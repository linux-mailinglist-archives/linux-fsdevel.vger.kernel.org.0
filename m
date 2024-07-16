Return-Path: <linux-fsdevel+bounces-23778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B43932F42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 19:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03AED2864E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 17:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2991A00E3;
	Tue, 16 Jul 2024 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnG4iEP4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CE919E832;
	Tue, 16 Jul 2024 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721151617; cv=none; b=fe7HquQVXknb5KudzzuOLXCBatr/POPB5eWKAQfRoFG7oBpUebDdPIzW0LXilxu+q7EoeyEXwePJLeiyVNbmaso0cLMAvFMql3DEPWPP+E8H96MMxg1wk3woF0gsJS/K0tlzNPv/z8dU+RcHqiHl4vX3ENWAGCNZk5jo7UZm2jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721151617; c=relaxed/simple;
	bh=/DWRRzlwPclikws22W4iLFI9F32izmSn+UFrDAbSZ5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MB1WhFTqdwJBgzfkjDJSJA2bUmdK+Y/+FNHm9ga0NhyK6ln667/giE1dmPHxdWCxz9dm4UdEEqdAF3VwLlzNiE3RvVJa9DqPtivMl/EILCH1luRBCcUl2Edv31f0C8KV7AHZ4zrE3wjqiIsHY92Ph6JPwrI7mHlNQh1Xl/oahWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnG4iEP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E687FC116B1;
	Tue, 16 Jul 2024 17:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721151617;
	bh=/DWRRzlwPclikws22W4iLFI9F32izmSn+UFrDAbSZ5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jnG4iEP4JUqetBoPTMZyAsGFAaYNtgCfXuqwuKe9v0neIVIxyJ2dkW8aaCQYFB+VL
	 t3HPOBIiGhUHUdi9EQ9UfrU5dCgDUOyOPb3fpVpqHpczhhxFKsFsHU0m4FDKJg0ljb
	 Vnp8jEPky8TJiCbnWtFVfF2Eafx17VmCr3LTR4UerjscPcONdbddRQqJ4tM4d2pinM
	 H9CJUTcyz+3Z/mF7X++iFZtZzRlAaBcTa+2BYMbuJu0vgrEGGJxoorHzHqVF9F7S75
	 cOdYE1z6WYYy1EYclanvs8RerANxPhlG02Dj0xuNIgIVL59OAg1A3I7eG+HxkWm/aY
	 v04NdoJCtHwNA==
Date: Tue, 16 Jul 2024 10:40:16 -0700
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
Message-ID: <20240716174016.GZ1998502@frogsfrogsfrogs>
References: <20240715094457.452836-1-kernel@pankajraghav.com>
 <20240715094457.452836-11-kernel@pankajraghav.com>
 <ZpaRwdi3Vo3qutyk@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpaRwdi3Vo3qutyk@casper.infradead.org>

On Tue, Jul 16, 2024 at 04:29:05PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 15, 2024 at 11:44:57AM +0200, Pankaj Raghav (Samsung) wrote:
> > +++ b/fs/xfs/xfs_super.c
> > @@ -1638,16 +1638,30 @@ xfs_fs_fill_super(
> >  		goto out_free_sb;
> >  	}
> >  
> > -	/*
> > -	 * Until this is fixed only page-sized or smaller data blocks work.
> > -	 */
> >  	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
> > -		xfs_warn(mp,
> > -		"File system with blocksize %d bytes. "
> > -		"Only pagesize (%ld) or less will currently work.",
> > +		size_t max_folio_size = mapping_max_folio_size_supported();
> > +
> > +		if (!xfs_has_crc(mp)) {
> > +			xfs_warn(mp,
> > +"V4 Filesystem with blocksize %d bytes. Only pagesize (%ld) or less is supported.",
> >  				mp->m_sb.sb_blocksize, PAGE_SIZE);
> > -		error = -ENOSYS;
> > -		goto out_free_sb;
> > +			error = -ENOSYS;
> > +			goto out_free_sb;
> > +		}
> > +
> > +		if (mp->m_sb.sb_blocksize > max_folio_size) {
> > +			xfs_warn(mp,
> > +"block size (%u bytes) not supported; maximum folio size supported in "\
> > +"the page cache is (%ld bytes). Check MAX_PAGECACHE_ORDER (%d)",
> > +			mp->m_sb.sb_blocksize, max_folio_size,
> > +			MAX_PAGECACHE_ORDER);
> 
> Again, too much message.  Way too much.  We shouldn't even allow block
> devices to be created if their block size is larger than the max supported
> by the page cache.

Filesystem blocksize != block device blocksize.  xfs still needs this
check because one can xfs_copy a 64k-fsblock xfs to a hdd with 512b
sectors and try to mount that on x86.

Assuming there /is/ some fs that allows 1G blocksize, you'd then really
want a mount check that would prevent you from mounting that.

--D

