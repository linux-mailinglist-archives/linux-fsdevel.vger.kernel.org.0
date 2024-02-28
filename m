Return-Path: <linux-fsdevel+bounces-13119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD7D86B716
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 19:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6BF0B22A57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 18:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060FC40857;
	Wed, 28 Feb 2024 18:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tgG0Z9FE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E538079B8A
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144558; cv=none; b=fGjkxT/vXqF8FXsk6FJ/YuuFMxqmB4k5mP+fZpNBrYhwhZuk4VFY+YVFI1bb+E0bBIubWGFEyvrvylDm7wWadoNHO25hDDzAA3uFhh2ocUccHGppLX1pljyxD4yLyBBgt3sL1o80hbi/tsrjo3Vq7vBnen/FUHKw+Dv9OYTTfJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144558; c=relaxed/simple;
	bh=71p0s3M34Ov63NZGMDtQr3pQOw+zG0/XCcc0PCgodTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LZ3NfEZBF7QqAXeBMsdAHiAp2iq4rt/9W2ET4pzcLILx8SFGzppb5J2oqcgcT5RGlGx3EfdovawDYH8kko3iHdrbZckQHeazPShLaUinovEepZ2OIOk3jGRuMNvu5fZhOHNM/WSLZ+fVZI6J1Sk7WJvYeoK8rZy85+GFJUdKv9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tgG0Z9FE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=J/q0ho0MBKAcYMWRNFtI3/6GGZRR/hx2c7R+WtSQaqY=; b=tgG0Z9FEdFK4x5PRJuj2S4FhOR
	UEH2lGJMmWebGXfRfothPzD4Bb4ZCwNJfNch6eYV6yxRw1BD22vGIWb7QjAUouSUxY3E4/1AaOtCa
	a9v5oqvJIZ8VVOWFcK19DMBsnZhxNKqKLs/rNuyuCK7lQNfVLmtYJciu4Jfemap7cIeshNoSQpy3z
	z9HoFDN9nzLiocW5RRyC81UrltMrOVeRYjQECsK+Ohm5VR4VgcT7vyyyybBlMSNatkt/jtSKQmXLq
	V6dQ9Nn7s3hir5CAaPcAoLIw35OCjTeERBGPktV3KaMYnxhcDkCXbp/DXH8gZnaVtf1w6mCRIRpX9
	kubFcNsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOZf-00000005sUQ-19uQ;
	Wed, 28 Feb 2024 18:22:35 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 0/1] Is pagecache_isize_extended() compatible with large folios?
Date: Wed, 28 Feb 2024 18:22:27 +0000
Message-ID: <20240228182230.1401088-1-willy@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'd appreciate some filesystem people checking my work here (in that
pagecache_isize_extended() may already be broken and we didn't notice).

As far as I can tell (and it'd be nice to explain this in the kernel-doc
a little more thoroughly), the reason pagecache_isize_extended() exists
is that some filesystems rely on getting page_mkwrite() calls in order to
instantiate blocks.  So if you have a filesystem using 512 byte blocks and
a 256 byte file mmaped, a store anywhere in the page will only result in
block 0 of the file being instantiated and the folio will now be marked
as dirty.

If we ftruncate the file to 2500 bytes before the folio gets written back,
then store to offset 2000, the filesystem will not be notified, so it
will not instantiate a block to store that information in.  Therefore if
we truncate a file up, we need to mark the PTE that straddles the EOF
as read-only so that page_mkwrite() is called.

Now, I think this patch is safe because it's PAGE_SIZE that's important,
not the size of the folio.  We mmap files on PAGE_SIZE boundaries and
we're only asking if there could be a new store which causes a block
to be instantiated.  If the block size is >= PAGE_SIZE, there can't be.
If the folio size happens to be larger than PAGE_SIZE, it doesn't matter.
All that matters is that we protect the folio which crosses i_size if
block size < PAGE_SIZE.

Matthew Wilcox (Oracle) (1):
  mm: Convert pagecache_isize_extended to use a folio

 mm/truncate.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

-- 
2.43.0


