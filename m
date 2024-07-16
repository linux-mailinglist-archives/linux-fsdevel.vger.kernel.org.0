Return-Path: <linux-fsdevel+bounces-23771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B04E0932A63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 17:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3431F23E45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 15:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF3C19E7CF;
	Tue, 16 Jul 2024 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AVs3Died"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFBD19DFA3;
	Tue, 16 Jul 2024 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721143580; cv=none; b=eD9+4foKI6+GGj0r2xMWUTQcCIwElKCycq0PMQR5T3Fbu6xQzh/s9Cv/8sFCt344JH1J5ly6uIX9JMZ48IQcTqoygNjLz1BUnNS/jCxqRiCoX1uVbhK/fy03qFbKKyC2b4DTziuVPhktG+mucOeeSaU4ow/0GFuD0muh5vFnE3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721143580; c=relaxed/simple;
	bh=R5JHL3KinP0UU8pPBfYYP/y8e8Szo7AwDYzcALfNZS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r08plp3dU6YBNEFYISb3N/9yKJ6XYM+PsCeMtAC9QZMGS3bX4s+ITYnfwo8DYKe7HKq41MO1HaBNElXQx50vZ0h173B+yW3NSE9afeSmI/sDzAb/315lNuq9NAjtSDEfwviZNMN6zbLIO/AK8n+3kCNZ0g2cWhtB1g8vgFp0e9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AVs3Died; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+ZGcgOeaT+/JIj3aQHIikSw57lYTC0+Jg+f0BLjgrTQ=; b=AVs3Diedky0NxggnKuSLAKTYiv
	37PBUzKjTOnVrXvjx2cQJZWT2ShGL28zhFNxFKNRyjyb4KRKv2vhYvUpHYH2h9ngIuGXSO+KeMfxK
	W70B5twuKz0TiAuSqKicQ7YLVSgdZ1sGhlg3R/zm+r2zcJWKyzii3qKT9cUMDrERzmuuox3knFkQG
	Vlcf5qFMRTusas2GujCUd1UKAPWHn1FU6swpyM/sdNF+PHnO04IAhG7jmbL8uOE75ItDFfXm1mP2d
	oy2MWQwz0DK0DJbRRVGQLaGi2Y46OvtvlydscVw0Ep+SsPXFVgGwElB8m0tbTVAF7mbpg6n6CTQrx
	MswkYg1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTk4A-0000000HFLP-2Qjt;
	Tue, 16 Jul 2024 15:26:10 +0000
Date: Tue, 16 Jul 2024 16:26:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, chandan.babu@oracle.com, djwong@kernel.org,
	brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, ryan.roberts@arm.com, hch@lst.de,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v10 01/10] fs: Allow fine-grained control of folio sizes
Message-ID: <ZpaRElX0HyikQ1ER@casper.infradead.org>
References: <20240715094457.452836-1-kernel@pankajraghav.com>
 <20240715094457.452836-2-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715094457.452836-2-kernel@pankajraghav.com>

On Mon, Jul 15, 2024 at 11:44:48AM +0200, Pankaj Raghav (Samsung) wrote:
> +/*
> + * mapping_max_folio_size_supported() - Check the max folio size supported
> + *
> + * The filesystem should call this function at mount time if there is a
> + * requirement on the folio mapping size in the page cache.
> + */
> +static inline size_t mapping_max_folio_size_supported(void)
> +{
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +		return 1U << (PAGE_SHIFT + MAX_PAGECACHE_ORDER);
> +	return PAGE_SIZE;
> +}

There's no need for this to be part of this patch.  I've removed stuff
from this patch before that's not needed, please stop adding unnecessary
functions.  This would logically be part of patch 10.

> +static inline void mapping_set_folio_order_range(struct address_space *mapping,
> +						 unsigned int min,
> +						 unsigned int max)
> +{
> +	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +		return;
> +
> +	if (min > MAX_PAGECACHE_ORDER) {
> +		VM_WARN_ONCE(1,
> +	"min order > MAX_PAGECACHE_ORDER. Setting min_order to MAX_PAGECACHE_ORDER");
> +		min = MAX_PAGECACHE_ORDER;
> +	}

This is really too much.  It's something that will never happen.  Just
delete the message.

> +	if (max > MAX_PAGECACHE_ORDER) {
> +		VM_WARN_ONCE(1,
> +	"max order > MAX_PAGECACHE_ORDER. Setting max_order to MAX_PAGECACHE_ORDER");
> +		max = MAX_PAGECACHE_ORDER;

Absolutely not.  If the filesystem declares it can support a block size
of 4TB, then good for it.  We just silently clamp it.


