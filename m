Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99E92EB3D8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 21:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbhAEUAr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 15:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbhAEUAq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 15:00:46 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77422C061574;
        Tue,  5 Jan 2021 12:00:06 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwsUT-0079eH-KD; Tue, 05 Jan 2021 19:59:37 +0000
Date:   Tue, 5 Jan 2021 19:59:37 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: Re: [PATCH v4] proc: Allow pid_revalidate() during LOOKUP_RCU
Message-ID: <20210105195937.GX3579531@ZenIV.linux.org.uk>
References: <20210104232123.31378-1-stephen.s.brennan@oracle.com>
 <20210105055935.GT3579531@ZenIV.linux.org.uk>
 <20210105165005.GV3579531@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105165005.GV3579531@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 05, 2021 at 04:50:05PM +0000, Al Viro wrote:

> LSM_AUDIT_DATA_DENTRY is easy to handle - wrap
>                 audit_log_untrustedstring(ab, a->u.dentry->d_name.name);
> into grabbing/dropping a->u.dentry->d_lock and we are done.

Incidentally, LSM_AUDIT_DATA_DENTRY in mainline is *not* safe wrt
rename() - for long-named dentries it is possible to get preempted
in the middle of
                audit_log_untrustedstring(ab, a->u.dentry->d_name.name);
and have the bugger renamed, with old name ending up freed.  The
same goes for LSM_AUDIT_DATA_INODE...

Folks, ->d_name.name is not automatically stable and the memory it
points to is not always guaranteed to last as long as dentry itself does.
In something like ->rename(), ->mkdir(), etc. - sure, we have the parent
->i_rwsem held exclusive and nothing's going to rename dentry under us.
But there's a reason why e.g. d_path() has to be careful.  And there
are selinux and smack hooks using LSM_AUDIT_DATA_DENTRY in locking
environment that does not exclude renames.

AFAICS, that race goes back to 2004: 605303cc340d ("[PATCH] selinux: Add dname
to audit output when a path cannot be generated.") in historical tree is where
its first ancestor appears...

The minimal fix is to grab ->d_lock around these audit_log_untrustedstring()
calls, and IMO that's -stable fodder.  It is a slow path (we are spewing an
audit record, not to mention anything else), so I don't believe it's worth
trying to do anything fancier than that.

How about the following?  If nobody objects, I'll drop it into #fixes and
send a pull request in a few days...

dump_common_audit_data(): fix racy accesses to ->d_name
    
We are not guaranteed the locking environment that would prevent
dentry getting renamed right under us.  And it's possible for
old long name to be freed after rename, leading to UAF here.

Cc: stable@kernel.org # v2.6.2+
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 7d8026f3f377..a0cd28cd31a8 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -275,7 +275,9 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		struct inode *inode;
 
 		audit_log_format(ab, " name=");
+		spin_lock(&a->u.dentry->d_lock);
 		audit_log_untrustedstring(ab, a->u.dentry->d_name.name);
+		spin_unlock(&a->u.dentry->d_lock);
 
 		inode = d_backing_inode(a->u.dentry);
 		if (inode) {
@@ -293,8 +295,9 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		dentry = d_find_alias(inode);
 		if (dentry) {
 			audit_log_format(ab, " name=");
-			audit_log_untrustedstring(ab,
-					 dentry->d_name.name);
+			spin_lock(&dentry->d_lock);
+			audit_log_untrustedstring(ab, dentry->d_name.name);
+			spin_unlock(&dentry->d_lock);
 			dput(dentry);
 		}
 		audit_log_format(ab, " dev=");
