Return-Path: <linux-fsdevel+bounces-29757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5164A97D703
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 16:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8490A1C227AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 14:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F6517BB06;
	Fri, 20 Sep 2024 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTrRzphM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D36F17BB32;
	Fri, 20 Sep 2024 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726843139; cv=none; b=AuHDHnLDDtBMLt3/klXiBYlFKEHBM/FUFfEyV5XKv6ut/05tYft1YFmvYZM+BqO08iHBn/Hk93nU6mKOhfRBnRYZ4Xwjw5UBr2h+ssdRyKxjyX+4ezGYyI3pgTcLQWP0ldIxArFFZ3JELasRz2g6ZcXgoLMIOwrlzdCho0sStf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726843139; c=relaxed/simple;
	bh=Gu9rDX3lW2aCKmolRq+5so7e+yAWoJNT0vz3eQ1Bnw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGy0pi3xTZZ/m5uoQx0O4gEirEEsWMWLtRSBnrSY69WfQx7jmL1zTOPZBdMbhMUUwGSHbcvLVYbX7YgQeF6eHvf03UwZuHLiQvGUptaPSHRj40FmCMlLOMfTeJu00sxdz76CpxWXJZ1ezLJlPm/Z4ZD6AD4lecxkQnaFNY8t5T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTrRzphM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0234DC4CEC3;
	Fri, 20 Sep 2024 14:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726843139;
	bh=Gu9rDX3lW2aCKmolRq+5so7e+yAWoJNT0vz3eQ1Bnw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fTrRzphMFNSX+h8tkt3hFP2gPjmqWOjRZOsC+FIh+DW6vseaphocVxHWX+GtYUqqv
	 nIkXzNN6/o6UKMccXphYWPR8K+ph2kKFETlidubWDtsniBm10zpPNLbU34067hx8rW
	 PwGEk2M7BccKUAkAhnQiTtbBGvi5+Hu/j/grLJ4T5mTBeJPTAuwCE27VZWd57Pm2p3
	 HJR/Ebc8DwOb96vD64YOdle6OB7GYutqIAI+hFBWd7O8ulAMQpsvpvRkF27WAI+t7j
	 tMhwdRMwr+s5oGCexMsT/kcdZbK9NXRQQAFz6mGZ6AHYH8yC+yGyMkHdRLAyQW/NdX
	 M2J9cdP/U3Saw==
Date: Fri, 20 Sep 2024 07:38:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	stable@vger.kernel.org,
	syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com,
	Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/3] vfs: Fix implicit conversion problem when testing
 overflow case
Message-ID: <20240920143858.GC21853@frogsfrogsfrogs>
References: <20240920122851.215641-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920122851.215641-1-sunjunchao2870@gmail.com>

On Fri, Sep 20, 2024 at 08:28:51PM +0800, Julian Sun wrote:
> The overflow check in generic_copy_file_checks() and generic_remap_checks()
> is now broken because the result of the addition is implicitly converted to
> an unsigned type, which disrupts the comparison with signed numbers.
> This caused the kernel to not return EOVERFLOW in copy_file_range()
> call with len is set to 0xffffffffa003e45bul.
> 
> Use the check_add_overflow() macro to fix this issue.
> 
> Reported-and-tested-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=296b1c84b9cbf306e5a0
> Fixes: 1383a7ed6749 ("vfs: check file ranges before cloning files")
> Fixes: 96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
> Inspired-by: Dave Chinner <david@fromorbit.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/read_write.c  | 5 +++--
>  fs/remap_range.c | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 070a7c33b9dd..5211246edc2e 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1509,7 +1509,7 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>  	struct inode *inode_in = file_inode(file_in);
>  	struct inode *inode_out = file_inode(file_out);
>  	uint64_t count = *req_count;
> -	loff_t size_in;
> +	loff_t size_in, tmp;
>  	int ret;
>  
>  	ret = generic_file_rw_checks(file_in, file_out);
> @@ -1544,7 +1544,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>  		return -ETXTBSY;
>  
>  	/* Ensure offsets don't wrap. */
> -	if (pos_in + count < pos_in || pos_out + count < pos_out)
> +	if (check_add_overflow(pos_in, count, &tmp) ||
> +	    check_add_overflow(pos_out, count, &tmp))
>  		return -EOVERFLOW;
>  
>  	/* Shorten the copy to EOF */
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index 28246dfc8485..6fdeb3c8cb70 100644
> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -36,7 +36,7 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
>  	struct inode *inode_out = file_out->f_mapping->host;
>  	uint64_t count = *req_count;
>  	uint64_t bcount;
> -	loff_t size_in, size_out;
> +	loff_t size_in, size_out, tmp;
>  	loff_t bs = inode_out->i_sb->s_blocksize;
>  	int ret;
>  
> @@ -45,7 +45,8 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
>  		return -EINVAL;
>  
>  	/* Ensure offsets don't wrap. */
> -	if (pos_in + count < pos_in || pos_out + count < pos_out)
> +	if (check_add_overflow(pos_in, count, &tmp) ||
> +	    check_add_overflow(pos_out, count, &tmp))
>  		return -EINVAL;
>  
>  	size_in = i_size_read(inode_in);
> -- 
> 2.39.2
> 
> 

