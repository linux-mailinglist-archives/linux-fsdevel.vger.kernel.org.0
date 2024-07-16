Return-Path: <linux-fsdevel+bounces-23779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04031932F4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 19:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34C9B1C21EE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 17:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42371A01C4;
	Tue, 16 Jul 2024 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r7x052J/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766491A00E3;
	Tue, 16 Jul 2024 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152010; cv=none; b=H65Y3avjG0v7OzdD53FNM2MP8hYpDlTS5SJEDBTK7uJt+TVCmSHuLivLuNThzWoI9hq2r1Mk33JxmqQ37MC/PCx6PKcACr3ImXvGwvk25sr40naDHLYzLMN68qnTkiyVQb46TRxiQEf0vIlsnL6xyMlCtCuatOGTEGqiVKSnmIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152010; c=relaxed/simple;
	bh=7C2aeRAZ9N22c5zDU+IK5CaS7FOXyPVlke82CHzRulk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELEPC/3YLdla3JyuTwRIJhRYyvs2jrdsGl8B0t+CvcQ5q060PXppODe1pu/uylYZorsPPIdOXsAM1QYdZuCuwTm4DYuXqgmfh4aBinANGHKm9DbT3n2dFt22MLw5/wAD9IaaL9oXFwN0EcZebFlbC39O6sufEyKVVQRAARzWKk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r7x052J/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ra6y1t4n6GxPoGrXbJCTMwqrGtbY4JF2QAmbOWwYp3Q=; b=r7x052J/t+uGYyNUOCFtT+noc5
	i4d6Jt+hV6vhBmtdgdyORa250S5TRlW9ERvLS7MEnyDJ7RQmOsi3SzBOQtTcOmvgLZcRs+z0Lc+fc
	TAevcJwwAPO2uGoxDZpfMIpe65ji9mWr2gd+Z3c2L3cWlc2PbZmor+u5/1mj6JhHcGYrfbKJawym/
	UL4Vyn2Z57PT301VYzQVb6eovnnGYwq3uYJ6ybBhydhvaPlINxXQkr0Rk3ZTmnAXMMU4MPm9yGq7s
	//2/00WIv8LDY2JjmOwh0bB5KsviU/Hlwo/+I+JLIZKM4/8qRs+Bb8cK8h2e0zGqI/xFfIYY2hCgs
	s0MCScrA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTmG8-0000000HMwh-3iT4;
	Tue, 16 Jul 2024 17:46:40 +0000
Date: Tue, 16 Jul 2024 18:46:40 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
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
Message-ID: <ZpayAGWQdw1rbCng@casper.infradead.org>
References: <20240715094457.452836-1-kernel@pankajraghav.com>
 <20240715094457.452836-11-kernel@pankajraghav.com>
 <ZpaRwdi3Vo3qutyk@casper.infradead.org>
 <20240716174016.GZ1998502@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716174016.GZ1998502@frogsfrogsfrogs>

On Tue, Jul 16, 2024 at 10:40:16AM -0700, Darrick J. Wong wrote:
> On Tue, Jul 16, 2024 at 04:29:05PM +0100, Matthew Wilcox wrote:
> > On Mon, Jul 15, 2024 at 11:44:57AM +0200, Pankaj Raghav (Samsung) wrote:
> > > +++ b/fs/xfs/xfs_super.c
> > > @@ -1638,16 +1638,30 @@ xfs_fs_fill_super(
> > >  		goto out_free_sb;
> > >  	}
> > >  
> > > -	/*
> > > -	 * Until this is fixed only page-sized or smaller data blocks work.
> > > -	 */
> > >  	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
> > > -		xfs_warn(mp,
> > > -		"File system with blocksize %d bytes. "
> > > -		"Only pagesize (%ld) or less will currently work.",
> > > +		size_t max_folio_size = mapping_max_folio_size_supported();
> > > +
> > > +		if (!xfs_has_crc(mp)) {
> > > +			xfs_warn(mp,
> > > +"V4 Filesystem with blocksize %d bytes. Only pagesize (%ld) or less is supported.",
> > >  				mp->m_sb.sb_blocksize, PAGE_SIZE);
> > > -		error = -ENOSYS;
> > > -		goto out_free_sb;
> > > +			error = -ENOSYS;
> > > +			goto out_free_sb;
> > > +		}
> > > +
> > > +		if (mp->m_sb.sb_blocksize > max_folio_size) {
> > > +			xfs_warn(mp,
> > > +"block size (%u bytes) not supported; maximum folio size supported in "\
> > > +"the page cache is (%ld bytes). Check MAX_PAGECACHE_ORDER (%d)",
> > > +			mp->m_sb.sb_blocksize, max_folio_size,
> > > +			MAX_PAGECACHE_ORDER);
> > 
> > Again, too much message.  Way too much.  We shouldn't even allow block
> > devices to be created if their block size is larger than the max supported
> > by the page cache.
> 
> Filesystem blocksize != block device blocksize.  xfs still needs this
> check because one can xfs_copy a 64k-fsblock xfs to a hdd with 512b
> sectors and try to mount that on x86.
> 
> Assuming there /is/ some fs that allows 1G blocksize, you'd then really
> want a mount check that would prevent you from mounting that.

Absolutely, we need to have an fs blocksize check in the fs (if only
because fs fuzzers will put random values in fields and expect the system
to not crash).  But that should have nothing to do with page cache size.

