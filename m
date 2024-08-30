Return-Path: <linux-fsdevel+bounces-28092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79009966CC9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 01:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7A9284C35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 23:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01B1188A38;
	Fri, 30 Aug 2024 23:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYaF3q4Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475AF1531D0;
	Fri, 30 Aug 2024 23:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725058973; cv=none; b=ZwgAA/Gf4mXABnWCf5uZQfS86hKmUnRfQV876IPabXO9qziueAV28dFW4lJUFEt8gIo6egU9ByqRkbz8Qx9ax04Ly91ZJh/b6oQfW2itvaaBoQx9rOopHrzENWaA8gTpYHRxtuST0tn2m7CygoPnzwcrrKSB4aYLZtnR9M6+aZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725058973; c=relaxed/simple;
	bh=UCvtDNWCmCB2enzsjyhNwb221teRJYmMnJgO0fw7YQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlbFfcKGKj6lweDRvXcMMJr5hZ21UeVu3AqsOu/3J7PQaCY5qX3Acdw2UY5yvOcXng1nCXwsVSEm7mrCTLxkPLdvvv428y8B+ldOX6aFrhFIlIMpe250Z2GyCskOjWwNd5vmNhN55SeazzVH/Ky777ahtWxMKpjpOjh0wtQgtTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYaF3q4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C1DC4CEC2;
	Fri, 30 Aug 2024 23:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725058972;
	bh=UCvtDNWCmCB2enzsjyhNwb221teRJYmMnJgO0fw7YQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CYaF3q4QbLyR6EftDMW1GxR9wP1fQrrpV6taHy+djKQrw5WEPOKMsh/viuNNgaFYE
	 h+m0qwWWu+6FsMmZUm+22AwysCw1hpOhNBfTya8Q4TucufQdNG24oT9aGRogpxgxow
	 onvhxgZAjNvZy5SklWBSsgnGOcDnxaiY7L8fE7ADGPW8yNjZBEQMSGC4pCtNtZ1kgt
	 35LlVSeG/ECqpCa2dzV+0be+APRnJfvnoJsaWgg/rxpVwDvmLAyC8cLGKSVgaWSddb
	 B7mCrqZkzndVAgUkwRGUi54M/8fPz7ONFCcCqBlWpl0O/X+0NqZGUGBG0soWY38dT/
	 YmDfPgPL7aV5Q==
Date: Fri, 30 Aug 2024 16:02:52 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, josef@toxicpanda.com,
	david@fromorbit.com
Subject: Re: [PATCH 2/2] iomap: make zero range flush conditional on
 unwritten mappings
Message-ID: <20240830230252.GW6224@frogsfrogsfrogs>
References: <20240822145910.188974-1-bfoster@redhat.com>
 <20240822145910.188974-3-bfoster@redhat.com>
 <Zs1uHoemE7jHQ2bw@infradead.org>
 <Zs3hTiXLtuwXkYgU@bfoster>
 <Zs6oY91eFfaFVrMw@infradead.org>
 <Zs8Zo3V1G3NAQEnK@bfoster>
 <ZtAKJH_NGhjxFQHa@infradead.org>
 <ZtCOVzK4KlPbcnk_@bfoster>
 <20240829214800.GQ6224@frogsfrogsfrogs>
 <ZtGztWILZPlU6Gxo@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtGztWILZPlU6Gxo@bfoster>

On Fri, Aug 30, 2024 at 07:57:41AM -0400, Brian Foster wrote:
> On Thu, Aug 29, 2024 at 02:48:00PM -0700, Darrick J. Wong wrote:
> > On Thu, Aug 29, 2024 at 11:05:59AM -0400, Brian Foster wrote:
> > > On Wed, Aug 28, 2024 at 10:41:56PM -0700, Christoph Hellwig wrote:
> > > > On Wed, Aug 28, 2024 at 08:35:47AM -0400, Brian Foster wrote:
> > > > > Yeah, it was buried in a separate review around potentially killing off
> > > > > iomap_truncate_page():
> > > > > 
> > > > > https://lore.kernel.org/linux-fsdevel/ZlxUpYvb9dlOHFR3@bfoster/
> > > > > 
> > > > > The idea is pretty simple.. use the same kind of check this patch does
> > > > > for doing a flush, but instead open code and isolate it to
> > > > > iomap_truncate_page() so we can just default to doing the buffered write
> > > > > instead.
> > > > > 
> > > > > Note that I don't think this replaces the need for patch 1, but it might
> > > > > arguably make further optimization of the flush kind of pointless
> > > > > because I'm not sure zero range would ever be called from somewhere that
> > > > > doesn't flush already.
> > > > > 
> > > > > The tradeoffs I can think of are this might introduce some false
> > > > > positives where an EOF folio might be dirty but a sub-folio size block
> > > > > backing EOF might be clean, and again that callers like truncate and
> > > > > write extension would need to both truncate the eof page and zero the
> > > > > broader post-eof range. Neither of those seem all that significant to
> > > > > me, but just my .02.
> > > > 
> > > > Looking at that patch and your current series I kinda like not having
> > > > to deal with the dirty caches in the loop, and in fact I'd also prefer
> > > > to not do any writeback from the low-level zero helpers if we can.
> > > > That is not doing your patch 1 but instead auditing the callers if
> > > > any of them needs them and documenting the expectation.
> > 
> > I looked, and was pretty sure that XFS is the only one that has that
> > expectation.
> > 
> > > I agree this seems better in some ways, but I don't like complicating or
> > > putting more responsibility on the callers. I think if we had a high
> > > level iomap function that wrapped a combination of this proposed variant
> > > of truncate_page() and zero_range() for general inode size changes, that
> > > might alleviate that concern.
> > > 
> > > Otherwise IME even if we audited and fixed all callers today, over time
> > > we'll just reintroduce the same sorts of errors if the low level
> > > mechanisms aren't made to function correctly.
> > 
> > Yeah.  What /are/ the criteria for needing the flush and wait?  AFAICT,
> > a filesystem only needs the flush if it's possible to have dirty
> > pagecache backed either by a hole or an unwritten extent, right?
> > 
> 
> Yeah, but this flush behavior shouldn't be a caller consideration at
> all. It's just an implementation detail. All the caller should care
> about is that zero range works As Expected (tm).
> 
> The pre-iomap way of doing this in XFS was xfs_zero_eof() ->
> xfs_iozero(), which was an internally coded buffered write loop that
> wrote zeroes into pagecache. That was ultimately replaced with
> iomap_zero_range() with the same sort of usage expectations, but
> iomap_zero_range() just didn't work quite correctly in all cases.
> 
> > I suppose we could amend the iomap ops so that filesystems could signal
> > that they allow either of those things, and then we wouldn't have to
> > query the mapping for filesystems that don't, right?  IOWs, one can opt
> > out of safety features if there's no risk of a garbage, right?
> > 
> 
> Not sure I parse.. In general I think we could let ops signal whether
> they want certain checks. This is how I used the IOMAP_F_DIRTY_CACHE
> flag mentioned in the other thread. If the operation handler is
> interested in pagecache state, set an IOMAP_DIRTY_CACHE flag in ops to
> trigger a pre iomap_begin() check and then set the corresponding
> _F_DIRTY_CACHE flag on the mapping if dirty, but I'm not sure if that's
> the same concept you're alluding to here.

Nope.  I was thinking about adding a field to iomap_ops so that
filesystems could declare which types of mappings they could return:

const struct iomap_ops xfs_buffered_write_iomap_ops = {
	.iomap_begin		= xfs_buffered_write_iomap_begin,
	.iomap_end		= xfs_buffered_write_iomap_end,

	/* xfs allows sparse holes and unwritten extents */
	.iomap_types = (1U << IOMAP_UNWRITTEN) | (1U << IOMAP_HOLE),
};

But given your statement below about dirtying a post-eof region for
which the filesystem does not allocate a block, I suspect we just have
to enable the flush thing for everyone and don't need the flags thing.

> > (Also: does xfs allow dirty page cache backed by a hole?  I didn't think
> > that was possible.)
> > 
> 
> It's a corner case. A mapped write can write to any portion of a folio
> so long as it starts within eof. So if you have a mapped write that
> writes past EOF, there's no guarantee that range of the folio is mapped
> by blocks.
> 
> That post-eof part of the folio would be zeroed at writeback time, but
> that assumes i_size doesn't change before writeback. If it does and the
> size change operation doesn't do the zeroing itself (enter zero range
> via write extension), then we end up with a dirty folio at least
> partially backed by a hole with non-zero data within EOF. There's
> nothing written back to disk in this hole backed example, but the
> pagecache is still inconsistent with what's on disk and therefore I
> suspect data corruption is possible if the folio is redirtied before
> reclaimed.

Ah.  Yikes.

--D

> Brian
> 
> > > > But please let Dave and Darrick chime in first before investing any
> > > > work into this.
> > > > 
> > > > 
> > > 
> > > Based on the feedback to v2, it sounds like there's general consensus on
> > > the approach modulo some code factoring discussion. Unless there is
> > > objection, I think I'll stick with that for now for the sake of progress
> > > and keep this option in mind on the back burner. None of this is really
> > > that hard to change if we come up with something better.
> > > 
> > > Brian
> > > 
> > > 
> > 
> 
> 

