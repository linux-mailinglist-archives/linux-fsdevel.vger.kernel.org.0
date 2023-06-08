Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1AC7275A4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 05:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbjFHDYZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 23:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjFHDYR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 23:24:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE541BF7;
        Wed,  7 Jun 2023 20:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7c5o1TgTZx/+yF45xsch3Sa+lM5OGTIusUitJBnsivE=; b=dS6kbTArhANERobE2WbrG1u86d
        G4kysNRDCruOqSaKtFn5zAcevAzNcDqJ0XIDpt0InqV1E229h2v4AB1t1AX54XIrldldfRokKfP7E
        NL4ogmpWWCw2xOQewRDYNDOuZC9aP36wgbF9JBIzjszCm5UrIatcNwKIG1bvBjPBZSBfQI9aVAxZ0
        C7cA89Uq+npbfJYk11W8mSb4z5E/YKz+dwLcyoUDyzdlOAR1xNFTe1aMoN1mggp6ZlIlAhHc2YSBQ
        7hx8CNFT/U6kJM0LK1ek6TW2XflCX+fvMT9Eln3BO/FJSBFHHddr59Ud16t1OOdL5eKmmqcUerXRp
        xu1YHExw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q76Fr-007uum-2y;
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
Subject: [RFC 3/4] bdev: rename iomap aops
Date:   Wed,  7 Jun 2023 20:24:03 -0700
Message-Id: <20230608032404.1887046-4-mcgrof@kernel.org>
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
index 61d8d2722cda..2b16afc2bd2a 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -408,7 +408,11 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
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
index 7ad7cb6ffa01..67bf2fa99fe9 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -453,6 +453,7 @@ long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 
 extern const struct address_space_operations def_blk_aops;
+extern const struct address_space_operations def_blk_aops_iomap;
 
 int disk_register_independent_access_ranges(struct gendisk *disk);
 void disk_unregister_independent_access_ranges(struct gendisk *disk);
diff --git a/block/fops.c b/block/fops.c
index 24037b493f5f..51f7241ab389 100644
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

