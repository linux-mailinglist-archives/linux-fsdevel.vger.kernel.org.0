Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B0137C705
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 17:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbhELP54 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 11:57:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236425AbhELPhx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 11:37:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FE946199C;
        Wed, 12 May 2021 15:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620832786;
        bh=T6Lawv7Kod9ZP9zSPqwbupin2WcFezRDjXSRCBkOee4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RzoUHhzFYiv2mtULMxmuDjagPgzgmkXMANmRZzUsOFxZe0EJoOdJoI3UeoFiOgeLS
         ZyA4AxCMiJhrZA/Fiju1k5YBKiFqLSd9zFJtLQACa78I5W1/6MkA8ZnX0EzN5LKkyF
         SJNsE13kpG0/OVLi7EdkVnW6rECToZBiP5iqhnvpFcE9ZXjTvFiD1aTtp3gOHHUGfM
         fMXm3oeOLg7xhFSqSKUwpvfbZQOt2+gfmyDcCcL5Hr2CdCCFrzzcCHc1yY4SOzKPzC
         rYL6CqUJiyBelQ3xfS/7gnKKMEptiDJdQ4f1xx072iW3pINIo74zk93ewlLedh1V5h
         p+g3aZCSUx3CQ==
Message-ID: <bc8f0ab096e1a7d8ba29655247de7b2c2abfd5f1.camel@kernel.org>
Subject: Re: [PATCH 10/11] ceph: Fix race between hole punch and page fault
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, ceph-devel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>
Date:   Wed, 12 May 2021 11:19:42 -0400
In-Reply-To: <20210512134631.4053-10-jack@suse.cz>
References: <20210512101639.22278-1-jack@suse.cz>
         <20210512134631.4053-10-jack@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-05-12 at 15:46 +0200, Jan Kara wrote:
> Ceph has a following race between hole punching and page fault:
> 
> CPU1                                  CPU2
> ceph_fallocate()
>   ...
>   ceph_zero_pagecache_range()
>                                       ceph_filemap_fault()
>                                         faults in page in the range being
>                                         punched
>   ceph_zero_objects()
> 
> And now we have a page in punched range with invalid data. Fix the
> problem by using mapping->invalidate_lock similarly to other
> filesystems. Note that using invalidate_lock also fixes a similar race
> wrt ->readpage().
> 
> CC: Jeff Layton <jlayton@kernel.org>
> CC: ceph-devel@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ceph/addr.c | 9 ++++++---
>  fs/ceph/file.c | 2 ++
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index c1570fada3d8..6d868faf97b5 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1401,9 +1401,11 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
>  		ret = VM_FAULT_SIGBUS;
>  	} else {
>  		struct address_space *mapping = inode->i_mapping;
> -		struct page *page = find_or_create_page(mapping, 0,
> -						mapping_gfp_constraint(mapping,
> -						~__GFP_FS));
> +		struct page *page;
> +
> +		down_read(&mapping->invalidate_lock);
> +		page = find_or_create_page(mapping, 0,
> +				mapping_gfp_constraint(mapping, ~__GFP_FS));
>  		if (!page) {
>  			ret = VM_FAULT_OOM;
>  			goto out_inline;
> @@ -1424,6 +1426,7 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
>  		vmf->page = page;
>  		ret = VM_FAULT_MAJOR | VM_FAULT_LOCKED;
>  out_inline:
> +		up_read(&mapping->invalidate_lock);
>  		dout("filemap_fault %p %llu read inline data ret %x\n",
>  		     inode, off, ret);
>  	}
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 77fc037d5beb..91693d8b458e 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -2083,6 +2083,7 @@ static long ceph_fallocate(struct file *file, int mode,
>  	if (ret < 0)
>  		goto unlock;
>  
> +	down_write(&inode->i_mapping->invalidate_lock);
>  	ceph_zero_pagecache_range(inode, offset, length);
>  	ret = ceph_zero_objects(inode, offset, length);
>  
> @@ -2095,6 +2096,7 @@ static long ceph_fallocate(struct file *file, int mode,
>  		if (dirty)
>  			__mark_inode_dirty(inode, dirty);
>  	}
> +	up_write(&inode->i_mapping->invalidate_lock);
>  
>  	ceph_put_cap_refs(ci, got);
>  unlock:

Assuming the basic concept is sound, then this looks reasonable. 

Reviewed-by: Jeff Layton <jlayton@kernel.org>

