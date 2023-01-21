Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59043676453
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjAUGvK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjAUGvD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:51:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E990676FD;
        Fri, 20 Jan 2023 22:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=a62JE7EP9Bdj4j9gkWkXC98yRjn28j3glbZ5JsSIiw8=; b=ZMDOwyV9fp8+0t0fLbnfBkpRb4
        j4gTEdgJ0ZWpwCQQI71nYbSNo4ARtSJuy2Xc9kGKe/GkIxgHWlj6feluzld9eGWEVeF2husTCaF20
        N8X/3l2c4ArjZ8KqAXBWSJXyCFHRfnxL5V0Piebp7EgU/F/E5QBne0E/w2kBILSe3G/pdpPbDBTQ/
        sD8skctw4N36G3wjxzWLBN542hweF+IYgpbW1zfuhxZwUGZV/Rl2O2cG8oCv8z5STF2G22HVaMHZr
        vkO2hbM1QLJ1yOOs1TEi65sLIjgLCtvm+2rP4Iw54u/lPQrpr8GaLcR1cd8s6Lj3Y6ffPCTmLAD/e
        b/soAS4w==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7iL-00DRLI-EF; Sat, 21 Jan 2023 06:50:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/34] btrfs: add a btrfs_data_csum_ok helper
Date:   Sat, 21 Jan 2023 07:50:06 +0100
Message-Id: <20230121065031.1139353-10-hch@lst.de>
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

Add a new checksumming helper that wraps btrfs_check_data_csum and
does all the checks to if we're dealing with some form of nodatacsum
I/O.  This helper will be used by the new storage layer checksum
validation and repair code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/btrfs_inode.h |  2 ++
 fs/btrfs/inode.c       | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 195c09e20609e4..3faabcef9898fb 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -423,6 +423,8 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
 int btrfs_check_data_csum(struct btrfs_inode *inode, struct btrfs_bio *bbio,
 			  u32 bio_offset, struct page *page, u32 pgoff);
+bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
+			u32 bio_offset, struct bio_vec *bv);
 unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
 				    u32 bio_offset, struct page *page,
 				    u64 start, u64 end);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 598897b0d661da..12b76d272f08d5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3495,6 +3495,45 @@ int btrfs_check_data_csum(struct btrfs_inode *inode, struct btrfs_bio *bbio,
 	return -EIO;
 }
 
+/*
+ * btrfs_data_csum_ok - verify the checksum of single data sector
+ * @bbio:	btrfs_io_bio which contains the csum
+ * @dev:	device the sector is on
+ * @bio_offset:	offset to the beginning of the bio (in bytes)
+ * @bv:		bio_vec to check
+ *
+ * Check if the checksum on a data block is valid.  When a checksum mismatch is
+ * detected, report the error and fill the corrupted range with zero.
+ *
+ * Return %true if the sector is ok or had no checksum to start with, else
+ * %false.
+ */
+bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
+			u32 bio_offset, struct bio_vec *bv)
+{
+	struct btrfs_inode *inode = bbio->inode;
+	u64 file_offset = bbio->file_offset + bio_offset;
+	u64 end = file_offset + bv->bv_len - 1;
+
+	if (!bbio->csum)
+		return true;
+
+	if (btrfs_is_data_reloc_root(inode->root) &&
+	    test_range_bit(&inode->io_tree, file_offset, end, EXTENT_NODATASUM,
+			1, NULL)) {
+		/* Skip the range without csum for data reloc inode */
+		clear_extent_bits(&inode->io_tree, file_offset, end,
+				  EXTENT_NODATASUM);
+		return true;
+	}
+
+	if (btrfs_check_data_csum(inode, bbio, bio_offset, bv->bv_page,
+				  bv->bv_offset) < 0)
+		return false;
+	return true;
+}
+
+
 /*
  * When reads are done, we need to check csums to verify the data is correct.
  * if there's a match, we allow the bio to finish.  If not, the code in
-- 
2.39.0

