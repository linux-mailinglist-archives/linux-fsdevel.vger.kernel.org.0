Return-Path: <linux-fsdevel+bounces-54366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D98D1AFED27
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 17:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E624170A8F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 15:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5B52E5B3E;
	Wed,  9 Jul 2025 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0l0/d75"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C386F1D54F7;
	Wed,  9 Jul 2025 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073478; cv=none; b=cmuaJErzzRK3JemJpknINRUeLkkD4MpST4qdS7RAk89vLFe94Ko6PyqqvLGg4MtC01xTHD+Sf2yM0yRR7e2pDEeW3aMtDBZXJvsfJ1obd7wfwc+f7qJsUfus/7aSfyUVVZD/xUfs8JgYS46VNbIOgF7Q6qtIbF8x7ZIpewlhg7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073478; c=relaxed/simple;
	bh=AlzZ6o1HrNfQ09llKHDD4OoK91Jxu8FYl9PqkkdFCCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmZ1zGJZ2qf+cAf5jy+sfBvkoNBCBGIgg5wdLgzfJ3wMVKboHn+480J87RsjzN3cuGgY/SFHxcP2tdjalsq8CgbVAZ6hn1/dV5vh2v51l7eDRie6pklbPtXBzD4KgkbOqA4S+tzAikupyRKVzUsRR0/NyKsC7LHwDhcde9hd5BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0l0/d75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D61BC4CEEF;
	Wed,  9 Jul 2025 15:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752073478;
	bh=AlzZ6o1HrNfQ09llKHDD4OoK91Jxu8FYl9PqkkdFCCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l0l0/d75LHIF0xW8U158TUbCa7E8JtYOQi9eCPBSNFGB8rD8rmZKa/J/fIIMRwu6L
	 2WDkCTegAmZ31jUzETf42XnYTqvhizdEdfSFdSbgFONBtlqWCEpXQC701VeLjxkkkZ
	 JfM/kvk9ukvN6I/NDevJggC/aPNrjypWokwm63LRBA0zkBc+sEuSaL6HGIOUX8F5Pf
	 fTARs1NcvzjSZBTCpKyjq4p2S28r4clr9LdrnT2N5GZYKnRCLq8IDJjm5sT2qD/GRS
	 RgksmrQWJT7RPcbWzYLfO+anaiVlmzATMwktQeiYDMx5bJ5yV+S9MUmv5Xb3pReZ1H
	 q0FHL4GPV9cdw==
Date: Wed, 9 Jul 2025 08:04:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Catherine Hoang <catherine.hoang@oracle.com>
Subject: Re: Why a lot of fses are using bdev's page cache to do super block
 read/write?
Message-ID: <20250709150436.GG2672029@frogsfrogsfrogs>
References: <5459cd6d-3fdb-4a4e-b5c7-00ef74f17f7d@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5459cd6d-3fdb-4a4e-b5c7-00ef74f17f7d@gmx.com>

On Wed, Jul 09, 2025 at 06:35:00PM +0930, Qu Wenruo wrote:
> Hi,
> 
> Recently I'm trying to remove direct bdev's page cache usage from btrfs
> super block IOs.
> 
> And replace it with common bio interface (mostly with bdev_rw_virt()).
> 
> However I'm hitting random generic/492 failure where sometimes blkid failed
> to detect any useful super block signature of btrfs.

Yes, you need to invalidate_bdev() after writing the superblock directly
to disk via submit_bio.

> This leads more digging, and to my surprise using bdev's page cache to do
> superblock IOs is not an exception, in fact f2fs is doing exactly the same
> thing.
> 
> 
> This makes me wonder:
> 
> - Should a fs use bdev's page cache directly?
>   I thought a fs shouldn't do this, and bio interface should be
>   enough for most if not all cases.
> 
>   Or am I wrong in the first place?

As willy said, most filesystems use the bdev pagecache because then they
don't have to implement their own (metadata) buffer cache.  The downside
is that any filesystem that does so must be prepared to handle the
buffer_head contents changing any time they cycle the bh lock because
anyone can write to the block device of a mounted fs ala tune2fs.

Effectively this means that you have to (a) revalidate the entire buffer
contents every time you lock_buffer(); and (b) you can't make decisions
based on superblock feature bits in the superblock bh directly.

I made that mistake when adding metadata_csum support to ext4 -- we'd
only connect to the crc32c "crypto" module if checksums were enabled in
the ondisk super at mount time, but then there were a couple of places
that looked at the ondisk super bits at runtime, so you could flip the
bit on and crash the kernel almost immediately.

Nowadays you could protect against malicious writes with the
BLK_DEV_WRITE_MOUNTED=n so at least that's mitigated a little bit.
Note (a) implies that the use of BH_Verified is a giant footgun.

Catherine Hoang [now cc'd] has prototyped a generic buffer cache so that
we can fix these vulnerabilities in ext2:
https://lore.kernel.org/linux-ext4/20250326014928.61507-1-catherine.hoang@oracle.com/

> - What is keeping fs super block update from racing with user space
>   device scan?
> 
>   I guess it's the regular page/folio locking of the bdev page cache.
>   But that also means, pure bio based IO will always race with buffered
>   read of a block device.

Right.  In theory you could take the posix advisory lock (aka flock)
from inside the kernel for the duration of the sb write, and that would
prevent libblkid/udev from seeing torn/stale contents because they take
LOCK_SH.

> - If so, is there any special bio flag to prevent such race?
>   So far I am unable to find out such flag.

No.

--D

> Thanks,
> Qu
> 

