Return-Path: <linux-fsdevel+bounces-46534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 754B1A8AF72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 07:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3683A1901400
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 05:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F802288F7;
	Wed, 16 Apr 2025 05:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyA7CwqG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F25E571;
	Wed, 16 Apr 2025 05:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744779705; cv=none; b=uVFVReeDhtCB5SlEaGjGjF5IQtHNvOdo6Xk39N27oS90QAJtNEqdDtKliexMQ0Kd+YjKCTb0B7OSsPDx2HyNbmOSHeEw9CQIKKikeEP43HbZ66YzrcYUIN2cIG1n8kHl54fBoCMYz64SvgGRMXZfj9ZsILtCf+qhzckMvq3glQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744779705; c=relaxed/simple;
	bh=6LXhHo3n8q1+WdZyASezw7obYvnOQnpMzr32n1KgRQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KC1QJeHcTmLdt0yLmOnykJe+yNznlE+LG/yg8jYadBwl6jftnNROCwHliSG7EkKy3Pohalxt1gfzramgbVGsYqtRpM/ZraFUzTrX1XLLT6hgNLkq+04bnRi5+RK4DomT5LYD+QsJ8TCN1oF7cfjL8nj/Wubq8JHw1fCm6BEH5BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyA7CwqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E50C4CEE2;
	Wed, 16 Apr 2025 05:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744779704;
	bh=6LXhHo3n8q1+WdZyASezw7obYvnOQnpMzr32n1KgRQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GyA7CwqGy5THlV0x1q2ZGF3w2paiqBoZ2rsJg1VxNy1HGcUwbIPgdJK7uI5yepNUA
	 mDAfDJOH5olmz/bpTy/bb0ohAO1s17PqbXiZPeDZJCBya0ZSnP6iCGdoJcW8OquoBa
	 MoYXbe3hFLVq5S9AXu4TS8Vz4ayosTMSAgKhIc4bOdq03J7kM00iv+OnyQvCOGwyzS
	 pNbYeBeTt6eH0F2JvIGmH39QEXaBTdQ7yQvbIc+D8Edhugx1tVnBS9HCKZWePaztAb
	 DI7hshNqN0TOr/1c+S+T10wPpg/+8sRJyAv/NdM+D3ypla3DLIHMHQ1Gwja10/3iDF
	 ex4OjO+xZKvPQ==
Date: Tue, 15 Apr 2025 22:01:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-block <linux-block@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>, Jack Vogel <jack.vogel@oracle.com>
Subject: Re: [RFC[RAP] 1/2] block: fix race between set_blocksize and read
 paths
Message-ID: <20250416050144.GZ25675@frogsfrogsfrogs>
References: <20250415001405.GA25659@frogsfrogsfrogs>
 <Z_80_EXzPUiAow2I@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_80_EXzPUiAow2I@infradead.org>

On Tue, Apr 15, 2025 at 09:41:32PM -0700, Christoph Hellwig wrote:
> On Mon, Apr 14, 2025 at 05:14:05PM -0700, Darrick J. Wong wrote:
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
> 
> Do we have a testcase for blktests or xfstests for this?  The issue is
> subtle and some of the code in the patch looks easy to accidentally
> break again (not the fault of this patch primarily).

It's the same patch as:
https://lore.kernel.org/linux-fsdevel/20250408175125.GL6266@frogsfrogsfrogs/

which is to say, xfs/032 with while true; do blkid; done running in the
background to increase the chances of a collision.

> >  	} else {
> > +		inode_lock_shared(bd_inode);
> >  		ret = blkdev_buffered_write(iocb, from);
> > +		inode_unlock_shared(bd_inode);
> 
> Does this need a comment why we take i_rwsem?
> 
> > +	inode_lock_shared(bd_inode);
> >  	ret = filemap_read(iocb, to, ret);
> > +	inode_unlock_shared(bd_inode);
> 
> Same here.  Especially as the protection is now heavier than for most
> file systems.

Yeah, somewhere we need a better comment.  How about this for
set_blocksize:

	/*
	 * Flush and truncate the pagecache before we reconfigure the
	 * mapping geometry because folio sizes are variable now.  If
	 * a reader has already allocated a folio whose size is smaller
	 * than the new min_order but invokes readahead after the new
	 * min_order becomes visible, readahead will think there are
	 * "zero" blocks per folio and crash.
	 */

And then the read/write paths can say something simpler:

	/*
	 * Take i_rwsem and invalidate_lock to avoid racing with a
	 * blocksize change punching out the pagecache.
	 */

> I also wonder if we need locking asserts in some of the write side
> functions that expect the shared inode lock and invalidate lock now?

Probably.  Do you have specific places in mind?

--D

