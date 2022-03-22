Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AC84E43B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbiCVP7l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238925AbiCVP7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:59:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457FA716ED;
        Tue, 22 Mar 2022 08:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Cagx/Sk4Rmng/z7z47yDROdu0HaigUyROtB41dmD178=; b=yJ6lMKipqfPCv4Zf61WyW12VjZ
        Wp/7hwC/HBU0e/Gqpgt/m2kVr9cJJhApEONnc2VK0rL+tZC4z291osvu/XOwO2DtIB+ubHQWRdDZ2
        a/5X5p6xn3de3XURS1yRG8wZJ2lPYC/Y48TxBvzQHz5jHALpSdJsIv36aofGe4bUz9drxIBF3e0fZ
        PSGUCw6B/IYimpORBfpnBdXGeXzjM+/MxW4J5VaK/N64fglMgIbBiqCPl1T+JASPwnp33nopsYK+7
        QAT76N25P0iCBlye8C84EUxvV0SYPmwXiYpfqXe0VZpqe2p8i/lJ82r8tYpWhM98mGaWfP+chiC4C
        3cEYPvcA==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgtG-00BbAJ-Ot; Tue, 22 Mar 2022 15:57:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 38/40] btrfs: return a blk_status_t from btrfs_repair_one_sector
Date:   Tue, 22 Mar 2022 16:56:04 +0100
Message-Id: <20220322155606.1267165-39-hch@lst.de>
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

This is what the submit hook returns and what the callers want anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 14 +++++++-------
 fs/btrfs/extent_io.h |  2 +-
 fs/btrfs/inode.c     |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 10fc5e4dd14a3..2fdb5d7dd51e1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2626,7 +2626,7 @@ static bool btrfs_check_repairable(struct inode *inode,
 	return true;
 }
 
-int btrfs_repair_one_sector(struct inode *inode,
+blk_status_t btrfs_repair_one_sector(struct inode *inode,
 			    struct bio *failed_bio, u32 bio_offset,
 			    struct page *page, unsigned int pgoff,
 			    u64 start, int failed_mirror,
@@ -2649,12 +2649,12 @@ int btrfs_repair_one_sector(struct inode *inode,
 
 	failrec = btrfs_get_io_failure_record(inode, start);
 	if (IS_ERR(failrec))
-		return PTR_ERR(failrec);
+		return errno_to_blk_status(PTR_ERR(failrec));
 
 
 	if (!btrfs_check_repairable(inode, failrec, failed_mirror)) {
 		free_io_failure(failure_tree, tree, failrec);
-		return -EIO;
+		return BLK_STS_IOERR;
 	}
 
 	repair_bio = btrfs_bio_alloc(inode, 1, REQ_OP_READ);
@@ -2685,7 +2685,7 @@ int btrfs_repair_one_sector(struct inode *inode,
 		free_io_failure(failure_tree, tree, failrec);
 		bio_put(repair_bio);
 	}
-	return blk_status_to_errno(status);
+	return status;
 }
 
 static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
@@ -2725,7 +2725,7 @@ static blk_status_t submit_read_repair(struct inode *inode,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	const u32 sectorsize = fs_info->sectorsize;
 	const int nr_bits = (end + 1 - start) >> fs_info->sectorsize_bits;
-	int error = 0;
+	blk_status_t error = BLK_STS_OK;
 	int i;
 
 	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
@@ -2744,7 +2744,7 @@ static blk_status_t submit_read_repair(struct inode *inode,
 		const unsigned int offset = i * sectorsize;
 		struct extent_state *cached = NULL;
 		bool uptodate = false;
-		int ret;
+		blk_status_t ret;
 
 		if (!(error_bitmap & (1U << i))) {
 			/*
@@ -2786,7 +2786,7 @@ static blk_status_t submit_read_repair(struct inode *inode,
 				start + offset + sectorsize - 1,
 				&cached);
 	}
-	return errno_to_blk_status(error);
+	return error;
 }
 
 /* lots and lots of room for performance fixes in the end_bio funcs */
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 3f0cb1ef5fdff..0239b26d5170a 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -303,7 +303,7 @@ struct io_failure_record {
 	int failed_mirror;
 };
 
-int btrfs_repair_one_sector(struct inode *inode,
+blk_status_t btrfs_repair_one_sector(struct inode *inode,
 			    struct bio *failed_bio, u32 bio_offset,
 			    struct page *page, unsigned int pgoff,
 			    u64 start, int failed_mirror,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3f7e1779ff19f..93b3ef48cea2f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7794,14 +7794,14 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 						 btrfs_ino(BTRFS_I(inode)),
 						 pgoff);
 			} else {
-				int ret;
+				blk_status_t ret;
 
 				ret = btrfs_repair_one_sector(inode, &bbio->bio,
 						bio_offset, bvec.bv_page, pgoff,
 						start, bbio->mirror_num,
 						submit_dio_repair_bio);
 				if (ret)
-					err = errno_to_blk_status(ret);
+					err = ret;
 			}
 			ASSERT(bio_offset + sectorsize > bio_offset);
 			bio_offset += sectorsize;
-- 
2.30.2

