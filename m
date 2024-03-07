Return-Path: <linux-fsdevel+bounces-13947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0BA875A70
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 23:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3371F23433
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 22:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945BD3D0B8;
	Thu,  7 Mar 2024 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBvznab/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C9A39FFA;
	Thu,  7 Mar 2024 22:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709851616; cv=none; b=qZ/PLMbbi77oXfCqrHzhXmCq9m9vY7tDDEBC677lKbtdu2S6uh6xkVWu5psuYYjbmN1g8XRgBpolOv6aY3T+9OWoXky197TKs0brOpYFx2iO68ywCfZWyk6bWraRPxFh2+uqZGgvLqE4/d2FemCcPbcAA0ubH+C8yY2KzbI1xK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709851616; c=relaxed/simple;
	bh=uPWYEXMTXJSpNxfTNrGrQdhMxqolTCFLLq10AFOc1nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvx0eQbHSCqSoxSynh7xzpx0ZS5XcS3ugS77VjRkyCDzLfsLoHCgDBD87T5kXdcGygC4q2U7jvSxdxmf4udCKBTBB1stRLVCMkDYLqe5Mx+OhGD7CmkjCpJRcVgfe74Nw246R6Rm++k5bMXTZFQET3G/kSljVylpFSHoLtUfxSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBvznab/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A84AC433F1;
	Thu,  7 Mar 2024 22:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709851615;
	bh=uPWYEXMTXJSpNxfTNrGrQdhMxqolTCFLLq10AFOc1nw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PBvznab/Fw0rmMk58/sfFMlPW1lLkKRDHUdn1hq6qLHeRXZCwN/AsJaWUdzR3ZDd3
	 M4YbnwQoTrNJTWna3fPC7U2y3ki8iCY/13gsxSA2/1YSzPEkBgqBRLf3UOVSourPIU
	 w9mUxNAPInj6Mn1veAOjLUDVk+2MbZMtalA7InKvOruKc7bqmJ22OCUnSveqnJqEcW
	 CXueObLD9UEIQz6hPrKAau1EMEAe8jmJ/iW+mV5ygzKSjmXlhG+uZeqytGdKs5fv86
	 d77+8A3umr00SFj4zTIYNLVkUwaMOfbCAKZ9/oQX82czTW6ZbORfAhQmPM97TwP2RN
	 6qHLpFpUtM0Cg==
Date: Thu, 7 Mar 2024 14:46:54 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	ebiggers@kernel.org
Subject: Re: [PATCH v5 11/24] xfs: add XBF_VERITY_SEEN xfs_buf flag
Message-ID: <20240307224654.GB1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-13-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304191046.157464-13-aalbersh@redhat.com>

On Mon, Mar 04, 2024 at 08:10:34PM +0100, Andrey Albershteyn wrote:
> One of essential ideas of fs-verity is that pages which are already
> verified won't need to be re-verified if they still in page cache.
> 
> XFS will store Merkle tree blocks in extended file attributes. When
> read extended attribute data is put into xfs_buf.
> 
> fs-verity uses PG_checked flag to track status of the blocks in the
> page. This flag can has two meanings - page was re-instantiated and
> the only block in the page is verified.
> 
> However, in XFS, the data in the buffer is not aligned with xfs_buf
> pages and we don't have a reference to these pages. Moreover, these
> pages are released when value is copied out in xfs_attr code. In
> other words, we can not directly mark underlying xfs_buf's pages as
> verified as it's done by fs-verity for other filesystems.
> 
> One way to track that these pages were processed by fs-verity is to
> mark buffer as verified instead. If buffer is evicted the incore
> XBF_VERITY_SEEN flag is lost. When the xattr is read again
> xfs_attr_get() returns new buffer without the flag. The xfs_buf's
> flag is then used to tell fs-verity this buffer was cached or not.
> 
> The second state indicated by PG_checked is if the only block in the
> PAGE is verified. This is not the case for XFS as there could be
> multiple blocks in single buffer (page size 64k block size 4k). This
> is handled by fs-verity bitmap. fs-verity is always uses bitmap for
> XFS despite of Merkle tree block size.
> 
> The meaning of the flag is that value of the extended attribute in
> the buffer is processed by fs-verity.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/xfs/xfs_buf.h | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
> index 73249abca968..2a73918193ba 100644
> --- a/fs/xfs/xfs_buf.h
> +++ b/fs/xfs/xfs_buf.h
> @@ -24,14 +24,15 @@ struct xfs_buf;
>  
>  #define XFS_BUF_DADDR_NULL	((xfs_daddr_t) (-1LL))
>  
> -#define XBF_READ	 (1u << 0) /* buffer intended for reading from device */
> -#define XBF_WRITE	 (1u << 1) /* buffer intended for writing to device */
> -#define XBF_READ_AHEAD	 (1u << 2) /* asynchronous read-ahead */
> -#define XBF_NO_IOACCT	 (1u << 3) /* bypass I/O accounting (non-LRU bufs) */
> -#define XBF_ASYNC	 (1u << 4) /* initiator will not wait for completion */
> -#define XBF_DONE	 (1u << 5) /* all pages in the buffer uptodate */
> -#define XBF_STALE	 (1u << 6) /* buffer has been staled, do not find it */
> -#define XBF_WRITE_FAIL	 (1u << 7) /* async writes have failed on this buffer */
> +#define XBF_READ		(1u << 0) /* buffer intended for reading from device */
> +#define XBF_WRITE		(1u << 1) /* buffer intended for writing to device */
> +#define XBF_READ_AHEAD		(1u << 2) /* asynchronous read-ahead */
> +#define XBF_NO_IOACCT		(1u << 3) /* bypass I/O accounting (non-LRU bufs) */
> +#define XBF_ASYNC		(1u << 4) /* initiator will not wait for completion */
> +#define XBF_DONE		(1u << 5) /* all pages in the buffer uptodate */
> +#define XBF_STALE		(1u << 6) /* buffer has been staled, do not find it */
> +#define XBF_WRITE_FAIL		(1u << 7) /* async writes have failed on this buffer */
> +#define XBF_VERITY_SEEN		(1u << 8) /* buffer was processed by fs-verity */

Yuck.  I still dislike this entire approach.

XBF_DOUBLE_ALLOC doubles the memory consumption of any xattr block that
gets loaded on behalf of a merkle tree request, then uses the extra
space to shadow the contents of the ondisk block.  AFAICT the shadow
doesn't get updated even if the cached data does, which sounds like a
landmine for coherency issues.

XFS_DA_OP_BUFFER is a little gross, since I don't like the idea of
exposing the low level buffering details of the xattr code to
xfs_attr_get callers.

XBF_VERITY_SEEN is a layering violation because now the overall buffer
cache can track file metadata state.  I think the reason why you need
this state flag is because the datadev buffer target indexes based on
physical xfs_daddr_t, whereas merkle tree blocks have their own internal
block numbers.  You can't directly go from the merkle block number to an
xfs_daddr_t, so you can't use xfs_buf_incore to figure out if the block
fell out of memory.

ISTR asking for a separation of these indices when I reviewed some
previous version of this patchset.  At the time it seems to me that a
much more efficient way to cache the merkle tree blocks would be to set
up a direct (merkle tree block number) -> (blob of data) lookup table.
That I don't see here.

In the spirit of the recent collaboration style that I've taken with
Christoph, I pulled your branch and started appending patches to it to
see if the design that I'm asking for is reasonable.  As it so happens,
I was working on a simplified version of the xfs buffer cache ("fsbuf")
that could be used by simple filesystems to get them off of buffer
heads.

(Ab)using the fsbuf code did indeed work (and passed all the fstests -g
verity tests), so now I know the idea is reasonable.  Patches 11, 12,
14, and 15 become unnecessary.  However, this solution is itself grossly
overengineered, since all we want are the following operations:

peek(key): returns an fsbuf if there's any data cached for key

get(key): returns an fsbuf for key, regardless of state

store(fsbuf, p): attach a memory buffer p to fsbuf

Then the xfs ->read_merkle_tree_block function becomes:

	bp = peek(key)
	if (bp)
		/* return bp data up to verity */

	p = xfs_attr_get(key)
	if (!p)
		/* error */

	bp = get(key)
	store(bp, p)

	/* return bp data up to verity */

*Fortunately* you've also rebased against the 6.9 for-next branch, which
means I think there's an elegant solution at hand.  The online repair
patches that are in that branch make it possible to create a standalone
xfs_buftarg.  We can attach one of these to an xfs_inode to cache merkle
tree blocks.  xfs_bufs have well known usage semantics, they're already
hooked up to shrinkers so that we can reclaim the data if memory is
tight, and they can clean up a lot of code.

Could you take a look at my branch here:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fsverity-cleanups-6.9_2024-03-07

And tell me what you think?

--D

>  
>  /* buffer type flags for write callbacks */
>  #define _XBF_INODES	 (1u << 16)/* inode buffer */
> @@ -65,6 +66,7 @@ typedef unsigned int xfs_buf_flags_t;
>  	{ XBF_DONE,		"DONE" }, \
>  	{ XBF_STALE,		"STALE" }, \
>  	{ XBF_WRITE_FAIL,	"WRITE_FAIL" }, \
> +	{ XBF_VERITY_SEEN,	"VERITY_SEEN" }, \
>  	{ _XBF_INODES,		"INODES" }, \
>  	{ _XBF_DQUOTS,		"DQUOTS" }, \
>  	{ _XBF_LOGRECOVERY,	"LOG_RECOVERY" }, \
> -- 
> 2.42.0
> 
> 

