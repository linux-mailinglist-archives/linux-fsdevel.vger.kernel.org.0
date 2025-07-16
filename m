Return-Path: <linux-fsdevel+bounces-55160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 420E9B07642
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 14:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792BB1C25558
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 12:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF322F431F;
	Wed, 16 Jul 2025 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jw3GA6ME"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE2C2F3C2F
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670406; cv=none; b=h21hsAv190f5785mID/oJQofDc16OB9BoOR1g676lIRrZvZP/yjJOTyhsmTWicNfszLWUkNdMhPLF/rjuOu7dcBgDAplTDCzybIqgDBPaGCGwyJm0tda0yvUkasZPXM/kkh6olkzOzUPkzrYVIAkJBbn0UeoWZQfYegaTu3IXuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670406; c=relaxed/simple;
	bh=SVjRlAyqhEHK/OP8H90Bd7bVPMUhFAPKM083e3imW/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F24jvqsFcPagKQ49WP43FVRGmAow1olMLaFq3R1d9lK3p7mcFFzzuqy23ORMcdFsm/V131XmMDSyGnb1o3m+VkhUA4ocMejyKQsK/H2lD9L+aE7E2SqcN0it/n5qRKUXkzhg6nur0vBrAN+XbKVfLO0+NRpWPXisf3VNC8oXIf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jw3GA6ME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4373C4CEF4;
	Wed, 16 Jul 2025 12:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752670405;
	bh=SVjRlAyqhEHK/OP8H90Bd7bVPMUhFAPKM083e3imW/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jw3GA6MEPbPEKrGnma4yLeLfPNq4uEGQ/y/mSi/APqh/rFq8SHeT2Bq19ZNM3bYi5
	 i0b4ftErMUBZp5p87s2qYFsCXXypbOdID3aiJIOBLaN3zFzvRn0xLq0HpazQFeZ27m
	 nHwZOdxjQ0Ul8ssKM1/KEhPH6nHQeuS+qAkNhrnP3s0g4f/SY2Yfbvu+s2+XpqKTxM
	 QLyt66pBBQg13VVxt7DKllbdIjUbSpHnNbZMJGM/PCwZDvYyFM4pnIt/29QI284RJe
	 CFqvuh9nFKueiBpOdr2zo8qtwq16+QSdfrA3n5kT8/OxzrUe5F4IJtcVL3jyrY1+4i
	 2Ie5lj/G7T15A==
Date: Wed, 16 Jul 2025 14:53:21 +0200
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>, 
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <20250716-teeservice-nagel-de69388d0df8@brauner>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org>
 <aHZ9H_3FPnPzPZrg@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aHZ9H_3FPnPzPZrg@casper.infradead.org>

On Tue, Jul 15, 2025 at 05:09:03PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 15, 2025 at 04:35:24PM +0200, Christian Brauner wrote:
> > struct inode is bloated as everyone is aware and we should try and
> > shrink it as that's potentially a lot of memory savings. I've already
> > freed up around 8 bytes but we can probably do better.
> 
> OK, but let's make sure we're actually achieving memory savings.
> First, inodes are allocated from slabs.  If we reduce a struct from,
> say, 596 to 592 bytes, we'll still get 27 of them in a 16KiB page
> (although we'd get 110 instead of 109 in a 64KiB page!) so we need
> to be crossing some important boundaries to actually make a difference.
> 
> For block/network filesystems, those slabs are fs-private with
> struct inode embedded into struct fs_inode.  eg:
> 
> xfs_inode         584600 593856   1024   32    8 : tunables    0    0    0 : slabdata  18558  18558      0
> ext4_inode_cache     756    756   1168   28    8 : tunables    0    0    0 : slabdata     27     27      0
> proc_inode_cache   18316  19136    704   46    8 : tunables    0    0    0 : slabdata    416    416      0
> inode_cache         8059   9325    632   25    4 : tunables    0    0    0 : slabdata    373    373      0
> 
> That's on a machine running 6.12 and pahole tells me struct inode is
> currently 624 bytes, so yes, you've saved 8 bytes (Debian config).
> And we've gone from 25 objects per 16KiB to 26, so yay!  Getting to 27
> will be harder, we have to get to 604 bytes.  Although for my system if
> we could get xfs_inode down from 1024 bytes to 992, that'd save me much
> more memory ;-)
> 
> We could get rid of i_io_list by using an allocating xarray to store the
> inodes in each backing_dev.  There's 16 bytes (would probably need to
> retain a 4 byte ID to allow for efficient deletion from the xarray,
> and there are multiple lists it might be on, so perhaps 3 bits to
> determine which list it's on).
> 
> That might work for i_sb_list, i_sb_list and i_lru too.  That could get
> us 48 bytes.
> 
> We can also win in inode by shrinking address_space.  nr_thps is
> one I want to kill.  That'll get us 8 bytes back as soon as btrfs
> lets us drop CONFIG_READ_ONLY_THP_FOR_FS.
> 
> The i_private_* members in i_data can probably also go.  Mostly they're
> used for buffer_heads.  So more conversion to iomap will help with that.
> 
> 
> I wonder if we can shift from having i_data embedded in struct inode
> to embedding it in struct foofs_inode.  Then procfs and other pseudo
> filesystems wouldn't allocate 192 bytes worth of data ...

If you/or someone manages to do that work before LSFMM in May 2026 I'll
bring the author a VFS T-Shirt with "I shrunk struct inode by $n bytes."
LSFMM 2026 edition.

