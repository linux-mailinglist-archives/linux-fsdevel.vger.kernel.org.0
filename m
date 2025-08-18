Return-Path: <linux-fsdevel+bounces-58190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC79B2ADC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 18:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07701961B09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 16:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48A8335BBC;
	Mon, 18 Aug 2025 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nvg6YV+v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB14322C66;
	Mon, 18 Aug 2025 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755533336; cv=none; b=T21n5FaXbbduWoolRC9QBvUjK19vXGome/OxZqOzO4+L+7nFvjkMgrXzKErGrEe8gqwhZAftj24CeN8Zi4yyIukWdMwRbisLHoKTpAkXCs5fIiyYKMThLYrXWQPzpeXvma4mQz+usRNMg2cIm9BpmaR2cEUqbWUppLnw9YVTjYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755533336; c=relaxed/simple;
	bh=UdGCmFEGEHdcwqEhmwdNM9Jw1ANM9uK1sFznAmDJTZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+IQucYBoD9i+9hrLD0SiFjLAM6NOGNDvvQZZ6psGZbrsifKQsEEbsCzqZyxpf3U/r56lwdkaxb5TigGf9k5lqaDTrSPixgHa6w+eDc4gA8xM4SpZqnUD6Lt/buGxn3o0in+hnxkRmwTMcihM6aSSM0p1luTx+zzRB5onq4Prts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nvg6YV+v; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ahlcvw0CG9EFcXpjOsyDakpp1kscynNMdyN1Mvg+wGM=; b=nvg6YV+ve12DBWofpc0jK3jC+D
	Gxsp2flKmsnxRk0yqHFC9cjoLMIZpsx80HSLlAmYytxW3pfgHp9EtiUl7lZI/32SgT2nREsF0uVRk
	HRrRM2IQh7r7PsX5HSXUANcbO4j4bA8kkDNG4DL0O5hXUPpnG540MVbhpIaQ56J6KUpssy/0nUqEw
	b9/ZoxZTsm4GvCXuvATaDg2p4WlhICh0HFd6uBGV76MyW9TFlCNQLhMvg8JZoVnyvd9E8mSr3MRud
	Kz1rCwPmP32i+nu7mVC95roxnMBt9TCqyJ0Coj177Zgm9qtY02SVN8wUZ6/cOSWf0iEtQn7pzxMmP
	Poi1BzsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo2Pk-00000008HRo-307E;
	Mon, 18 Aug 2025 16:08:52 +0000
Date: Mon, 18 Aug 2025 17:08:52 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v3 1/2] filemap: Add a helper for filesystems
 implementing dropbehind
Message-ID: <aKNQFBhhTIkUbK6e@casper.infradead.org>
References: <cover.1755527537.git.trond.myklebust@hammerspace.com>
 <ba478422e240f18eb9331e16c1d67d309b5a72cd.1755527537.git.trond.myklebust@hammerspace.com>
 <aKM99bjgILBwRQus@casper.infradead.org>
 <5109a45f43249d88882400f92e0cef27503c0704.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5109a45f43249d88882400f92e0cef27503c0704.camel@kernel.org>

On Mon, Aug 18, 2025 at 08:59:41AM -0700, Trond Myklebust wrote:
> On Mon, 2025-08-18 at 15:51 +0100, Matthew Wilcox wrote:
> > On Mon, Aug 18, 2025 at 07:39:49AM -0700, Trond Myklebust wrote:
> > > +void folio_end_dropbehind(struct folio *folio)
> > > +{
> > > +	filemap_end_dropbehind_write(folio);
> > > +}
> > > +EXPORT_SYMBOL(folio_end_dropbehind);
> > 
> > Why not just export filemap_end_dropbehind_write()?
> 
> It seemed more appropriate to use the 'folio' prefix when exporting, so
> that it is symmetric with folio_end_writeback().
> 
> I'm perfectly fine with changing that if people disagree.

I don't mind renaming filemap_end_dropbehind_write() to
folio_end_dropbehind() as a solution!

