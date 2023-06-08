Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9AF7275A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 05:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjFHDY1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 23:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbjFHDYR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 23:24:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7D32137;
        Wed,  7 Jun 2023 20:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=i8udE4lZ9zFqOy/CU8rsbiperqptCexBzEc3SlSva0A=; b=FqszdcQsYtn+7QaEoWq67nnDPF
        5Eg7Zs3vYghbDl9L/ZdzusDwSf7l2rNkyQmNh7Z53nlKNwoVBTRJsa6kodwBwycgq4dXbWyFASKdm
        M82I9wh0LfRFzH792mSlPkUC187ToVFJVlM+Jw65mgJuRDVAI6fFFTuS28HZo33fhGVOgWDGHgpWW
        Ybf/GOJ8BSBsBXY6FvO3Ue13e4nOlMiKX7/7KznLwPcYEhIOr/HGyqRYaqonj1CK0AGSA+qL80nWK
        0Vu1+8vslH34F+tJJEFbeoACTr6y36JHZ9ldkj1KopEuA57cYV7tCJR79s+FTt6+oiY2zYm6MFT/6
        hrzrNh9Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q76Fr-007uuo-37;
        Thu, 08 Jun 2023 03:24:07 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, dchinner@redhat.com,
        kbusch@kernel.org, willy@infradead.org
Cc:     hare@suse.de, ritesh.list@gmail.com, rgoldwyn@suse.com,
        jack@suse.cz, patches@lists.linux.dev, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com,
        rpuri.linux@gmail.com, mcgrof@kernel.org, corbet@lwn.net,
        jake@lwn.net
Subject: [RFC 4/4] bdev: extend bdev inode with it's own super_block
Date:   Wed,  7 Jun 2023 20:24:04 -0700
Message-Id: <20230608032404.1887046-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230608032404.1887046-1-mcgrof@kernel.org>
References: <20230608032404.1887046-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We currently share a single super_block for the block device cache,
each block device corresponds to one inode on that super_block. This
implicates sharing one aops operation though, and in the near future
we want to be able to instead support using iomap on the super_block
for different block devices.

To allow more flexibility use a super_block per block device, so
that we can eventually allow co-existence with pure-iomap requirements
and block devices which require buffer-heads.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/bdev.c | 94 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 78 insertions(+), 16 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 2b16afc2bd2a..3ab952a77a11 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -30,9 +30,14 @@
 #include "../fs/internal.h"
 #include "blk.h"
 
+static LIST_HEAD(bdev_inode_list);
+static DEFINE_MUTEX(bdev_inode_mutex);
+
 struct bdev_inode {
 	struct block_device bdev;
 	struct inode vfs_inode;
+	struct vfsmount *bd_mnt;
+	struct list_head list;
 };
 
 static inline struct bdev_inode *BDEV_I(struct inode *inode)
@@ -321,10 +326,28 @@ static struct inode *bdev_alloc_inode(struct super_block *sb)
 	return &ei->vfs_inode;
 }
 
+static void bdev_remove_inode(struct bdev_inode *binode)
+{
+	struct bdev_inode *bdev_inode, *tmp;
+
+	kern_unmount(binode->bd_mnt);
+
+	mutex_lock(&bdev_inode_mutex);
+	list_for_each_entry_safe(bdev_inode, tmp, &bdev_inode_list, list) {
+		if (bdev_inode == binode) {
+			list_del_init(&bdev_inode->list);
+			break;
+		}
+	}
+	mutex_unlock(&bdev_inode_mutex);
+}
+
 static void bdev_free_inode(struct inode *inode)
 {
 	struct block_device *bdev = I_BDEV(inode);
 
+	bdev_remove_inode(BDEV_I(inode));
+
 	free_percpu(bdev->bd_stats);
 	kfree(bdev->bd_meta_info);
 
@@ -378,12 +401,9 @@ static struct file_system_type bd_type = {
 	.kill_sb	= kill_anon_super,
 };
 
-struct super_block *blockdev_superblock __read_mostly;
-
 void __init bdev_cache_init(void)
 {
 	int err;
-	static struct vfsmount *bd_mnt;
 
 	bdev_cachep = kmem_cache_create("bdev_cache", sizeof(struct bdev_inode),
 			0, (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
@@ -392,20 +412,23 @@ void __init bdev_cache_init(void)
 	err = register_filesystem(&bd_type);
 	if (err)
 		panic("Cannot register bdev pseudo-fs");
-	bd_mnt = kern_mount(&bd_type);
-	if (IS_ERR(bd_mnt))
-		panic("Cannot create bdev pseudo-fs");
-	blockdev_superblock = bd_mnt->mnt_sb;   /* For writeback */
 }
 
 struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 {
+	struct vfsmount *bd_mnt;
 	struct block_device *bdev;
 	struct inode *inode;
 
-	inode = new_inode(blockdev_superblock);
-	if (!inode)
+	bd_mnt = vfs_kern_mount(&bd_type, SB_KERNMOUNT, bd_type.name, NULL);
+	if (IS_ERR(bd_mnt))
 		return NULL;
+
+	inode = new_inode(bd_mnt->mnt_sb);
+	if (!inode) {
+		kern_unmount(bd_mnt);
+		goto err_out;
+	}
 	inode->i_mode = S_IFBLK;
 	inode->i_rdev = 0;
 #ifdef CONFIG_BUFFER_HEAD
@@ -426,12 +449,14 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	else
 		bdev->bd_has_submit_bio = false;
 	bdev->bd_stats = alloc_percpu(struct disk_stats);
-	if (!bdev->bd_stats) {
-		iput(inode);
-		return NULL;
-	}
+	if (!bdev->bd_stats)
+		goto err_out;
 	bdev->bd_disk = disk;
+	BDEV_I(inode)->bd_mnt = bd_mnt; /* For writeback */
 	return bdev;
+err_out:
+	iput(inode);
+	return NULL;
 }
 
 void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors)
@@ -444,13 +469,16 @@ void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors)
 
 void bdev_add(struct block_device *bdev, dev_t dev)
 {
+	struct inode *inode = bdev->bd_inode;
+
 	bdev->bd_dev = dev;
 	bdev->bd_inode->i_rdev = dev;
 	bdev->bd_inode->i_ino = dev;
 	insert_inode_hash(bdev->bd_inode);
+	list_add_tail(&BDEV_I(inode)->list, &bdev_inode_list);
 }
 
-long nr_blockdev_pages(void)
+static long nr_blockdev_pages_sb(struct super_block *blockdev_superblock)
 {
 	struct inode *inode;
 	long ret = 0;
@@ -463,6 +491,19 @@ long nr_blockdev_pages(void)
 	return ret;
 }
 
+long nr_blockdev_pages(void)
+{
+	struct bdev_inode *bdev_inode;
+	long ret = 0;
+
+	mutex_lock(&bdev_inode_mutex);
+	list_for_each_entry(bdev_inode, &bdev_inode_list, list)
+		ret += nr_blockdev_pages_sb(bdev_inode->bd_mnt->mnt_sb);
+	mutex_unlock(&bdev_inode_mutex);
+
+	return ret;
+}
+
 /**
  * bd_may_claim - test whether a block device can be claimed
  * @bdev: block device of interest
@@ -672,7 +713,18 @@ static void blkdev_put_part(struct block_device *part, fmode_t mode)
 
 static struct inode *blkdev_inode_lookup(dev_t dev)
 {
-	return ilookup(blockdev_superblock, dev);
+	struct bdev_inode *bdev_inode;
+	struct inode *inode = NULL;
+
+	mutex_lock(&bdev_inode_mutex);
+	list_for_each_entry(bdev_inode, &bdev_inode_list, list) {
+		inode = ilookup(bdev_inode->bd_mnt->mnt_sb, dev);
+		if (inode)
+			break;
+	}
+	mutex_unlock(&bdev_inode_mutex);
+
+	return inode;
 }
 
 struct block_device *blkdev_get_no_open(dev_t dev)
@@ -961,7 +1013,7 @@ int __invalidate_device(struct block_device *bdev, bool kill_dirty)
 }
 EXPORT_SYMBOL(__invalidate_device);
 
-void sync_bdevs(bool wait)
+static void sync_bdev_sb(struct super_block *blockdev_superblock, bool wait)
 {
 	struct inode *inode, *old_inode = NULL;
 
@@ -1013,6 +1065,16 @@ void sync_bdevs(bool wait)
 	iput(old_inode);
 }
 
+void sync_bdevs(bool wait)
+{
+	struct bdev_inode *bdev_inode;
+
+	mutex_lock(&bdev_inode_mutex);
+	list_for_each_entry(bdev_inode, &bdev_inode_list, list)
+		sync_bdev_sb(bdev_inode->bd_mnt->mnt_sb, wait);
+	mutex_unlock(&bdev_inode_mutex);
+}
+
 /*
  * Handle STATX_DIOALIGN for block devices.
  *
-- 
2.39.2

