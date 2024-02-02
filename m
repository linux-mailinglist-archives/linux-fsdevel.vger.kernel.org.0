Return-Path: <linux-fsdevel+bounces-10025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 850038471ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 15:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B3F1F2A417
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 14:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1C014077C;
	Fri,  2 Feb 2024 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XKYE+x3u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2094C17C77;
	Fri,  2 Feb 2024 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706884188; cv=none; b=dS4ks10DMhLgFSVtNZXkKEFK9MU5Rgbn5JVw0fLuLQINPpmzs9Vom9z7de9RilSpOZqEWBF3PTwtXrJHCsrO/blxs04aqh+UBek90L2aZASGUCN9IieYQIBQruVUNBW8y1/oPmBzFFqAprO6iAE3yA0n/gHuD+9IKNGvyRsjjag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706884188; c=relaxed/simple;
	bh=yQnFMwUPqT1dwV3rgVOzcOu8uxmqyURzCAvr1lxck9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iU00dFkw+1VYkfTKy1WO29h99JWlocKEG+M1CPoK3aPyczmTJP6F2qax8TxGl+hz1AV+/o1DIpKj5f4dFHXETcFx0Snv3/Z90FMSPaw5rQSMt/xWA4hR1IpHoUJJ0nJAKpy6tyNFFba9W882ybgR72UWqtGXhuAKyqT3cgrxwhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XKYE+x3u; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wP7ap7SwTE6cJeEes3sVUH/vFnz+eX+KSdmLVr5C1To=; b=XKYE+x3u9bB0tuGI/mGQ4xi5Sv
	pdMjLTE0LcFX2TLHGnBe6u6ld6fp8xdUYT0+pYZBK9H+Ts0IqvFc2YVlUFPdS0GywD8jSR95Chxhs
	+jzef2Fo+TiyloyChnxnsUD1lS7DSh2FpDgvK7nsYIZjDuK76U+nMANLkyc6REeD2V9d27s6aPooh
	4Ij8FkFzkZzF2B0uZZ5PKGJiSouTJfBuuiytuTgAzAI+mwjo5+HHM6YKRd4PuBj6UrpxwFRi91T11
	sWpFpcGUQYcytmMgC6K+mfFbjGvWxwBKi05OkRm3F9cfkikh8HAH2icgpi0+r4Vj7CbGwgTSI3XXB
	3G5SRSUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVuY0-00000001H82-3gby;
	Fri, 02 Feb 2024 14:29:40 +0000
Date: Fri, 2 Feb 2024 14:29:40 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Large folios, swap and fscache
Message-ID: <Zbz8VAKcO56rBh6b@casper.infradead.org>
References: <2701740.1706864989@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2701740.1706864989@warthog.procyon.org.uk>

On Fri, Feb 02, 2024 at 09:09:49AM +0000, David Howells wrote:
> The topic came up in a recent discussion about how to deal with large folios
> when it comes to swap as a swap device is normally considered a simple array
> of PAGE_SIZE-sized elements that can be indexed by a single integer.
> 
> With the advent of large folios, however, we might need to change this in
> order to be better able to swap out a compound page efficiently.  Swap
> fragmentation raises its head, as does the need to potentially save multiple
> indices per folio.  Does swap need to grow more filesystem features?

I didn't mention this during the meeting, but there are more reasons
to do something like this.  For example, even with large folios, it
doesn't make sense to drive writing to swap on a per-folio basis.  We
should be writing out large chunks of virtual address space in a single
write to the swap device, just like we do large chunks of files in
->writepages.

Another reason to do something different is that we're starting to see
block devices with bs>PS.  That means we'll _have_ to write out larger
chunks than a single page.  For reads, we can discard the extra data,
but it'd be better to swap back in the entire block rather than
individual pages.

So my modest proposal is that we completely rearchitect how we handle
swap.  Instead of putting swp entries in the page tables (and in shmem's
case in the page cache), we turn swap into an (object, offset) lookup
(just like a filesystem).  That means that each anon_vma becomes its
own swap object and each shmem inode becomes its own swap object.
The swap system can then borrow techniques from whichever filesystem
it likes to do (object, offset, length) -> n x (device, block) mappings.

> Further to this, we have at least two ways to cache data on disk/flash/etc. -
> swap and fscache - and both want to set aside disk space for their operation.
> Might it be possible to combine the two?
> 
> One thing I want to look at for fscache is the possibility of switching from a
> file-per-object-based approach to a tagged cache more akin to the way OpenAFS
> does things.  In OpenAFS, you have a whole bunch of small files, each
> containing a single block (e.g. 256K) of data, and an index that maps a
> particular {volume,file,version,block} to one of these files in the cache.

I think my proposal above works for you?  For each file you want to cache,
create a swap object, and then tell swap when you want to read/write to
the local swap object.  What you do need is to persist the objects over
a power cycle.  That shouldn't be too hard ... after all, filesystems
manage to do it.  All we need to do is figure out how to name the
lookup (I don't think we need to use strings to name the swap object,
but obviously we could).  Maybe it's just a stream of bytes.

