Return-Path: <linux-fsdevel+bounces-2304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 108877E495D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 20:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3172812FD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 19:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CD736B04;
	Tue,  7 Nov 2023 19:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TjRa542P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503A736AFE
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 19:42:18 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2DB10C1
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 11:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Laz2KCiz/PqdHbx5lJ7LK8+snbPmisFVR4K15bIR380=; b=TjRa542PWstspcQhwbJZkkAO2O
	U3Q2oSpJZ1aJronnqjSRtG0YlXUadAkrtyBJ3bbJs0l66AfCN0aN8XHe1giUBnVHS128014pkLL2S
	xLRzdVEa6P1q4oc8tAbTsipWHiHq55XXSwfyV6LGiX2bVN/makgTNieuW+gJO3Hto1baxpt6Y6TCv
	/PGpLMu3a0Fx1h/gY/zTItqAZAQTCpRGbgdlditReeKQa6C1vLjmp1cIefiJcM2m8fn1jVCe9gx7H
	b/WyTB+FJqRWJWPrMlFr1oxeqOJj1kDaTeyCD/yqzDqCEb3ZUnVLZVFrtqhEkYFs3l0PIpwK241iq
	Zx8Pjv7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r0RxU-00E9l7-CE; Tue, 07 Nov 2023 19:41:56 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/5] buffer: Fix various functions for block size > PAGE_SIZE
Date: Tue,  7 Nov 2023 19:41:52 +0000
Message-Id: <20231107194152.3374087-6-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231107194152.3374087-1-willy@infradead.org>
References: <20231107194152.3374087-1-willy@infradead.org>
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
---
 fs/buffer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 2f08af3c47a2..5bdfcf8c6fe6 100644
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


