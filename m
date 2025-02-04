Return-Path: <linux-fsdevel+bounces-40696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E374CA26B35
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 06:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76643166CEB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 05:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2D519C54B;
	Tue,  4 Feb 2025 05:06:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909D712D758
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 05:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738645610; cv=none; b=Nw31hVnUsmRduoenhAqbOq3YJ/Q0MEYWmr/d9r/WgzBpd+vCFeZ/viZq00/BgVPHquP0aEef7lxFxga+1yXePbitC1oI26nmzYquHQliQRUTNNFTmiOKpMd6EfICPGRPFuTkfBECIb+lP8fo5/crPhNS8H12gAUFIB2Wt07Yveg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738645610; c=relaxed/simple;
	bh=ws27pxG7FH+YZsN7DjkhGWm8kifUnbhTIEBNVp2ZdDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYaBFiADlJGgNkAaq3j3db8mBby//3G3kkNNXQe9CbEJheumxoyrxG1g/ivuPJIkQzQjI0HrCCCnEVdP76/4CycJWIX69w3xt2f++8VUhOlJ2HMmbCDDYW6oxzPD4/YHUq66pkb698MtM3u9KSSRCOQenjP1IAriVbXY9ZksQlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4462868AFE; Tue,  4 Feb 2025 06:06:43 +0100 (CET)
Date: Tue, 4 Feb 2025 06:06:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Kundan Kumar <kundan.kumar@samsung.com>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	anuj20.g@samsung.com, mcgrof@kernel.org, joshi.k@samsung.com,
	axboe@kernel.dk, clm@meta.com, hch@lst.de, willy@infradead.org,
	gost.dev@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] Parallelizing filesystem writeback
Message-ID: <20250204050642.GF28103@lst.de>
References: <CGME20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749@epcas5p1.samsung.com> <20250129102627.161448-1-kundan.kumar@samsung.com> <Z5qw_1BOqiFum5Dn@dread.disaster.area> <20250131093209.6luwm4ny5kj34jqc@green245> <Z6GAYFN3foyBlUxK@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6GAYFN3foyBlUxK@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Feb 04, 2025 at 01:50:08PM +1100, Dave Chinner wrote:
> I doubt that will create enough concurrency for a typical small
> server or desktop machine that only has a single NUMA node but has a
> couple of fast nvme SSDs in it.
> 
> > 2) Fixed number of writeback contexts, say min(10, numcpu).
> > 3) NUMCPU/N number of writeback contexts.
> 
> These don't take into account the concurrency available from
> the underlying filesystem or storage.
> 
> That's the point I was making - CPU count has -zero- relationship to
> the concurrency the filesystem and/or storage provide the system. It
> is fundamentally incorrect to base decisions about IO concurrency on
> the number of CPU cores in the system.

Yes.  But as mention in my initial reply there is a use case for more
WB threads than fs writeback contexts, which is when the writeback
threads do CPU intensive work like compression.  Being able to do that
from normal writeback threads vs forking out out to fs level threads
would really simply the btrfs code a lot.  Not really interesting for
XFS right now of course.

Or in other words: fs / device geometry really should be the main
driver, but if a file systems supports compression (or really expensive
data checksums) being able to scale up the numbes of threads per
context might still make sense.  But that's really the advanced part,
we'll need to get the fs geometry aligned to work first.

> > > XFS largely stem from the per-IO cpu overhead of block allocation in
> > > the filesystems (i.e. delayed allocation).
> > 
> > This is a good idea, but it means we will not be able to paralellize within
> > an AG.
> 
> The XFS allocation concurrency model scales out across AGs, not
> within AGs. If we need writeback concurrency within an AG (e.g. for
> pure overwrite concurrency) then we want async dispatch worker
> threads per writeback queue, not multiple writeback queues per
> AG....

Unless the computational work mentioned above is involved there would be
something really wrong if we're saturating a CPU per AG.


