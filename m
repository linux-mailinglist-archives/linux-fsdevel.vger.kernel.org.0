Return-Path: <linux-fsdevel+bounces-2303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AD47E495C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 20:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF92281320
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 19:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038C336B09;
	Tue,  7 Nov 2023 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q0e34h02"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65CF36AFE
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 19:42:14 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D8D184
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 11:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=xfASZ8VSwupG8W8xOo2oafiHbZVPBxsrX/jji6c7RCA=; b=q0e34h02PybsihRcKWPK2JfGhP
	rRGN+p37Avy6kDYRbaYLagB1eGsZSxBEhGBGVcEgid5a2l/r4XGH98kFm4HgoiL4sztmK0xw4Mbs/
	pRF4wTnHuBZwFBhmDnAX7SqG7I1RSDLBy8idnylhEtvhyXTr3ds/7zrJUzUA4R6/8zMl9shlScFqo
	mxnvaDdIuoy4QVWvKIl9mPQz6HW5ndOqiQ2LsL0yGt49KVV2lF3IISOe8tC5o2rRiPaBpJF5JB2nk
	7wuexuV9jZWCbmNkMVetkgp9sUvWSY6p463YCrPQaD7PkydxcfaCEBmzYUFJKKJ1tI8ITJ8MOMvrF
	gV34sxYg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r0RxT-00E9l3-Ti; Tue, 07 Nov 2023 19:41:55 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/5] buffer: Fix grow_buffers() for block size > PAGE_SIZE
Date: Tue,  7 Nov 2023 19:41:50 +0000
Message-Id: <20231107194152.3374087-4-willy@infradead.org>
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

We must not shift by a negative number so work in terms of a byte
offset to avoid the awkward shift left-or-right-depending-on-sign
option.  This means we need to use check_mul_overflow() to ensure
that a large block number does not result in a wrap.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index cd114110b27f..c83bb89b2e24 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1085,26 +1085,21 @@ static bool grow_dev_folio(struct block_device *bdev, sector_t block,
 static bool grow_buffers(struct block_device *bdev, sector_t block,
 		unsigned size, gfp_t gfp)
 {
-	pgoff_t index;
-	int sizebits;
-
-	sizebits = PAGE_SHIFT - __ffs(size);
-	index = block >> sizebits;
+	loff_t pos;
 
 	/*
-	 * Check for a block which wants to lie outside our maximum possible
-	 * pagecache index.  (this comparison is done using sector_t types).
+	 * Check for a block which lies outside our maximum possible
+	 * pagecache index.
 	 */
-	if (unlikely(index != block >> sizebits)) {
-		printk(KERN_ERR "%s: requested out-of-range block %llu for "
-			"device %pg\n",
+	if (check_mul_overflow(block, size, &pos) || pos > MAX_LFS_FILESIZE) {
+		printk(KERN_ERR "%s: requested out-of-range block %llu for device %pg\n",
 			__func__, (unsigned long long)block,
 			bdev);
 		return false;
 	}
 
 	/* Create a folio with the proper size buffers */
-	return grow_dev_folio(bdev, block, index, size, gfp);
+	return grow_dev_folio(bdev, block, pos / PAGE_SIZE, size, gfp);
 }
 
 static struct buffer_head *
-- 
2.42.0


