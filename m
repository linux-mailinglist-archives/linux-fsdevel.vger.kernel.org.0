Return-Path: <linux-fsdevel+bounces-52569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C3AAE45A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240F1441192
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7AE253351;
	Mon, 23 Jun 2025 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HxtUApuq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E3A19CC3E;
	Mon, 23 Jun 2025 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686414; cv=none; b=Q1QogrKFD72OadH/vyKqRS+Vhjqt2L7mnlnEFYF5mS/jVZTKV/WgdDziHMvtaMiNDM72XvaFKSaXL+VXnl6dAQRBbuoVlHzB15INt3N5aorDqHTiZDqXDD+nE6YAJuQ9/Y8r2tZWSEOS2SQkMwzEBeLcwPsGi/sv3opEvKpECuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686414; c=relaxed/simple;
	bh=EtRg/kLg8kdMEIk4JAQ1HIT9l876vGX3bDX3siYn1W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snNp+CJPTlnKj3dSHIyxXKJQWvWvwBfBhtdGOX7UKCMcrj7uGb5v/P61Agsc9+ip+fL/fLshHEPupOKlUhKhpyHd7tXZBRKhaZXG2x560ga/TT5lGR1XebjtoCODRXtxceMrMjqLuc6+NI0WIeyDCLWMSTS7b4oeuP2JSXYbM0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HxtUApuq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ana0bJ8hg2451El2QUEf36H2FD1ZACNayjwsD6jvG/A=; b=HxtUApuqIxjQJ05HeYehUPlPmt
	HblO84+kpcn33Jvf5y85M4E7ksoqHdRegguU2ClgTmVAzHOp9nOcma5AIOH1jXggvasOHWwly4zzn
	60U7UYcz5apZggiJD5DyWdIETDnYoLq72uWAtgvLV7M8xnDkuhC2wKMs7uDamgf0SLdKhxPMsIqaD
	pfejZy+sEDFFcEG8gP5OczwtZgk3RxHSAOZPDoeSOjy4+Fux1KdPIiVc1kz7aQSF/93akpKO2dk1P
	ya4PbjJtM2pjpxDbzIlnELNWbjbhZnjC0QxRI6L0qJbx/pOHweI9dQE647dQ2vbHjbqkBZEYbMkbX
	GfruIkCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uThVX-00000002uw7-2IPu;
	Mon, 23 Jun 2025 13:46:47 +0000
Date: Mon, 23 Jun 2025 06:46:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Mina Almasry <almasrymina@google.com>, willy@infradead.org,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: How to handle P2P DMA with only {physaddr,len} in bio_vec?
Message-ID: <aFlaxwpKChYXFf8A@infradead.org>
References: <2135907.1747061490@warthog.procyon.org.uk>
 <1069540.1746202908@warthog.procyon.org.uk>
 <165f5d5b-34f2-40de-b0ec-8c1ca36babe8@lunn.ch>
 <0aa1b4a2-47b2-40a4-ae14-ce2dd457a1f7@lunn.ch>
 <1015189.1746187621@warthog.procyon.org.uk>
 <1021352.1746193306@warthog.procyon.org.uk>
 <1098395.1750675858@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098395.1750675858@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi David,

On Mon, Jun 23, 2025 at 11:50:58AM +0100, David Howells wrote:
> What's the best way to manage this without having to go back to the page
> struct for every DMA mapping we want to make?

There isn't a very easy way.  Also because if you actually need to do
peer to peer transfers, you right now absolutely need the page to find
the pgmap that has the information on how to perform the peer to peer
transfer.

> Do we need to have
> iov_extract_user_pages() note this in the bio_vec?
> 
> 	struct bio_vec {
> 		physaddr_t	bv_base_addr;	/* 64-bits */
> 		size_t		bv_len:56;	/* Maybe just u32 */
> 		bool		p2pdma:1;	/* Region is involved in P2P */
> 		unsigned int	spare:7;
> 	};

Having a flag in the bio_vec might be a way to shortcut the P2P or not
decision a bit.  The downside is that without the flag, the bio_vec
in the brave new page-less world would actually just be:

	struct bio_vec {
		phys_addr_t	bv_phys;
		u32		bv_len;
	} __packed;

i.e. adding any more information would actually increase the size from
12 bytes to 16 bytes for the usualy 64-bit phys_addr_t setups, and thus
undo all the memory savings that this move would provide.

Note that at least for the block layer the DMA mapping changes I'm about
to send out again require each bio to be either non P2P or P2P to a
specific device.  It might be worth to also extend this higher level
limitation to other users if feasible.

> I'm guessing that only folio-type pages can be involved in this:
> 
> 	static inline struct dev_pagemap *page_pgmap(const struct page *page)
> 	{
> 		VM_WARN_ON_ONCE_PAGE(!is_zone_device_page(page), page);
> 		return page_folio(page)->pgmap;
> 	}
> 
> as only struct folio has a pointer to dev_pagemap?  And I assume this is going
> to get removed from struct page itself at some point soonish.

I guess so.


