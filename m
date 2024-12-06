Return-Path: <linux-fsdevel+bounces-36676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFCD9E7A12
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 21:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7261881DDC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 20:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0661D90C5;
	Fri,  6 Dec 2024 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="toV2w23W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E461C5490
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733517392; cv=none; b=SHhgNL2k9zAoZJaCa+Rej13rl+6zB0PtF152GE1w2/7g2EORNy9JtCzrQwRFMz9wj+DO8XbtR2i2OEVK3XwceL81W+yh3VFbabBc4yEl5WFgaHm4DRByrTMUdG340eSNrcCDV09RazUFZeuM0rj1YPyo/AQ86N21inZR/+s97lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733517392; c=relaxed/simple;
	bh=KPUnA/DAooxUmpvmf5bmcLf5M+sxhOC33eNyhCkDvCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbTh/zxdA/smStxBJnNUP8eG0ZAd45nsYNvAktG9zILcm8I6kQMUk+OmD+plkSmRBOdvOH5tDBE2tNpXmJArhwNlGEvVGo36sSxshpiEpQWjxzzEuEv8OdoKza59SvejTy4GY2f8+mZtY2zqoUrZx6Lc5wDGF1Jj5ctt+l3M1rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=toV2w23W; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 6 Dec 2024 12:36:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733517386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mysp93q6txdVK9ODKK5SOHhK+j41MxmLkBXwCweCYKo=;
	b=toV2w23WUh5jQXGlah70eBb3KgJumJOcyLkcShabfhhDSzmq2u80ctydfDTG6acmQwPpKp
	qh9sfzq1aIdfmra7YECG9VdeBetZDTb2LhgHAuY4i1NoV4ObGelAIEpfKXZ++Qz7T8VKnw
	MdtnIwXFS2koUZTkcloJeGyjEUV1Jdg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, bernd.schubert@fastmail.fm, 
	willy@infradead.org, kernel-team@meta.com
Subject: Re: [PATCH v2 00/12] fuse: support large folios
Message-ID: <spdqvmxyzzbb6rajv6lvsztbf5xojtxfwu343jlihnq466u7ah@znmv7b6aj44x>
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
X-Migadu-Flow: FLOW_OUT

On Fri, Dec 06, 2024 at 09:41:25AM -0800, Joanne Koong wrote:
> On Fri, Dec 6, 2024 at 1:50 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
[...]
> >
> > >
> > > Writes are still effectively one page size. Benchmarks showed that trying to get
> > > the largest folios possible from __filemap_get_folio() is an over-optimization
> > > and ends up being significantly more expensive. Fine-tuning for the optimal
> > > order size for the __filemap_get_folio() calls can be done in a future patchset.
> 
> This is the behavior I noticed as well when running some benchmarks on
> v1 [1]. I think it's because when we call into __filemap_get_folio(),
> we hit the FGP_CREAT path and if the order we set is too high, the
> internal call to filemap_alloc_folio() will repeatedly fail until it
> finds an order it's able to allocate (eg the do { ... } while (order--
> > min_order) loop).
> 

What is the mapping_min_folio_order(mapping) for fuse? One thing we can
do is decide for which range of orders we want a cheap failure i.e. without
__GFP_DIRECT_RECLAIM and then the range where we are fine with some
effort and work. I see __GFP_NORETRY is being used for orders larger
than min_order, please note that this flag still allows one iteration of
reclaim and compaction, so not necessarily cheap.

