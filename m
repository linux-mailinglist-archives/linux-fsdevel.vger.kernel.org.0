Return-Path: <linux-fsdevel+bounces-35158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5856A9D1BC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 00:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD6C3B21E9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 23:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB52197552;
	Mon, 18 Nov 2024 23:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8KIVlVZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF159147C71;
	Mon, 18 Nov 2024 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731971722; cv=none; b=U6q4VO0WDJihwt0bzc4kZISluXR3uzucRR1I7kdWtlrfKt7X+xhdyT5VjUzYF6rM48kZrwDuljC487XRCE4gkOAFHvBUpVxUv0b7Jh2wv/vrvb3mYRYLs1wavY8pRFjm9BXBfA8O2GrQmSkCAIVR3uXS2ahiaIOT2/hjDzIedj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731971722; c=relaxed/simple;
	bh=xEkqWzgqeMIkvdQHPZg4p3xgSfo/UinTqXhG8KrlTWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjLU7yF/3q46axp271lsAYw4IIRC+x6MlRnqYrVg8PpLDxUqk3NbHRqMo/fNBh+iGTTZh/QzzcQcWE7AZiLfGCUlKsTAPWQFxYYFMWNu+Ri2mV4DjjJc904W8y0q0tEujib8Cqo/v0RgcOVbaEw7UbM/bJbcRyjO0JAZPb6NynM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8KIVlVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5926FC4CECC;
	Mon, 18 Nov 2024 23:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731971722;
	bh=xEkqWzgqeMIkvdQHPZg4p3xgSfo/UinTqXhG8KrlTWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F8KIVlVZBovIunuQBDOqCmTUgu5pJ24G3oQgN7rX0lzjnhvEJVYd1FDG1Hsmqm4n7
	 K4dlQ0+x7sHql2UbeM8jReXxyS2DWjwGXcwSeBhxaWCMLDinCMlVT10wpS8xURtSjP
	 s7M8pUfmoYBfvPHbJvRYpvpnDjzqRN1ODFDJTtZAesCm3dqaeeoCdNzoFhM61B3s5w
	 7m9L7EhPHv6Ogq2sLknXCuFBaPA40OozG6Hze/mMrlxO/kxV6oALSjAMaCV7bq+C3Q
	 uA45Z/hJeDQpi75BeykQ0P1SL4kk6PF6XihascA4z66pX5PQscQvYfN0sP8ch/k7e5
	 Uj/PTpfnPpnVg==
Date: Mon, 18 Nov 2024 15:15:21 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	hch@infradead.org, david@fromorbit.com, zokeefe@google.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: Re: [PATCH 03/27] ext4: don't write back data before punch hole in
 nojournal mode
Message-ID: <20241118231521.GA9417@frogsfrogsfrogs>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022111059.2566137-4-yi.zhang@huaweicloud.com>

On Tue, Oct 22, 2024 at 07:10:34PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> There is no need to write back all data before punching a hole in
> data=ordered|writeback mode since it will be dropped soon after removing
> space, so just remove the filemap_write_and_wait_range() in these modes.
> However, in data=journal mode, we need to write dirty pages out before
> discarding page cache in case of crash before committing the freeing
> data transaction, which could expose old, stale data.

Can't the same thing happen with non-journaled data writes?

Say you write 1GB of "A"s to a file and fsync.  Then you write "B"s to
the same 1GB of file and immediately start punching it.  If the system
reboots before the mapping updates all get written to disk, won't you
risk seeing some of those "A" because we no longer flush the "B"s?

Also, since the program didn't explicitly fsync the Bs, why bother
flushing the dirty data at all?  Are data=journal writes supposed to be
synchronous flushing writes nowadays?

--D

> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/inode.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index f8796f7b0f94..94b923afcd9c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3965,17 +3965,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  
>  	trace_ext4_punch_hole(inode, offset, length, 0);
>  
> -	/*
> -	 * Write out all dirty pages to avoid race conditions
> -	 * Then release them.
> -	 */
> -	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
> -		ret = filemap_write_and_wait_range(mapping, offset,
> -						   offset + length - 1);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	inode_lock(inode);
>  
>  	/* No need to punch hole beyond i_size */
> @@ -4037,6 +4026,21 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  		ret = ext4_update_disksize_before_punch(inode, offset, length);
>  		if (ret)
>  			goto out_dio;
> +
> +		/*
> +		 * For journalled data we need to write (and checkpoint) pages
> +		 * before discarding page cache to avoid inconsitent data on
> +		 * disk in case of crash before punching trans is committed.
> +		 */
> +		if (ext4_should_journal_data(inode)) {
> +			ret = filemap_write_and_wait_range(mapping,
> +					first_block_offset, last_block_offset);
> +			if (ret)
> +				goto out_dio;
> +		}
> +
> +		ext4_truncate_folios_range(inode, first_block_offset,
> +					   last_block_offset + 1);
>  		truncate_pagecache_range(inode, first_block_offset,
>  					 last_block_offset);
>  	}
> -- 
> 2.46.1
> 
> 

