Return-Path: <linux-fsdevel+bounces-57392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FDEB210D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 18:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0DE7B3966
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 16:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8980D2E03EB;
	Mon, 11 Aug 2025 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrGck7Fm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB02E2E2679;
	Mon, 11 Aug 2025 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927377; cv=none; b=cTzShH5tNb+SJ3/JIac9f45M6WQtxUUpMZKbNGGsL3rMEssiOc733gripkspi8NLg0+DLKknscUPz25jO9+mh5CZ504UGmlLYs6zjQED794/un9IAJkgbE2KF5XfP+yfqH7i2HJx9ll4ONi6zJs42WDg9SGv7ozrl4BuxAlmSFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927377; c=relaxed/simple;
	bh=RopHifErAZ/r1bKrzCXHi+tqR8Gd+ZBCOXa63JC3HIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duTirGKDQyiGBycyeKkvAiDA+PxmGT2Wcz7Ut5cbO5BRV7AqwSjREhyDzi8h2Th/WNpWnMRTGAWRmROQxHlknjGYXwC7WeG+eCtKFriId2xu/fYYq55rycfWt433MTjdjvFQLaEstZCwKXLvCGb00RSNcMBxMyTf3vLZHxVrRZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrGck7Fm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2FBC4CEED;
	Mon, 11 Aug 2025 15:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754927376;
	bh=RopHifErAZ/r1bKrzCXHi+tqR8Gd+ZBCOXa63JC3HIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WrGck7Fmn0StA1HSyOixhZNPLPo5/WRadk5mDshttUOMgrSNgupbE96hta5DvBVj3
	 apSkCJOnMOECU6/IGLbkJHX2t7Vvbotqor63J18pfGnwia/s6dXE1SreowaY24sO0q
	 wQv5qfqtKahV6w8xGiUAV8eURWno82WnSMRDKSAs2RJK/g/q3HIL3VWC2cB98VCGKW
	 QesWjW+OnVmrp9KDJ2yFVTxfMfuKyTpp+WLHGuakLcpptXpnmJAWXndwyWnOnsF3q+
	 s8DO7xeTCoaEjnNgQlSddM+52tNVwSnC4BsO8Rmzgvi74GrybIFHuhPemLca0du7Mp
	 yO0DvfspCWAEQ==
Date: Mon, 11 Aug 2025 08:49:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, Qu Wenruo <wqu@suse.com>,
	Theodore Ts'o <tytso@mit.edu>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Ext4 iomap warning during btrfs/136 (yes, it's from btrfs test
 cases)
Message-ID: <20250811154935.GD7942@frogsfrogsfrogs>
References: <9b650a52-9672-4604-a765-bb6be55d1e4a@gmx.com>
 <4ef2476f-50c3-424d-927d-100e305e1f8e@gmx.com>
 <20250808121659.GC778805@mit.edu>
 <035ad34e-fb1e-414f-8d3c-839188cfa387@suse.com>
 <c2a00db8-ed34-49bb-8c01-572381451af3@huaweicloud.com>
 <15a4c437-d276-4503-9e30-4d48f5b7a4ff@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15a4c437-d276-4503-9e30-4d48f5b7a4ff@gmx.com>

On Sun, Aug 10, 2025 at 07:36:48AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/8/9 18:39, Zhang Yi 写道:
> > On 2025/8/9 6:11, Qu Wenruo wrote:
> > > 在 2025/8/8 21:46, Theodore Ts'o 写道:
> > > > On Fri, Aug 08, 2025 at 06:20:56PM +0930, Qu Wenruo wrote:
> > > > > 
> > > > > 在 2025/8/8 17:22, Qu Wenruo 写道:
> > > > > > Hi,
> > > > > > 
> > > > > > [BACKGROUND]
> > > > > > Recently I'm testing btrfs with 16KiB block size.
> > > > > > 
> > > > > > Currently btrfs is artificially limiting subpage block size to 4K.
> > > > > > But there is a simple patch to change it to support all block sizes <=
> > > > > > page size in my branch:
> > > > > > 
> > > > > > https://github.com/adam900710/linux/tree/larger_bs_support
> > > > > > 
> > > > > > [IOMAP WARNING]
> > > > > > And I'm running into a very weird kernel warning at btrfs/136, with 16K
> > > > > > block size and 64K page size.
> > > > > > 
> > > > > > The problem is, the problem happens with ext3 (using ext4 modeule) with
> > > > > > 16K block size, and no btrfs is involved yet.
> > > > 
> > > > 
> > > > Thanks for the bug report!  This looks like it's an issue with using
> > > > indirect block-mapped file with a 16k block size.  I tried your
> > > > reproducer using a 1k block size on an x86_64 system, which is how I
> > > > test problem caused by the block size < page size.  It didn't
> > > > reproduce there, so it looks like it really needs a 16k block size.
> > > > 
> > > > Can you say something about what system were you running your testing
> > > > on --- was it an arm64 system, or a powerpc 64 system (the two most
> > > > common systems with page size > 4k)?  (I assume you're not trying to
> > > > do this on an Itanic.  :-)   And was the page size 16k or 64k?
> > > 
> > > The architecture is aarch64, the host board is Rock5B (cheap and fast enough), the test machine is a VM on that board, with ovmf as the UEFI firmware.
> > > 
> > > The kernel is configured to use 64K page size, the *ext3* system is using 16K block size.
> > > 
> > > Currently I tried the following combination with 64K page size and ext3, the result looks like the following
> > > 
> > > - 2K block size
> > > - 4K block size
> > >    All fine
> > > 
> > > - 8K block size
> > > - 16K block size
> > >    All the same kernel warning and never ending fsstress
> > > 
> > > - 32K block size
> > > - 64K block size
> > >    All fine
> > > 
> > > I am surprised as you that, not all subpage block size are having problems, just 2 of the less common combinations failed.
> > > 
> > > And the most common ones (4K, page size) are all fine.
> > > 
> > > Finally, if using ext4 not ext3, all combinations above are fine again.
> > > 
> > > So I ran out of ideas why only 2 block sizes fail here...
> > > 
> > 
> > This issue is caused by an overflow in the calculation of the hole's
> > length on the forth-level depth for non-extent inodes. For a file system
> > with a 4KB block size, the calculation will not overflow. For a 64KB
> > block size, the queried position will not reach the fourth level, so this
> > issue only occur on the filesystem with a 8KB and 16KB block size.
> > 
> > Hi, Wenruo, could you try the following fix?
> > 
> > diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
> > index 7de327fa7b1c..d45124318200 100644
> > --- a/fs/ext4/indirect.c
> > +++ b/fs/ext4/indirect.c
> > @@ -539,7 +539,7 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
> >   	int indirect_blks;
> >   	int blocks_to_boundary = 0;
> >   	int depth;
> > -	int count = 0;
> > +	u64 count = 0;
> >   	ext4_fsblk_t first_block = 0;
> > 
> >   	trace_ext4_ind_map_blocks_enter(inode, map->m_lblk, map->m_len, flags);
> > @@ -588,7 +588,7 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
> >   		count++;
> >   		/* Fill in size of a hole we found */
> >   		map->m_pblk = 0;
> > -		map->m_len = min_t(unsigned int, map->m_len, count);
> > +		map->m_len = umin(map->m_len, count);
> >   		goto cleanup;
> >   	}
> 
> It indeed solves the problem.
> 
> Tested-by: Qu Wenruo <wqu@suse.com>

Can we get the relevant chunks of this test turned into a tests/ext4/
fstest so that the ext4 developers have a regression test that doesn't
require setting up btrfs, please?

--D

> Thanks,
> Qu
> 
> > Thanks,
> > Yi.
> > 
> 
> 

