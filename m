Return-Path: <linux-fsdevel+bounces-40854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A4CA27F5E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 00:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7143A5370
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FC021E08D;
	Tue,  4 Feb 2025 23:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IHtFMQGC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D72721C19D;
	Tue,  4 Feb 2025 23:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738710736; cv=none; b=MoViqw5t9fwYOq1AU//lgx4Sq2hGJU00BpgOMexCOtA/A1L+ZzKl5awI0eKAUXvzbD+VPjuHxbrvNgJLX4dOd1RJ/eBobLKplb6SSA7NX4j+xTZeVL7xpH4GgV7siJQFqz2HBI1dhlJXfQ6LWKhL90HpzzV713YBI88AbqybDxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738710736; c=relaxed/simple;
	bh=zt97TGl2KF08+WytHpTHgv7Zf2m36wjwZhA67iwywMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBrANGt0gS3s34EJ/GyEdHkkOh8903l4ankLxeojvYr2rVEJPQbOYugCOLUb3G5obGzzFFAFwh0VearaesBhR6hILRAB7aXJuI8YWjgY9baT7dzel5MJhLdzgZBRZXIepCNpAJN1YYcBxct+JBsSkfu2TpnkccZIjmTAWl4risM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IHtFMQGC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dx9mRi5amWVcM0ecsur6IbVdNelNNovE80LuaqvVo+c=; b=IHtFMQGC1lK7B131euedd45YPt
	nvZXb+Eg/WELScuPXyzcOvYG5gWjU1eXe++DWyQ+PqIpGdRMjXPlrkWuXofu9nDbHrNeXRzYrzPpH
	sYemqQLRrwX9oSG97zypNzZd1Z0nKV2MhFdmFsi2SRLxWUw7R66nAHOcgFB8KEi1u2Q14RXLCmv0q
	71XJQ0YgjmH6eipR2q3wHm8hoYFC61FAadJWvmI6TPp0Rf5otCojled0yolTsPGl3yosS0jCJwNb9
	1ZKv0Oqq+F+DsKYrgflgR1rtAAqpBL/9Iwj9Vt5eTq5STdHZjtIZ+XK1owFLcZBUz1HOv/ZphMXaU
	U/pJyBtQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tfS5T-00000001nhQ-1MeY;
	Tue, 04 Feb 2025 23:12:11 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: hare@suse.de,
	willy@infradead.org,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org,
	kbusch@kernel.org
Cc: john.g.garry@oracle.com,
	hch@lst.de,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH v2 3/8] fs/mpage: avoid negative shift for large blocksize
Date: Tue,  4 Feb 2025 15:12:04 -0800
Message-ID: <20250204231209.429356-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204231209.429356-1-mcgrof@kernel.org>
References: <20250204231209.429356-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

From: Hannes Reinecke <hare@kernel.org>

For large blocksizes the number of block bits is larger than PAGE_SHIFT,
so use instead use folio_pos(folio) >> blkbits to calculate the sector
number. This is required to enable large folios with buffer-heads.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/mpage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 82aecf372743..a3c82206977f 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -181,7 +181,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	if (folio_buffers(folio))
 		goto confused;
 
-	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
+	block_in_file = folio_pos(folio) >> blkbits;
 	last_block = block_in_file + args->nr_pages * blocks_per_page;
 	last_block_in_file = (i_size_read(inode) + blocksize - 1) >> blkbits;
 	if (last_block > last_block_in_file)
@@ -527,7 +527,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	 * The page has no buffers: map it to disk
 	 */
 	BUG_ON(!folio_test_uptodate(folio));
-	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
+	block_in_file = folio_pos(folio) >> blkbits;
 	/*
 	 * Whole page beyond EOF? Skip allocating blocks to avoid leaking
 	 * space.
-- 
2.45.2


