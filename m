Return-Path: <linux-fsdevel+bounces-65636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 519D4C09E18
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 19:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886A1406DEF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 17:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5087F303A1A;
	Sat, 25 Oct 2025 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ECXAMnnY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A962A2FC027;
	Sat, 25 Oct 2025 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761415029; cv=none; b=IJUSKErmfUpmLAkIxXW/EvmouguH+OKqc0bq+FgGaqxMMsDkwS6vw4iLxjtz7/4jd5tm4D/b01bz3dig9V/J+5kpQowaYB+EZze4LEr0mMwcfb0LItjz0AM4ewcc/c7/d13iL9EPsvJ5hE3++tq9qE0DTngR4SS5h8oAWEB0+AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761415029; c=relaxed/simple;
	bh=bnsS9Z2tUWZFYzST6NRYQcpqSZJrSfuEGOlxVww4oN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDzhL7bMoHIAWlPvn5jfQLVWaQcKuhpuMcfrwq7tgVaYDmkOnbKfxbKaGX0LGCYwFS0jrv0XDHNr+O5GPtnulI8IEQLSe/6QhrMdDn/OxczhAYABQ3cHO9eoxQjfe2GXE2+EmfRh5EfJInI80wht02mMw5urZ6+NFfjt/6s11Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ECXAMnnY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z9vGoY+nbBaOsbKg03YXEdXl7WE0FeSV0k77hTLT5bU=; b=ECXAMnnYzkobhQTzmNKTN+D2JT
	LJwyNcLznU3digEnaytP90GukMfPxEKZNmmye4UGQ19jzCPM3wd8PiPgiIC7rzd+6qJXDIQYUGAyA
	2UjXIykYnLNnFjQKG2y5vqoMwm4cV0lUhRAAqEJlVF3M3zZ38cWcedP3YCY3Zo3DJvEsndNjmucqF
	tvLgUBTnHX9radZQYvZRG6yBwaTBX/qMTHGwJRZTD6p+bs9wPQvNqZ60kUFBpHzb8kJU1LZEJSGuJ
	mUz2Mv1HnWqADDRfXGwQitYT2Rk39kHpK7WCBCsp+5eG/+hoxz7/sVJnLd6cN+Qp+3TFITzoZ/ST+
	L/vzx7tQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCiVd-00000001ILI-4AtI;
	Sat, 25 Oct 2025 17:56:58 +0000
Date: Sat, 25 Oct 2025 18:56:57 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Baokun Li <libaokun@huaweicloud.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	linux-kernel@vger.kernel.org, kernel@pankajraghav.com,
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, yi.zhang@huawei.com, yangerkun@huawei.com,
	chengzhihao1@huawei.com, libaokun1@huawei.com,
	catherine.hoang@oracle.com
Subject: Re: [PATCH 22/25] fs/buffer: prevent WARN_ON in
 __alloc_pages_slowpath() when BS > PS
Message-ID: <aP0PachXS8Qxjo9Q@casper.infradead.org>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-23-libaokun@huaweicloud.com>
 <aPxV6QnXu-OufSDH@casper.infradead.org>
 <adccaa99-ffbc-4fbf-9210-47932724c184@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adccaa99-ffbc-4fbf-9210-47932724c184@huaweicloud.com>

On Sat, Oct 25, 2025 at 02:32:45PM +0800, Baokun Li wrote:
> On 2025-10-25 12:45, Matthew Wilcox wrote:
> > On Sat, Oct 25, 2025 at 11:22:18AM +0800, libaokun@huaweicloud.com wrote:
> >> +	while (1) {
> >> +		folio = __filemap_get_folio(mapping, index, fgp_flags,
> >> +					    gfp & ~__GFP_NOFAIL);
> >> +		if (!IS_ERR(folio) || !(gfp & __GFP_NOFAIL))
> >> +			return folio;
> >> +
> >> +		if (PTR_ERR(folio) != -ENOMEM && PTR_ERR(folio) != -EAGAIN)
> >> +			return folio;
> >> +
> >> +		memalloc_retry_wait(gfp);
> >> +	}
> > No, absolutely not.  We're not having open-coded GFP_NOFAIL semantics.
> > The right way forward is for ext4 to use iomap, not for buffer heads
> > to support large block sizes.
> 
> ext4 only calls getblk_unmovable or __getblk when reading critical
> metadata. Both of these functions set __GFP_NOFAIL to ensure that
> metadata reads do not fail due to memory pressure.

If filesystems actually require __GFP_NOFAIL for high-order allocations,
then this is a new requirement that needs to be communicated to the MM
developers, not hacked around in filesystems (or the VFS).  And that
communication needs to be a separate thread with a clear subject line
to attract the right attention, not buried in patch 26/28.

For what it's worth, I think you have a good case.  This really is
a new requirement (bs>PS) and in this scenario, we should be able to
reclaim page cache memory of the appropriate order to satisfy the NOFAIL
requirement.  There will be concerns that other users will now be able to
use it without warning, but I think eventually this use case will prevail.

> Both functions eventually call grow_dev_folio(), which is why we
> handle the __GFP_NOFAIL logic there. xfs_buf_alloc_backing_mem()
> has similar logic, but XFS manages its own metadata, allowing it
> to use vmalloc for memory allocation.

The other possibility is that we switch ext4 away from the buffer cache
entirely.  This is a big job!  I know Catherine has been working on
a generic replacement for the buffer cache, but I'm not sure if it's
ready yet.

