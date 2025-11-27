Return-Path: <linux-fsdevel+bounces-70078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C7CC900A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 20:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD1C334E07B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 19:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1983064BF;
	Thu, 27 Nov 2025 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bLoT/Fgl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2533130149D;
	Thu, 27 Nov 2025 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764272609; cv=none; b=NYF+a5atBRdF7iYNsPIRZhbzAEHRWCOIQalnyXPJkcA2+btF0rV18Ec6pVEn2gxaiXOVz2cmlabQhi+WNkNaq/ydOh+K/NfHnpGl9j37ow3t7KErbGdbiz7UD3b4KqoOB7LVBdpJdI1PsLA8Za0KZlm1XU2dqNimmnCi3RXHwwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764272609; c=relaxed/simple;
	bh=OK+CU8cNMmUIZJxdbIpvYN8hYF/RDiQRU5s420ZGKQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjNwOb2Tu7mPd4w4Yv4RTHX9ieVYK7Aqh1BDNA6bH7qzEwD5eCPsjl2006yl+y4Yrn5spKjAa1xs5NW7s9srfDZr2lJtmMhEXmspdZtAXntA0O5RIz0NH6NlQgELh0QJZro4sC6+qaQuk1w9nv/X+YvVl1t41+NXT6OyVkpXX/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bLoT/Fgl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=JQe+g5ZvR6KeivPEwk1LBLbeVJ2/39tSJLB6nZ8TM10=; b=bLoT/FglVGFQTp6ZQ56Yle6fs8
	ptqzHTWL95KXuhjuxl7XPt2gLgIOgk1wweluHsPyQ38cpDssH97HG3X9erEgS+i3X/bNy+BrSNtZX
	0Nx+1/7AoEl05gpR3MVH+L9M0aocNk7ibz8QPD2KslaJzakC7Ok8gfVaNO2YEVazZb2xxnmCHFpPF
	IGRfMUCoFpNAy2XF/qaFP5T/vm4M4wGNn6/Yp6Tnduny8zxbeHx1WOFYhR2vZjAP7vXkPR/loRBbS
	yrzAGHclbg4deP4UOsDu2voNxG+3XLZD1UdKAL75EZWsX6Dwl59DS2irr+1duhO8HSc3s96oSDErT
	Uno8xeEw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOhti-0000000CBWb-3MlU;
	Thu, 27 Nov 2025 19:43:22 +0000
Date: Thu, 27 Nov 2025 19:43:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] mm: continue using per-VMA lock when retrying
 page faults after I/O
Message-ID: <aSip2mWX13sqPW_l@casper.infradead.org>
References: <20251127011438.6918-1-21cnbao@gmail.com>
 <aSfO7fA-04SBtTug@casper.infradead.org>
 <CAGsJ_4zyZeLtxVe56OSYQx0OcjETw2ru1FjZjBOnTszMe_MW2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zyZeLtxVe56OSYQx0OcjETw2ru1FjZjBOnTszMe_MW2g@mail.gmail.com>

[dropping individuals, leaving only mailing lists.  please don't send
this kind of thing to so many people in future]

On Thu, Nov 27, 2025 at 12:22:16PM +0800, Barry Song wrote:
> On Thu, Nov 27, 2025 at 12:09 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Nov 27, 2025 at 09:14:36AM +0800, Barry Song wrote:
> > > There is no need to always fall back to mmap_lock if the per-VMA
> > > lock was released only to wait for pagecache or swapcache to
> > > become ready.
> >
> > Something I've been wondering about is removing all the "drop the MM
> > locks while we wait for I/O" gunk.  It's a nice amount of code removed:
> 
> I think the point is that page fault handlers should avoid holding the VMA
> lock or mmap_lock for too long while waiting for I/O. Otherwise, those
> writers and readers will be stuck for a while.

There's a usecase some of us have been discussing off-list for a few
weeks that our current strategy pessimises.  It's a process with
thousands (maybe tens of thousands) of threads.  It has much more mapped
files than it has memory that cgroups will allow it to use.  So on a
page fault, we drop the vma lock, allocate a page of ram, kick off the
read, sleep waiting for the folio to come uptodate, once it is return,
expecting the page to still be there when we reenter filemap_fault.
But it's under so much memory pressure that it's already been reclaimed
by the time we get back to it.  So all the threads just batter the
storage re-reading data.

If we don't drop the vma lock, we can insert the pages in the page table
and return, maybe getting some work done before this thread is
descheduled.

This use case also manages to get utterly hung-up trying to do reclaim
today with the mmap_lock held.  SO it manifests somewhat similarly to
your problem (everybody ends up blocked on mmap_lock) but it has a
rather different root cause.

> I agree there’s room for improvement, but merely removing the "drop the MM
> locks while waiting for I/O" code is unlikely to improve performance.

I'm not sure it'd hurt performance.  The "drop mmap locks for I/O" code
was written before the VMA locking code was written.  I don't know that
it's actually helping these days.

> The change would be much more complex, so I’d prefer to land the current
> patchset first. At least this way, we avoid falling back to mmap_lock and
> causing contention or priority inversion, with minimal changes.

Uh, this is an RFC patchset.  I'm giving you my comment, which is that I
don't think this is the right direction to go in.  Any talk of "landing"
these patches is extremely premature.

