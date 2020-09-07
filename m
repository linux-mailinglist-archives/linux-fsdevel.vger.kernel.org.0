Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C225C25F682
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 11:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgIGJco (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 05:32:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:34174 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgIGJcn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 05:32:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6BCDDAD1E;
        Mon,  7 Sep 2020 09:32:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4978F1E12D1; Mon,  7 Sep 2020 11:32:41 +0200 (CEST)
Date:   Mon, 7 Sep 2020 11:32:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, khazhy@google.com, kernel@collabora.com
Subject: Re: [PATCH v3 1/3] direct-io: clean up error paths of
 do_blockdev_direct_IO
Message-ID: <20200907093241.GD16559@quack2.suse.cz>
References: <20200905052023.3719585-1-krisman@collabora.com>
 <20200905052023.3719585-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905052023.3719585-2-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 05-09-20 01:20:21, Gabriel Krisman Bertazi wrote:
> In preparation to resort DIO checks, reduce code duplication of error
> handling in do_blockdev_direct_IO.
> 
> Changes since V1:
>   - Remove fail_dio_unlocked (Me)
>   - Ensure fail_dio won't call inode_unlock() for writes (Jan Kara)

Please add the patch changelogs below the diffstat. That way they won't be
in the final changelog (which is the right thing to do because they are
mostly irrelevant for the final patch).

Otherwise the patch looks good to me so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza 

> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/direct-io.c | 35 ++++++++++++++---------------------
>  1 file changed, 14 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 183299892465..6c11db1cec27 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -1170,7 +1170,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  			blkbits = blksize_bits(bdev_logical_block_size(bdev));
>  		blocksize_mask = (1 << blkbits) - 1;
>  		if (align & blocksize_mask)
> -			goto out;
> +			return -EINVAL;
>  	}
>  
>  	/* watch out for a 0 len io from a tricksy fs */
> @@ -1178,9 +1178,8 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  		return 0;
>  
>  	dio = kmem_cache_alloc(dio_cache, GFP_KERNEL);
> -	retval = -ENOMEM;
>  	if (!dio)
> -		goto out;
> +		return -ENOMEM;
>  	/*
>  	 * Believe it or not, zeroing out the page array caused a .5%
>  	 * performance regression in a database benchmark.  So, we take
> @@ -1199,22 +1198,16 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  
>  			retval = filemap_write_and_wait_range(mapping, offset,
>  							      end - 1);
> -			if (retval) {
> -				inode_unlock(inode);
> -				kmem_cache_free(dio_cache, dio);
> -				goto out;
> -			}
> +			if (retval)
> +				goto fail_dio;
>  		}
>  	}
>  
>  	/* Once we sampled i_size check for reads beyond EOF */
>  	dio->i_size = i_size_read(inode);
>  	if (iov_iter_rw(iter) == READ && offset >= dio->i_size) {
> -		if (dio->flags & DIO_LOCKING)
> -			inode_unlock(inode);
> -		kmem_cache_free(dio_cache, dio);
>  		retval = 0;
> -		goto out;
> +		goto fail_dio;
>  	}
>  
>  	/*
> @@ -1258,14 +1251,8 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  			 */
>  			retval = sb_init_dio_done_wq(dio->inode->i_sb);
>  		}
> -		if (retval) {
> -			/*
> -			 * We grab i_mutex only for reads so we don't have
> -			 * to release it here
> -			 */
> -			kmem_cache_free(dio_cache, dio);
> -			goto out;
> -		}
> +		if (retval)
> +			goto fail_dio;
>  	}
>  
>  	/*
> @@ -1368,7 +1355,13 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  	} else
>  		BUG_ON(retval != -EIOCBQUEUED);
>  
> -out:
> +	return retval;
> +
> +fail_dio:
> +	if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ)
> +		inode_unlock(inode);
> +
> +	kmem_cache_free(dio_cache, dio);
>  	return retval;
>  }
>  
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
