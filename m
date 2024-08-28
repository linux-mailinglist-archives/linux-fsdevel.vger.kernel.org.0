Return-Path: <linux-fsdevel+bounces-27617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC3F962D96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 18:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39370286769
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 16:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5968C1A3BB8;
	Wed, 28 Aug 2024 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfuDFhQd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE785B216;
	Wed, 28 Aug 2024 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862242; cv=none; b=fS2zi9TUqJaLuoEKgDBC8jg3fGV83Ase16UY7zlbMXGUuUQtIgeSGWnsRu5zbWZ87hxmaOx0KLxb4LUuNUnsRELsDzVGsRRm9dKc5RyuOGeKsMkgqQmgLPAKwingNRWrCIypSh76Srb97gdiD95nba0cpKFFyrBKD3lDutEmCOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862242; c=relaxed/simple;
	bh=ek64Ez7ALjiYZoEu8O8UR2K7pZSJzTJIRhJiWuUvKVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzJhDf0Zm8QzYv6uwWlHW5ihCRwWxRvsrA6Yr0lpxcrYQWKcpQe16iGtUFhQgpstUSnCqAyJ51RqleEQRWYsbI/id/LiPtNRtP31z2/cKMVl9nEBIWofbtbatuFb/BD+gaxnWww/cu5Krl6w6bjSwZPHYcGJvZayMy1i1tYeMoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfuDFhQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293CFC4CED9;
	Wed, 28 Aug 2024 16:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724862242;
	bh=ek64Ez7ALjiYZoEu8O8UR2K7pZSJzTJIRhJiWuUvKVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XfuDFhQdK9DmS9eYIEIOuHtwsigN4kYgMA52ZtixYFqYZVocAEMSeTpaZRuWM6qzs
	 DcWt3P9mT1qoGtTNxyB390kFVPFeBAbPKV1/wvlVka6g9idWxxBt+fziSChLO+c2/c
	 SMryVhxPvGNuzndVlx2N29GQ2GhumBHTd7sD4DQ6oYoUp1v3dyDphPzOV39rPQWQ5g
	 JBkJvtMT1U+kjbx0+wt5zMH7JVHtdqkfzhYVWxWXGU1bQHqE34u4GfTjTPiuFMcxm8
	 tzIl13bouFK0lSYb+b3qj8iCNFme0erPlq4oCAqtogr2KrqJcp5fenGCFXo0teEbYu
	 HgCsfVXiBi8Bg==
Date: Wed, 28 Aug 2024 09:24:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/3] fs: add STATX_DIO_READ_ALIGN
Message-ID: <20240828162401.GM1977952@frogsfrogsfrogs>
References: <20240828051149.1897291-1-hch@lst.de>
 <20240828051149.1897291-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828051149.1897291-3-hch@lst.de>

On Wed, Aug 28, 2024 at 08:11:02AM +0300, Christoph Hellwig wrote:
> Add a separate dio read align field, as many out of place write
> file systems can easily do reads aligned to the device sector size,
> but require bigger alignment for writes.
> 
> This is usually papered over by falling back to buffered I/O for smaller
> writes and doing read-modify-write cycles, but performance for this
> sucks, so applications benefit from knowing the actual write alignment.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks fine to me...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/stat.c                 | 1 +
>  include/linux/stat.h      | 1 +
>  include/uapi/linux/stat.h | 4 +++-
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index 89ce1be563108c..044e7ad9f3abc2 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -700,6 +700,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
>  	tmp.stx_mnt_id = stat->mnt_id;
>  	tmp.stx_dio_mem_align = stat->dio_mem_align;
>  	tmp.stx_dio_offset_align = stat->dio_offset_align;
> +	tmp.stx_dio_read_offset_align = stat->dio_read_offset_align;
>  	tmp.stx_subvol = stat->subvol;
>  	tmp.stx_atomic_write_unit_min = stat->atomic_write_unit_min;
>  	tmp.stx_atomic_write_unit_max = stat->atomic_write_unit_max;
> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index 3d900c86981c5b..9d8382e23a9c69 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -52,6 +52,7 @@ struct kstat {
>  	u64		mnt_id;
>  	u32		dio_mem_align;
>  	u32		dio_offset_align;
> +	u32		dio_read_offset_align;
>  	u64		change_cookie;
>  	u64		subvol;
>  	u32		atomic_write_unit_min;
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 8b35d7d511a287..f78ee3670dd5d7 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -179,7 +179,8 @@ struct statx {
>  	/* Max atomic write segment count */
>  	__u32   stx_atomic_write_segments_max;
>  
> -	__u32   __spare1[1];
> +	/* File offset alignment for direct I/O reads */
> +	__u32	stx_dio_read_offset_align;
>  
>  	/* 0xb8 */
>  	__u64	__spare3[9];	/* Spare space for future expansion */
> @@ -213,6 +214,7 @@ struct statx {
>  #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
>  #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
>  #define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
> +#define STATX_DIO_READ_ALIGN	0x00020000U	/* Want/got dio read alignment info */
>  
>  #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
>  
> -- 
> 2.43.0
> 
> 

