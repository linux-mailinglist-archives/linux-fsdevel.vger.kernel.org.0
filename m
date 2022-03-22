Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AEB4E4396
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbiCVP6n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238795AbiCVP6f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:58:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA886D959;
        Tue, 22 Mar 2022 08:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ik896SM15cBFFrcSr02Qjkcxw7YRxIqbkmqoQS+DrXE=; b=HfygAPlgDTGffr49CZveobTuuJ
        5BeVs3Ek1nhL7RQ2L60JvG/aLX9b1tnWyqFwWjqyjQvldERPImlWtZi6JjtVL6bXyzuJ0uYXPuJyp
        H4VD8vMRg/XkiT7aUxWkmomciMJhQx/S/Eu3/igbh8h8qxeI9AzEdZ9Kqu7JvdMBssEYkRy9AwQdB
        sgvq+tp4xd7NpLOA1R92TMoPNmkFqMhZ4Yse3B5ii/QGFI6skUQQ2NBGCAcp9WYRO7QFMQpAfV6i7
        i1vbAoTev4Ebt/lvUrx0Y+l/1373wCkfGhN/aXxiRWO7OdzFzJ0wnB/bvpwHzFF8OIyplMpUhlmAt
        Dq9dPMAA==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgsZ-00Bar6-24; Tue, 22 Mar 2022 15:57:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 21/40] btrfs: cleanup btrfs_submit_data_bio
Date:   Tue, 22 Mar 2022 16:55:47 +0100
Message-Id: <20220322155606.1267165-22-hch@lst.de>
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

Clean up the code flow to be straight forward.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 85 +++++++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 48 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 325e773c6e880..a54b7fd4658d0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2511,67 +2511,56 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_root *root = BTRFS_I(inode)->root;
-	enum btrfs_wq_endio_type metadata = BTRFS_WQ_ENDIO_DATA;
-	blk_status_t ret = 0;
-	int skip_sum;
-	int async = !atomic_read(&BTRFS_I(inode)->sync_writers);
-
-	skip_sum = (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM) ||
-		test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
-
-	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
-		metadata = BTRFS_WQ_ENDIO_FREE_SPACE;
+	struct btrfs_inode *bi = BTRFS_I(inode);
+	blk_status_t ret;
 
 	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-		struct page *page = bio_first_bvec_all(bio)->bv_page;
-		loff_t file_offset = page_offset(page);
-
-		ret = extract_ordered_extent(BTRFS_I(inode), bio, file_offset);
+		ret = extract_ordered_extent(bi, bio,
+				page_offset(bio_first_bvec_all(bio)->bv_page));
 		if (ret)
-			goto out;
+			return ret;
 	}
 
-	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
+	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
+		if ((bi->flags & BTRFS_INODE_NODATASUM) ||
+		    test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state))
+			goto mapit;
+
+		if (!atomic_read(&bi->sync_writers)) {
+			/* csum items have already been cloned */
+			if (btrfs_is_data_reloc_root(bi->root))
+				goto mapit;
+			return btrfs_wq_submit_bio(inode, bio, mirror_num, bio_flags,
+						  0, btrfs_submit_bio_start);
+		}
+		ret = btrfs_csum_one_bio(bi, bio, 0, 0);
+		if (ret)
+			return ret;
+	} else {
+		enum btrfs_wq_endio_type metadata = BTRFS_WQ_ENDIO_DATA;
+
+		if (btrfs_is_free_space_inode(bi))
+			metadata = BTRFS_WQ_ENDIO_FREE_SPACE;
+
 		ret = btrfs_bio_wq_end_io(fs_info, bio, metadata);
 		if (ret)
-			goto out;
+			return ret;
 
-		if (bio_flags & EXTENT_BIO_COMPRESSED) {
-			ret = btrfs_submit_compressed_read(inode, bio,
+		if (bio_flags & EXTENT_BIO_COMPRESSED)
+			return btrfs_submit_compressed_read(inode, bio,
 							   mirror_num,
 							   bio_flags);
-			goto out;
-		} else {
-			/*
-			 * Lookup bio sums does extra checks around whether we
-			 * need to csum or not, which is why we ignore skip_sum
-			 * here.
-			 */
-			ret = btrfs_lookup_bio_sums(inode, bio, NULL);
-			if (ret)
-				goto out;
-		}
-		goto mapit;
-	} else if (async && !skip_sum) {
-		/* csum items have already been cloned */
-		if (btrfs_is_data_reloc_root(root))
-			goto mapit;
-		/* we're doing a write, do the async checksumming */
-		ret = btrfs_wq_submit_bio(inode, bio, mirror_num, bio_flags,
-					  0, btrfs_submit_bio_start);
-		goto out;
-	} else if (!skip_sum) {
-		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
+
+		/*
+		 * Lookup bio sums does extra checks around whether we need to
+		 * csum or not, which is why we ignore skip_sum here.
+		 */
+		ret = btrfs_lookup_bio_sums(inode, bio, NULL);
 		if (ret)
-			goto out;
+			return ret;
 	}
-
 mapit:
-	ret = btrfs_map_bio(fs_info, bio, mirror_num);
-
-out:
-	return ret;
+	return btrfs_map_bio(fs_info, bio, mirror_num);
 }
 
 /*
-- 
2.30.2

