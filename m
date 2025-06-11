Return-Path: <linux-fsdevel+bounces-51227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF39AD4A11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 06:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64447189B9D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 04:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB2C20E034;
	Wed, 11 Jun 2025 04:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q9pBvlIh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B0417E;
	Wed, 11 Jun 2025 04:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749616496; cv=none; b=AlDZENcAMdD69fcRviDEFMn4h0TP2qhKb36Yy0h4wvZLFHl5o5rF5rVJHMuqzCHH2g7Ch2fjBJS19u1/0MJIGpWE7Yesoey+/jopDOELKgpT1hNASHcitMPtlJi/nul5bfu56d5gUs++ziWLzQDuDGjT7rkw8yzDNy2BK57x3h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749616496; c=relaxed/simple;
	bh=LthGE3fUU7Vln18kBGtSPyqKU3ZFcnQlq1EL1a4+Ex0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r334uPnx5+GwUi37ebdB1e/GtEqUrK7glkJrjoaRmeE1b387/wMwCQzF+EILrgLYmdLbnBYBotq1i/9rpxQk1YYlOgj6gcxyHv1VpbkKWcdfk8y4/E0z+2Fn2G/Y2/IcTV7ALCo+9g8njvTXYvFCFV9XSeNLpY6inPs6gKUCAc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q9pBvlIh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ARbjRh7/rnRbjvUmhBkINZLHyFvPiwwBlxyxyZKqeFE=; b=q9pBvlIhw7CmlRzuGDAnChYrve
	l7tTw7U8A9waVV9TjNjbhlc/YRyCLndgjnkRd7FmfIzS5BubAMCF/FdGJabjwQ+aWf1AK0dgoYpk7
	FEJN5Jc5zMRQiFtQh6Z8daA1FdCqLbPmzJq4DXufXapM/oRl6ih5reJcfJoz3crPmCmdqfwshsZ8x
	J0xGgZq3xr+aSlQD1DXfbBRmE+/upSARf2nNl9rUAe3sMQ5ww9zoG/I7FTqmDuhnaMgNZ2n/h+Uiu
	WkvF7UzDsq1q+zEHH3/kDyivsHYmapuok71Al/hYkiKU2IZmx2uqFbNTwEKyOrAZDOksk1mn6GOlx
	tZkJmq0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPDAo-0000000ADVi-2M9F;
	Wed, 11 Jun 2025 04:34:50 +0000
Date: Wed, 11 Jun 2025 05:34:50 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
	brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, bernd.schubert@fastmail.fm,
	kernel-team@meta.com, linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 5/8] iomap: add iomap_writeback_dirty_folio()
Message-ID: <aEkHarE9_LlxFTAi@casper.infradead.org>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-6-joannelkoong@gmail.com>
 <aEZoau3AuwoeqQgu@infradead.org>
 <20250609171444.GL6156@frogsfrogsfrogs>
 <aEetuahlyfHGTG7x@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEetuahlyfHGTG7x@infradead.org>

On Mon, Jun 09, 2025 at 08:59:53PM -0700, Christoph Hellwig wrote:
> On Mon, Jun 09, 2025 at 10:14:44AM -0700, Darrick J. Wong wrote:
> > > Where "folio laundering" means calling ->launder_folio, right?
> > 
> > What does fuse use folio laundering for, anyway?  It looks to me like
> > the primary users are invalidate_inode_pages*.  Either the caller cares
> > about flushing dirty data and has called filemap_write_and_wait_range;
> > or it doesn't and wants to tear down the pagecache ahead of some other
> > operation that's going to change the file contents and doesn't care.
> > 
> > I suppose it could be useful as a last-chance operation on a dirty folio
> > that was dirtied after a filemap_write_and_wait_range but before
> > invalidate_inode_pages*?  Though for xfs we just return EBUSY and let
> > the caller try again (or not).  Is there a subtlety to fuse here that I
> > don't know about?
> 
> My memory might be betraying me, but I think willy once launched an
> attempt to see if we can kill launder_folio.  Adding him, and the
> mm and nfs lists to check if I have a point :)

I ... got distracted with everything else.

Looking at the original addition of ->launder_page (e3db7691e9f3), I
don't understand why we need it.  invalidate_inode_pages2() isn't
supposed to invalidate dirty pages, so I don't understand why nfs
found it necessary to do writeback from ->releasepage() instead
of just returning false like iomap does.

There's now a new question of what the hell btrfs is up to with
->launder_folio, which they just added recently.

