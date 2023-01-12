Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49039666DAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 10:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239840AbjALJLm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 04:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbjALJKU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:10:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733BDE08E;
        Thu, 12 Jan 2023 01:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=N4KfnCuqip072hC4jplqw4X0hoo6iaWrIF9Ngek7z0k=; b=dTeUOz+Iabb4Qv7es57qu42Mfu
        icMh54MpQnxtXq9x23nQSyX11+pDJLcetMQwhH0xSyw8KiDkyAiQNJIsGvIEgEu4cIojRgWaoDQC1
        bB1QuqWHqR0EjX0JDCy6WCWdCON1TU8n/Rl0C/01ubSd8en19C3tGG6tDmtM7KB3dcyHZ4Z3THvtL
        IspyD1GCTieIDdgodi02r1gU8JzTAUf4mLXgq0CYGE8o4Pj3ZbWoyQWeZ6CJ/y0ul9rQxOhXYj5d+
        d22LOeQsNtA+0AxQqRh5364iqILe0BwBnUiHJS8woOCn+J4KfRjWQJDvISLZoG8NCZT+c6ADsE42r
        5ntjjxNw==;
Received: from [2001:4bb8:181:656b:c87d:36c9:914c:c2ea] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFtX0-00EGKJ-PT; Thu, 12 Jan 2023 09:05:55 +0000
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
Date:   Thu, 12 Jan 2023 10:05:19 +0100
Message-Id: <20230112090532.1212225-8-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230112090532.1212225-1-hch@lst.de>
References: <20230112090532.1212225-1-hch@lst.de>
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c     |  2 +-
 fs/btrfs/disk-io.c | 14 ++++++--------
 fs/btrfs/disk-io.h |  2 +-
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 2e8943fd696e94..c68a1a0a6a869f 100644
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
index 146b64715745bb..e60fd73957c8e3 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -438,17 +438,15 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct bio_vec *bvec
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
index ac55f8ec3a31a7..f2dd4c6d9c258b 100644
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
2.35.1

