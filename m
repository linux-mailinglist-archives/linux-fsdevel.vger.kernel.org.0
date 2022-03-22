Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C604E436F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238793AbiCVP6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238762AbiCVP5v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:57:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAEB69CD5;
        Tue, 22 Mar 2022 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GifgDkcSQLWbWJzlYZi0ojExi3ZmzYe+YEGtMaiQ+PY=; b=BZouzEgn2lKe/8hsZqcHMgnHDV
        IxcjO6yr+pARF69+OFva4G33glyInQIo3DGh7L6B4I7Rg1izg/7+ioI1K+b3SkRQfmcgSFXqTkPRJ
        MDxuvkrHyxXxzL8CTpbTVD8VnqOOVxWnKu2T/bNERokLqEkUBopTawxQS9G7MCVsl8N9W4hQguUs5
        h9dC2puSAAuH+rkcEzSYOtib4Zshm6lGHSqzwLCYIJw1uHXWNJllnEnlafB2sJZB8X4CC+HvpmEj+
        jLRy4RArfO/8R80VoJ65fqQylPR9igC30aDVHhVmcNRuk1wr8VGyBlTVfAVdetUcIFj23PRYnoaHe
        8NdE3CuQ==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgrr-00Bacn-7X; Tue, 22 Mar 2022 15:56:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/40] btrfs: fix and document the zoned device choice in alloc_new_bio
Date:   Tue, 22 Mar 2022 16:55:30 +0100
Message-Id: <20220322155606.1267165-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220322155606.1267165-1-hch@lst.de>
References: <20220322155606.1267165-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Zone Append bios only need a valid block device in struct bio, but
not the device in the btrfs_bio.  Use the information from
btrfs_zoned_get_device to set up bi_bdev and fix zoned writes on
multi-device file system with non-homogeneous capabilities and remove
the pointless btrfs_bio.device assignment.

Add big fat comments explaining what is going on here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7ca4e9b80f023..e789676373ab0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3330,24 +3330,37 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	ret = calc_bio_boundaries(bio_ctrl, inode, file_offset);
 	if (ret < 0)
 		goto error;
-	if (wbc) {
-		struct block_device *bdev;
 
-		bdev = fs_info->fs_devices->latest_dev->bdev;
-		bio_set_dev(bio, bdev);
-		wbc_init_bio(wbc, bio);
-	}
-	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-		struct btrfs_device *device;
+	if (wbc) {
+		/*
+		 * For Zone append we need the correct block_device that we are
+		 * going to write to set in the bio to be able to respect the
+		 * hardware limitation.  Look it up here:
+		 */
+		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+			struct btrfs_device *dev;
+
+			dev = btrfs_zoned_get_device(fs_info, disk_bytenr,
+						     fs_info->sectorsize);
+			if (IS_ERR(dev)) {
+				ret = PTR_ERR(dev);
+				goto error;
+			}
 
-		device = btrfs_zoned_get_device(fs_info, disk_bytenr,
-						fs_info->sectorsize);
-		if (IS_ERR(device)) {
-			ret = PTR_ERR(device);
-			goto error;
+			bio_set_dev(bio, dev->bdev);
+		} else {
+			/*
+			 * Otherwise pick the last added device to support
+			 * cgroup writeback.  For multi-device file systems this
+			 * means blk-cgroup policies have to always be set on the
+			 * last added/replaced device.  This is a bit odd but has
+			 * been like that for a long time.
+			 */
+			bio_set_dev(bio, fs_info->fs_devices->latest_dev->bdev);
 		}
-
-		btrfs_bio(bio)->device = device;
+		wbc_init_bio(wbc, bio);
+	} else {
+		ASSERT(bio_op(bio) != REQ_OP_ZONE_APPEND);
 	}
 	return 0;
 error:
-- 
2.30.2

