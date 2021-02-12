Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3F731995B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 05:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhBLEya (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 23:54:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:38920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhBLEy3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 23:54:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A360C64E6B;
        Fri, 12 Feb 2021 04:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613105628;
        bh=w+W+4jcsNvzGlG2xqLkXfZcesXxw+6R5aF7yQyuCYlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fufx1fqeM3hxebhjwZhWERVSes40YektvvD4MNwXAAaHX7C385bePfCf/ZYuf+fr4
         VjXQzDk1iYeuGWEzuh3XOVDeU0GMdvQMwGiE04pdTP8Ey2qvGFKniDXYZsVisDqE+b
         Gaw/ot58sSuu2limnbtJ8rm9aQ8gKKHtIzk9mSXVxeZo6gg2BJtx0XRHkUf0O3+H9u
         7V9PcHn1ODGg961t8rplR9yfXMxcWhKGvO37JStJYmu3u2f4ZXKG6FZFo5din2ZvxR
         2xem+jJDggvi8Wb7uFb8DW3YgGJXnDeBHZbITNgET4eugYTrSEGHkWfZwJd3+9rJJZ
         t/4ZUlL0taafQ==
Date:   Thu, 11 Feb 2021 20:53:47 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] vfs: Disallow copy_file_range on generated file
 systems
Message-ID: <20210212045347.GM7190@magnolia>
References: <20210212044405.4120619-1-drinkcat@chromium.org>
 <20210212124354.6.Idc9c3110d708aa0df9d8fe5a6246524dc8469dae@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212124354.6.Idc9c3110d708aa0df9d8fe5a6246524dc8469dae@changeid>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 12:44:05PM +0800, Nicolas Boichat wrote:
> copy_file_range (which calls generic_copy_file_checks) uses the
> inode file size to adjust the copy count parameter. This breaks
> with special filesystems like procfs/sysfs/debugfs/tracefs, where
> the file size appears to be zero, but content is actually returned
> when a read operation is performed. Other issues would also
> happen on partial writes, as the function would attempt to seek
> in the input file.
> 
> Use the newly introduced FS_GENERATED_CONTENT filesystem flag
> to return -EOPNOTSUPP: applications can then retry with a more
> usual read/write based file copy (the fallback code is usually
> already present to handle older kernels).
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> 
>  fs/read_write.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 0029ff2b0ca8..80322e89fb0a 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1485,6 +1485,9 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>  	if (flags != 0)
>  		return -EINVAL;
>  
> +	if (file_inode(file_in)->i_sb->s_type->fs_flags & FS_GENERATED_CONTENT)
> +		return -EOPNOTSUPP;

Why not declare a dummy copy_file_range_nop function that returns
EOPNOTSUPP and point all of these filesystems at it?

(Or, I guess in these days where function pointers are the enemy,
create a #define that is a cast of 0x1, and fix do_copy_file_range to
return EOPNOTSUPP if it sees that?)

--D

> +
>  	ret = generic_copy_file_checks(file_in, pos_in, file_out, pos_out, &len,
>  				       flags);
>  	if (unlikely(ret))
> -- 
> 2.30.0.478.g8a0d178c01-goog
> 
