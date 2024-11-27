Return-Path: <linux-fsdevel+bounces-36025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFE89DABC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 17:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3A4166DDE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 16:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AE7200B9D;
	Wed, 27 Nov 2024 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vb+eAjeY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDEA20012C;
	Wed, 27 Nov 2024 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724910; cv=none; b=t7+Qr1eZlgdCkoE/G237r8zX341vnMuLpr5nSKA+e+TuBgz5LRHPXqqCmvSg82AkSvxHqw1WsLleY3EMdLcPzPaDY7HykAwW9DX/vTbbx9Ry0N2dPHhRYPos+sgGeQs7Bnp2K9Oc8hgwmI1gIBlAXMkdHTeDvuxUP0AWWaX8dEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724910; c=relaxed/simple;
	bh=ty7QdIGtAbk7uAeDhpNJfi2tfSQ74eL0IOTIQrH653o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipatkJ8iXjHkdPvKBVJ4tDABTcTtuwi9jTT7KXRicMzFU8eMDtGfBXlfvoDvEV2oSGBZ7YcczjJlc8h1/8HGpoHEJ1XhdKIEYpvlhEhG5Uq80Kop85mAgcdUCqF6xYWDGLkpu78MxhhG6kSxuZdR5EC2L1gOVAUd2wAHkC8iVbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vb+eAjeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92459C4CECC;
	Wed, 27 Nov 2024 16:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732724909;
	bh=ty7QdIGtAbk7uAeDhpNJfi2tfSQ74eL0IOTIQrH653o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vb+eAjeYD6zkg9gdT9B/Qp5u5HQuXIKMDQKzLP6MOLVq74iB89FVua2dZ728inxuB
	 uAzDn+ueIgZvYzlH+6BB37cA8n3/pB3f0JCu9dv6M8aEGl+B8eVmdiK+4fI+Oxiwbd
	 JkTMIeIRE1xMiv4tsxQfJ4C1Z55pRCIB3RaJyWpAICuNvGF7ZO/UJZu9JAe9xrFb1y
	 dZS6DD0Ti8rxFgyDfK2aUZ1SCXXLcmH7/pKA5fcqoAINXWR0l+doPVRhxKARFS+jxv
	 8XQnn03QGAugCQ2+1SnXomq2eVBEn7nQiiEMGCfKMW/Db0zVwy5vNHUNsZJALhMOsr
	 NpMKR60JFvN2Q==
Date: Wed, 27 Nov 2024 08:28:29 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Long Li <leo.lilong@huawei.com>
Cc: brauner@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, yi.zhang@huawei.com,
	houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v5 1/2] iomap: fix zero padding data issue in concurrent
 append writes
Message-ID: <20241127162829.GY1926309@frogsfrogsfrogs>
References: <20241127063503.2200005-1-leo.lilong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127063503.2200005-1-leo.lilong@huawei.com>

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

Er... filesystem iomap wasn't in 2.6.12, how did you come up with this?
At most this is a fix against a roughly 6.1 era kernel, right?

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

I think it's useful to preserve the diagram showing exactly what problem
you're solving:

	/*
	 * Clamp io_offset and io_size to the incore EOF so that ondisk
	 * file size updates in the ioend completion are byte-accurate.
	 * This avoids recovering files with zeroed tail regions when
	 * writeback races with appending writes:
	 *
	 *    Thread 1:                  Thread 2:
	 *    ------------               -----------
	 *    write [A, A+B]
	 *    update inode size to A+B
	 *    submit I/O [A, A+BS]
	 *                               write [A+B, A+B+C]
	 *                               update inode size to A+B+C
	 *    <I/O completes, updates disk size to min(A+B+C, A+BS)>
	 *    <power failure>
	 *
	 *  After reboot:
	 *    1) with A+B+C < A+BS, the file has zero padding in range
	 *       [A+B, A+B+C]
	 *
	 *    |<     Block Size (BS)    >|
	 *    |DDDDDDDDDDDD00000000000000|
	 *    ^           ^        ^
	 *    A          A+B     A+B+C
	 *                       (EOF)
	 *
	 *    2) with A+B+C > A+BS, the file has zero padding in range
	 *       [A+B, A+BS]
	 *
	 *    |<     Block Size (BS)    >|<      Block Size (BS)    >|
	 *    |DDDDDDDDDDDD00000000000000|000000000000000000000000000|
	 *    ^           ^              ^           ^
	 *    A          A+B            A+BS       A+B+C
	 *                              (EOF)
	 *
	 *    D = Valid Data
	 *    0 = Zero Padding
	 *
	 * Note that this defeats the ability to chain the ioends of
	 * appending writes.
	 */

(I reduced the blocksize a bit for wrapping purposes)

The logic looks ok, but I'm curious about how you landed at 2.6.12-rc
for the fixes tag.

--D

> +	 */
>  	wpc->ioend->io_size += len;
> +	if (wpc->ioend->io_offset + wpc->ioend->io_size > isize)
> +		wpc->ioend->io_size = isize - wpc->ioend->io_offset;
> +
>  	wbc_account_cgroup_owner(wbc, folio, len);
>  	return 0;
>  }
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 5675af6b740c..75bf54e76f3b 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -335,7 +335,7 @@ struct iomap_ioend {
>  	u16			io_type;
>  	u16			io_flags;	/* IOMAP_F_* */
>  	struct inode		*io_inode;	/* file being written to */
> -	size_t			io_size;	/* size of the extent */
> +	size_t			io_size;	/* size of data within eof */
>  	loff_t			io_offset;	/* offset in the file */
>  	sector_t		io_sector;	/* start sector of ioend */
>  	struct bio		io_bio;		/* MUST BE LAST! */
> -- 
> 2.39.2
> 

