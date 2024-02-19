Return-Path: <linux-fsdevel+bounces-12057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6459E85ACE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 21:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20DD9288F93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 20:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEA6535C6;
	Mon, 19 Feb 2024 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J3w1tZlH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F4251C5F;
	Mon, 19 Feb 2024 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708373630; cv=none; b=EG9pOGa/4HkE+pKIE0Y459YINqTPUoXAFbg4Uu0LJdgK4okwwXVzUC5iye/tsd2mcFKH+qYoNPlZuOg7SRwOtrBJbFS9aCnp8ZWBDl/taluaTx52JwXh72XnZAjinZJrvh+I7If2oBoP1W3xsD3y7m1sV7APCd5hjgUsc6wjz98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708373630; c=relaxed/simple;
	bh=GwZAYrAuDcsDsQed6SP/B+Tv7/f9pk2vi2Hp9BGCVi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4VjPX/D2YlFsxoV+nHMhcAue6m7mGnZZIaZQfj9HzmL4GK94pWZ+oMl2qz+FWVgEBxG8FpyH+qi59csZaS7WYpPuUhst9j5QFp5/ERSI2q1cCL6sPwFfQnE6YKalHux9CfZ5zEmWmrd7xp6KrLFkPWGzlTaW3ERXW8iOIE5TNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J3w1tZlH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Jchb+LZCv2qEJtD+Rt9qzwfdoWc+U+2jiOKWjU4NWow=; b=J3w1tZlHo7drwooqkjX3y5SPfH
	elaMwmvPoX1hmpg+4MB+cvamg309guKr/Ij2Y6t81FG4QQUXolrnW9AUb0SOp3+MK6Ie3VVQP3a+B
	4qZ90X44sLH/lAnfmD3eeelqIMhkJOgeoLSevHh91GjJ5TmJfsDTNFaAKSCd23L28KzNUXaDcUunY
	HPTk5lWwmN0VUSVaPnhMxLoHcMDre1m70lSGojq4FjeyhUPbbSR9IKfD/GuJzTrpogXa4wracCW9z
	ZnjwkrluXe78+suPeKnfQquNV1HZkGZ9jbVhHpsSobEIXAOMuEZZgbrzezqoSfQhfvl4dUmSsYV28
	ZmkmHbGA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcA1I-0000000DgB5-1OL3;
	Mon, 19 Feb 2024 20:13:44 +0000
Date: Mon, 19 Feb 2024 20:13:44 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Reclaiming & documenting page flags
Message-ID: <ZdO2eABfGoPNnR07@casper.infradead.org>
References: <Zbcn-P4QKgBhyxdO@casper.infradead.org>
 <Zb9pZTmyb0lPMQs8@kernel.org>
 <ZcACya-MJr_fNRSH@casper.infradead.org>
 <ZcOnEGyr6y3jei68@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcOnEGyr6y3jei68@kernel.org>

On Wed, Feb 07, 2024 at 05:51:44PM +0200, Mike Rapoport wrote:
> On Sun, Feb 04, 2024 at 09:34:01PM +0000, Matthew Wilcox wrote:
> > I'm doing my best to write documentation as I go.  I think we're a bit
> > better off than we were last year.  Do we have scripts to tell us which
> > public functions (ie EXPORT_SYMBOL and static inline functions in header
> > files) have kernel-doc?  And could we run them against kernels from, say,
> > April 2023, 2022, 2021, 2020, 2019 (and in two months against April 2024)
> > and see how we're doing in terms of percentage undocumented functions?
> 
> We didn't have such script, but it was easy to compare "grep
> EXPORT_SYMBOL\|static inline" with ".. c:function" in kernel-doc.
> We do improve slowly, but we are still below 50% with kernel-doc for
> EXPORT_SYMBOL functions and slightly above 10% for static inlines.

Thanks for doing this!  Data is good ;-)

I just came across an interesting example of a function which I believe
should NOT have kernel-doc.  But it should have documentation for why it
doesn't have kernel-doc!  Any thoughts about how we might accomplish that?

The example is filemap_range_has_writeback().  It's EXPORT_SYMBOL_GPL()
and it's a helper function for filemap_range_needs_writeback().
filemap_range_needs_writeback() has kernel-doc, but nobody should be
calling filemap_range_has_writeback() directly, so it shouldn't even
exist in the htmldocs.  But we should have a comment on it saying
"Use filemap_range_needs_writeback(), don't use this", in case anyone
discovers it.  And the existance of that comment should be enough to
tell our tools to not flag this as a function that needs kernel-doc.


