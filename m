Return-Path: <linux-fsdevel+bounces-37864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7939F82DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 19:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 485F37A35DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB2618B46A;
	Thu, 19 Dec 2024 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIJXHjVg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B2741C6C;
	Thu, 19 Dec 2024 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734631329; cv=none; b=M8zRCaJYaULTLd+4QzaBmXa7kviv4hrpFzvsH7KZlMToOaTLLDHOP/NRJYymT9/0amnb5/ldzc6fwKpXpYHcxiFEXpFrI9k11MDE8Hd/1LPkrfM3ha3MJUFt0XndfWY3WLST90mcU5G/nbxmIfL6IAjgdU56JxKKUrWE2wamXHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734631329; c=relaxed/simple;
	bh=yUy7WZwjZ6OTcH75dwHDRB5iYuei1IXfYM/HLNv1n+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsPJnD3NcXmp/Z3Jro3Q4QFa7rHJCDtLSNOAA4Y74eOSIcNbhgqa8EjD5BoxUgUcFoOiIkZvUu0JL+kpJ4KUGZqDFGNy4lizUM4r920G44LR2530vGAXW5woGhjg1pqBH5O2uKpWrLoeTvhFJFQJCwVH7ma8TMQ0hvB9fCF2b4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIJXHjVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB96FC4CED0;
	Thu, 19 Dec 2024 18:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734631329;
	bh=yUy7WZwjZ6OTcH75dwHDRB5iYuei1IXfYM/HLNv1n+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MIJXHjVgVXc5ssh0b9qBH9t6BUP+NVTL1saDjM257JFLflpj+8BRhqqRJczPQOxRq
	 Zhtj2dX9AZrCuBRet3IUzFNPBvh6yMdYTey57abuUL1xxvqt0B0iQ+Bw3bBWmhyiWi
	 uQSyLx92BALyfyX5pvZWLi2R0c9jJ0R2dcgwXYwvrxGsyn2j/oaorVmJqvRmGR8pve
	 NdBlCTz62/pO1eQu/dYkT90IsS2CBcadsSUH9uC7E92aQHSKp2oGlBX50FEtv0OQga
	 OUImeyBo42PbnimuagIXKycb+qAHdeE+q7XL0AhDeoAdmXd2IsC7Eboa5Ly43Z/0ES
	 s5URfUOBixldA==
Date: Thu, 19 Dec 2024 10:02:08 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/10] iomap: add a IOMAP_F_ANON_WRITE flag
Message-ID: <20241219180208.GC6156@frogsfrogsfrogs>
References: <20241219173954.22546-1-hch@lst.de>
 <20241219173954.22546-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219173954.22546-4-hch@lst.de>

On Thu, Dec 19, 2024 at 05:39:08PM +0000, Christoph Hellwig wrote:
> Add a IOMAP_F_ANON_WRITE flag that indicates that the write I/O does not
> have a target block assigned to it yet at iomap time and the file system
> will do that in the bio submission handler, splitting the I/O as needed.
> 
> This is used to implement Zone Append based I/O for zoned XFS, where
> splitting writes to the hardware limits and assigning a zone to them
> happens just before sending the I/O off to the block layer, but could
> also be useful for other things like compressed I/O.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/filesystems/iomap/design.rst |  4 ++++
>  fs/iomap/buffered-io.c                     | 13 +++++++++----
>  fs/iomap/direct-io.c                       |  6 ++++--
>  include/linux/iomap.h                      |  7 +++++++
>  4 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/filesystems/iomap/design.rst b/Documentation/filesystems/iomap/design.rst
> index b0d0188a095e..28ab3758c474 100644
> --- a/Documentation/filesystems/iomap/design.rst
> +++ b/Documentation/filesystems/iomap/design.rst
> @@ -246,6 +246,10 @@ The fields are as follows:
>     * **IOMAP_F_PRIVATE**: Starting with this value, the upper bits can
>       be set by the filesystem for its own purposes.
>  
> +   * **IOMAP_F_ANON_WRITE**: Indicates that (write) I/O does not have a target
> +     block assigned to it yet and the file system will do that in the bio
> +     submission handler, splitting the I/O as needed.
> +
>     These flags can be set by iomap itself during file operations.
>     The filesystem should supply an ``->iomap_end`` function if it needs
>     to observe these flags:
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 3176dc996fb7..8c18fb2a82e0 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1691,10 +1691,14 @@ static int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
>  	 * failure happened so that the file system end I/O handler gets called
>  	 * to clean up.
>  	 */
> -	if (wpc->ops->submit_ioend)
> +	if (wpc->ops->submit_ioend) {
>  		error = wpc->ops->submit_ioend(wpc, error);
> -	else if (!error)
> -		submit_bio(&wpc->ioend->io_bio);
> +	} else {
> +		if (WARN_ON_ONCE(wpc->iomap.flags & IOMAP_F_ANON_WRITE))
> +			error = -EIO;
> +		if (!error)
> +			submit_bio(&wpc->ioend->io_bio);
> +	}
>  
>  	if (error) {
>  		wpc->ioend->io_bio.bi_status = errno_to_blk_status(error);
> @@ -1744,7 +1748,8 @@ static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
>  		return false;
>  	if (pos != wpc->ioend->io_offset + wpc->ioend->io_size)
>  		return false;
> -	if (iomap_sector(&wpc->iomap, pos) !=
> +	if (!(wpc->iomap.flags & IOMAP_F_ANON_WRITE) &&
> +	    iomap_sector(&wpc->iomap, pos) !=
>  	    bio_end_sector(&wpc->ioend->io_bio))
>  		return false;
>  	/*
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index b521eb15759e..641649a04614 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -81,10 +81,12 @@ static void iomap_dio_submit_bio(const struct iomap_iter *iter,
>  		WRITE_ONCE(iocb->private, bio);
>  	}
>  
> -	if (dio->dops && dio->dops->submit_io)
> +	if (dio->dops && dio->dops->submit_io) {
>  		dio->dops->submit_io(iter, bio, pos);
> -	else
> +	} else {
> +		WARN_ON_ONCE(iter->iomap.flags & IOMAP_F_ANON_WRITE);
>  		submit_bio(bio);

Do we need to error the bio instead of submitting it if
IOMAP_F_ANON_WRITE is set here?  Or are we relying on the block
layer/device will reject an IO to U64_MAX and produce the EIO for us?

If yes, then that's acceptagble to me
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +	}
>  }
>  
>  ssize_t iomap_dio_complete(struct iomap_dio *dio)
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 31857d4750a9..36a7298b6cea 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -56,6 +56,10 @@ struct vm_fault;
>   *
>   * IOMAP_F_BOUNDARY indicates that I/O and I/O completions for this iomap must
>   * never be merged with the mapping before it.
> + *
> + * IOMAP_F_ANON_WRITE indicates that (write) I/O does not have a target block
> + * assigned to it yet and the file system will do that in the bio submission
> + * handler, splitting the I/O as needed.
>   */
>  #define IOMAP_F_NEW		(1U << 0)
>  #define IOMAP_F_DIRTY		(1U << 1)
> @@ -68,6 +72,7 @@ struct vm_fault;
>  #endif /* CONFIG_BUFFER_HEAD */
>  #define IOMAP_F_XATTR		(1U << 5)
>  #define IOMAP_F_BOUNDARY	(1U << 6)
> +#define IOMAP_F_ANON_WRITE	(1U << 7)
>  
>  /*
>   * Flags set by the core iomap code during operations:
> @@ -111,6 +116,8 @@ struct iomap {
>  
>  static inline sector_t iomap_sector(const struct iomap *iomap, loff_t pos)
>  {
> +	if (iomap->flags & IOMAP_F_ANON_WRITE)
> +		return U64_MAX; /* invalid */
>  	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
>  }
>  
> -- 
> 2.45.2
> 
> 

