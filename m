Return-Path: <linux-fsdevel+bounces-21570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 958A8905DBB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 23:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F161F225FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 21:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBF412B169;
	Wed, 12 Jun 2024 21:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thcveAPa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCA185C7D;
	Wed, 12 Jun 2024 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718227957; cv=none; b=He72hx2g0icsS02v1IQRKS+zvUc0/DYDlDzWz7qvfR5NmPzrsjjIRn/b9QRO6Zjr9YI19PGsAQldwLaFGl52h2KvapmcOhRzScVQ9h3uCX8qqxfXn4BV10ezntEfKLKM6nB5JmfUtjS4YU6KsCvhseItbSdYFFLlc4OxSpMT9II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718227957; c=relaxed/simple;
	bh=+6K2GBiD0D6rO2F8XEEpwjw7JrvPdC0cF53qMdYVYKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qY9wY3x4k0KKU9xZGTAQyHbrLtc5GWuwn1DvtY391nG5V4If10QmY4UVGKQ7H6WhvL6T+wf/PFBVoJrCB4QuvqECfRk/bGmiELcAoX356Zf0Wry9xJDpUwbW1TK85gEfxOj+sNQ7N7A4HEJnY26ciaS3XAO8NmqrNpEWEtXxr/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thcveAPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B43AC116B1;
	Wed, 12 Jun 2024 21:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718227956;
	bh=+6K2GBiD0D6rO2F8XEEpwjw7JrvPdC0cF53qMdYVYKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=thcveAPaEwsbXqDPJp4ortTgIEthCL/Ns9UeHO/MNyNH/Pp1rVKddUHOiSTxXE7Kk
	 R6OpcqTcK9qyO67XMIFXeHEGwCCHivTeVPDeB70u2wq/1WlzXbQCxZtALLdF0VD7gF
	 t6GDLv3Cfk3BxvJ9r+zZ+MLazjF85+dRaN3yYlaEFel4eSF0LsgW+2va3PK01MckVJ
	 FQzj+cg7BUkaP8VQ2WtJVwXc7SFyezEx6rCEN6C6bVCsZqvj+dKdS5pXWqdR8nVltq
	 tRo2khVZW05PrkS/X8HzP1aYmKj7+ylCkzO8TEIW3PQUQDRla9cozLSiI23pKkE3cI
	 /6Qt5EU0PtLjw==
Date: Wed, 12 Jun 2024 14:32:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, tytso@mit.edu, dchinner@redhat.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.com,
	chandan.babu@oracle.com, hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-xfs@vger.kernel.org, catherine.hoang@oracle.com,
	ritesh.list@gmail.com, mcgrof@kernel.org,
	mikulas@artax.karlin.mff.cuni.cz, agruenba@redhat.com,
	miklos@szeredi.hu, martin.petersen@oracle.com
Subject: Re: [PATCH v4 02/22] iomap: Allow filesystems set IO block zeroing
 size
Message-ID: <20240612213235.GK2764752@frogsfrogsfrogs>
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
 <20240607143919.2622319-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607143919.2622319-3-john.g.garry@oracle.com>

On Fri, Jun 07, 2024 at 02:38:59PM +0000, John Garry wrote:
> Allow filesystems to set the io_block_size for sub-fs block size zeroing,
> as in future we will want to extend this feature to support zeroing of
> block sizes of larger than the inode block size.
> 
> The value in io_block_size does not have to be a power-of-2, so fix up
> zeroing code to handle that.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  block/fops.c          |  1 +
>  fs/btrfs/inode.c      |  1 +
>  fs/erofs/data.c       |  1 +
>  fs/erofs/zmap.c       |  1 +
>  fs/ext2/inode.c       |  1 +
>  fs/ext4/extents.c     |  1 +
>  fs/ext4/inode.c       |  1 +
>  fs/f2fs/data.c        |  1 +
>  fs/fuse/dax.c         |  1 +
>  fs/gfs2/bmap.c        |  1 +
>  fs/hpfs/file.c        |  1 +
>  fs/iomap/direct-io.c  | 23 +++++++++++++++++++----
>  fs/xfs/xfs_iomap.c    |  1 +
>  fs/zonefs/file.c      |  2 ++
>  include/linux/iomap.h |  2 ++
>  15 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 9d6d86ebefb9..020443078630 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -402,6 +402,7 @@ static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  	iomap->addr = iomap->offset;
>  	iomap->length = isize - iomap->offset;
>  	iomap->flags |= IOMAP_F_BUFFER_HEAD; /* noop for !CONFIG_BUFFER_HEAD */
> +	iomap->io_block_size = i_blocksize(inode);
>  	return 0;
>  }
>  

<snip a bunch of filesystems setting io_block_size to i_blocksize>

> diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
> index 1bb8d97cd9ae..5d2718faf520 100644
> --- a/fs/hpfs/file.c
> +++ b/fs/hpfs/file.c
> @@ -149,6 +149,7 @@ static int hpfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  		iomap->addr = IOMAP_NULL_ADDR;
>  		iomap->length = 1 << blkbits;
>  	}
> +	iomap->io_block_size = i_blocksize(inode);

HPFS does iomap now?  Yikes.

>  
>  	hpfs_unlock(sb);
>  	return 0;
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index f3b43d223a46..5be8d886ab4a 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -277,7 +277,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  {
>  	const struct iomap *iomap = &iter->iomap;
>  	struct inode *inode = iter->inode;
> -	unsigned int fs_block_size = i_blocksize(inode), pad;
> +	u64 io_block_size = iomap->io_block_size;

I wonder, should iomap be nice and not require filesystems to set
io_block_size themselves unless they really need it?  Anyone working on
an iomap port while this patchset is in progress may or may not remember
to add this bit if they get their port merged after atomicwrites is
merged; and you might not remember to prevent the bitrot if the reverse
order happens.

	u64 io_block_size = iomap->io_block_size ?: i_blocksize(inode);

>  	loff_t length = iomap_length(iter);
>  	loff_t pos = iter->pos;
>  	blk_opf_t bio_opf;
> @@ -287,6 +287,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	int nr_pages, ret = 0;
>  	size_t copied = 0;
>  	size_t orig_count;
> +	unsigned int pad;
>  
>  	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
>  	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
> @@ -355,7 +356,14 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  
>  	if (need_zeroout) {
>  		/* zero out from the start of the block to the write offset */
> -		pad = pos & (fs_block_size - 1);
> +		if (is_power_of_2(io_block_size)) {
> +			pad = pos & (io_block_size - 1);
> +		} else {
> +			loff_t _pos = pos;
> +
> +			pad = do_div(_pos, io_block_size);
> +		}

Please don't opencode this twice.

static unsigned int offset_in_block(loff_t pos, u64 blocksize)
{
	if (likely(is_power_of_2(blocksize)))
		return pos & (blocksize - 1);
	return do_div(pos, blocksize);
}

		pad = offset_in_block(pos, io_block_size);
		if (pad)
			...

Also, what happens if pos-pad points to a byte before the mapping?

> +
>  		if (pad)
>  			iomap_dio_zero(iter, dio, pos - pad, pad);
>  	}
> @@ -429,9 +437,16 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	if (need_zeroout ||
>  	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode))) {
>  		/* zero out from the end of the write to the end of the block */
> -		pad = pos & (fs_block_size - 1);
> +		if (is_power_of_2(io_block_size)) {
> +			pad = pos & (io_block_size - 1);
> +		} else {
> +			loff_t _pos = pos;
> +
> +			pad = do_div(_pos, io_block_size);
> +		}
> +
>  		if (pad)
> -			iomap_dio_zero(iter, dio, pos, fs_block_size - pad);
> +			iomap_dio_zero(iter, dio, pos, io_block_size - pad);

What if pos + io_block_size - pad points to a byte after the end of the
mapping?

>  	}
>  out:
>  	/* Undo iter limitation to current extent */
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 378342673925..ecb4cae88248 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -127,6 +127,7 @@ xfs_bmbt_to_iomap(
>  	}
>  	iomap->offset = XFS_FSB_TO_B(mp, imap->br_startoff);
>  	iomap->length = XFS_FSB_TO_B(mp, imap->br_blockcount);
> +	iomap->io_block_size = i_blocksize(VFS_I(ip));
>  	if (mapping_flags & IOMAP_DAX)
>  		iomap->dax_dev = target->bt_daxdev;
>  	else
> diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
> index 3b103715acc9..bf2cc4bee309 100644
> --- a/fs/zonefs/file.c
> +++ b/fs/zonefs/file.c
> @@ -50,6 +50,7 @@ static int zonefs_read_iomap_begin(struct inode *inode, loff_t offset,
>  		iomap->addr = (z->z_sector << SECTOR_SHIFT) + iomap->offset;
>  		iomap->length = isize - iomap->offset;
>  	}
> +	iomap->io_block_size = i_blocksize(inode);
>  	mutex_unlock(&zi->i_truncate_mutex);
>  
>  	trace_zonefs_iomap_begin(inode, iomap);
> @@ -99,6 +100,7 @@ static int zonefs_write_iomap_begin(struct inode *inode, loff_t offset,
>  		iomap->type = IOMAP_MAPPED;
>  		iomap->length = isize - iomap->offset;
>  	}
> +	iomap->io_block_size = i_blocksize(inode);
>  	mutex_unlock(&zi->i_truncate_mutex);
>  
>  	trace_zonefs_iomap_begin(inode, iomap);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 6fc1c858013d..d63a35b77907 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -103,6 +103,8 @@ struct iomap {
>  	void			*private; /* filesystem private */
>  	const struct iomap_folio_ops *folio_ops;
>  	u64			validity_cookie; /* used with .iomap_valid() */
> +	/* io block zeroing size, not necessarily a power-of-2  */

size in bytes?

I'm not sure what "io block zeroing" means.  What are you trying to
accomplish here?  Let's say the fsblock size is 4k and the allocation
unit (aka the atomic write size) is 16k.  Userspace wants a direct write
to file offset 8192-12287, and that space is unwritten:

uuuu
  ^

Currently we'd just write the 4k and run the io completion handler, so
the final state is:

uuWu

Instead, if the fs sets io_block_size to 16384, does this direct write
now amplify into a full 16k write?  With the end result being:

ZZWZ

only.... I don't see the unwritten areas being converted to written?
I guess for an atomic write you'd require the user to write 0-16383?

<still confused about why we need to do this, maybe i'll figure it out
as I go along>

--D

> +	u64			io_block_size;
>  };
>  
>  static inline sector_t iomap_sector(const struct iomap *iomap, loff_t pos)
> -- 
> 2.31.1
> 
> 

