Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8764E4399
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238858AbiCVP6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238874AbiCVP6h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:58:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2386E78E;
        Tue, 22 Mar 2022 08:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4UxaZPb00R8Sj3xNXNP2gocttdDvhdz2pSlEQ5Lx12Q=; b=K3iydrV9W0y9z/RdBWZ29njfu3
        LsA4GKNLQ4whtbI2MVqxA0RRBQ89SSdvKpuh7YEJMejqsnVAKUoykKpYqg6zderJg/9dqMfwHfuUl
        iBaH/JgCTwHTM++edtsej+i0djZHzu0XC2YKc6GqmY7lcBQ2uq3xzTO3cUDWKJxBvnivwr6i2K9Zj
        wMUNs+DbpvIiKFIqlLkzBozFc6GufYwT+kYXFgFCypx/djz822JZ/o1furnN3qUQtXaFGykNOzv80
        yO/IBeMlZmJU1FmqsNt5MYY8bSc/VQkLmw64i8JKkHrnL+i+XuUMwRnPXd9tdVfjcJI69B0brC5Fn
        ybu4ThGw==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgsb-00Basj-Kk; Tue, 22 Mar 2022 15:57:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 22/40] btrfs: cleanup btrfs_submit_dio_bio
Date:   Tue, 22 Mar 2022 16:55:48 +0100
Message-Id: <20220322155606.1267165-23-hch@lst.de>
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

Remove the pointless goto just to return err and clean up the code flow
to be a little more straight forward.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 59 ++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a54b7fd4658d0..5c9d8e8a98466 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7844,47 +7844,42 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		struct inode *inode, u64 file_offset, int async_submit)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_inode *bi = BTRFS_I(inode);
 	struct btrfs_dio_private *dip = bio->bi_private;
-	bool write = btrfs_op(bio) == BTRFS_MAP_WRITE;
 	blk_status_t ret;
 
-	/* Check btrfs_submit_bio_hook() for rules about async submit. */
-	if (async_submit)
-		async_submit = !atomic_read(&BTRFS_I(inode)->sync_writers);
+	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
+		if (!(bi->flags & BTRFS_INODE_NODATASUM)) {
+			/* See btrfs_submit_data_bio for async submit rules */
+			if (async_submit && !atomic_read(&bi->sync_writers))
+				return btrfs_wq_submit_bio(inode, bio, 0, 0,
+					file_offset,
+					btrfs_submit_bio_start_direct_io);
 
-	if (!write) {
+			/*
+			 * If we aren't doing async submit, calculate the csum of the
+			 * bio now.
+			 */
+			ret = btrfs_csum_one_bio(bi, bio, file_offset, 1);
+			if (ret)
+				return ret;
+		}
+	} else {
 		ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
 		if (ret)
-			goto err;
-	}
-
-	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
-		goto map;
+			return ret;
 
-	if (write && async_submit) {
-		ret = btrfs_wq_submit_bio(inode, bio, 0, 0, file_offset,
-					  btrfs_submit_bio_start_direct_io);
-		goto err;
-	} else if (write) {
-		/*
-		 * If we aren't doing async submit, calculate the csum of the
-		 * bio now.
-		 */
-		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, file_offset, 1);
-		if (ret)
-			goto err;
-	} else {
-		u64 csum_offset;
+		if (!(bi->flags & BTRFS_INODE_NODATASUM)) {
+			u64 csum_offset;
 
-		csum_offset = file_offset - dip->file_offset;
-		csum_offset >>= fs_info->sectorsize_bits;
-		csum_offset *= fs_info->csum_size;
-		btrfs_bio(bio)->csum = dip->csums + csum_offset;
+			csum_offset = file_offset - dip->file_offset;
+			csum_offset >>= fs_info->sectorsize_bits;
+			csum_offset *= fs_info->csum_size;
+			btrfs_bio(bio)->csum = dip->csums + csum_offset;
+		}
 	}
-map:
-	ret = btrfs_map_bio(fs_info, bio, 0);
-err:
-	return ret;
+
+	return btrfs_map_bio(fs_info, bio, 0);
 }
 
 /*
-- 
2.30.2

