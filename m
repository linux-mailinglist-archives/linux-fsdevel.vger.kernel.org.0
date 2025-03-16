Return-Path: <linux-fsdevel+bounces-44142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7D9A63467
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 08:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DAA67A68FA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 07:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19E518D626;
	Sun, 16 Mar 2025 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EO0i6jIJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A0E15C140;
	Sun, 16 Mar 2025 07:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742109344; cv=none; b=uivHuhVycalGj1QTmJXuazB8+bKa5xSPKN+Mkfv0Oy80XQc/HXogxgOuyJqPP1pRgMIhtJ+zBTHHNZMOwQIXSR3z1WJtKC7WarzNSCRYKKpcON771qRNWehh2brEhcIezSC9qorT5dHilog0nr23+j+GoafEeTVuksvw/Au6KIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742109344; c=relaxed/simple;
	bh=lu3qvsfUh6l/Lq9LC1hyOXIy2trWRiJd9d72CECHmx0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=EkVqYE5ue2XYekVXXoutlQRWCdoPuWySN8rmuCgv2SyLCkxxfhvcwRYMTG7nxU6S34nswgvfHrx4IU3w6jYfHkx+PLe7f8SRrRoNCnORWxvWFP9sNODAgMYVh3qZy32MHy1hoXZ2G/8bifxhYcI7y8nzp+RQT7Ghek69DCO8C4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EO0i6jIJ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fe9759e5c1so1735453a91.0;
        Sun, 16 Mar 2025 00:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742109342; x=1742714142; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bjcObISMHQZ+Fg1muKY5MRZIaUfjvyeHrPpcVz3xSs4=;
        b=EO0i6jIJ1ZL05DhgQp31Zh5WpzIDEjTVFXv7UVYwB8VcrZXOQxO/5GZ1MyHpPrhmuj
         A5NetT1YEErIqFSt9gFyA8qVTcHdaXOlDjHRx4SL6SzYxVwyr4x1hDvYqD24Bp160nda
         UKj0mFK7YQrCmKjfp31153yqe4gzFF15VUVcSlBqhc6WGdD/4VlVtIYVOZj3sXFFbn7G
         pJba/yxdqy/R5b7FKg/U72PQS2LHh8CUe2qB+3mXTyU56Xs2TUgmPo7WLDUyI7xM058L
         y2CzZkzUae/POpq1nMCmOG17OPJYhwy0H2475v0j4t+ys07B7TZKi1WwuaFgWfbQJDHC
         5xqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742109342; x=1742714142;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bjcObISMHQZ+Fg1muKY5MRZIaUfjvyeHrPpcVz3xSs4=;
        b=Xf/6YSW+1HVs4JxiirQ2SPEwQQMJ9P+ot0LIpvl2EmJ4WmSpgtgHhT0tfHNwNPXuJj
         7mwgEDsbaijt/yjKVhmZD9DRq2KiVICdHVTJ/Id2dKtLft2rfUzVmTOgU6frygAuRK9U
         TRLfbFCtkJqYaJOLeuDlf578qbGFKokBtPovScpLVrkSzi25CjRI+VVPvosGt1H8zLyt
         6K7JBqTX+fN4kiXMWfYuyButSS4bTTxsi4BWikK7RrsxEPDHL2FTtA5AmY0shx/zqpkg
         aPklsMNZTRwJ16te4QVN4LyOZ6L0Y5TFwvAZbZ/KBMpl0Ogy5A02CxLrvR4l+hLe4otp
         qzhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV39E/4TL5U7FL40wt0i9d7qUBZd6ENEu3qiEUIVTKUlMqN/SXyqmdqalYsVrfBOg8Wy9t2Q0GtWpcr@vger.kernel.org, AJvYcCVurELfPFU/DmIby/s8MXefeUuYhTETU6fqhZdoR5GB6+GqRvBOPQpfoVON//29cM329IrN9Q2R/AKgqQ1kKg==@vger.kernel.org, AJvYcCW1z9s2S8FWBLIwxJud1v3HmLYFgqtHIX+AgrBnOOecvsLSebZGcVTUlx1wUiYmi5kuAXQrRRILaHknmZwo@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmp82QfklwC0vDGM2tPQIKOwjV7eaXYIIiXh2TVAbtXjwFR/te
	AU+GAgVlmmkUeR1n78nrHVn5e0WjQebQ3eVuV4s8+wkOFvnUGCQZPgOJbw==
X-Gm-Gg: ASbGncsdPhP4qrbSlHFbA3cfNLyMBJgqQnu8BofJgvaLzTc9WyYIgyxWPF0io1O5S/r
	GmgCGKtNyH89cz45MgzgO6JOMY/wjpHbUEJuo86YdHEgyLAKRFymLEn+WmCpGxnJwznk06G5ue3
	NdhPEQUXP+KAMRWRzFWiRLmq4KA/TBe+cFN44DRdLXwPSlUGtNUTkajWKI8PcmaRh0F/EnTxNbR
	31+edUiSXBL7XZ8cnWPWVmPXdLUSX7aT1J8OqIV8bX5ysBatApBsqmjjyavPu7ijxIYZkTUfDYt
	k0WI3HxjYLC8FarEHWIzkn+bu6qwjxaaTzXdcg==
X-Google-Smtp-Source: AGHT+IE7H4raGlFXoKfcQaj6Wtc7nXW7cUYucho3UtQrEbSafIrgFPj3EgC+0L0cavSARR4MJtiPEg==
X-Received: by 2002:a17:90b:5387:b0:2ff:4a8d:74f8 with SMTP id 98e67ed59e1d1-30151c9a341mr8609833a91.6.1742109341749;
        Sun, 16 Mar 2025 00:15:41 -0700 (PDT)
Received: from dw-tp ([171.76.81.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153bc301esm3721187a91.49.2025.03.16.00.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 00:15:41 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, martin.petersen@oracle.com, tytso@mit.edu, linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v6 10/13] xfs: iomap COW-based atomic write support
In-Reply-To: <20250313171310.1886394-11-john.g.garry@oracle.com>
Date: Sun, 16 Mar 2025 12:23:34 +0530
Message-ID: <8734fd79g1.fsf@gmail.com>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-11-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


Hello,

John Garry <john.g.garry@oracle.com> writes:

> In cases of an atomic write covering misaligned or discontiguous disk
> blocks, we will use a CoW-based method to issue the atomic write.

Looks like the 1st time write to a given logical range of a file (e.g an
append write or writes on a hole), will also result into CoW based
fallback method, right?. More on that ask below. The commit msg should
capture that as well IMO.

>
> So, for that case, return -EAGAIN to request that the write be issued in
> CoW atomic write mode. The dio write path should detect this, similar to
> how misaligned regular DIO writes are handled.
>
> For normal REQ_ATOMIC-based mode, when the range which we are atomic
> writing to covers a shared data extent, try to allocate a new CoW fork.
> However, if we find that what we allocated does not meet atomic write
> requirements in terms of length and alignment, then fallback on the
> CoW-based mode for the atomic write.
>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_iomap.c | 131 ++++++++++++++++++++++++++++++++++++++++++++-
>  fs/xfs/xfs_iomap.h |   1 +
>  2 files changed, 130 insertions(+), 2 deletions(-)
>
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 8196e66b099b..88d86cabb8a1 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -798,6 +798,23 @@ imap_spans_range(
>  	return true;
>  }
>  
> +static bool
> +xfs_bmap_valid_for_atomic_write(
> +	struct xfs_bmbt_irec	*imap,
> +	xfs_fileoff_t		offset_fsb,
> +	xfs_fileoff_t		end_fsb)
> +{
> +	/* Misaligned start block wrt size */
> +	if (!IS_ALIGNED(imap->br_startblock, imap->br_blockcount))
> +		return false;
> +
> +	/* Discontiguous extents */
> +	if (!imap_spans_range(imap, offset_fsb, end_fsb))
> +		return false;
> +
> +	return true;
> +}
> +
>  static int
>  xfs_direct_write_iomap_begin(
>  	struct inode		*inode,
> @@ -812,10 +829,12 @@ xfs_direct_write_iomap_begin(
>  	struct xfs_bmbt_irec	imap, cmap;
>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>  	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
> +	xfs_fileoff_t		orig_end_fsb = end_fsb;
>  	int			nimaps = 1, error = 0;
>  	unsigned int		reflink_flags = 0;
>  	bool			shared = false;
>  	u16			iomap_flags = 0;
> +	bool			needs_alloc;
>  	unsigned int		lockmode;
>  	u64			seq;
>  
> @@ -877,13 +896,44 @@ xfs_direct_write_iomap_begin(
>  				&lockmode, reflink_flags);
>  		if (error)
>  			goto out_unlock;
> -		if (shared)
> +		if (shared) {
> +			/*
> +			 * Since we got a CoW fork extent mapping, ensure that
> +			 * the mapping is actually suitable for an
> +			 * REQ_ATOMIC-based atomic write, i.e. properly aligned
> +			 * and covers the full range of the write. Otherwise,
> +			 * we need to use the COW-based atomic write mode.
> +			 */
> +			if ((flags & IOMAP_ATOMIC) &&
> +			    !xfs_bmap_valid_for_atomic_write(&cmap,
> +					offset_fsb, end_fsb)) {
> +				error = -EAGAIN;
> +				goto out_unlock;
> +			}
>  			goto out_found_cow;
> +		}
>  		end_fsb = imap.br_startoff + imap.br_blockcount;
>  		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
>  	}
>  
> -	if (imap_needs_alloc(inode, flags, &imap, nimaps))
> +	needs_alloc = imap_needs_alloc(inode, flags, &imap, nimaps);
> +
> +	if (flags & IOMAP_ATOMIC) {
> +		error = -EAGAIN;
> +		/*
> +		 * If we allocate less than what is required for the write
> +		 * then we may end up with multiple mappings, which means that
> +		 * REQ_ATOMIC-based cannot be used, so avoid this possibility.
> +		 */
> +		if (needs_alloc && orig_end_fsb - offset_fsb > 1)
> +			goto out_unlock;

I have a quick question here. Based on above check it looks like
allocation requests on a hole or the 1st time allocation (append writes)
for a given logical range will always be done using CoW fallback
mechanism, isn't it? So that means HW based multi-fsblock atomic write
request will only happen for over writes (non-discontigous extent),
correct? 

Now, it's not always necessary that if we try to allocate an extent for
the given range, it results into discontiguous extents. e.g. say, if the
entire range being written to is a hole or append writes, then it might
just allocate a single unwritten extent which is valid for doing an
atomic write using HW/BIOs right? 
And it is valid to write using unwritten extent as long as we don't have
mixed mappings i.e. the entire range should either be unwritten or
written for the atomic write to be untorned, correct?

I am guessing this is kept intentional?

-ritesh

> +
> +		if (!xfs_bmap_valid_for_atomic_write(&imap, offset_fsb,
> +				orig_end_fsb))
> +			goto out_unlock;
> +	}
> +
> +	if (needs_alloc)
>  		goto allocate_blocks;
>  
>  	/*
> @@ -1024,6 +1074,83 @@ const struct iomap_ops xfs_zoned_direct_write_iomap_ops = {
>  };
>  #endif /* CONFIG_XFS_RT */
>  
> +static int
> +xfs_atomic_write_cow_iomap_begin(
> +	struct inode		*inode,
> +	loff_t			offset,
> +	loff_t			length,
> +	unsigned		flags,
> +	struct iomap		*iomap,
> +	struct iomap		*srcmap)
> +{
> +	ASSERT(flags & IOMAP_WRITE);
> +	ASSERT(flags & IOMAP_DIRECT);
> +
> +	struct xfs_inode	*ip = XFS_I(inode);
> +	struct xfs_mount	*mp = ip->i_mount;
> +	struct xfs_bmbt_irec	imap, cmap;
> +	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> +	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
> +	int			nimaps = 1, error;
> +	bool			shared = false;
> +	unsigned int		lockmode = XFS_ILOCK_EXCL;
> +	u64			seq;
> +
> +	if (xfs_is_shutdown(mp))
> +		return -EIO;
> +
> +	if (!xfs_has_reflink(mp))
> +		return -EINVAL;
> +
> +	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
> +	if (error)
> +		return error;
> +
> +	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
> +			&nimaps, 0);
> +	if (error)
> +		goto out_unlock;
> +
> +	 /*
> +	  * Use XFS_REFLINK_ALLOC_EXTSZALIGN to hint at aligning new extents
> +	  * according to extszhint, such that there will be a greater chance
> +	  * that future atomic writes to that same range will be aligned (and
> +	  * don't require this COW-based method).
> +	  */
> +	error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
> +			&lockmode, XFS_REFLINK_CONVERT_UNWRITTEN |
> +			XFS_REFLINK_FORCE_COW | XFS_REFLINK_ALLOC_EXTSZALIGN);
> +	/*
> +	 * Don't check @shared. For atomic writes, we should error when
> +	 * we don't get a COW fork extent mapping.
> +	 */
> +	if (error)
> +		goto out_unlock;
> +
> +	end_fsb = imap.br_startoff + imap.br_blockcount;
> +
> +	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
> +	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
> +	if (imap.br_startblock != HOLESTARTBLOCK) {
> +		seq = xfs_iomap_inode_sequence(ip, 0);
> +		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
> +		if (error)
> +			goto out_unlock;
> +	}
> +	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
> +	xfs_iunlock(ip, lockmode);
> +	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
> +
> +out_unlock:
> +	if (lockmode)
> +		xfs_iunlock(ip, lockmode);
> +	return error;
> +}
> +
> +const struct iomap_ops xfs_atomic_write_cow_iomap_ops = {
> +	.iomap_begin		= xfs_atomic_write_cow_iomap_begin,
> +};
> +
>  static int
>  xfs_dax_write_iomap_end(
>  	struct inode		*inode,
> diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
> index d330c4a581b1..674f8ac1b9bd 100644
> --- a/fs/xfs/xfs_iomap.h
> +++ b/fs/xfs/xfs_iomap.h
> @@ -56,5 +56,6 @@ extern const struct iomap_ops xfs_read_iomap_ops;
>  extern const struct iomap_ops xfs_seek_iomap_ops;
>  extern const struct iomap_ops xfs_xattr_iomap_ops;
>  extern const struct iomap_ops xfs_dax_write_iomap_ops;
> +extern const struct iomap_ops xfs_atomic_write_cow_iomap_ops;
>  
>  #endif /* __XFS_IOMAP_H__*/
> -- 
> 2.31.1

