Return-Path: <linux-fsdevel+bounces-46020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91603A815B1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 21:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3973B074E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 19:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D6523F43C;
	Tue,  8 Apr 2025 19:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghNAaHlG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AE9190674;
	Tue,  8 Apr 2025 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139588; cv=none; b=tYpeFzVWQ0VVaJCkx9x/g03XpNfL0OGreQ4IgYasYgQLCrDrJjswQRfW06fFRTDLD5UphG6pzzfktgiuNWIqb1NnYGg1I14m4hK+vSKpB6Y1+hk9ZYUBls0bl3wgD1nsw9X9Tr2AzRIbwbVnEVx0slErgzXU9/H3JojVRT6L5yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139588; c=relaxed/simple;
	bh=epQh/gaUaDDW5jnc7/qOqV5jwYTP+Jz/mj3glQvJiQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0ASnOKbTWlfJjmA8kiaJ1IICtIyjNX01yUYn68K7dOESO+jAkePpvliAGj6Sn51rOIK4unvS1uAr2aCcyGw6SvtRh59z0PHSRuSJoaShjYE+LqiBo5S654YSNAhNkqq41U50G8m9qL3eenO2UlQyqN8561yg/ixEENvDS7SZWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghNAaHlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B25C4CEE5;
	Tue,  8 Apr 2025 19:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744139588;
	bh=epQh/gaUaDDW5jnc7/qOqV5jwYTP+Jz/mj3glQvJiQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ghNAaHlG7bqqdTxG3szwAUndPLZmKSaKqmZSGG4kJL/NidXNlCj+Y1zKbb1AfYUZh
	 u3l6Ml0jksUXqEqFqVVlIVrdweI9ZKdypmpH5OEuIqw74C2giSqyp8L1wZ3MDUfVu4
	 lPXocc1BiOdbt77c5T7nHbZ4ctkLeYmyZmhQ+1GIx93+91m7HQSr5vmSEJJMz6Tftr
	 7vzlMGvyrH3zlAQdsqgPCuYf97ErAmCjzFBVEtK5SYzpYTSzCfxIpNm+WdYf1Tl/E8
	 oennVE7UltJetxq322Q45lj2emq2/buAZozulh4s7ml32uOAqTV+Bj5p6KSo1dPjT3
	 ZWQEFmVjdTaXQ==
Date: Tue, 8 Apr 2025 12:13:06 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, David Bueso <dave@stgolabs.net>,
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
Message-ID: <Z_V1QiXTCYQk9sfZ@bombadil.infradead.org>
References: <20250331074541.gK4N_A2Q@linutronix.de>
 <20250408164307.GK6266@frogsfrogsfrogs>
 <Z_VXpD-d8iC57dBc@bombadil.infradead.org>
 <CAB=NE6X2QztC4OGnJwxRWdeCVEekLBcnFf7JcgV1pKDn6DqhcA@mail.gmail.com>
 <20250408174855.GI6307@frogsfrogsfrogs>
 <Z_ViElxiCcDNpUW8@casper.infradead.org>
 <20250408180240.GM6266@frogsfrogsfrogs>
 <Z_VwF1MA-R7MgDVG@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_VwF1MA-R7MgDVG@casper.infradead.org>

On Tue, Apr 08, 2025 at 07:51:03PM +0100, Matthew Wilcox wrote:
> On Tue, Apr 08, 2025 at 11:02:40AM -0700, Darrick J. Wong wrote:
> > On Tue, Apr 08, 2025 at 06:51:14PM +0100, Matthew Wilcox wrote:
> > > On Tue, Apr 08, 2025 at 10:48:55AM -0700, Darrick J. Wong wrote:
> > > > On Tue, Apr 08, 2025 at 10:24:40AM -0700, Luis Chamberlain wrote:
> > > > > On Tue, Apr 8, 2025 at 10:06 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > > > > Fun
> > > > > > puzzle for the community is figuring out *why* oh why did a large folio
> > > > > > end up being used on buffer-heads for your use case *without* an LBS
> > > > > > device (logical block size) being present, as I assume you didn't have
> > > > > > one, ie say a nvme or virtio block device with logical block size  >
> > > > > > PAGE_SIZE. The area in question would trigger on folio migration *only*
> > > > > > if you are migrating large buffer-head folios. We only create those
> > > > > 
> > > > > To be clear, large folios for buffer-heads.
> > > > > > if
> > > > > > you have an LBS device and are leveraging the block device cache or a
> > > > > > filesystem with buffer-heads with LBS (they don't exist yet other than
> > > > > > the block device cache).
> > > > 
> > > > My guess is that udev or something tries to read the disk label in
> > > > response to some uevent (mkfs, mount, unmount, etc), which creates a
> > > > large folio because min_order > 0, and attaches a buffer head.  There's
> > > > a separate crash report that I'll cc you on.
> > > 
> > > But you said:
> > > 
> > > > the machine is arm64 with 64k basepages and 4k fsblock size:
> > > 
> > > so that shouldn't be using large folios because you should have set the
> > > order to 0.  Right?  Or did you mis-speak and use a 4K PAGE_SIZE kernel
> > > with a 64k fsblocksize?
> > 
> > This particular kernel warning is arm64 with 64k base pages and a 4k
> > fsblock size, and my suspicion is that udev/libblkid are creating the
> > buffer heads or something weird like that.
> > 
> > On x64 with 4k base pages, xfs/032 creates a filesystem with 64k sector
> > size and there's an actual kernel crash resulting from a udev worker:
> > https://lore.kernel.org/linux-fsdevel/20250408175125.GL6266@frogsfrogsfrogs/T/#u
> > 
> > So I didn't misspeak, I just have two problems.  I actually have four
> > problems, but the others are loop device behavior changes.
> 
> Right, but this warning only triggers for large folios.  So somehow
> we've got a multi-page folio in the bdev's page cache.
> 
> Ah.  I see.
> 
> block/bdev.c:   mapping_set_folio_min_order(BD_INODE(bdev)->i_mapping,
> 
> so we're telling the bdev that it can go up to MAX_PAGECACHE_ORDER.

Ah yes silly me that would explain the large folios without LBS devices.

> And then we call readahead, which will happily put order-2 folios
> in the pagecache because of my bug that we've never bothered fixing.
> 
> We should probably fix that now, but as a temporary measure if
> you'd like to put:
> 
> mapping_set_folio_order_range(BD_INODE(bdev)->i_mapping, min, min)
> 
> instead of the mapping_set_folio_min_order(), that would make the bug
> no longer appear for you.

Agreed.

  Luis

