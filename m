Return-Path: <linux-fsdevel+bounces-4148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E96E37FCF39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 07:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260C61C2042B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831D310781
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctHorFvc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E8E63AD;
	Wed, 29 Nov 2023 05:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86495C433C7;
	Wed, 29 Nov 2023 05:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701236242;
	bh=6HnpvlqKyRsfCd1gC7Cy/PA+nTbbuKWsfFA5Lpvdp5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ctHorFvcnceqh3HaLH4XyKWGzr2QUPfh0ULh47YSyhChBoVtcLF+kXx5vjiT58Xzo
	 uJRfA3lio8jKFU0fzSJmxZr88G25spedemw6SrFPoR0WArldLVwOMzGUz/EvpbJNCk
	 BAvdB+EawTmNMWCfwiVL4Tt7o1N6qujPaf/XdS75fQN/OW+ILX6gDpXFcGqiOu5dn2
	 xnKidMfFQV8LHk+3dB3iTp5dFJ7Cx1A/50+K8yFk/RciMFkjx1vJAbIMJBhunb0mv8
	 +7Myv4LWnr31dUD9p3l/lrtA5kyezx+dj+Zb4QfhPwNuh6/JEB6+TayWzYN+nFIEQT
	 7IXSuHTz2g/Ew==
Date: Tue, 28 Nov 2023 21:37:21 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use
 iomap
Message-ID: <20231129053721.GC36168@frogsfrogsfrogs>
References: <cover.1700506526.git.ritesh.list@gmail.com>
 <f5e84d3a63de30def2f3800f534d14389f6ba137.1700506526.git.ritesh.list@gmail.com>
 <20231122122946.wg3jqvem6fkg3tgw@quack3>
 <ZV399sCMq+p57Yh3@infradead.org>
 <ZV6AJHd0jJ14unJn@dread.disaster.area>
 <20231123040944.GB36168@frogsfrogsfrogs>
 <ZV76nfRd6BUzXYqe@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV76nfRd6BUzXYqe@infradead.org>

On Wed, Nov 22, 2023 at 11:09:17PM -0800, Christoph Hellwig wrote:
> On Wed, Nov 22, 2023 at 08:09:44PM -0800, Darrick J. Wong wrote:
> > The particular idea I had is to add a u64 counter to address_space that
> > we can bump in the same places where we bump xfs_inode_fork::if_seq
> > right now..  ->iomap_begin would sample this address_space::i_mappingseq
> > counter (with locks held), and now buffered writes and writeback can
> > check iomap::mappingseq == address_space::i_mappingseq to decide if it's
> > time to revalidate.
> 
> So I think moving this to the VFS is probably a good idea, and I
> actually argued for that when the sequence checking was first proposed.
> We just have to be careful to be able to map things like the two
> separate data and cow seq counts in XFS (or anything else complicated
> in other file systems) to it.

TBH I've been wondering what would happen if we bumped i_mappingseq on
updates of either data or cow fork instead of the shift+or'd thing that
we use now for writeback and/or pagecache write.

I suppose the nice thing about the current encodings is that we elide
revalidations when the cow fork changes but mapping isn't shared.

> > Anyway, I'll have time to go play with that (and further purging of
> > function pointers)
> 
> Do we have anything where the function pointer overhead is actually
> hurting us right now?

Not that I know of, but moving to a direct call model means that the fs
would know based on the iomap_XXX_iter function signature whether or not
iomap needs a srcmap; and then it can modify its iomap_begin function
accordingly.

Right now all those rules aren't especially obvious or well documented.
Maybe I can convince myself that improved documentation will suffice to
eliminate Ted's confusion. :)

Also I haven't checked how much the indirect calls hurt.

> One thing I'd like to move to is to merge the iomap_begin and iomap_end
> callbacks into one similar to willy's series from 2020.  The big

Got a link to that?  I need my memory refreshed, having DROP TABLE MEM2020;
pretty please.

> benefit of that would be that (together with switching
> write_cache_pages to an iterator model) that we could actually use
> this single iterator callback also for writeback instead of
> ->map_blocks, which doesn't really work with the current begin/end
> based iomap_iter as the folios actually written through
> write_cache_pages might not be contiguous.

Ooh it'd benice to get rid of that parallel callbacks thing finally.

>  Using the same mapping
> callback would not only save some code duplication, but should also
> allow us to nicely implement Dave's old idea to not dirty pages for
> O_SYNC writes, but directly write them out.  I did start prototyping
> that in the last days, and iomap_begin vs map_blocks is currently
> the biggest stumbling block.

Neat!  willy's been pushing me for that too.

--D

