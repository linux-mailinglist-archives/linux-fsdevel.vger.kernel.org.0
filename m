Return-Path: <linux-fsdevel+bounces-4668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2DE8018FF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 01:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564F01F210E3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 00:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18AB4407
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 00:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2Lh0KOXv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3315103
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 15:09:45 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7b3905b1b86so90996839f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 15:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701472185; x=1702076985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tK91MdqS5fm0oRnvLgKQFRYdiRGZaWme5xVW3QL3A7Y=;
        b=2Lh0KOXvzfQH4SsaUnDDx1rfLTu8ygarPH9Ou1H2fqVWlBv0oh6SIjEJRyXWWiioz7
         ltgdwDI5VTMPtzly1oJ7fZ0lCoWTYDeShnSvrnKSqc+zxv8RHaYek0XQfrDnWHEmM9gk
         om4S7RCJrCqi1kT+jyDAXchcL6R1meLIMiraC9AdO76DUfg43WXUj3Ru9vPt2ZU+tiTT
         bIFewBPCny+qlgc0XIP2nXccFZ1nvjWm8zTUQBV30vlk79GrBWPXzzw1C4Ubah61uuyN
         OcDI0uIK1Ll7Htvby5CNtvQIa5RmaqXhRhBqt7P6WyVGET6M0ob+ukv6SHz994NGZXG6
         rmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701472185; x=1702076985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tK91MdqS5fm0oRnvLgKQFRYdiRGZaWme5xVW3QL3A7Y=;
        b=GhnHUiZAqIbCuorqJyAuVoIApf7vSAmk+4iIQ2arB0MCTME5qGvRPoi/1DS5gwaqIa
         geBiVmeFoZn2AviYtLVWMlxNExaXf/6CkyFgLPg9xVgkudwpjsC9j/IC/RvGuoSckA6/
         NSULUpP8KmVXicyYcNgOeyynNdABjp6+Rheyxo21DIbkCzrzNYGeakalbQ+MH1cg80Ko
         Olx1ZmkgHyf/GSffWsvKN2mzJXkmgkgcYEBacIDa0a+Gh7gLASi/xAw1ozsDHXlQBjCM
         hhv5WXmWijCfQWaFIyT54GPLttBPE4bT97Ru9STVUMElQmi8Ioc5iv5S/41XS/7f36H7
         SqrQ==
X-Gm-Message-State: AOJu0YyKoI7vW0lrSHadA9vUEz0ZBKotoVGYeLySO/xr4n0gf9mA1uBB
	i1KrN3dDep0EkOpa7rlnlLYukg==
X-Google-Smtp-Source: AGHT+IF5Fv/qHWzsN5yAM8N0cpxjtNfHr+HOBO4abjlkiaoJwZN+mM+A+lRjplW6QiKos9AZJq2lKw==
X-Received: by 2002:a6b:7515:0:b0:7b4:28f8:51e with SMTP id l21-20020a6b7515000000b007b428f8051emr335842ioh.30.1701472185200;
        Fri, 01 Dec 2023 15:09:45 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id e4-20020aa78c44000000b006c4d2479bf8sm3492863pfd.51.2023.12.01.15.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 15:09:44 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1r9Cdh-002bBC-2p;
	Sat, 02 Dec 2023 10:09:41 +1100
Date: Sat, 2 Dec 2023 10:09:41 +1100
From: Dave Chinner <david@fromorbit.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use
 iomap
Message-ID: <ZWpntZXm32kyfX7M@dread.disaster.area>
References: <87msv5r0uq.fsf@doe.com>
 <8734wnj53k.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734wnj53k.fsf@doe.com>

On Thu, Nov 30, 2023 at 08:54:31AM +0530, Ritesh Harjani wrote:
> Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
> 
> > Christoph Hellwig <hch@infradead.org> writes:
> >
> >> On Wed, Nov 22, 2023 at 01:29:46PM +0100, Jan Kara wrote:
> >>> writeback bit set. XFS plays the revalidation sequence counter games
> >>> because of this so we'd have to do something similar for ext2. Not that I'd
> >>> care as much about ext2 writeback performance but it should not be that
> >>> hard and we'll definitely need some similar solution for ext4 anyway. Can
> >>> you give that a try (as a followup "performance improvement" patch).
> >>
> >> Darrick has mentioned that he is looking into lifting more of the
> >> validation sequence counter validation into iomap.
> >>
> >> In the meantime I have a series here that at least maps multiple blocks
> >> inside a folio in a single go, which might be worth trying with ext2 as
> >> well:
> >>
> >> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/iomap-map-multiple-blocks
> >
> > Sure, thanks for providing details. I will check this.
> >
> 
> So I took a look at this. Here is what I think -
> So this is useful of-course when we have a large folio. Because
> otherwise it's just one block at a time for each folio. This is not a
> problem once FS buffered-io handling code moves to iomap (because we
> can then enable large folio support to it).
> 
> However, this would still require us to pass a folio to ->map_blocks
> call to determine the size of the folio (which I am not saying can't be
> done but just stating my observations here).
> 
> Now coming to implementing validation seq check. I am hoping, it should
> be straight forward at least for ext2, because it mostly just have to
> protect against truncate operation (which can change the block mapping)...
> 
> ...ok so here is the PoC for seq counter check for ext2. Next let me
> try to see if we can lift this up from the FS side to iomap - 
> 
> 
> From 86b7bdf79107c3d0a4f37583121d7c136db1bc5c Mon Sep 17 00:00:00 2001
> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> Subject: [PATCH] ext2: Implement seq check for mapping multiblocks in ->map_blocks
> 
> This implements inode block seq counter (ib_seq) which helps in validating 
> whether the cached wpc (struct iomap_writepage_ctx) still has the valid 
> entries or not. Block mapping can get changed say due to a racing truncate. 
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/ext2/balloc.c |  1 +
>  fs/ext2/ext2.h   |  6 ++++++
>  fs/ext2/inode.c  | 51 +++++++++++++++++++++++++++++++++++++++++++-----
>  fs/ext2/super.c  |  2 +-
>  4 files changed, 54 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
> index e124f3d709b2..e97040194da4 100644
> --- a/fs/ext2/balloc.c
> +++ b/fs/ext2/balloc.c
> @@ -495,6 +495,7 @@ void ext2_free_blocks(struct inode * inode, ext2_fsblk_t block,
>  	}
>  
>  	ext2_debug ("freeing block(s) %lu-%lu\n", block, block + count - 1);
> +	ext2_inc_ib_seq(EXT2_I(inode));
>  
>  do_more:
>  	overflow = 0;
> diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
> index 677a9ad45dcb..882c14d20183 100644
> --- a/fs/ext2/ext2.h
> +++ b/fs/ext2/ext2.h
> @@ -663,6 +663,7 @@ struct ext2_inode_info {
>  	struct rw_semaphore xattr_sem;
>  #endif
>  	rwlock_t i_meta_lock;
> +	unsigned int ib_seq;
>  
>  	/*
>  	 * truncate_mutex is for serialising ext2_truncate() against
> @@ -698,6 +699,11 @@ static inline struct ext2_inode_info *EXT2_I(struct inode *inode)
>  	return container_of(inode, struct ext2_inode_info, vfs_inode);
>  }
>  
> +static inline void ext2_inc_ib_seq(struct ext2_inode_info *ei)
> +{
> +	WRITE_ONCE(ei->ib_seq, READ_ONCE(ei->ib_seq) + 1);
> +}
> +
>  /* balloc.c */
>  extern int ext2_bg_has_super(struct super_block *sb, int group);
>  extern unsigned long ext2_bg_num_gdb(struct super_block *sb, int group);
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index f4e0b9a93095..a5490d641c26 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -406,6 +406,8 @@ static int ext2_alloc_blocks(struct inode *inode,
>  	ext2_fsblk_t current_block = 0;
>  	int ret = 0;
>  
> +	ext2_inc_ib_seq(EXT2_I(inode));
> +
>  	/*
>  	 * Here we try to allocate the requested multiple blocks at once,
>  	 * on a best-effort basis.
> @@ -966,14 +968,53 @@ ext2_writepages(struct address_space *mapping, struct writeback_control *wbc)
>  	return mpage_writepages(mapping, wbc, ext2_get_block);
>  }
>  
> +struct ext2_writepage_ctx {
> +	struct iomap_writepage_ctx ctx;
> +	unsigned int		ib_seq;
> +};

Why copy this structure from XFS? The iomap held in ctx->iomap now
has a 'u64 validity_cookie;' which is expressly intended to be used
for holding this information.

And then this becomes:

> +static inline
> +struct ext2_writepage_ctx *EXT2_WPC(struct iomap_writepage_ctx *ctx)
> +{
> +	return container_of(ctx, struct ext2_writepage_ctx, ctx);
> +}
> +
> +static bool ext2_imap_valid(struct iomap_writepage_ctx *wpc, struct inode *inode,
> +			    loff_t offset)
> +{
> +	if (offset < wpc->iomap.offset ||
> +	    offset >= wpc->iomap.offset + wpc->iomap.length)
> +		return false;
> +
> +	if (EXT2_WPC(wpc)->ib_seq != READ_ONCE(EXT2_I(inode)->ib_seq))
> +		return false;

	if (wpc->iomap->validity_cookie != EXT2_I(inode)->ib_seq)
		return false;

> +
> +	return true;
> +}
> +
>  static int ext2_write_map_blocks(struct iomap_writepage_ctx *wpc,
>  				 struct inode *inode, loff_t offset)
>  {
> -	if (offset >= wpc->iomap.offset &&
> -	    offset < wpc->iomap.offset + wpc->iomap.length)
> +	loff_t maxblocks = (loff_t)INT_MAX;
> +	u8 blkbits = inode->i_blkbits;
> +	u32 bno;
> +	bool new, boundary;
> +	int ret;
> +
> +	if (ext2_imap_valid(wpc, inode, offset))
>  		return 0;
>  
> -	return ext2_iomap_begin(inode, offset, inode->i_sb->s_blocksize,
> +	EXT2_WPC(wpc)->ib_seq = READ_ONCE(EXT2_I(inode)->ib_seq);
> +
> +	ret = ext2_get_blocks(inode, offset >> blkbits, maxblocks << blkbits,
> +			      &bno, &new, &boundary, 0);

This is incorrectly ordered. ext2_get_blocks() bumps ib_seq when it
does allocation, so the newly stored EXT2_WPC(wpc)->ib_seq is
immediately staled and the very next call to ext2_imap_valid() will
fail, causing a new iomap to be mapped even when not necessary.

Indeed, we also don't hold the ei->truncate_mutex here, so the
sampling of ib_seq could race with other allocation or truncation
calls on this inode. That's a landmine that will eventually bite
hard, because the sequence number returned with the iomap does not
reflect the state of the extent tree when the iomap is created.

If you look at the XFS code, we set iomap->validity_cookie whenever
we call xfs_bmbt_to_iomap() to format the found/allocated extent
into an iomap to return to the caller. The sequence number is passed
into that function alongside the extent map by the caller, because
when we format the extent into an iomap the caller has already dropped the
allocation lock. We must sample the sequence number after the allocation
but before we drop the allocation lock so that the sequence number
-exactly- matches the extent tree and the extent map we are going to
format into the iomap, otherwise the extent we map into the iomap
may already be stale and the validity cookie won't tell us that.

i.e. the cohrenecy relationship between the validity cookie and the
iomap must be set up from a synchronised state.  If the sequence
number is allowed to change between mapping the extent and sampling
the sequence number, then the extent we map and cache may already be
invalid and this introduces the possibility that the validity cookie
won't always catch that...

> +	if (ret < 0)
> +		return ret;
> +	/*
> +	 * ret can be 0 in case of a hole which is possible for mmaped writes.
> +	 */
> +	ret = ret ? ret : 1;
> +	return ext2_iomap_begin(inode, offset, (loff_t)ret << blkbits,
>  				IOMAP_WRITE, &wpc->iomap, NULL);

So calling ext2_iomap_begin() here might have to change. Indeed,
given that we just allocated the blocks and we know where they are
located, calling ext2_iomap_begin()->ext2_get_blocks() to look them
up again just to format them into the iomap seems .... convoluted.

It would be better to factor ext2_iomap_begin() into a call to
ext2_get_blocks() and then a "ext2_blocks_to_iomap()" function to
format the returned blocks into the iomap that is returned. Then
ext2_write_map_blocks() can just call ext2_blocks_to_iomap() here
and it skips the unnecessary block mapping lookup....

It also means that the ib_seq returned by the allocation can be fed
directly into the iomap->validity_cookie...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

