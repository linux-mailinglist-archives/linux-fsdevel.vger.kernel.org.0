Return-Path: <linux-fsdevel+bounces-36184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ECD9DF098
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 14:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAAA2818DD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 13:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891E719AD7D;
	Sat, 30 Nov 2024 13:41:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A66322066;
	Sat, 30 Nov 2024 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732974112; cv=none; b=m8Q9xS2h+jd8YtJARIgBoiu9bpRtLD2IRtldOwzMKkI7gYXhCugh0G85vGnzkYQXs0kfw1dsFZhAq+0bymtcJY2q+Je1oa0X4OM0HoneKUuLwZUSDElY+PeCZe8+0rai7VPLdxzqJj5S4zU7CO5/TZYQfa5pjLks6JzmSSLqm68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732974112; c=relaxed/simple;
	bh=8yHA58RnBcqJ4iTh2+b2D7RTyLJDCG+KrfLJXsRle+4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvOj9FCheqE8r8uq/8V2eCI7ravEYfE0PG6wmmPc6oBjgbrmRPp1Ps9sxZYGC1nOxor+S25S5Xd4Tu238hLGFZFtmEYjYqFpG86MUreDIDVnWSnOmxAxV4vjpoBp62qE2xFgIS9U59MjipV3BzkVTKG2HGBRROEDuSoSE3gQ0gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Y0rjh33XRzxSPS;
	Sat, 30 Nov 2024 21:38:48 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E904180106;
	Sat, 30 Nov 2024 21:41:40 +0800 (CST)
Received: from localhost (10.175.112.188) by dggpemf500017.china.huawei.com
 (7.185.36.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 30 Nov
 2024 21:41:39 +0800
Date: Sat, 30 Nov 2024 21:39:29 +0800
From: Long Li <leo.lilong@huawei.com>
To: <brauner@kernel.org>, <djwong@kernel.org>, <cem@kernel.org>
CC: <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <houtao1@huawei.com>, <yangerkun@huawei.com>
Subject: Re: [PATCH v5 1/2] iomap: fix zero padding data issue in concurrent
 append writes
Message-ID: <Z0sVkSXzxUDReow7@localhost.localdomain>
References: <20241127063503.2200005-1-leo.lilong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20241127063503.2200005-1-leo.lilong@huawei.com>
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500017.china.huawei.com (7.185.36.126)

On Wed, Nov 27, 2024 at 02:35:02PM +0800, Long Li wrote:
> During concurrent append writes to XFS filesystem, zero padding data
> may appear in the file after power failure. This happens due to imprecise
> disk size updates when handling write completion.
> 
> Consider this scenario with concurrent append writes same file:
> 
>   Thread 1:                  Thread 2:
>   ------------               -----------
>   write [A, A+B]
>   update inode size to A+B
>   submit I/O [A, A+BS]
>                              write [A+B, A+B+C]
>                              update inode size to A+B+C
>   <I/O completes, updates disk size to min(A+B+C, A+BS)>
>   <power failure>
> 
> After reboot:
>   1) with A+B+C < A+BS, the file has zero padding in range [A+B, A+B+C]
> 
>   |<         Block Size (BS)      >|
>   |DDDDDDDDDDDDDDDD0000000000000000|
>   ^               ^        ^
>   A              A+B     A+B+C
>                          (EOF)
> 
>   2) with A+B+C > A+BS, the file has zero padding in range [A+B, A+BS]
> 
>   |<         Block Size (BS)      >|<           Block Size (BS)    >|
>   |DDDDDDDDDDDDDDDD0000000000000000|00000000000000000000000000000000|
>   ^               ^                ^               ^
>   A              A+B              A+BS           A+B+C
>                                   (EOF)
> 
>   D = Valid Data
>   0 = Zero Padding
> 
> The issue stems from disk size being set to min(io_offset + io_size,
> inode->i_size) at I/O completion. Since io_offset+io_size is block
> size granularity, it may exceed the actual valid file data size. In
> the case of concurrent append writes, inode->i_size may be larger
> than the actual range of valid file data written to disk, leading to
> inaccurate disk size updates.
> 
> This patch modifies the meaning of io_size to represent the size of
> valid data within EOF in an ioend. If the ioend spans beyond i_size,
> io_size will be trimmed to provide the file with more accurate size
> information. This is particularly useful for on-disk size updates
> at completion time.
> 
> After this change, ioends that span i_size will not grow or merge with
> other ioends in concurrent scenarios. However, these cases that need
> growth/merging rarely occur and it seems no noticeable performance impact.
> Although rounding up io_size could enable ioend growth/merging in these
> scenarios, we decided to keep the code simple after discussion [1].
> 
> Another benefit is that it makes the xfs_ioend_is_append() check more
> accurate, which can reduce unnecessary end bio callbacks of xfs_end_bio()
> in certain scenarios, such as repeated writes at the file tail without
> extending the file size.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Link[1]: https://patchwork.kernel.org/project/xfs/patch/20241113091907.56937-1-leo.lilong@huawei.com
> Signed-off-by: Long Li <leo.lilong@huawei.com>
> Reviewed-by: Brian Foster <bfoster@redhat.com>
> ---
> v4->v5: remove iomap_ioend_size_aligned() and don't round up io_size for
> 	ioend growth/merging to keep the code simple. 
>  fs/iomap/buffered-io.c | 10 ++++++++++
>  include/linux/iomap.h  |  2 +-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d42f01e0fc1c..dc360c8e5641 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1774,6 +1774,7 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
>  {
>  	struct iomap_folio_state *ifs = folio->private;
>  	size_t poff = offset_in_folio(folio, pos);
> +	loff_t isize = i_size_read(inode);
>  	int error;
>  
>  	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos)) {
> @@ -1789,7 +1790,16 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
>  
>  	if (ifs)
>  		atomic_add(len, &ifs->write_bytes_pending);
> +
> +	/*
> +	 * If the ioend spans i_size, trim io_size to the former to provide
> +	 * the fs with more accurate size information. This is useful for
> +	 * completion time on-disk size updates.
> +	 */
>  	wpc->ioend->io_size += len;
> +	if (wpc->ioend->io_offset + wpc->ioend->io_size > isize)
> +		wpc->ioend->io_size = isize - wpc->ioend->io_offset;
> +
 
When performing fsstress test with this patch set, there is a very low probability of
encountering an issue where isize is less than ioend->io_offset in iomap_add_to_ioend.
After investigation, this was found to be caused by concurrent with truncate operations.
Consider a scenario with 4K block size and a file size of 12K.

//write back [8K, 12K]           //truncate file to 4K
----------------------          ----------------------
iomap_writepage_map             xfs_setattr_size
  iomap_writepage_handle_eof
                                  truncate_setsize
				    i_size_write(inode, newsize)  //update inode size to 4K
  iomap_writepage_map_blocks
    iomap_add_to_ioend
           < iszie < ioend->io_offset>
	   <iszie = 4K,  ioend->io_offset=8K>

It appears that in extreme cases, folios beyond EOF might be written back,
resulting in situations where isize is less than pos. In such cases,
maybe we should not trim the io_size further.

Long Li


