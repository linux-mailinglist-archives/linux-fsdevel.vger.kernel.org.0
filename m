Return-Path: <linux-fsdevel+bounces-56287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F11B15547
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 00:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21423548205
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 22:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F87E28540B;
	Tue, 29 Jul 2025 22:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V87AaQnR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F32284B57;
	Tue, 29 Jul 2025 22:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753828057; cv=none; b=Zxn5/qn1bh9Nb3gSORK46ObtCPnduBwkGzPFhDoYpmmXRnZ2LH0isS3AJ35oHcT3YmoLBzw7sa0xrlrFc9rEAN6qwWyF7mdJSMBqgEYYdCXi3HnaUaU7UEB/DZ+/QsG/NpjMdAMyaSUzdbfOPAEMCjGukDZzLRgUz0Jl4Ljaz2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753828057; c=relaxed/simple;
	bh=ilIC/Xh3dKvQ/r+z4/db5xNANAkWnJC3gTHoZWT0e00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6d6oCUuZpRgnEI75229Ii0uyR+tkRXurRSpBiLK7ODqYEn7fDUrRBMBPDSxFZbmdkc3EtgJDmAdrVGkE8NkfKnbSAAwYNfxwB7i8SUvXfokHwQ5rlF/sJ0NpXr8uucCt0wF3rF/lllsFRN9wwtikYEGQYzNLomdIY3MVVtvrYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V87AaQnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188BFC4CEEF;
	Tue, 29 Jul 2025 22:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753828057;
	bh=ilIC/Xh3dKvQ/r+z4/db5xNANAkWnJC3gTHoZWT0e00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V87AaQnRDQiOFyZENrx7DEz6V3x61WM72x50pr4SCg4nj7YV50wjqMYzp7LR4kVab
	 CeMiywL9jrY2oeuStkvw8wG5+KQwdkaP27h07gR8ymsu3MHYflHezmbiYD8KMgsqK2
	 zl8xDhquo3YVhJ1STbz5UMFDCLE4bY4n4DkTruOXD6KRlFBG4QAzqkQ1ytwB850fmP
	 bc6driid+uNO1oAqGuwG29GUx+732CapAB/JtYJ7TCFmVdnCFGSW0vF62kJbhGRqT4
	 viXbE4WwTHaqA4i2M3CY7G3shOBCvIquQYR2AcZfm4m5kSMslvwiyH1mazE5pFgbv8
	 BfM6grZc1zaQw==
Date: Tue, 29 Jul 2025 15:27:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, david@fromorbit.com, ebiggers@kernel.org,
	hch@lst.de, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 20/29] xfs: disable preallocations for fsverity
 Merkle tree writes
Message-ID: <20250729222736.GK2672049@frogsfrogsfrogs>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-20-9e5443af0e34@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-fsverity-v1-20-9e5443af0e34@kernel.org>

On Mon, Jul 28, 2025 at 10:30:24PM +0200, Andrey Albershteyn wrote:
> While writing Merkle tree, file is read-only and there's no further
> writes except Merkle tree building. The file is truncated beforehand to
> remove any preallocated extents.
> 
> The Merkle tree is the only data XFS will write. As we don't want XFS to
> truncate file after we done writing, let's also skip truncation on
> fsverity files. Therefore, we also need to disable preallocations while
> writing merkle tree as we don't want any unused extents past the tree.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/xfs/xfs_iomap.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index ff05e6b1b0bb..00ec1a738b39 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -32,6 +32,8 @@
>  #include "xfs_rtbitmap.h"
>  #include "xfs_icache.h"
>  #include "xfs_zone_alloc.h"
> +#include "xfs_fsverity.h"
> +#include <linux/fsverity.h>

What do these includes pull in for the iflags tests below?

>  #define XFS_ALLOC_ALIGN(mp, off) \
>  	(((off) >> mp->m_allocsize_log) << mp->m_allocsize_log)
> @@ -1849,7 +1851,9 @@ xfs_buffered_write_iomap_begin(
>  		 * Determine the initial size of the preallocation.
>  		 * We clean up any extra preallocation when the file is closed.
>  		 */
> -		if (xfs_has_allocsize(mp))
> +		if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
> +			prealloc_blocks = 0;
> +		else if (xfs_has_allocsize(mp))
>  			prealloc_blocks = mp->m_allocsize_blocks;
>  		else if (allocfork == XFS_DATA_FORK)
>  			prealloc_blocks = xfs_iomap_prealloc_size(ip, allocfork,
> @@ -1976,6 +1980,13 @@ xfs_buffered_write_iomap_end(
>  	if (flags & IOMAP_FAULT)
>  		return 0;
>  
> +	/*
> +	 * While writing Merkle tree to disk we would not have any other
> +	 * delayed allocations
> +	 */
> +	if (xfs_iflags_test(XFS_I(inode), XFS_VERITY_CONSTRUCTION))
> +		return 0;

I assume XFS_VERITY_CONSTRUCTION doesn't get set until after we've
locked the inode, flushed the dirty pagecache, and truncated the file to
EOF?  In which case I guess this is ok -- we're never going to have new
delalloc reservations, and verity data can't be straddling the EOF
folio, no matter how large it is.  Right?

--D

> +
>  	/* Nothing to do if we've written the entire delalloc extent */
>  	start_byte = iomap_last_written_block(inode, offset, written);
>  	end_byte = round_up(offset + length, i_blocksize(inode));
> 
> -- 
> 2.50.0
> 
> 

