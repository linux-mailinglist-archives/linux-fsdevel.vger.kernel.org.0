Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6B749F091
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 02:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345003AbiA1Beh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 20:34:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60976 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbiA1Beh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 20:34:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48E0AB8241E;
        Fri, 28 Jan 2022 01:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A24C340E4;
        Fri, 28 Jan 2022 01:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643333674;
        bh=syJ8YNq0jFqssCN+Fpn6CejIFER0XxHyJW+5cZh7qQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r4MmK2L91UnUY3Ju+lob6pGYrfuC4tFQze7/UdZcwtg0my1bI0HYZ/EGzcR2/0eYh
         5qWQkXkz6GQ99yyiTKsnnZ4hM95RpS6f7bdJAM5P56admAP3hc/ZCtXKNCnRVkrgES
         v2zuReXf7omP1BD/F2BPe0mg+8tbNoZzsZhdyhFKiYcIFiKTzLCcaIL+zbZB+jgKI2
         HaKelY2L0Vg6ndyDgX/aggsEHmYplzWVSHFk3KYEO4hj0B99GHfDlJ8bPCc2gICQtz
         XRdKz8lPe2Sew/3rSqRIVIUhmZZ9ob0Va5c0yw/atKn6Dw4IaoROTNoyJVls08WLFV
         3jQ5xdJOfRU/w==
Date:   Thu, 27 Jan 2022 17:34:31 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chao Yu <chao@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-nilfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        ceph-devel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/9] f2fs: change retry waiting for
 f2fs_write_single_data_page()
Message-ID: <YfNIJxirDBO/pcQQ@google.com>
References: <164325106958.29787.4865219843242892726.stgit@noble.brown>
 <164325158956.29787.7016948342209980097.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164325158956.29787.7016948342209980097.stgit@noble.brown>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/27, NeilBrown wrote:
> f2fs_write_single_data_page() can return -EAGAIN if it cannot get
> the cp_rwsem lock - it holds a page lock and so cannot wait for it.
> 
> Some code which calls f2fs_write_single_data_page() use
> congestion_wait() and then tries again.  congestion_wait() doesn't do
> anything useful as congestion is no longer tracked.  So this is just a
> simple sleep.
> 
> A better approach is it wait until the cp_rwsem lock can be taken - then
> try again.  There is certainly no point trying again *before* the lock
> can be taken.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/f2fs/compress.c |    6 +++---
>  fs/f2fs/data.c     |    9 ++++++---
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index d0c3aeba5945..58ff7f4b296c 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1505,9 +1505,9 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
>  				if (IS_NOQUOTA(cc->inode))
>  					return 0;
>  				ret = 0;
> -				cond_resched();
> -				congestion_wait(BLK_RW_ASYNC,
> -						DEFAULT_IO_TIMEOUT);
> +				/* Wait until we can get the lock, then try again. */
> +				f2fs_lock_op(F2FS_I_SB(cc->inode));
> +				f2fs_unlock_op(F2FS_I_SB(cc->inode));

Since checkpoint uses down_write(cp_rwsem), I'm not sure the write path is safe
and needs to wait for checkpoint. Can we just do io_schedule_timeout()?

>  				goto retry_write;
>  			}
>  			return ret;
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 8c417864c66a..1d2341163e2c 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3047,9 +3047,12 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  				} else if (ret == -EAGAIN) {
>  					ret = 0;
>  					if (wbc->sync_mode == WB_SYNC_ALL) {
> -						cond_resched();
> -						congestion_wait(BLK_RW_ASYNC,
> -							DEFAULT_IO_TIMEOUT);
> +						/* Wait until we can get the
> +						 * lock, then try again.
> +						 */
> +						f2fs_lock_op(F2FS_I_SB(mapping->host));
> +						f2fs_unlock_op(F2FS_I_SB(mapping->host));
> +
>  						goto retry_write;
>  					}
>  					goto next;
> 
