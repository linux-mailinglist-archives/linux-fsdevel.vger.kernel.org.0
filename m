Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214B637C071
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 16:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhELOnD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 10:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhELOnD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 10:43:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4C3C061574;
        Wed, 12 May 2021 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nmCeol4OxOYxGsAsqjc6BSS4j1R2S4rzG/0fPJoXFKI=; b=a+NNS/dSBg4ioksrXQKLAeOm0U
        fU0YgisnbBMFBlWnjNB0l4NWnvCy2wZOot3llat5Ww6lZvRuPm3gwsrPT3VbNlfaNPXo+mmYWK7CD
        GI4iIw8yeVzZVKkwbSyuxbJTLCe2EHfHQ55zluQDAWZp0+DB+fnvuAB766DGz2RH5Nhss0xfAw1B2
        P1/NvqUn+xdA97P+o3Sw8HmnOS9H+PZ8qPtpFVoKHkm1jyf4U315OzYXWxMvMFqPIAtuczY9ZdRJ7
        SqkG4lrx5+GB3z6L+CqZp3UHEsAshbfcW1DIKpYADkAyFJ/D7l+TxhRiuVYb49Scc6hu741DxOETB
        n319PzdA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgq29-008NIW-W7; Wed, 12 May 2021 14:40:49 +0000
Date:   Wed, 12 May 2021 15:40:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
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
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>
Subject: Re: [PATCH 03/11] mm: Protect operations adding pages to page cache
 with invalidate_lock
Message-ID: <YJvo1bGG1tG+gtgC@casper.infradead.org>
References: <20210512101639.22278-1-jack@suse.cz>
 <20210512134631.4053-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512134631.4053-3-jack@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 12, 2021 at 03:46:11PM +0200, Jan Kara wrote:
> Currently, serializing operations such as page fault, read, or readahead
> against hole punching is rather difficult. The basic race scheme is
> like:
> 
> fallocate(FALLOC_FL_PUNCH_HOLE)			read / fault / ..
>   truncate_inode_pages_range()
> 						  <create pages in page
> 						   cache here>
>   <update fs block mapping and free blocks>
> 
> Now the problem is in this way read / page fault / readahead can
> instantiate pages in page cache with potentially stale data (if blocks
> get quickly reused). Avoiding this race is not simple - page locks do
> not work because we want to make sure there are *no* pages in given
> range. inode->i_rwsem does not work because page fault happens under
> mmap_sem which ranks below inode->i_rwsem. Also using it for reads makes
> the performance for mixed read-write workloads suffer.
> 
> So create a new rw_semaphore in the address_space - invalidate_lock -
> that protects adding of pages to page cache for page faults / reads /
> readahead.

Remind me (or, rather, add to the documentation) why we have to hold the
invalidate_lock during the call to readpage / readahead, and we don't just
hold it around the call to add_to_page_cache / add_to_page_cache_locked
/ add_to_page_cache_lru ?  I appreciate that ->readpages is still going
to suck, but we're down to just three implementations of ->readpages now
(9p, cifs & nfs).

Also, could I trouble you to run the comments through 'fmt' (or
equivalent)?  It's easier to read if you're not kissing right up on 80
columns.

> +++ b/fs/inode.c
> @@ -190,6 +190,9 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
>  	mapping_set_gfp_mask(mapping, GFP_HIGHUSER_MOVABLE);
>  	mapping->private_data = NULL;
>  	mapping->writeback_index = 0;
> +	init_rwsem(&mapping->invalidate_lock);
> +	lockdep_set_class(&mapping->invalidate_lock,
> +			  &sb->s_type->invalidate_lock_key);

Why not:

	__init_rwsem(&mapping->invalidate_lock, "mapping.invalidate_lock",
			&sb->s_type->invalidate_lock_key);

