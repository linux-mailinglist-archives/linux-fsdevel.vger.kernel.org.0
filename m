Return-Path: <linux-fsdevel+bounces-59469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AA6B396CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 10:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C99D189D4BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 08:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C07F2DEA7B;
	Thu, 28 Aug 2025 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+agvb9x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE7B849C;
	Thu, 28 Aug 2025 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369448; cv=none; b=kepfNMqSbvlE+JiVXnFkG8jMV85Q4zXCotixFJlZ1uK3mrtn9zS17LxJ6Wl4NcrkNcBW37oubjohNLWpWDeb8mL4wKtnybx0/kILZgjtj4PR1MJUHD8c1k+vFbhyC1I8m4ifOMi/mH4qGnIbFYnwRN/DXbUWq4U1PJw+5Qa0Zo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369448; c=relaxed/simple;
	bh=RwBgH5v8YJpYJqLz1ozvOeDtoOvRSy9/swn9P5xY8rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TE4Qc9D8QWLgI24Jc7G+uSk2vbB495iGAABuIXTiS6+W/G5GFalLxOb3feH5SS7uV2NXbvGOlnACYujRLvhNLMslMxPRT0aW0MZk6QlIPlQnYeoUVHpX7Hn22P6sJTipss290INPjWAdV5rZMUXAU7jf0HCE5E3m/NT1xHXDpbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+agvb9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A975C4CEEB;
	Thu, 28 Aug 2025 08:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756369448;
	bh=RwBgH5v8YJpYJqLz1ozvOeDtoOvRSy9/swn9P5xY8rA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+agvb9xMMS/KKbuwl4cTD/dWT1EFAzP6plhYf24nKmZds2z75NT+ZFe6gsczanFR
	 j2ny30OJGiybUrPBrZj2jGDvw8Iwu2Pz4j9sVrUavQJID0ddJlsPMVBfTvyimayPSV
	 kxmRFpmGvs4b8R/BXx26GrpXT2T1SbnzAuRfjO8Ygk+BhJkaSoZWtzVSnHH+KY1PBC
	 O+EDQTDWoqID5DXtyqCFcHCeEcHaC/e+5Dns/Ob0A+mbred93Iyucu6IOD+tP1/bv9
	 Z1AGJQrf9yBJweJ3IN3b1y4mkedBDrAK1Wyz4mbgNu0tKSEfdbQ/Q0nB2uNBWd0n3L
	 PQ4F+oSTwhuUA==
Date: Thu, 28 Aug 2025 10:24:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 15/54] fs: maintain a list of pinned inodes
Message-ID: <20250828-chorkonzert-forschen-0203eae65f7f@brauner>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <35dc849a851470e2a31375ecdfdf70424844c871.1756222465.git.josef@toxicpanda.com>
 <20250827-gelandet-heizt-1f250f77bfc8@brauner>
 <20250827160756.GA2272053@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250827160756.GA2272053@perftesting>

On Wed, Aug 27, 2025 at 12:07:56PM -0400, Josef Bacik wrote:
> On Wed, Aug 27, 2025 at 05:20:17PM +0200, Christian Brauner wrote:
> > On Tue, Aug 26, 2025 at 11:39:15AM -0400, Josef Bacik wrote:
> > > Currently we have relied on dirty inodes and inodes with cache on them
> > > to simply be left hanging around on the system outside of an LRU. The
> > > only way to make sure these inodes are eventually reclaimed is because
> > > dirty writeback will grab a reference on the inode and then iput it when
> > > it's done, potentially getting it on the LRU. For the cached case the
> > > page cache deletion path will call inode_add_lru when the inode no
> > > longer has cached pages in order to make sure the inode object can be
> > > freed eventually.  In the unmount case we walk all inodes and free them
> > > so this all works out fine.
> > > 
> > > But we want to eliminate 0 i_count objects as a concept, so we need a
> > > mechanism to hold a reference on these pinned inodes. To that end, add a
> > > list to the super block that contains any inodes that are cached for one
> > > reason or another.
> > > 
> > > When we call inode_add_lru(), if the inode falls into one of these
> > > categories, we will add it to the cached inode list and hold an
> > > i_obj_count reference.  If the inode does not fall into one of these
> > > categories it will be moved to the normal LRU, which is already holds an
> > > i_obj_count reference.
> > > 
> > > The dirty case we will delete it from the LRU if it is on one, and then
> > > the iput after the writeout will make sure it's placed onto the correct
> > > list at that point.
> > > 
> > > The page cache case will migrate it when it calls inode_add_lru() when
> > > deleting pages from the page cache.
> > > 
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > ---
> > 
> > Ok, I'm trying to wrap my head around the justification for this new
> > list. Currently we have inodes with a zero reference counts that aren't
> > on any LRU. They just appear on sb->i_sb_list and are e.g., dealt with
> > during umount (sync_filesystem() followed by evict_inodes()).
> > 
> > So they're either dealt with by writeback or by the page cache and are
> > eventually put on the regular LRU or the filesystem shuts down before
> > that happens.
> > 
> > They're easy to handle and recognize because their inode->i_count is
> > zero.
> > 
> > Now you make the LRUs hold a full reference so it can be grabbed from
> > the LRU again avoiding the zombie resurrection from zero. So to
> > recognize inodes that are pinned internally due to being dirty or having
> > pagecache pages attached to it you need to track them in a new list
> > otherwise you can't really differentiate them and when to move them onto
> > the LRU after writeback and pagecache is done with them.
> > 
> 
> Exactly. We need to put them somewhere so we can account for their reference.
> 
> We could technically just use a flag and not have a list for this, and just use
> the flag to indicate that the inode is pinned and the flag has a full reference
> associated with it.
> 
> I did it this way because if I had a nickel for every time I needed to figure
> out where a zombie inode was and had to do the most grotesque drgn magic to find
> it, I'd have like 15 cents, which isn't a lot but weird that it's happened 3
> times. Having a list makes it easier from a debugging perspective.
> 
> But again, we have ->s_inodes, and I can just scan that list and look for
> I_LRU_CACHED. We'd still need to hold a full reference for that, but it would
> eliminate the need for another list if that's more preferable?  Thanks,

I don't mind the additional list and the sb struct is not very size
sensitive anyway.

