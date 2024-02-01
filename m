Return-Path: <linux-fsdevel+bounces-9906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4B3845E1E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 18:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59517B25283
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D8B779FB;
	Thu,  1 Feb 2024 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiPQAlPo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49661608E1;
	Thu,  1 Feb 2024 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807314; cv=none; b=huhPu1xgej7iHxBTYkgyBVwWoxXMSlxqbgiixu8fMwuoiU1I5u/iHf3Ccg5Z3vX1mM09S3oPkhQ6qRmHsjYvW/ftuByk0aA8O+X+zo7euXYD4cWrQxje7cB06GkAGhCu9lVd/HwJoIjU7ALv2XnHe/KuD0VUy7w94segPZWBRzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807314; c=relaxed/simple;
	bh=W+bZPY9kaX5gm8ZK9DWmwVsBxj19zA8nfyKDN8FCYhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1HZNK0/2ahw4n/g/IUq0t0difpWdzE9mPppMcnCQLMEWrih/IZSQNzdfwOrl/JsZ5lKfuuzM/PFVC2phhje/8URrw3u1v086A6kEMg9ETNMizMe5iXMc08L0NH5M1laeOkT35OHNOK/KKXnggYUlFMpGR/ohQu4fGpBFgWY43A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiPQAlPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0AAC433F1;
	Thu,  1 Feb 2024 17:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706807314;
	bh=W+bZPY9kaX5gm8ZK9DWmwVsBxj19zA8nfyKDN8FCYhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AiPQAlPo7JSDOhGAAt8FDSIXniDqo8dQjuom0qvi/H1aZY+oEkeIgEtG9/IQ8OVKW
	 2fT/jJu4h06T+J2OsdIsctPr0wODXti2tH0H3cgI+NZYyEA6XLZrEyw/htX5zoq+El
	 IR/N3NXfkr5zNhUp9b49zi+Ka0id65WgQRbVJooSGK8OWs+6ps2QdBckEkeWPvoiIr
	 lTEsLUsBGzFp3aXkOZ2i2Z7aQNd5j5uAvZesb7ogdpaMTODIM6P0+NQdlhG0KiLDwn
	 IsX71BMTbqehCoWtRNEsLdMhoWHVMJdgOXu8eu+4j0prntFqNrV7ei1+MCGpoCOJh+
	 pqtrHa40WjBog==
Date: Thu, 1 Feb 2024 18:08:29 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 01/34] bdev: open block device as files
Message-ID: <20240201-rational-wurfgeschosse-73ca66259263@brauner>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-1-adbd023e19cc@kernel.org>
 <20240129160241.GA2793@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129160241.GA2793@lst.de>

On Mon, Jan 29, 2024 at 05:02:41PM +0100, Christoph Hellwig wrote:
> > +static unsigned blk_to_file_flags(blk_mode_t mode)
> > +{
> > +	unsigned int flags = 0;
> > +
> 
> ...
> 
> > +	/*
> > +	 * O_EXCL is one of those flags that the VFS clears once it's done with
> > +	 * the operation. So don't raise it here either.
> > +	 */
> > +	if (mode & BLK_OPEN_NDELAY)
> > +		flags |= O_NDELAY;
> 
> O_EXCL isn't dealt with in this helper at all.

Yeah, on purpose was my point bc we can just rely on @holder and passing
_EXCL without holder is invalid. But I could add it.

> 
> > +	/*
> > +	 * If BLK_OPEN_WRITE_IOCTL is set then this is a historical quirk
> > +	 * associated with the floppy driver where it has allowed ioctls if the
> > +	 * file was opened for writing, but does not allow reads or writes.
> > +	 * Make sure that this quirk is reflected in @f_flags.
> > +	 */
> > +	if (mode & BLK_OPEN_WRITE_IOCTL)
> > +		flags |= O_RDWR | O_WRONLY;
> 
> .. and BLK_OPEN_WRITE_IOCTL will never be passed to it.  It only comes
> from open block devices nodes.
> 
> That being said, passing BLK_OPEN_* to bdev_file_open_by_* actually
> feels wrong.  They deal with files and should just take normal
> O_* flags instead of translating from BLK_OPEN_* to O_* back to
> BLK_OPEN_* for the driver (where they make sense as the driver
> flags are pretty different from what is passed to open).
> 
> Now of course changing that would make a mess of the whole series,
> so maybe that can go into a new patch at the end?

Yes, I had considered that and it would work but there's the issue that
we need to figure out how to handle BLK_OPEN_RESTRICT_WRITES. It has no
corresponding O_* flag that would let us indicate this. So I had
considered:

1/ Expose bdev_file_open_excl() so callers don't need to pass any
   specific flags. Nearly all filesystems would effectively use this
   helper as sb_open_mode() adds it implicitly. That would have the
   side-effect of introducing another open helper ofc; possibly two if
   we take _by_dev() and _by_path() into account.

2/ Abuse an O_* flag to mean BLK_OPEN_RESTRICT_WRITES. For example,
   O_TRUNC or O_NOCTTY which is pretty yucky.

3/ Introduce an internal O_* flag which is also ugly. Vomitorious and my
   co-maintainers would likely chop off my hands so I can't go near a
   computer again.

3/ Make O_EXCL when passed together with bdev_file_open_by_*() always
   imply BLK_OPEN_RESTRICT_WRITES.

The 3/ option would probably be the cleanest one and I think that all
filesystems now pass at least a holder and holder ops so this _should_
work.

Thoughts?

> 
> > + * @noaccount: whether this is an internal open that shouldn't be counted
> >   */
> >  static struct file *alloc_file(const struct path *path, int flags,
> > -		const struct file_operations *fop)
> > +		const struct file_operations *fop, bool noaccount)
> 
> Just a suggestion as you are the maintainer here, but I always find
> it hard to follow when infrastructure in subsystem A is changed in
> a patch primarily changing subsystem B.  Can the file_table.c
> changes go into a separate patch or patches with commit logs
> documenting their semantics?
> 
> And while we're at the semantics I find this area already a bit of a
> a mess and this doesn't make it any better..
> 
> How about the following:
> 
>  - alloc_file loses the actual file allocation and gets a new name
>    (unfortunatel init_file is already taken), callers call
>    alloc_empty_file_noaccount or alloc_empty_file plus the
>    new helper.
>  - similarly __alloc_file_pseudo is split into a helper creating
>    a path for mnt and inode, and callers call that plus the
>    file allocation
> 
> ?

Ok, let me see how far I get.

> 
> > +extern struct file *alloc_file_pseudo_noaccount(struct inode *, struct vfsmount *,
> 
> no need for the extern here.
> 
> > +	struct block_device	*s_bdev;	/* can go away once we use an accessor for @s_bdev_file */
> 
> can you put the comment into a separate line to make it readable.
> 
> But I'm not even sure it should go away.  s_bdev is used all over the
> data and metadata I/O path, so caching it and avoiding multiple levels
> of pointer chasing would seem useful.

Fair.

