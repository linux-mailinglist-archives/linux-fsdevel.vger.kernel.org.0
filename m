Return-Path: <linux-fsdevel+bounces-17484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9EA8AE109
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 11:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB3B1C21ACB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 09:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1449B58ADD;
	Tue, 23 Apr 2024 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEouxlI3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E368351016;
	Tue, 23 Apr 2024 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864703; cv=none; b=tqgFg6IOpIuoMz9Hiu52UhKYJO+SUytx9evuwX4ijEFijS8II7wCfDsGnJTwLTCmEu7vK+KB4G7tLwXuR/8mAxplmQ9yKKrQ52mziDncakmfMgj3Asvcz8Zcuy7tZs7BrolPNCBT4YN8mj5Q2bk+bmuWAgRxPQNOBdnhhojEFOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864703; c=relaxed/simple;
	bh=b3TWFQWb0tix0MkMtNzrHwbXq4CRG4GXigE0Dw28aBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sNCEEZYLjsIvcDZ7qZskXOxXhT5s53t3ai1mx+Kpsj6En5NOW808Z8H8wWkDYGQNUDARC7uF53KYoEneRlXEwCjKC/t8htJzox8Raq2aICPiPnONdauykyg5o1DY/zueY/6X1zHJ3zDD0nVOSOqs+l2e/2MK7EAbaGAC6bsKwAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEouxlI3; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ab88634cfaso4282334a91.0;
        Tue, 23 Apr 2024 02:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713864701; x=1714469501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFzo7Qok9UOM9YVV5ek8GZqoP/DoFpgiYqJRlA4fUxQ=;
        b=FEouxlI34kawlB6MYpBx0sAScB5cNgG2DaAhEy0V0SnfNyGU3YP0FVXMWn5nII9rbC
         GV3At833xYYe6NMLCSc2iWPGQHWMmJHkoZGToYRymRyPK4jogIXFfvUXmtrHDTRDAejO
         S58cClrakn5kPpxmqe4dqptZO5jWpZ6btC5Q8Sa2R09f1qmVILx97sQOX8MLjQ72KWLR
         Nrwbs56UcMb4oLTDOcT7Qx5u2tlaRjR0g3LloLbI9CTWI1SZ8/uUZ3rmVZK+KBP8q9Sf
         3L/BlkpRSgxoV5CxsQB97MhIHKt4yMJJ6wWoHD2EnF89p0nxZr8brG90TcAUp4NZGqQh
         M4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713864701; x=1714469501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFzo7Qok9UOM9YVV5ek8GZqoP/DoFpgiYqJRlA4fUxQ=;
        b=TOdZNUQKUx9NPQI+xVMEnMGjtJNG/gUU/UkWyu8JAcxmYwg74ASZLqIM9lANjUHhKy
         IMmLhRYKes6sYBwV92Z/EyKLSqSY5Js+yjXKaTqXK4/YUksoFwGMZ59rVQz0hBUmJBf0
         Bp7JyjVi3iVJnBDJmforEk+l7NNWBQYug45O4YYgXStO0BQyVrpPyMzuWu45ZnLnoyA3
         2CkPDkpvHjkUEnXRdFOiWt8SwQxY6egBBXEYbHm6dT4atHkG7On7j4/yniU4LuoCb5Kh
         Gix5puPLgZoeJuP+YSEM3SjgEygeevNPaJEwK9G6Gh5V3F/zIoaqk0j4TDyy5VOyIuUI
         JsTw==
X-Forwarded-Encrypted: i=1; AJvYcCXwLiAhtn04YcGtFRaKbOlxMZXKOO2b6zR3R8QdJ51RVMLBJxg3VJ3RPmVqz+YXg0VKcbQ54vFHRFwt4i+Y+tNYOqZuItM/MVuBrnLkR+iDU7bPRHQNO2IvB90forrkU3bR35Bit9YaVSMUgg==
X-Gm-Message-State: AOJu0Yx1y+0MMJRZ0woZw98uNob5nZMfrYAhkZ5HHpXLCF5AVkA/QZ1O
	Pd2XBpGr0Hcbmd1hM4DC/9vqF0aGcAlccCBU6LzcG5rqrNlSDULW
X-Google-Smtp-Source: AGHT+IGPqnDbQJ4SDSWuDvIY7j4QSuZ2aMzG/rVkl/tk1flkyFfSJ14gXOz//hUe/um9aIfLeiCHdg==
X-Received: by 2002:a17:90a:43e3:b0:2a2:bc8c:d677 with SMTP id r90-20020a17090a43e300b002a2bc8cd677mr12153342pjg.26.1713864700976;
        Tue, 23 Apr 2024 02:31:40 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090a430600b002a2fe0998f0sm10745283pjg.19.2024.04.23.02.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 02:31:40 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+2a62f58f1a4951a549bb@syzkaller.appspotmail.com
Cc: jlayton@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH fs/hfs] hfs: fix deadlock in hfs_extend_file()
Date: Tue, 23 Apr 2024 18:31:32 +0900
Message-Id: <20240423093132.55504-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000f07c2606165ff63a@google.com>
References: <000000000000f07c2606165ff63a@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc4-syzkaller-00274-g3b68086599f8 #0 Not tainted
------------------------------------------------------
kworker/u8:6/1059 is trying to acquire lock:
ffff88805bd4a7f8 (&HFS_I(tree->inode)->extents_lock){+.+.}-{3:3}, at: hfs_extend_file+0xff/0x1450 fs/hfs/extent.c:397

but task is already holding lock:
ffff88806a48c0b0 (&tree->tree_lock#2/1){+.+.}-{3:3}, at: hfs_find_init+0x16e/0x1f0

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&tree->tree_lock#2/1){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       hfs_find_init+0x16e/0x1f0
       hfs_ext_read_extent fs/hfs/extent.c:200 [inline]
       hfs_extend_file+0x31b/0x1450 fs/hfs/extent.c:401
       hfs_bmap_reserve+0xd9/0x400 fs/hfs/btree.c:234
       hfs_cat_create+0x1e0/0x970 fs/hfs/catalog.c:104
       hfs_create+0x66/0xe0 fs/hfs/dir.c:202
       lookup_open fs/namei.c:3497 [inline]
       open_last_lookups fs/namei.c:3566 [inline]
       path_openat+0x1425/0x3240 fs/namei.c:3796
       do_filp_open+0x235/0x490 fs/namei.c:3826
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
       do_sys_open fs/open.c:1421 [inline]
       __do_sys_openat fs/open.c:1437 [inline]
       __se_sys_openat fs/open.c:1432 [inline]
       __x64_sys_openat+0x247/0x2a0 fs/open.c:1432
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&HFS_I(tree->inode)->extents_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       hfs_extend_file+0xff/0x1450 fs/hfs/extent.c:397
       hfs_bmap_reserve+0xd9/0x400 fs/hfs/btree.c:234
       __hfs_ext_write_extent+0x22e/0x4f0 fs/hfs/extent.c:121
       hfs_ext_write_extent+0x154/0x1d0 fs/hfs/extent.c:144
       hfs_write_inode+0xbc/0xec0 fs/hfs/inode.c:427
       write_inode fs/fs-writeback.c:1498 [inline]
       __writeback_single_inode+0x6b9/0x10b0 fs/fs-writeback.c:1715
       writeback_sb_inodes+0x905/0x1260 fs/fs-writeback.c:1941
       wb_writeback+0x457/0xce0 fs/fs-writeback.c:2117
       wb_do_writeback fs/fs-writeback.c:2264 [inline]
       wb_workfn+0x410/0x1090 fs/fs-writeback.c:2304
       process_one_work kernel/workqueue.c:3254 [inline]
       process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
       worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
       kthread+0x2f0/0x390 kernel/kthread.c:388
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&tree->tree_lock#2/1);
                               lock(&HFS_I(tree->inode)->extents_lock);
                               lock(&tree->tree_lock#2/1);
  lock(&HFS_I(tree->inode)->extents_lock);

 *** DEADLOCK ***

3 locks held by kworker/u8:6/1059:
 #0: ffff88801be87148 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff88801be87148 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x17c0 kernel/workqueue.c:3335
 #1: ffffc90004197d00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc90004197d00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x17c0 kernel/workqueue.c:3335
 #2: ffff88806a48c0b0 (&tree->tree_lock#2/1){+.+.}-{3:3}, at: hfs_find_init+0x16e/0x1f0

======================================================

When a file expansion operation occurs in the hfs file system, 
unnecessary locking occurs due to recursion. This situation does 
not appear to be easy to reproduce, but it is very strange logic 
and must be fixed.

Whether this recursion is intended behavior or not, I think it is a 
good idea to prevent deadlock by placing mutex_lock() in a higher 
function than hfs_extend_file().

Reported-by: syzbot+2a62f58f1a4951a549bb@syzkaller.appspotmail.com
Fixes: 39f8d472f280 ("hfs: convert extents_lock in a mutex")
Fixes: 1267a07be5eb ("hfs: fix return value of hfs_get_block()")
Fixes: 54640c7502e5 ("hfs: prevent btree data loss on ENOSPC")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 fs/hfs/catalog.c |  4 ++++
 fs/hfs/extent.c  | 26 +++++++++++++++-----------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
index d63880e7d9d6..cece4333f7a7 100644
--- a/fs/hfs/catalog.c
+++ b/fs/hfs/catalog.c
@@ -101,7 +101,9 @@ int hfs_cat_create(u32 cnid, struct inode *dir, const struct qstr *str, struct i
 	 * Fail early and avoid ENOSPC during the btree operations. We may
 	 * have to split the root node at most once.
 	 */
+	mutex_lock(&HFS_I(fd.tree->inode)->extents_lock);
 	err = hfs_bmap_reserve(fd.tree, 2 * fd.tree->depth);
+	mutex_unlock(&HFS_I(fd.tree->inode)->extents_lock);
 	if (err)
 		goto err2;
 
@@ -307,7 +309,9 @@ int hfs_cat_move(u32 cnid, struct inode *src_dir, const struct qstr *src_name,
 	 * Fail early and avoid ENOSPC during the btree operations. We may
 	 * have to split the root node at most once.
 	 */
+	mutex_lock(&HFS_I(src_fd.tree->inode)->extents_lock);
 	err = hfs_bmap_reserve(src_fd.tree, 2 * src_fd.tree->depth);
+	mutex_unlock(&HFS_I(src_fd.tree->inode)->extents_lock);
 	if (err)
 		goto out;
 
diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index 6d1878b99b30..25de1d48b667 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -338,38 +338,41 @@ int hfs_get_block(struct inode *inode, sector_t block,
 {
 	struct super_block *sb;
 	u16 dblock, ablock;
-	int res;
+	int res = 0;
 
 	sb = inode->i_sb;
 	/* Convert inode block to disk allocation block */
 	ablock = (u32)block / HFS_SB(sb)->fs_div;
 
+	mutex_lock(&HFS_I(inode)->extents_lock);
 	if (block >= HFS_I(inode)->fs_blocks) {
 		if (!create)
-			return 0;
-		if (block > HFS_I(inode)->fs_blocks)
-			return -EIO;
+			goto out;
+		if (block > HFS_I(inode)->fs_blocks){
+			res = -EIO;
+			goto out;
+		}
 		if (ablock >= HFS_I(inode)->alloc_blocks) {
 			res = hfs_extend_file(inode);
 			if (res)
-				return res;
+				goto out;
 		}
 	} else
 		create = 0;
 
 	if (ablock < HFS_I(inode)->first_blocks) {
 		dblock = hfs_ext_find_block(HFS_I(inode)->first_extents, ablock);
+		mutex_unlock(&HFS_I(inode)->extents_lock);
 		goto done;
 	}
 
-	mutex_lock(&HFS_I(inode)->extents_lock);
 	res = hfs_ext_read_extent(inode, ablock);
 	if (!res)
 		dblock = hfs_ext_find_block(HFS_I(inode)->cached_extents,
 					    ablock - HFS_I(inode)->cached_start);
 	else {
-		mutex_unlock(&HFS_I(inode)->extents_lock);
-		return -EIO;
+		res = -EIO;
+		goto out;
 	}
 	mutex_unlock(&HFS_I(inode)->extents_lock);
 
@@ -385,7 +388,10 @@ int hfs_get_block(struct inode *inode, sector_t block,
 		inode_add_bytes(inode, sb->s_blocksize);
 		mark_inode_dirty(inode);
 	}
-	return 0;
+	return res;
+out:
+	mutex_unlock(&HFS_I(inode)->extents_lock);
+	return res;
 }
 
 int hfs_extend_file(struct inode *inode)
@@ -394,7 +400,6 @@ int hfs_extend_file(struct inode *inode)
 	u32 start, len, goal;
 	int res;
 
-	mutex_lock(&HFS_I(inode)->extents_lock);
 	if (HFS_I(inode)->alloc_blocks == HFS_I(inode)->first_blocks)
 		goal = hfs_ext_lastblock(HFS_I(inode)->first_extents);
 	else {
@@ -444,7 +449,6 @@ int hfs_extend_file(struct inode *inode)
 			goto insert_extent;
 	}
 out:
-	mutex_unlock(&HFS_I(inode)->extents_lock);
 	if (!res) {
 		HFS_I(inode)->alloc_blocks += len;
 		mark_inode_dirty(inode);
-- 
2.34.1

