Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9BD203AC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 17:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgFVPZ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 11:25:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:52376 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729374AbgFVPZ3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:25:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9D7D6C19F;
        Mon, 22 Jun 2020 15:25:26 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, hch@lst.de, darrick.wong@oracle.com,
        david@fromorbit.com, dsterba@suse.cz, jthumshirn@suse.de,
        fdmanana@gmail.com, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 5/6] btrfs: remove BTRFS_INODE_READDIO_NEED_LOCK
Date:   Mon, 22 Jun 2020 10:24:56 -0500
Message-Id: <20200622152457.7118-6-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200622152457.7118-1-rgoldwyn@suse.de>
References: <20200622152457.7118-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/btrfs_inode.h | 18 ------------------
 fs/btrfs/inode.c       |  3 ---
 2 files changed, 21 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index e7d709505cb1..aeff56a0e105 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -28,7 +28,6 @@ enum {
 	BTRFS_INODE_NEEDS_FULL_SYNC,
 	BTRFS_INODE_COPY_EVERYTHING,
 	BTRFS_INODE_IN_DELALLOC_LIST,
-	BTRFS_INODE_READDIO_NEED_LOCK,
 	BTRFS_INODE_HAS_PROPS,
 	BTRFS_INODE_SNAPSHOT_FLUSH,
 };
@@ -313,23 +312,6 @@ struct btrfs_dio_private {
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
index 0d93f82d3146..edce0d77253b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4811,10 +4811,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 
 		truncate_setsize(inode, newsize);
 
-		/* Disable nonlocked read DIO to avoid the endless truncate */
-		btrfs_inode_block_unlocked_dio(BTRFS_I(inode));
 		inode_dio_wait(inode);
-		btrfs_inode_resume_unlocked_dio(BTRFS_I(inode));
 
 		ret = btrfs_truncate(inode, newsize == oldsize);
 		if (ret && inode->i_nlink) {
-- 
2.25.0

