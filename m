Return-Path: <linux-fsdevel+bounces-9403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECD3840AC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 17:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B811F27E5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 16:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03018155313;
	Mon, 29 Jan 2024 16:02:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAF11552E9;
	Mon, 29 Jan 2024 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544168; cv=none; b=rfWlzp9VXnLmDB7MdFM1fUS33s3m5Ck11KX/3DjFFveRKxaC3wVAqr+zdUftdjJr3f06DU6zqFmqIXelj5zvxL5b3s06UTCRvMVtNi4kezPkBqw1iP4CcOGKs0i6D4xah5lzaGfFjk+BjbIQRP12NkRGepfd9zsRBPx2FWlNnA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544168; c=relaxed/simple;
	bh=6nhfjAXRv/orkUJeUAI8CFuV2V6j3S3Gs9J/Di1IAI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIGC2CqijetCOdp75cQV43WweowCuhi0d5tl93ZjarHkycAGE8ZFPtHLaCVcGxh0iYzD/lHiDyN63bLLTX9hKPyIr5f8tUJDZSaM4zR1AxQCki4fn7oB8Fa1i8CGLGD/jUwwvbrxnJp8UiV4Ebih4sC/VasnSC5FFHMO/F96JRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D217068C4E; Mon, 29 Jan 2024 17:02:41 +0100 (CET)
Date: Mon, 29 Jan 2024 17:02:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 01/34] bdev: open block device as files
Message-ID: <20240129160241.GA2793@lst.de>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org> <20240123-vfs-bdev-file-v2-1-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-1-adbd023e19cc@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +static unsigned blk_to_file_flags(blk_mode_t mode)
> +{
> +	unsigned int flags = 0;
> +

...

> +	/*
> +	 * O_EXCL is one of those flags that the VFS clears once it's done with
> +	 * the operation. So don't raise it here either.
> +	 */
> +	if (mode & BLK_OPEN_NDELAY)
> +		flags |= O_NDELAY;

O_EXCL isn't dealt with in this helper at all.

> +	/*
> +	 * If BLK_OPEN_WRITE_IOCTL is set then this is a historical quirk
> +	 * associated with the floppy driver where it has allowed ioctls if the
> +	 * file was opened for writing, but does not allow reads or writes.
> +	 * Make sure that this quirk is reflected in @f_flags.
> +	 */
> +	if (mode & BLK_OPEN_WRITE_IOCTL)
> +		flags |= O_RDWR | O_WRONLY;

.. and BLK_OPEN_WRITE_IOCTL will never be passed to it.  It only comes
from open block devices nodes.

That being said, passing BLK_OPEN_* to bdev_file_open_by_* actually
feels wrong.  They deal with files and should just take normal
O_* flags instead of translating from BLK_OPEN_* to O_* back to
BLK_OPEN_* for the driver (where they make sense as the driver
flags are pretty different from what is passed to open).

Now of course changing that would make a mess of the whole series,
so maybe that can go into a new patch at the end?

> + * @noaccount: whether this is an internal open that shouldn't be counted
>   */
>  static struct file *alloc_file(const struct path *path, int flags,
> -		const struct file_operations *fop)
> +		const struct file_operations *fop, bool noaccount)

Just a suggestion as you are the maintainer here, but I always find
it hard to follow when infrastructure in subsystem A is changed in
a patch primarily changing subsystem B.  Can the file_table.c
changes go into a separate patch or patches with commit logs
documenting their semantics?

And while we're at the semantics I find this area already a bit of a
a mess and this doesn't make it any better..

How about the following:

 - alloc_file loses the actual file allocation and gets a new name
   (unfortunatel init_file is already taken), callers call
   alloc_empty_file_noaccount or alloc_empty_file plus the
   new helper.
 - similarly __alloc_file_pseudo is split into a helper creating
   a path for mnt and inode, and callers call that plus the
   file allocation

?

> +extern struct file *alloc_file_pseudo_noaccount(struct inode *, struct vfsmount *,

no need for the extern here.

> +	struct block_device	*s_bdev;	/* can go away once we use an accessor for @s_bdev_file */

can you put the comment into a separate line to make it readable.

But I'm not even sure it should go away.  s_bdev is used all over the
data and metadata I/O path, so caching it and avoiding multiple levels
of pointer chasing would seem useful.


