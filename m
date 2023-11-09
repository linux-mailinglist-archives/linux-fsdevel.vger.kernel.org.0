Return-Path: <linux-fsdevel+bounces-2637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093767E735F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 22:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8EFDB211F3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 21:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0933B374CF;
	Thu,  9 Nov 2023 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="igG6aHHx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C9536AFE
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 21:06:31 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7A1D5F
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 13:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=H4wSyXEEGgJqio2mL6FJcY55DnvfRQIrSBN9MRDpId4=; b=igG6aHHxj+aXFXQdMp7v6fVIr6
	ucLTVJ4kPj/omFOo5cjIMwOFquJed4cNdt4F9TBwJc4rPZeJF4uryH62PuPK6+tceaDhz+K4cZZbo
	JZKdYl0xlp5QvNCGjF6b9wR0hF/mzxUXdXen06hOLwQgXst+yo2yCsP1uEUErJwdTz3+wvmJGnK1c
	s9lL/yTNVaateh+Ip9L81nsY+RqojedaWoquTcYzjgH1jpRu3hwa/H3jyzVC2AT0IVks809/6ZUWc
	3G2RG0Jy+eLAqNx4ZnyM7evrcRVHY7X26XNH7QTrbaBxB1zFZgDcwO34TVj9zqcMarhpNEWlIrdF2
	4z+0V9Ag==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r1CE7-009Rw9-Uk; Thu, 09 Nov 2023 21:06:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 5/7] buffer: Fix various functions for block size > PAGE_SIZE
Date: Thu,  9 Nov 2023 21:06:06 +0000
Message-Id: <20231109210608.2252323-6-willy@infradead.org>
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

If i_blkbits is larger than PAGE_SHIFT, we shift by a negative number,
which is undefined.  It is safe to shift the block left as a block
device must be smaller than MAX_LFS_FILESIZE, which is guaranteed to
fit in loff_t.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/buffer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ab345fd4da12..faf1916200c2 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -199,7 +199,7 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 	int all_mapped = 1;
 	static DEFINE_RATELIMIT_STATE(last_warned, HZ, 1);
 
-	index = block >> (PAGE_SHIFT - bd_inode->i_blkbits);
+	index = ((loff_t)block << bd_inode->i_blkbits) / PAGE_SIZE;
 	folio = __filemap_get_folio(bd_mapping, index, FGP_ACCESSED, 0);
 	if (IS_ERR(folio))
 		goto out;
@@ -1693,13 +1693,13 @@ void clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len)
 	struct inode *bd_inode = bdev->bd_inode;
 	struct address_space *bd_mapping = bd_inode->i_mapping;
 	struct folio_batch fbatch;
-	pgoff_t index = block >> (PAGE_SHIFT - bd_inode->i_blkbits);
+	pgoff_t index = ((loff_t)block << bd_inode->i_blkbits) / PAGE_SIZE;
 	pgoff_t end;
 	int i, count;
 	struct buffer_head *bh;
 	struct buffer_head *head;
 
-	end = (block + len - 1) >> (PAGE_SHIFT - bd_inode->i_blkbits);
+	end = ((loff_t)(block + len - 1) << bd_inode->i_blkbits) / PAGE_SIZE;
 	folio_batch_init(&fbatch);
 	while (filemap_get_folios(bd_mapping, &index, end, &fbatch)) {
 		count = folio_batch_count(&fbatch);
@@ -2660,8 +2660,8 @@ int block_truncate_page(struct address_space *mapping,
 		return 0;
 
 	length = blocksize - length;
-	iblock = (sector_t)index << (PAGE_SHIFT - inode->i_blkbits);
-	
+	iblock = ((loff_t)index * PAGE_SIZE) >> inode->i_blkbits;
+
 	folio = filemap_grab_folio(mapping, index);
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
-- 
2.42.0


