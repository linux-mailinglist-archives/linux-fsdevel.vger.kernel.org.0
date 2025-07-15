Return-Path: <linux-fsdevel+bounces-54981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EA8B06119
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 16:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A56E8B428A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3D326B765;
	Tue, 15 Jul 2025 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkXbgtRc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893C423ABA8;
	Tue, 15 Jul 2025 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589194; cv=none; b=MlXMr3mG0jLFbiA8ITKnr7GI0pcZM5v6Vh/KPgQv9Th/gGqIVmW0Q/8MyZTWNQKHzO6rHd5h9A4mBpov337upnUjoeMo2VUwYaX81PiGnkyV00XDjlm8535BWrnGb4OucZykM1BbQ3SFhat3Evj2xl341Syi5uNCVI4/LOULFDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589194; c=relaxed/simple;
	bh=qZ+LC3FTqFJ27mtCLEBJ1uKtZR3TIsj7xDBbTuuliR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+pOqwYotsWHYcHa/04+azBCCN4wLAXRf8SKchZd7b32nwUHRAEN5GYZIX6syB/Ba9C/kW3wFJxYqHkbf9TIauMiZG8ptW42TmzK/M49V8y9A/zcGeRAXpXQmabrsNX0jGkhjr20uGycTG49rDvcm+82mn5FOdiX2dXYGkk1P5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkXbgtRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F651C4CEE3;
	Tue, 15 Jul 2025 14:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752589194;
	bh=qZ+LC3FTqFJ27mtCLEBJ1uKtZR3TIsj7xDBbTuuliR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tkXbgtRclBrdKKwGxvl2fyRNA7ZDXaoB+JpC8gJMJZ0co1wjgMD3t/uVkWC0Z1Lwg
	 m+ituiGN8QClgVE6taDhix9JV2m8tLPwxtfhu0DC0tKszE3FMBnAeaHlAW/09f5f1P
	 XFkBEcXhrDjsZJp1yzuZMmJOUynwZwxNXZ6fQFfzn5178LruEEQ5CKonDtpweRdVYy
	 4Ruu/VLP37alTWyoVwm5XdzPeTa0s1Zh6JNfeM3JX2/lUhXZifcvKlGdDdS6le+kGY
	 +H/L3kvidQDgy+eAHZbWehwEP84xsXp4GVZ6PI3QVFgRzLPGi5BSnS0MpCrPKoumJA
	 QDhs46ChF6lyg==
Date: Tue, 15 Jul 2025 07:19:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, hch@infradead.org, willy@infradead.org
Subject: Re: [PATCH v3 5/7] xfs: fill dirty folios on zero range of unwritten
 mappings
Message-ID: <20250715141953.GM2672029@frogsfrogsfrogs>
References: <20250714204122.349582-1-bfoster@redhat.com>
 <20250714204122.349582-6-bfoster@redhat.com>
 <20250715052811.GQ2672049@frogsfrogsfrogs>
 <aHZLJyPmZPmDtLE_@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHZLJyPmZPmDtLE_@bfoster>

On Tue, Jul 15, 2025 at 08:35:51AM -0400, Brian Foster wrote:
> On Mon, Jul 14, 2025 at 10:28:11PM -0700, Darrick J. Wong wrote:
> > On Mon, Jul 14, 2025 at 04:41:20PM -0400, Brian Foster wrote:
> > > Use the iomap folio batch mechanism to select folios to zero on zero
> > > range of unwritten mappings. Trim the resulting mapping if the batch
> > > is filled (unlikely for current use cases) to distinguish between a
> > > range to skip and one that requires another iteration due to a full
> > > batch.
> > > 
> > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  fs/xfs/xfs_iomap.c | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > > 
> > > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > > index b5cf5bc6308d..63054f7ead0e 100644
> > > --- a/fs/xfs/xfs_iomap.c
> > > +++ b/fs/xfs/xfs_iomap.c
> > > @@ -1691,6 +1691,8 @@ xfs_buffered_write_iomap_begin(
> > >  	struct iomap		*iomap,
> > >  	struct iomap		*srcmap)
> > >  {
> > > +	struct iomap_iter	*iter = container_of(iomap, struct iomap_iter,
> > > +						     iomap);
> > >  	struct xfs_inode	*ip = XFS_I(inode);
> > >  	struct xfs_mount	*mp = ip->i_mount;
> > >  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> > > @@ -1762,6 +1764,7 @@ xfs_buffered_write_iomap_begin(
> > >  	 */
> > >  	if (flags & IOMAP_ZERO) {
> > >  		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
> > > +		u64 end;
> > >  
> > >  		if (isnullstartblock(imap.br_startblock) &&
> > >  		    offset_fsb >= eof_fsb)
> > > @@ -1769,6 +1772,26 @@ xfs_buffered_write_iomap_begin(
> > >  		if (offset_fsb < eof_fsb && end_fsb > eof_fsb)
> > >  			end_fsb = eof_fsb;
> > >  
> > > +		/*
> > > +		 * Look up dirty folios for unwritten mappings within EOF.
> > > +		 * Providing this bypasses the flush iomap uses to trigger
> > > +		 * extent conversion when unwritten mappings have dirty
> > > +		 * pagecache in need of zeroing.
> > > +		 *
> > > +		 * Trim the mapping to the end pos of the lookup, which in turn
> > > +		 * was trimmed to the end of the batch if it became full before
> > > +		 * the end of the mapping.
> > > +		 */
> > > +		if (imap.br_state == XFS_EXT_UNWRITTEN &&
> > > +		    offset_fsb < eof_fsb) {
> > > +			loff_t len = min(count,
> > > +					 XFS_FSB_TO_B(mp, imap.br_blockcount));
> > > +
> > > +			end = iomap_fill_dirty_folios(iter, offset, len);
> > > +			end_fsb = min_t(xfs_fileoff_t, end_fsb,
> > > +					XFS_B_TO_FSB(mp, end));
> > 
> > Hrmm.  XFS_B_TO_FSB and not _FSBT?  Can the rounding up behavior result
> > in a missed byte range?  I think the answer is no because @end should be
> > aligned to a folio boundary, and folios can't be smaller than an
> > fsblock.
> > 
> 
> Hmm.. not that I'm aware of..? Please elaborate if there's a case you're
> suspicious of because I could have certainly got my wires crossed.

I don't have a specific case in mind.  I saw the conversion function and
thought "well, what IF the return value from iomap_fill_dirty_folios
isn't aligned to a fsblock?" and then went around trying to prove that
isn't possible. :)

> My thinking is that end_fsb reflects the first fsb beyond the target
> range. I.e., it's calculated and used as such in xfs_iomap_end_fsb() and
> the various xfs_trim_extent() calls throughout the rest of the function.

<nod> So I think we're fine here.

--D

> Brian
> 
> > If the answer to the second question is indeed "no" then I think this is
> > ok and
> > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> > 
> > --D
> > 
> > 
> > > +		}
> > > +
> > >  		xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);
> > >  	}
> > >  
> > > -- 
> > > 2.50.0
> > > 
> > > 
> > 
> 
> 

