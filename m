Return-Path: <linux-fsdevel+bounces-12718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FD1862A69
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 14:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD031C209F6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 13:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D678312E5D;
	Sun, 25 Feb 2024 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pLkNRu//"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F7C12B82
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708866651; cv=none; b=SALd9xV3pEXD3BrMdoXpPQXVbntvSxTgKusEqR9cP2hBsGSeRHaZoL1AVIyvSKBrY7hIrGcGEaD/BW+vSCqxsbDN81j2NvU3G1VWPYB7Q/z2KIisCwHComPOzJdTBNU3iDzcilgixT0iVVSCDehfdQ1lOKS3vsu2ILFhxhiS3+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708866651; c=relaxed/simple;
	bh=eaQQRa9SHoFJC5BamvA3EhSNfTDm+myRbrcAkH/aybA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjArouug9qTojmG7RBP0bw+0JEU47i9IIbRfBeAkOeq4RdYOP1yJXlq3figH+jIck0t08NGRz/JCCCHTOKiML8RdjRG+p0f8wwTikQxoRPECXPsuNHaZQkLGvEndHvpDYLT8cVcCrrKvx8QY3+c/x+5+UpRzFfcvp1nzv2yJCA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pLkNRu//; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZL8fhrvIsNWTDsH4Kkh9UJzj1Oneol0JDNfT7yC0CiY=; b=pLkNRu//xEeB+T99nwHZaNSTra
	YADuHVtLOrHqC3aPy+kOxW5/2hvFj8lnZ74fjDZDsuWiXQMenMmWovOiPWNqfj6BVGZ0wGGWJ0Gn+
	la+VKvmrHJmIuJfsdLXwnusCmL6gnPQLfULJuN9tXl85X7Si3daS6U02mqOGL5zULCcsXV5bHZFvg
	6UfTXa9Kot+no5Mg6Fi2g3ENcr4JGKijEPtnsKYjxM0BF/fKfsDY2XNQSgctXnFdS9XWLCxuBBerT
	OKmXMLWlnRaSwibr8vdHl//XP1JjA0rmTA3lJRZI6I0oVz7/toseJ/+RUHW/k4+hWOeP6kmk6+xMN
	WLDGFffA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reEH9-0000000E7be-1wgr;
	Sun, 25 Feb 2024 13:10:39 +0000
Date: Sun, 25 Feb 2024 13:10:39 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <Zds8T9O4AYAmdS9d@casper.infradead.org>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <Zdlsr88A6AAlJpcc@casper.infradead.org>
 <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
 <o4a6577t2z5xytjwmixqkl33h23vfnjypwbx7jaaldtldpvjf5@dzbzkhrzyobb>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o4a6577t2z5xytjwmixqkl33h23vfnjypwbx7jaaldtldpvjf5@dzbzkhrzyobb>

On Sun, Feb 25, 2024 at 12:18:23AM -0500, Kent Overstreet wrote:
> Before large folios, we had people very much bottlenecked by 4k page
> overhead on sequential IO; my customer/sponsor was one of them.
> 
> Factor of 2 or 3, IIRC; it was _bad_. And when you looked at the
> profiles and looked at the filemap.c code it wasn't hard to see why;
> we'd walk a radix tree, do an atomic op (get the page), then do a 4k
> usercopy... hence the work I did to break up
> generic_file_buffered_read() and vectorize it, which was a huge
> improvement.

There's also the small random 64 byte read case that we haven't optimised
for yet.  That also bottlenecks on the page refcount atomic op.

The proposed solution to that was double-copy; look up the page without
bumping its refcount, copy to a buffer, look up the page again to be
sure it's still there, copy from the buffer to userspace.

Except that can go wrong under really unlikely circumstances.  Look up the
page, page gets freed, page gets reallocated to slab, we copy sensitive
data from it, page gets freed again, page gets reallocated to the same
spot in the file (!), lookup says "yup the same page is there".
We'd need a seqcount or something to be sure the page hasn't moved.

