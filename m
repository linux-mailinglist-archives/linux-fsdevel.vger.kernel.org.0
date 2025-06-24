Return-Path: <linux-fsdevel+bounces-52765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10474AE6535
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 14:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5E64A6522
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1F0291C0A;
	Tue, 24 Jun 2025 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W6GHJ9nD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5614230996;
	Tue, 24 Jun 2025 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750768746; cv=none; b=jcIKjiP82/R/zM86NZ7F0Q9SkWmR2z6EBLAp1zAMJgKYa4qv4dTyvyNVXK1p1sx6yZT6STiskO1aCpRs3NZBiVOcuxK5+nu4hWb00FeBPF5Ua5Q4keeugvYA0SAZp5tpQN3rZ0+cqd8qAICb5lew8ZhC3uylitHgFSpR6SqFDQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750768746; c=relaxed/simple;
	bh=4P8wd9h5Go264P/9N+8xDjMZjsgekEEzsS81qXtyA0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhmLS5kOz7GHtI0eTmTMmeyD7cVP5FHHUadTVbbJn0eSfI18GGpJ4855hOe69dUuXEEGOq0bo/dNjq0me8zp0ur3PreGk+XgmrZ1BJSu9ziD6VVQWuB5aTvv1Bhg7nuFueeelUa3rJg8OhSz4wNRBV6rAk/kLQNyrz4NxoNWkNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W6GHJ9nD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0hakl0/kYPdggumUkyNzKLxp5ngjPrYeJTMOFwUQIRA=; b=W6GHJ9nDe8Pjyc8lP/+jiNtUot
	tEV2YfGRhCnLYBES0b6YVkr8LBiUF8sj81PF+eHHOH1G3NPn5GhDshzrr8iZec7DNgrnHoHIgfSG8
	mYmlXBZl7lUIdQOM2ADjdzD8dbkUx8tszlW3N1dar2Zy0fyxFeHZS12t5fZeqO5eB2UkDd0+i2LQe
	CVMMgiq3wc/JqmPHJU3WZgdiw5jCGKKKximG6PYpCDZLy4Ldbx1q0hWJIQY3rljTUpDloQIypJBOF
	rn4Ulq7/ZtTByPIQ+Wy3e4+mD8O4K3gVvFFnzCcVR/VwzsMkQWMdSNvbnor6GQbfYMgBKqbW/87Mq
	hM4pGj5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU2vU-00000005bfF-49O8;
	Tue, 24 Jun 2025 12:39:00 +0000
Date: Tue, 24 Jun 2025 05:39:00 -0700
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
Message-ID: <aFqcZMXUYx6qqDx_@infradead.org>
References: <aFlaxwpKChYXFf8A@infradead.org>
 <2135907.1747061490@warthog.procyon.org.uk>
 <1069540.1746202908@warthog.procyon.org.uk>
 <165f5d5b-34f2-40de-b0ec-8c1ca36babe8@lunn.ch>
 <0aa1b4a2-47b2-40a4-ae14-ce2dd457a1f7@lunn.ch>
 <1015189.1746187621@warthog.procyon.org.uk>
 <1021352.1746193306@warthog.procyon.org.uk>
 <1098395.1750675858@warthog.procyon.org.uk>
 <1143687.1750755725@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143687.1750755725@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 24, 2025 at 10:02:05AM +0100, David Howells wrote:
> > There isn't a very easy way.  Also because if you actually need to do
> > peer to peer transfers, you right now absolutely need the page to find
> > the pgmap that has the information on how to perform the peer to peer
> > transfer.
> 
> Are you expecting P2P to become particularly common?

What do you mean with 'particularly common'?  In general it's a very
niche thing.  But in certain niches it gets used more and more.

> Because page struct
> lookups will become more expensive because we'll have to do type checking and
> Willy may eventually move them from a fixed array into a maple tree - so if we
> can record the P2P flag in the bio_vec, it would help speed up the "not P2P"
> case.

As said before, the best place for that is a higher level structure than
the bio_vec.

> Do we actually need 32 bits for bv_len, especially given that MAX_RW_COUNT is
> capped at a bit less than 2GiB?  Could we, say, do:
> 
>  	struct bio_vec {
>  		phys_addr_t	bv_phys;
>  		u32		bv_len:31;
> 		u32		bv_use_p2p:1;
>  	} __packed;

I've already heard people complain 32-bit might not be enough :) 

> And rather than storing the how-to-do-P2P info in the page struct, does it
> make sense to hold it separately, keyed on bv_phys?

Maybe.  But then you need to invent your own new refcounting for the
section representing the hot pluggable p2p memory.

> Also, is it possible for the networking stack, say, to trivially map the P2P
> memory in order to checksum it?  I presume bv_phys in that case would point to
> a mapping of device memory?

P2P is always to MMIO regions.  So you can access it using the usual
MMIO helpers.


