Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6EA388402
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 02:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352897AbhESAw3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 20:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352873AbhESAu6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 20:50:58 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89EAC061760;
        Tue, 18 May 2021 17:49:39 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljAOU-00G4GG-Mm; Wed, 19 May 2021 00:49:02 +0000
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
Subject: [PATCH 14/14] getcwd(2): clean up error handling
Date:   Wed, 19 May 2021 00:49:01 +0000
Message-Id: <20210519004901.3829541-14-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/d_path.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index 8a9cd44f6689..23a53f7b5c71 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -390,9 +390,11 @@ SYSCALL_DEFINE2(getcwd, char __user *, buf, unsigned long, size)
 	rcu_read_lock();
 	get_fs_root_and_pwd_rcu(current->fs, &root, &pwd);
 
-	error = -ENOENT;
-	if (!d_unlinked(pwd.dentry)) {
-		unsigned long len;
+	if (unlikely(d_unlinked(pwd.dentry))) {
+		rcu_read_unlock();
+		error = -ENOENT;
+	} else {
+		unsigned len;
 		DECLARE_BUFFER(b, page, PATH_MAX);
 
 		prepend(&b, "", 1);
@@ -400,23 +402,16 @@ SYSCALL_DEFINE2(getcwd, char __user *, buf, unsigned long, size)
 			prepend(&b, "(unreachable)", 13);
 		rcu_read_unlock();
 
-		if (b.len < 0) {
-			error = -ENAMETOOLONG;
-			goto out;
-		}
-
-		error = -ERANGE;
 		len = PATH_MAX - b.len;
-		if (len <= size) {
+		if (unlikely(len > PATH_MAX))
+			error = -ENAMETOOLONG;
+		else if (unlikely(len > size))
+			error = -ERANGE;
+		else if (copy_to_user(buf, b.buf, len))
+			error = -EFAULT;
+		else
 			error = len;
-			if (copy_to_user(buf, b.buf, len))
-				error = -EFAULT;
-		}
-	} else {
-		rcu_read_unlock();
 	}
-
-out:
 	__putname(page);
 	return error;
 }
-- 
2.11.0

