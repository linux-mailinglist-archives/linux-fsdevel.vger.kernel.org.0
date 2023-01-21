Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03020676452
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjAUGvD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjAUGvA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:51:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE5B66ECB;
        Fri, 20 Jan 2023 22:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=seOiQ2zpzXFLBbGATDT2NxKw/UgmRGyApnsnQY6BKtA=; b=xsjK2CUXHjHTCPeruX9tGTd3I0
        HfYF2tOFnFyOrDqR33KI09Y/BC1a7UZm6AvZrr90K4x3TZJwC3H0VI1vEW8MGVzoiRfygXTdbECHt
        QQK75B7DmaUL7zjlfHoUdPotCDXbckNrox4jhCGhQSSs3Q9Cb7eckt+HkN9PVgkQUi7zCAlLMGfIy
        pDp2dA0RY6QP0ErQg3XecTWZbK9Oj/l/GxHH5IowxaN+f42xQCP7XZMRqfJy30Z1itU8B4g+OlVY/
        l80L61k6/WBjk/Qx61f0708Qj+vVsEYs02yiySB8genLi5xvaZMYHQALn7/FOF5hSPJDkLAK7lBzq
        XnybgZKw==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7iI-00DRKn-RP; Sat, 21 Jan 2023 06:50:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/34] btrfs: pre-load data checksum for reads in btrfs_submit_bio
Date:   Sat, 21 Jan 2023 07:50:05 +0100
Message-Id: <20230121065031.1139353-9-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121065031.1139353-1-hch@lst.de>
References: <20230121065031.1139353-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of calling btrfs_lookup_bio_sums in every caller of
btrfs_submit_bio that reads data, do the call once in btrfs_submit_bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c         | 10 ++++++++--
 fs/btrfs/compression.c |  6 ------
 fs/btrfs/inode.c       | 24 ------------------------
 3 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 2651f20891f08f..6fbb71e60037be 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -14,6 +14,7 @@
 #include "dev-replace.h"
 #include "rcu-string.h"
 #include "zoned.h"
+#include "file-item.h"
 
 static struct bio_set btrfs_bioset;
 
@@ -254,10 +255,15 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 	}
 
 	/*
-	 * Save the iter for the end_io handler for data reads.
+	 * Save the iter for the end_io handler and preload the checksums for
+	 * data reads.
 	 */
-	if (bio_op(bio) == REQ_OP_READ && !(bio->bi_opf & REQ_META))
+	if (bio_op(bio) == REQ_OP_READ && !(bio->bi_opf & REQ_META)) {
 		bbio->iter = bio->bi_iter;
+		ret = btrfs_lookup_bio_sums(bbio);
+		if (ret)
+			goto fail;
+	}
 
 	if (!bioc) {
 		/* Single mirror read/write fast path */
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index ba458b88be26b0..fdcc6f3b90b128 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -797,12 +797,6 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 			 */
 			btrfs_bio(comp_bio)->file_offset = file_offset;
 
-			ret = btrfs_lookup_bio_sums(btrfs_bio(comp_bio));
-			if (ret) {
-				btrfs_bio_end_io(btrfs_bio(comp_bio), ret);
-				break;
-			}
-
 			ASSERT(comp_bio->bi_iter.bi_size);
 			btrfs_submit_bio(fs_info, comp_bio, mirror_num);
 			comp_bio = NULL;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c368a45bc079d6..598897b0d661da 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2762,7 +2762,6 @@ void btrfs_submit_data_read_bio(struct btrfs_inode *inode, struct bio *bio,
 			int mirror_num, enum btrfs_compression_type compress_type)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	blk_status_t ret;
 
 	if (compress_type != BTRFS_COMPRESS_NONE) {
 		/*
@@ -2773,16 +2772,6 @@ void btrfs_submit_data_read_bio(struct btrfs_inode *inode, struct bio *bio,
 		return;
 	}
 
-	/*
-	 * Lookup bio sums does extra checks around whether we need to csum or
-	 * not, which is why we ignore skip_sum here.
-	 */
-	ret = btrfs_lookup_bio_sums(btrfs_bio(bio));
-	if (ret) {
-		btrfs_bio_end_io(btrfs_bio(bio), ret);
-		return;
-	}
-
 	btrfs_submit_bio(fs_info, bio, mirror_num);
 }
 
@@ -8004,12 +7993,6 @@ static void btrfs_submit_dio_bio(struct bio *bio, struct btrfs_inode *inode,
 			btrfs_bio_end_io(btrfs_bio(bio), ret);
 			return;
 		}
-	} else {
-		ret = btrfs_lookup_bio_sums(btrfs_bio(bio));
-		if (ret) {
-			btrfs_bio_end_io(btrfs_bio(bio), ret);
-			return;
-		}
 	}
 map:
 	btrfs_submit_bio(fs_info, bio, 0);
@@ -10269,13 +10252,6 @@ static blk_status_t submit_encoded_read_bio(struct btrfs_inode *inode,
 {
 	struct btrfs_encoded_read_private *priv = btrfs_bio(bio)->private;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	blk_status_t ret;
-
-	if (!priv->skip_csum) {
-		ret = btrfs_lookup_bio_sums(btrfs_bio(bio));
-		if (ret)
-			return ret;
-	}
 
 	atomic_inc(&priv->pending);
 	btrfs_submit_bio(fs_info, bio, mirror_num);
-- 
2.39.0

