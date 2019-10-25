Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCAEE4BCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 15:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440382AbfJYNHs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 09:07:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:37698 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439018AbfJYNHs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:07:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 21B70AE65;
        Fri, 25 Oct 2019 13:07:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6DC761E485C; Fri, 25 Oct 2019 15:07:45 +0200 (CEST)
Date:   Fri, 25 Oct 2019 15:07:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     tytso@mit.edu, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org
Subject: Re: [RFC 1/5] ext4: keep uniform naming convention for io & io_end
 variables
Message-ID: <20191025130745.GB30163@quack2.suse.cz>
References: <20191016073711.4141-1-riteshh@linux.ibm.com>
 <20191016073711.4141-2-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016073711.4141-2-riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 16-10-19 13:07:07, Ritesh Harjani wrote:
> Let's keep uniform naming convention for ext4_submit_io (io)
> & ext4_end_io_t (io_end) structures, to avoid any confusion.
> No functionality change in this patch.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/page-io.c | 55 ++++++++++++++++++++++++-----------------------
>  1 file changed, 28 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index 12ceadef32c5..d9b96fc976a3 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -136,19 +136,19 @@ static void ext4_release_io_end(ext4_io_end_t *io_end)
>   * cannot get to ext4_ext_truncate() before all IOs overlapping that range are
>   * completed (happens from ext4_free_ioend()).
>   */
> -static int ext4_end_io(ext4_io_end_t *io)
> +static int ext4_end_io_end(ext4_io_end_t *io_end)
>  {
> -	struct inode *inode = io->inode;
> -	loff_t offset = io->offset;
> -	ssize_t size = io->size;
> -	handle_t *handle = io->handle;
> +	struct inode *inode = io_end->inode;
> +	loff_t offset = io_end->offset;
> +	ssize_t size = io_end->size;
> +	handle_t *handle = io_end->handle;
>  	int ret = 0;
>  
> -	ext4_debug("ext4_end_io_nolock: io 0x%p from inode %lu,list->next 0x%p,"
> +	ext4_debug("ext4_end_io_nolock: io_end 0x%p from inode %lu,list->next 0x%p,"
>  		   "list->prev 0x%p\n",
> -		   io, inode->i_ino, io->list.next, io->list.prev);
> +		   io_end, inode->i_ino, io_end->list.next, io_end->list.prev);
>  
> -	io->handle = NULL;	/* Following call will use up the handle */
> +	io_end->handle = NULL;	/* Following call will use up the handle */
>  	ret = ext4_convert_unwritten_extents(handle, inode, offset, size);
>  	if (ret < 0 && !ext4_forced_shutdown(EXT4_SB(inode->i_sb))) {
>  		ext4_msg(inode->i_sb, KERN_EMERG,
> @@ -157,8 +157,8 @@ static int ext4_end_io(ext4_io_end_t *io)
>  			 "(inode %lu, offset %llu, size %zd, error %d)",
>  			 inode->i_ino, offset, size, ret);
>  	}
> -	ext4_clear_io_unwritten_flag(io);
> -	ext4_release_io_end(io);
> +	ext4_clear_io_unwritten_flag(io_end);
> +	ext4_release_io_end(io_end);
>  	return ret;
>  }
>  
> @@ -166,21 +166,21 @@ static void dump_completed_IO(struct inode *inode, struct list_head *head)
>  {
>  #ifdef	EXT4FS_DEBUG
>  	struct list_head *cur, *before, *after;
> -	ext4_io_end_t *io, *io0, *io1;
> +	ext4_io_end_t *io_end, *io_end0, *io_end1;
>  
>  	if (list_empty(head))
>  		return;
>  
>  	ext4_debug("Dump inode %lu completed io list\n", inode->i_ino);
> -	list_for_each_entry(io, head, list) {
> -		cur = &io->list;
> +	list_for_each_entry(io_end, head, list) {
> +		cur = &io_end->list;
>  		before = cur->prev;
> -		io0 = container_of(before, ext4_io_end_t, list);
> +		io_end0 = container_of(before, ext4_io_end_t, list);
>  		after = cur->next;
> -		io1 = container_of(after, ext4_io_end_t, list);
> +		io_end1 = container_of(after, ext4_io_end_t, list);
>  
>  		ext4_debug("io 0x%p from inode %lu,prev 0x%p,next 0x%p\n",
> -			    io, inode->i_ino, io0, io1);
> +			    io_end, inode->i_ino, io_end0, io_end1);
>  	}
>  #endif
>  }
> @@ -207,7 +207,7 @@ static void ext4_add_complete_io(ext4_io_end_t *io_end)
>  static int ext4_do_flush_completed_IO(struct inode *inode,
>  				      struct list_head *head)
>  {
> -	ext4_io_end_t *io;
> +	ext4_io_end_t *io_end;
>  	struct list_head unwritten;
>  	unsigned long flags;
>  	struct ext4_inode_info *ei = EXT4_I(inode);
> @@ -219,11 +219,11 @@ static int ext4_do_flush_completed_IO(struct inode *inode,
>  	spin_unlock_irqrestore(&ei->i_completed_io_lock, flags);
>  
>  	while (!list_empty(&unwritten)) {
> -		io = list_entry(unwritten.next, ext4_io_end_t, list);
> -		BUG_ON(!(io->flag & EXT4_IO_END_UNWRITTEN));
> -		list_del_init(&io->list);
> +		io_end = list_entry(unwritten.next, ext4_io_end_t, list);
> +		BUG_ON(!(io_end->flag & EXT4_IO_END_UNWRITTEN));
> +		list_del_init(&io_end->list);
>  
> -		err = ext4_end_io(io);
> +		err = ext4_end_io_end(io_end);
>  		if (unlikely(!ret && err))
>  			ret = err;
>  	}
> @@ -242,13 +242,14 @@ void ext4_end_io_rsv_work(struct work_struct *work)
>  
>  ext4_io_end_t *ext4_init_io_end(struct inode *inode, gfp_t flags)
>  {
> -	ext4_io_end_t *io = kmem_cache_zalloc(io_end_cachep, flags);
> -	if (io) {
> -		io->inode = inode;
> -		INIT_LIST_HEAD(&io->list);
> -		atomic_set(&io->count, 1);
> +	ext4_io_end_t *io_end = kmem_cache_zalloc(io_end_cachep, flags);
> +
> +	if (io_end) {
> +		io_end->inode = inode;
> +		INIT_LIST_HEAD(&io_end->list);
> +		atomic_set(&io_end->count, 1);
>  	}
> -	return io;
> +	return io_end;
>  }
>  
>  void ext4_put_io_end_defer(ext4_io_end_t *io_end)
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
