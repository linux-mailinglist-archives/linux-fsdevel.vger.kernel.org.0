Return-Path: <linux-fsdevel+bounces-14356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D482987B283
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 21:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042331C25A33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 20:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317804D117;
	Wed, 13 Mar 2024 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dmqc3m2h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865B34776A;
	Wed, 13 Mar 2024 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360344; cv=none; b=u3x3FLiqRaNFmevNAluDq403TB5Z34cBkMH5ykJOPFiKbNVfk5Xc8ElqWBJ/qMyIQNyg57/itI0C5DfQ3+t6Aawd/VdWLv8pvvWFnCCFXkld+ushvXkSgZmMyH+3/b2qnUKpMiVlOaYfLDLaLGcTD9oJdVVodsGzmkJFHCQoTdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360344; c=relaxed/simple;
	bh=FyZZ4q+d+Q1ohXVYZHtiX6vCSNssRAwVN8MMwSYtAvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dA3AncMIo6Wqd/CWgM3IxMI1x9LdwrA9LP+9+/pODuCPJh2Ah1SFH0W0vNqdY776EERU1jr0kF4pnyRUzDgbmkWyLnBn32nwSOuk/VQLFFTiVdCCG+mRi4lxrbsTQ3do/Q2/EDhQTQwAeIYwVhFvYevxhA6o4Z8JrgeY5qGNFLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dmqc3m2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1343C433F1;
	Wed, 13 Mar 2024 20:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710360344;
	bh=FyZZ4q+d+Q1ohXVYZHtiX6vCSNssRAwVN8MMwSYtAvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dmqc3m2h0ZSod5dbmSaMMW9lUekMjVEuDZnqCPkoPVQu407cPhOyHPQvLgDwA2+Zu
	 RypAILSwkkwl7YWr5uYHynGdcGs/Wu7Bw2LFPxyeP2/pxOJDdygkVcUpP6TIGR2/nf
	 OEOcjsT0YIvGza/iKQtNpuU7WlKrb2WvyqI3Fc++7xuEWe09YNS5bpJjh2lSXSpgkD
	 PoTB7G4jDpATaB9K0e4CtKjFpVIM1N0lRjoKdu6PreD3lIfWAJvtoXM1hDu+2iofXJ
	 DCQLYGHk23+JbbawXba2/xMyudwuYjHeMdB9Z0Z//rypsp8WU/t1YUpfz336RkA3Hi
	 zwc9lMGuJAFEA==
Date: Wed, 13 Mar 2024 13:05:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, tytso@mit.edu, jack@suse.cz,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH 2/4] xfs: convert delayed extents to unwritten when
 zeroing post eof blocks
Message-ID: <20240313200543.GO1927156@frogsfrogsfrogs>
References: <20240311122255.2637311-1-yi.zhang@huaweicloud.com>
 <20240311122255.2637311-3-yi.zhang@huaweicloud.com>
 <20240311153737.GT1927156@frogsfrogsfrogs>
 <aab454d0-d8f3-61c8-0d14-a5ae4c35746e@huaweicloud.com>
 <20240312162150.GB1927156@frogsfrogsfrogs>
 <e29aa6df-5307-5c95-6471-fbaf3452d76f@huaweicloud.com>
 <cde25a6b-b468-33be-d82f-0172b840b064@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cde25a6b-b468-33be-d82f-0172b840b064@huaweicloud.com>

On Wed, Mar 13, 2024 at 09:25:49PM +0800, Zhang Yi wrote:
> On 2024/3/13 15:07, Zhang Yi wrote:
> > On 2024/3/13 0:21, Darrick J. Wong wrote:
> >> On Tue, Mar 12, 2024 at 08:31:58PM +0800, Zhang Yi wrote:
> >>> On 2024/3/11 23:37, Darrick J. Wong wrote:
> >>>> On Mon, Mar 11, 2024 at 08:22:53PM +0800, Zhang Yi wrote:
> >>>>> From: Zhang Yi <yi.zhang@huawei.com>
> >>>>>
> >>>>> Current clone operation could be non-atomic if the destination of a file
> >>>>> is beyond EOF, user could get a file with corrupted (zeroed) data on
> >>>>> crash.
> >>>>>
> >>>>> The problem is about to pre-alloctions. If you write some data into a
> >>>>> file [A, B) (the position letters are increased one by one), and xfs
> >>>>> could pre-allocate some blocks, then we get a delayed extent [A, D).
> >>>>> Then the writeback path allocate blocks and convert this delayed extent
> >>>>> [A, C) since lack of enough contiguous physical blocks, so the extent
> >>>>> [C, D) is still delayed. After that, both the in-memory and the on-disk
> >>>>> file size are B. If we clone file range into [E, F) from another file,
> >>>>> xfs_reflink_zero_posteof() would call iomap_zero_range() to zero out the
> >>>>> range [B, E) beyond EOF and flush range. Since [C, D) is still a delayed
> >>>>> extent, it will be zeroed and the file's in-memory && on-disk size will
> >>>>> be updated to D after flushing and before doing the clone operation.
> >>>>> This is wrong, because user can user can see the size change and read
> >>>>> zeros in the middle of the clone operation.
> >>>>>
> >>>>> We need to keep the in-memory and on-disk size before the clone
> >>>>> operation starts, so instead of writing zeroes through the page cache
> >>>>> for delayed ranges beyond EOF, we convert these ranges to unwritten and
> >>>>> invalidating any cached data over that range beyond EOF.
> >>>>>
> >>>>> Suggested-by: Dave Chinner <david@fromorbit.com>
> >>>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> >>>>> ---
> >>>>>  fs/xfs/xfs_iomap.c | 29 +++++++++++++++++++++++++++++
> >>>>>  1 file changed, 29 insertions(+)
> >>>>>
> >>>>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> >>>>> index ccf83e72d8ca..2b2aace25355 100644
> >>>>> --- a/fs/xfs/xfs_iomap.c
> >>>>> +++ b/fs/xfs/xfs_iomap.c
> >>>>> @@ -957,6 +957,7 @@ xfs_buffered_write_iomap_begin(
> >>>>>  	struct xfs_mount	*mp = ip->i_mount;
> >>>>>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> >>>>>  	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
> >>>>> +	xfs_fileoff_t		eof_fsb = XFS_B_TO_FSBT(mp, XFS_ISIZE(ip));
> >>>>>  	struct xfs_bmbt_irec	imap, cmap;
> >>>>>  	struct xfs_iext_cursor	icur, ccur;
> >>>>>  	xfs_fsblock_t		prealloc_blocks = 0;
> >>>>> @@ -1035,6 +1036,22 @@ xfs_buffered_write_iomap_begin(
> >>>>>  	}
> >>>>>  
> >>>>>  	if (imap.br_startoff <= offset_fsb) {
> >>>>> +		/*
> >>>>> +		 * For zeroing out delayed allocation extent, we trim it if
> >>>>> +		 * it's partial beyonds EOF block, or convert it to unwritten
> >>>>> +		 * extent if it's all beyonds EOF block.
> >>>>> +		 */
> >>>>> +		if ((flags & IOMAP_ZERO) &&
> >>>>> +		    isnullstartblock(imap.br_startblock)) {
> >>>>> +			if (offset_fsb > eof_fsb)
> >>>>> +				goto convert_delay;
> >>>>> +			if (end_fsb > eof_fsb) {
> >>>>> +				end_fsb = eof_fsb + 1;
> >>>>> +				xfs_trim_extent(&imap, offset_fsb,
> >>>>> +						end_fsb - offset_fsb);
> >>>>> +			}
> >>>>> +		}
> >>>>> +
> >>>>>  		/*
> >>>>>  		 * For reflink files we may need a delalloc reservation when
> >>>>>  		 * overwriting shared extents.   This includes zeroing of
> >>>>> @@ -1158,6 +1175,18 @@ xfs_buffered_write_iomap_begin(
> >>>>>  	xfs_iunlock(ip, lockmode);
> >>>>>  	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
> >>>>>  
> >>>>> +convert_delay:
> >>>>> +	end_fsb = min(end_fsb, imap.br_startoff + imap.br_blockcount);
> >>>>> +	xfs_iunlock(ip, lockmode);
> >>>>> +	truncate_pagecache_range(inode, offset, XFS_FSB_TO_B(mp, end_fsb));
> >>>>> +	error = xfs_iomap_write_direct(ip, offset_fsb, end_fsb - offset_fsb,
> >>>>> +				       flags, &imap, &seq);
> >>>>
> >>>> I expected this to be a direct call to xfs_bmapi_convert_delalloc.
> >>>> What was the reason not for using that?
> >>>>
> >>>
> >>> It's because xfs_bmapi_convert_delalloc() isn't guarantee to convert
> >>> enough blocks once a time, it may convert insufficient blocks since lack
> >>> of enough contiguous free physical blocks. If we are going to use it, I
> >>> suppose we need to introduce a new helper something like
> >>> xfs_convert_blocks(), add a loop to do the conversion.
> >>
> >> I thought xfs_bmapi_convert_delalloc passes out (via @iomap) the extent
> >> that xfs_bmapi_allocate (or anyone else) allocated (bma.got).  If that
> >> mapping is shorter, won't xfs_buffered_write_iomap_begin pass the
> >> shortened mapping out to the iomap machinery?  In which case that
> >> iomap_iter loop will call ->iomap_begin on the unfinished delalloc
> >> conversion work?
> > 
> > Yeah, make sense, it works, I forgot this loop in iomap_iter().
> 
> Sorry, I've found that it doesn't always work. Think about a special case,
> If we have a file below:
> 
> 	A          B           C                    D
> 	+wwwwwwwwww+DDDDDDDDDDD+dddddddddddddddddddd+
> 	          EOF         EOF
>                (on disk)  (in memory)
> 
> where 'd' is a delalloc block with no data and 'D' is a delalloc
> block with dirty folios over it.
> 
> xfs_bmapi_convert_delalloc() might only convert some blocks from B to B',
> 
> 	A          B   B'       C                    D
> 	+wwwwwwwwww+UUU+DDDDDDD+dddddddddddddddddddd+
> 	          EOF         EOF
>                (on disk)  (in memory)
> 
> After that, it will trigger below warning in iomap_iter_done():
> 
>  WARN_ON_ONCE(iter->iomap.offset + iter->iomap.length <= iter->pos);
> 
> So I guess the loop is still needed, I plane to revise and use
> xfs_convert_blocks() here.

Ah, sounds good to me.  Though, I wouldn't work too hard to hammer that
writeback helper into a write helper.

--D

> Yi.
> 
> 

