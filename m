Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16453775EF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2019 04:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfG0CXu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 22:23:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50082 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbfG0CXt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 22:23:49 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hrCN7-0003zA-HP; Sat, 27 Jul 2019 02:23:45 +0000
Date:   Sat, 27 Jul 2019 03:23:45 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: Regression in 5.3 for some FS_USERNS_MOUNT (aka
 user-namespace-mountable) filesystems
Message-ID: <20190727022345.GN1131@ZenIV.linux.org.uk>
References: <20190726115956.ifj5j4apn3tmwk64@brauner.io>
 <CAHk-=wgK254RkZg9oAv+Wt4V9zqYJMm3msTofvTUfA9dJw6piQ@mail.gmail.com>
 <20190726232220.GM1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726232220.GM1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 27, 2019 at 12:22:20AM +0100, Al Viro wrote:
> On Fri, Jul 26, 2019 at 03:47:02PM -0700, Linus Torvalds wrote:
> 
> > Of course, then later on, commit 20284ab7427f ("switch mount_capable()
> > to fs_context") drops that argument entirely, and hardcodes the
> > decision to look at fc->global.
> > 
> > But that fc->global decision wasn't there originally, and is incorrect
> > since it breaks existing users.
> > 
> > What gets much more confusing about this is that the two different
> > users then moved around. The sget_userns() case got moved to
> > legacy_get_tree(), and then joined together in vfs_get_tree(), and
> > then split and moved out to do_new_mount() and vfs_fsconfig_locked().
> > 
> > And that "joined together into vfs_get_tree()" must be wrong, because
> > the two cases used two different namespace rules. The sget_userns()
> > case *did* have that "global" flag check, while the sget_fc() did not.
> > 
> > Messy. Al?
> 
> Digging through that mess...  It's my fuckup, and we obviously need to
> restore the old behaviour, but I really hope to manage that with
> checks _not_ in superblock allocator ;-/

It shouldn't have looked at fc->global for those checks.  In any cases.
sget_fc() should indeed have been passing fc->user_ns, not userns.
And as for sget_userns(), by the time of 20284ab7427f
its checks had been moved to legacy_get_tree().  In form of
	if (!mount_capable(fc->fs_type, fc->user_ns))
as it bloody well ought to.

So the first mistake (wrong argument passed to mount_capable() by sget_fc()
in 0ce0cf12fc4c) has been completed by 20284ab7427f - that conversion was,
actually, an equivalent transformation (callers of legacy_get_tree() never
have fc->global set, so it's all the same).  However, the bug introduced in
the earlier commit was now spelled out in mount_capable() itself.

IOW, the minimal fix should be as below.  In principle, I'm not against
Eric's "add a method instead of setting FS_USERNS_MOUNT", but note that
in *all* cases the instances of his method end up being equivalent to
	return ns_capable(fc->user_ns, CAP_SYS_ADMIN) ? 0 : -EPERM;

Anyway, AFAICS the regression fix should be simply this:

Unbreak mount_capable()

In "consolidate the capability checks in sget_{fc,userns}())" the
wrong argument had been passed to mount_capable() by sget_fc().
That mistake had been further obscured later, when switching
mount_capable() to fs_context has moved the calculation of
bogus argument from sget_fc() to mount_capable() itself.  It
should've been fc->user_ns all along.

Screwed-up-by: Al Viro <viro@zeniv.linux.org.uk>
Reported-by: Christian Brauner <christian@brauner.io>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/super.c b/fs/super.c
index 113c58f19425..5960578a4076 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -478,13 +478,10 @@ EXPORT_SYMBOL(generic_shutdown_super);
 
 bool mount_capable(struct fs_context *fc)
 {
-	struct user_namespace *user_ns = fc->global ? &init_user_ns
-						    : fc->user_ns;
-
 	if (!(fc->fs_type->fs_flags & FS_USERNS_MOUNT))
 		return capable(CAP_SYS_ADMIN);
 	else
-		return ns_capable(user_ns, CAP_SYS_ADMIN);
+		return ns_capable(fc->user_ns, CAP_SYS_ADMIN);
 }
 
 /**

