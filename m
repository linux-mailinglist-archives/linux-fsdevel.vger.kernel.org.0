Return-Path: <linux-fsdevel+bounces-36684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6729E7BB5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 23:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812BA284788
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 22:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEAB212FA8;
	Fri,  6 Dec 2024 22:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I3uU1WLU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFD422C6C0
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 22:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523935; cv=none; b=N+TOk7rkwchHUnQxz3iE5xDGfVhZC0DxEsUaiyjD3Cwpcs+WYQvu6zwPSBRob1JU8dV2cB0nUBDF5ofG7+0RjZkHO6nQNMkWlXniSOrCx0JccLqcK7ecuKXtcq+aW6dhcz9DTN0MO3Z9rp8lZ23atapAA6Uo/4d56ls++6GQ8aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523935; c=relaxed/simple;
	bh=0G/FKxR8197zNGdAsBulaxn6HtDa6t7h29sDqzbLVkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfXtaPebNikFYxDDlf7Y8yFdXbbv6QdYQO7rnCAD/+LPKdRXslpxpEz0BpXOIXFjIRuu/ldmWxpESbGCIQE7hnksqBgf6q6adxWMsWkweSn/hjen0f3UUad2zxDExNHOjC+HUrVLgXpNYGHM89qh0ZWP0KZtmQlJmIwDjljv5uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I3uU1WLU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=nZNTYzUHGsbJBBqOyu65xaMrr+aWcm8Z7EcxbwKvAmE=; b=I3uU1WLULxyjeCe4pdurkOkCaC
	hkNKnU/tjhoRZv0bLMMcvD07Zjlxl3VL1ZRvg0m1D1YmMIzWLTCT5zQBkWIBuhUCuN7jG3wJ1BVJX
	HRmLjTzq7Ik4UqWQTX8ffali/gw1UziiKOmbBZuHRTK+ycBmDj0x1xnEjRSZ8L6J0ggr/ruLRZoUZ
	8uVClGP/Bg8GYbarJ5qUlWuRRSs/fdmd2aXlqiGkLcU8ivpmBLQ8cH9jlCCD/ewRoVvuM7stxHTVR
	b9zvNv4z0fAPzfYAVgHaGZ/FbschEybZ2IbvDF8Yoa9mxlSFz08RvR9NYa+eXQRNx4Bj1rT04U0SH
	kFzK8K3Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJglH-0000000F4hc-3Ldx;
	Fri, 06 Dec 2024 22:25:23 +0000
Date: Fri, 6 Dec 2024 22:25:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
	bernd.schubert@fastmail.fm, shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: Re: [PATCH v2 00/12] fuse: support large folios
Message-ID: <Z1N505RCcH1dXlLZ@casper.infradead.org>
References: <20241125220537.3663725-1-joannelkoong@gmail.com>
 <f9b63a41-ced7-4176-8f40-6cba8fce7a4c@linux.alibaba.com>
 <CAJnrk1bwat_r4+pmhaWH-ThAi+zoAJFwmJG65ANj1Zv0O0s4_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1bwat_r4+pmhaWH-ThAi+zoAJFwmJG65ANj1Zv0O0s4_A@mail.gmail.com>

On Fri, Dec 06, 2024 at 09:41:25AM -0800, Joanne Koong wrote:
> On Fri, Dec 6, 2024 at 1:50 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
> > -       folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
> > +       folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN |
> > fgf_set_order(len),
> >
> > Otherwise the large folio is not enabled on the buffer write path.
> >
> >
> > Besides, when applying the above diff, the large folio is indeed enabled
> > but it suffers severe performance regression:
> >
> > fio 1 job buffer write:
> > 2GB/s BW w/o large folio, and 200MB/s BW w/ large folio
> 
> This is the behavior I noticed as well when running some benchmarks on
> v1 [1]. I think it's because when we call into __filemap_get_folio(),
> we hit the FGP_CREAT path and if the order we set is too high, the
> internal call to filemap_alloc_folio() will repeatedly fail until it
> finds an order it's able to allocate (eg the do { ... } while (order--
> > min_order) loop).

But this is very different frrom what other filesystems have measured
when allocating large folios during writes.  eg:

https://lore.kernel.org/linux-fsdevel/20240527163616.1135968-1-hch@lst.de/

So we need to understand what's different about fuse.  My suspicion is
that it's disabling some other optimisation that is only done on
order 0 folios, but that's just wild speculation.  Needs someone to
dig into it and look at profiles to see what's really going on.

