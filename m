Return-Path: <linux-fsdevel+bounces-73323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FC0D1594A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 23:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 310523037CC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 22:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB262BE03C;
	Mon, 12 Jan 2026 22:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SO3gXyug"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2017C9476;
	Mon, 12 Jan 2026 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768257120; cv=none; b=r6WgsMe0UEUPLEtjB4PhhKg7H7kIkkP6t/GrJmicXWOEicQhe1mDUxTtlwHlmnxtdtIYMdDkxKTzVvgUA6Fw5/4xdt3cUYO659zx4yKY9rQmbV1yOndleZg4YSKVqrXsUHXgJ/+VPhiEPx7HMnX6zK9YdvvByn0Wa1mp0ms0jq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768257120; c=relaxed/simple;
	bh=w/F8zJPgWoSq8QLQqegZIhSR1m//PoYbn/hQqm9C0aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIg9Y0jC9iYzx8/jQj177ztVtPDnvKxLWPOQ3ANoVVgyHn5OlUNtOai7oqXQU8QsgpbEkiD+tk1cq7oNlmsodD3GJHJe6mi0Y1Rn5lxJxwL44czge3sMLiZh3rvOhKrx5MPlsEw8f6HRk53ScjcWF2JM7iZZTc4Bi5AAd8Xa5FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SO3gXyug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7F5C116D0;
	Mon, 12 Jan 2026 22:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768257119;
	bh=w/F8zJPgWoSq8QLQqegZIhSR1m//PoYbn/hQqm9C0aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SO3gXyugDV6xzSM5DhQI38RIshoY2GghwHSkyH2Ci29tbPN0afCVnHvmuAj6rxTru
	 0LJ5EsVYTcmfvrZn5FF0XeX35KuItNZVyjbRoL6waX0qu0V8tPcaBtZ9YpPJnVh1V/
	 9OvZYr5oKvvY6DhId1uGjQAPq8jJFTAWk22Cx7xOMSX+QJ4RcH++xN1/OnsWrB25MT
	 rRtZooR0x+oUqnQfAZCivWhoicQr9cqzKLoSWUTrnehYXjxToCt/eSam3a1wIBQ5EP
	 /P975AueHZWICUQkstwJHLYqacLfAC6ntb2vPi41nQPmNc5Anxr0In2DSZ25pdKxxh
	 UWD6O1c5U823A==
Date: Mon, 12 Jan 2026 14:31:58 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 3/22] iomap: introduce IOMAP_F_BEYOND_EOF
Message-ID: <20260112223158.GK15551@frogsfrogsfrogs>
References: <cover.1768229271.patch-series@thinky>
 <d5fc72ldfwyzbgiypzlhn5diiqyijxaicpa3w6obx4iismuko3@kttpcgqjy6i5>
 <20260112221853.GI15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112221853.GI15551@frogsfrogsfrogs>

On Mon, Jan 12, 2026 at 02:18:53PM -0800, Darrick J. Wong wrote:
> On Mon, Jan 12, 2026 at 03:50:05PM +0100, Andrey Albershteyn wrote:
> > Flag to indicate to iomap that read/write is happening beyond EOF and no
> > isize checks/update is needed.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  fs/iomap/buffered-io.c | 13 ++++++++-----
> >  fs/iomap/trace.h       |  3 ++-
> >  include/linux/iomap.h  |  5 +++++
> >  3 files changed, 15 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index e5c1ca440d..cc1cbf2a4c 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -533,7 +533,8 @@
> 
> (Does your diff program not set --show-c-function?  That makes reviewing
> harder because I have to search on the comment text to figure out which
> function this is)
> 
> >  			return 0;
> >  
> >  		/* zero post-eof blocks as the page may be mapped */
> > -		if (iomap_block_needs_zeroing(iter, pos)) {
> > +		if (iomap_block_needs_zeroing(iter, pos) &&
> > +		    !(iomap->flags & IOMAP_F_BEYOND_EOF)) {
> 
> Hrm.  The last test in iomap_block_needs_zeroing is if pos is at or
> beyond EOF, and iomap_adjust_read_range takes great pains to reduce plen
> so that poff/plen never cross EOF.  I think the intent of that code is
> to ensure that we always zero the post-EOF part of a folio when reading
> it in from disk.
> 
> For verity I can see why you don't want to zero the merkle tree blocks
> beyond EOF, but I think this code can expose unwritten junk in the
> post-EOF part of the EOF block on disk.

Oh wait, is IOMAP_F_BEYOND_EOF only set on mappings that are entirely
beyond EOF, aka the merkle tree extents?

--D

> Would it be more correct to do:
> 
> static inline bool
> iomap_block_needs_zeroing(
> 	const struct iomap_iter *iter,
> 	struct folio *folio,
> 	loff_t pos)
> {
> 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> 
> 	if (srcmap->type != IOMAP_MAPPED)
> 		return true;
> 	if (srcmap->flags & IOMAP_F_NEW);
> 		return true;
> 
> 	/*
> 	 * Merkle tree exists in a separate folio beyond EOF, so
> 	 * only zero if this is the EOF folio.
> 	 */
> 	if (iomap->flags & IOMAP_F_BEYOND_EOF)
> 		return folio_pos(folio) == i_size_read(iter->inode);
> 
> 	return pos >= i_size_read(iter->inode);
> }
> 
> >  			folio_zero_range(folio, poff, plen);
> >  			iomap_set_range_uptodate(folio, poff, plen);
> >  		} else {
> > @@ -1130,13 +1131,14 @@
> >  		 * unlock and release the folio.
> >  		 */
> >  		old_size = iter->inode->i_size;
> > -		if (pos + written > old_size) {
> > +		if (pos + written > old_size &&
> > +		    !(iter->flags & IOMAP_F_BEYOND_EOF)) {
> >  			i_size_write(iter->inode, pos + written);
> >  			iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
> >  		}
> >  		__iomap_put_folio(iter, write_ops, written, folio);
> >  
> > -		if (old_size < pos)
> > +		if (old_size < pos && !(iter->flags & IOMAP_F_BEYOND_EOF))
> >  			pagecache_isize_extended(iter->inode, old_size, pos);
> >  
> >  		cond_resched();
> > @@ -1815,8 +1817,9 @@
> >  
> >  	trace_iomap_writeback_folio(inode, pos, folio_size(folio));
> >  
> > -	if (!iomap_writeback_handle_eof(folio, inode, &end_pos))
> > -		return 0;
> > +	if (!(wpc->iomap.flags & IOMAP_F_BEYOND_EOF) &&
> > +	    !iomap_writeback_handle_eof(folio, inode, &end_pos))
> 
> Hrm.  I /think/ this might break post-eof zeroing on writeback if
> BEYOND_EOF is set.  For verity this isn't a problem because there's no
> writeback, but it's a bit of a logic bomb if someone ever tries to set
> BEYOND_EOF on a non-verity file.
> 
> --D
> 
> > + 		return 0;
> >  	WARN_ON_ONCE(end_pos <= pos);
> >  
> >  	if (i_blocks_per_folio(inode, folio) > 1) {
> > diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> > index 532787277b..f1895f7ae5 100644
> > --- a/fs/iomap/trace.h
> > +++ b/fs/iomap/trace.h
> > @@ -118,7 +118,8 @@
> >  	{ IOMAP_F_ATOMIC_BIO,	"ATOMIC_BIO" }, \
> >  	{ IOMAP_F_PRIVATE,	"PRIVATE" }, \
> >  	{ IOMAP_F_SIZE_CHANGED,	"SIZE_CHANGED" }, \
> > -	{ IOMAP_F_STALE,	"STALE" }
> > +	{ IOMAP_F_STALE,	"STALE" }, \
> > +	{ IOMAP_F_BEYOND_EOF,	"BEYOND_EOF" }
> >  
> >  
> >  #define IOMAP_DIO_STRINGS \
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index 520e967cb5..7a7e31c499 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -86,6 +86,11 @@
> >  #define IOMAP_F_PRIVATE		(1U << 12)
> >  
> >  /*
> > + * IO happens beyound inode EOF
> 
> s/beyound/beyond/
> 
> > + */
> > +#define IOMAP_F_BEYOND_EOF	(1U << 13)
> > +
> > +/*
> >   * Flags set by the core iomap code during operations:
> >   *
> >   * IOMAP_F_SIZE_CHANGED indicates to the iomap_end method that the file size
> > 
> > -- 
> > - Andrey
> > 
> > 
> 

