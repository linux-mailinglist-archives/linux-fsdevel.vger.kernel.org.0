Return-Path: <linux-fsdevel+bounces-14059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3F887723A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 17:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65FD7B20B33
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 16:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95C945BFA;
	Sat,  9 Mar 2024 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW4Hc7Fn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC9C45955;
	Sat,  9 Mar 2024 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710001709; cv=none; b=Eru8y/HiJ4xW0CClKRUSt1uo9wO2v1uOPRi6SLb7tUj3oHlT3pNRU2Ett1kh6r1izh/lqniVmrBtitsulXHQVm8ag4SbRxy9HhO+7FmASmng6U0dSJTxsNibT+gcwffrb3Po5n6I+MqZaaQQb7z8mfGNiELyvbXmv7aDgh/PEHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710001709; c=relaxed/simple;
	bh=hfFQWnwvgj9sZDpvKlZFzXi7T2I6yg1wtYDTe7tklmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaM+aMznsyQ1SDwKYHnAV4APGAoPaX9ZZuVIQdDxG1uPfIk2HiF5RjgSZ646B0ZmwH2953EzJvGoLC4AdgBee4e0vsMXAH1DZ/YVOQGUGzuS5czISm5G6ByJD6Cc8L/vsjJ7RxGcRjI+iTwn1HP0XH2Vfza6rrTUa6lBJY95RKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TW4Hc7Fn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FFBC433F1;
	Sat,  9 Mar 2024 16:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710001708;
	bh=hfFQWnwvgj9sZDpvKlZFzXi7T2I6yg1wtYDTe7tklmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TW4Hc7FnnTmYUgTY7pfV0mLm+BFdMcMuNH0NdFNBUhNS6Uiq8dM8r6v8BHdWEINfh
	 XtbIPHuG00GNcK8P9sf6qxB6NpB+Hh2Au0FWtigX4H6TnwPm3LVyMXSPTB/OrIS6p7
	 eviLkNAfFOWzOpS0hcVeFv/L/zxhZIaFJ4tyyfCfRcyOR+LzDEbpNuNV8tt7KKFd1J
	 A2JadQT6JTRP5Pwy/XcZUoCz1MinRrZX1NdQqJXH0cZRhJKCEAYKS5w5/4G4l4sI4V
	 8t9QNA7iJrI8wpro45xFCEAtboWI/BTEHWXbYZgJGWiavBS/+TKXImgngV+ZXzhNmT
	 dBkgnwxDha0zw==
Date: Sat, 9 Mar 2024 08:28:28 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com, ebiggers@kernel.org
Subject: Re: [PATCH v5 11/24] xfs: add XBF_VERITY_SEEN xfs_buf flag
Message-ID: <20240309162828.GQ1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-13-aalbersh@redhat.com>
 <20240307224654.GB1927156@frogsfrogsfrogs>
 <ZepxHObVLb3JLCl/@dread.disaster.area>
 <20240308033138.GN6184@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308033138.GN6184@frogsfrogsfrogs>

On Thu, Mar 07, 2024 at 07:31:38PM -0800, Darrick J. Wong wrote:
> On Fri, Mar 08, 2024 at 12:59:56PM +1100, Dave Chinner wrote:
> > On Thu, Mar 07, 2024 at 02:46:54PM -0800, Darrick J. Wong wrote:
> > > On Mon, Mar 04, 2024 at 08:10:34PM +0100, Andrey Albershteyn wrote:
> > > > One of essential ideas of fs-verity is that pages which are already
> > > > verified won't need to be re-verified if they still in page cache.
> > > > 
> > > > XFS will store Merkle tree blocks in extended file attributes. When
> > > > read extended attribute data is put into xfs_buf.
> > > > 
> > > > fs-verity uses PG_checked flag to track status of the blocks in the
> > > > page. This flag can has two meanings - page was re-instantiated and
> > > > the only block in the page is verified.
> > > > 
> > > > However, in XFS, the data in the buffer is not aligned with xfs_buf
> > > > pages and we don't have a reference to these pages. Moreover, these
> > > > pages are released when value is copied out in xfs_attr code. In
> > > > other words, we can not directly mark underlying xfs_buf's pages as
> > > > verified as it's done by fs-verity for other filesystems.
> > > > 
> > > > One way to track that these pages were processed by fs-verity is to
> > > > mark buffer as verified instead. If buffer is evicted the incore
> > > > XBF_VERITY_SEEN flag is lost. When the xattr is read again
> > > > xfs_attr_get() returns new buffer without the flag. The xfs_buf's
> > > > flag is then used to tell fs-verity this buffer was cached or not.
> > > > 
> > > > The second state indicated by PG_checked is if the only block in the
> > > > PAGE is verified. This is not the case for XFS as there could be
> > > > multiple blocks in single buffer (page size 64k block size 4k). This
> > > > is handled by fs-verity bitmap. fs-verity is always uses bitmap for
> > > > XFS despite of Merkle tree block size.
> > > > 
> > > > The meaning of the flag is that value of the extended attribute in
> > > > the buffer is processed by fs-verity.
> > > > 
> > > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > > ---
> > > >  fs/xfs/xfs_buf.h | 18 ++++++++++--------
> > > >  1 file changed, 10 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
> > > > index 73249abca968..2a73918193ba 100644
> > > > --- a/fs/xfs/xfs_buf.h
> > > > +++ b/fs/xfs/xfs_buf.h
> > > > @@ -24,14 +24,15 @@ struct xfs_buf;
> > > >  
> > > >  #define XFS_BUF_DADDR_NULL	((xfs_daddr_t) (-1LL))
> > > >  
> > > > -#define XBF_READ	 (1u << 0) /* buffer intended for reading from device */
> > > > -#define XBF_WRITE	 (1u << 1) /* buffer intended for writing to device */
> > > > -#define XBF_READ_AHEAD	 (1u << 2) /* asynchronous read-ahead */
> > > > -#define XBF_NO_IOACCT	 (1u << 3) /* bypass I/O accounting (non-LRU bufs) */
> > > > -#define XBF_ASYNC	 (1u << 4) /* initiator will not wait for completion */
> > > > -#define XBF_DONE	 (1u << 5) /* all pages in the buffer uptodate */
> > > > -#define XBF_STALE	 (1u << 6) /* buffer has been staled, do not find it */
> > > > -#define XBF_WRITE_FAIL	 (1u << 7) /* async writes have failed on this buffer */
> > > > +#define XBF_READ		(1u << 0) /* buffer intended for reading from device */
> > > > +#define XBF_WRITE		(1u << 1) /* buffer intended for writing to device */
> > > > +#define XBF_READ_AHEAD		(1u << 2) /* asynchronous read-ahead */
> > > > +#define XBF_NO_IOACCT		(1u << 3) /* bypass I/O accounting (non-LRU bufs) */
> > > > +#define XBF_ASYNC		(1u << 4) /* initiator will not wait for completion */
> > > > +#define XBF_DONE		(1u << 5) /* all pages in the buffer uptodate */
> > > > +#define XBF_STALE		(1u << 6) /* buffer has been staled, do not find it */
> > > > +#define XBF_WRITE_FAIL		(1u << 7) /* async writes have failed on this buffer */
> > > > +#define XBF_VERITY_SEEN		(1u << 8) /* buffer was processed by fs-verity */
> > > 
> > > Yuck.  I still dislike this entire approach.
> > > 
> > > XBF_DOUBLE_ALLOC doubles the memory consumption of any xattr block that
> > > gets loaded on behalf of a merkle tree request, then uses the extra
> > > space to shadow the contents of the ondisk block.  AFAICT the shadow
> > > doesn't get updated even if the cached data does, which sounds like a
> > > landmine for coherency issues.
> > >
> > > XFS_DA_OP_BUFFER is a little gross, since I don't like the idea of
> > > exposing the low level buffering details of the xattr code to
> > > xfs_attr_get callers.
> > > 
> > > XBF_VERITY_SEEN is a layering violation because now the overall buffer
> > > cache can track file metadata state.  I think the reason why you need
> > > this state flag is because the datadev buffer target indexes based on
> > > physical xfs_daddr_t, whereas merkle tree blocks have their own internal
> > > block numbers.  You can't directly go from the merkle block number to an
> > > xfs_daddr_t, so you can't use xfs_buf_incore to figure out if the block
> > > fell out of memory.
> > >
> > > ISTR asking for a separation of these indices when I reviewed some
> > > previous version of this patchset.  At the time it seems to me that a
> > > much more efficient way to cache the merkle tree blocks would be to set
> > > up a direct (merkle tree block number) -> (blob of data) lookup table.
> > > That I don't see here.
> > >
> > > In the spirit of the recent collaboration style that I've taken with
> > > Christoph, I pulled your branch and started appending patches to it to
> > > see if the design that I'm asking for is reasonable.  As it so happens,
> > > I was working on a simplified version of the xfs buffer cache ("fsbuf")
> > > that could be used by simple filesystems to get them off of buffer
> > > heads.
> > > 
> > > (Ab)using the fsbuf code did indeed work (and passed all the fstests -g
> > > verity tests), so now I know the idea is reasonable.  Patches 11, 12,
> > > 14, and 15 become unnecessary.  However, this solution is itself grossly
> > > overengineered, since all we want are the following operations:
> > > 
> > > peek(key): returns an fsbuf if there's any data cached for key
> > > 
> > > get(key): returns an fsbuf for key, regardless of state
> > > 
> > > store(fsbuf, p): attach a memory buffer p to fsbuf
> > > 
> > > Then the xfs ->read_merkle_tree_block function becomes:
> > > 
> > > 	bp = peek(key)
> > > 	if (bp)
> > > 		/* return bp data up to verity */
> > > 
> > > 	p = xfs_attr_get(key)
> > > 	if (!p)
> > > 		/* error */
> > > 
> > > 	bp = get(key)
> > > 	store(bp, p)
> > 
> > Ok, that looks good - it definitely gets rid of a lot of the
> > nastiness, but I have to ask: why does it need to be based on
> > xfs_bufs?
> 
> (copying from IRC) It was still warm in my brain L2 after all the xfile
> buftarg cleaning and merging that just got done a few weeks ago.   So I
> went with the simplest thing I could rig up to test my ideas, and now
> we're at the madly iterate until exhaustion stage. ;)
> 
> >            That's just wasting 300 bytes of memory on a handle to
> > store a key and a opaque blob in a rhashtable.
> 
> Yep.  The fsbufs implementation was a lot more slender, but a bunch more
> code.  I agree that I ought to go look at xarrays or something that's
> more of a direct mapping as a next step.  However, i wanted to get
> Andrey's feedback on this general approach first.
> 
> > IIUC, the key here is a sequential index, so an xarray would be a
> > much better choice as it doesn't require internal storage of the
> > key.
> 
> I wonder, what are the access patterns for merkle blobs?  Is it actually
> sequential, or is more like 0 -> N -> N*N as we walk towards leaves?
> 
> Also -- the fsverity block interfaces pass in a "u64 pos" argument.  Was
> that done because merkle trees may some day have more than 2^32 blocks
> in them?  That won't play well with things like xarrays on 32-bit
> machines.
> 
> (Granted we've been talking about deprecating XFS on 32-bit for a while
> now but we're not the whole world)
> 
> > i.e.
> > 
> > 	p = xa_load(key);
> > 	if (p)
> > 		return p;
> > 
> > 	xfs_attr_get(key);
> > 	if (!args->value)
> > 		/* error */
> > 
> > 	/*
> > 	 * store the current value, freeing any old value that we
> > 	 * replaced at this key. Don't care about failure to store,
> > 	 * this is optimistic caching.
> > 	 */
> > 	p = xa_store(key, args->value, GFP_NOFS);
> > 	if (p)
> > 		kvfree(p);
> > 	return args->value;
> 
> Attractive.  Will have to take a look at that tomorrow.

Done.  I think.  Not sure that I actually got all the interactions
between the shrinker and the xarray correct though.  KASAN and lockdep
don't have any complaints running fstests, so that's a start.

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fsverity-cleanups-6.9_2024-03-09

--D

> 
> --D
> 
> > -Dave.
> > -- 
> > Dave Chinner
> > david@fromorbit.com
> > 
> 

