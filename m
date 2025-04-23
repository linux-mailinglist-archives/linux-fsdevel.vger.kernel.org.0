Return-Path: <linux-fsdevel+bounces-47084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 155FDA987A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 12:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86E187AA1BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 10:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8720326A0D6;
	Wed, 23 Apr 2025 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NZlBfTS0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9962701A7
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 10:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745404671; cv=none; b=mZbjC5iuJjvXnvITXrtXPFa69PxUsJJPBHEBux5bKpKKPgfzxSb5hbjiM4DcivCz8Lp+5yOTafr9m1DGC/+7KuIc8XWzO6I/rehVNzqJ5bKv+s1fE83vZ0nl92fe4hYNWBJe+ZM4iRRTSIVIO09AZgnclKvTwozQMn12XO4J5tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745404671; c=relaxed/simple;
	bh=H4yB2VqdHW5Mx37gnKyyS6SHLyLBKUckwyP7mf95yYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLOQ3LiY2T6i1jv0DQo3pVYGdqxfCPXVX78UKjG/MmGNXVeuQMTd0Bbq4YST6hpNZXXD5eOVXrTTq1Bxgpp0aWNVEVlN/m2kwEXAWTn2u8PahX3k1Z3tZwgymNRKzI8PE4CFEqlP5lTJCGGZTQZSbJ2uxOD2E2i3YaVbPy90BYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NZlBfTS0; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 23 Apr 2025 06:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745404666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h1X705brQVpSptGLrhJRMpaEPjNIn6bUE+IhmWlVE2o=;
	b=NZlBfTS0IpoVJRDdMvVxxcB/Lpwrab9NO5G3uKZDmuyi8mzIO86I/PUXd88XgzTuZn49ST
	gLriQ//WfXAV/lq3WsPhVF0GKJr+Bfeylib4vQvVxRXxFayAYBivCT7jC8OAWmtGBUIn4/
	DcUPlLzvzWL7UaMq94B3xWZYQRWCxS4=
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
Message-ID: <sl4oibdxpjygqfpy6llq237zuckz7ym4fmzcfvxn2raofr37a5@hvevbcgm5trn>
References: <20250422142628.1553523-1-hch@lst.de>
 <jetduw7zshrmp4gl7zfpwqjweycwesxiod7xvtnxqwqekgtvdf@idwnvfzvhgik>
 <20250423093621.GA2578@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423093621.GA2578@lst.de>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 23, 2025 at 11:36:21AM +0200, Christoph Hellwig wrote:
> On Tue, Apr 22, 2025 at 10:47:03AM -0400, Kent Overstreet wrote:
> > On Tue, Apr 22, 2025 at 04:26:01PM +0200, Christoph Hellwig wrote:
> > > Hi all,
> > > 
> > > this series adds more block layer helpers to remove boilerplate code when
> > > adding memory to a bio or to even do the entire synchronous I/O.
> > > 
> > > The main aim is to avoid having to convert to a struct page in the caller
> > > when adding kernel direct mapping or vmalloc memory.
> > 
> > have you seen (bch,bch2)_bio_map?
> 
> Now I have.
> 
> > 
> > it's a nicer interface than your bio_add_vmalloc(), and also handles the
> > if (is_vmalloc_addr())
> 
> Can you explain how it's nicer?
> 
> For use with non-vmalloc memory it does a lot of extra work
> and generates less optimal bios using more vecs than required, but
> maybe that wasn't the point?
> 
> For vmalloc it might also build suboptimal bios when using large vmalloc
> mappings due to the lack of merging, but I don't think anyone does I/O to
> those yet.
> 
> It lacks a API description and it or the callers miss handling for VIVT
> caches, maybe because of that.
> 
> Besides optimizing the direct map case that always needs just one vec
> that is also one of the reasons why I want the callers to know about
> vmalloc vs non-vmalloc memory.

Sure, that code predates multipage bvecs - the interface is what I was
referring to.

> It also don't support bio chaining or error handling and requires a
> single bio that is guaranteed to fit the required number of vectors.

Why would bio chaining ever be required? The caller allocates both the
buf and the bio, I've never seen an instance where you'd want that; just
allocate a bio with the correct number of vecs, which your
bio_vmalloc_max_vecs() helps with.

> OTOH for callers where that applies it would be nice to have a
> helper that loops over bio_add_vmalloc.  I actually had one initially,
> but given that I only found two obvious users I dropped it for now.
> If we get more we can add one.

The "abstract over vmalloc and normal physically contigious allocations"
bit that bch2_bio_map() does is the important part.

It's not uncommon to prefer physically contiguous allocations but have a
vmalloc fallback; bcachefs does, and  xfs does with a clever "try the
big allocation if it's cheap, fall back to vmalloc to avoid waiting on
compaction" that I might steal.

is_vmalloc_addr() is also cheap, it's just a pointer comparison (and it
really should be changed to a static inline).

