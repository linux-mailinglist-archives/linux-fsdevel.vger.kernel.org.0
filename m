Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2B0D11C170
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 01:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfLLAbJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 19:31:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:42316 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727359AbfLLAbI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 19:31:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CFF9DACF2;
        Thu, 12 Dec 2019 00:31:06 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com, fdmanana@kernel.org, dsterba@suse.cz,
        jthumshirn@suse.de, nborisov@suse.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 8/8] btrfs: remove BTRFS_INODE_READDIO_NEED_LOCK
Date:   Wed, 11 Dec 2019 18:30:43 -0600
Message-Id: <20191212003043.31093-9-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191212003043.31093-1-rgoldwyn@suse.de>
References: <20191212003043.31093-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Since we now perform direct reads using i_rwsem, we can remove this
inode flag used to co-ordinate unlocked reads.

The truncate call takes i_rwsem. This means it is correctly synchronized
with concurrent direct reads.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/btrfs_inode.h | 18 ------------------
 fs/btrfs/inode.c       |  5 -----
 2 files changed, 23 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 4e12a477d32e..cd8f378ed8e7 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -27,7 +27,6 @@ enum {
 	BTRFS_INODE_NEEDS_FULL_SYNC,
 	BTRFS_INODE_COPY_EVERYTHING,
 	BTRFS_INODE_IN_DELALLOC_LIST,
-	BTRFS_INODE_READDIO_NEED_LOCK,
 	BTRFS_INODE_HAS_PROPS,
 	BTRFS_INODE_SNAPSHOT_FLUSH,
 };
@@ -317,23 +316,6 @@ struct btrfs_dio_private {
 			blk_status_t);
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
index c5c809ab84cf..501e2a8f5b93 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5273,11 +5273,6 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 
 		truncate_setsize(inode, newsize);
 
-		/* Disable nonlocked read DIO to avoid the endless truncate */
-		btrfs_inode_block_unlocked_dio(BTRFS_I(inode));
-		inode_dio_wait(inode);
-		btrfs_inode_resume_unlocked_dio(BTRFS_I(inode));
-
 		ret = btrfs_truncate(inode, newsize == oldsize);
 		if (ret && inode->i_nlink) {
 			int err;
-- 
2.16.4

