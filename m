Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CADA4E43BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238907AbiCVP7a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238814AbiCVP7N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:59:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0044C70CDF;
        Tue, 22 Mar 2022 08:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=O7J+ia8VC1kRcOrLhOm5PzQsQR4Q/vtxVU6MRqEPIlI=; b=gn3rBv1tVBisu4/kTccyOBYr3z
        hbPXbdbDdRMoYE8asjEu32maOvZdpoZWp4Xs0FCdsmEHKz3tfrT9pnbXoog+X9hNJpPgwluUxVsDB
        A1MW0Rh/gRXQG7ndsBfQQr5Hxm45WroChtxcGnggI2yn5Nrc8tOraw9ubZKPETLdnPahC1utlx0eb
        J4q2ArfQoDZBQDYxdjI5HMldz4pgfLJTSaZbM6uZpINKiC8jguNgkLUOZQslphC+C/UXm+PzFIbOI
        3zdHZaLk9wPO/4GMZViKmusLmSrDyjb9HULLdt3R421JQ1A+VXMhp9jb9sU0imQCv6kh3nzvG7XOk
        KBQLlpgQ==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgt9-00Bb7G-0k; Tue, 22 Mar 2022 15:57:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 35/40] btrfs: allocate dio_data on stack
Date:   Tue, 22 Mar 2022 16:56:01 +0100
Message-Id: <20220322155606.1267165-36-hch@lst.de>
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

Make use of the new iomap_iter->private field to avoid a memory
allocation per iomap range.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ab3ff4747266a..adcd392caa78e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7511,10 +7511,11 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
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
@@ -7541,21 +7542,15 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 			return ret;
 	}
 
-	dio_data = kzalloc(sizeof(*dio_data), GFP_NOFS);
-	if (!dio_data)
-		return -ENOMEM;
-
-	iomap->private = dio_data;
-
+	dio_data->submitted = 0;
+	dio_data->data_reserved = NULL;
 
 	/*
 	 * If this errors out it's because we couldn't invalidate pagecache for
 	 * this range and we need to fallback to buffered.
 	 */
-	if (lock_extent_direct(inode, lockstart, lockend, &cached_state, write)) {
-		ret = -ENOTBLK;
-		goto err;
-	}
+	if (lock_extent_direct(inode, lockstart, lockend, &cached_state, write))
+		return -ENOTBLK;
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, len);
 	if (IS_ERR(em)) {
@@ -7664,24 +7659,22 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 unlock_err:
 	unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 			     &cached_state);
-err:
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
@@ -7698,10 +7691,6 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 
 	if (write)
 		extent_changeset_free(dio_data->data_reserved);
-out:
-	kfree(dio_data);
-	iomap->private = NULL;
-
 	return ret;
 }
 
@@ -7935,7 +7924,7 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 	int ret;
 	blk_status_t status;
 	struct btrfs_io_geometry geom;
-	struct btrfs_dio_data *dio_data = iter->iomap.private;
+	struct btrfs_dio_data *dio_data = iter->private;
 	struct extent_map *em = NULL;
 
 	dip = btrfs_create_dio_private(dio_bio, inode, file_offset);
@@ -8062,6 +8051,9 @@ static const struct iomap_dio_ops btrfs_dio_ops = {
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

