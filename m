Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E13F31456A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 02:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhBIBN5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 20:13:57 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:57695 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229671AbhBIBNn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:13:43 -0500
Received: from dread.disaster.area (pa49-181-52-82.pa.nsw.optusnet.com.au [49.181.52.82])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 52A0310405A3;
        Tue,  9 Feb 2021 12:12:59 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l9HaM-00DODw-16; Tue, 09 Feb 2021 12:12:58 +1100
Date:   Tue, 9 Feb 2021 12:12:58 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/2] mm: Protect operations adding pages to page cache
 with i_mapping_lock
Message-ID: <20210209011258.GQ4626@dread.disaster.area>
References: <20210208163918.7871-1-jack@suse.cz>
 <20210208163918.7871-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208163918.7871-2-jack@suse.cz>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=7pwokN52O8ERr2y46pWGmQ==:117 a=7pwokN52O8ERr2y46pWGmQ==:17
        a=kj9zAlcOel0A:10 a=qa6Q16uM49sA:10 a=7-415B0cAAAA:8
        a=muq-Sb2eTPKmvJNtKt8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 08, 2021 at 05:39:17PM +0100, Jan Kara wrote:
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
> So create a new rw_semaphore in the inode - i_mapping_sem - that
> protects adding of pages to page cache for page faults / reads /
> readahead.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/inode.c         |  3 +++
>  include/linux/fs.h |  2 ++
>  mm/filemap.c       | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  mm/readahead.c     |  2 ++
>  4 files changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 6442d97d9a4a..8df49d98e1cd 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -174,6 +174,9 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
>  
>  	init_rwsem(&inode->i_rwsem);
>  	lockdep_set_class(&inode->i_rwsem, &sb->s_type->i_mutex_key);
> +	init_rwsem(&inode->i_mapping_sem);
> +	lockdep_set_class(&inode->i_mapping_sem,
> +			  &sb->s_type->i_mapping_sem_key);
>  
>  	atomic_set(&inode->i_dio_count, 0);
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b20ddd8a6e62..248609bc61a2 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -658,6 +658,7 @@ struct inode {
>  	/* Misc */
>  	unsigned long		i_state;
>  	struct rw_semaphore	i_rwsem;
> +	struct rw_semaphore	i_mapping_sem;
>  
>  	unsigned long		dirtied_when;	/* jiffies of first dirtying */
>  	unsigned long		dirtied_time_when;
> @@ -2249,6 +2250,7 @@ struct file_system_type {
>  
>  	struct lock_class_key i_lock_key;
>  	struct lock_class_key i_mutex_key;
> +	struct lock_class_key i_mapping_sem_key;
>  	struct lock_class_key i_mutex_dir_key;
>  };
>  
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 16a3bf693d4a..02f778ff02e0 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2257,16 +2257,28 @@ static int filemap_update_page(struct kiocb *iocb,
>  {
>  	int error;
>  
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!down_read_trylock(&mapping->host->i_mapping_sem))
> +			return -EAGAIN;
> +	} else {
> +		down_read(&mapping->host->i_mapping_sem);
> +	}
> +
>  	if (!trylock_page(page)) {
> -		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_NOIO))
> +		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_NOIO)) {
> +			up_read(&mapping->host->i_mapping_sem);
>  			return -EAGAIN;
> +		}
>  		if (!(iocb->ki_flags & IOCB_WAITQ)) {
> +			up_read(&mapping->host->i_mapping_sem);
>  			put_and_wait_on_page_locked(page, TASK_KILLABLE);
>  			return AOP_TRUNCATED_PAGE;
>  		}
>  		error = __lock_page_async(page, iocb->ki_waitq);
> -		if (error)
> +		if (error) {
> +			up_read(&mapping->host->i_mapping_sem);
>  			return error;
> +		}
>  	}

What tree is this against? I don't see filemap_update_page() in a
5.11-rc7 tree...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
