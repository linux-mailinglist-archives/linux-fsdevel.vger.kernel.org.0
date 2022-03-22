Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7F14E438F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238820AbiCVP6f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbiCVP60 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:58:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14A36D946;
        Tue, 22 Mar 2022 08:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Q9lfuDCPbLxLEucc5zZDFsFgzwcZnYjDJWCOE0jxGz4=; b=lVG9KxTp7qVPl99kG0OOKEITNS
        IiERR2Wy+dzvhYwgs89z3h7mneD7rY1dHpkI+0yqml8q4D4zQURAlbMs8U2mvdLHAVq9SMiK/jgGu
        7PR2xDI9kWmgvm2gN0L+pnUbl+Ax2FWCu4FafQr5hR1hGC/tVtLCbXcks0+2ZwmCrp3USrETJiIUs
        +lTbwx+W+1GmK+/qNp76SIhacc3e+WawiHzgndO+bf8DMFMD6KbOOBTP9lpzKtvJpChbxg0sFX79F
        0Z4HNKRjoDR5eLwTcf2/z2pBJWV8il5kysBlIdbP7xHSaCAFJm5FTCg1lO1j+Nj5RYit0fwmCMYmL
        LtX918GQ==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgsO-00Banj-NK; Tue, 22 Mar 2022 15:56:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 17/40] btrfs: remove the submit_bio_hook argument to submit_read_repair
Date:   Tue, 22 Mar 2022 16:55:43 +0100
Message-Id: <20220322155606.1267165-18-hch@lst.de>
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

submit_bio_hooks is always set to btrfs_submit_data_bio, so just remove
it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 88d3a46e89a51..238252f86d5ad 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2721,8 +2721,7 @@ static blk_status_t submit_read_repair(struct inode *inode,
 				      struct bio *failed_bio, u32 bio_offset,
 				      struct page *page, unsigned int pgoff,
 				      u64 start, u64 end, int failed_mirror,
-				      unsigned int error_bitmap,
-				      submit_bio_hook_t *submit_bio_hook)
+				      unsigned int error_bitmap)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	const u32 sectorsize = fs_info->sectorsize;
@@ -2760,7 +2759,7 @@ static blk_status_t submit_read_repair(struct inode *inode,
 		ret = btrfs_repair_one_sector(inode, failed_bio,
 				bio_offset + offset,
 				page, pgoff + offset, start + offset,
-				failed_mirror, submit_bio_hook);
+				failed_mirror, btrfs_submit_data_bio);
 		if (!ret) {
 			/*
 			 * We have submitted the read repair, the page release
@@ -3075,8 +3074,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 			 */
 			submit_read_repair(inode, bio, bio_offset, page,
 					   start - page_offset(page), start,
-					   end, mirror, error_bitmap,
-					   btrfs_submit_data_bio);
+					   end, mirror, error_bitmap);
 
 			ASSERT(bio_offset + len > bio_offset);
 			bio_offset += len;
-- 
2.30.2

