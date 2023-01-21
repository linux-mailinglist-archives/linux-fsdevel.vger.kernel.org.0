Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C018676441
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjAUGvB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjAUGu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:50:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9D760C8F;
        Fri, 20 Jan 2023 22:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=APcbCXsenqwfoaUYCzz2s/4DCQcwsm+X+AI7RSavdIo=; b=FhSF8mS7Ey3PqG91cruuGUcwUz
        v6cF99G4hnsKF6IVKWw+HdUbaSRcmuqkd3NeFwKy8DyxR7Cf6T4TiEZLmxiq36at+2l3mM52BYewZ
        T/HeKqmZSaqHfEfvtG3PRRSLUkwEoYa0FieXuWv6o6dUoOlFK6B1/pHky86MOMsKdUztWD80Ow32y
        HhRnO3w0rPxzx/jRFKTG56KjRngWR1yw3Z5ELcB6ZsgMngni6rEyav5/ufat227RUw7bI5sBdou/Z
        hjX+akC61aaAuZkTgYMeN/t9z0ZvADwvZV5zZabQVqDKGCehG29sMWXN8xrxk3EQ66+lhrHAsr8cA
        t74IBzbQ==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7iG-00DRK0-4r; Sat, 21 Jan 2023 06:50:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/34] btrfs: save the bio iter for checksum validation in common code
Date:   Sat, 21 Jan 2023 07:50:04 +0100
Message-Id: <20230121065031.1139353-8-hch@lst.de>
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

All callers of btrfs_submit_bio that want to validate checksums
currently have to store a copy of the iter in the btrfs_bio.  Move
the assignment into common code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c         | 7 ++++++-
 fs/btrfs/compression.c | 4 ----
 fs/btrfs/extent_io.c   | 1 -
 fs/btrfs/inode.c       | 7 -------
 4 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 23afeeb6dbc8eb..2651f20891f08f 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -63,7 +63,6 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
 	btrfs_bio_init(bbio, inode, end_io, private);
 
 	bio_trim(bio, offset >> 9, size >> 9);
-	bbio->iter = bio->bi_iter;
 	return bio;
 }
 
@@ -254,6 +253,12 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 		BUG();
 	}
 
+	/*
+	 * Save the iter for the end_io handler for data reads.
+	 */
+	if (bio_op(bio) == REQ_OP_READ && !(bio->bi_opf & REQ_META))
+		bbio->iter = bio->bi_iter;
+
 	if (!bioc) {
 		/* Single mirror read/write fast path */
 		bbio->mirror_num = mirror_num;
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index ab7f7ea499d9ca..ba458b88be26b0 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -789,10 +789,6 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 			submit = true;
 
 		if (submit) {
-			/* Save the original iter for read repair */
-			if (bio_op(comp_bio) == REQ_OP_READ)
-				btrfs_bio(comp_bio)->iter = comp_bio->bi_iter;
-
 			/*
 			 * Save the initial offset of this chunk, as there
 			 * is no direct correlation between compressed pages and
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index faf9312a46c0e1..44cacf62e4314e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -756,7 +756,6 @@ int btrfs_repair_one_sector(struct btrfs_inode *inode, struct btrfs_bio *failed_
 	}
 
 	bio_add_page(repair_bio, page, failrec->len, pgoff);
-	repair_bbio->iter = repair_bio->bi_iter;
 
 	btrfs_debug(fs_info,
 		    "repair read error: submitting new read to mirror %d",
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7c8f5349ed7a4c..c368a45bc079d6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2773,9 +2773,6 @@ void btrfs_submit_data_read_bio(struct btrfs_inode *inode, struct bio *bio,
 		return;
 	}
 
-	/* Save the original iter for read repair */
-	btrfs_bio(bio)->iter = bio->bi_iter;
-
 	/*
 	 * Lookup bio sums does extra checks around whether we need to csum or
 	 * not, which is why we ignore skip_sum here.
@@ -7988,10 +7985,6 @@ static void btrfs_submit_dio_bio(struct bio *bio, struct btrfs_inode *inode,
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	blk_status_t ret;
 
-	/* Save the original iter for read repair */
-	if (btrfs_op(bio) == BTRFS_MAP_READ)
-		btrfs_bio(bio)->iter = bio->bi_iter;
-
 	if (inode->flags & BTRFS_INODE_NODATASUM)
 		goto map;
 
-- 
2.39.0

