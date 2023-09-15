Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC207A296C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 23:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbjIOVd1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 17:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237721AbjIOVdM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:33:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394E8F7;
        Fri, 15 Sep 2023 14:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fY/ZSJcX0nGtNhorp279tvkX1snuX5Kki9NEKyyEvZ0=; b=pMZOMSoplkznMz23hCcyCuvW+1
        Q5X0DNXRoWSaQm50XrYed2ERGsB62yIGhxRFVJ5yWO7/WHTncq80QWO6bWPAxmnhgXa2arperZvms
        NTxp8MdrjSQkYV48LcOR50FiLW93j9OS1kLLdbjLQ8sW2W7WPR5rqgWAM7bEnXWkxT4QnkGneUGO3
        E8rh9r/+rao7kSNdq1f6/C0v4BHWzLlSlNz46HMKDM6azvHhAKSm/tyv230E9q1BPCMDWUATuo9/Y
        IL5mKOlshmRBOtbl2P/dz7P55FbzsqPlB8QGk16lhaOPwcNLq1sYSSDisbfbiHzu6BE1WTaycpYL6
        3hzMI4aQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qhGQq-00BQnH-0K;
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
Subject: [RFC v2 01/10] bdev: rename iomap aops
Date:   Fri, 15 Sep 2023 14:32:45 -0700
Message-Id: <20230915213254.2724586-2-mcgrof@kernel.org>
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

Allow buffer-head and iomap aops to co-exist on a build. Right
now the iomap aops is can only be used if you disable buffer-heads.
In the near future we should be able to dynamically select at runtime
the intended aops based on the nature of the filesystem and device
requirements.

So rename the iomap aops, and select use the new name if buffer-heads
is disabled. This introduces no functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/bdev.c |  4 ++++
 block/blk.h  |  1 +
 block/fops.c | 14 +++++++-------
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index f3b13aa1b7d4..6e62d8a992e6 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -392,7 +392,11 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 		return NULL;
 	inode->i_mode = S_IFBLK;
 	inode->i_rdev = 0;
+#ifdef CONFIG_BUFFER_HEAD
 	inode->i_data.a_ops = &def_blk_aops;
+#else
+	inode->i_data.a_ops = &def_blk_aops_iomap;
+#endif
 	mapping_set_gfp_mask(&inode->i_data, GFP_USER);
 
 	bdev = I_BDEV(inode);
diff --git a/block/blk.h b/block/blk.h
index 08a358bc0919..75e8deb9f458 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -473,6 +473,7 @@ long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 
 extern const struct address_space_operations def_blk_aops;
+extern const struct address_space_operations def_blk_aops_iomap;
 
 int disk_register_independent_access_ranges(struct gendisk *disk);
 void disk_unregister_independent_access_ranges(struct gendisk *disk);
diff --git a/block/fops.c b/block/fops.c
index acff3d5d22d4..80a8430bcd69 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -455,13 +455,14 @@ const struct address_space_operations def_blk_aops = {
 	.migrate_folio	= buffer_migrate_folio_norefs,
 	.is_dirty_writeback = buffer_check_dirty_writeback,
 };
-#else /* CONFIG_BUFFER_HEAD */
-static int blkdev_read_folio(struct file *file, struct folio *folio)
+
+#endif /* CONFIG_BUFFER_HEAD */
+static int blkdev_read_folio_iomap(struct file *file, struct folio *folio)
 {
 	return iomap_read_folio(folio, &blkdev_iomap_ops);
 }
 
-static void blkdev_readahead(struct readahead_control *rac)
+static void blkdev_readahead_iomap(struct readahead_control *rac)
 {
 	iomap_readahead(rac, &blkdev_iomap_ops);
 }
@@ -492,18 +493,17 @@ static int blkdev_writepages(struct address_space *mapping,
 	return iomap_writepages(mapping, wbc, &wpc, &blkdev_writeback_ops);
 }
 
-const struct address_space_operations def_blk_aops = {
+const struct address_space_operations def_blk_aops_iomap = {
 	.dirty_folio	= filemap_dirty_folio,
 	.release_folio		= iomap_release_folio,
 	.invalidate_folio	= iomap_invalidate_folio,
-	.read_folio		= blkdev_read_folio,
-	.readahead		= blkdev_readahead,
+	.read_folio		= blkdev_read_folio_iomap,
+	.readahead		= blkdev_readahead_iomap,
 	.writepages		= blkdev_writepages,
 	.is_partially_uptodate  = iomap_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
 	.migrate_folio		= filemap_migrate_folio,
 };
-#endif /* CONFIG_BUFFER_HEAD */
 
 /*
  * for a block special file file_inode(file)->i_size is zero
-- 
2.39.2

