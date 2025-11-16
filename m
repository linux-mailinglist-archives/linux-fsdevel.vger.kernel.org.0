Return-Path: <linux-fsdevel+bounces-68606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B5AC613EB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 12:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3913135D081
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 11:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4622C11DF;
	Sun, 16 Nov 2025 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tR5be4N8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB6F201278;
	Sun, 16 Nov 2025 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763293901; cv=none; b=I0etOF+5c/EvM2V3s9SH4DbFGYu+Zry82Ujl/vs35IaENHLEpPO40l1Rheeb7QGDN+yJ8eVdBQNxe8GFF0Pj6GfA+6vmoXtwZNeCkVLJxQHYpE8VXKAa4pD1OzNzNBHcrAxr+RPk3xuI8WGwL+JyEKW07RGyWGNeXPgzn2v61N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763293901; c=relaxed/simple;
	bh=DVTqHgvj/7b2wg+60/ovYcqGcYReV+koF/0UPF6xvtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xb9a4hV+c51acd2tTxbfBFIHZXwv5/D24b6qtjf9hdzuFM8RLrWEnibiYKFRu97yI7gg5Jzhs0pWRqh9itiRaxopczqBwdFmVipvOyulRVSHJutaub1httzXPkx1x97bMF5K18E9GQzwNUCRz1MivNpOIbQpv37ZEvC4FGgVgVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tR5be4N8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pz4BJwDyaALcHK3BMUpJeAT6g0IIQz8aJIQbynT13Jc=; b=tR5be4N8jR/gONcUW9m+u85yKY
	BoyXLT7+NeCHca4j1SubH/JuFKIaLjhZxsrI8BoJy2o2hDKtAokJLs0hJunMQi/8BWXQbc1rtzweZ
	XQ7FiMEJogdOLNTQ6k/9nrqq0KDP3FdA3JoojqeLQuOfCVJapf7Dwg+z+axpYn7ZwFAheBDRDrBxn
	J54Ydo5HI0vJDaU/8mc1seP/vC5w557HnjAMRalYiJrIs9apje2KaL2TaXEZu4r7l1NTdhn4Ssfln
	xJ8Pzcf4t2lHZoGNuhkLIA6AfYs8Em2bcEn+SNo1lP6Ev8VfJupnHGk5B1RT+pE7JmMErU1JhpIOC
	5EC8ZXGA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKbHm-0000000CFKM-15FF;
	Sun, 16 Nov 2025 11:51:14 +0000
Date: Sun, 16 Nov 2025 11:51:14 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, ziy@nvidia.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	william.roche@oracle.com, harry.yoo@oracle.com, tony.luck@intel.com,
	wangkefeng.wang@huawei.com, jane.chu@oracle.com,
	akpm@linux-foundation.org, osalvador@suse.de, muchun.song@linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mm/huge_memory: introduce
 uniform_split_unmapped_folio_to_zero_order
Message-ID: <aRm6shtKizyrq_TA@casper.infradead.org>
References: <20251116014721.1561456-1-jiaqiyan@google.com>
 <20251116014721.1561456-2-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116014721.1561456-2-jiaqiyan@google.com>

On Sun, Nov 16, 2025 at 01:47:20AM +0000, Jiaqi Yan wrote:
> Introduce uniform_split_unmapped_folio_to_zero_order, a wrapper
> to the existing __split_unmapped_folio. Caller can use it to
> uniformly split an unmapped high-order folio into 0-order folios.

Please don't make this function exist.  I appreciate what you're trying
to do, but let's try to do it differently?

When we have struct folio separately allocated from struct page,
splitting a folio will mean allocating new struct folios for every
new folio created.  I anticipate an order-0 folio will be about 80 or
96 bytes.  So if we create 512 * 512 folios in a single go, that'll be
an allocation of 20MB.

This is why I asked Zi Yan to create the asymmetrical folio split, so we
only end up creating log() of this.  In the case of a single hwpoison page
in an order-18 hugetlb, that'd be 19 allocations totallying 1520 bytes.

But since we're only doing this on free, we won't need to do folio
allocations at all; we'll just be able to release the good pages to the
page allocator and sequester the hwpoison pages.

