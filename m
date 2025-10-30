Return-Path: <linux-fsdevel+bounces-66524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0489AC22685
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 22:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7876B4EE2D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 21:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B29832E125;
	Thu, 30 Oct 2025 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gEZTFOgV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A86834D383;
	Thu, 30 Oct 2025 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761859555; cv=none; b=nmxJuahrU7yFM0WvqDD1znkrHfwKNch9E4J/ATd8jW5ujyr1V0Qnq3f46esYkYWuiybVwZeK3WjVSKrSECtIGU4L2ymSrJ1/6XcoEvOxDS1nI8fCBb2HUAe4/JL+kH6ncB3on/qYxYNCh5mg0kXqXKGgFl4NldBLvecdaskqKQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761859555; c=relaxed/simple;
	bh=Jmh6jMrP3dDORoX1+gJfwJb2pFOf6i45AQLL6Hzo/Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fc7guR9rBBR4g8zgcSOxNRRQ9i88Hu/W1aXANULdFDPIEieLcxQvhk7I5IcaHVfqfK7tIrg8kKm9Evmk+a7738gVMCoK14BNZuTSkcQVvcZbSetSKbDc9L2KeYrUIX2+YTZCSbPkLIVNBWzx83PSbWRkEeSViYB9vEeILJmDms0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gEZTFOgV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WQjgh76ocKn6tEir5dlln+rELO/KQ8E5wii4qcczHPc=; b=gEZTFOgVBA16zievEla5GynjUp
	PEyXMVqR2EUv2ROto/2cPQtzxjiwuSYjvtOdbriPADtwgo/DJXnzw3GqWRYCYX3+RMz5uMXbLbvRh
	9MinJUfmF9NsJsCBcRXCVwy95RGgFj9/wcDpiihdiDg50G1dkgoKMrlNMAji2QFNgffZdrBmd1RJi
	tWhDGBcPuHOJUSa28y/bIXNJvdcZ6Ol5atWR2O+pMM2XlD5Yc/vbnWqrAkLVMcYsSkQABgJl8/Uiv
	pLaf2suQ1vhKrtY3/ttlmI3WVsAOIn7iCFhO55ouG3KVBrvhXiXOM1RKpJW3lQU5jWPfLNR7iuXUy
	AY0QM0eg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEa9P-0000000DkEe-3SJR;
	Thu, 30 Oct 2025 21:25:43 +0000
Date: Thu, 30 Oct 2025 21:25:43 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Baokun Li <libaokun@huaweicloud.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	linux-kernel@vger.kernel.org, kernel@pankajraghav.com,
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, yi.zhang@huawei.com, yangerkun@huawei.com,
	chengzhihao1@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH 22/25] fs/buffer: prevent WARN_ON in
 __alloc_pages_slowpath() when BS > PS
Message-ID: <aQPX1-XWQjKaMTZB@casper.infradead.org>
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
> > No, absolutely not.  We're not having open-coded GFP_NOFAIL semantics.
> > The right way forward is for ext4 to use iomap, not for buffer heads
> > to support large block sizes.
> 
> ext4 only calls getblk_unmovable or __getblk when reading critical
> metadata. Both of these functions set __GFP_NOFAIL to ensure that
> metadata reads do not fail due to memory pressure.
> 
> Both functions eventually call grow_dev_folio(), which is why we
> handle the __GFP_NOFAIL logic there. xfs_buf_alloc_backing_mem()
> has similar logic, but XFS manages its own metadata, allowing it
> to use vmalloc for memory allocation.

In today's ext4 call, we discussed various options:

1. Change folios to be potentially fragmented.  This change would be
ridiculously large and nobody thinks this is a good idea.  Included here
for completeness.

2. Separate the buffer cache from the page cache again.  They were
unified about 25 years ago, and this also feels like a very big job.

3. Duplicate the buffer cache into ext4/jbd2, remove the functionality
not needed and make _this_ version of the buffer cache allocate
its own memory instead of aliasing into the page cache.  More feasible
than 1 or 2; still quite a big job.

4. Pick up Catherine's work and make ext4/jbd2 use it.  Seems to be
about an equivalent amount of work to option 3.

5. Make __GFP_NOFAIL work for allocations up to 64KiB (we decided this was
probably the practical limit of sector sizes that people actually want).
In terms of programming, it's a one-line change.  But we need to sell
this change to the MM people.  I think it's doable because if we have
a filesystem with 64KiB sectors, there will be many clean folios in the
pagecache which are 64KiB or larger.

So, we liked option 5 best.

