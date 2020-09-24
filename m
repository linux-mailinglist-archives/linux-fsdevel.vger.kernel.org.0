Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D7C2776FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 18:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgIXQkN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 12:40:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:36770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbgIXQkN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:40:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B3E45B28F;
        Thu, 24 Sep 2020 16:40:10 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 12/14] btrfs: Remove dio_sem
Date:   Thu, 24 Sep 2020 11:39:19 -0500
Message-Id: <20200924163922.2547-13-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924163922.2547-1-rgoldwyn@suse.de>
References: <20200924163922.2547-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

dio_sem can be eliminated because all DIO synchronization is performed
through inode->i_rwsem now.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
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
index 83012d1e6f29..6854bf78d677 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2021,8 +2021,6 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		goto buffered;
 	}
 
-	down_read(&BTRFS_I(inode)->dio_sem);
-
 	/*
 	 * We have are actually a sync iocb, so we need our fancy endio to know
 	 * if we need to sync.
@@ -2037,7 +2035,6 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (written == -ENOTBLK)
 		written = 0;
 
-	up_read(&BTRFS_I(inode)->dio_sem);
 	btrfs_inode_unlock(inode, ilock_flags);
 
 	if (written < 0 || !iov_iter_count(from)) {
@@ -2245,13 +2242,6 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
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
@@ -2282,7 +2272,6 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 */
 	ret = start_ordered_ops(inode, start, end);
 	if (ret) {
-		up_write(&BTRFS_I(inode)->dio_sem);
 		inode_unlock(inode);
 		goto out;
 	}
@@ -2379,7 +2368,6 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * file again, but that will end up using the synchronization
 	 * inside btrfs_sync_log to keep things safe.
 	 */
-	up_write(&BTRFS_I(inode)->dio_sem);
 	inode_unlock(inode);
 
 	if (ret != BTRFS_NO_LOG_SYNC) {
@@ -2410,7 +2398,6 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 out_release_extents:
 	btrfs_release_log_ctx_extents(&ctx);
-	up_write(&BTRFS_I(inode)->dio_sem);
 	inode_unlock(inode);
 	goto out;
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cdde4422a6fa..17c97f30459c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8594,7 +8594,6 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	INIT_LIST_HEAD(&ei->delalloc_inodes);
 	INIT_LIST_HEAD(&ei->delayed_iput);
 	RB_CLEAR_NODE(&ei->rb_node);
-	init_rwsem(&ei->dio_sem);
 
 	return inode;
 }
-- 
2.26.2

