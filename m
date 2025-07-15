Return-Path: <linux-fsdevel+bounces-54997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F14CB063EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 18:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE7658090A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 16:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A298248878;
	Tue, 15 Jul 2025 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="niAZBK62"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B59F2066CE
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595754; cv=none; b=AQSjef+wYGYWC50tkvzvus0/KbXB/pAjW8D14fkl9Mklzej6mOjceAZkX+92YfpapV5cYxbn6XrS4Xb/RKcM9zk3bA1WMmPH1OYOVhUovmvX9Fypku7T7bng8d6QnyOqaKsHTsimCmqLvz6GG4UdzbUHLOg6fdqoXx8nsGhyfbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595754; c=relaxed/simple;
	bh=oQ5aGSaOmj5IY5psYrCSnR0DW4NMTUkBlGkaE6ClEcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jY4nYWqdgu7yAj7p+erJIldCfbIdJakjH4163EnkXpF5gXF4KKGAqjXxo7QECS+aaoXYJl3j+dK7X+hHOdAXc0MG/fraux4WaCpDcN8umbuR7vxzxwzQTi6/gSmfxCMUHo7p0Mhog7RY2/ojzjyJKLOrPMlKJNSrL4vkWfP5aAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=niAZBK62; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k10L6FnzXKu+nTVvS46Hu2/BpcztSpVyQ/VoRzLm/eY=; b=niAZBK62gdZejq6fTwlDPaOsIH
	M8Jrr1UZJD8nwoPhIsUK2MuB5TwEXAE85zkvdQwuGdqchmzgl7VSMEdBZhM94hwxPZwqmm2uiymPk
	KvzfhIErIaviYKh/7NA3Mz6j7L1CSYl/FnW/kJve+ReMlfLixcjhpGQR+RPTOPUl7y0rmeQuDZl1M
	q/nZrh36Y+vgSvHfLFnbyTwEFPDXPwKdUjrabdrlyRLVrmxi4/mjA3R3z+mEanq6e4eqMlLCTmog/
	IwK2ljNs8EJzd7ZJsa1f286AiTFE+ukjnzHmGwj/N6C3JQ9ydQFKdLi7s/svVsLuplARwP+OEXj8X
	Cmr9FZWw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubiDH-0000000D3SO-2Lma;
	Tue, 15 Jul 2025 16:09:03 +0000
Date: Tue, 15 Jul 2025 17:09:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <aHZ9H_3FPnPzPZrg@casper.infradead.org>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org>

On Tue, Jul 15, 2025 at 04:35:24PM +0200, Christian Brauner wrote:
> struct inode is bloated as everyone is aware and we should try and
> shrink it as that's potentially a lot of memory savings. I've already
> freed up around 8 bytes but we can probably do better.

OK, but let's make sure we're actually achieving memory savings.
First, inodes are allocated from slabs.  If we reduce a struct from,
say, 596 to 592 bytes, we'll still get 27 of them in a 16KiB page
(although we'd get 110 instead of 109 in a 64KiB page!) so we need
to be crossing some important boundaries to actually make a difference.

For block/network filesystems, those slabs are fs-private with
struct inode embedded into struct fs_inode.  eg:

xfs_inode         584600 593856   1024   32    8 : tunables    0    0    0 : slabdata  18558  18558      0
ext4_inode_cache     756    756   1168   28    8 : tunables    0    0    0 : slabdata     27     27      0
proc_inode_cache   18316  19136    704   46    8 : tunables    0    0    0 : slabdata    416    416      0
inode_cache         8059   9325    632   25    4 : tunables    0    0    0 : slabdata    373    373      0

That's on a machine running 6.12 and pahole tells me struct inode is
currently 624 bytes, so yes, you've saved 8 bytes (Debian config).
And we've gone from 25 objects per 16KiB to 26, so yay!  Getting to 27
will be harder, we have to get to 604 bytes.  Although for my system if
we could get xfs_inode down from 1024 bytes to 992, that'd save me much
more memory ;-)

We could get rid of i_io_list by using an allocating xarray to store the
inodes in each backing_dev.  There's 16 bytes (would probably need to
retain a 4 byte ID to allow for efficient deletion from the xarray,
and there are multiple lists it might be on, so perhaps 3 bits to
determine which list it's on).

That might work for i_sb_list, i_sb_list and i_lru too.  That could get
us 48 bytes.

We can also win in inode by shrinking address_space.  nr_thps is
one I want to kill.  That'll get us 8 bytes back as soon as btrfs
lets us drop CONFIG_READ_ONLY_THP_FOR_FS.

The i_private_* members in i_data can probably also go.  Mostly they're
used for buffer_heads.  So more conversion to iomap will help with that.


I wonder if we can shift from having i_data embedded in struct inode
to embedding it in struct foofs_inode.  Then procfs and other pseudo
filesystems wouldn't allocate 192 bytes worth of data ...

