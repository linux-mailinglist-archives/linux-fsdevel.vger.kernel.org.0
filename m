Return-Path: <linux-fsdevel+bounces-74243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 592EAD388DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 22:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5AA3B3024A15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 21:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51CF2EBDFA;
	Fri, 16 Jan 2026 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Js7JdMr/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315DB307AC2
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 21:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768599944; cv=none; b=l7biwP8lGUk40YsLH/cjmYDo1tu+DwjIScdtn7w0s+uVBROJFR5RXeQYxhGN9JX+TvrgniLP7c22ouaVbM2rpBGqldH22DqcZuN/VMLA63oX2fRce1vZWyqARv3TTtSXu7TeUC/FApEQehECTBwmCNaNxmz2xFnuEwUA78Vaiv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768599944; c=relaxed/simple;
	bh=zEjaWphlR/aUdvCwj/Y0zcRk65cC1Xd5W+HtunTO85c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0H4jaLwg4sKLh/ZNan99Aohr/szm4cT7VB5zRdFTJ+BqLo0UJYDJ7biOWjaPI1+2J1bqvvZoeHakUb/qpF3p2EQBkRUnmv2NcSQfZFep9XhR8t/L4z73HHMv74pfE7qrdMMFd8ZBR70qqOk1BWPfP1FSxYzvOwQCLF/e9ypGRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Js7JdMr/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=gCCyqPfXxDb2+x4lGtTgB0wGPKjbAO2aFI4UKU5grW0=; b=Js7JdMr/AVl0qMnn65joTMgPYm
	xlOBVYjgBryxSzAPel2YwC8ETWjqGh+svpbwKKg6CCyJ4MYrNUM2sZyqpBgVYrx5bBDkX/fht5jHL
	kMCr2nyRyDDm5F/zJfOA0MA4X7yIj060DhScNaW+glUtaJolUi0U3hyUBorzHeXavPyUZ7P0rG+a5
	nB3AtCj3qE/jtd5XrX+WQkhwa5q1VqzuGGdkCFsY5jp87/lUcoP3S1pF7rxDU27IZx9YfGE6qok+p
	Atza9XJ4CcjZhnWEuk1T4HttfAladOvJR/dWhi9Q9YlzB+FJ53n71tPpO97Z8aiTb3fZbN5ppeQKm
	w9mDuiUw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgrdQ-00000009uub-3zfS;
	Fri, 16 Jan 2026 21:45:36 +0000
Date: Fri, 16 Jan 2026 21:45:36 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iomap: fix readahead folio refcounting race
Message-ID: <aWqxgAfDHD5mZBO1@casper.infradead.org>
References: <20260116015452.757719-1-joannelkoong@gmail.com>
 <20260116015452.757719-2-joannelkoong@gmail.com>
 <aWmn2FympQXOMst-@casper.infradead.org>
 <CAJnrk1Zs2C-RjigzuhU-5dCqZqV1igAfAWfiv-trnydwBYOHfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Zs2C-RjigzuhU-5dCqZqV1igAfAWfiv-trnydwBYOHfA@mail.gmail.com>

On Fri, Jan 16, 2026 at 10:36:25AM -0800, Joanne Koong wrote:
> On Thu, Jan 15, 2026 at 6:52 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > > +                     if (!ifs) {
> > > +                             ctx->cur_folio = NULL;
> > > +                             if (unlikely(plen != folio_len))
> > > +                                 return -EIO;
> >
> > This should be indented with a tab, not four spaces.  Can it even
> > happen?  If we didn't attach an ifs, can we do a short read?
> 
> The short read can happen if the filesystem sets the iomap length to a
> size that's less than the folio size. plen is determined by
> iomap_length() (which returns the minimum of the iter->len and the
> iomap length value the filesystem set).

Understood, but if plen is less than folio_size(), don't we allocate
an ifs?  So !ifs && plen < folio_size() shouldn't be possible?  Or have
I misunderstood this part?

