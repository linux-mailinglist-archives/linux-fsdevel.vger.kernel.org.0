Return-Path: <linux-fsdevel+bounces-27758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B4D963920
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 05:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2631F2634E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AA712D766;
	Thu, 29 Aug 2024 03:56:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F8D8BE0;
	Thu, 29 Aug 2024 03:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724903793; cv=none; b=DZMQ/mVs0UX+iUTSfu7PpzYAh0UCeINwZqW1ZhfxeBJ6vNj6sPgWXLvG/XB2jkEvrMmgcq7TI0C1WkA6xQOToH1TQVCYKpS135p7/sn9DhNGXeLOkP46cFJqp0rEvaxNkkZ3s5nq/Prf/r9yN0HyyTPM4Jub7+HbocTIS8Z4TT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724903793; c=relaxed/simple;
	bh=dZ25Vu5Hqd04Jii1Sws+QHe2wmoP+MbYjGN7CrTqR5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4ClHuTnLCRlz2YjFDTxIICKJxeqlCQ7ODAwhe3sVQe4K3z8cmIXU8bjc9bMRGMoNR4yFtBedbYWM8qhpKOCWeE2bRjKYx3zJ7mzhayd0vUlRGtR4VxlONRnrdyvBbD/L5n2rgvCWghYVpFVYKs8TCZuZSx5UQ8sx6SXteURqTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 97EBA68AA6; Thu, 29 Aug 2024 05:56:27 +0200 (CEST)
Date: Thu, 29 Aug 2024 05:56:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Brian Foster <bfoster@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 6/6] xfs: refactor xfs_file_fallocate
Message-ID: <20240829035627.GC4023@lst.de>
References: <20240827065123.1762168-1-hch@lst.de> <20240827065123.1762168-7-hch@lst.de> <Zs/mz4Gve+znep2M@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs/mz4Gve+znep2M@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Aug 29, 2024 at 01:11:11PM +1000, Dave Chinner wrote:
> > +xfs_falloc_allocate_range(
> > +	struct file		*file,
> > +	int			mode,
> > +	loff_t			offset,
> > +	loff_t			len)
> > +{
> > +	struct inode		*inode = file_inode(file);
> > +	loff_t			new_size = 0;
> > +	int			error;
> > +
> > +	/*
> > +	 * If always_cow mode we can't use preallocations and thus should not
> > +	 * create them.
> > +	 */
> > +	if (xfs_is_always_cow_inode(XFS_I(inode)))
> > +		return -EOPNOTSUPP;
> 
> ... our preallocation operation always returns -EOPNOTSUPP for
> COW mode.
> 
> Should the zeroing code also have this COW mode check in it after
> the hole punch has run so we don't do unnecessary prealloc there?

The low-level block allocation helper just returns early without
doing work (move a bit, but not changed in behavior earlier in the
series).  So it won't actually do the prealloc.

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
---end quoted text---

