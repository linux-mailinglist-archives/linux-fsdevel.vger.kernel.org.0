Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60109388409
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 02:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhESAwb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 20:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352872AbhESAu6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 20:50:58 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78EBC06175F;
        Tue, 18 May 2021 17:49:39 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljAOT-00G4Fc-R9; Wed, 19 May 2021 00:49:01 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jia He <justin.he@arm.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 05/14] getcwd(2): saner logics around prepend_path() call
Date:   Wed, 19 May 2021 00:48:52 +0000
Message-Id: <20210519004901.3829541-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The only negative value that might get returned by prepend_path() is
-ENAMETOOLONG, and that happens only on overflow.  The same goes for
prepend_unreachable().  Overflow is detectable by observing negative
buflen, so we can simplify the control flow around the prepend_path()
call.  Expand prepend_unreachable(), while we are at it - that's the
only caller.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/d_path.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index 7f3fac544bbb..311d43287572 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -211,11 +211,6 @@ char *d_absolute_path(const struct path *path,
 	return res;
 }
 
-static int prepend_unreachable(char **buffer, int *buflen)
-{
-	return prepend(buffer, buflen, "(unreachable)", 13);
-}
-
 static void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
 {
 	unsigned seq;
@@ -414,17 +409,13 @@ SYSCALL_DEFINE2(getcwd, char __user *, buf, unsigned long, size)
 		int buflen = PATH_MAX;
 
 		prepend(&cwd, &buflen, "", 1);
-		error = prepend_path(&pwd, &root, &cwd, &buflen);
+		if (prepend_path(&pwd, &root, &cwd, &buflen) > 0)
+			prepend(&cwd, &buflen, "(unreachable)", 13);
 		rcu_read_unlock();
 
-		if (error < 0)
+		if (buflen < 0) {
+			error = -ENAMETOOLONG;
 			goto out;
-
-		/* Unreachable from current root */
-		if (error > 0) {
-			error = prepend_unreachable(&cwd, &buflen);
-			if (error)
-				goto out;
 		}
 
 		error = -ERANGE;
-- 
2.11.0

