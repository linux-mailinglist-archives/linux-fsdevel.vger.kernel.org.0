Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8260577448
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Jul 2022 06:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiGQEgS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Jul 2022 00:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGQEgR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Jul 2022 00:36:17 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D854E20F57
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Jul 2022 21:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1658032576; x=1689568576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=64I0h5SoR9M9pZ2dpqmM782CcnZdypZufhDR1of5wnA=;
  b=hWJdxSuAw+tnIl4eD3xPZEOy6l2d6ttN9KFQp5og51mSd1IN175XZUTz
   Tjvlq53l3UzVMsMIrGeypCJtiuT5tY3S786IcFAS3jm5IWXBkxJJfAgp1
   U1iMsG1xH3PhwFHFJPpqetX5f7xr23L/oAdPf4zW0AiRXYwZbXrviDVK7
   Q=;
X-IronPort-AV: E=Sophos;i="5.92,278,1650931200"; 
   d="scan'208";a="1034913791"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-c275e159.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 17 Jul 2022 04:36:01 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-c275e159.us-west-2.amazon.com (Postfix) with ESMTPS id 970D69A239;
        Sun, 17 Jul 2022 04:36:01 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Sun, 17 Jul 2022 04:36:00 +0000
Received: from 88665a182662.ant.amazon.com (10.43.162.124) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.9;
 Sun, 17 Jul 2022 04:35:58 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
CC:     Kuniyuki Iwashima <kuniyu@amazon.com>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v3 1/2] fs/lock: Don't allocate file_lock in flock_make_lock().
Date:   Sat, 16 Jul 2022 21:35:31 -0700
Message-ID: <20220717043532.35821-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220717043532.35821-1-kuniyu@amazon.com>
References: <20220717043532.35821-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.162.124]
X-ClientProxiedBy: EX13d09UWC001.ant.amazon.com (10.43.162.60) To
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
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/locks.c | 46 +++++++++++++++-------------------------------
 1 file changed, 15 insertions(+), 31 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index ca28e0e50e56..b134eaefd7d6 100644
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
@@ -2097,10 +2083,9 @@ EXPORT_SYMBOL(locks_lock_inode_wait);
  */
 SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 {
+	int can_sleep, error, unlock, type;
 	struct fd f = fdget(fd);
-	struct file_lock *lock;
-	int can_sleep, unlock;
-	int error;
+	struct file_lock fl;
 
 	error = -EBADF;
 	if (!f.file)
@@ -2127,28 +2112,27 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 		goto out_putf;
 	}
 
-	lock = flock_make_lock(f.file, cmd, NULL);
-	if (IS_ERR(lock)) {
-		error = PTR_ERR(lock);
+	type = flock_translate_cmd(cmd);
+	if (type < 0) {
+		error = type;
 		goto out_putf;
 	}
 
+	flock_make_lock(f.file, &fl, type);
+
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
 					  (can_sleep) ? F_SETLKW : F_SETLK,
-					  lock);
+					    &fl);
 	else
-		error = locks_lock_file_wait(f.file, lock);
-
- out_free:
-	locks_free_lock(lock);
+		error = locks_lock_file_wait(f.file, &fl);
 
  out_putf:
 	fdput(f);
@@ -2614,7 +2598,7 @@ locks_remove_flock(struct file *filp, struct file_lock_context *flctx)
 	if (list_empty(&flctx->flc_flock))
 		return;
 
-	flock_make_lock(filp, LOCK_UN, &fl);
+	flock_make_lock(filp, &fl, F_UNLCK);
 	fl.fl_flags |= FL_CLOSE;
 
 	if (filp->f_op->flock)
-- 
2.30.2

