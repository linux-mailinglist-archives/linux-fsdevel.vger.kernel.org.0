Return-Path: <linux-fsdevel+bounces-57536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 626C7B22E1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 18:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DF267A5E61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 16:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF492FA0F7;
	Tue, 12 Aug 2025 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdPFVQ4V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BA01F4CA0;
	Tue, 12 Aug 2025 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017287; cv=none; b=uTqkINgSyCimtS1BL5Urk7OmTEeWH+QFsMTizcyAuIhatl2bxvjBeVZYgii7enU9tQkoJSwzc8Kbnoz01WICutDpPImPK34XehVhpnzLe3WlfT3okQsY6IS3Pdg7spVhopfxUyAUeyfDiwDOQYMlSQ8Klk8mxgYwbTvoj9pSeyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017287; c=relaxed/simple;
	bh=TyxIRLTl9NXVeVcD8UsZ5wlMsNk5vzwRoGhXxXi1k8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kw9ZMPl8/FzFPrA2UtB95PUhpLiMBFKCmc+AB2zfx24Y5eyNeNOT27QqZ0f7C7a66jY0lYCgEUrmHRLtqp6YeMwTKIhBAnY84gUXYV6xVZNDpMRas9D0Ynl3w+Wn8HP56rbHO67qAQJRWG2RoI02g22wBcInZqTkGTXXSlblI74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdPFVQ4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7408AC4CEF0;
	Tue, 12 Aug 2025 16:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755017286;
	bh=TyxIRLTl9NXVeVcD8UsZ5wlMsNk5vzwRoGhXxXi1k8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cdPFVQ4VF5/IPTEMsMSORpVJmORvFRtRNo7KaE76rjlqlVZQADF89BLaWdbubfedU
	 fy96WdYdnkepCImVEnGfPBKIBgl1xiRARu6i1kamVb6dhK+THzDhAvhkAeu53rImkT
	 d0s5IXvrPQWktZ/3+7bYvZW0fqwBrlyvDn7cC4UsTziQOucpPxPJEJRgTSe5pFwBfQ
	 Rb6ClY79oKSx7fCb7T/GRa7ZQBgkfjKnrpaKvgK48BGt2vnWcS+agb4t08zqxXaB8y
	 mt2zZFET4wQcCJzBcJZQtJaz3WXq3zlfGEgtV+9qj73uLLu/qdyQLs6sY2QXKzVTTD
	 wgnf/8d43lJRQ==
Date: Tue, 12 Aug 2025 09:48:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Zhang Yi <yi.zhang@huaweicloud.com>,
	Theodore Ts'o <tytso@mit.edu>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Ext4 iomap warning during btrfs/136 (yes, it's from btrfs test
 cases)
Message-ID: <20250812164805.GH7942@frogsfrogsfrogs>
References: <9b650a52-9672-4604-a765-bb6be55d1e4a@gmx.com>
 <4ef2476f-50c3-424d-927d-100e305e1f8e@gmx.com>
 <20250808121659.GC778805@mit.edu>
 <035ad34e-fb1e-414f-8d3c-839188cfa387@suse.com>
 <c2a00db8-ed34-49bb-8c01-572381451af3@huaweicloud.com>
 <15a4c437-d276-4503-9e30-4d48f5b7a4ff@gmx.com>
 <20250811154935.GD7942@frogsfrogsfrogs>
 <869c9ca6-2799-4ae0-8490-f383d7e0564b@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <869c9ca6-2799-4ae0-8490-f383d7e0564b@suse.com>

On Tue, Aug 12, 2025 at 07:44:09AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/8/12 01:19, Darrick J. Wong 写道:
> > On Sun, Aug 10, 2025 at 07:36:48AM +0930, Qu Wenruo wrote:
> > > 
> > > 
> > > 在 2025/8/9 18:39, Zhang Yi 写道:
> > > > On 2025/8/9 6:11, Qu Wenruo wrote:
> > > > > 在 2025/8/8 21:46, Theodore Ts'o 写道:
> > > > > > On Fri, Aug 08, 2025 at 06:20:56PM +0930, Qu Wenruo wrote:
> > > > > > > 
> > > > > > > 在 2025/8/8 17:22, Qu Wenruo 写道:
> > > > > > > > Hi,
> > > > > > > > 
> > > > > > > > [BACKGROUND]
> > > > > > > > Recently I'm testing btrfs with 16KiB block size.
> > > > > > > > 
> > > > > > > > Currently btrfs is artificially limiting subpage block size to 4K.
> > > > > > > > But there is a simple patch to change it to support all block sizes <=
> > > > > > > > page size in my branch:
> > > > > > > > 
> > > > > > > > https://github.com/adam900710/linux/tree/larger_bs_support
> > > > > > > > 
> > > > > > > > [IOMAP WARNING]
> > > > > > > > And I'm running into a very weird kernel warning at btrfs/136, with 16K
> > > > > > > > block size and 64K page size.
> > > > > > > > 
> > > > > > > > The problem is, the problem happens with ext3 (using ext4 modeule) with
> > > > > > > > 16K block size, and no btrfs is involved yet.
> > > > > > 
> > > > > > 
> > > > > > Thanks for the bug report!  This looks like it's an issue with using
> > > > > > indirect block-mapped file with a 16k block size.  I tried your
> > > > > > reproducer using a 1k block size on an x86_64 system, which is how I
> > > > > > test problem caused by the block size < page size.  It didn't
> > > > > > reproduce there, so it looks like it really needs a 16k block size.
> > > > > > 
> > > > > > Can you say something about what system were you running your testing
> > > > > > on --- was it an arm64 system, or a powerpc 64 system (the two most
> > > > > > common systems with page size > 4k)?  (I assume you're not trying to
> > > > > > do this on an Itanic.  :-)   And was the page size 16k or 64k?
> > > > > 
> > > > > The architecture is aarch64, the host board is Rock5B (cheap and fast enough), the test machine is a VM on that board, with ovmf as the UEFI firmware.
> > > > > 
> > > > > The kernel is configured to use 64K page size, the *ext3* system is using 16K block size.
> > > > > 
> > > > > Currently I tried the following combination with 64K page size and ext3, the result looks like the following
> > > > > 
> > > > > - 2K block size
> > > > > - 4K block size
> > > > >     All fine
> > > > > 
> > > > > - 8K block size
> > > > > - 16K block size
> > > > >     All the same kernel warning and never ending fsstress
> > > > > 
> > > > > - 32K block size
> > > > > - 64K block size
> > > > >     All fine
> > > > > 
> > > > > I am surprised as you that, not all subpage block size are having problems, just 2 of the less common combinations failed.
> > > > > 
> > > > > And the most common ones (4K, page size) are all fine.
> > > > > 
> > > > > Finally, if using ext4 not ext3, all combinations above are fine again.
> > > > > 
> > > > > So I ran out of ideas why only 2 block sizes fail here...
> > > > > 
> > > > 
> > > > This issue is caused by an overflow in the calculation of the hole's
> > > > length on the forth-level depth for non-extent inodes. For a file system
> > > > with a 4KB block size, the calculation will not overflow. For a 64KB
> > > > block size, the queried position will not reach the fourth level, so this
> > > > issue only occur on the filesystem with a 8KB and 16KB block size.
> > > > 
> > > > Hi, Wenruo, could you try the following fix?
> > > > 
> > > > diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
> > > > index 7de327fa7b1c..d45124318200 100644
> > > > --- a/fs/ext4/indirect.c
> > > > +++ b/fs/ext4/indirect.c
> > > > @@ -539,7 +539,7 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
> > > >    	int indirect_blks;
> > > >    	int blocks_to_boundary = 0;
> > > >    	int depth;
> > > > -	int count = 0;
> > > > +	u64 count = 0;
> > > >    	ext4_fsblk_t first_block = 0;
> > > > 
> > > >    	trace_ext4_ind_map_blocks_enter(inode, map->m_lblk, map->m_len, flags);
> > > > @@ -588,7 +588,7 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
> > > >    		count++;
> > > >    		/* Fill in size of a hole we found */
> > > >    		map->m_pblk = 0;
> > > > -		map->m_len = min_t(unsigned int, map->m_len, count);
> > > > +		map->m_len = umin(map->m_len, count);
> > > >    		goto cleanup;
> > > >    	}
> > > 
> > > It indeed solves the problem.
> > > 
> > > Tested-by: Qu Wenruo <wqu@suse.com>
> > 
> > Can we get the relevant chunks of this test turned into a tests/ext4/
> > fstest so that the ext4 developers have a regression test that doesn't
> > require setting up btrfs, please?
> 
> Sure, although I can send out a ext4 specific test case for it, I'm
> definitely not the best one to explain why the problem happens.
> 
> Thus I believe Zhang Yi would be the best one to send the test case.
> 
> 
> 
> Another thing is, any ext3 run with 16K block size (that's if the system
> supports it) should trigger it with the existing test cases.
> 
> The biggest challenge is to get a system supporting 16k bs (aka page size >=
> 16K), so it has a high chance that for most people the new test case will
> mostly be NOTRUN.

I'm curious to try out fuse2fs against whatever test gets written, since
it supports large fsblock sizes.

--D

> Thanks,
> Qu
> 
> > 
> > --D
> > 
> > > Thanks,
> > > Qu
> > > 
> > > > Thanks,
> > > > Yi.
> > > > 
> > > 
> > > 
> 
> 

