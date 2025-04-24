Return-Path: <linux-fsdevel+bounces-47224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E779AA9ACBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 14:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B58920A78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 12:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B18228CB5;
	Thu, 24 Apr 2025 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u9gRpvYC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE89B22A4F6
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496092; cv=none; b=D0IceEaWsKWyy89MQBWTKfDiTh9LPfgi1gtOUt3Qn5fBHClOU/fNjSZH7Ne0xJ1iY8E5+z7fzD6Bw46ZdSGEf3pHcw371fcF/gY4GZb3Al+iE0kiv17y8UsLugqXvpyqFE17ruRGLrTVPKPkgg0VZ7h78DFkUakHFgYXddrMszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496092; c=relaxed/simple;
	bh=RDRKZeNKN55umrzQ5oGHsI+0KYc+ooDByqGf/CbRS4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSOJnC8Ym0GA+qvA80PLRm8aV9Ddx2hIY1OYlh6SK7l2umfT33YrMPFmcPTPqSQp18y8vNd3BYysrZl+kQNqm3eHitT/DjBDL3zYhITp/XblQoHvN2xO3vUcyc5pDGbk7agBfC2nR1SaOkG2vsTA2HrHkl6kudUTYskKTPi/Lh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u9gRpvYC; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Apr 2025 08:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745496087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T2MMeEmusMY/E/i/SQKbyFaL7BU6CcGYmFZRFD2drdA=;
	b=u9gRpvYCA7IkAb0B4poNcSjWcfnEIwKuPsuUltPGgb8dOqhtvOFUuqTpBE1musH7/BVP9b
	38vbULDjl6NCX/pmhSnebe2rg3ejQKWdffXIWBn1CsORMSUQcA3dgQXk9yIE8/M4BAoo1k
	1DBuUEL/zkkYq7EeqOTzQe9EbZUJZTQ=
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
Message-ID: <anc2qstnukiwtskc4pd3kqajfswm3dzljxwa3awrxjs7mzppoc@nziz3h4ilqpd>
References: <20250422142628.1553523-1-hch@lst.de>
 <jetduw7zshrmp4gl7zfpwqjweycwesxiod7xvtnxqwqekgtvdf@idwnvfzvhgik>
 <20250423093621.GA2578@lst.de>
 <sl4oibdxpjygqfpy6llq237zuckz7ym4fmzcfvxn2raofr37a5@hvevbcgm5trn>
 <20250423160733.GA656@lst.de>
 <q53k4x5nshvr2zatrgyhygxouv7ijyepe6cj2pfooemi6gbu4y@lpxxcvozazzu>
 <20250424083740.GA24723@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424083740.GA24723@lst.de>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 24, 2025 at 10:37:40AM +0200, Christoph Hellwig wrote:
> On Wed, Apr 23, 2025 at 02:02:11PM -0400, Kent Overstreet wrote:
> > Allocating your own bio doesn't allow you to safely exceed the
> > BIO_MAX_VECS limit - there's places in the io path that need to bounce,
> > and they all use biosets.
> 
> Yes.  Another reason not to do it, which I don't want to anyway.
> 
> But we do have a few places that do it like squashs which we need to
> weed out.  And/or finally kill the bounce bufferingreal, which is long
> overdue.
> 
> > That may be an issue even for non vmalloc bios, unless everything that
> > bounces has been converted to bounce to a folio of the same order.
> 
> Anything that actually hits the bounce buffering is going to
> cause problems because it hasn't kept up with the evolution of
> the block layer, and is basically not used for anything relevant.

It's not just block/bounce.c that does bouncing, though.

e.g. bcache has to bounce on a cache miss that will be written to the
cache - we don't want to wait for the write to the backing device to
complete before returning the read completion, and we can't write to the
backing device with the original buffer if it was mapped to userspace.

I'm pretty sure I've seen bouncing in dm and maybe md as well, but it's
been years.

> > > The problem with transparent vmalloc handling is that it's not possible.
> > > The magic handling for virtually indexed caches can be hidden on the
> > > submission side, but the completion side also needs to call
> > > invalidate_kernel_vmap_range for reads.  Requiring the caller to know
> > > they deal vmalloc is a way to at least keep that on the radar.
> > 
> > yeesh, that's a landmine.
> > 
> > having a separate bio_add_vmalloc as a hint is still a really bad
> > "solution", unfortunately. And since this is something we don't have
> > sanitizers or debug code for, and it only shows up on some archs -
> > that's nasty.
> 
> Well, we can't do it in the block stack because that doesn't have the
> vmalloc address available.  So the caller has to do it, and having a
> very visible sign is the best we can do.  Yes, signs aren't the
> best cure for landmines, but they are better than nothing.

Given that only a few architectures need it, maybe sticking the vmalloc
address in struct bio is something we should think about.

Obviously not worth it if only 2-3 codepaths need it, but if vmalloc
fallbacks become more common it's something to think about.

> > > Not for a purely synchronous helper we could handle both, but so far
> > > I've not seen anything but the xfs log recovery code that needs it,
> > > and we'd probably get into needing to pass a bio_set to avoid
> > > deadlock when used deeper in the stack, etc.  I can look into that
> > > if we have more than a single user, but for now it doesn't seem
> > > worth it.
> > 
> > bcache and bcachefs btree buffers can also be vmalloc backed. Possibly
> > also the prio_set path in bcache, for reading/writing bucket gens, but
> > I'd have to check.
> 
> But do you do synchronous I/O, i.e. using sumit_bio_wait on them?

Most btree node reads are synchronous, but not when we're prefetching.

