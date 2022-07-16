Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A99576B32
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Jul 2022 03:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiGPBcM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jul 2022 21:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiGPBcL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jul 2022 21:32:11 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0BA43E7A
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jul 2022 18:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1657935127; x=1689471127;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=42pGIUa9Q6IV6yCVU6D7hjavW4N5MHMYFeIuv3o8epI=;
  b=lOYqhG+ed1UNeV3wrvwu2rxwwbcGuGXQgwTd3lhwEh6gbrzECreH1h0r
   jPAmZuSx8Fpu07O4ACSzf+vqvrkozpZM/yl24xGhR23YEfcksfKw/GVem
   5rBpZ6D5UHjKlr5oMGF0/sYfOo6VkgUHQwfQGdZ4zfyAKnOOb2TR24I38
   g=;
X-IronPort-AV: E=Sophos;i="5.92,275,1650931200"; 
   d="scan'208";a="222364099"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-9a235a16.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 16 Jul 2022 01:31:54 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-9a235a16.us-east-1.amazon.com (Postfix) with ESMTPS id 57344800CE;
        Sat, 16 Jul 2022 01:31:53 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Sat, 16 Jul 2022 01:31:52 +0000
Received: from 88665a182662.ant.amazon.com (10.43.161.172) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.9;
 Sat, 16 Jul 2022 01:31:50 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
CC:     Kuniyuki Iwashima <kuniyu@amazon.com>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] fs/lock: Don't allocate file_lock in flock_make_lock().
Date:   Fri, 15 Jul 2022 18:31:40 -0700
Message-ID: <20220716013140.61445-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.161.172]
X-ClientProxiedBy: EX13D40UWA003.ant.amazon.com (10.43.160.29) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Two functions, flock syscall and locks_remove_flock(), call
flock_make_lock().  It allocates struct file_lock from slab
cache if its argument fl is NULL.

When we call flock syscall, we pass NULL to allocate memory
for struct file_lock.  However, we always free it at the end
by locks_free_lock().  We need not allocate it and instead
should use a local variable as locks_remove_flock() does.

Also, the validation for flock_translate_cmd() is not necessary
for locks_remove_flock().  So we move the part to flock syscall
and make flock_make_lock() return nothing.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 fs/locks.c | 57 +++++++++++++++++++-----------------------------------
 1 file changed, 20 insertions(+), 37 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index ca28e0e50e56..db75f4537abc 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -425,21 +425,9 @@ static inline int flock_translate_cmd(int cmd) {
 }
 
 /* Fill in a file_lock structure with an appropriate FLOCK lock. */
-static struct file_lock *
-flock_make_lock(struct file *filp, unsigned int cmd, struct file_lock *fl)
+static void flock_make_lock(struct file *filp, struct file_lock *fl, int type)
 {
-	int type = flock_translate_cmd(cmd);
-
-	if (type < 0)
-		return ERR_PTR(type);
-
-	if (fl == NULL) {
-		fl = locks_alloc_lock();
-		if (fl == NULL)
-			return ERR_PTR(-ENOMEM);
-	} else {
-		locks_init_lock(fl);
-	}
+	locks_init_lock(fl);
 
 	fl->fl_file = filp;
 	fl->fl_owner = filp;
@@ -447,8 +435,6 @@ flock_make_lock(struct file *filp, unsigned int cmd, struct file_lock *fl)
 	fl->fl_flags = FL_FLOCK;
 	fl->fl_type = type;
 	fl->fl_end = OFFSET_MAX;
-
-	return fl;
 }
 
 static int assign_type(struct file_lock *fl, long type)
@@ -2097,14 +2083,18 @@ EXPORT_SYMBOL(locks_lock_inode_wait);
  */
 SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 {
-	struct fd f = fdget(fd);
-	struct file_lock *lock;
-	int can_sleep, unlock;
+	int can_sleep, unlock, type;
+	struct file_lock fl;
+	struct fd f;
 	int error;
 
-	error = -EBADF;
+	type = flock_translate_cmd(cmd);
+	if (type < 0)
+		return type;
+
+	f = fdget(fd);
 	if (!f.file)
-		goto out;
+		return -EBADF;
 
 	can_sleep = !(cmd & LOCK_NB);
 	cmd &= ~LOCK_NB;
@@ -2127,32 +2117,25 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 		goto out_putf;
 	}
 
-	lock = flock_make_lock(f.file, cmd, NULL);
-	if (IS_ERR(lock)) {
-		error = PTR_ERR(lock);
-		goto out_putf;
-	}
+	flock_make_lock(f.file, &fl, type);
 
 	if (can_sleep)
-		lock->fl_flags |= FL_SLEEP;
+		fl.fl_flags |= FL_SLEEP;
 
-	error = security_file_lock(f.file, lock->fl_type);
+	error = security_file_lock(f.file, fl.fl_type);
 	if (error)
-		goto out_free;
+		goto out_putf;
 
 	if (f.file->f_op->flock)
 		error = f.file->f_op->flock(f.file,
-					  (can_sleep) ? F_SETLKW : F_SETLK,
-					  lock);
+					    can_sleep ? F_SETLKW : F_SETLK,
+					    &fl);
 	else
-		error = locks_lock_file_wait(f.file, lock);
-
- out_free:
-	locks_free_lock(lock);
+		error = locks_lock_file_wait(f.file, &fl);
 
  out_putf:
 	fdput(f);
- out:
+
 	return error;
 }
 
@@ -2614,7 +2597,7 @@ locks_remove_flock(struct file *filp, struct file_lock_context *flctx)
 	if (list_empty(&flctx->flc_flock))
 		return;
 
-	flock_make_lock(filp, LOCK_UN, &fl);
+	flock_make_lock(filp, &fl, flock_translate_cmd(LOCK_UN));
 	fl.fl_flags |= FL_CLOSE;
 
 	if (filp->f_op->flock)
-- 
2.30.2

