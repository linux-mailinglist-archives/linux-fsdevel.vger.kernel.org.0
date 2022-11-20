Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCED631419
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Nov 2022 13:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiKTMsp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Nov 2022 07:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiKTMsQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Nov 2022 07:48:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FFD2DF3;
        Sun, 20 Nov 2022 04:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OLMHROO8U6XeiJ/NjZiZeN1VxLHJmAYSAenizgrNalA=; b=g2yAo65s38jvqnK9xcRX36zE2F
        eRTAY9HUP3gaUXeiCwduEoN+HGw5dVX70Yyb5vhs/NhN0IY3A2CQIe9U5GkJiQNJ9oTHtZmuh80H8
        VOiHdG8/bd/mUq1byBIe1NECJgYrRNlwa55rDvMkY4qUkf0AavmjvWjawVSQW2NfpcVIDDny6qnwY
        5EhkI6Gx+vgcjF2Lt1mcWBW+W4d9pmZRN/IKVAbsg12obNaJOoPpePvHA5JhnvVz4+zEarBzAeCEu
        /0G7s7IYwKo4lE1Iz9EKUzzGWbmc/y+sLl34mPTePVLv7TZ2kNVI4EZ4PMtbtzyIoUhTp9mlewhiV
        dAStuknw==;
Received: from [2001:4bb8:181:6f70:ae5d:6675:76b9:6fc3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1owjk2-004IDB-Tj; Sun, 20 Nov 2022 12:48:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/19] btrfs: remove stripe boundary calculation for encoded I/O
Date:   Sun, 20 Nov 2022 13:47:27 +0100
Message-Id: <20221120124734.18634-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221120124734.18634-1-hch@lst.de>
References: <20221120124734.18634-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

Stop looking at the stripe boundary in
btrfs_encoded_read_regular_fill_pages() now that btrfs_submit_bio can
split bios.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 13d58ee092357..bcfb943273ed1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9968,7 +9968,6 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 					  u64 file_offset, u64 disk_bytenr,
 					  u64 disk_io_size, struct page **pages)
 {
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_encoded_read_private priv = {
 		.inode = inode,
 		.file_offset = file_offset,
@@ -9976,33 +9975,15 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 	};
 	unsigned long i = 0;
 	u64 cur = 0;
-	int ret;
 
 	init_waitqueue_head(&priv.wait);
 	/*
-	 * Submit bios for the extent, splitting due to bio or stripe limits as
-	 * necessary.
+	 * Submit bios for the extent, splitting due to bio limits as necessary.
 	 */
 	while (cur < disk_io_size) {
-		struct extent_map *em;
-		struct btrfs_io_geometry geom;
 		struct bio *bio = NULL;
-		u64 remaining;
+		u64 remaining = disk_io_size - cur;
 
-		em = btrfs_get_chunk_map(fs_info, disk_bytenr + cur,
-					 disk_io_size - cur);
-		if (IS_ERR(em)) {
-			ret = PTR_ERR(em);
-		} else {
-			ret = btrfs_get_io_geometry(fs_info, em, BTRFS_MAP_READ,
-						    disk_bytenr + cur, &geom);
-			free_extent_map(em);
-		}
-		if (ret) {
-			WRITE_ONCE(priv.status, errno_to_blk_status(ret));
-			break;
-		}
-		remaining = min(geom.len, disk_io_size - cur);
 		while (bio || remaining) {
 			size_t bytes = min_t(u64, remaining, PAGE_SIZE);
 
-- 
2.30.2

