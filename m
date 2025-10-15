Return-Path: <linux-fsdevel+bounces-64174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6F0BDBF26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 03:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B69564EA4A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 01:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12672F49EC;
	Wed, 15 Oct 2025 01:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b6hAzcK9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D66186294;
	Wed, 15 Oct 2025 01:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760490198; cv=none; b=VHJsTWEQlcRhBzjBacZqmwC6pAXtyInj+rUUFh+eX/tGx+xHCqVXCnVDu/a9pP1gO8KnQQJL6hejlSl/XO6QYpDSzW4C1TX6I+K/ar88y74EcTy3Gf5rhQSOezXy7UmduZfMM5DJXGXmwwJSSTQTWurdbCnTc11+RiO+KzM5vgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760490198; c=relaxed/simple;
	bh=RREgf6Gg7wwMbGdc/AWZnTykON32Sl+5JqxT1WhtNd8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EKOijkOSB0a3pbfoRPVUD8+YZXcYvnX5J19exfWZbzxbty/rt7obtp4gS1sOEjABx7CAXWh8TWsKdrRLqtJ+08rAGGN+ZjBZvc9JF6ifoupjBEcEj10h/M9hD8/ZiEx6LxcPWIhJ2vaLx4n+5Kr3XYgO3PNJPW9humQYJR2r4TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b6hAzcK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5719AC4CEE7;
	Wed, 15 Oct 2025 01:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760490194;
	bh=RREgf6Gg7wwMbGdc/AWZnTykON32Sl+5JqxT1WhtNd8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b6hAzcK9a6ZsHa0Mk3iI21Eqpc+IV+6ztwUn4mhqw/zL741FObJn7o/U9JxPSucFA
	 SEs+LS9B625yiZiRfHBLry2rSnVIcwt334tzjVqkWVwgBsNZDdhpSWaH5YoM+Re3XR
	 MVE+EarzW3FoEwNNGRRa6truUMvxx/+8yivIASe4=
Date: Tue, 14 Oct 2025 18:03:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
 trondmy@kernel.org, anna@kernel.org, willy@infradead.org,
 mcgrof@kernel.org, clm@meta.com, david@fromorbit.com, amir73il@gmail.com,
 axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com, djwong@kernel.org,
 dave@stgolabs.net, wangyufei@vivo.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
 gost.dev@samsung.com, anuj20.g@samsung.com, vishak.g@samsung.com,
 joshi.k@samsung.com
Subject: Re: [PATCH v2 00/16] Parallelizing filesystem writeback
Message-Id: <20251014180312.6917d7bd5681d4c8ca356691@linux-foundation.org>
In-Reply-To: <20251014120845.2361-1-kundan.kumar@samsung.com>
References: <CGME20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9@epcas5p2.samsung.com>
	<20251014120845.2361-1-kundan.kumar@samsung.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 17:38:29 +0530 Kundan Kumar <kundan.kumar@samsung.com> wrote:

> Currently, pagecache writeback is performed by a single thread. Inodes
> are added to a dirty list, and delayed writeback is triggered. The single
> writeback thread then iterates through the dirty inode list, and executes
> the writeback.
> 
> This series parallelizes the writeback by allowing multiple writeback
> contexts per backing device (bdi). These writeback contexts are executed
> as separate, independent threads, improving overall parallelism. Inodes
> are distributed to these threads and are flushed in parallel.
> 
> ...
>
> IOPS and throughput
> ===================
> With the affinity to allocation group we see significant improvement in
> XFS when we write to multiple files in different directories(AGs).
> 
> Performance gains:
>   A) Workload 12 files each of 1G in 12 directories(AGs) - numjobs = 12
>     - NVMe device BM1743 SSD
>         Base XFS                : 243 MiB/s
>         Parallel Writeback XFS  : 759 MiB/s  (+212%)
> 
>     - NVMe device PM9A3 SSD
>         Base XFS                : 368 MiB/s
>         Parallel Writeback XFS  : 1634 MiB/s  (+344%)
> 
>   B) Workload 6 files each of 20G in 6 directories(AGs)  - numjobs = 6
>     - NVMe device BM1743 SSD
>         Base XFS                : 305 MiB/s
>         Parallel Writeback XFS  : 706 MiB/s  (+131%)
> 
>     - NVMe device PM9A3 SSD
>         Base XFS                : 315 MiB/s
>         Parallel Writeback XFS  : 990 MiB/s  (+214%)
> 
> Filesystem fragmentation
> ========================
> We also see that there is no increase in filesystem fragmentation
> Number of extents per file:
>   A) Workload 6 files each 1G in single directory(AG)   - numjobs = 1
>         Base XFS                : 17
>         Parallel Writeback XFS  : 17
> 
>   B) Workload 12 files each of 1G to 12 directories(AGs)- numjobs = 12
>         Base XFS                : 166593
>         Parallel Writeback XFS  : 161554
> 
>   C) Workload 6 files each of 20G to 6 directories(AGs) - numjobs = 6
>         Base XFS                : 3173716
>         Parallel Writeback XFS  : 3364984

Nice results.  Is testing planned for other filesystems?

