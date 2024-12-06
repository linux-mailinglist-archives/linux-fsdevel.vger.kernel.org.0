Return-Path: <linux-fsdevel+bounces-36685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B6F9E7BC3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 23:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870BF283D43
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 22:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D075204597;
	Fri,  6 Dec 2024 22:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SFBBPKFs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB5413D251
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 22:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733524068; cv=none; b=Zp2nP6bRNk5rgUTvJwVYJInSX5BlMTSEIEbD9SHPd1lCGaDG8eVxJKysMhIK/L4ipdll9yqRlpO/qWPsRK4qYJXds0ulF+kzKmu/TDgLimIi0Py57KulZ8kG4xTBWhgsjKQvQW1ZctN2TTaX0Rv2xVbYY2OD22muvwAIHUOLcww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733524068; c=relaxed/simple;
	bh=Jj3QGDCq/KNyTH/49b+LIBq8KfTCG1i+oTXerNK38Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NesEjN0cwTMjPkmYwJHzY46+BgaBsdeRS/1SlJhyBDOZIStPv2G8nDrIZ73ByxaDcOKAZW68wHrSIs6oHHaZVId41oVMBrF21Ahrx4pkNrv2UzipzzueGaRh/c8rgs3K4y84BM8KzTcYkx+spE6kIY7ftJ7yIepxAdyqAAdkPpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SFBBPKFs; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 6 Dec 2024 14:27:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733524062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l5GuwGUenFxRlGFtdNdD7+xBHDbFS1ZAhsYPmbhXLwo=;
	b=SFBBPKFsk6+Onkj5RGAOvWHX5gwy45v2A95gJgaHEMbyfWgdV1IFU5swdJnbbAXc3+EE0F
	zdudSRD3VNIQ5XoHt+yA01aRJJ5xsgCE+n7MZJiWVNPOP5BlhvKk7+0NMjvp4T6SvhUZi3
	fBRimRHqskOrHmviP+IfNeExDSyXiWw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, bernd.schubert@fastmail.fm, 
	willy@infradead.org, kernel-team@meta.com
Subject: Re: [PATCH v2 00/12] fuse: support large folios
Message-ID: <k5r4wheqx4bwbtnorrzath2n6pg22ginkyha4vuw342tvn4uah@tjy5j2kvbuxk>
References: <20241125220537.3663725-1-joannelkoong@gmail.com>
 <f9b63a41-ced7-4176-8f40-6cba8fce7a4c@linux.alibaba.com>
 <CAJnrk1bwat_r4+pmhaWH-ThAi+zoAJFwmJG65ANj1Zv0O0s4_A@mail.gmail.com>
 <spdqvmxyzzbb6rajv6lvsztbf5xojtxfwu343jlihnq466u7ah@znmv7b6aj44x>
 <CAJnrk1ZLHwAcbTO-1W=Uvb25w9+4y+1RFXCQTxw_SQYv=+Q6vA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZLHwAcbTO-1W=Uvb25w9+4y+1RFXCQTxw_SQYv=+Q6vA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Dec 06, 2024 at 02:11:26PM -0800, Joanne Koong wrote:
> On Fri, Dec 6, 2024 at 12:36 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Fri, Dec 06, 2024 at 09:41:25AM -0800, Joanne Koong wrote:
> > > On Fri, Dec 6, 2024 at 1:50 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
> > [...]
> > > >
> > > > >
> > > > > Writes are still effectively one page size. Benchmarks showed that trying to get
> > > > > the largest folios possible from __filemap_get_folio() is an over-optimization
> > > > > and ends up being significantly more expensive. Fine-tuning for the optimal
> > > > > order size for the __filemap_get_folio() calls can be done in a future patchset.
> > >
> > > This is the behavior I noticed as well when running some benchmarks on
> > > v1 [1]. I think it's because when we call into __filemap_get_folio(),
> > > we hit the FGP_CREAT path and if the order we set is too high, the
> > > internal call to filemap_alloc_folio() will repeatedly fail until it
> > > finds an order it's able to allocate (eg the do { ... } while (order--
> > > > min_order) loop).
> > >
> >
> > What is the mapping_min_folio_order(mapping) for fuse? One thing we can
> 
> The mapping_min_folio_order used is 0. The folio order range gets set here [1]
> 
> [1] https://lore.kernel.org/linux-fsdevel/20241125220537.3663725-13-joannelkoong@gmail.com/
> 
> > do is decide for which range of orders we want a cheap failure i.e. without
> > __GFP_DIRECT_RECLAIM and then the range where we are fine with some
> > effort and work. I see __GFP_NORETRY is being used for orders larger
> 
> The gfp flags we pass into __filemap_get_folio() are the gfp flags of
> the mapping, and that gets set in inode_init_always_gfp() to
> GFP_HIGHUSER_MOVABLE, which does include __GFP_RECLAIM.
> 
> If __GFP_RECLAIM is set and the filemap_alloc_folio() call can't find
> enough space, does this automatically trigger a round of reclaim and
> compaction as well?

Yes, it will trigger reclaim/compaction rounds and based on order size
(order <= PAGE_ALLOC_COSTLY_ORDER), it can be very aggressive. The
__GFP_NORETRY flag limits to one iteration but a single iteration can be
expensive depending on the system condition.

For anon memory or specifically THPs allocation, we can tune though
sysctls to be less aggressive but there is infrastructure like
khugepaged which in background converts small pages into THPs. I can
imagine that we might want something similar for filesystem as well.


