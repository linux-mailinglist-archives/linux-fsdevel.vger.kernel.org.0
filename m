Return-Path: <linux-fsdevel+bounces-46691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 022FFA93C73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 19:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2AB8E4897
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 17:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509A121CC62;
	Fri, 18 Apr 2025 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nb5NgH01"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61D021C18A;
	Fri, 18 Apr 2025 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744999017; cv=none; b=GDdiWoMlO/Gk4enBIrkQoC9dLXHdBJRkiUE3GrB5GYzTC+pk7zObQ3cAG8LdjA8NaeLciy7hxiK+32mKI/Rrk973C+1Rq6iC1Kh+Zn8o0i/o4Fn/Fh5yBmH25Yv98Nn7wPUDdy9XAFPu78Tw7ZyGQrbXMRHwMmFARQlSCmPRuWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744999017; c=relaxed/simple;
	bh=lCN31lv0JMkBqjNi2Z/Mgc0Brryp+Ge+V2eAquzK5DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMe2wbtGDcgIfl9Rq6HrdPHHk1VRjhmbkcyHPXR8PokXGr+GFEf2Ug9/q0zB6Mu+GJ3NdmqU3j4WSnbPUAPlxms0o7kPXgMZ9AwYvvz4XD+3gkQCitBikyEkWeB2jdrnFnWeLHqycZdfJ08+joXKHF77cyYwPlvRTL7h+s43Ip8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nb5NgH01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A25C4CEE2;
	Fri, 18 Apr 2025 17:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744999017;
	bh=lCN31lv0JMkBqjNi2Z/Mgc0Brryp+Ge+V2eAquzK5DY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nb5NgH01SNXj02TBz+SEKdFIToWV02ukH2FNKcF/O81r9wAt7vKd0yf9GKbt+mult
	 FArDo3QJ8erxrR4XWBpaoJo8le5jWPsKNbh2Cf/vMIn5p7jt2+H0Jwpt5OrLZ98Nkw
	 3E86mIoj+v4ILBQw7q1zi0MCs0XGyIX7mp3ZVjzb0ekIoK56igL+z0ivkEBafRfTse
	 e3e1taAbE+Thfw+ROdRIYE2WX7wZy0VGHUQWqybsED2SLzEjLFUCoNHgiSpknBEy57
	 /a3fE0lvrP48fQ81/Fxczc+98FHd/D1u1eskVQJU5G9nCAOUU58safz6EaB+etOLNF
	 jajaF2rjwSb2Q==
Date: Fri, 18 Apr 2025 10:56:55 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-block <linux-block@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] block: fix race between set_blocksize and read paths
Message-ID: <aAKSZwZHbVykMIMk@bombadil.infradead.org>
References: <20250418155458.GR25675@frogsfrogsfrogs>
 <20250418160234.GT25675@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418160234.GT25675@frogsfrogsfrogs>

On Fri, Apr 18, 2025 at 09:02:34AM -0700, Darrick J. Wong wrote:
> On Fri, Apr 18, 2025 at 08:54:58AM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > With the new large sector size support, it's now the case that
> > set_blocksize can change i_blksize and the folio order in a manner that
> > conflicts with a concurrent reader and causes a kernel crash.
> > 
> > Specifically, let's say that udev-worker calls libblkid to detect the
> > labels on a block device.  The read call can create an order-0 folio to
> > read the first 4096 bytes from the disk.  But then udev is preempted.
> > 
> > Next, someone tries to mount an 8k-sectorsize filesystem from the same
> > block device.  The filesystem calls set_blksize, which sets i_blksize to
> > 8192 and the minimum folio order to 1.
> > 
> > Now udev resumes, still holding the order-0 folio it allocated.  It then
> > tries to schedule a read bio and do_mpage_readahead tries to create
> > bufferheads for the folio.  Unfortunately, blocks_per_folio == 0 because
> > the page size is 4096 but the blocksize is 8192 so no bufferheads are
> > attached and the bh walk never sets bdev.  We then submit the bio with a
> > NULL block device and crash.
> > 
> > Therefore, truncate the page cache after flushing but before updating
> > i_blksize.  However, that's not enough -- we also need to lock out file
> > IO and page faults during the update.  Take both the i_rwsem and the
> > invalidate_lock in exclusive mode for invalidations, and in shared mode
> > for read/write operations.
> > 
> > I don't know if this is the correct fix, but xfs/259 found it.
> > 
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> I think this could also have the tag:
> Fixes: 3c20917120ce61 ("block/bdev: enable large folio support for large logical block sizes")
> 
> Not sure anyone cares about that for a fix for 6.15-rc1 though.

Its a fix, so I'd prefer this goes to v6.15-rcx for sure.

  Luis

