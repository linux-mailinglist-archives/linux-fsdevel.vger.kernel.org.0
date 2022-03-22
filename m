Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD2A4E43BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238890AbiCVP7j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238926AbiCVP7T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:59:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895C96EB33;
        Tue, 22 Mar 2022 08:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Ibq6QXURVroz/FPeSJL08xoB5jB/cwDA8IOnXIdIZkE=; b=1yw1pcHFZcjw9Or6DrYJOtQFUX
        IMf6Ivnnb9gUScFI2aoAjbV1I4iWYRT1sEC0/Ub2VgmRRTOEQN96v+81Hn6n5aQM6/8ZTL00d1gHu
        DvCuSJvB6OBBTXiF4gjXiiBcCOQxeSnEWHjaDxS3J8abAHDApflvFesdHY+TSpDdJNE0nTohq2pxz
        trYP+3RKYq153X2fa3lED0bZEC0/oBjI8AO6J36Xa7EgCNPe6OueytIaAAg3yNGQspWX6EPLeqYHw
        cZkqciRegkldAzy1QqTzjmzGOvURyiHIKc81qK+bozQCmE4805Z6AhDYfx633ymi8VxAt78rvHM65
        wHIDXM1A==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgtJ-00BbB9-98; Tue, 22 Mar 2022 15:57:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 39/40] btrfs: pass private data end end_io handler to btrfs_repair_one_sector
Date:   Tue, 22 Mar 2022 16:56:05 +0100
Message-Id: <20220322155606.1267165-40-hch@lst.de>
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

Allow the caller to control what happens when the repair bio completes.
This will be needed streamline the direct I/O path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 15 ++++++++-------
 fs/btrfs/extent_io.h |  8 ++++----
 fs/btrfs/inode.c     |  4 +++-
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2fdb5d7dd51e1..5a1447db28228 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2627,10 +2627,10 @@ static bool btrfs_check_repairable(struct inode *inode,
 }
 
 blk_status_t btrfs_repair_one_sector(struct inode *inode,
-			    struct bio *failed_bio, u32 bio_offset,
-			    struct page *page, unsigned int pgoff,
-			    u64 start, int failed_mirror,
-			    submit_bio_hook_t *submit_bio_hook)
+		struct bio *failed_bio, u32 bio_offset, struct page *page,
+		unsigned int pgoff, u64 start, int failed_mirror,
+		submit_bio_hook_t *submit_bio_hook,
+		void *bi_private, void (*bi_end_io)(struct bio *bio))
 {
 	struct io_failure_record *failrec;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -2660,9 +2660,9 @@ blk_status_t btrfs_repair_one_sector(struct inode *inode,
 	repair_bio = btrfs_bio_alloc(inode, 1, REQ_OP_READ);
 	repair_bbio = btrfs_bio(repair_bio);
 	repair_bbio->file_offset = start;
-	repair_bio->bi_end_io = failed_bio->bi_end_io;
 	repair_bio->bi_iter.bi_sector = failrec->logical >> 9;
-	repair_bio->bi_private = failed_bio->bi_private;
+	repair_bio->bi_private = bi_private;
+	repair_bio->bi_end_io = bi_end_io;
 
 	if (failed_bbio->csum) {
 		const u32 csum_size = fs_info->csum_size;
@@ -2758,7 +2758,8 @@ static blk_status_t submit_read_repair(struct inode *inode,
 		ret = btrfs_repair_one_sector(inode, failed_bio,
 				bio_offset + offset,
 				page, pgoff + offset, start + offset,
-				failed_mirror, btrfs_submit_data_bio);
+				failed_mirror, btrfs_submit_data_bio,
+				failed_bio->bi_private, failed_bio->bi_end_io);
 		if (!ret) {
 			/*
 			 * We have submitted the read repair, the page release
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 0239b26d5170a..54e54269cfdba 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -304,10 +304,10 @@ struct io_failure_record {
 };
 
 blk_status_t btrfs_repair_one_sector(struct inode *inode,
-			    struct bio *failed_bio, u32 bio_offset,
-			    struct page *page, unsigned int pgoff,
-			    u64 start, int failed_mirror,
-			    submit_bio_hook_t *submit_bio_hook);
+		struct bio *failed_bio, u32 bio_offset, struct page *page,
+		unsigned int pgoff, u64 start, int failed_mirror,
+		submit_bio_hook_t *submit_bio_hook,
+		void *bi_private, void (*bi_end_io)(struct bio *bio));
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 bool find_lock_delalloc_range(struct inode *inode,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 93b3ef48cea2f..e25d9d860c679 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7799,7 +7799,9 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 				ret = btrfs_repair_one_sector(inode, &bbio->bio,
 						bio_offset, bvec.bv_page, pgoff,
 						start, bbio->mirror_num,
-						submit_dio_repair_bio);
+						submit_dio_repair_bio,
+						bbio->bio.bi_private,
+						bbio->bio.bi_end_io);
 				if (ret)
 					err = ret;
 			}
-- 
2.30.2

