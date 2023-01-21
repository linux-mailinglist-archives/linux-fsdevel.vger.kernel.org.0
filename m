Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C030F67646C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjAUGvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjAUGvd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:51:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E6D72C32;
        Fri, 20 Jan 2023 22:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kTYNBgj9gvbB1HVzJPo+/gfmuZU4+C4tyJ/feOtZM64=; b=Va/lDg5O7bRF3Rgl1YCbnMCb/D
        TEylyx3uJO3vv1Z8rkiS2WFewuNV3qMEzFu13ynwiW3YGFdeToQnn8TnKAdznlIAcAS5xi2aeJFUf
        ZsOUg9WBQyQK1AJSlQLI3DL0d28KA0mDhf5UGgfsGKMN+9o9klbC/m4gRUHkjj4rfdrqhnGTXc/cG
        nnEuJgdb5r7Tjzeq3KNybhh1DO1RpPtvW1yr/wxwdx1Iup6k6uMt+G3aKTjl2TW2zHLW3OigkCZ9e
        I5Av7/ojrqQGFl6pis6/JTPLF8wj6WTDOiSJUi3yWb8nluOmN9IbLa1ifrqF7aqorkJh9NAgnhl+V
        IbDluBdA==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7ig-00DRVZ-Uh; Sat, 21 Jan 2023 06:51:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 17/34] btrfs: remove the is_metadata flag in struct btrfs_bio
Date:   Sat, 21 Jan 2023 07:50:14 +0100
Message-Id: <20230121065031.1139353-18-hch@lst.de>
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

This flag is unused now, so remove it.  Re-expand the mirror_num field
to 8 bits, and move it to the I/O completion internal section of the
structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.h     | 11 +----------
 fs/btrfs/disk-io.c |  1 -
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index c232148348dfe3..a96bcb3f36f684 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -30,16 +30,6 @@ typedef void (*btrfs_bio_end_io_t)(struct btrfs_bio *bbio);
  * passed to btrfs_submit_bio for mapping to the physical devices.
  */
 struct btrfs_bio {
-	unsigned int mirror_num:7;
-
-	/*
-	 * Extra indicator for metadata bios.
-	 * For some btrfs bios they use pages without a mapping, thus
-	 * we can not rely on page->mapping->host to determine if
-	 * it's a metadata bio.
-	 */
-	unsigned int is_metadata:1;
-
 	/* Inode and offset into it that this I/O operates on. */
 	struct btrfs_inode *inode;
 	u64 file_offset;
@@ -64,6 +54,7 @@ struct btrfs_bio {
 	void *private;
 
 	/* For internal use in read end I/O handling */
+	unsigned int mirror_num;
 	struct work_struct end_io_work;
 
 	/*
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a6f89ac1c0865c..5a8ca6a518cf62 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -846,7 +846,6 @@ void btrfs_submit_metadata_bio(struct btrfs_inode *inode, struct bio *bio, int m
 	blk_status_t ret;
 
 	bio->bi_opf |= REQ_META;
-	bbio->is_metadata = 1;
 
 	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
 		btrfs_submit_bio(fs_info, bio, mirror_num);
-- 
2.39.0

