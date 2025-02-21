Return-Path: <linux-fsdevel+bounces-42321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F48A402DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 23:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455053B0FC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 22:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A663220766D;
	Fri, 21 Feb 2025 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j0PYVvwX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B7D2397BF;
	Fri, 21 Feb 2025 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177513; cv=none; b=DKlUf7bywhspU7b/fybLWqQ6F0WQjMq/QT0HxZbQYeTmBUduIuW1oevXHFRTR35aaBjqgg2cKy1j1mTbVtAVxXLDl6YnSkeRreMYxSLNqi2ACOhtaIfidfTpvtfOm3hpNqAtySMb3x+jXVZP6MGdb80NVTZ4n47/GT8vlHrrEVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177513; c=relaxed/simple;
	bh=hh+kjJOX3Lo3l4ILL+fbseEofYE8t0mReKLbQTa2XbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CL2T6s2NEFXu9NIJae8Q1ypxPD9Ed+Jx3LQC+NUjoutmKNDGBNSPl9T1XTofIJpgMikWR8hyLHeFy0ov/RiVHFHczrIUg+s9KrCimm9JIpuvjPotDGEa9snNUXD8p3TBOTX1XjOTXqokLamGkXODZZ6nMQNCO4MyTRl/L0XfUoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j0PYVvwX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GoCon0Fq6X63chDqWaV9ZGQ+ZBO2iIy6otYzhff4lOE=; b=j0PYVvwXI7eCRUoi3gZOV2na2H
	Bj98iRzd1YMF4Lz6r9LwSxt53op4Q5kXHZRxGptgTBnpTPcgVrjtVTzNrCNH9l6rWodcKn1uzPvD9
	5Ugsk0CiQqBqoK3Z1WXfrcTsqQ4lWh+ibde8Kyn/b37D0hn79Jyk5ikSCLn85SAI3yk2Siu3h8Rcn
	WBQJFYEGyP08H9hJUa6NJvNezR+bLm0zKeLxDXBLYKEHGofvghjAj8odarDyzARiJBcNYIk34HXt5
	p8plBqyKTGkpOZtRcaOYmBc4TH/6BHg024qY5gApNVtEJBdUVAa+0WQsf/4QcJHNgJe3/pdPjNLkg
	Y+5JFOAA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlbf7-000000073D5-3Plg;
	Fri, 21 Feb 2025 22:38:25 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: brauner@kernel.org,
	akpm@linux-foundation.org,
	hare@suse.de,
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
Subject: [PATCH v3 3/8] fs/mpage: avoid negative shift for large blocksize
Date: Fri, 21 Feb 2025 14:38:18 -0800
Message-ID: <20250221223823.1680616-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221223823.1680616-1-mcgrof@kernel.org>
References: <20250221223823.1680616-1-mcgrof@kernel.org>
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
so calculate the sector number from the byte offset instead. This is
required to enable large folios with buffer-heads.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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
2.47.2


