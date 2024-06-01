Return-Path: <linux-fsdevel+bounces-20711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A72A8D7169
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 19:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CA51C20C24
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 17:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7421153BD9;
	Sat,  1 Jun 2024 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="usOr6DVG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF9D26AF6
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Jun 2024 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717264318; cv=none; b=uQ/2nRt6OLUZYySuqeuZ7uHk83B4P2nrNMHnSi1/wYNs65ADk/tteAeU/jV9ERgV/8+Hh92l/X+3rBWp/JfViBWcJvCvEMPTvXMHjGxTy7YFDan/AgvfP1sU83FzTlj5qtlQJBLaZrMc9ONR14lkvC5onbPQaykTVk0Gpyy7wKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717264318; c=relaxed/simple;
	bh=8V1ubKEyQ3e7H8A/w7DRiM3nW8hgyL58Bajr80atib8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6GPifbeNzET1GaQuqKeqlb0CXdJOWNmYJi9FLAs0lFNk7mxrehC2Pe8+2+GsJJEtgvaACMz0dQEEBqaNp5AONGusXhasWoa22U204znW/GvhfGaRG+wXOyoMtSFJR6mEF8dVG4C3V+1Mi1cgvEdthVHK8isUIdDpkMdegqSCvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=usOr6DVG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e3H8ZnKQ2E/gGeLDugd4OQeoR4SU0nPKKSaqfqZJIe4=; b=usOr6DVGa75frbZI5HDsskF0il
	o64h/n1TgsL/TZinf4GhTSIpP4l22GB8cx2dGpAeyZ8y4WICZpJix0dQKn7vsuR6BrjEXOIsug13s
	tsbr04GrUpLzrFS+szIrkFegEQ/PugTqdo3em7R43hOPP1VXKfYrusX8i4teNCzSI0PGNZNVxXcmi
	SjDDVT3AZzDOaq8gNRZ18oOu1ufPTn6NvtUmGoErbDM2lPW2vCyMDNFQanXhoOs5rSYRb8h229XaK
	HxIwfjO2I71VRp8S75hZlCWBQvN79oCwxJOhZ4TjtG6d+6idpVhi2xIp10ZqfICfH0fXktTOYoUJW
	/X6Fg66w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDStN-0000000ChWn-3zwu;
	Sat, 01 Jun 2024 17:51:45 +0000
Date: Sat, 1 Jun 2024 18:51:45 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Johannes Thumshirn <jth@kernel.org>, linux-fsdevel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] zonefs: move super block reading from page to folio
Message-ID: <ZltfsUjv9RaVWCtd@casper.infradead.org>
References: <20240514152208.26935-1-jth@kernel.org>
 <Zk6e30EMxz_8LbW6@casper.infradead.org>
 <20240531011616.GA52973@frogsfrogsfrogs>
 <5eedc500-5d85-4e41-87b5-61901ca59847@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eedc500-5d85-4e41-87b5-61901ca59847@kernel.org>

On Fri, May 31, 2024 at 10:28:50AM +0900, Damien Le Moal wrote:
> >> This will stop working at some point.  It'll return NULL once we get
> >> to the memdesc future (because the memdesc will be a slab, not a folio).
> > 
> > Hmmm, xfs_buf.c plays a similar trick here for sub-page buffers.  I'm
> > assuming that will get ported to ... whatever the memdesc future holds?

I don't think it does, exactly?  Are you referring to kmem_to_page()?
That will continue to work.  You're not trying to get a folio from a
slab allocation; that will start to fail.

> >> I think the right way to handle this is to call read_mapping_folio().
> >> That will allocate a folio in the page cache for you (obeying the
> >> minimum folio size).  Then you can examine the contents.  It should
> >> actually remove code from zonefs.  Don't forget to call folio_put()
> >> when you're done with it (either at unmount or at the end of mount if
> >> you copy what you need elsewhere).
> > 
> > The downside of using bd_mapping is that userspace can scribble all over
> > the folio contents.  For zonefs that's less of a big deal because it
> > only reads it once, but for everyone else (e.g. ext4) it's been a huge
> 
> Yes, and zonefs super block is read-only, we never update it after formatting.
> 
> > problem.  I guess you could always do max(ZONEFS_SUPER_SIZE,
> > block_size(sb->s_bdev)) if you don't want to use the pagecache.
> 
> Good point. ZONEFS_SUPER_SIZE is 4K and given that I only know of 512e and 4K
> zoned block devices, this is not an issue yet. But better safe than sorry, so
> doing the max() thing you propose is better. Will patch that.

I think you should use read_mapping_folio() for now instead of
complicating zonefs.  Once there's a grand new buffer cache, switch to
that, but I don't think you're introducing a significant vulnerability
by using the block device's page cache.

