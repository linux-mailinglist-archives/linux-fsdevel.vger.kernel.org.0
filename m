Return-Path: <linux-fsdevel+bounces-17602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5141D8B0058
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 06:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE3F2868B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 04:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA45E14430E;
	Wed, 24 Apr 2024 04:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h4Fe0VR3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969C0142E9D;
	Wed, 24 Apr 2024 04:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713931576; cv=none; b=VFt+KCSS4rWeOGcnvLle41O+HK/Vt6AHdQLTe+p+pmNv9ikrKamhzBrMdmKEKEuvYBkZjq27uV03zxyKjoAYPlIOnAmMmVa8AujcWejmuwGjd2yw6K9+dymRfEmcS3SgLYuOZTbRTnpfdxjP2t7gpODfgj6cHrBFONdi4bDaaJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713931576; c=relaxed/simple;
	bh=uQR45cFMjtlCHmxT79KIysG9mZOqnQ9+qd3qqsml7x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fz7gEAe67xHxj3g9p0sWBG4FvKpajdh9xoDU0ugtEk8Vfh/7Ti/78sjbeuu55oqcb7feTVeZFOslpvTnY5PewoXamn11bbd2xbTpSfIy1ml78zZW1QcaHCIlPvGkOY0LBAv09SCrSFFTo9GdsuADQnjBEqd+ZUcKEHghlRoAQKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h4Fe0VR3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EuETJtGZxu1owesI989Ljeb319SuE+6AMj187CcAyGU=; b=h4Fe0VR3cSeC3HLANTcVKxyO/i
	B06vSJffXjewy57PoJgnUcyyBRkwUMt8vwuZzwXPAPX/udjrDvsPCNFQzhONrXdtyLHXfbOJ3B19K
	G4cRQtmYMqTvPrqT5/VHDUveVUmupBCQy1DVO5WfA8wGGpm8/ic5HV0FkHTTDKg3mdgmo9HuGlteL
	dcOe9STGScruYnrnJTVB/SzBLNbp4V+Ao8QGX2RO3DBO9G8mERgnhc1SvA84Cy+T4EM6m+089hhc3
	ZvygtNcQZxBN46XczDC7C/g2Bhq+rZtbyN6BQWKKWNsoskDTrqwacWtSXRrdNeiFV+92BjMO6/pnQ
	x1RO0NIA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzTtG-00000000894-0JOS;
	Wed, 24 Apr 2024 04:05:50 +0000
Date: Wed, 24 Apr 2024 05:05:49 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org,
	Kairui Song <kasong@tencent.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>, linux-afs@lists.infradead.org,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>
Subject: Re: [PATCH v2 7/8] mm: drop page_index/page_file_offset and convert
 swap helpers to use folio
Message-ID: <ZiiFHTwgu8FGio1k@casper.infradead.org>
References: <20240423170339.54131-1-ryncsn@gmail.com>
 <20240423170339.54131-8-ryncsn@gmail.com>
 <87sezbsdwf.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sezbsdwf.fsf@yhuang6-desk2.ccr.corp.intel.com>

On Wed, Apr 24, 2024 at 10:17:04AM +0800, Huang, Ying wrote:
> Kairui Song <ryncsn@gmail.com> writes:
> >  static inline loff_t folio_file_pos(struct folio *folio)
> >  {
> > -	return page_file_offset(&folio->page);
> > +	if (unlikely(folio_test_swapcache(folio)))
> > +		return __folio_swap_dev_pos(folio);
> > +	return ((loff_t)folio->index << PAGE_SHIFT);
> 
> This still looks confusing for me.  The function returns the byte
> position of the folio in its file.  But we returns the swap device
> position of the folio.
> 
> Tried to search folio_file_pos() usage.  The 2 usage in page_io.c is
> swap specific, we can use swap_dev_pos() directly.
> 
> There are also other file system users (NFS and AFS) of
> folio_file_pos(), I don't know why they need to work with swap
> cache. Cced file system maintainers for help.

Time for a history lesson!

In d56b4ddf7781 (2012) we introduced page_file_index() and
page_file_mapping() to support swap-over-NFS.  Writes to the swapfile went
through ->direct_IO but reads went through ->readpage.  So NFS was changed
to remove direct references to page->mapping and page->index because
those aren't right for anon pages (or shmem pages being swapped out).

In e1209d3a7a67 (2022), we stopped using ->readpage in favour of using
->swap_rw.  Now we don't need to use page_file_*(); we get the swap_file
and ki_pos directly in the swap_iocb.  But there are still relics in NFS
that nobody has dared rip out.  And there are all the copy-and-pasted
filesystems that use page_file_* because they don't know any better.

We should delete page_file_*() and folio_file_*().  They shouldn't be
needed any more.

