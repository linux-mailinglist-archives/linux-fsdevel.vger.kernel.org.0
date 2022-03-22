Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58A94E4393
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbiCVP6i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238788AbiCVP6e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:58:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623BF6E344;
        Tue, 22 Mar 2022 08:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=sDuwS2b0eG9VMafKXk8DWKaeYMjvlsxzjdESvyTuKt4=; b=pVr2HzWuV0fD9l4cWzKVcF91Fq
        ei9MQJxXL1KF/EPu+dsCL2xV833Vz6MS0nZNVLZ3H8sgVdjdgG2FFxA3VrDQPdYXHFh0o65d969Ck
        i7v7NsYCxfsBeXQ9bw0b/vPUxyf1qCsNXyCP97N0ODegc1jnve9D4BT7QHcb6WVNAnnqz47zwvE3V
        rccBQRviJmULkpnxeX2dkIDeJypMIDO0V5P/W/ll5JVGpU1KY5LsKwhm9F4IpafqVOMSFs+qrE2Qi
        1vQvKCsCU904z5LjQXewoQUG4sdBlwK1XFC36aV9kaglRyr5uwCHjEXlLYqrTS53MoQ/nQmY/wIiQ
        OW/9JDjQ==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgsW-00Bapj-Ey; Tue, 22 Mar 2022 15:57:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 20/40] btrfs: cleanup btrfs_submit_metadata_bio
Date:   Tue, 22 Mar 2022 16:55:46 +0100
Message-Id: <20220322155606.1267165-21-hch@lst.de>
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

Remove the unused bio_flags argument and clean up the code flow to be
straight forward.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/disk-io.c   | 42 ++++++++++++++++--------------------------
 fs/btrfs/disk-io.h   |  2 +-
 fs/btrfs/extent_io.c |  2 +-
 3 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index dc497e17dcd06..f43c9ab86e617 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -890,6 +890,10 @@ static blk_status_t btree_submit_bio_start(struct inode *inode, struct bio *bio,
 	return btree_csum_one_bio(bio);
 }
 
+/*
+ * Check if metadata writes should be submitted by async threads so that
+ * checksumming can happen in parallel across all CPUs.
+ */
 static bool should_async_write(struct btrfs_fs_info *fs_info,
 			     struct btrfs_inode *bi)
 {
@@ -903,41 +907,27 @@ static bool should_async_write(struct btrfs_fs_info *fs_info,
 }
 
 blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
-				       int mirror_num, unsigned long bio_flags)
+				       int mirror_num)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	blk_status_t ret;
 
-	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
-		/*
-		 * called for a read, do the setup so that checksum validation
-		 * can happen in the async kernel threads
-		 */
-		ret = btrfs_bio_wq_end_io(fs_info, bio,
-					  BTRFS_WQ_ENDIO_METADATA);
-		if (ret)
-			goto out_w_error;
-		ret = btrfs_map_bio(fs_info, bio, mirror_num);
-	} else if (!should_async_write(fs_info, BTRFS_I(inode))) {
+	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
+		if (should_async_write(fs_info, BTRFS_I(inode)))
+			return btrfs_wq_submit_bio(inode, bio, mirror_num, 0, 0,
+						   btree_submit_bio_start);
 		ret = btree_csum_one_bio(bio);
 		if (ret)
-			goto out_w_error;
-		ret = btrfs_map_bio(fs_info, bio, mirror_num);
+			return ret;
 	} else {
-		/*
-		 * kthread helpers are used to submit writes so that
-		 * checksumming can happen in parallel across all CPUs
-		 */
-		ret = btrfs_wq_submit_bio(inode, bio, mirror_num, 0,
-					  0, btree_submit_bio_start);
+		/* checksum validation should happen in async threads: */
+		ret = btrfs_bio_wq_end_io(fs_info, bio,
+					  BTRFS_WQ_ENDIO_METADATA);
+		if (ret)
+			return ret;
 	}
 
-	if (ret)
-		goto out_w_error;
-	return 0;
-
-out_w_error:
-	return ret;
+	return btrfs_map_bio(fs_info, bio, mirror_num);
 }
 
 #ifdef CONFIG_MIGRATION
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 2364a30cd9e32..afe3bb96616c9 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -87,7 +87,7 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
 				   struct page *page, u64 start, u64 end,
 				   int mirror);
 blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
-				       int mirror_num, unsigned long bio_flags);
+				       int mirror_num);
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info);
 #endif
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 238252f86d5ad..58ef0f4fca361 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -179,7 +179,7 @@ int __must_check submit_one_bio(struct bio *bio, int mirror_num,
 					    bio_flags);
 	else
 		ret = btrfs_submit_metadata_bio(tree->private_data, bio,
-						mirror_num, bio_flags);
+						mirror_num);
 
 	if (ret) {
 		bio->bi_status = ret;
-- 
2.30.2

