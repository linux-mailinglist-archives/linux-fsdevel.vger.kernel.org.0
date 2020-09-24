Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1488B2776E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 18:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgIXQjq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 12:39:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:35876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgIXQjn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:39:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 162F8ABD1;
        Thu, 24 Sep 2020 16:39:42 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 02/14] btrfs: remove BTRFS_INODE_READDIO_NEED_LOCK
Date:   Thu, 24 Sep 2020 11:39:09 -0500
Message-Id: <20200924163922.2547-3-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924163922.2547-1-rgoldwyn@suse.de>
References: <20200924163922.2547-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Since we now perform direct reads using i_rwsem, we can remove this
inode flag used to co-ordinate unlocked reads.

The truncate call takes i_rwsem. This means it is correctly synchronized
with concurrent direct reads.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <jth@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/btrfs_inode.h | 18 ------------------
 fs/btrfs/inode.c       |  3 ---
 2 files changed, 21 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 6fdb46d58299..738009a22320 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -33,7 +33,6 @@ enum {
 	BTRFS_INODE_NEEDS_FULL_SYNC,
 	BTRFS_INODE_COPY_EVERYTHING,
 	BTRFS_INODE_IN_DELALLOC_LIST,
-	BTRFS_INODE_READDIO_NEED_LOCK,
 	BTRFS_INODE_HAS_PROPS,
 	BTRFS_INODE_SNAPSHOT_FLUSH,
 };
@@ -334,23 +333,6 @@ struct btrfs_dio_private {
 	u8 csums[];
 };
 
-/*
- * Disable DIO read nolock optimization, so new dio readers will be forced
- * to grab i_mutex. It is used to avoid the endless truncate due to
- * nonlocked dio read.
- */
-static inline void btrfs_inode_block_unlocked_dio(struct btrfs_inode *inode)
-{
-	set_bit(BTRFS_INODE_READDIO_NEED_LOCK, &inode->runtime_flags);
-	smp_mb();
-}
-
-static inline void btrfs_inode_resume_unlocked_dio(struct btrfs_inode *inode)
-{
-	smp_mb__before_atomic();
-	clear_bit(BTRFS_INODE_READDIO_NEED_LOCK, &inode->runtime_flags);
-}
-
 /* Array of bytes with variable length, hexadecimal format 0x1234 */
 #define CSUM_FMT				"0x%*phN"
 #define CSUM_FMT_VALUE(size, bytes)		size, bytes
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 18d171b2d544..3db4697ff1ba 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4855,10 +4855,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 
 		truncate_setsize(inode, newsize);
 
-		/* Disable nonlocked read DIO to avoid the endless truncate */
-		btrfs_inode_block_unlocked_dio(BTRFS_I(inode));
 		inode_dio_wait(inode);
-		btrfs_inode_resume_unlocked_dio(BTRFS_I(inode));
 
 		ret = btrfs_truncate(inode, newsize == oldsize);
 		if (ret && inode->i_nlink) {
-- 
2.26.2

