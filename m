Return-Path: <linux-fsdevel+bounces-23792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EF0933446
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 00:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3CF1F22C2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 22:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB08214386D;
	Tue, 16 Jul 2024 22:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1p9IYH6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2537581D;
	Tue, 16 Jul 2024 22:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721169423; cv=none; b=rPlRK1C+tqZQlpM6YDRc/Gi9BiLKpatIvZUvir+ED2mS5I6c7hxYuIFtKlAJOTEMa09ISU8p6ItdqtEJ1AVS+BarF+Y/+RHtCSe4/tOr13p5+r5k2QVEIA7/YhzeY3Pt3SEUA34UnFB98FRreJejRr5andhUyBHxr/eLgd2FRyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721169423; c=relaxed/simple;
	bh=XUhPqr66mBnpUl5wHd3I09bj5Pm8QPcHLcQbS8RN2FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjRFd9K+tRVF/XYZ8SP3OESEE0Z+o1g0fVhyGSp98vueYgGgLdhUuyhZv8uZPBR5A4VyvAQNUQStcRPFHW09EUEAXfr3qVCsyaZGl8hA+fEXC3e/lub/9r0VU0kliRZ5zrV4xz5QChUPN25JE/mizdkTYgOLWgQQbJJbuGaTx/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1p9IYH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0D6C116B1;
	Tue, 16 Jul 2024 22:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721169422;
	bh=XUhPqr66mBnpUl5wHd3I09bj5Pm8QPcHLcQbS8RN2FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F1p9IYH6CeswGs4EhE3VvNyGUrDLpo0oWzVNjMgdh1KruHl2vKfSDfiscijpVIalA
	 DHurXGvl7xl1FcRKM+mgjsN5Q8QAUUSQ5i64eUKdblM8SurZYwSNXaTLK63c2MPcPJ
	 wWG13t+2ppvzi8J65PTwRj0YFm7SBgwlzjAYjHozzpKrlEIR8bQUg+m6zedz8yS8km
	 4JZndZ1R6/kkdFyE6/5L0/UnCAhdf/MMPw6YTn72JsINyPJfeRg9gvOpMBFC0/IlC0
	 MI+IxItyLo0XzPGtrksOOQTYCXZQFJua4YwNox8hmOrVBBkM1UaR/xa7rNE/MimPu6
	 PxeS4v9QjH9Ng==
Date: Tue, 16 Jul 2024 15:37:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	david@fromorbit.com, chandan.babu@oracle.com, brauner@kernel.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, linux-mm@kvack.org,
	john.g.garry@oracle.com, linux-fsdevel@vger.kernel.org,
	hare@suse.de, p.raghav@samsung.com, mcgrof@kernel.org,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, ryan.roberts@arm.com, hch@lst.de,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v10 10/10] xfs: enable block size larger than page size
 support
Message-ID: <20240716223701.GG103014@frogsfrogsfrogs>
References: <20240715094457.452836-1-kernel@pankajraghav.com>
 <20240715094457.452836-11-kernel@pankajraghav.com>
 <ZpaRwdi3Vo3qutyk@casper.infradead.org>
 <20240716174016.GZ1998502@frogsfrogsfrogs>
 <ZpayAGWQdw1rbCng@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpayAGWQdw1rbCng@casper.infradead.org>

On Tue, Jul 16, 2024 at 06:46:40PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 16, 2024 at 10:40:16AM -0700, Darrick J. Wong wrote:
> > On Tue, Jul 16, 2024 at 04:29:05PM +0100, Matthew Wilcox wrote:
> > > On Mon, Jul 15, 2024 at 11:44:57AM +0200, Pankaj Raghav (Samsung) wrote:
> > > > +++ b/fs/xfs/xfs_super.c
> > > > @@ -1638,16 +1638,30 @@ xfs_fs_fill_super(
> > > >  		goto out_free_sb;
> > > >  	}
> > > >  
> > > > -	/*
> > > > -	 * Until this is fixed only page-sized or smaller data blocks work.
> > > > -	 */
> > > >  	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
> > > > -		xfs_warn(mp,
> > > > -		"File system with blocksize %d bytes. "
> > > > -		"Only pagesize (%ld) or less will currently work.",
> > > > +		size_t max_folio_size = mapping_max_folio_size_supported();
> > > > +
> > > > +		if (!xfs_has_crc(mp)) {
> > > > +			xfs_warn(mp,
> > > > +"V4 Filesystem with blocksize %d bytes. Only pagesize (%ld) or less is supported.",
> > > >  				mp->m_sb.sb_blocksize, PAGE_SIZE);
> > > > -		error = -ENOSYS;
> > > > -		goto out_free_sb;
> > > > +			error = -ENOSYS;
> > > > +			goto out_free_sb;
> > > > +		}
> > > > +
> > > > +		if (mp->m_sb.sb_blocksize > max_folio_size) {
> > > > +			xfs_warn(mp,
> > > > +"block size (%u bytes) not supported; maximum folio size supported in "\
> > > > +"the page cache is (%ld bytes). Check MAX_PAGECACHE_ORDER (%d)",
> > > > +			mp->m_sb.sb_blocksize, max_folio_size,
> > > > +			MAX_PAGECACHE_ORDER);
> > > 
> > > Again, too much message.  Way too much.  We shouldn't even allow block
> > > devices to be created if their block size is larger than the max supported
> > > by the page cache.
> > 
> > Filesystem blocksize != block device blocksize.  xfs still needs this
> > check because one can xfs_copy a 64k-fsblock xfs to a hdd with 512b
> > sectors and try to mount that on x86.
> > 
> > Assuming there /is/ some fs that allows 1G blocksize, you'd then really
> > want a mount check that would prevent you from mounting that.
> 
> Absolutely, we need to have an fs blocksize check in the fs (if only
> because fs fuzzers will put random values in fields and expect the system
> to not crash).  But that should have nothing to do with page cache size.

I don't understand your objection -- we're setting the minimum folio
order on a file's pagecache to match the fs-wide blocksize.  If the
pagecache can't possibly fulfill our fs-wide requirement, then why would
we continue the mount?

Let's pretend that MAX_PAGECACHE_ORDER is 1.  The filesystem has 16k
blocks, the CPU has 4k base pages.  xfs will try to set the min folio
order to 2 via mapping_set_folio_order_range.  That function clamps it
to 1, so we try to cache a 16k fsblock with 8k pages.  Does that
actually work?

If not, then doesn't it make more more sense to fail the mount?

--D

