Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8912D2728B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 16:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgIUOop (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 10:44:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:56298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727131AbgIUOol (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:44:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4A3B3B040;
        Mon, 21 Sep 2020 14:45:15 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 12/15] btrfs: Remove dio_sem
Date:   Mon, 21 Sep 2020 09:43:50 -0500
Message-Id: <20200921144353.31319-13-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921144353.31319-1-rgoldwyn@suse.de>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

dio_sem can be eliminated because all DIO synchronization is performed
through inode->i_rwsem now.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/btrfs_inode.h | 10 ----------
 fs/btrfs/file.c        | 13 -------------
 fs/btrfs/inode.c       |  1 -
 3 files changed, 24 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 738009a22320..176abce59467 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -203,16 +203,6 @@ struct btrfs_inode {
 	/* Hook into fs_info->delayed_iputs */
 	struct list_head delayed_iput;
 
-	/*
-	 * To avoid races between lockless (i_mutex not held) direct IO writes
-	 * and concurrent fsync requests. Direct IO writes must acquire read
-	 * access on this semaphore for creating an extent map and its
-	 * corresponding ordered extent. The fast fsync path must acquire write
-	 * access on this semaphore before it collects ordered extents and
-	 * extent maps.
-	 */
-	struct rw_semaphore dio_sem;
-
 	struct inode vfs_inode;
 };
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 50092d24eee2..193af84f5405 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2022,8 +2022,6 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		goto buffered;
 	}
 
-	down_read(&BTRFS_I(inode)->dio_sem);
-
 	/*
 	 * We have are actually a sync iocb, so we need our fancy endio to know
 	 * if we need to sync.
@@ -2038,7 +2036,6 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (written == -ENOTBLK)
 		written = 0;
 
-	up_read(&BTRFS_I(inode)->dio_sem);
 	btrfs_inode_unlock(inode, ilock_flags);
 
 	if (written < 0 || !iov_iter_count(from)) {
@@ -2248,13 +2245,6 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 	inode_lock(inode);
 
-	/*
-	 * We take the dio_sem here because the tree log stuff can race with
-	 * lockless dio writes and get an extent map logged for an extent we
-	 * never waited on.  We need it this high up for lockdep reasons.
-	 */
-	down_write(&BTRFS_I(inode)->dio_sem);
-
 	atomic_inc(&root->log_batch);
 
 	/*
@@ -2285,7 +2275,6 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 */
 	ret = start_ordered_ops(inode, start, end);
 	if (ret) {
-		up_write(&BTRFS_I(inode)->dio_sem);
 		inode_unlock(inode);
 		goto out;
 	}
@@ -2382,7 +2371,6 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * file again, but that will end up using the synchronization
 	 * inside btrfs_sync_log to keep things safe.
 	 */
-	up_write(&BTRFS_I(inode)->dio_sem);
 	inode_unlock(inode);
 
 	if (ret != BTRFS_NO_LOG_SYNC) {
@@ -2413,7 +2401,6 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 out_release_extents:
 	btrfs_release_log_ctx_extents(&ctx);
-	up_write(&BTRFS_I(inode)->dio_sem);
 	inode_unlock(inode);
 	goto out;
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f305efac75ae..96ff8e4a3b45 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8580,7 +8580,6 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	INIT_LIST_HEAD(&ei->delalloc_inodes);
 	INIT_LIST_HEAD(&ei->delayed_iput);
 	RB_CLEAR_NODE(&ei->rb_node);
-	init_rwsem(&ei->dio_sem);
 
 	return inode;
 }
-- 
2.26.2

