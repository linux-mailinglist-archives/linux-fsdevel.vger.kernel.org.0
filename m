Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A27D1E9BCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 13:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfJ3Mtk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 08:49:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:53752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbfJ3Mtk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 08:49:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B00F5B3F5;
        Wed, 30 Oct 2019 12:49:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B313A1E485C; Wed, 30 Oct 2019 13:49:35 +0100 (CET)
Date:   Wed, 30 Oct 2019 13:49:35 +0100
From:   Jan Kara <jack@suse.cz>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fs: keep dio_warn_stale_pagecache() when CONFIG_BLOCK=n
Message-ID: <20191030124935.GL28525@quack2.suse.cz>
References: <157242307298.5840.14949889649221596095.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157242307298.5840.14949889649221596095.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 30-10-19 11:11:13, Konstantin Khlebnikov wrote:
> This helper prints warning if direct I/O write failed to invalidate cache.
> Direct I/O is supported by non-disk filesystems, for example NFS.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Link: https://lore.kernel.org/lkml/201910300824.UIo56oC7%25lkp@intel.com/

Well, but this patch doesn't quite make sense without your other patch so
it would make sense to explain that in the changelog and make this patch
1/2 while the other patch will be 2/2? Otherwise those changes make sense
to me.

								Honza

> ---
>  fs/direct-io.c     |   21 ---------------------
>  include/linux/fs.h |    6 +++++-
>  mm/filemap.c       |   21 +++++++++++++++++++++
>  3 files changed, 26 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 9329ced91f1d..0ec4f270139f 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -220,27 +220,6 @@ static inline struct page *dio_get_page(struct dio *dio,
>  	return dio->pages[sdio->head];
>  }
>  
> -/*
> - * Warn about a page cache invalidation failure during a direct io write.
> - */
> -void dio_warn_stale_pagecache(struct file *filp)
> -{
> -	static DEFINE_RATELIMIT_STATE(_rs, 86400 * HZ, DEFAULT_RATELIMIT_BURST);
> -	char pathname[128];
> -	struct inode *inode = file_inode(filp);
> -	char *path;
> -
> -	errseq_set(&inode->i_mapping->wb_err, -EIO);
> -	if (__ratelimit(&_rs)) {
> -		path = file_path(filp, pathname, sizeof(pathname));
> -		if (IS_ERR(path))
> -			path = "(unknown)";
> -		pr_crit("Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!\n");
> -		pr_crit("File: %s PID: %d Comm: %.20s\n", path, current->pid,
> -			current->comm);
> -	}
> -}
> -
>  /*
>   * dio_complete() - called when all DIO BIO I/O has been completed
>   *
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e0d909d35763..b4e4560d1c38 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3153,7 +3153,6 @@ enum {
>  };
>  
>  void dio_end_io(struct bio *bio);
> -void dio_warn_stale_pagecache(struct file *filp);
>  
>  ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  			     struct block_device *bdev, struct iov_iter *iter,
> @@ -3198,6 +3197,11 @@ static inline void inode_dio_end(struct inode *inode)
>  		wake_up_bit(&inode->i_state, __I_DIO_WAKEUP);
>  }
>  
> +/*
> + * Warn about a page cache invalidation failure diring a direct I/O write.
> + */
> +void dio_warn_stale_pagecache(struct file *filp);
> +
>  extern void inode_set_flags(struct inode *inode, unsigned int flags,
>  			    unsigned int mask);
>  
> diff --git a/mm/filemap.c b/mm/filemap.c
> index cdb8780a0758..d7394226f5ab 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3161,6 +3161,27 @@ int pagecache_write_end(struct file *file, struct address_space *mapping,
>  }
>  EXPORT_SYMBOL(pagecache_write_end);
>  
> +/*
> + * Warn about a page cache invalidation failure during a direct I/O write.
> + */
> +void dio_warn_stale_pagecache(struct file *filp)
> +{
> +	static DEFINE_RATELIMIT_STATE(_rs, 86400 * HZ, DEFAULT_RATELIMIT_BURST);
> +	char pathname[128];
> +	struct inode *inode = file_inode(filp);
> +	char *path;
> +
> +	errseq_set(&inode->i_mapping->wb_err, -EIO);
> +	if (__ratelimit(&_rs)) {
> +		path = file_path(filp, pathname, sizeof(pathname));
> +		if (IS_ERR(path))
> +			path = "(unknown)";
> +		pr_crit("Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!\n");
> +		pr_crit("File: %s PID: %d Comm: %.20s\n", path, current->pid,
> +			current->comm);
> +	}
> +}
> +
>  ssize_t
>  generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
>  {
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
