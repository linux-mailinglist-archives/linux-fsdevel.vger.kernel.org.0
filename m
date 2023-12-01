Return-Path: <linux-fsdevel+bounces-4595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C18801035
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 17:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B476B1C20506
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 16:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB8725572
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TasJ7Xcp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCC1AD
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 08:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rVH172bDylofEvt+PPOvzgtupGiUqOptYr0OBZTEWgk=; b=TasJ7XcpLBbpP2V/MdptDBE1JV
	ela05ld9MHlxOxAQHBe//t/2oTPBSITve715u/CwI5DARS9PTxxPfkLTfKDHvMB9yJkhX5PCx/d7p
	tRMyj2q6XGsUr6VjOxFhCJ8YW6j+uNDtMdaUUzhI5S09PCx5dlHm2cbKR2OXpY6J9EsSPyXO/zXg+
	Oh5CuPvVwnHhYHjIvjlIEwKVoVnEAmaSyiPxM51ugNDNA1Kkj1ixtZq0d1KD7ilrJOxuHtJjei+gt
	21RGAzQRLS65Hk5YVodlp8ak7RWn/Hhhc9k+PeBgaoVh7QSAw1nScYhOm0TXcDzEJ7tUDaErX8X/n
	ZkXdICiA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r96Qu-00FgVD-Ox; Fri, 01 Dec 2023 16:32:04 +0000
Date: Fri, 1 Dec 2023 16:32:04 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1] mm/readahead: Do not allow order-1 folio
Message-ID: <ZWoKhMpmXm31CURk@casper.infradead.org>
References: <20231201161045.3962614-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201161045.3962614-1-ryan.roberts@arm.com>

On Fri, Dec 01, 2023 at 04:10:45PM +0000, Ryan Roberts wrote:
> The THP machinery does not support order-1 folios because it requires
> meta data spanning the first 3 `struct page`s. So order-2 is the
> smallest large folio that we can safely create.
> 
> There was a theoretical bug whereby if ra->size was 2 or 3 pages (due to
> the device-specific bdi->ra_pages being set that way), we could end up
> with order = 1. Fix this by unconditionally checking if the preferred
> order is 1 and if so, set it to 0. Previously this was done in a few
> specific places, but with this refactoring it is done just once,
> unconditionally, at the end of the calculation.
> 
> This is a theoretical bug found during review of the code; I have no
> evidence to suggest this manifests in the real world (I expect all
> device-specific ra_pages values are much bigger than 3).
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

It's better code anyway!

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>


