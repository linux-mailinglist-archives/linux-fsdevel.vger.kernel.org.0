Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F4C7924E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjIEQAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 12:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354564AbjIEMle (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:41:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007071A8;
        Tue,  5 Sep 2023 05:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=I66u7n0qR7e4t2l/vHkn1+P4nfDofW3E+lXSWKAdYBU=; b=co4MG+2W+W6XTXPz7WYRQmR0j3
        8PQGEq6qlCieyDdFq9+M9pPX4W+lm+6znAs21w9o70fhf8OAT5SUkzrJX65xgRBneV3lT2xCIXD4i
        FIq7l+ln9X3FyQEMJZcp4TnnSXmZWEyJqMy3HO484PNKmlSYZrXiFR+T0OFMjoaIjyD0FO8pnuCIu
        EvMqoGUbQMILy+A88Cnlq6gPlLvBtV0qScgqPxZD9oo2JPnY42oKZdu/A6t8wXTsrWt5JmZOE+1fx
        p102lXJwc/3BYIHykX9h9GIJI1Su7xaY0FMYbccjaMQjn9c8CZ2TXq80xXrJPqWXBXHXeXlalvirN
        XanECvGg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qdVMz-0062IL-16;
        Tue, 05 Sep 2023 12:41:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     djwong@kernel.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com
Subject: [PATCH] iomap: handle error conditions more gracefully in iomap_to_bh
Date:   Tue,  5 Sep 2023 14:41:20 +0200
Message-Id: <20230905124120.325518-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
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

iomap_to_bh currently BUG()s when the passed in block number is not
in the iomap.  For file systems that have proper synchronization this
should never happen and so far hasn't in mainline, but for block devices
size changes aren't fully synchronized against ongoing I/O.  Instead
of BUG()ing in this case, return -EIO to the caller, which already has
proper error handling.  While we're at it, also return -EIO for an
unknown iomap state instead of returning garbage.

Fixes: 487c607df790 ("block: use iomap for writes to block devices")
Reported-by: syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/buffer.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 2379564e5aeadf..a6785cd07081cb 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2011,7 +2011,7 @@ void folio_zero_new_buffers(struct folio *folio, size_t from, size_t to)
 }
 EXPORT_SYMBOL(folio_zero_new_buffers);
 
-static void
+static int
 iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
 		const struct iomap *iomap)
 {
@@ -2025,7 +2025,8 @@ iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
 	 * current block, then do not map the buffer and let the caller
 	 * handle it.
 	 */
-	BUG_ON(offset >= iomap->offset + iomap->length);
+	if (offset >= iomap->offset + iomap->length)
+		return -EIO;
 
 	switch (iomap->type) {
 	case IOMAP_HOLE:
@@ -2037,7 +2038,7 @@ iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
 		if (!buffer_uptodate(bh) ||
 		    (offset >= i_size_read(inode)))
 			set_buffer_new(bh);
-		break;
+		return 0;
 	case IOMAP_DELALLOC:
 		if (!buffer_uptodate(bh) ||
 		    (offset >= i_size_read(inode)))
@@ -2045,7 +2046,7 @@ iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
 		set_buffer_uptodate(bh);
 		set_buffer_mapped(bh);
 		set_buffer_delay(bh);
-		break;
+		return 0;
 	case IOMAP_UNWRITTEN:
 		/*
 		 * For unwritten regions, we always need to ensure that regions
@@ -2062,7 +2063,10 @@ iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
 		bh->b_blocknr = (iomap->addr + offset - iomap->offset) >>
 				inode->i_blkbits;
 		set_buffer_mapped(bh);
-		break;
+		return 0;
+	default:
+		WARN_ON_ONCE(1);
+		return -EIO;
 	}
 }
 
@@ -2103,13 +2107,12 @@ int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
 			clear_buffer_new(bh);
 		if (!buffer_mapped(bh)) {
 			WARN_ON(bh->b_size != blocksize);
-			if (get_block) {
+			if (get_block)
 				err = get_block(inode, block, bh, 1);
-				if (err)
-					break;
-			} else {
-				iomap_to_bh(inode, block, bh, iomap);
-			}
+			else
+				err = iomap_to_bh(inode, block, bh, iomap);
+			if (err)
+				break;
 
 			if (buffer_new(bh)) {
 				clean_bdev_bh_alias(bh);
-- 
2.39.2

