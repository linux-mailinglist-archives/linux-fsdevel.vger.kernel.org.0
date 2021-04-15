Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F56A360704
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 12:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhDOKYi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 06:24:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:34034 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231531AbhDOKYh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:24:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 26D62AC6E;
        Thu, 15 Apr 2021 10:24:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C1E551F2B65; Thu, 15 Apr 2021 12:24:13 +0200 (CEST)
Date:   Thu, 15 Apr 2021 12:24:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     viro@zeniv.linux.org.uk, jack@suse.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        chao@kernel.org
Subject: Re: [PATCH] direct-io: use read lock for DIO_LOCKING flag
Message-ID: <20210415102413.GA25217@quack2.suse.cz>
References: <20210415094332.37231-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415094332.37231-1-yuchao0@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 15-04-21 17:43:32, Chao Yu wrote:
> 9902af79c01a ("parallel lookups: actual switch to rwsem") changes inode
> lock from mutex to rwsem, however, we forgot to adjust lock for
> DIO_LOCKING flag in do_blockdev_direct_IO(), so let's change to hold read
> lock to mitigate performance regression in the case of read DIO vs read DIO,
> meanwhile it still keeps original functionality of avoiding buffered access
> vs direct access.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>

Thanks for the patch but this is not safe. Originally we had exclusive lock
(with i_mutex), switching to rwsem doesn't change that requirement. It may
be OK for some filesystems to actually use shared acquisition of rwsem for
DIO reads but it is not clear that is fine for all filesystems (and I
suspect those filesystems that actually do care already don't use
DIO_LOCKING flag or were already converted to iomap_dio_rw()). So unless
you do audit of all filesystems using do_blockdev_direct_IO() with
DIO_LOCKING flag and make sure they are all fine with inode lock in shared
mode, this is a no-go.

								Honza

> ---
>  fs/direct-io.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index b2e86e739d7a..93ff912f2749 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -1166,7 +1166,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  	dio->flags = flags;
>  	if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ) {
>  		/* will be released by direct_io_worker */
> -		inode_lock(inode);
> +		inode_lock_shared(inode);
>  	}
>  
>  	/* Once we sampled i_size check for reads beyond EOF */
> @@ -1316,7 +1316,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  	 * of protecting us from looking up uninitialized blocks.
>  	 */
>  	if (iov_iter_rw(iter) == READ && (dio->flags & DIO_LOCKING))
> -		inode_unlock(dio->inode);
> +		inode_unlock_shared(dio->inode);
>  
>  	/*
>  	 * The only time we want to leave bios in flight is when a successful
> @@ -1341,7 +1341,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  
>  fail_dio:
>  	if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ)
> -		inode_unlock(inode);
> +		inode_unlock_shared(inode);
>  
>  	kmem_cache_free(dio_cache, dio);
>  	return retval;
> -- 
> 2.29.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
