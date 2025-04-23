Return-Path: <linux-fsdevel+bounces-47122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BA2A9976B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 20:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513CD3ACC4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 18:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFBE28D853;
	Wed, 23 Apr 2025 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WKzXkeLy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AB828CF6E
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745431352; cv=none; b=piIwUJggInGfKbFKytJFdzVftNbQm2OgTdndb7+1PK2So2Efo+ZxplrrYrNpEHPs/lvQTW1IY4d1uRq1N7/V54P1o8sML4L3XIbUc3oPFblYUlvgxxSNTgH5ZxTb6P346p3c4PBy2zW7JAyO/CzWYzeOtNuI1t0WxDVD1Nqte0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745431352; c=relaxed/simple;
	bh=BSV2S5axVk3jR2Dj4hy0PRdYG9l3BhCOacRqX+is/5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pf9c2okQiYOOuQczpufw5W5h5YWQYmct/PScbv9CRL6qRK8JuDT3MBPe8dysJVPE7KkqUSezSfPlPI44oYcwS6J+3WHO0YbXC8A5QyN4Yw2PmQ8hjU0fWJ1JsndeMQiLohCUGoMwTsmy1EpOCyZoScEhnz4Tzp0j4RwnQI4tUrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WKzXkeLy; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 23 Apr 2025 14:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745431337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8BS6PilBZgvTDPZhVhVWu7ww97sBPTJLkhr1PmWiCpA=;
	b=WKzXkeLyNYDwk/eCKuYZUCO+ERfNfkrsogpUfK8yviZk5KF8v/jUkJdnJU+r8oZr+ubgz5
	x6V9oP+fLmYCwLsnSZd82pB9eEkKHjvuhiG4VRWZPCOzP6wYwxgwjmy1iiuNhSzk9iSRcj
	k8plvwA+ho8NM7aL2D7SLNCO8wUepbA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, 
	Johannes Thumshirn <jth@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: add more bio helper
Message-ID: <q53k4x5nshvr2zatrgyhygxouv7ijyepe6cj2pfooemi6gbu4y@lpxxcvozazzu>
References: <20250422142628.1553523-1-hch@lst.de>
 <jetduw7zshrmp4gl7zfpwqjweycwesxiod7xvtnxqwqekgtvdf@idwnvfzvhgik>
 <20250423093621.GA2578@lst.de>
 <sl4oibdxpjygqfpy6llq237zuckz7ym4fmzcfvxn2raofr37a5@hvevbcgm5trn>
 <20250423160733.GA656@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423160733.GA656@lst.de>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 23, 2025 at 06:07:33PM +0200, Christoph Hellwig wrote:
> On Wed, Apr 23, 2025 at 06:37:41AM -0400, Kent Overstreet wrote:
> > > It also don't support bio chaining or error handling and requires a
> > > single bio that is guaranteed to fit the required number of vectors.
> > 
> > Why would bio chaining ever be required? The caller allocates both the
> > buf and the bio, I've never seen an instance where you'd want that; just
> > allocate a bio with the correct number of vecs, which your
> > bio_vmalloc_max_vecs() helps with.
> 
> If you go beyond 1MB I/O for vmalloc you need it because a single
> bio can't hold enough page size chunks.  That is unless you want
> to use your own allocation for it and call bio_init which has various
> other downsides.

Allocating your own bio doesn't allow you to safely exceed the
BIO_MAX_VECS limit - there's places in the io path that need to bounce,
and they all use biosets.

That may be an issue even for non vmalloc bios, unless everything that
bounces has been converted to bounce to a folio of the same order.

> > The "abstract over vmalloc and normal physically contigious allocations"
> > bit that bch2_bio_map() does is the important part.
> > 
> > It's not uncommon to prefer physically contiguous allocations but have a
> > vmalloc fallback; bcachefs does, and  xfs does with a clever "try the
> > big allocation if it's cheap, fall back to vmalloc to avoid waiting on
> > compaction" that I might steal.
> > 
> > is_vmalloc_addr() is also cheap, it's just a pointer comparison (and it
> > really should be changed to a static inline).
> 
> The problem with transparent vmalloc handling is that it's not possible.
> The magic handling for virtually indexed caches can be hidden on the
> submission side, but the completion side also needs to call
> invalidate_kernel_vmap_range for reads.  Requiring the caller to know
> they deal vmalloc is a way to at least keep that on the radar.

yeesh, that's a landmine.

having a separate bio_add_vmalloc as a hint is still a really bad
"solution", unfortunately. And since this is something we don't have
sanitizers or debug code for, and it only shows up on some archs -
that's nasty.

> The other benefit is that by forcing different calls it is much
> easier to pick the optimal number of bvecs (1) for the non-vmalloc
> path, although that is of course also possible without it.

Your bio_vmalloc_max_vecs() could trivially handle both vmalloc and non
vmalloc addresses.

> Not for a purely synchronous helper we could handle both, but so far
> I've not seen anything but the xfs log recovery code that needs it,
> and we'd probably get into needing to pass a bio_set to avoid
> deadlock when used deeper in the stack, etc.  I can look into that
> if we have more than a single user, but for now it doesn't seem
> worth it.

bcache and bcachefs btree buffers can also be vmalloc backed. Possibly
also the prio_set path in bcache, for reading/writing bucket gens, but
I'd have to check.

> Having a common helper for vmalloc and the kernel direct mapping
> is actually how I started, but then I ran into all the issues with
> it and with the extremely simple helpers for the direct mapping
> which are used a lot, and the more complicated version for vmalloc
> which just has a few users instead.

*nod*

What else did you run into? invalidate_kernel_vmap_range() seems like
the only problematic one, given that is_vmalloc_addr() is cheap.

