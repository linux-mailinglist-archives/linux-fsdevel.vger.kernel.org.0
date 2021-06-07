Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5764F39E11D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 17:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhFGPsP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 11:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhFGPsN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 11:48:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E89D61029;
        Mon,  7 Jun 2021 15:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623080782;
        bh=HI9sxdPlDL3aHynFPkgW9uXuKBCOLyWBD+N0DWRCj2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lPwVfoMqlw+XEIfsv+kdzxNX8xhODaFTCI4bqlXwN7KkZp+iaz+EJ62t14aAWNsuC
         vYA6nfBE6J13L0Y3/m4VoZi6SGzXvq7pOudicJvOJc1r+9qWFHy3KDad8J21rx9pvs
         /DgvsxbS20QsQ8REiqdx02ut3lpWU6VU9Fj1C1hCIzpqS3Zgh1ch6yXKeTecb+6PW7
         CZNPV5q9NoHPdExrubdgnHKB7S3FQeSG0n8CfKQY5LMmbaxl5QuAaNYJAqB81RjwHZ
         ha1gKbkyjFs1r2Rjg2Lwz1V186iMcCy5tD24waMQJcvIAce13cWPSYGxHRSgFM44aC
         z5U0s0L18zPxg==
Date:   Mon, 7 Jun 2021 08:46:22 -0700
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
Subject: Re: [PATCH 04/14] mm: Add functions to lock invalidate_lock for two
 mappings
Message-ID: <20210607154622.GG2945738@locust>
References: <20210607144631.8717-1-jack@suse.cz>
 <20210607145236.31852-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607145236.31852-4-jack@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 07, 2021 at 04:52:14PM +0200, Jan Kara wrote:
> Some operations such as reflinking blocks among files will need to lock
> invalidate_lock for two mappings. Add helper functions to do that.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Straightforward lift from xfs, though now with vfs lock ordering
rules...

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  include/linux/fs.h |  6 ++++++
>  mm/filemap.c       | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index d8afbc9661d7..ddc11bafc183 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -849,6 +849,12 @@ static inline void filemap_invalidate_unlock_shared(
>  void lock_two_nondirectories(struct inode *, struct inode*);
>  void unlock_two_nondirectories(struct inode *, struct inode*);
>  
> +void filemap_invalidate_lock_two(struct address_space *mapping1,
> +				 struct address_space *mapping2);
> +void filemap_invalidate_unlock_two(struct address_space *mapping1,
> +				   struct address_space *mapping2);
> +
> +
>  /*
>   * NOTE: in a 32bit arch with a preemptable kernel and
>   * an UP compile the i_size_read/write must be atomic
> diff --git a/mm/filemap.c b/mm/filemap.c
> index c8e7e451d81e..b8e9bccecd9f 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1009,6 +1009,44 @@ struct page *__page_cache_alloc(gfp_t gfp)
>  EXPORT_SYMBOL(__page_cache_alloc);
>  #endif
>  
> +/*
> + * filemap_invalidate_lock_two - lock invalidate_lock for two mappings
> + *
> + * Lock exclusively invalidate_lock of any passed mapping that is not NULL.
> + *
> + * @mapping1: the first mapping to lock
> + * @mapping2: the second mapping to lock
> + */
> +void filemap_invalidate_lock_two(struct address_space *mapping1,
> +				 struct address_space *mapping2)
> +{
> +	if (mapping1 > mapping2)
> +		swap(mapping1, mapping2);
> +	if (mapping1)
> +		down_write(&mapping1->invalidate_lock);
> +	if (mapping2 && mapping1 != mapping2)
> +		down_write_nested(&mapping2->invalidate_lock, 1);
> +}
> +EXPORT_SYMBOL(filemap_invalidate_lock_two);
> +
> +/*
> + * filemap_invalidate_unlock_two - unlock invalidate_lock for two mappings
> + *
> + * Unlock exclusive invalidate_lock of any passed mapping that is not NULL.
> + *
> + * @mapping1: the first mapping to unlock
> + * @mapping2: the second mapping to unlock
> + */
> +void filemap_invalidate_unlock_two(struct address_space *mapping1,
> +				   struct address_space *mapping2)
> +{
> +	if (mapping1)
> +		up_write(&mapping1->invalidate_lock);
> +	if (mapping2 && mapping1 != mapping2)
> +		up_write(&mapping2->invalidate_lock);
> +}
> +EXPORT_SYMBOL(filemap_invalidate_unlock_two);
> +
>  /*
>   * In order to wait for pages to become available there must be
>   * waitqueues associated with pages. By using a hash table of
> -- 
> 2.26.2
> 
