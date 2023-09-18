Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DC17A47DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 13:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241228AbjIRLF5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 07:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbjIRLFY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:05:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDBE8F;
        Mon, 18 Sep 2023 04:05:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6DC561FDFD;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695035117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hjD8cnhpkb2Y5lGXJnngRv/a5ht52uC6A09ZJu2R4Sk=;
        b=q+DxNIy/ZdGzclXyaNKtO0EP6Qa3MpMBMit+ZPD8D4xYLfbyW1iiGWcnLCUtu5shbb0foY
        KCfjVqmChiQbJO+ucF0/u2OP0+gPG0fgLyK6X7qBP7/P5yqbltpEXKR0D/7IM7NkkWdNY7
        7kHxkG+/jUsm1xBJhitj2z9c1iZ0Qvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695035117;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hjD8cnhpkb2Y5lGXJnngRv/a5ht52uC6A09ZJu2R4Sk=;
        b=xuR9poqmq8V9n9KU6b9VFXUJK6lbKZ5g1NhIREtuK4VxBXSb/fMzVXpbc7SzdKtg1vmkv7
        3Rrxili5oEqVPqDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 066092C149;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 0AA3651CD145; Mon, 18 Sep 2023 13:05:17 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 04/18] fs/buffer.c: use accessor function to translate page index to sectors
Date:   Mon, 18 Sep 2023 13:04:56 +0200
Message-Id: <20230918110510.66470-5-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230918110510.66470-1-hare@suse.de>
References: <20230918110510.66470-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use accessor functions block_index_to_sector() and block_sector_to_index()
to translate the page index into the block sector and vice versa.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 fs/buffer.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 2379564e5aea..66895432d91f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -199,7 +199,7 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 	int all_mapped = 1;
 	static DEFINE_RATELIMIT_STATE(last_warned, HZ, 1);
 
-	index = block >> (PAGE_SHIFT - bd_inode->i_blkbits);
+	index = block_sector_to_index(block, bd_inode->i_blkbits);
 	folio = __filemap_get_folio(bd_mapping, index, FGP_ACCESSED, 0);
 	if (IS_ERR(folio))
 		goto out;
@@ -1702,13 +1702,13 @@ void clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len)
 	struct inode *bd_inode = bdev->bd_inode;
 	struct address_space *bd_mapping = bd_inode->i_mapping;
 	struct folio_batch fbatch;
-	pgoff_t index = block >> (PAGE_SHIFT - bd_inode->i_blkbits);
+	pgoff_t index = block_sector_to_index(block, bd_inode->i_blkbits);
 	pgoff_t end;
 	int i, count;
 	struct buffer_head *bh;
 	struct buffer_head *head;
 
-	end = (block + len - 1) >> (PAGE_SHIFT - bd_inode->i_blkbits);
+	end = block_sector_to_index(block + len - 1, bd_inode->i_blkbits);
 	folio_batch_init(&fbatch);
 	while (filemap_get_folios(bd_mapping, &index, end, &fbatch)) {
 		count = folio_batch_count(&fbatch);
@@ -1835,7 +1835,7 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 	blocksize = bh->b_size;
 	bbits = block_size_bits(blocksize);
 
-	block = (sector_t)folio->index << (PAGE_SHIFT - bbits);
+	block = block_index_to_sector(folio->index, bbits);
 	last_block = (i_size_read(inode) - 1) >> bbits;
 
 	/*
@@ -2087,7 +2087,7 @@ int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
 	blocksize = head->b_size;
 	bbits = block_size_bits(blocksize);
 
-	block = (sector_t)folio->index << (PAGE_SHIFT - bbits);
+	block = block_index_to_sector(folio->index, bbits);
 
 	for(bh = head, block_start = 0; bh != head || !block_start;
 	    block++, block_start=block_end, bh = bh->b_this_page) {
@@ -2369,7 +2369,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 	blocksize = head->b_size;
 	bbits = block_size_bits(blocksize);
 
-	iblock = (sector_t)folio->index << (PAGE_SHIFT - bbits);
+	iblock = block_index_to_sector(folio->index, bbits);
 	lblock = (limit+blocksize-1) >> bbits;
 	bh = head;
 	nr = 0;
@@ -2657,7 +2657,7 @@ int block_truncate_page(struct address_space *mapping,
 		return 0;
 
 	length = blocksize - length;
-	iblock = (sector_t)index << (PAGE_SHIFT - inode->i_blkbits);
+	iblock = block_index_to_sector(index, inode->i_blkbits);
 	
 	folio = filemap_grab_folio(mapping, index);
 	if (IS_ERR(folio))
-- 
2.35.3

