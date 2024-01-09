Return-Path: <linux-fsdevel+bounces-7623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD191828848
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 15:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA641F22822
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 14:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA9E3C46A;
	Tue,  9 Jan 2024 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WOy8RXNK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BA53C067;
	Tue,  9 Jan 2024 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=vQE4Vr9H4MhDEQ3ZsfKD//avXDRAF3tvXQ94yS9EaIc=; b=WOy8RXNKs6IkvVSwr390DH5rRe
	0rst5N0FA/qgl8haZG3WWpgKA98XqBUTBrk6VO84tfKI2gUcXcpXwQNWdwLmkXJ4kLGdQS8yL6k1d
	YFFIVqft4rvEIVeyqvGjnFTqIiNrNifH3XoCAogibRgbU57ipvSoHdN8OqlAvtrdpZ/iP8zoEKcNl
	Wpc74Ie6cZstz0i54+BmqZSWqG7rIQ/fZflo7FfJ1OMCcHw1Ql97n2vKjI7g5sIPYm2NnKmVrZP+E
	uBbWWP25xLMR7PETFxYOVfR+g5nuWaU/y4y10cjIxhvfydceKgEMvwjELoP9fYWoFWYy1W4aa2AZC
	cUHHeFNQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNDB1-009xrc-BC; Tue, 09 Jan 2024 14:33:59 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] buffer: Improve bdev_getblk documentation
Date: Tue,  9 Jan 2024 14:33:56 +0000
Message-Id: <20240109143357.2375046-8-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240109143357.2375046-1-willy@infradead.org>
References: <20240109143357.2375046-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some more information about the state of the buffer_head returned.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 05b68eccfdcc..562de7e013f7 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1424,6 +1424,11 @@ EXPORT_SYMBOL(__find_get_block);
  * @size: The size of buffer_heads for this @bdev.
  * @gfp: The memory allocation flags to use.
  *
+ * The returned buffer head has its reference count incremented, but is
+ * not locked.  The caller should call brelse() when it has finished
+ * with the buffer.  The buffer may not be uptodate.  If needed, the
+ * caller can bring it uptodate either by reading it or overwriting it.
+ *
  * Return: The buffer head, or NULL if memory could not be allocated.
  */
 struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
-- 
2.43.0


