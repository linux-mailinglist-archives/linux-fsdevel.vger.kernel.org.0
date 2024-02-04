Return-Path: <linux-fsdevel+bounces-10227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C708490B7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 22:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82B351C21CC2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 21:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8693F2C69A;
	Sun,  4 Feb 2024 21:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kjlY18EM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A0433995;
	Sun,  4 Feb 2024 21:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707082454; cv=none; b=SBnzcenzeogRVGpaOdNtzAytnTsf8O0HG3ahflPf2PHTtetTZVu7XGx/QtLqTzGvU8GmyF3tYRt4KCsNOiH9oWyZSSGPRj3wunC/uvzOtpixqeFNziBAb+PbKy2hnKP+64X1isV8ASjs18fsi/34BXayBMmo6dpN5dpfxLzaHLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707082454; c=relaxed/simple;
	bh=lsCB2VcRgo9zfs5ZsYcXyaJzIxWS69uxiBljQAreJqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpCJpEEGnEyVAg/eHbkHlraER/yR64wi0M9K8HxJ+UQLX77ZuBTTjAOGteS/Fge67RZE/GZ/1iQxFlltE0NcTle4qfcuaT//bePE4qgusjZucFefXq/KG9wSkP7jDTPqoXNlrgYyg9NinPG4+hwBQSiUI/4zHDAndCxL70M1b4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kjlY18EM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oUPc0T9g01EBpJOFoKdeHugi9gR06zfpezwQo4Xu2qY=; b=kjlY18EMquQO4rPsntbj3dj6j9
	N1MmlpTUgmNoPzoUvDd3yGgPhXrBQRJwzwP9CxdAQiv7He8LE68yVAwI0Ei7Njjzmr82gTLKKf8Pj
	OhHhUhmf64OYQIYOD9kQjgngDF2oZqlaFY9KIpl6FzJxtDqbkVND2v1/fSWqDSviYl0TAfWR7vr4+
	MdfTEJIheGzRRQTlMu7dALld7MDz2YZvG5gf2oUm8746PYZm3GwxQfsR0z6xFR0QWxUPKUBPydhlN
	qhT+IXfYIR/q13gE/7DFyxuWDFTtEL4Twt6TiMLpUpn6hGz/oAXBB/WzDAjUs4QcoctYYWO0YXsGr
	q6jzPD5g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWk7l-00000007dDv-24V5;
	Sun, 04 Feb 2024 21:34:01 +0000
Date: Sun, 4 Feb 2024 21:34:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Reclaiming & documenting page flags
Message-ID: <ZcACya-MJr_fNRSH@casper.infradead.org>
References: <Zbcn-P4QKgBhyxdO@casper.infradead.org>
 <Zb9pZTmyb0lPMQs8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zb9pZTmyb0lPMQs8@kernel.org>

On Sun, Feb 04, 2024 at 11:39:33AM +0100, Mike Rapoport wrote:
> On Mon, Jan 29, 2024 at 04:32:03AM +0000, Matthew Wilcox wrote:
> > Our documentation of the current page flags is ... not great.  I think
> > I can improve it for the page cache side of things; I understand the
> > meanings of locked, writeback, uptodate, dirty, head, waiters, slab,
> > mlocked, mappedtodisk, error, hwpoison, readahead, anon_exclusive,
> > has_hwpoisoned, hugetlb and large_remappable.
> > 
> > Where I'm a lot more shaky is the meaning of the more "real MM" flags,
> > like active, referenced, lru, workingset, reserved, reclaim, swapbacked,
> > unevictable, young, idle, swapcache, isolated, and reported.
> > 
> > Perhaps we could have an MM session where we try to explain slowly and
> > carefully to each other what all these flags actually mean, talk about
> > what combinations of them make sense, how we might eliminate some of
> > them to make more space in the flags word, and what all this looks like
> > in a memdesc world.
> > 
> > And maybe we can get some documentation written about it!  Not trying
> > to nerd snipe Jon into attending this session, but if he did ...
> 
> I suspect Jon will be there anyway, but not sure he'd be willing to do the
> writing :)
> 
> I was going to propose the "mm docs" session again, but this one seems more
> useful than talking yet again about how hard it is to get MM documentation
> done.

I'm doing my best to write documentation as I go.  I think we're a bit
better off than we were last year.  Do we have scripts to tell us which
public functions (ie EXPORT_SYMBOL and static inline functions in header
files) have kernel-doc?  And could we run them against kernels from, say,
April 2023, 2022, 2021, 2020, 2019 (and in two months against April 2024)
and see how we're doing in terms of percentage undocumented functions?

There's also the problem of getting long-form documentation done.
But I think that's a different problem from getting kernel-doc written.
Looking at the 55 commits in the last year to Documentation/mm, we seems
to be doing a pretty good job of keeping the documentation we have up
to date.  Just not a great job of adding new documentation.

