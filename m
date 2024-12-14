Return-Path: <linux-fsdevel+bounces-37409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B39289F1C4F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 04:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83F4160F0E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 03:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B345F1531DC;
	Sat, 14 Dec 2024 03:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AaqLnJlB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE22322EE5;
	Sat, 14 Dec 2024 03:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734145860; cv=none; b=igTSrXjasEZ7u8OIS2jB0K2GdrWbud6IRBRxC0PNzlql6rB1Zvj+jaP0OiT9Ur5CV52vd2T7gyxl8nCNx5ETSEKJTjHo17wNquKo83TlQMksgRvEtR30sZlBnelNZdHqsfQyIRnP7g9h9A1DD5yrlTym9ojK2Ldwcahmhj+LoBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734145860; c=relaxed/simple;
	bh=qLOoquAiywgpFbIfyCc3drngjRhAf1ne3Fx8Jz2mZW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAw49spvd60SbUZs1FqGZK86G/o8zLEnKpMKOPeYyqjU4hwgezzZCxKsPA8KpfzclaIgjC5B/FFi2B9YczoIBR7paGJ5Dx1ctS2OhjeySC6bmd/F9CP+zL3TspIKmOzV/Wg6xEl4Q42fMNXxWU9BJ5pECunAJObE+qGt0/DVsh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AaqLnJlB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fu2uu1E/hdWYAQ+oUve2n/osalBR9KfPKW7YQSw9qoM=; b=AaqLnJlBZdgAEm5L97UO99Elg9
	nSwRtJ5Oh3gR4SidRU6mFt90VVz+uswm/DRZRf273o490Dg0O6HfiZRMrUUTBIgcA6OuPe89DR+Vg
	vaQkWlNILmOXkYnVsWtisqS9qNdmSsIeFG8chQ5k17HhmQk8rCRVwKhiO9O1nCDo7QkMNiFt7Yh5J
	uPSFIk/Lz/RQS3axKLBxUkRTvMoMh+lSyCmjjB904f1VhaIBtKABlUHxaYW8D8E1rb5iszDDWVX1Y
	HPuyapGGhV0myArKMLDbpY+SLDfnwInKpoU2vRMF5hG0ZLB07t0T2nEWCJx2uFiVKZiqy6/VE3B2q
	0Mw72q5Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tMIYN-00000005c3h-3us2;
	Sat, 14 Dec 2024 03:10:51 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: willy@infradead.org,
	hch@lst.de,
	hare@suse.de,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org
Cc: john.g.garry@oracle.com,
	ritesh.list@gmail.com,
	kbusch@kernel.org,
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
Subject: [RFC v2 06/11] fs/mpage: avoid negative shift for large blocksize
Date: Fri, 13 Dec 2024 19:10:44 -0800
Message-ID: <20241214031050.1337920-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241214031050.1337920-1-mcgrof@kernel.org>
References: <20241214031050.1337920-1-mcgrof@kernel.org>
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
number.

With this in place we can now enable large folios on with buffer-heads.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/mpage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index eb6fee7de529..c6bb2a9706a1 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -181,7 +181,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	if (folio_buffers(folio))
 		goto confused;
 
-	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
+	block_in_file = folio_pos(folio) >> blkbits;
 	last_block = block_in_file + args->nr_pages * blocks_per_folio;
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
2.43.0


