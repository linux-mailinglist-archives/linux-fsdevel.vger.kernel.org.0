Return-Path: <linux-fsdevel+bounces-2634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B757E735B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 22:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2B5281477
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 21:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBFA37157;
	Thu,  9 Nov 2023 21:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HsZleta2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5D41946B
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 21:06:22 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203F04688
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 13:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=9KPeRgMNK2nxHTBLeWSf18XXaXQwRoOCArRZM2euPRs=; b=HsZleta2hPKp6B2rQl1Hg9KLzd
	/g0j5La34lQMvYFYfHN6Qy/0qy0BK1Awj1nSMgBCWJ7Ju6Z2RtXvP3NX9THMaFT8bGP+WSirwdZrl
	gKkDFxzBDCKxabgwZx3kiUjGjnP3a+H8utlyRiAfGba9/JfmZecEABJlFFSfwvjWrcQyaTyatg4ax
	3x9C8TQzeW/YFJgR2Q9luPnaDQpZNP1Iqe0O9NPdUi4My3we11rhlYIjCyjyg2gFWsK7y+727Ty56
	917RdSxYJ9ZsHuJEuNtjgIUlAqMGAnw9rmKokfp+QMKMnQ8Gg9tJCptFX5zIG8xKEN2zvPA83WNeJ
	XxO9VqIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r1CE7-009Rw7-S1; Thu, 09 Nov 2023 21:06:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 4/7] buffer: Cast block to loff_t before shifting it
Date: Thu,  9 Nov 2023 21:06:05 +0000
Message-Id: <20231109210608.2252323-5-willy@infradead.org>
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

While sector_t is always defined as a u64 today, that hasn't always been
the case and it might not always be the same size as loff_t in the future.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 9c3f49cf8d28..ab345fd4da12 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2008,7 +2008,7 @@ static int
 iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
 		const struct iomap *iomap)
 {
-	loff_t offset = block << inode->i_blkbits;
+	loff_t offset = (loff_t)block << inode->i_blkbits;
 
 	bh->b_bdev = iomap->bdev;
 
-- 
2.42.0


