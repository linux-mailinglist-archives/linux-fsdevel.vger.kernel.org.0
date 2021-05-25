Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BE8390AA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 22:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhEYUth (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 16:49:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229798AbhEYUtg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 16:49:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 279AC6140B;
        Tue, 25 May 2021 20:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621975686;
        bh=6LI8nXD4++dr3yyc1ORbVc5YQQSxmuG/HaJJYKgTcFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hH52FUkACUHkbGllGWKwrxKsRdd7iP1mxfk+a1siOZdVEI6kqEuJbPHskAt+ZHwN4
         ozrQSEp5tw5Gb6MwaHJvlGX7okhpBVC7kaKOPG0yeWWuiByjPqBcZ+iSdBNjfDr9dx
         jnXRndLPBuoUupxSSQVFzcb2TZSUXQLudpuvhwr5jjDe1vLlsryU6GO2yrRmtUkbU8
         CRQ0V0KAi8mlSP4V9Tho0unqQs0vlIvGF1Jx8i50zax3nIdKRsitXTY9wkG21d1Vep
         cyf5F4e0akiKk/6Jo4hg5uCCpY1XHtPn8Xiz1gtFWFGdIJ7JZPkbz23+Y+4M9fkHQh
         0hhvZ6suqaANQ==
Date:   Tue, 25 May 2021 13:48:05 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, ceph-devel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 04/13] mm: Add functions to lock invalidate_lock for two
 mappings
Message-ID: <20210525204805.GM202121@locust>
References: <20210525125652.20457-1-jack@suse.cz>
 <20210525135100.11221-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525135100.11221-4-jack@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 03:50:41PM +0200, Jan Kara wrote:
> Some operations such as reflinking blocks among files will need to lock
> invalidate_lock for two mappings. Add helper functions to do that.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  include/linux/fs.h |  6 ++++++
>  mm/filemap.c       | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 897238d9f1e0..e6f7447505f5 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -822,6 +822,12 @@ static inline void inode_lock_shared_nested(struct inode *inode, unsigned subcla
>  void lock_two_nondirectories(struct inode *, struct inode*);
>  void unlock_two_nondirectories(struct inode *, struct inode*);
>  
> +void filemap_invalidate_down_write_two(struct address_space *mapping1,
> +				       struct address_space *mapping2);
> +void filemap_invalidate_up_write_two(struct address_space *mapping1,

TBH I find myself wishing that the invalidate_lock used the same
lock/unlock style wrappers that we use for i_rwsem.

filemap_invalidate_lock(inode1->mapping);
filemap_invalidate_lock_two(inode1->i_mapping, inode2->i_mapping);

To be fair, I've never been able to keep straight that down means lock
and up means unlock.  Ah well, at least you didn't use "p" and "v".

Mechanically, the changes look ok to me.
Acked-by: Darrick J. Wong <djwong@kernel.org>

--D

> +				     struct address_space *mapping2);
> +
> +
>  /*
>   * NOTE: in a 32bit arch with a preemptable kernel and
>   * an UP compile the i_size_read/write must be atomic
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 4d9ec4c6cc34..d3801a9739aa 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1009,6 +1009,44 @@ struct page *__page_cache_alloc(gfp_t gfp)
>  EXPORT_SYMBOL(__page_cache_alloc);
>  #endif
>  
> +/*
> + * filemap_invalidate_down_write_two - lock invalidate_lock for two mappings
> + *
> + * Lock exclusively invalidate_lock of any passed mapping that is not NULL.
> + *
> + * @mapping1: the first mapping to lock
> + * @mapping2: the second mapping to lock
> + */
> +void filemap_invalidate_down_write_two(struct address_space *mapping1,
> +				       struct address_space *mapping2)
> +{
> +	if (mapping1 > mapping2)
> +		swap(mapping1, mapping2);
> +	if (mapping1)
> +		down_write(&mapping1->invalidate_lock);
> +	if (mapping2 && mapping1 != mapping2)
> +		down_write_nested(&mapping2->invalidate_lock, 1);
> +}
> +EXPORT_SYMBOL(filemap_invalidate_down_write_two);
> +
> +/*
> + * filemap_invalidate_up_write_two - unlock invalidate_lock for two mappings
> + *
> + * Unlock exclusive invalidate_lock of any passed mapping that is not NULL.
> + *
> + * @mapping1: the first mapping to unlock
> + * @mapping2: the second mapping to unlock
> + */
> +void filemap_invalidate_up_write_two(struct address_space *mapping1,
> +				     struct address_space *mapping2)
> +{
> +	if (mapping1)
> +		up_write(&mapping1->invalidate_lock);
> +	if (mapping2 && mapping1 != mapping2)
> +		up_write(&mapping2->invalidate_lock);
> +}
> +EXPORT_SYMBOL(filemap_invalidate_up_write_two);
> +
>  /*
>   * In order to wait for pages to become available there must be
>   * waitqueues associated with pages. By using a hash table of
> -- 
> 2.26.2
> 
