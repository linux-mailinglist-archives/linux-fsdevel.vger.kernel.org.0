Return-Path: <linux-fsdevel+bounces-46535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773EAA8AF7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 07:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6D43BBA0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 05:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29733229B12;
	Wed, 16 Apr 2025 05:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSy7CHm4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FC9E571;
	Wed, 16 Apr 2025 05:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744779993; cv=none; b=n5Omjt8hB/LO2LgAQZiHX6AFiFpyVuql6dWjNwZ4+2OP9q4z16tG4C3w3PB3F+kU5kQt9ANR9R+o29xSBzrYSq8D9Iz+ANbNE/eADBJUS4lLqM+Jrn4S5TPxJRZXg84QHjIvBZNSOPrARFUxRrsXgzOelpzLHUK+RT9u3Ncgncc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744779993; c=relaxed/simple;
	bh=fHi5XrOL2SB9R1MJowP5hyWGYTkibDImTBkWMHHHXlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swXB/ApqUwoaPDuSP2HGdY3zlkheAsF5YaNqp5FPMUrB5GKclAYFh3IJuMdGyY+k5KKKnpxAaxd6Y804ph1iEz6ex3QtC+Aqs13JlPcoagyWPUQ1ThjisV2uFvcQ0CazK0KLCZH09meBrKYihtPgbSVryJD1EwnGNx5+8WiMWDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSy7CHm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E49C4CEE2;
	Wed, 16 Apr 2025 05:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744779992;
	bh=fHi5XrOL2SB9R1MJowP5hyWGYTkibDImTBkWMHHHXlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qSy7CHm43Ju6n/L7MAQryb3ELRua0gUY8c5IdvlYP5k1ALGtwPl2niKRkOgl976n0
	 cbVi1YDB7ew4lWyGflRcjndqgs5LCMOPvL0LjWonWwYExIfvdTQVXYFdHvcPcfYKVm
	 vZvft7lWxmavE5Yimoda7LfGJ5fZJLDQzzUKHy8Xpsgbt0YL6Yw8slwv4sOPlGcdlS
	 ccRzppm5tq5m6yudCYJIlGZbgtXYvrY+haAHf8tGTKVkV1AqI2GEcAjmGRFgoRUloy
	 LWgl7TJC0KuvMxkPSTfJAJUkjEPeIKB2CTQpR4uOOn2DwvJcqpdYRDIX6wk3TlvGHC
	 eFx8Oa9E2R9eg==
Date: Tue, 15 Apr 2025 22:06:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Carlos Maiolino <cem@kernel.org>, axboe@kernel.dk,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-block <linux-block@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>, Jack Vogel <jack.vogel@oracle.com>
Subject: Re: [RF[CRAP] 2/2] xfs: stop using set_blocksize
Message-ID: <20250416050632.GA25675@frogsfrogsfrogs>
References: <20250415001405.GA25659@frogsfrogsfrogs>
 <20250415003308.GE25675@frogsfrogsfrogs>
 <Z_82ETKMHDxE4N2e@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_82ETKMHDxE4N2e@infradead.org>

On Tue, Apr 15, 2025 at 09:46:09PM -0700, Christoph Hellwig wrote:
> On Mon, Apr 14, 2025 at 05:33:08PM -0700, Darrick J. Wong wrote:
> > +/*
> > + * For bdev filesystems that do not use buffer heads, check that this block
> > + * size is acceptable and flush dirty pagecache to disk.
> > + */
> 
> Can you turn this into a full fledged kerneldoc comment?

Ok.

> > +int bdev_use_blocksize(struct file *file, int size)
> > +{
> > +	struct inode *inode = file->f_mapping->host;
> > +	struct block_device *bdev = I_BDEV(inode);
> > +
> > +	if (blk_validate_block_size(size))
> > +		return -EINVAL;
> > +
> > +	/* Size cannot be smaller than the size supported by the device */
> > +	if (size < bdev_logical_block_size(bdev))
> > +		return -EINVAL;
> > +
> > +	if (!file->private_data)
> > +		return -EINVAL;
> 
> This private_data check looks really confusing.  Looking it up I see
> that it is directly copied from set_blocksize, but it could really
> use a comment.  Or in fact be removed here and kept in set_blocksize
> only as we don't care about an exclusive opener at all.   Even there
> a comment would be rather helpful, though.

When even is it null?  I thought it would either be the holder or
bdev_inode if not.

> > +
> > +	return sync_blockdev(bdev);
> > +}
> 
> I don't think we need sync_blockdev here as we don't touch the
> bdev page cache.  Maybe XFS wants to still call it, but it feels
> wrong in a helper just validating the block size.
> 
> So maybe drop it, rename the helper to bdev_validate_block_size
> and use it in set_blocksize instead of duplicating the logic?

Ok.  bdev_validate_block_size is a much better name for a tighter
function...

> > +	error = bdev_use_blocksize(btp->bt_bdev_file, sectorsize);
> 
> .. and then split using it in XFS into a separate patch from adding
> the block layer helper.

...and xfs can call sync_blockdev directly from xfs_setsize_buftarg.
I imagine we still want any dirty pagecache to get flushed before we
start submitting our own read bios.

--D

