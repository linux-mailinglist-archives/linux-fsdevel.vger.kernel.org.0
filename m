Return-Path: <linux-fsdevel+bounces-21978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD3F9108F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 16:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7F41F25EBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD6B1AE0B5;
	Thu, 20 Jun 2024 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DK9461nv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232F81A00E8;
	Thu, 20 Jun 2024 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894999; cv=none; b=cGqZeNP0UVAQh2Hqaf7ViJnCQY5ekK3OdO2gq/6Ya6qHAs++DoZp2V+CMllc1HzHLPf8eT7F5ZqBAQRUploMn33FrWQ9U/Uk30NuQwfNy2XqQvsuhYbTA1wlaKAAy6sfoEBhGxCrHlPPKj7vTz9YYk9sFmV7iabICTIOC/pg6Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894999; c=relaxed/simple;
	bh=zLMFji/kBtdm/cR3ouzyDA+1RLCkzScESSTR+iy4eqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ga97X3SQG1VEsDmY0BjqjL/fkrnK/AB69qxWyS2R8nRT5IcVVCnaVwVHK263OfLTeZbFadu63r/MYSt1D4aer6LJFKzMGw1uHH4RBY6cTMQRoI8foZ/7yMUpV7r6XW8wJP1otUUv2UAntT2Na/yX2Qe41u5mXU0pl+YCrFSNvno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DK9461nv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=H81DH+ynfsRTqrcA4THkP1f+g4d7a275h5xZYoZGs1A=; b=DK9461nv9ud2Vd9wNnLiHx6RM2
	zrytsuWqXz6x7CxWX642tSzOv09khrVdR65jq21EdOHr1oyZbkam9CaJGJpIYuR5XXgsFj0HoXS7C
	xp4YyI6ZBujMT9Aaq4xmSdjiP5QeE1N3iHzllWYY8ZXi4b07dXkH3muNSKU3SdIHB0UlWdnJnC4Nt
	MpZrmkT9DA6+yQk5le4tHgX0jmxYlc2exQ0pJCIom5L3X3pys8Lo4eWlQtI98jondqw98wqjvmdiM
	evgKQLDUqM8TxlCB7U+Y09mJuYBSLLnN5bILrywTTjPMW48siMvQV4u5ep/sk8UzEUkvYGVYANPrO
	tl8bJMoQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKJ6o-00000006ATj-2BpZ;
	Thu, 20 Jun 2024 14:49:54 +0000
Date: Thu, 20 Jun 2024 15:49:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Hongbo Li <lihongbo22@huawei.com>, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de
Subject: Re: bvec_iter.bi_sector -> loff_t? (was: Re: [PATCH] bcachefs: allow
 direct io fallback to buffer io for) unaligned length or offset
Message-ID: <ZnRBkr_7Ah8Hj-i-@casper.infradead.org>
References: <20240620132157.888559-1-lihongbo22@huawei.com>
 <bbf7lnl2d5sxdzqbv3jcn6gxmtnsnscakqmfdf6vj4fcs3nasx@zvjsxfwkavgm>
 <ZnQ0gdpcplp_-aw7@casper.infradead.org>
 <pfxno4kzdgk6imw7vt2wvpluybohbf6brka6tlx34lu2zbbuaz@khifgy2v2z5n>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pfxno4kzdgk6imw7vt2wvpluybohbf6brka6tlx34lu2zbbuaz@khifgy2v2z5n>

On Thu, Jun 20, 2024 at 10:16:02AM -0400, Kent Overstreet wrote:
> That's really just descriptive, not prescriptive.
> 
> The intent of O_DIRECT is "bypass the page cache", the alignment
> restrictions are just a side effect of that. Applications just care
> about is having predictable performance characteristics.

But any application that has been written to use O_DIRECT already has the
alignment & size guarantees in place.  What this patch is attempting to do
is make it "more friendly" to use, and I'm not sure that's a great idea.
Not without buy-in from a large cross-section of filesystem people.

I'm more sympathetic to "lets relax the alignment requirements", since
most IO devices actually can do IO to arbitrary boundaries (or at least
reasonable boundaries, eg cacheline alignment or 4-byte alignment).
The 512 byte alignment doesn't seem particularly rooted in any hardware
restrictions.

But size?  Fundamentally, we're asking the device to do IO directly to
this userspace address.  That means you get to do the entire IO, not
just the part of it that you want.  I know some devices have bitbucket
descriptors, but many don't.

> > I'm against it.  Block devices only do sector-aligned IO and we should
> > not pretend otherwise.
> 
> Eh?
> 
> bio isn't really specific to the block layer anyways, given that an
> iov_iter can be a bio underneath. We _really_ should be trying for
> better commonality of data structures.

bio is absolutely specific to the block layer.  Look at it:

/*
 * main unit of I/O for the block layer and lower layers (ie drivers and
 * stacking drivers)
 */

        struct block_device     *bi_bdev;
        unsigned short          bi_flags;       /* BIO_* below */
        unsigned short          bi_ioprio;
        blk_status_t            bi_status;

Filesystems get to use it to interact with the block layer.  The iov_iter
isn't an abstraction over the bio, it's an abstraction over the bio_vec.

