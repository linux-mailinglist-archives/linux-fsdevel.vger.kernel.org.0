Return-Path: <linux-fsdevel+bounces-29276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D07F977772
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 05:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E380628466C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 03:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71BC1D12EA;
	Fri, 13 Sep 2024 03:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JOdq7coC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD5C8827;
	Fri, 13 Sep 2024 03:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726199066; cv=none; b=AV205LqqXDD1zdFW+crscVN4OSC0189SI14lBLnoRMFxAzH7eb3rv95DwZaWcQ9uKxJ9MGtWe39aRDiIsc64NJ/2PZvWfpSKshZ8tiRG3xZHU6FrcpRBiclGVBC3vBXhyuhTyVf7N+bm4BWCSvuuSxxC4hKp8IT7DqQWaCbrN6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726199066; c=relaxed/simple;
	bh=/m4GfWd3oU9aBz87wq0gfZPIiwHASnEq9/Vz2lV/oe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfRFNPkNs4FlVyQ0Wbi1VSC/d5JV0OgIalJwI5jyh/9/sT/dSmL7dcLl+88jimQH+GE8lI2t/dxl/hSxCnTPBe14q0zAjoO+2ciqDAMewiFFETh68jpX8LbmilUXi0IFkuvgFmEEg0lapCaXfXWfDWlv8n79fyOon5X9kxOpnxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JOdq7coC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RvfXQ9uvEs2BWWmkp13Rn+2w03z6x8sxWgVmbE+dLsk=; b=JOdq7coCdU6dtWavSvoUMfgrkb
	HkADbUmaigqOAD9xt0G4oLZPvfAPkdxAFR/9izSAnmePGYc1AvjFz080+NLrvCIcADY9LkHjCTjCh
	1zmlQw1FsW0jgAUWCa6Gk7b8eAelPrR1BjOU1mK+mIEhAMXWWMFRsyFs/578cNsU7Zpd2IB6iz7Vx
	IXiLEB7YFP9nr9k/lVXJ6uAJ1oHMCv5UiinGibHQFfuMLsvsn6AD5/JiotmGckfolhF0U7L0Z7zEo
	8ytsOnorp5ox7o3K1IJaEBqylesxq0Um4ewmL6vrPDszY7tbyJ0Ou+C1oBbY2SP3nFCDB1+7X3BFe
	8fpoFTGg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1soxEA-0000000G4tf-1dYV;
	Fri, 13 Sep 2024 03:44:10 +0000
Date: Fri, 13 Sep 2024 04:44:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Theune <ct@flyingcircus.io>,
	linux-mm@kvack.org,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Dao <dqminh@cloudflare.com>,
	Dave Chinner <david@fromorbit.com>, clm@meta.com,
	regressions@lists.linux.dev, regressions@leemhuis.info
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
Message-ID: <ZuO1CtpGgwyf8Hui@casper.infradead.org>
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
 <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <415b0e1a-c92f-4bf9-bccd-613f903f3c75@kernel.dk>
 <CAHk-=wg51pT_b+tgHuAaO6O0PT19WY9p3CXEqTn=LO8Zjaf=7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg51pT_b+tgHuAaO6O0PT19WY9p3CXEqTn=LO8Zjaf=7A@mail.gmail.com>

On Thu, Sep 12, 2024 at 03:56:17PM -0700, Linus Torvalds wrote:
> On Thu, 12 Sept 2024 at 15:30, Jens Axboe <axboe@kernel.dk> wrote:
> >
> > It might be an iomap thing... Other file systems do use it, but to
> > various degrees, and XFS is definitely the primary user.
> 
> I have to say, I looked at the iomap code, and it's disgusting.

I'm not going to comment on this because I think it's unrelated to
the problem.

We have reports of bad entries being returned from page cache lookups.
Sometimes they're pages which have been freed, sometimes they're pages
which are very definitely in use by a different filesystem.

I think that's what the underlying problem is here (or else we have
two problems).  I'm not convinced that it's necessarily related to large
folios, but it's certainly easier to reproduce with large folios.

I've looked at a number of explanations for this.  Could it be a page
that's being freed without being removed from the xarray?  We seem to
have debug that would trigger in that case, so I don't think so.

Could it be a page with a messed-up refcount?  Again, I think we'd
notice the VM_BUG_ON_PAGE() in put_page_testzero(), so I don't think
it's that either.

My current best guess is that we have an xarray node with a stray pointer
in it; that the node is freed from one xarray, allocated to a different
xarray, but not properly cleared.  But I can't reproduce the problem,
so that's pure speculation on my part.

