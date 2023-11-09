Return-Path: <linux-fsdevel+bounces-2641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515B77E7362
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 22:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96CE5B21293
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 21:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3F1374DF;
	Thu,  9 Nov 2023 21:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g8GPU04k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C5E374FB
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 21:06:40 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD57D54
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 13:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Dr/RGrgySdjd8ncT62EyLWsleBevlgE8NPLHoUwdEOE=; b=g8GPU04kTpo7BHTzeRRy3dwoxQ
	I52Y95/5wmMTznJ4m7GxTqNhGSkC15ilPGrzijw6EMgFnphA22M2IkjQ0n8bHZcuflKe5IGWFY+Dt
	JjxF3jok9g5ZBOJbqYkNg7gidYlnW9ma3XxrbwfGTMdogvC/x1AIFv6v+/Pcv81abZlTS2Xjc40xs
	QrDAbe4EmwhFL1LzXbae/COpQDkQIDL2PLX7qumMXvthB8lH5XN2PdcjNSHUfwlC+DlaSFeHQTc7T
	5cm/YayWQXE0TbKYqyvZjewG69KjRSZGzJ0OcjEKkunnyeKLEyE2/y3PhAAE3ol0dewhngaujKOPc
	AiHF4lvg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r1CE8-009RwB-1B; Thu, 09 Nov 2023 21:06:12 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-fsdevel@vger.kernel.org,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v2 6/7] buffer: Handle large folios in __block_write_begin_int()
Date: Thu,  9 Nov 2023 21:06:07 +0000
Message-Id: <20231109210608.2252323-7-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231109210608.2252323-1-willy@infradead.org>
References: <20231109210608.2252323-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When __block_write_begin_int() was converted to support folios, we
did not expect large folios to be passed to it.  With the current
work to support large block size storage devices, this will no longer
be true so change the checks on 'from' and 'to' to be related to the
size of the folio instead of PAGE_SIZE.  Also remove an assumption that
the block size is smaller than PAGE_SIZE.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reported-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/buffer.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index faf1916200c2..ef444ab53a9b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2075,27 +2075,24 @@ iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
 int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
 		get_block_t *get_block, const struct iomap *iomap)
 {
-	unsigned from = pos & (PAGE_SIZE - 1);
-	unsigned to = from + len;
+	size_t from = offset_in_folio(folio, pos);
+	size_t to = from + len;
 	struct inode *inode = folio->mapping->host;
-	unsigned block_start, block_end;
+	size_t block_start, block_end;
 	sector_t block;
 	int err = 0;
-	unsigned blocksize, bbits;
+	size_t blocksize;
 	struct buffer_head *bh, *head, *wait[2], **wait_bh=wait;
 
 	BUG_ON(!folio_test_locked(folio));
-	BUG_ON(from > PAGE_SIZE);
-	BUG_ON(to > PAGE_SIZE);
+	BUG_ON(to > folio_size(folio));
 	BUG_ON(from > to);
 
 	head = folio_create_buffers(folio, inode, 0);
 	blocksize = head->b_size;
-	bbits = block_size_bits(blocksize);
-
-	block = (sector_t)folio->index << (PAGE_SHIFT - bbits);
+	block = div_u64(folio_pos(folio), blocksize);
 
-	for(bh = head, block_start = 0; bh != head || !block_start;
+	for (bh = head, block_start = 0; bh != head || !block_start;
 	    block++, block_start=block_end, bh = bh->b_this_page) {
 		block_end = block_start + blocksize;
 		if (block_end <= from || block_start >= to) {
-- 
2.42.0


