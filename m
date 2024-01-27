Return-Path: <linux-fsdevel+bounces-9219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB6283EF86
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 19:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573CF1C21FDF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 18:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1912E40E;
	Sat, 27 Jan 2024 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lELbwOzz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C1D1E514;
	Sat, 27 Jan 2024 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706381022; cv=none; b=j3aPwxKkURCFEexo5jwJR5U6MoJuuc8p89jC/z+y1M1kkP4iDMoy1YzwTzq7/DHbCT2mOpWU/cVKemDkEARBH28pY5+oPmN4lbbjnxsIUhB89XpmvgK/C4Fi5CfOwg1+gmw/dZHSEIxDKbzeeegoL4ZkbORo4Cs1miNCw+TyhDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706381022; c=relaxed/simple;
	bh=o90Uy09FMG+nY6hJBnszRS178dx2FJoI9DHsL7uc4jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/YHG8aheootNFnzcDuuy6G7EkFo8hwOKCOJlrJl8+bHBh9b9J0eEi74OeyrYe4YhHhWKHQuwySPizXyg4Y8KV6SRTnqPd0R3u3S74a4xOeRIc8FrqrmBN4IPRf32JKrCNsHvRtZ7J8xQXriOfAAYnnxhYTMwTm55QSH1GzAB9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lELbwOzz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X6dqNNaFcBPAuUj/Qb7BL8mzsncc4vwb10YQ9AHh2wU=; b=lELbwOzzp1TR91on867emJBA1d
	avobqrdJ8X7yB9badToi0BoMO96MowyanbyF5LaeRj65WWbJbwni699zGz/2EG8LVzbhIQIZQHJ66
	ZEOhKelSRC9LdHVTE/Qv/LzJsoEhFTcX3pSrMMHV8vraAYReK0RhQVbAp5wv1iF7LCp+D3iQ4GZ6F
	Ik//ZLI7LL9Eqh3cUFXOhbEM55uQij82k1lfPkCdZw/SJhA7C1ITmkWtfCxI+Q9bSGz2z1LBaiTsZ
	NUS3eWu46fYn809l7rTxCMLJvNvauvvXIIPMCbg/oSIskf8I7CYTgvFKUE4YX58ztH/r9QBdsy2gv
	QxiM558g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTneT-00000000400-0bqE;
	Sat, 27 Jan 2024 18:43:37 +0000
Date: Sat, 27 Jan 2024 18:43:37 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
Message-ID: <ZbVO2RKhw-dLUMvf@casper.infradead.org>
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
 <yrswihigbp46vlyxqvi3io5pfngcivfwfb3gdlnjs6tzntldbx@mbnrycaujxb3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yrswihigbp46vlyxqvi3io5pfngcivfwfb3gdlnjs6tzntldbx@mbnrycaujxb3>

On Sat, Jan 27, 2024 at 12:57:45PM -0500, Kent Overstreet wrote:
> On Fri, Jan 19, 2024 at 04:24:29PM +0000, Matthew Wilcox wrote:
> >  - What are we going to do about bio_vecs?
> 
> For bios and biovecs, I think it's important to keep in mind the
> distinction between the code that owns and submits the bio, and the
> consumer underneath.
> 
> The code underneath could just as easily work with pfns, and the code
> above got those pages from somewhere else, so it doesn't _need_ the bio
> for access to those pages/folios (it would be a lot of refactoring
> though).
> 
> But I've been thinking about going in a different direction - what if we
> unified iov_iter and bio? We've got ~3 different scatter-gather types
> that an IO passes through down the stack, and it would be lovely if we
> could get it down to just one; e.g. for DIO, pinning pages right at the
> copy_from_user boundary.

Yes, but ...

One of the things that Xen can do and Linux can't is I/O to/from memory
that doesn't have an associated struct page.  We have all kinds of hacks
in place to get around that right now, and I'd like to remove those.

Since we want that kind of memory (lets take, eg, GPU memory as an
example) to be mappable to userspace, and we want to be able to do DIO
to that memory, that points us to using a non-page-based structure right
from the start.  Yes, if it happens to be backed by pages we need to 'pin'
them in some way (I'd like to get away from per-page or even per-folio
pinning, but we'll see about that), but the data structure that we use
to represent that memory as it moves through the I/O subsystem needs to
be physical address based.

So my 40,000 foot view is that we do something like get_user_phyrs()
at the start of DIO, pas the phyr to the filesystem; the filesystem then
passes one or more phyrs to the block layer, the block layer gives the
phyrs to the driver which DMA maps the phyr.

Yes, the IO completion path (for buffered IO) needs to figure out which
folios are decsribed by this phyr, but that's a phys_to_folio() call away.

