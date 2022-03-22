Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303164E43A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbiCVP7Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238917AbiCVP7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:59:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEC770F7F;
        Tue, 22 Mar 2022 08:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mgc29LJWUNT84c1SGoA7HiuwDbrLHq22OoME3RV8egw=; b=104L7H+2vLiimPL1Ciu9VMT+lx
        mq/9TSxNPClcj30TH1Slt4zXUF/vPop45CT1KOWpBlP0thLUGaqJiyH78CaL/nPrRtHS6I1FwfuqR
        cQtiNVGHNUGfuX5nLP0ycTsqxoyAPVxLKg+Wbb9tLhKdwQm4ClZlk23U1DKlHAD+BjCDQrwfmoXSm
        ZJoBnnc0ARhtTEKORmxvUIvAevFfmF+BgW2LyDQ4WLrpd5PwKhhqRXed0Hj7piCkd2Hil4Fmugfsf
        GnSpKePpmRF47KGekYMXuhCgWuNR+hjnPF6tq1xYJSfXEmY48iVqrtzSI0FfN0XtU0im8vIaLsyaB
        Af0ySYaQ==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgtB-00Bb8M-Jn; Tue, 22 Mar 2022 15:57:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 36/40] btrfs: implement ->iomap_iter
Date:   Tue, 22 Mar 2022 16:56:02 +0100
Message-Id: <20220322155606.1267165-37-hch@lst.de>
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

Switch from the separate ->iomap_begin and ->iomap_end methods to
->iomap_iter to allow or greater control over the iteration in subsequent
patches.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 69 ++++++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index adcd392caa78e..d4faed31d36a4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7507,17 +7507,18 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	return ret;
 }
 
-static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
-		loff_t length, unsigned int flags, struct iomap *iomap,
-		struct iomap *srcmap)
+static int btrfs_dio_iomap_begin(struct iomap_iter *iter)
 {
-	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
+	struct inode *inode = iter->inode;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	loff_t start = iter->pos;
+	loff_t length = iter->len;
+	struct iomap *iomap = &iter->iomap;
 	struct extent_map *em;
 	struct extent_state *cached_state = NULL;
 	struct btrfs_dio_data *dio_data = iter->private;
 	u64 lockstart, lockend;
-	const bool write = !!(flags & IOMAP_WRITE);
+	bool write = (iter->flags & IOMAP_WRITE);
 	int ret = 0;
 	u64 len = length;
 	bool unlock_extents = false;
@@ -7602,7 +7603,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	 * which we return back to our caller - we should only return EIOCBQUEUED
 	 * after we have submitted bios for all the extents in the range.
 	 */
-	if ((flags & IOMAP_NOWAIT) && len < length) {
+	if ((iter->flags & IOMAP_NOWAIT) && len < length) {
 		free_extent_map(em);
 		ret = -EAGAIN;
 		goto unlock_err;
@@ -7662,30 +7663,28 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	return ret;
 }
 
-static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
-		ssize_t written, unsigned int flags, struct iomap *iomap)
+static int btrfs_dio_iomap_end(struct iomap_iter *iter)
 {
-	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
 	struct btrfs_dio_data *dio_data = iter->private;
-	size_t submitted = dio_data->submitted;
-	const bool write = !!(flags & IOMAP_WRITE);
+	struct btrfs_inode *bi = BTRFS_I(iter->inode);
+	bool write = (iter->flags & IOMAP_WRITE);
+	loff_t length = iomap_length(iter);
+	loff_t pos = iter->pos;
 	int ret = 0;
 
-	if (!write && (iomap->type == IOMAP_HOLE)) {
+	if (!write && iter->iomap.type == IOMAP_HOLE) {
 		/* If reading from a hole, unlock and return */
-		unlock_extent(&BTRFS_I(inode)->io_tree, pos, pos + length - 1);
+		unlock_extent(&bi->io_tree, pos, pos + length - 1);
 		return 0;
 	}
 
-	if (submitted < length) {
-		pos += submitted;
-		length -= submitted;
+	if (dio_data->submitted < length) {
+		pos += dio_data->submitted;
+		length -= dio_data->submitted;
 		if (write)
-			__endio_write_update_ordered(BTRFS_I(inode), pos,
-					length, false);
+			__endio_write_update_ordered(bi, pos, length, false);
 		else
-			unlock_extent(&BTRFS_I(inode)->io_tree, pos,
-				      pos + length - 1);
+			unlock_extent(&bi->io_tree, pos, pos + length - 1);
 		ret = -ENOTBLK;
 	}
 
@@ -7694,6 +7693,31 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return ret;
 }
 
+static int btrfs_dio_iomap_iter(struct iomap_iter *iter)
+{
+	int ret;
+
+	if (iter->iomap.length) {
+		ret = btrfs_dio_iomap_end(iter);
+		if (ret < 0 && !iter->processed)
+			return ret;
+	}
+
+	ret = iomap_iter_advance(iter);
+	if (ret <= 0)
+		return ret;
+
+	ret = btrfs_dio_iomap_begin(iter);
+	if (ret < 0)
+		return ret;
+	iomap_iter_done(iter);
+	return 1;
+}
+
+static const struct iomap_ops btrfs_dio_iomap_ops = {
+	.iomap_iter		= btrfs_dio_iomap_iter,
+};
+
 static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 {
 	/*
@@ -8039,11 +8063,6 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 	btrfs_dio_private_put(dip);
 }
 
-static const struct iomap_ops btrfs_dio_iomap_ops = {
-	.iomap_begin            = btrfs_dio_iomap_begin,
-	.iomap_end              = btrfs_dio_iomap_end,
-};
-
 static const struct iomap_dio_ops btrfs_dio_ops = {
 	.submit_io		= btrfs_submit_direct,
 };
-- 
2.30.2

