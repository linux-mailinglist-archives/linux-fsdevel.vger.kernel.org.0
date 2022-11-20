Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1077A631408
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Nov 2022 13:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiKTMsJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Nov 2022 07:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiKTMsC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Nov 2022 07:48:02 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24AF2BC3;
        Sun, 20 Nov 2022 04:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=H44KGGMRN5KIHGaSWYtzgZPttwkuaR0yYnG9oUIggnc=; b=cMFcKZRA5Q0bUYbT22gtE3tSYD
        xMQrCcrA3nIMBoLS8pNf+nBJOK7TSKeKb1ja7/jAXDH/Fg8eLELSXlRSYgDWtBuifJL2TUMNwGPPA
        ZWEPHs8ZUN0B06taDDtlvU12f8QfuPiuXIZaTbmS1Qz+4H2lO8v0rbvzMn8Qw9Aps4mfDkakT97l6
        ixLoPmaG4cjX2//VcogyVVK66mYpkg/9U6PFIvV42i/6c20GrgyyY9yto+KvvMb3Co0uLFxUidE6h
        NlzHNfhM5MK4HRdkvpUCs5mSgh3XMqWAecOp+yYaUodEra7aOatkpKimnVygzYRdzeTw3JS53RQCR
        0eHPosLw==;
Received: from [2001:4bb8:181:6f70:ae5d:6675:76b9:6fc3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1owjjp-004I9B-Ei; Sun, 20 Nov 2022 12:47:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/19] btrfs: support cloned bios in btree_csum_one_bio
Date:   Sun, 20 Nov 2022 13:47:22 +0100
Message-Id: <20221120124734.18634-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221120124734.18634-1-hch@lst.de>
References: <20221120124734.18634-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To allow splitting bios in btrfs_submit_bio, btree_csum_one_bio needs to
be able to handle cloned bios.  As btree_csum_one_bio is always called
before handing the bio to the block layer that is trivially done by using
bio_for_each_segment instead of bio_for_each_segment_all.  Also switch
the function to take a btrfs_bio and use that to derive the fs_info.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c     |  2 +-
 fs/btrfs/disk-io.c | 14 ++++++--------
 fs/btrfs/disk-io.h |  2 +-
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 5978b795bf710..4979cf74da624 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -440,7 +440,7 @@ static void __btrfs_submit_bio(struct bio *bio, struct btrfs_io_context *bioc,
 static blk_status_t btrfs_bio_csum(struct btrfs_bio *bbio)
 {
 	if (bbio->bio.bi_opf & REQ_META)
-		return btree_csum_one_bio(&bbio->bio);
+		return btree_csum_one_bio(bbio);
 	return btrfs_csum_one_bio(bbio);
 }
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2018d1b9ff3a5..c8b6ef511942c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -431,17 +431,15 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct bio_vec *bvec
 	return csum_one_extent_buffer(eb);
 }
 
-blk_status_t btree_csum_one_bio(struct bio *bio)
+blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 {
-	struct bio_vec *bvec;
-	struct btrfs_root *root;
+	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
+	struct bvec_iter iter;
+	struct bio_vec bv;
 	int ret = 0;
-	struct bvec_iter_all iter_all;
 
-	ASSERT(!bio_flagged(bio, BIO_CLONED));
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		root = BTRFS_I(bvec->bv_page->mapping->host)->root;
-		ret = csum_dirty_buffer(root->fs_info, bvec);
+	bio_for_each_segment(bv, &bbio->bio, iter) {
+		ret = csum_dirty_buffer(fs_info, &bv);
 		if (ret)
 			break;
 	}
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 1e04ecc43a2ab..101260f57e816 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -114,7 +114,7 @@ int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
 int btrfs_read_extent_buffer(struct extent_buffer *buf,
 			     struct btrfs_tree_parent_check *check);
 
-blk_status_t btree_csum_one_bio(struct bio *bio);
+blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio);
 int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root);
 int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
-- 
2.30.2

