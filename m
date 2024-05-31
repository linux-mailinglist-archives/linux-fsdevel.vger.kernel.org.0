Return-Path: <linux-fsdevel+bounces-20644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 864718D65B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 17:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7981F254B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 15:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1AE770F3;
	Fri, 31 May 2024 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDsbjgom"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76721C687;
	Fri, 31 May 2024 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717169253; cv=none; b=nNJABPQIy0ozn0mAGsen1tPVTbktFc8uUHHvfMgi5Fd8HeBEQ/fiSwIC/0pTwPRcWE39d2plJOY5JCW8mXOjbA5wt7GEWyHxrgJvlDnyEhixjCfL910BpUkmR1vkhHCrvbLkWoSYZomSQfqsj+0N0dDEJToSoY4TgMTSdEzNayQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717169253; c=relaxed/simple;
	bh=rjij/e0aNKDfKAiiaNEJ7N7+ZrqYaMhO+848HjpvkF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqtYAEmfEz1g5szWXmQYf9Z2evEGbcWa1tuNTKLtRGoP7CfNZ+nHfq6KM4CgZC6NPO/ZaWOUGn85HgWnwwDkTUL7h5Xa8enl9REyt7c3YWEVigmboAKk9LyfnCO0L1v/5H9J2w+ct20DCIQxioU3Mm1gC0jqgaitAaAB8A/dOxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDsbjgom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C21C116B1;
	Fri, 31 May 2024 15:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717169253;
	bh=rjij/e0aNKDfKAiiaNEJ7N7+ZrqYaMhO+848HjpvkF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDsbjgom4IPUjMX7uh8DQOqumPO4dBoDgGxbqi1FsE+c59LokizFlvmnmkEWykPvm
	 9vFEdwI1n0M7xzHISQFTv+p1C4lmtQoLvGe5gAwJLgBlfW3mpMUHxVE941lqPWu/OH
	 PMNBRXcN+aOU/9m6q/id+Ox3YvAuPzS+NdR44L2KoGF+zLi6pKgkLqC5rhLeFTPUm3
	 MlMhWCpm9FVw2X/qanj1024hmrS1DfSXYs5MZG2pYmUKA2iLVXB9EMztBC84ADLH59
	 bsI6+v9MTyCftjTXac9qATSEuQ4UMayjvS96fGgn9P9T/yfUpXfLguhivY7XZebjtw
	 eBvZjjSGq//YA==
Date: Fri, 31 May 2024 08:27:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 5/8] xfs: refactor the truncating order
Message-ID: <20240531152732.GM52987@frogsfrogsfrogs>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-6-yi.zhang@huaweicloud.com>
 <ZlnRODP_b8bhXOEE@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlnRODP_b8bhXOEE@infradead.org>

On Fri, May 31, 2024 at 06:31:36AM -0700, Christoph Hellwig wrote:
> > +	write_back = newsize > ip->i_disk_size && oldsize != ip->i_disk_size;
> 
> Maybe need_writeback would be a better name for the variable?  Also no
> need to initialize it to false at declaration time if it is
> unconditionally set here.

This variable captures whether or not we need to write dirty file tail
data because we're extending the ondisk EOF, right?

I don't really like long names like any good 1980s C programmer, but
maybe we should name this something like "extending_ondisk_eof"?

	if (newsize > ip->i_disk_size && oldsize != ip->i_disk_size)
		extending_ondisk_eof = true;

	...

	if (did_zeroing || extending_ondisk_eof)
		filemap_write_and_wait_range(...);

Hm?

> > +		/*
> > +		 * Updating i_size after writing back to make sure the zeroed
> > +		 * blocks could been written out, and drop all the page cache
> > +		 * range that beyond blocksize aligned new EOF block.
> > +		 *
> > +		 * We've already locked out new page faults, so now we can
> > +		 * safely remove pages from the page cache knowing they won't
> > +		 * get refaulted until we drop the XFS_MMAP_EXCL lock after the

And can we correct the comment here too?

"...until we drop XFS_MMAPLOCK_EXCL after the extent manipulations..."

--D

> > +		 * extent manipulations are complete.
> > +		 */
> > +		i_size_write(inode, newsize);
> > +		truncate_pagecache(inode, roundup_64(newsize, blocksize));
> 
> Any reason this open codes truncate_setsize()?
> 
> 

