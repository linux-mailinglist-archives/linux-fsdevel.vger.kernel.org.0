Return-Path: <linux-fsdevel+bounces-47206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F135BA9A65B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 10:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5236A466375
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69292206A4;
	Thu, 24 Apr 2025 08:37:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7514020E700;
	Thu, 24 Apr 2025 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745483868; cv=none; b=ipGuBkfbpbuz8wOyMPcw7cWMlJjL9rRdbXLXYTNrylCcbWu9ykVxg39rjUwD+vslyZXN80gn5zn8My71szbhUrkC2tOxKimyC6PSeoSkzSbt/kx5oD8HRH/A4KY0EfxGHGklL24o50zVnJS5AZz6d0Bbp9uMK1Q97XRCokQuxiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745483868; c=relaxed/simple;
	bh=uV5SOxe11nIMXSY79Utbf7Y4n7mYRE75YQ+Yie0DOkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFPO7KLdSfS91tEtJS/aE6svIe+bYnlSDmBLTrJ/Gi00rlzXxci1FvBF/GaVKbiDKTJlfVdwc8KDpSqpIZLB+4ongYWU1tV0BLEde4YX3CqdMnF8mXnoyunIVgWSPXJaBaDLK4zpGMsFpcUjHnR5z9w2iHj7l8T1qD1japlD++g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 778C567373; Thu, 24 Apr 2025 10:37:40 +0200 (CEST)
Date: Thu, 24 Apr 2025 10:37:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: add more bio helper
Message-ID: <20250424083740.GA24723@lst.de>
References: <20250422142628.1553523-1-hch@lst.de> <jetduw7zshrmp4gl7zfpwqjweycwesxiod7xvtnxqwqekgtvdf@idwnvfzvhgik> <20250423093621.GA2578@lst.de> <sl4oibdxpjygqfpy6llq237zuckz7ym4fmzcfvxn2raofr37a5@hvevbcgm5trn> <20250423160733.GA656@lst.de> <q53k4x5nshvr2zatrgyhygxouv7ijyepe6cj2pfooemi6gbu4y@lpxxcvozazzu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q53k4x5nshvr2zatrgyhygxouv7ijyepe6cj2pfooemi6gbu4y@lpxxcvozazzu>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 23, 2025 at 02:02:11PM -0400, Kent Overstreet wrote:
> Allocating your own bio doesn't allow you to safely exceed the
> BIO_MAX_VECS limit - there's places in the io path that need to bounce,
> and they all use biosets.

Yes.  Another reason not to do it, which I don't want to anyway.

But we do have a few places that do it like squashs which we need to
weed out.  And/or finally kill the bounce bufferingreal, which is long
overdue.

> That may be an issue even for non vmalloc bios, unless everything that
> bounces has been converted to bounce to a folio of the same order.

Anything that actually hits the bounce buffering is going to
cause problems because it hasn't kept up with the evolution of
the block layer, and is basically not used for anything relevant.

> > The problem with transparent vmalloc handling is that it's not possible.
> > The magic handling for virtually indexed caches can be hidden on the
> > submission side, but the completion side also needs to call
> > invalidate_kernel_vmap_range for reads.  Requiring the caller to know
> > they deal vmalloc is a way to at least keep that on the radar.
> 
> yeesh, that's a landmine.
> 
> having a separate bio_add_vmalloc as a hint is still a really bad
> "solution", unfortunately. And since this is something we don't have
> sanitizers or debug code for, and it only shows up on some archs -
> that's nasty.

Well, we can't do it in the block stack because that doesn't have the
vmalloc address available.  So the caller has to do it, and having a
very visible sign is the best we can do.  Yes, signs aren't the
best cure for landmines, but they are better than nothing.

> > Not for a purely synchronous helper we could handle both, but so far
> > I've not seen anything but the xfs log recovery code that needs it,
> > and we'd probably get into needing to pass a bio_set to avoid
> > deadlock when used deeper in the stack, etc.  I can look into that
> > if we have more than a single user, but for now it doesn't seem
> > worth it.
> 
> bcache and bcachefs btree buffers can also be vmalloc backed. Possibly
> also the prio_set path in bcache, for reading/writing bucket gens, but
> I'd have to check.

But do you do synchronous I/O, i.e. using sumit_bio_wait on them?

> 
> > Having a common helper for vmalloc and the kernel direct mapping
> > is actually how I started, but then I ran into all the issues with
> > it and with the extremely simple helpers for the direct mapping
> > which are used a lot, and the more complicated version for vmalloc
> > which just has a few users instead.
> 
> *nod*
> 
> What else did you run into? invalidate_kernel_vmap_range() seems like
> the only problematic one, given that is_vmalloc_addr() is cheap.

invalidate_kernel_vmap_range is the major issue that can't be
worked around.  Everything else was mentioned before and can be
summarized as minor inconveniences.

