Return-Path: <linux-fsdevel+bounces-45568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F3DA79723
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 23:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E13327A4F2B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 21:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB821F3FC2;
	Wed,  2 Apr 2025 21:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EmzzU0wj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BC51F3BAE
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743627993; cv=none; b=HaJqoL80RuzlLBB2mgIkc/lE+mZxyeiF9CPQtZ7axQX8P71/j83F72Gu01x0k1hHc5RSrLjOHRQJRRnNLXqS8lYS9doO6QFIRpfsy4b7vH5BHkfzxx9vhhB0r90XFb9DUJsogszPRx7f6F9BdRLlQ8vIomeodY9jg702Fid0Q/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743627993; c=relaxed/simple;
	bh=rFsAG2+Ov++VLndrvOzPMbD0or9WbOefz+wIfmCy9AY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b7hOtEcr8G8vWucMCTUuKp5/YuE6aUrOtQOkSQ8GU6Utxl2n1a4CFGhbV94F8Sye8vWvEZlV2QmlPGiFhwpdT5edrwsux0ORoqk8rQ84R7DVhwdYrMMrZebpXTeVno6/aQA/NfuurDQvxUnwfI0k9PXukh8JhNro/ZI2VWna9vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EmzzU0wj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=c3b184WGgdYtzK+XFBPG5bf8hLL4JlK64agmC7l/ydM=; b=EmzzU0wj5T9ntmSYWpj5pIs/E1
	baQzWCj+puuCrdJiCphXvc06keORnn6bScWnqx1u/oCDsCvn4yLXgD9i+TqXcn3HbwCZk9BmwNKhU
	1T0Wl5Pw0wfAJwQkwPVBhbKq+rVRax7XLiPSJGkq79arEkzUvjZEj7ZV0YSvtExxpEv1EuYPMPNub
	MY8Q4ITkO2Jzsd/Cy1FXakEAOxcpAobgu56xwxCHTq137ypmrLHocj+qum9i9x/FEY39wvgQfHveP
	WA7z8xDEQ7XX7yKforOCi9JYhgb/8LSPrLA8T8NrGOOcEm1jCBrVFyGrWnqtOfev1LRbLiBpKdfD9
	M5dOroFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u05Hq-0000000AFqK-2j1F;
	Wed, 02 Apr 2025 21:06:14 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/8] Misc folio patches for 6.16
Date: Wed,  2 Apr 2025 22:06:02 +0100
Message-ID: <20250402210612.2444135-1-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a few APIs that we've converted everybody from using.  I also
found a few places that extract a page pointer from i_pages, which will
be an invalid thing to do when we separate pages from folios.

Matthew Wilcox (Oracle) (8):
  filemap: Remove readahead_page()
  mm: Remove offset_in_thp()
  iov_iter: Convert iter_xarray_populate_pages() to use folios
  iov_iter: Convert iov_iter_extract_xarray_pages() to use folios
  filemap: Remove find_subpage()
  filemap: Convert __readahead_batch() to use a folio
  filemap: Remove readahead_page_batch()
  mm: Delete thp_nr_pages()

 include/linux/mm.h      | 10 -------
 include/linux/pagemap.h | 62 ++++++-----------------------------------
 lib/iov_iter.c          | 30 ++++++++++----------
 3 files changed, 24 insertions(+), 78 deletions(-)

-- 
2.47.2


