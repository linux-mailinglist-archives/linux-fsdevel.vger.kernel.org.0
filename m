Return-Path: <linux-fsdevel+bounces-21908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDBA90E0D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 02:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5E3282F7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 00:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1DD3FF1;
	Wed, 19 Jun 2024 00:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFARj+oK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2295815CE;
	Wed, 19 Jun 2024 00:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718756685; cv=none; b=Z0A922BnpELk8SVFB7i+v7kiCrjegXELqcvHJO0hndP4WM3PeIce66U8oCG1WYvBGFuy2ULtGSXzI4zED24JOfskAmuHPy916QbIhjIGO0i8PIEfELdulKGI6cioZIzXrP7xMqnEhP0R78iv1jEJc/hj3JuQY/cp7y31V76E+bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718756685; c=relaxed/simple;
	bh=o7V1HvxMcu/Vb4/1j0DAzvXV9PZEBwsKo7jyvsnWr0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDxcMk6lWirb2zk/f1FXucZiZwcI+rwNznVTYrFIg0AC5P/1Q5brbjch3EVeY61HEyVOL+BzzxLoeFLFseN/QSGF8JeT9UYcToArVjuwqkxIQERVgm820xrmTxnVk+9N7G8sA4Y/3u0ET+NfNdu2z05zGz52MVTvzDpg7L5qe+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFARj+oK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CE2C3277B;
	Wed, 19 Jun 2024 00:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718756684;
	bh=o7V1HvxMcu/Vb4/1j0DAzvXV9PZEBwsKo7jyvsnWr0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eFARj+oKSVgku84ZhIsLmAJo1V54cM+nw1tCZrdiwttnL65nAqnmQvdwvHZir4SFb
	 WLoENeWrnMas+HclEEattz5nvzOCNXq7Cpb7QZo5JNg4yHwftoZ9BPmbXo0E7IxqwV
	 /rztxscSSQDNd9BMd+CcAk4upFUTNBEbrFT6VZf9VUSFYAKc8H5PdMBHP8ZEfTBaMU
	 u/k+3BnvOdpin6rQQZYKn+V6wpSq5DYPGRWcv2yKnztdmlA3q2p401rmGrQ/6aIaTV
	 pGByh3u3S5nJbsH7q5uZv9KkkjYRyrBQGLa6agdcQ4RHBtONbIGYRvcMqQWnz/fbHI
	 FbBiwijxQl1Xg==
Date: Tue, 18 Jun 2024 17:24:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, chandanbabu@kernel.org, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH -next v6 0/2] iomap/xfs: fix stale data exposure when
 truncating realtime inodes
Message-ID: <20240619002444.GH103034@frogsfrogsfrogs>
References: <20240618142112.1315279-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618142112.1315279-1-yi.zhang@huaweicloud.com>

On Tue, Jun 18, 2024 at 10:21:10PM +0800, Zhang Yi wrote:
> Changes since v5:
>  - Drop all the code about zeroing out the whole allocation unitsize
>    on truncate down in xfs_setattr_size() as Christoph suggested, let's
>    just fix this issue for RT file by converting tail blocks to
>    unwritten now, and we could think about forced aligned extent and
>    atomic write later until it needs, so only pick patch 6 and 8 in
>    previous version, do some minor git log changes.

This mostly makes sense, let's see how it fares with overnight fstests.
For now, this is a provisional
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> Changes since v4:
>  - Drop the first patch in v4 "iomap: zeroing needs to be pagecache
>    aware" since this series is not strongly depends on it, that patch
>    still needs furtuer analyse and also should add to handle the case of
>    a pending COW extent that extends over a data fork hole. This is a
>    big job, so let's fix the exposure stale data issue and brings back
>    the changes in iomap_write_end() first, don't block the ext4 buffered
>    iomap conversion.
>  - In patch 1, drop the 'ifndef rem_u64'.
>  - In patch 4, factor out a helper xfs_setattr_truncate_data() to handle
>    the zero out, update i_size, write back and drop pagecache on
>    truncate.
>  - In patch 5, switch to use xfs_inode_alloc_unitsize() in
>    xfs_itruncate_extents_flags().
>  - In patch 6, changes to reserve blocks for rtextsize > 1 realtime
>    inodes on truncate down.
>  - In patch 7, drop the unwritten convert threshold, always convert tail
>    blocks to unwritten on truncate down realtime inodes.
>  - Add patch 8 to bring back 'commit 943bc0882ceb ("iomap: don't
>    increase i_size if it's not a write operation")'.
> 
> Changes since v3:
>  - Factor out a new helper to get the remainder in math64.h as Darrick
>    suggested.
>  - Adjust the truncating order to prevent too much redundant blocking
>    writes as Dave suggested.
>  - Improve to convert the tail extent to unwritten when truncating down
>    an inode with large rtextsize as Darrick and Dave suggested.
> 
> Since 'commit 943bc0882ceb ("iomap: don't increase i_size if it's not a
> write operation")' merged, Chandan reported a stale data exposure issue
> when running fstests generic/561 on xfs with realtime device [1]. This
> issue has been fix in 6.10 by revert this commit through commit
> '0841ea4a3b41 ("iomap: keep on increasing i_size in iomap_write_end()")',
> but the real problem is xfs_setattr_size() doesn't zero out enough range
> when truncate down a realtime inode. So this series fix this problem by
> just converting the tail blocks to unwritten when truncate down realtime
> inodes, then we could bring commit 943bc0882ceb back.
> 
> I've tested this series on fstests (1) with reflink=0, (2) with
> reflink=1, (3) with 28K RT device, no new failures detected, and it
> passed generic/561 on RT device over 300+ rounds, please let me know if
> we need any other test.
> 
> [1] https://lore.kernel.org/linux-xfs/87ttj8ircu.fsf@debian-BULLSEYE-live-builder-AMD64/
> 
> Thanks,
> Yi.
> 
> Zhang Yi (2):
>   xfs: reserve blocks for truncating large realtime inode
>   iomap: don't increase i_size in iomap_write_end()
> 
>  fs/iomap/buffered-io.c | 53 +++++++++++++++++++++++-------------------
>  fs/xfs/xfs_iops.c      | 15 +++++++++++-
>  2 files changed, 43 insertions(+), 25 deletions(-)
> 
> -- 
> 2.39.2
> 
> 

