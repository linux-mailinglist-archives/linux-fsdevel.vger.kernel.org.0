Return-Path: <linux-fsdevel+bounces-46018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D8BA81512
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 20:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630B94E141D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 18:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A87253B41;
	Tue,  8 Apr 2025 18:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VFqLiaqT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029E9243951;
	Tue,  8 Apr 2025 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744138280; cv=none; b=rzZaKD1p/nU7uVu1z3rQfgCRz8vRryRa3a7G3Mt/65nRLLR4gGcWs2+u53WtaZY6kTmfskddgXvS1Vb6QF/Z897Zekb9V4mSBxU++mQRH/1jTj3mRwMTQ6PYLN8d/Vn8mKKCCTcnUBZoEtgpuSRcsUWqnSqkJkjI62AUvne9S2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744138280; c=relaxed/simple;
	bh=yd4HwMIHLUXwNjh1rWWKwl1AOIFqUaHGnxyK9DsWnf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+MNRkNkvjdC+ezVTuA4hBLX/bn440xglmLh5vFt5XihgARagt1NjctrVdm3p6yieslHZF2gugQLoBvw8QZslMPLDvr7K9VV8KZx39QobzzL5KmYdWRCqBawggFImDOy+RZNwlEmMG4Zk6zYdzQNiBglbsRi9cmTU2b7sqC7rdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VFqLiaqT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=dGXZXPhKoociiuci5ixZu5eBgeCDmzv+oG1pcsW8GV4=; b=VFqLiaqTw8f6tco2SORsdJWtgu
	A5OH0bv6WxDDDP3nV1dDvIhWpx9JgDZGSCPJ5DOp2s5MjxFSDkdKlWcdSxg8tKcnnfXLewT4tgnF7
	vQTgFjBX0pb14srq9b5LjU58Bg8j1wjeSn8yQVmYllw8BjlCD3WxwLFtilsRhY2H6J9Bl6EY92Lbt
	U+B9S1JAE5I/7x/VR6SqkEbpveJ7T8zLVdQVapIVfSf0nmDs498RgINuPSAw+c53BapppK8eJJVbY
	SlUe9Y1Dgke/Ij8VjTeZqXLSYgy4GK2nipp8qUiC1QqJ/VgNm8qyJPvb3+3xWNXFfgCt0XXU5CE6y
	Ubsgg21Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u2E2J-00000000LgK-45gI;
	Tue, 08 Apr 2025 18:51:04 +0000
Date: Tue, 8 Apr 2025 19:51:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, David Bueso <dave@stgolabs.net>,
	Jan Kara <jack@suse.cz>, Kefeng Wang <wangkefeng.wang@huawei.com>,
	Tso Ted <tytso@mit.edu>, Ritesh Harjani <ritesh.list@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Oliver Sang <oliver.sang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>,
	Hannes Reinecke <hare@suse.de>, oe-lkp@lists.linux.dev,
	lkp@intel.com, John Garry <john.g.garry@oracle.com>,
	linux-block@vger.kernel.org, ltp@lists.linux.it,
	Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Chinner <david@fromorbit.com>, gost.dev@samsung.com,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [linux-next:master] [block/bdev] 3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
Message-ID: <Z_VwF1MA-R7MgDVG@casper.infradead.org>
References: <20250331074541.gK4N_A2Q@linutronix.de>
 <20250408164307.GK6266@frogsfrogsfrogs>
 <Z_VXpD-d8iC57dBc@bombadil.infradead.org>
 <CAB=NE6X2QztC4OGnJwxRWdeCVEekLBcnFf7JcgV1pKDn6DqhcA@mail.gmail.com>
 <20250408174855.GI6307@frogsfrogsfrogs>
 <Z_ViElxiCcDNpUW8@casper.infradead.org>
 <20250408180240.GM6266@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250408180240.GM6266@frogsfrogsfrogs>

On Tue, Apr 08, 2025 at 11:02:40AM -0700, Darrick J. Wong wrote:
> On Tue, Apr 08, 2025 at 06:51:14PM +0100, Matthew Wilcox wrote:
> > On Tue, Apr 08, 2025 at 10:48:55AM -0700, Darrick J. Wong wrote:
> > > On Tue, Apr 08, 2025 at 10:24:40AM -0700, Luis Chamberlain wrote:
> > > > On Tue, Apr 8, 2025 at 10:06 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > > > Fun
> > > > > puzzle for the community is figuring out *why* oh why did a large folio
> > > > > end up being used on buffer-heads for your use case *without* an LBS
> > > > > device (logical block size) being present, as I assume you didn't have
> > > > > one, ie say a nvme or virtio block device with logical block size  >
> > > > > PAGE_SIZE. The area in question would trigger on folio migration *only*
> > > > > if you are migrating large buffer-head folios. We only create those
> > > > 
> > > > To be clear, large folios for buffer-heads.
> > > > > if
> > > > > you have an LBS device and are leveraging the block device cache or a
> > > > > filesystem with buffer-heads with LBS (they don't exist yet other than
> > > > > the block device cache).
> > > 
> > > My guess is that udev or something tries to read the disk label in
> > > response to some uevent (mkfs, mount, unmount, etc), which creates a
> > > large folio because min_order > 0, and attaches a buffer head.  There's
> > > a separate crash report that I'll cc you on.
> > 
> > But you said:
> > 
> > > the machine is arm64 with 64k basepages and 4k fsblock size:
> > 
> > so that shouldn't be using large folios because you should have set the
> > order to 0.  Right?  Or did you mis-speak and use a 4K PAGE_SIZE kernel
> > with a 64k fsblocksize?
> 
> This particular kernel warning is arm64 with 64k base pages and a 4k
> fsblock size, and my suspicion is that udev/libblkid are creating the
> buffer heads or something weird like that.
> 
> On x64 with 4k base pages, xfs/032 creates a filesystem with 64k sector
> size and there's an actual kernel crash resulting from a udev worker:
> https://lore.kernel.org/linux-fsdevel/20250408175125.GL6266@frogsfrogsfrogs/T/#u
> 
> So I didn't misspeak, I just have two problems.  I actually have four
> problems, but the others are loop device behavior changes.

Right, but this warning only triggers for large folios.  So somehow
we've got a multi-page folio in the bdev's page cache.

Ah.  I see.

block/bdev.c:   mapping_set_folio_min_order(BD_INODE(bdev)->i_mapping,

so we're telling the bdev that it can go up to MAX_PAGECACHE_ORDER.
And then we call readahead, which will happily put order-2 folios
in the pagecache because of my bug that we've never bothered fixing.

We should probably fix that now, but as a temporary measure if
you'd like to put:

mapping_set_folio_order_range(BD_INODE(bdev)->i_mapping, min, min)

instead of the mapping_set_folio_min_order(), that would make the bug
no longer appear for you.

