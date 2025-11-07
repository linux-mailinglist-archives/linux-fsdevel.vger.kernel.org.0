Return-Path: <linux-fsdevel+bounces-67437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1395C4027B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 14:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B26E3BF8E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 13:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECF122A7E9;
	Fri,  7 Nov 2025 13:37:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69B02EBB99;
	Fri,  7 Nov 2025 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522672; cv=none; b=FYiPJGCeyL+koU+REBKjbNpJjeeDcLEETY2hwTv6FXZx73igAxE39lRgrMlyqrv083rm2phFt1tloSZhn81o1c+BoTgRpHwKT/Kla94SkM85Qk+HaQ/mdIPmgA+1TkceIJdh/Bz9V0syJoIyEJ3wJABCEk/axcNonr7629OEfDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522672; c=relaxed/simple;
	bh=8xZspVBCCIAUVlKCUDdtd84EGV/fxhteLT5WItRN29A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mauRWr1qb/4OPdpI3JJuYOR81JjQcBcKBLmxuUpn7LveW0DxJsB2fhqFc0sejcicwbzfC4lo0Gnah83m90+zR8ioLmLBBCS4/v3z/Mjzv9US+Hu13QeCM9Wey7A1Eb/X5YOxbHZUqfX6bAC5S8diH0IUbjZKCl8Q8ED/guUsirw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6E374227AAE; Fri,  7 Nov 2025 14:37:42 +0100 (CET)
Date: Fri, 7 Nov 2025 14:37:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>, jaegeuk@kernel.org,
	chao@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com,
	amir73il@gmail.com, axboe@kernel.dk, ritesh.list@gmail.com,
	dave@stgolabs.net, wangyufei@vivo.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Subject: Re: [PATCH v2 00/16] Parallelizing filesystem writeback
Message-ID: <20251107133742.GA5596@lst.de>
References: <CGME20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9@epcas5p2.samsung.com> <20251014120845.2361-1-kundan.kumar@samsung.com> <aPa7xozr7YbZX0W4@dread.disaster.area> <20251022043930.GC2371@lst.de> <e51e4fb9-01f7-4273-a363-fc1c2c61954b@samsung.com> <20251029060932.GS4015566@frogsfrogsfrogs> <20251029085526.GA32407@lst.de> <91367b76-e48b-46b4-b10b-43dfdd8472fa@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91367b76-e48b-46b4-b10b-43dfdd8472fa@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 07, 2025 at 02:54:42PM +0530, Kundan Kumar wrote:
> Predicting the Allocation Group (AG) for aged filesystems and passing
> this information to per-AG writeback threads appears to be a complex
> task.

Yes.  But in the end aged file systems are what will see most usage.
Fresh file systems look nice in benchmarks, but they aren't what
users will mostly deal with.

> To segregate these I/O requests by AG, it is necessary to associate
> AG-specific information with the pages/folios in the page cache. Two
> possible approaches are:
> (1) storing AG information in the folio->private field, or
> (2) introducing new markers in the xarray to track AG-specific data.
> 
> The AG-affined writeback thread processes specific pages from the page 
> cache marked for its AG. Is this a viable approach, or are there 
> alternative solutions that could be more effective?

Or maybe the per-AG scheme isn't that great after all and we just
need some other simple sharding scheme?  Of course lock contention
will be nicer on a per-AG basis, but as you found out actually
mapping high-level writeback to AGs is pretty hard.


