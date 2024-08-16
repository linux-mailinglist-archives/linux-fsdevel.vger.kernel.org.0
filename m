Return-Path: <linux-fsdevel+bounces-26128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 256E4954C6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 16:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37561F22E4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 14:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA531BD02F;
	Fri, 16 Aug 2024 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCLICXGy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8751BD016
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723818990; cv=none; b=tK59r7zSt4aSUcabAHlTi6DBpY4lW5p0unrpg3sQTaQLviPAHNWN0GUtojSmvTb2twCy5ikMO6nUWzzYoRrj8nFdb5FBVaL4KA2w3ZJWj2MevvJ6pbK+a6V57Hofj+CUQx17Ed0rvBWGWOretoTpN+c01iKyAYPaL/N4CAhofNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723818990; c=relaxed/simple;
	bh=PFh/MC7hnmiY49gEzApxdD/Zitn/cn/+dP783jvd8YA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o4Ztve90f/xCuQ9+D+fY0tLOCeMKMYDvdsiDbOV7G6MEHDLubdoAPhQu5Nf8Dvhg6JqnQmjpP8tRi2BHW6yXfmufBGJrfXpQoYfYzWK6fVriTAfjfA5bw3LmRJlqeyJFmQj9+p1vefPPxsgRrzFPnbMTq6dXr/2wotqUP7emK78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCLICXGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F240C4AF13;
	Fri, 16 Aug 2024 14:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723818990;
	bh=PFh/MC7hnmiY49gEzApxdD/Zitn/cn/+dP783jvd8YA=;
	h=From:Date:Subject:To:Cc:From;
	b=GCLICXGydPQTOKxQP0Ib+vHodmTjxe9QaFgKx0nhSNnggRr6YiI0QaVakdmqu4xkV
	 zeahZ1/0FM1PaL4vVOpSh+/TUcuTypRCl/JiXxoWOlMBKSErqBKjDNz/5M3adqD5sl
	 1BOqMjFlU7IYe7niKmekpqwNg5mOAT0l0IVsUzq59QR0kRxkp47Dw4H6i2PoZb557t
	 2vOWTAQyYBBaekDdTUl7/meLN3n4T6arywmCRi2oc0l1yxyJCNDde4BIKtjdEtRhdE
	 M3BOL3bPUKCvw/AaTgA8I48tP5LMdOj49CaMkfMF8ZCb9THlyS6GQ89q3jRWY3S8dM
	 avG+vHMAIChsA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 16 Aug 2024 16:35:52 +0200
Subject: [PATCH] inode: remove __I_DIO_WAKEUP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-vfs-misc-dio-v1-1-80fe21a2c710@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMdjv2YC/x3MwQqDMAyA4VeRnJfRinWyVxk7pDVqDtbRgAjFd
 1/0+B++v4JyEVZ4NxUK76KyZQv/aCAtlGdGGa2hdW3nBt/jPimuoglH2TCk6F5MxD4EMPIrPMl
 x7z5f60jKGAvltFwTs8/Lwnn+AYvW1uh5AAAA
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>, 
 Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=4678; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PFh/MC7hnmiY49gEzApxdD/Zitn/cn/+dP783jvd8YA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTtT34TFyl/1M1hQV7/c7n7+6tehrlm3mpX0zW8tv7J4
 q4n/n8SO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCc47hr2ySiH377LaDnufu
 zXAtjlshFbLw56X6zz9cSx8p7Fz1z4vhv//Ny5LPqo1PxtUm39x8qd7o84w4/fklfr9PSzA3/ve
 oYgQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Afaict, we can just rely on inode->i_dio_count for waiting instead of
this awkward indirection through __I_DIO_WAKEUP. This survives LTP dio
and xfstests dio tests.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
---
 fs/inode.c         | 23 +++++++++++------------
 fs/netfs/locking.c | 18 +++---------------
 include/linux/fs.h |  9 ++++-----
 3 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 7a4e27606fca..46bf05d826db 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2465,18 +2465,12 @@ EXPORT_SYMBOL(inode_owner_or_capable);
 /*
  * Direct i/o helper functions
  */
-static void __inode_dio_wait(struct inode *inode)
+bool inode_dio_finished(const struct inode *inode)
 {
-	wait_queue_head_t *wq = bit_waitqueue(&inode->i_state, __I_DIO_WAKEUP);
-	DEFINE_WAIT_BIT(q, &inode->i_state, __I_DIO_WAKEUP);
-
-	do {
-		prepare_to_wait(wq, &q.wq_entry, TASK_UNINTERRUPTIBLE);
-		if (atomic_read(&inode->i_dio_count))
-			schedule();
-	} while (atomic_read(&inode->i_dio_count));
-	finish_wait(wq, &q.wq_entry);
+	smp_mb__before_atomic();
+	return atomic_read(&inode->i_dio_count) == 0;
 }
+EXPORT_SYMBOL(inode_dio_finished);
 
 /**
  * inode_dio_wait - wait for outstanding DIO requests to finish
@@ -2490,11 +2484,16 @@ static void __inode_dio_wait(struct inode *inode)
  */
 void inode_dio_wait(struct inode *inode)
 {
-	if (atomic_read(&inode->i_dio_count))
-		__inode_dio_wait(inode);
+	wait_var_event(&inode->i_dio_count, inode_dio_finished);
 }
 EXPORT_SYMBOL(inode_dio_wait);
 
+void inode_dio_wait_interruptible(struct inode *inode)
+{
+	wait_var_event_interruptible(&inode->i_dio_count, inode_dio_finished);
+}
+EXPORT_SYMBOL(inode_dio_wait_interruptible);
+
 /*
  * inode_set_flags - atomically set some inode flags
  *
diff --git a/fs/netfs/locking.c b/fs/netfs/locking.c
index 75dc52a49b3a..c2cfdda85230 100644
--- a/fs/netfs/locking.c
+++ b/fs/netfs/locking.c
@@ -21,23 +21,11 @@
  */
 static int inode_dio_wait_interruptible(struct inode *inode)
 {
-	if (!atomic_read(&inode->i_dio_count))
+	if (inode_dio_finished(inode))
 		return 0;
 
-	wait_queue_head_t *wq = bit_waitqueue(&inode->i_state, __I_DIO_WAKEUP);
-	DEFINE_WAIT_BIT(q, &inode->i_state, __I_DIO_WAKEUP);
-
-	for (;;) {
-		prepare_to_wait(wq, &q.wq_entry, TASK_INTERRUPTIBLE);
-		if (!atomic_read(&inode->i_dio_count))
-			break;
-		if (signal_pending(current))
-			break;
-		schedule();
-	}
-	finish_wait(wq, &q.wq_entry);
-
-	return atomic_read(&inode->i_dio_count) ? -ERESTARTSYS : 0;
+	inode_dio_wait_interruptible(inode);
+	return !inode_dio_finished(inode) ? -ERESTARTSYS : 0;
 }
 
 /* Call with exclusively locked inode->i_rwsem */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b6f2e2a1e513..f744cd918259 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2380,8 +2380,6 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
  *
  * I_REFERENCED		Marks the inode as recently references on the LRU list.
  *
- * I_DIO_WAKEUP		Never set.  Only used as a key for wait_on_bit().
- *
  * I_WB_SWITCH		Cgroup bdi_writeback switching in progress.  Used to
  *			synchronize competing switching instances and to tell
  *			wb stat updates to grab the i_pages lock.  See
@@ -2413,8 +2411,6 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 #define __I_SYNC		7
 #define I_SYNC			(1 << __I_SYNC)
 #define I_REFERENCED		(1 << 8)
-#define __I_DIO_WAKEUP		9
-#define I_DIO_WAKEUP		(1 << __I_DIO_WAKEUP)
 #define I_LINKABLE		(1 << 10)
 #define I_DIRTY_TIME		(1 << 11)
 #define I_WB_SWITCH		(1 << 13)
@@ -3230,6 +3226,7 @@ static inline ssize_t blockdev_direct_IO(struct kiocb *iocb,
 #endif
 
 void inode_dio_wait(struct inode *inode);
+void inode_dio_wait_interruptible(struct inode *inode);
 
 /**
  * inode_dio_begin - signal start of a direct I/O requests
@@ -3241,6 +3238,7 @@ void inode_dio_wait(struct inode *inode);
 static inline void inode_dio_begin(struct inode *inode)
 {
 	atomic_inc(&inode->i_dio_count);
+	smp_mb__after_atomic();
 }
 
 /**
@@ -3252,8 +3250,9 @@ static inline void inode_dio_begin(struct inode *inode)
  */
 static inline void inode_dio_end(struct inode *inode)
 {
+	smp_mb__before_atomic();
 	if (atomic_dec_and_test(&inode->i_dio_count))
-		wake_up_bit(&inode->i_state, __I_DIO_WAKEUP);
+		wake_up_var(&inode->i_dio_count);
 }
 
 extern void inode_set_flags(struct inode *inode, unsigned int flags,

---
base-commit: 5570f04d0bb1a34ebcb27caac76c797a7c9e36c9
change-id: 20240816-vfs-misc-dio-5cb07eaae155


