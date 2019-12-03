Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB7A010FDD1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 13:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfLCMje (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 07:39:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:50424 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725997AbfLCMjd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:39:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A297CAD78;
        Tue,  3 Dec 2019 12:39:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 28C891E0B7B; Tue,  3 Dec 2019 13:39:30 +0100 (CET)
Date:   Tue, 3 Dec 2019 13:39:29 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org
Subject: Re: [RFCv3 4/4] ext4: Move to shared iolock even without
 dioread_nolock mount opt
Message-ID: <20191203123929.GE8206@quack2.suse.cz>
References: <20191120050024.11161-1-riteshh@linux.ibm.com>
 <20191120050024.11161-5-riteshh@linux.ibm.com>
 <20191120143257.GE9509@quack2.suse.cz>
 <20191126105122.75EC6A4060@b06wcsmtp001.portsmouth.uk.ibm.com>
 <20191129171836.GB27588@quack2.suse.cz>
 <20191203115445.6F802AE059@d06av26.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203115445.6F802AE059@d06av26.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hello Ritesh!

On Tue 03-12-19 17:24:44, Ritesh Harjani wrote:
> On 11/29/19 10:48 PM, Jan Kara wrote:
> > > Also, I wanted to have some more discussions on this race before
> > > making the changes.
> > > But nevertheless, it's the right time to discuss those changes here.
> > > 
> > > > mmap write instantiating dirty page and then someone starting writeback
> > > > against that page while DIO read is running still theoretically leading to
> > > > stale data exposure. Now this patch does not have influence on that race
> > > > but:
> > > 
> > > Yes, agreed.
> > > 
> > > > 
> > > > 1) We need to close the race mentioned above. Maybe we could do that by
> > > > proactively allocating unwritten blocks for a page being faulted when there
> > > > is direct IO running against the file - the one who fills holes through
> > > > mmap write while direct IO is running on the file deserves to suffer the
> > > > performance penalty...
> > > 
> > > I was giving this a thought. So even if we try to penalize mmap
> > > write as you mentioned above, what I am not sure about it, is that, how can
> > > we reliably detect that the DIO is in progress?
> > > 
> > > Say even if we try to check for atomic_read(&inode->i_dio_count) in mmap
> > > ext4_page_mkwrite path, it cannot be reliable unless there is some sort of a
> > > lock protection, no?
> > > Because after the check the DIO can still snoop in, right?
> > 
> > Yes, doing this reliably will need some code tweaking. Also thinking about
> > this in detail, doing a reliable check in ext4_page_mkwrite() is
> > somewhat difficult so it will be probably less error-prone to deal with the
> > race in the writeback path.
> 
> hmm. But if we don't do in ext4_page_mkwrite, then I am afraid on
> how to handle nodelalloc scenario. Where we will directly go and
> allocate block via ext4_get_block() in ext4_page_mkwrite(),
> as explained below.
> I guess we may need some tweaking at both places.

Ok, I forgot to mention that. Yes, the nodelalloc case in
ext4_page_mkwrite() still needs tweaking. But that is not performance
sensitive path at all. So we can just have there:

	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
		get_block = ext4_get_block_unwritten;
	else
		get_block = ext4_get_block;

and be done with it. And yes, for inodes using indirect blocks, direct IO
reads can still theoretically expose data from blocks instantiated by hole
filling from ext4_page_mkwrite(). But that race has always been there
regardless of DIO locking and is hardly fixable with that on-disk format.

								Honza

> 
> 
> > 
> > My preferred way of dealing with this would be to move inode_dio_begin()
> > call in iomap_dio_rw() a bit earlier before page cache invalidation and add
> > there smp_mb_after_atomic() (so that e.g. nrpages checks cannot get
> > reordered before the increment).  Then the check on i_dio_count in
> > ext4_writepages() will be reliable if we do it after gathering and locking
> > pages for writeback (i.e., in mpage_map_and_submit_extent()) - either we
> > see i_dio_count elevated and use the safe (but slower) writeback using
> > unwritten extents, or we see don't and then we are sure DIO will not start
> > until writeback of the pages we have locked has finished because of
> > filemap_write_and_wait() call in iomap_dio_rw().
> > 
> > 
> 
> Thanks for explaining this in detail. I guess I understand this part now
> Earlier my understanding towards mapping->nrpages was not complete.
> 
> AFAIU, with your above suggestion the race won't happen for delalloc
> cases. But what if it is a nodelalloc mount option?
> 
> Say with above changes i.e. after tweaking iomap_dio_rw() code as you
> mentioned above. Below race could still happen, right?
> 
> iomap_dio_rw()					
> filemap_write_and_wait_range() 			
> inode_dio_begin()
> smp_mb__after_atomic()
> invalidate_inode_pages2_range()				
> 						ext4_page_mkwrite()
> 						block_page_mkwrite()
> 		  				  lock_page()
> 						  ext4_get_block()
> 
> ext4_map_blocks()
> //this will return IOMAP_MAPPED entry
> 
> submit_bio()
> // this goes and reads the block
> // with stale data allocated,
> // by ext4_page_mkwrite()
> 
> 
> Now, I am assuming that ext4_get_block() via ext4_page_mkwrite() path
> may try to create the block for hole then and there itself.
> And if submit_bio() from DIO path is serviced late i.e. after
> ext4_get_block() has already allocated block there, then this may expose
> stale data. Thoughts?
> 
> 
> So to avoid both such races in delalloc & in nodelalloc path,
> we should add the checks at both ext4_writepages() & also at
> ext4_page_mkwrite().
> 
> For ext4_page_mkwrite(), why don't we just change the "get_block"
> function pointer which is passed to block_page_mkwrite()
> as below. This should solve our race since
> ext4_dio_check_get_block() will be only called with lock_page()
> held. And also with inode_dio_begin() now moved up before
> invalidate_inode_pages2_range(), we could be sure
> about DIO is currently running or not in ext4_page_mkwrite() path.
> 
> Does this looks correct to you?
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 381813205f99..74c33d03592c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -806,6 +806,19 @@ int ext4_get_block_unwritten(struct inode *inode,
> sector_t iblock,
>  			       EXT4_GET_BLOCKS_IO_CREATE_EXT);
>  }
> 
> +int ext4_dio_check_get_block(struct inode *inode, sector_t iblock,
> +		   struct buffer_head *bh, int create)
> +{
> +	get_block_t *get_block;
> +
> +	if (!atomic_read(&inode->i_dio_count))
> +		get_block = ext4_get_block;
> +	else
> +		get_block = ext4_get_block_unwritten;
> +
> +	return get_block(inode, iblock, bh, create);
> +}
> +
>  /* Maximum number of blocks we map for direct IO at once. */
>  #define DIO_MAX_BLOCKS 4096
> 
> @@ -2332,7 +2345,8 @@ static int mpage_map_one_extent(handle_t *handle,
> struct mpage_da_data *mpd)
>  	struct inode *inode = mpd->inode;
>  	struct ext4_map_blocks *map = &mpd->map;
>  	int get_blocks_flags;
> -	int err, dioread_nolock;
> +	int err;
> +	bool dio_in_progress = atomic_read(&inode->i_dio_count);
> 
>  	trace_ext4_da_write_pages_extent(inode, map);
>  	/*
> @@ -2353,8 +2367,14 @@ static int mpage_map_one_extent(handle_t *handle,
> struct mpage_da_data *mpd)
>  	get_blocks_flags = EXT4_GET_BLOCKS_CREATE |
>  			   EXT4_GET_BLOCKS_METADATA_NOFAIL |
>  			   EXT4_GET_BLOCKS_IO_SUBMIT;
> -	dioread_nolock = ext4_should_dioread_nolock(inode);
> -	if (dioread_nolock)
> +
> +	/*
> +	 * There could be race between DIO read & ext4_page_mkwrite
> +	 * where in delalloc case, we may go and try to allocate the
> +	 * block here but if DIO read is in progress then it may expose
> +	 * stale data, hence use unwritten blocks for allocation
> +	 * when DIO is in progress.
> +	 */
> +	if (dio_in_progress)
>  		get_blocks_flags |= EXT4_GET_BLOCKS_IO_CREATE_EXT;
>  	if (map->m_flags & (1 << BH_Delay))
>  		get_blocks_flags |= EXT4_GET_BLOCKS_DELALLOC_RESERVE;
> @@ -2362,7 +2382,7 @@ static int mpage_map_one_extent(handle_t *handle,
> struct mpage_da_data *mpd)
>  	err = ext4_map_blocks(handle, inode, map, get_blocks_flags);
>  	if (err < 0)
>  		return err;
> -	if (dioread_nolock && (map->m_flags & EXT4_MAP_UNWRITTEN)) {
> +	if (dio_in_progress && (map->m_flags & EXT4_MAP_UNWRITTEN)) {
>  		if (!mpd->io_submit.io_end->handle &&
>  		    ext4_handle_valid(handle)) {
>  			mpd->io_submit.io_end->handle = handle->h_rsv_handle;
> @@ -5906,10 +5926,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
>  	}
>  	unlock_page(page);
>  	/* OK, we need to fill the hole... */
> -	if (ext4_should_dioread_nolock(inode))
> -		get_block = ext4_get_block_unwritten;
> -	else
> -		get_block = ext4_get_block;
> +	get_block = ext4_dio_check_get_block;
>  retry_alloc:
>  	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE,
>  				    ext4_writepage_trans_blocks(inode));
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 2f88d64c2a4d..09d0601e5ecb 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -465,6 +465,8 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	if (ret)
>  		goto out_free_dio;
> 
> +	inode_dio_begin(inode);
> +	smp_mb__after_atomic();
>  	/*
>  	 * Try to invalidate cache pages for the range we're direct
>  	 * writing.  If this invalidation fails, tough, the write will
> @@ -484,8 +486,6 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  			goto out_free_dio;
>  	}
> 
> -	inode_dio_begin(inode);
> -
>  	blk_start_plug(&plug);
>  	do {
>  		ret = iomap_apply(inode, pos, count, flags, ops, dio,
> 
> 
> 
> -ritesh
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
