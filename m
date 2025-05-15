Return-Path: <linux-fsdevel+bounces-49081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073FDAB7B62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 04:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DCED3A6C9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 02:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68841269817;
	Thu, 15 May 2025 02:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JVF8hLAw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38154B1E44
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 02:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747274780; cv=none; b=tadItwi+HdA7ZfQoNRxAsZjla4sAWOJccBLT80Ju16DYSyRNCeGE1SDXzOAq0mpM63eLBTFlDIB4RyocRmmAFu0BOoAKz898x37tXdVQ6UcXUYBYiBgaQOkAg5WzDtdDuVckYxUFa3J7kRLLH3Y252klBIeNG8Aim7lYo9Kp/oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747274780; c=relaxed/simple;
	bh=XqLQ8fhB/2lyA5thCbLMsXXyVb6tH1uf+Fbd6cHK/N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7vNpYV/YWTxacGH/V8+jPChv8RxI+XN1xrmbJewOXtyEbhmbEE+a84ktaAgFwPvCUU7sZc9I9VnQC0xuC+ZpHtd3h45IjRunkOd0uhzojHFrwhFkE+HWkVBA1jAYpLZt8WhRWhQzf/RSd1g81QI7LChdkCeLcbR6VnjZslOcWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JVF8hLAw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=RSkVH4EAMEHbo2jkecJn2DWKjq+7hi9C2tyu992lxQ4=; b=JVF8hLAwnxBRdjQRRGz+BSHDwx
	XffNxq0meWJ6Zu/jxYSciCpxqseiSxnV+0dTh5ZLhYvhUfMShmjw+akQYxYVWqHUkUu6qnVoABJtE
	TleW5/vU2ld7uisinerZ1gBk8ICH9vCMr6EGI7M8i0rZXBPKelkAlUSmE3CQMa545MJiPyjr701YR
	StkGPqPlYpbaViPOgr2bXi1NdR+PIP8IQeczEjtvfECuW+N1somz5JGnDQUOAzndkDv7AQt9Q2/UW
	FwCqX0RjQgxTv3kIv7D3dLmi95iegPtnSh0+bY2SjcNLFp0rvDV7PjKumEKHIUuzi9Zwxqg3+gG7Q
	OH6igUAg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFNyx-0000000DA6u-2S8d;
	Thu, 15 May 2025 02:05:59 +0000
Date: Thu, 15 May 2025 03:05:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jlayton@kernel.org,
	jefflexu@linux.alibaba.com, josef@toxicpanda.com,
	kernel-team@meta.com, Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v6 01/11] fuse: support copying large folios
Message-ID: <aCVMB8R8mo0aPWM9@casper.infradead.org>
References: <20250512225840.826249-1-joannelkoong@gmail.com>
 <20250512225840.826249-2-joannelkoong@gmail.com>
 <aCPhbVxmfmBjC8Jh@casper.infradead.org>
 <CAJnrk1baSrQ__HxYDv99JpZr4FtXKDrjFfEw5AoUfVnM4ZJMNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1baSrQ__HxYDv99JpZr4FtXKDrjFfEw5AoUfVnM4ZJMNw@mail.gmail.com>

On Wed, May 14, 2025 at 03:59:50PM -0700, Joanne Koong wrote:
> On Tue, May 13, 2025 at 5:18 PM Matthew Wilcox <willy@infradead.org> wrote:
> > kmap_local_folio() only maps the page which contains 'offset'.
> > following what the functions in highmem.h do, i'd suggest something
> > like:
> >
> >                 if (folio) {
> >                         void *mapaddr = kmap_local_folio(folio, offset);
> >                         void *buf = mapaddr;
> >
> >                         if (folio_test_highmem(folio) &&
> >                             size > PAGE_SIZE - offset_in_page(offset))
> >                                 size = PAGE_SIZE - offset_in_page(offset);
> >                         offset += fuse_copy_do(cs, &buf, &count);
> >                         kunmap_local(mapaddr);
> >
> Ahh okay, I see, thanks. Do you think it makes sense to change
> kmap_local_folio() to kmap all the pages in the folio if the folio is
> in highmem instead of the caller needing to do that for each page in
> the folio one by one? We would need a kunmap_local_folio() where we
> pass in the folio so that we know how many pages need to be unmapped,
> but it seems to me like with large folios, every caller will be
> running into this issue, so maybe we should just have
> kmap_local_folio() handle it?

Spoken like someone who hasn't looked into the implementation of
kmap_local at all ;-)

Basically, this isn't possible.  There's only space for 16 pages to be
mapped at once, and we might want to copy from one folio to another, so
we'd be limited to a maximum folio order of 8.  Expanding the reserved
space for kmap is hard because it's primarily used on 32-bit machines
and we're very constrained in VA space.

