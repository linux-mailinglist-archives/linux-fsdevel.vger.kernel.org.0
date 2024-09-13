Return-Path: <linux-fsdevel+bounces-29367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CBC978A9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 23:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2098E1F24E91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 21:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E0A155333;
	Fri, 13 Sep 2024 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D2MX1hXV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612FA1E884;
	Fri, 13 Sep 2024 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726263024; cv=none; b=AAWdUFMEusM3pAbz0/s2oUD60s6BvXY3/83IbF6ZOwZsd3X1tDr0YGLYGE0epf/AZtzGx3BDxEZmrI+RY5hMu0Jm88LzFj8ekUIqcDb9ru+z7vP/AFA81nggUp62NJMbjmMJYGGlcX87wNr32wZirEeECngchzPJbsqalvRpNzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726263024; c=relaxed/simple;
	bh=+k6ZxvwrVNCbKN2u3wk5AlFx1/04DtTREo4MFxRD448=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0t5BiLvVVwzTdYSPxpQzpxCuxd2h0IWS5g+/2m8OHagdxqtoD+44xLsPXNSXiUFtFefq/4PenKisX/ZbBKbFwIX/3feQQ6KuztPtceVVRK0wmyXykwCCXRHcXzZuwWfYwynBaJy1f/tPyVGeyLqhPvfUznxDafoCubjaIBR9g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D2MX1hXV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yZFmPPNNPyPVHwqQRbgbAhRYsxST8nX90G2qtvqpxNQ=; b=D2MX1hXVqxM+b2Tq+Hvw4tocOz
	DLg4I0ge4lCMRtXGKFXcDCDoqiHz5uV1jey6HcaRGdhqNsDq9kaCOD5GMwYGdJKL8u8nr7RPusfWP
	eCqHGxooSUSBS+L++H6Yi3XWDxfxioPGIdJLfAENLQC0MQVFfRTUrqaSYUvpEVihXoTDulMulQq2t
	AljQWD4jAGxQX52sidyhG1KiJU49IgAxxXi3tze/1mhSFUpP5OOOkq+1AkFxkE9jRQuMTf3hPJoY+
	LEAIYHHmZC4S0va6eJosOkNqz1Tx9qQNupkHhQ8tllOPDy7Knx+PzDsSMEV80kR0i79uQHlx40Gpx
	+cWxG3ig==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1spDrr-0000000H0er-3mFV;
	Fri, 13 Sep 2024 21:30:16 +0000
Date: Fri, 13 Sep 2024 22:30:15 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Chris Mason <clm@meta.com>, Jens Axboe <axboe@kernel.dk>,
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Dao <dqminh@cloudflare.com>,
	Dave Chinner <david@fromorbit.com>, regressions@lists.linux.dev,
	regressions@leemhuis.info
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
Message-ID: <ZuSu51iMWr3PZ7ZW@casper.infradead.org>
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
 <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <d4a1cca4-96b8-4692-81f0-81c512f55ccf@meta.com>
 <ZuRfjGhAtXizA7Hu@casper.infradead.org>
 <b40b2b1c-3ed5-4943-b8d0-316e04cb1dab@meta.com>
 <ZuSBPrN2CbWMlr3f@casper.infradead.org>
 <CAHk-=wh=_n1jfSRw2tyS0w85JpHZvG9wNynOB_141C19=RuJvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh=_n1jfSRw2tyS0w85JpHZvG9wNynOB_141C19=RuJvQ@mail.gmail.com>

On Fri, Sep 13, 2024 at 02:24:02PM -0700, Linus Torvalds wrote:
> On Fri, 13 Sept 2024 at 11:15, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Oh!  I think split is the key.  Let's say we have an order-6 (or
> > larger) folio.  And we call split_huge_page() (whatever it's called
> > in your kernel version).  That calls xas_split_alloc() followed
> > by xas_split().  xas_split_alloc() puts entry in node->slots[0] and
> > initialises node->slots[1..XA_CHUNK_SIZE] to a sibling entry.
> 
> Hmm. The splitting does seem to be not just indicated by the debug
> logs, but it ends up being a fairly complicated case. *The* most
> complicated case of adding a new folio by far, I'd say.
> 
> And I wonder if it's even necessary?

Unfortunately, we need to handle things like "we are truncating a file
which has a folio which now extends many pages beyond the end of the
file" and so we have to split the folio which now crosses EOF.  Or we
could write it back and drop it, but that has its own problems.

Part of the "large block size" patches sitting in Christian's tree is
solving these problems for folios which can't be split down to order-0,
so there may be ways we can handle this better now, but if we don't
split we might end up wasting a lot of memory in file tails.

> It's possible that I'm entirely missing something, but at least the
> filemap_add_folio() case looks like it really would actually be
> happier with a "oh, that size conflicts with an existing entry, let's
> just allocate a smaller size then"

Pretty sure we already do that; it's mostly handled through the
readahead path which checks for conflicting folios already in the cache.

