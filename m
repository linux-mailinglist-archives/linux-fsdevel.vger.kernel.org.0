Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D602251A571
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 18:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353412AbiEDQ1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 12:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353395AbiEDQ11 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 12:27:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567F34617E;
        Wed,  4 May 2022 09:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=P59pyQBqBoF17d2W6JJgn//aSw8c2p3w7OtvRpfEhsQ=; b=COYWQjJcNP9HMTXTKeN4Fl5rLf
        qMMUlC7kox0OnEihMCI4DSG9D294Kik6ZGKkSyjE8mgfUS/pftaUY6Ah7kKMO8OpfmJws46iqZG2I
        x9SYfbomKduQ6a3RZuT/Xtth7w92iymPwNv2gaMiNnR5WiKpqW3Jkl4lNE1qkZwXbpiEf8gXQG/oa
        WIPzmspHnwWaE1s5YIJRe28d/A1bZUdQJYk2GwzYHfY/FCa6omkmoorcrVIT0DxI53+Ic9X4GcWRf
        mj3d+VAwoRZW5HycNdTfLlzuoYWkBz4XGM3kum+F4Ug9RhHpTy+oNAL7MFRfti9twe26SmNKgs+XG
        ZMGb9BMg==;
Received: from [8.34.116.185] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmHn0-00BeE4-2A; Wed, 04 May 2022 16:23:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/5] btrfs: allocate dio_data on stack
Date:   Wed,  4 May 2022 09:23:41 -0700
Message-Id: <20220504162342.573651-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220504162342.573651-1-hch@lst.de>
References: <20220504162342.573651-1-hch@lst.de>
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

Make use of the new iomap_iter->private field to avoid a memory
allocation per iomap range.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cdf96a2472821..6ecff32c1fc22 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7546,10 +7546,11 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 		loff_t length, unsigned int flags, struct iomap *iomap,
 		struct iomap *srcmap)
 {
+	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map *em;
 	struct extent_state *cached_state = NULL;
-	struct btrfs_dio_data *dio_data = NULL;
+	struct btrfs_dio_data *dio_data = iter->private;
 	u64 lockstart, lockend;
 	const bool write = !!(flags & IOMAP_WRITE);
 	int ret = 0;
@@ -7595,17 +7596,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 		}
 	}
 
-	if (flags & IOMAP_NOWAIT) {
-		dio_data = kzalloc(sizeof(*dio_data), GFP_NOWAIT);
-		if (!dio_data)
-			return -EAGAIN;
-	} else {
-		dio_data = kzalloc(sizeof(*dio_data), GFP_NOFS);
-		if (!dio_data)
-			return -ENOMEM;
-	}
-
-	iomap->private = dio_data;
+	memset(dio_data, 0, sizeof(*dio_data));
 
 	/*
 	 * We always try to allocate data space and must do it before locking
@@ -7769,23 +7760,22 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 		extent_changeset_free(dio_data->data_reserved);
 	}
 
-	kfree(dio_data);
-
 	return ret;
 }
 
 static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		ssize_t written, unsigned int flags, struct iomap *iomap)
 {
-	int ret = 0;
-	struct btrfs_dio_data *dio_data = iomap->private;
+	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
+	struct btrfs_dio_data *dio_data = iter->private;
 	size_t submitted = dio_data->submitted;
 	const bool write = !!(flags & IOMAP_WRITE);
+	int ret = 0;
 
 	if (!write && (iomap->type == IOMAP_HOLE)) {
 		/* If reading from a hole, unlock and return */
 		unlock_extent(&BTRFS_I(inode)->io_tree, pos, pos + length - 1);
-		goto out;
+		return 0;
 	}
 
 	if (submitted < length) {
@@ -7802,10 +7792,6 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 
 	if (write)
 		extent_changeset_free(dio_data->data_reserved);
-out:
-	kfree(dio_data);
-	iomap->private = NULL;
-
 	return ret;
 }
 
@@ -8041,7 +8027,7 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 	int ret;
 	blk_status_t status;
 	struct btrfs_io_geometry geom;
-	struct btrfs_dio_data *dio_data = iter->iomap.private;
+	struct btrfs_dio_data *dio_data = iter->private;
 	struct extent_map *em = NULL;
 
 	dip = btrfs_create_dio_private(dio_bio, inode, file_offset);
@@ -8167,6 +8153,9 @@ static const struct iomap_dio_ops btrfs_dio_ops = {
 ssize_t btrfs_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		size_t done_before)
 {
+	struct btrfs_dio_data data;
+
+	iocb->private = &data;
 	return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
 			   IOMAP_DIO_PARTIAL, done_before);
 }
-- 
2.30.2

