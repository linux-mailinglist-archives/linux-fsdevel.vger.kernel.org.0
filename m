Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D168830B1EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 22:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhBAVP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 16:15:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:49598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhBAVP1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 16:15:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DADAC64E93;
        Mon,  1 Feb 2021 21:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612214087;
        bh=+12SZWhnYLHVQXoyM8JEhPHmxp8rpI5hqw7Lr/VJTwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IM3u8UJyQXWTWzyffsTy3v/9hb82diHUejo1q3xfdHtaj8dtd25umUNVy9T8NPl15
         CZ3L/2aqcmlSGE988tNBwEwlyw+n0qMIYl6JBPm3AsgIPotsDK0RiFp7j7VwwEm9Br
         5eDg2EWD2iPYdVpMJ0+5+JrwTQgpaPco+zcagytLZsoN9DEZufsLgZYjLbklBmnFqO
         8t7XAkTke2whhr/VfKLNu1ovEYnvvJ7szPG3SoxFFor6PAWagcfR6AM6ZNrv7Khvc4
         OjGLQGXnfCz6j8HNmGlCKn7MgZgwhpY23eu60szZUudF82YvW2swrgiU7kWgPYFqOC
         zZW43OkJgaN6g==
Date:   Mon, 1 Feb 2021 13:14:46 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] vfs: generic_copy_file_checks should return EINVAL
 when source offset is beyond EOF
Message-ID: <20210201211446.GA7187@magnolia>
References: <20210201204952.74625-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201204952.74625-1-dai.ngo@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 01, 2021 at 03:49:52PM -0500, Dai Ngo wrote:
> Fix by returning -EINVAL instead of 0, per man page of copy_file_range,

Huh?  That's not what the manpage[1] says:

RETURN VALUE
       Upon successful completion, copy_file_range() will return the
number of bytes copied between files.  This could be less than the
length originally requested.  If the file offset of fd_in is at or past
the end of file, no bytes are copied, and copy_file_range() returns
zero.

--D

[1] https://man7.org/linux/man-pages/man2/copy_file_range.2.html#RETURN_VALUE

> when the requested range extends beyond the end of the source file.
> Problem was discovered by subtest inter11 of nfstest_ssc.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/read_write.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 75f764b43418..438c00910716 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1445,7 +1445,7 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>  	/* Shorten the copy to EOF */
>  	size_in = i_size_read(inode_in);
>  	if (pos_in >= size_in)
> -		count = 0;
> +		count = -EINVAL;
>  	else
>  		count = min(count, size_in - (uint64_t)pos_in);
>  
> -- 
> 2.9.5
> 
