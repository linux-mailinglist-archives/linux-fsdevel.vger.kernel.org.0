Return-Path: <linux-fsdevel+bounces-14058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD9C877231
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 17:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B510028198E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 16:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E38D4596D;
	Sat,  9 Mar 2024 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxBlNslp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3310383BE;
	Sat,  9 Mar 2024 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710001482; cv=none; b=Z9vobD89cSqKI5Zj3ryRHLyc/CnUAp2DKyFcaXasCSy0eLDexj2zKFi9eF3ZQ3dXlPNwsd3O5UI1fSkNW+lN1ciR0oT4TNimojn0cumacLrmx+tIHRPfWd2chdm3V3hURgdduROpaOUyNhcONeC8g4KA1q7jr+eU9a1d6sLC5gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710001482; c=relaxed/simple;
	bh=fETwexvvOQQ+jmh+kp/x0A+lf9glkZH8TCJz6F7KXpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJ8d6vd6JB0pozOL1Ktvsl0qJUIudp4pt14iVyoDjNFOWuZJn8hlxN1aTCqs6yvq2YhlY7pjYktcLixK7POPygTKl5UB/+YqSalpxTetGC4dMYDRsZ9XISfRuspZu/VXZTX1pp1110TnQ5ExlLII2+w0sIaCi+XiAaJYdyG0Dq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxBlNslp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DA2C433C7;
	Sat,  9 Mar 2024 16:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710001482;
	bh=fETwexvvOQQ+jmh+kp/x0A+lf9glkZH8TCJz6F7KXpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FxBlNslp68rt5QmYWqKMRkaAp9uUzFic/HPbHvLr7S+94JZLJuoQY2u03a/CqPPuG
	 Y+F1BXDPeR0pAI9zYRqN1LeS1NIjRS3ac02/wjasAOha95khF7aT8wZtva4m7aFkRE
	 lHTQLlOx9qX1eBVArRJ4rdx8O+cOXT2CMwuTL7zp3tboeu33Ekz2HUyDc4I4l1IAfH
	 J23vaYF9c1pLLRPA834eXka2kifsvbKg15FklESoahiJQaWHT9woivv+EzilCP2bDz
	 fISHUhzgWW+Xj6SWtA5+DV4u+9c7BTIl0N24XbzMpQFm1unJ9b2AJ2Vk1WtK2VZsgH
	 Pdt5/z6pO9/zw==
Date: Sat, 9 Mar 2024 08:24:41 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com
Subject: Re: [PATCH v5 07/24] fsverity: support block-based Merkle tree
 caching
Message-ID: <20240309162441.GP1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-9-aalbersh@redhat.com>
 <20240306035622.GA68962@sol.localdomain>
 <20240307215401.GR1927156@frogsfrogsfrogs>
 <20240307224903.GE1799@sol.localdomain>
 <20240308035036.GL1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308035036.GL1927156@frogsfrogsfrogs>

On Thu, Mar 07, 2024 at 07:50:36PM -0800, Darrick J. Wong wrote:
> On Thu, Mar 07, 2024 at 02:49:03PM -0800, Eric Biggers wrote:
> > On Thu, Mar 07, 2024 at 01:54:01PM -0800, Darrick J. Wong wrote:
> > > On Tue, Mar 05, 2024 at 07:56:22PM -0800, Eric Biggers wrote:
> > > > On Mon, Mar 04, 2024 at 08:10:30PM +0100, Andrey Albershteyn wrote:
> > > > > diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
> > > > > index b3506f56e180..dad33e6ff0d6 100644
> > > > > --- a/fs/verity/fsverity_private.h
> > > > > +++ b/fs/verity/fsverity_private.h
> > > > > @@ -154,4 +154,12 @@ static inline void fsverity_init_signature(void)
> > > > >  
> > > > >  void __init fsverity_init_workqueue(void);
> > > > >  
> > > > > +/*
> > > > > + * Drop 'block' obtained with ->read_merkle_tree_block(). Calls out back to
> > > > > + * filesystem if ->drop_block() is set, otherwise, drop the reference in the
> > > > > + * block->context.
> > > > > + */
> > > > > +void fsverity_drop_block(struct inode *inode,
> > > > > +			 struct fsverity_blockbuf *block);
> > > > > +
> > > > >  #endif /* _FSVERITY_PRIVATE_H */
> > > > 
> > > > This should be paired with a helper function that reads a Merkle tree block by
> > > > calling ->read_merkle_tree_block or ->read_merkle_tree_page as needed.  Besides
> > > > being consistent with having a helper function for drop, this would prevent code
> > > > duplication between verify_data_block() and fsverity_read_merkle_tree().
> > > > 
> > > > I recommend that it look like this:
> > > > 
> > > > int fsverity_read_merkle_tree_block(struct inode *inode, u64 pos,
> > > > 				    unsigned long ra_bytes,
> > > > 				    struct fsverity_blockbuf *block);
> > > > 
> > > > 'pos' would be the byte position of the block in the Merkle tree, and 'ra_bytes'
> > > > would be the number of bytes for the filesystem to (optionally) readahead if the
> > > > block is not yet cached.  I think that things work out simpler if these values
> > > > are measured in bytes, not blocks.  'block' would be at the end because it's an
> > > > output, and it can be confusing to interleave inputs and outputs in parameters.
> > > 
> > > FWIW I don't really like 'pos' here because that's usually short for
> > > "file position", which is a byte, and this looks a lot more like a
> > > merkle tree block number.
> > > 
> > > u64 blkno?
> > > 
> > > Or better yet use a typedef ("merkle_blkno_t") to make it really clear
> > > when we're dealing with a tree block number.  Ignore checkpatch
> > > complaining about typeedefs. :)
> > 
> > My suggestion is for 'pos' to be a byte position, in alignment with the
> > pagecache naming convention as well as ->write_merkle_tree_block which currently
> > uses a 'u64 pos' byte position too.
> > 
> > It would also work for it to be a block index, in which case it should be named
> > 'index' or 'blkno' and have type unsigned long.  I *think* that things work out
> > a bit cleaner if it's a byte position, but I could be convinced that it's
> > actually better for it to be a block index.
> 
> It's probably cleaner (or at least willy says so) to measure everything
> in bytes.  The only place that gets messy is if we want to cache merkle
> tree blocks in an xarray or something, in which case we'd want to >> by
> the block_shift to avoid leaving gaps.

...and now having just done that, yes, I would like to retain passing
log_blocksize to the ->read_merkle_tree_block function.  I cleaned it up
a bit for my own purposes:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=fsverity-cleanups-6.9&id=4d36c90be4ac143f3e31989317bde7cd6c109c6e

Though I saw you had other feedback to Andrey about that. :)

--D

> > > > How about changing the prototype to:
> > > > 
> > > > void fsverity_invalidate_merkle_tree_block(struct inode *inode, u64 pos);
> > > >
> > > > Also, is it a kernel bug for the pos to be beyond the end of the Merkle tree, or
> > > > can it happen in cases like filesystem corruption?  If it can only happen due to
> > > > kernel bugs, WARN_ON_ONCE() might be more appropriate than an error message.
> > > 
> > > I think XFS only passes to _invalidate_* the same pos that was passed to
> > > ->read_merkle_tree_block, so this is a kernel bug, not a fs corruption
> > > problem.
> > > 
> > > Perhaps this function ought to note that @pos is supposed to be the same
> > > value that was given to ->read_merkle_tree_block?
> > > 
> > > Or: make the implementations return 1 for "reloaded from disk", 0 for
> > > "still in cache", or a negative error code.  Then fsverity can call
> > > the invalidation routine itself and XFS doesn't have to worry about this
> > > part.
> > > 
> > > (I think?  I have questions about the xfs_invalidate_blocks function.)
> > 
> > It looks like XFS can invalidate blocks other than the one being read by
> > ->read_merkle_tree_block.
> > 
> > If it really was only a matter of the single block being read, then it would
> > indeed be simpler to just make it a piece of information returned from
> > ->read_merkle_tree_block.
> > 
> > If the generic invalidation function is needed, it needs to be clearly
> > documented when filesystems are expected to invalidate blocks.
> 
> I /think/ the generic invalidation is only necessary with the weird
> DOUBLE_ALLOC thing.  If the other two implementations (ext4/f2fs)
> haven't needed a "nuke from orbit" function then xfs shouldn't require
> one too.
> 
> > > > > +
> > > > > +	/**
> > > > > +	 * Release the reference to a Merkle tree block
> > > > > +	 *
> > > > > +	 * @block: the block to release
> > > > > +	 *
> > > > > +	 * This is called when fs-verity is done with a block obtained with
> > > > > +	 * ->read_merkle_tree_block().
> > > > > +	 */
> > > > > +	void (*drop_block)(struct fsverity_blockbuf *block);
> > > > 
> > > > drop_merkle_tree_block, so that it's clearly paired with read_merkle_tree_block
> > > 
> > > Yep.  I noticed that xfs_verity.c doesn't put them together, which made
> > > me wonder if the write_merkle_tree_block path made use of that.  It
> > > doesn't, AFAICT.
> > > 
> > > And I think the reason is that when we're setting up the merkle tree,
> > > we want to stream the contents straight to disk instead of ending up
> > > with a huge cache that might not all be necessary?
> > 
> > In the current patchset, fsverity_blockbuf isn't used for writes (despite the
> > comment saying it is).  I think that's fine and that it keeps things simpler.
> > Filesystems can still cache the blocks that are passed to
> > ->write_merkle_tree_block if they want to.  That already happens on ext4 and
> > f2fs; FS_IOC_ENABLE_VERITY results in the Merkle tree being in the pagecache.
> 
> Oh!  Maybe it should do that then.  At least the root block?
> 
> --D
> 
> > - Eric
> > 
> 

