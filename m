Return-Path: <linux-fsdevel+bounces-19693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7A88C8BE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 19:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1771C22713
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 17:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D7013E038;
	Fri, 17 May 2024 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U31g4s4X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E512C492;
	Fri, 17 May 2024 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715968741; cv=none; b=I0cXRAJTmLDyanMdmvTql6U9gviqXhg3PR98I7dsteuqZHzD6PjuJeVXE1akTXKpliB4o13FWnEYh7uiP8N2eyEEQIDu37oITh6Ut5qorl0gTZfSfqhw0M44JyRolmLO3Wt7Z5D74Ra1xmxpSZVphGifqcCk9xsDUzK7yNYwUwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715968741; c=relaxed/simple;
	bh=pKB07h4tYYQycvmYl0AAJgDHfhFWfWr/tJd2D4E2uEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UA0SL4ByrqYVSMkfjEaM3LqxVEwU0aim4ke/Cf6zUqotUV4RpuA+CRX8YXSk7s/WISO3R/S2VitbT6OPVgWrrwDC23osQjDs18iftq/+21dY6D0wwUVVL/nqHP2Co34Kq3uxBIeoJ8GhXaz9/fsZg5xObZjC7Qtj0WA01VkNZtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U31g4s4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A92C2BD10;
	Fri, 17 May 2024 17:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715968741;
	bh=pKB07h4tYYQycvmYl0AAJgDHfhFWfWr/tJd2D4E2uEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U31g4s4XCO5YTLBcwQ7q82QmZmEBAxjcSq8FwCtOiIhJOR8Q/dnJJEzFeFly6SwKA
	 qF0AwCq+MLkmsGGcbjv+QQu3P8Ndj3wob1NKChP9+LqBP3ne+1gcliI+Qx5kmmlFI8
	 sYPpqr5StZ+FfHsRAQA5gi7aWfF3Q8G/QdWZsbkcYMGz7Q6UMrHwSIVkjoI934ICt2
	 InEamXPV/GYar8V5FatSI4kb+Pm9WRNLmJvdg1319diM+wZbl6BfegwT3fwzQ6T7wK
	 eKHVzxhUwD9NbQmuki4gf+3sgQT9q4TXBV26tiigDFVxGg7+X1s92jvOv3oqqdano9
	 XCnak9gvigYyQ==
Date: Fri, 17 May 2024 10:59:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
	hch@infradead.org, brauner@kernel.org, david@fromorbit.com,
	chandanbabu@kernel.org, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 3/3] xfs: correct the zeroing truncate range
Message-ID: <20240517175900.GC360919@frogsfrogsfrogs>
References: <20240517111355.233085-1-yi.zhang@huaweicloud.com>
 <20240517111355.233085-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517111355.233085-4-yi.zhang@huaweicloud.com>

On Fri, May 17, 2024 at 07:13:55PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When truncating a realtime file unaligned to a shorter size,
> xfs_setattr_size() only flush the EOF page before zeroing out, and
> xfs_truncate_page() also only zeros the EOF block. This could expose
> stale data since 943bc0882ceb ("iomap: don't increase i_size if it's not
> a write operation").
> 
> If the sb_rextsize is bigger than one block, and we have a realtime
> inode that contains a long enough written extent. If we unaligned
> truncate into the middle of this extent, xfs_itruncate_extents() could
> split the extent and align the it's tail to sb_rextsize, there maybe
> have more than one blocks more between the end of the file. Since
> xfs_truncate_page() only zeros the trailing portion of the i_blocksize()
> value, so it may leftover some blocks contains stale data that could be
> exposed if we append write it over a long enough distance later.

IOWs, any time we truncate down, we need to zero every byte from the new
EOF all the way to the end of the allocation unit, correct?

Maybe pictures would be easier to reason with.  Say you have
rextsize=30 and a partially written rtextent; each 'W' is a written
fsblock and 'u' is an unwritten fsblock:

WWWWWWWWWWWWWWWWWWWWWuuuuuuuuu
                    ^ old EOF

Now you want to truncate down:

WWWWWWWWWWWWWWWWWWWWWuuuuuuuuu
     ^ new EOF      ^ old EOF

Currently, iomap_truncate_blocks only zeroes up to the next i_blocksize,
so the truncate leaves the file in this state:

WWWWWzWWWWWWWWWWWWWWWuuuuuuuuu
     ^ new EOF      ^ old EOF

(where 'z' is a written block with zeroes after EOF)

This is bad because the "W"s between the new and old EOF still contain
old credit card info or whatever.  Now if we mmap the file or whatever,
we can access those old contents.

So your new patch amends iomap_truncate_page so that it'll zero all the
way to the end of the @blocksize parameter.  That fixes the exposure by 
writing zeroes to the pagecache before we truncate down:

WWWWWzzzzzzzzzzzzzzzzuuuuuuuuu
     ^ new EOF      ^ old EOF

Is that correct?

If so, then why don't we make xfs_truncate_page convert the post-eof
rtextent blocks back to unwritten status:

WWWWWzuuuuuuuuuuuuuuuuuuuuuuuu
     ^ new EOF      ^ old EOF

If we can do that, then do we need the changes to iomap_truncate_page?
Converting the mapping should be much faster than dirtying potentially
a lot of data (rt extents can be 1GB in size).

> xfs_truncate_page() should flush, zeros out the entire rtextsize range,
> and make sure the entire zeroed range have been flushed to disk before
> updating the inode size.
> 
> Fixes: 943bc0882ceb ("iomap: don't increase i_size if it's not a write operation")
> Reported-by: Chandan Babu R <chandanbabu@kernel.org>
> Link: https://lore.kernel.org/linux-xfs/0b92a215-9d9b-3788-4504-a520778953c2@huaweicloud.com
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/xfs/xfs_iomap.c | 35 +++++++++++++++++++++++++++++++----
>  fs/xfs/xfs_iops.c  | 10 ----------
>  2 files changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 4958cc3337bc..fc379450fe74 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1466,12 +1466,39 @@ xfs_truncate_page(
>  	loff_t			pos,
>  	bool			*did_zero)
>  {
> +	struct xfs_mount	*mp = ip->i_mount;
>  	struct inode		*inode = VFS_I(ip);
>  	unsigned int		blocksize = i_blocksize(inode);
> +	int			error;
> +
> +	if (XFS_IS_REALTIME_INODE(ip))
> +		blocksize = XFS_FSB_TO_B(mp, mp->m_sb.sb_rextsize);

Don't opencode xfs_inode_alloc_unitsize, please.

> +
> +	/*
> +	 * iomap won't detect a dirty page over an unwritten block (or a
> +	 * cow block over a hole) and subsequently skips zeroing the
> +	 * newly post-EOF portion of the page. Flush the new EOF to
> +	 * convert the block before the pagecache truncate.
> +	 */
> +	error = filemap_write_and_wait_range(inode->i_mapping, pos,
> +					     roundup_64(pos, blocksize));
> +	if (error)
> +		return error;pos_in_block

Ok so this is hoisting the filemap_write_and_wait_range call from
xfs_setattr_size.  It's curious that we need to need to twiddle anything
other than the EOF block itself though?

>  
>  	if (IS_DAX(inode))
> -		return dax_truncate_page(inode, pos, blocksize, did_zero,
> -					&xfs_dax_write_iomap_ops);
> -	return iomap_truncate_page(inode, pos, blocksize, did_zero,
> -				   &xfs_buffered_write_iomap_ops);
> +		error = dax_truncate_page(inode, pos, blocksize, did_zero,
> +					  &xfs_dax_write_iomap_ops);
> +	else
> +		error = iomap_truncate_page(inode, pos, blocksize, did_zero,
> +					    &xfs_buffered_write_iomap_ops);
> +	if (error)
> +		return error;
> +
> +	/*
> +	 * Write back path won't write dirty blocks post EOF folio,
> +	 * flush the entire zeroed range before updating the inode
> +	 * size.
> +	 */
> +	return filemap_write_and_wait_range(inode->i_mapping, pos,
> +					    roundup_64(pos, blocksize));

...but what is the purpose of the second filemap_write_and_wait_range
call?  Is that to flush the bytes between new and old EOF to disk before
truncate_setsize invalidates the (zeroed) pagecache?

--D

>  }
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 66f8c47642e8..baeeddf4a6bb 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -845,16 +845,6 @@ xfs_setattr_size(
>  		error = xfs_zero_range(ip, oldsize, newsize - oldsize,
>  				&did_zeroing);
>  	} else {
> -		/*
> -		 * iomap won't detect a dirty page over an unwritten block (or a
> -		 * cow block over a hole) and subsequently skips zeroing the
> -		 * newly post-EOF portion of the page. Flush the new EOF to
> -		 * convert the block before the pagecache truncate.
> -		 */
> -		error = filemap_write_and_wait_range(inode->i_mapping, newsize,
> -						     newsize);
> -		if (error)
> -			return error;
>  		error = xfs_truncate_page(ip, newsize, &did_zeroing);
>  	}
>  
> -- 
> 2.39.2
> 
> 

