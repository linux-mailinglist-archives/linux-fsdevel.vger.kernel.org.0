Return-Path: <linux-fsdevel+bounces-19088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582EF8BFC77
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 13:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA171F24F6F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 11:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E4783A18;
	Wed,  8 May 2024 11:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HHbd7SaA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4922839FC;
	Wed,  8 May 2024 11:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168564; cv=none; b=kvRj3AKvuwvvKCHGZlNm7mHvyGKjxN51p59BDvj74TwR/gVmBT+8ORE2X/h7eQjtaZ5hVQ2P1O78cZP7BZ2s6HH5VfFuhYU6OMvwC3Ov9YmY3chMWL1f72KWScgQSDFnmhXVZBoCW+v3CtFFclIFw4z9sreN54w0arJ4OB28Puo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168564; c=relaxed/simple;
	bh=lEmyUHC2s5VhpLeURQHuxXLUIuX5w1xayzBF9k0Bp9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEMHvyB1cil38tIYYZH9p8yc/iTov2Dujw3QIrnmG3P+wOWOs9b34Hk7pqfpG8RjkMAuDSxHbdCCtnlwmKw0/qXGw003tXrMzT9FaQXYlxbErRAoz0bF+ud4mP55OuPqMW+wb7JnwbfmvfO9xYSyoj+vBwCcnPNkzrDFEGyVvCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HHbd7SaA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BYab8gfnw71vLMZVwC4umL8NG4B6+6Id6Hpb6wOPWjk=; b=HHbd7SaAADfmXktCJOTkLr+66V
	AkDUd67kmMYelDBlifdDtViqKcxM6NNa0WZuLHAGmLtUB+2WRucyP3b3r63VEauAIsTtmUI1N2g9d
	j/3ko+aQVQ4UwWEPWLQUGNCQzozSxiX0vC/RoZhoRbmQhWV80UNlKa+Gp3pwQzZNtGQXdlqNMXVF5
	WYcZRiWIc8T3T7I9H6H8VVTMQMNGEvb+Cf+WamZ70/ZuvvFYk2+Y4c0MhrS3Go1p3PGrlEZmhO4TP
	ktr9UWzu0LOpDFypvammstDWUzo7p4kSO4X2da1/RQuNqhy46pk1Ro30IaOBxfEh7BkBett3mVBIc
	eeramhCg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4fgy-0000000FJ7p-0WDT;
	Wed, 08 May 2024 11:42:36 +0000
Date: Wed, 8 May 2024 04:42:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, hch@lst.de,
	willy@infradead.org, mcgrof@kernel.org, akpm@linux-foundation.org,
	brauner@kernel.org, chandan.babu@oracle.com, david@fromorbit.com,
	djwong@kernel.org, gost.dev@samsung.com, hare@suse.de,
	john.g.garry@oracle.com, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, p.raghav@samsung.com, ziy@nvidia.com
Subject: Re: [RFC] iomap: use huge zero folio in iomap_dio_zero
Message-ID: <ZjtlLH-y5eBE9W9g@infradead.org>
References: <87edado4an.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edado4an.fsf@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 08, 2024 at 12:08:56AM +0530, Ritesh Harjani wrote:
> Christoph Hellwig <hch@infradead.org> writes:
> 
> > On Tue, May 07, 2024 at 04:58:12PM +0200, Pankaj Raghav (Samsung) wrote:
> >> +	if (len > PAGE_SIZE) {
> >> +		folio = mm_get_huge_zero_folio(current->mm);
> >
> > I don't think the mm_struct based interfaces work well here, as I/O
> > completions don't come in through the same mm.  You'll want to use
> 
> But right now iomap_dio_zero() is only called from the submission
> context right i.e. iomap_dio_bio_iter(). Could you please explain the
> dependency with the completion context to have same mm_struct here?

mm_get_huge_zero_folio ties the huge folio reference to the mm_struct.
So when the process that kicked this off exists you lose the reference to
it.  Which doesn't make sense, we need it as long as the file system
is mounted.

> Even so, should we not check whether allocation of hugepage is of any
> value or not depending upon how large the length or (blocksize in case of
> mount time) really is.
> i.e. say if the len for zeroing is just 2 times the PAGE_SIZE, then it
> doesn't really make sense to allocate a 2MB hugepage and sometimes 16MB
> hugepage on some archs (like Power with hash mmu).

I'd kinda expect we'll just need it for so many other reasons that I
wouldn't worry.

> The hugepage allocation can still fail during mount time (if we mount
> late when the system memory is already fragmented). So we might still
> need a fallback to ZERO_PAGE(0), right?

Memory fragmentation should not prevent the allocation due to
compaction. And if we're really badly out of memory 2MB isn't going
to make the difference vs all the other memory used by an XFS file
system.


