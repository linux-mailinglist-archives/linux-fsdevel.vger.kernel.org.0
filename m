Return-Path: <linux-fsdevel+bounces-20595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967008D57AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 03:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535A4283C0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 01:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5521B6AD7;
	Fri, 31 May 2024 01:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQ+nE7yz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B631F15B3
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 01:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717118177; cv=none; b=ocwruqa5X46DesHx41LsWBsRRP8E3/lpuPxO0dvnKDNPAs0ENPwI5YPMy2Dpxh3F4LsTCvANWgJpRLT+07213iEMM1hjdGCzepTZ6hzx9u+3I/rSrhxrH6XAW8aoz2FAostB94NB1EH04jl+X4uZMC0CxU/mc4k11gvHyQL/3ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717118177; c=relaxed/simple;
	bh=N3oy0hqhs/so42+1H/KGvh4oiVuofoMpad6Lrlnn0EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKnQKnWqM5I4/YwFDTxkTalC4wHz/ylfJOtps+btDAUAfaxqqIDzv4ZFCVWVgPzAtUHzxxJ7K2mRHgDh/KDuKXp0QL4dof+60z6psaF8q80EsjpZc7MogG9zm5ugZM4mkIdcqL3DslcfY+CdQp3/U3GJrvaiBZcP+ev2yoeNbIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQ+nE7yz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771CFC32789;
	Fri, 31 May 2024 01:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717118177;
	bh=N3oy0hqhs/so42+1H/KGvh4oiVuofoMpad6Lrlnn0EA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQ+nE7yzYQo7vonpAWmyjfsV68v676NPyAm1JRmnxf9DNco1GEk+Q8+p0kqTr2xv8
	 DJHt6TYzzcpt5TKHTwS3NdjKe9jKO7UpoqR+pUkmkH2JGyssDzKA+GBKLWuEUx6rzI
	 nuSCPRZMiXPv21YEICT2DTBKAaKi98tH9cmcVvQ+ykzm2eNjA8zPnEnQcMUGY4dfJT
	 BS+TRIDiggNSEBlwO5S9y3xLxby65BafpIU/CWpr5HPs5WvdYH+1C244wAWWAjHc9Z
	 66/ffTiLH4JEf7TUXnVj84esHLC+ht7Vhd+88fy083ldRnkO5JuQ+vL3JSZBcIvHlA
	 r0BrrdAlB2//g==
Date: Thu, 30 May 2024 18:16:16 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Johannes Thumshirn <jth@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-fsdevel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] zonefs: move super block reading from page to folio
Message-ID: <20240531011616.GA52973@frogsfrogsfrogs>
References: <20240514152208.26935-1-jth@kernel.org>
 <Zk6e30EMxz_8LbW6@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk6e30EMxz_8LbW6@casper.infradead.org>

On Thu, May 23, 2024 at 02:41:51AM +0100, Matthew Wilcox wrote:
> On Tue, May 14, 2024 at 05:22:08PM +0200, Johannes Thumshirn wrote:
> > From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > 
> > Move reading of the on-disk superblock from page to kmalloc()ed memory.
> 
> No, this is wrong.
> 
> > +	super = kzalloc(ZONEFS_SUPER_SIZE, GFP_KERNEL);
> > +	if (!super)
> >  		return -ENOMEM;
> >  
> > +	folio = virt_to_folio(super);
> 
> This will stop working at some point.  It'll return NULL once we get
> to the memdesc future (because the memdesc will be a slab, not a folio).

Hmmm, xfs_buf.c plays a similar trick here for sub-page buffers.  I'm
assuming that will get ported to ... whatever the memdesc future holds?

> >  	bio_init(&bio, sb->s_bdev, &bio_vec, 1, REQ_OP_READ);
> >  	bio.bi_iter.bi_sector = 0;
> > -	__bio_add_page(&bio, page, PAGE_SIZE, 0);
> > +	bio_add_folio_nofail(&bio, folio, ZONEFS_SUPER_SIZE,
> > +			     offset_in_folio(folio, super));
> 
> It also doesn't solve the problem of trying to read 4KiB from a device
> with 16KiB sectors.  We'll have to fail the bio because there isn't
> enough memory in the bio to store one block.
> 
> I think the right way to handle this is to call read_mapping_folio().
> That will allocate a folio in the page cache for you (obeying the
> minimum folio size).  Then you can examine the contents.  It should
> actually remove code from zonefs.  Don't forget to call folio_put()
> when you're done with it (either at unmount or at the end of mount if
> you copy what you need elsewhere).

The downside of using bd_mapping is that userspace can scribble all over
the folio contents.  For zonefs that's less of a big deal because it
only reads it once, but for everyone else (e.g. ext4) it's been a huge
problem.  I guess you could always do max(ZONEFS_SUPER_SIZE,
block_size(sb->s_bdev)) if you don't want to use the pagecache.

<more mumbling about buffer caches>

--D

