Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE4A7A2977
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 23:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237794AbjIOVda (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 17:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237742AbjIOVdO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:33:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A57B8;
        Fri, 15 Sep 2023 14:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ywg9faqG2BCnT1wKSQTUuxdInS3gshCAShEIiU6RHjQ=; b=qZS2ofRnqhN2ypoQAYEMnwcIRF
        HZUE+++FdwsDen9M6IhyoAQ+Y7IzzG+N6V5wdQXwdMhZwhUZOOOkXUyJn5dH5RZELYsDhvqfIyCnA
        ZjYUrf9zEzLClRiJF4F8RlTgboxEj7+SeYzajsKRRaiu9LdY0ic7q1ZAKdUj1flkfYBD5mf2ru396
        o6BEKaGXoMw51wobZ87Zc80mRgP73fRjgEVpPf3KoqmioNBUm5UeaqAtE4ddC30ZIYqkwxU6RlDOC
        28YjopC1+/y6tkHKPQpwssGCKPPuBy05mqO5WZzTekd+HM/K74fIDkiSrHBRW+fDUWOH85cjqgyBi
        gUde0Spg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qhGQq-00BQnS-0y;
        Fri, 15 Sep 2023 21:32:56 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, dchinner@redhat.com,
        kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc:     willy@infradead.org, brauner@kernel.org, hare@suse.de,
        ritesh.list@gmail.com, rgoldwyn@suse.com, jack@suse.cz,
        ziy@nvidia.com, ryan.roberts@arm.com, patches@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, p.raghav@samsung.com,
        da.gomez@samsung.com, dan.helmick@samsung.com, mcgrof@kernel.org
Subject: [RFC v2 05/10] bdev: allow to switch between bdev aops
Date:   Fri, 15 Sep 2023 14:32:49 -0700
Message-Id: <20230915213254.2724586-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230915213254.2724586-1-mcgrof@kernel.org>
References: <20230915213254.2724586-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that we have annotations for filesystems which require buffer-heads we
can use that flag to verify if we can use the filesystem on the target
block devices which require higher order folios. A filesystems which requires
buffer-heads cannot be used on block devices which have a logical block size
greater than PAGE_SIZE. We also want to allow to use buffer-head filesystems
on block devices and at a later time then unmount and switch to a filesystem
which supports bs > PAGE_SIZE, even if the logical block size of the block
device is PAGE_SIZE, and this requires iomap. Provide helpers to do all these
checks and resets the aops to iomap when needed.

Leaving iomap in place after an umount would not make such block devices usable
for buffer-head filesystems so we must reset the aops to buffer-heads also
on unmount.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/bdev.c           | 55 ++++++++++++++++++++++++++++++++++++++++++
 fs/super.c             |  3 ++-
 include/linux/blkdev.h |  7 ++++++
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index 0d685270cd34..bf3cfc02aaf9 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -150,6 +150,59 @@ static int bdev_bsize_limit(struct block_device *bdev)
 	return PAGE_SIZE;
 }
 
+#ifdef CONFIG_BUFFER_HEAD
+static void bdev_aops_set(struct block_device *bdev,
+			  const struct address_space_operations *aops)
+{
+	kill_bdev(bdev);
+	bdev->bd_inode->i_data.a_ops = aops;
+}
+
+static void bdev_aops_sync(struct super_block *sb, struct block_device *bdev,
+			   const struct address_space_operations *aops)
+{
+	sync_blockdev(bdev);
+	bdev_aops_set(bdev, aops);
+	kill_bdev(bdev);
+	bdev->bd_inode->i_data.a_ops = aops;
+}
+
+void bdev_aops_reset(struct block_device *bdev)
+{
+	bdev_aops_set(bdev, &def_blk_aops);
+}
+
+static int sb_bdev_aops_set(struct super_block *sb)
+{
+	struct block_device *bdev = sb->s_bdev;
+
+	if (mapping_min_folio_order(bdev->bd_inode->i_mapping) != 0 &&
+	    sb->s_type->fs_flags & FS_BUFFER_HEADS) {
+			pr_warn_ratelimited(
+"block device logical block size > PAGE_SIZE, buffer-head filesystem cannot be used.\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * We can switch back and forth, but we need to use buffer-heads
+	 * first, otherwise a filesystem created which only uses iomap
+	 * will have it sticky and we can't detect buffer-head filesystems
+	 * on mount.
+	 */
+	bdev_aops_sync(sb, bdev, &def_blk_aops);
+	if (sb->s_type->fs_flags & FS_BUFFER_HEADS)
+		return 0;
+
+	bdev_aops_sync(sb, bdev, &def_blk_aops_iomap);
+	return 0;
+}
+#else
+static int sb_bdev_aops_set(struct super_block *sb)
+{
+	return 0;
+}
+#endif
+
 int set_blocksize(struct block_device *bdev, int size)
 {
 	/* Size must be a power of two, and between 512 and supported order */
@@ -173,6 +226,8 @@ EXPORT_SYMBOL(set_blocksize);
 
 int sb_set_blocksize(struct super_block *sb, int size)
 {
+	if (sb_bdev_aops_set(sb))
+		return 0;
 	if (set_blocksize(sb->s_bdev, size))
 		return 0;
 	/* If we get here, we know size is power of two
diff --git a/fs/super.c b/fs/super.c
index 816a22a5cad1..eb269c9489cb 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1649,12 +1649,13 @@ void kill_block_super(struct super_block *sb)
 	generic_shutdown_super(sb);
 	if (bdev) {
 		sync_blockdev(bdev);
+		bdev_aops_reset(bdev);
 		blkdev_put(bdev, sb);
 	}
 }
 
 EXPORT_SYMBOL(kill_block_super);
-#endif
+#endif /* CONFIG_BLOCK */
 
 struct dentry *mount_nodev(struct file_system_type *fs_type,
 	int flags, void *data,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index eef450f25982..738a879a0786 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1503,6 +1503,13 @@ void sync_bdevs(bool wait);
 void bdev_statx_dioalign(struct inode *inode, struct kstat *stat);
 void printk_all_partitions(void);
 int __init early_lookup_bdev(const char *pathname, dev_t *dev);
+#ifdef CONFIG_BUFFER_HEAD
+void bdev_aops_reset(struct block_device *bdev);
+#else
+static inline void bdev_aops_reset(struct block_device *bdev)
+{
+}
+#endif
 #else
 static inline void invalidate_bdev(struct block_device *bdev)
 {
-- 
2.39.2

