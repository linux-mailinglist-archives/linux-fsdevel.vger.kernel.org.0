Return-Path: <linux-fsdevel+bounces-34959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FF39CF24E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 18:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DFB72881A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 17:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250251CEE9F;
	Fri, 15 Nov 2024 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEuPz2TS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEF3824BD
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731690168; cv=none; b=tSnqNYPnUiH4Qwpr9nbp3Fe8ndc9AGQ7e3R6N2d31zdErAutmhsC647jHXzrTRJbaZLN7HU1FDTbk2zvnz4MUiCW2RyKzn4DSxbAlyoomlqdMJgqgwBdfjOYlgE/AsP0Ll4mLsmzF/jWGrCvayP2Fwi6f5JqtDbG7gz2B+YLG9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731690168; c=relaxed/simple;
	bh=rkFtgv5KWmHoLecs1jQJ9hGc8Bt04bbdagu9/tAmDac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6XIyeCzx46sl6y8qyHuiguIvYjUwYiF/JO65T7kp3goydJeS1kzpRIXxdNRsQlkxcWm2nABRTtGs1z3c1YHOaJGEhvNxiLKMJHyrDmlZ2zwGf+zEypg5l31upy8P2SFsONgwsjZrKFxO66JH/8IsvJ7Gt8ROskbwHDdBZgdkz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEuPz2TS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18549C4CECF;
	Fri, 15 Nov 2024 17:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731690168;
	bh=rkFtgv5KWmHoLecs1jQJ9hGc8Bt04bbdagu9/tAmDac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rEuPz2TSRzYcOPby8iSei3hu4mBrI6DmJ1t6vBCHve3tovE0rhyboNtAL+NviWsoX
	 9wRDktuqWgwkR2NGD5NvwJj+VNc2OwDXvzCyRe+wJ34vNvtL+nbKALF5rXhrVnTGfG
	 6xAp/CECVw4jHw722Uk0ufDh0poC0lOWMPepjGm3GL7K4p1Kvcd/W+V7MibYcH42ME
	 XAkGV7z94ZN/M4lxkuNvQ+lL0awsHlAR73JgDy1RB3++L85sSpYciF7bHpPw2Q7TnE
	 wnhGMgIj0w/KpSSQWYSeEbCAI+nLDSghVE1RKYmJvN9Fi/ZWZDjh72cNYcQBk0q37C
	 pu+yI7koun9gw==
Date: Fri, 15 Nov 2024 09:02:47 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] iomap: lift zeroed mapping handling into
 iomap_zero_range()
Message-ID: <20241115170247.GH9421@frogsfrogsfrogs>
References: <20241108124246.198489-1-bfoster@redhat.com>
 <20241108124246.198489-3-bfoster@redhat.com>
 <ZzGeQGl9zvQLkRfZ@infradead.org>
 <ZzNfg2E7TyMyo86h@bfoster>
 <ZzdgWkt1DRCTWfCv@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzdgWkt1DRCTWfCv@bfoster>

On Fri, Nov 15, 2024 at 09:53:14AM -0500, Brian Foster wrote:
> On Tue, Nov 12, 2024 at 09:00:35AM -0500, Brian Foster wrote:
> > On Sun, Nov 10, 2024 at 10:03:44PM -0800, Christoph Hellwig wrote:
> > > On Fri, Nov 08, 2024 at 07:42:44AM -0500, Brian Foster wrote:
> > > > In preparation for special handling of subranges, lift the zeroed
> > > > mapping logic from the iterator into the caller.
> > > 
> > > What's that special code?  I don't really see anything added to this
> > > in the new code?  In general I would prefer if all code for the
> > > iteration would be kept in a single function in preparation for
> > > unrolling these loops.  If you want to keep this code separate
> > > from the write zeroes logic (which seems like a good idea) please
> > > just just move the actual real zeroing out of iomap_zero_iter into
> > > a separate helper similar to how we e.g. have multiple different
> > > implementations in the dio iterator.
> > > 
> > 
> > There is no special code... the special treatment is to check the dirty
> > state of a block unaligned start in isolation to decide whether to skip
> > or explicitly zero if dirty. The fallback logic is to check the dirty
> > state of the entire range and if needed, flush the mapping to push all
> > pending (dirty && unwritten) instances out to the fs so the iomap is up
> > to date and we can safely skip iomaps that are inherently zero on disk.
> > 
> > Hmm.. so I see the multiple iter modes for dio, but it looks like that
> > is inherent to the mapping type. That's not quite what I'm doing here,
> > so I'm not totally clear on what you're asking for. FWIW, I swizzled
> > this code around a few times and failed to ultimately find something I'd
> > consider elegant. For example, initial versions would have something
> > like another param to iomap_zero_iter() to skip the optimization logic
> > (i.e. don't skip zeroed extents for this call), which I think is more in
> > the spirit of what you're saying, but I ultimately found it cleaner to
> > open code that part. If you had something else in mind, could you share
> > some pseudocode or something to show the factoring..?
> > 
> 
> FWIW, I'm concurrently hacking on what I'd consider a longer term fix
> here, based on some of the earlier discussions. The idea is basically
> iomap provides a mechanism for the fs to attach a folio_batch of dirty
> folios to the iomap, which zero range can then use as the source of
> truth for which subranges to zero of an unwritten mapping.

That's fun! :)

I wonder, can this mechanism stretch to the generic buffered write path?
In which case, can you hang on to the folios long enough to issue
writeback on them too, if it's a synchronous write?

> It occurs to me that might lend itself a bit more to what you're looking
> for here by avoiding the need for a new instance of the iter loop (I
> assume there is some outstanding work that is affected by this?). Given
> that this series was kind of a side quest for a band-aid performance fix
> in the meantime, and it's not likely 6.13 material anyways, I think I'm
> going to put it in a holding pattern and keep it in the back pocket in
> favor of trying to move that alternate approach along, at least to where
> I can post an RFC for discussion.
> 
> If that doesn't work out or there proves some critical need for it in
> the meantime, then I'll post v4 for an easy fix. I'll post a v2 of patch
> 4 separately since that is an independent fix..

I thought the bug robots were complaining about the performance hit,
so at least this part should go in sooner than later.

--D

> Brian
> 
> > > > +	while ((ret = iomap_iter(&iter, ops)) > 0) {
> > > > +		const struct iomap *s = iomap_iter_srcmap(&iter);
> > > > +
> > > > +		if (s->type == IOMAP_HOLE || s->type == IOMAP_UNWRITTEN) {
> > > > +			loff_t p = iomap_length(&iter);
> > > 
> > > Also please stick to variable names that are readable and preferably
> > > the same as in the surrounding code, e.g. s -> srcmap p -> pos.
> > > 
> > 
> > Sure. I think I did this to avoid long lines, but I can change it.
> > Thanks.
> > 
> > Brian
> > 
> > 
> 
> 

