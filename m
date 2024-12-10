Return-Path: <linux-fsdevel+bounces-36916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7364E9EAFB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 12:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4764B16B351
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 11:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80E0226541;
	Tue, 10 Dec 2024 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rWsNa9C3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0527F22541E;
	Tue, 10 Dec 2024 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829339; cv=none; b=sOpDqHTlW1nQPS53Yr8ZeQl7zuOapwPnqGlbThRooKqpUBsz92Jt6cnXUPLNOKrGD3pKcIdPtGXa75CccYrEdR2N4NLgQLW6Xxnj9pw/xwHtx4mlp/MepfSk8bvyLq0W0GbthWNXpF4noGrp0qWW3RsDiXM1tGm3qymuhhetsQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829339; c=relaxed/simple;
	bh=TfYOZYfEfENhdfuiEd5mRJY43n6LCIF/vR1WFBhNUTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evPiTkaxx3KUPIYb6q7Y9Zj4PZn78h+G3JWGfe0nmk/HlsPU4JhE+ze//XvcVwLR2Yh1nTkSGWzgP/3MU1IvbgootFFtSWv+c7Zt/dNwQ66WHty9iUS7U+AVdnubay77Q3nV5uiccGcr/uF4pI5+QZtCHYp+UwwEFfHGY3C0V2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rWsNa9C3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N/E7hy0e3ZL6CA1y0gJJQ3G4S6LexU1tKKmXtYfoVgk=; b=rWsNa9C3hUiV0XpoBLC3VMcT/B
	18VfAxVIIy3/EJ+CPRs3i3Vwgo5jfKmoR9KiTAjxFvVmTisdWYU4A3GmLpthiohiU7MDG+/S/xFvN
	GT8D93VGZ3SSCPXnsaTKb2JPyCEVG6uM8r7Z2veGHaezDyGdPVBhWTxWFd7CmZUNxhSgVulw81535
	iwkSh2APe/lmZNwZsiznTtNd7UkxLIgPkHLp4n9Ap7uQDRi29tUR49RNYtvQg6ZpgdNnQr/il2GOx
	mP5T7qMljTIx4aumSZib+9rX6pDj8ym/TUNOzaYHX3ijjQopUWbxSkcmdmG3TZmWZbsglxBcO6tZi
	3x7iiq5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKyDG-0000000BHQJ-0fjJ;
	Tue, 10 Dec 2024 11:15:34 +0000
Date: Tue, 10 Dec 2024 03:15:34 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
	kirill@shutemov.name, bfoster@redhat.com
Subject: Re: [PATCH 05/12] mm/filemap: use page_cache_sync_ra() to kick off
 read-ahead
Message-ID: <Z1gi1qUKFot43GzJ@infradead.org>
References: <20241203153232.92224-2-axboe@kernel.dk>
 <20241203153232.92224-7-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203153232.92224-7-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 03, 2024 at 08:31:41AM -0700, Jens Axboe wrote:
> Rather than use the page_cache_sync_readahead() helper, define our own
> ractl and use page_cache_sync_ra() directly. In preparation for needing
> to modify ractl inside filemap_get_pages().
> 
> No functional changes in this patch.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

FYI, I usually try to keep these pure cleanup patches that don't even
directly touch the series subject matter at the beginning to reduce
the cognitive load.


