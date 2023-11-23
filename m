Return-Path: <linux-fsdevel+bounces-3506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3902A7F58E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 08:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34C8AB210C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 07:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C0B14F65;
	Thu, 23 Nov 2023 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SsqqBrXS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95AA83;
	Wed, 22 Nov 2023 23:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gfCnOTMWBGaQ9EtuvEblhtZqjLaDKJa4eek8GzzpNew=; b=SsqqBrXS2BCELuoQIKvB+FR60B
	UYdqZwGstD3l8GEeErtSiNDBLcKi7uYc5VgDm6GYMhrm8GbBdGQbjHofRwLPn1PXGYqxFrI/pPiyQ
	29W+DFSray+cnn88j4IMTsVyz/FSdre2xoN8QN9qW5kr104euAhcfN0RTIi2kBEDsit44HWDdvKUO
	YAL6NJxfeayl69nbxN/fYc+y7YyFAk5udjjGz4J+881IeUI6YZfCKZkOL6dKHgbC6VHDg8MW+fUEv
	rNV0/olJ4yaSOwnWnGK5Frlx4OC0od4n4xZtDZ9+tlwjJnPjmfRfdwkB2MFIe3569dfr8crEpdaWF
	gSvtUMYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r63pt-003zAg-1p;
	Thu, 23 Nov 2023 07:09:17 +0000
Date: Wed, 22 Nov 2023 23:09:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use
 iomap
Message-ID: <ZV76nfRd6BUzXYqe@infradead.org>
References: <cover.1700506526.git.ritesh.list@gmail.com>
 <f5e84d3a63de30def2f3800f534d14389f6ba137.1700506526.git.ritesh.list@gmail.com>
 <20231122122946.wg3jqvem6fkg3tgw@quack3>
 <ZV399sCMq+p57Yh3@infradead.org>
 <ZV6AJHd0jJ14unJn@dread.disaster.area>
 <20231123040944.GB36168@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123040944.GB36168@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 22, 2023 at 08:09:44PM -0800, Darrick J. Wong wrote:
> The particular idea I had is to add a u64 counter to address_space that
> we can bump in the same places where we bump xfs_inode_fork::if_seq
> right now..  ->iomap_begin would sample this address_space::i_mappingseq
> counter (with locks held), and now buffered writes and writeback can
> check iomap::mappingseq == address_space::i_mappingseq to decide if it's
> time to revalidate.

So I think moving this to the VFS is probably a good idea, and I
actually argued for that when the sequence checking was first proposed.
We just have to be careful to be able to map things like the two
separate data and cow seq counts in XFS (or anything else complicated
in other file systems) to it.

> Anyway, I'll have time to go play with that (and further purging of
> function pointers)

Do we have anything where the function pointer overhead is actually
hurting us right now?

One thing I'd like to move to is to merge the iomap_begin and iomap_end
callbacks into one similar to willy's series from 2020.  The big
benefit of that would be that (together with switching
write_cache_pages to an iterator model) that we could actually use
this single iterator callback also for writeback instead of
->map_blocks, which doesn't really work with the current begin/end
based iomap_iter as the folios actually written through
write_cache_pages might not be contiguous.  Using the same mapping
callback would not only save some code duplication, but should also
allow us to nicely implement Dave's old idea to not dirty pages for
O_SYNC writes, but directly write them out.  I did start prototyping
that in the last days, and iomap_begin vs map_blocks is currently
the biggest stumbling block.

