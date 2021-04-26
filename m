Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF6D36B6BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 18:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbhDZQZO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 12:25:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:57172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234528AbhDZQZN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:25:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B6F48ACF6;
        Mon, 26 Apr 2021 16:24:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 08DF71E0CB7; Mon, 26 Apr 2021 18:24:30 +0200 (CEST)
Date:   Mon, 26 Apr 2021 18:24:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>, Ted Tso <tytso@mit.edu>,
        Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH 06/12] zonefs: Convert to using invalidate_lock
Message-ID: <20210426162429.GC23895@quack2.suse.cz>
References: <20210423171010.12-1-jack@suse.cz>
 <20210423173018.23133-6-jack@suse.cz>
 <BL0PR04MB651475DE7CA7465849D821D5E7429@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR04MB651475DE7CA7465849D821D5E7429@BL0PR04MB6514.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 26-04-21 06:40:27, Damien Le Moal wrote:
> On 2021/04/24 2:30, Jan Kara wrote:
> > Use invalidate_lock instead of zonefs' private i_mmap_sem. The intended
> > purpose is exactly the same. By this conversion we also fix a race
> > between hole punching and read(2) / readahead(2) paths that can lead to
> > stale page cache contents.
> 
> zonefs does not support hole punching since the blocks of a file are determined
> by the device zone configuration and cannot change, ever. So I think you can
> remove the second sentence above.

Sure, thanks for correction. Updated.

								Honza

> 
> > 
> > CC: Damien Le Moal <damien.lemoal@wdc.com>
> > CC: Johannes Thumshirn <jth@kernel.org>
> > CC: <linux-fsdevel@vger.kernel.org>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/zonefs/super.c  | 23 +++++------------------
> >  fs/zonefs/zonefs.h |  7 +++----
> >  2 files changed, 8 insertions(+), 22 deletions(-)
> > 
> > diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> > index 049e36c69ed7..60ac5587c880 100644
> > --- a/fs/zonefs/super.c
> > +++ b/fs/zonefs/super.c
> > @@ -462,7 +462,7 @@ static int zonefs_file_truncate(struct inode *inode, loff_t isize)
> >  	inode_dio_wait(inode);
> >  
> >  	/* Serialize against page faults */
> > -	down_write(&zi->i_mmap_sem);
> > +	down_write(&inode->i_mapping->invalidate_lock);
> >  
> >  	/* Serialize against zonefs_iomap_begin() */
> >  	mutex_lock(&zi->i_truncate_mutex);
> > @@ -500,7 +500,7 @@ static int zonefs_file_truncate(struct inode *inode, loff_t isize)
> >  
> >  unlock:
> >  	mutex_unlock(&zi->i_truncate_mutex);
> > -	up_write(&zi->i_mmap_sem);
> > +	up_write(&inode->i_mapping->invalidate_lock);
> >  
> >  	return ret;
> >  }
> > @@ -575,18 +575,6 @@ static int zonefs_file_fsync(struct file *file, loff_t start, loff_t end,
> >  	return ret;
> >  }
> >  
> > -static vm_fault_t zonefs_filemap_fault(struct vm_fault *vmf)
> > -{
> > -	struct zonefs_inode_info *zi = ZONEFS_I(file_inode(vmf->vma->vm_file));
> > -	vm_fault_t ret;
> > -
> > -	down_read(&zi->i_mmap_sem);
> > -	ret = filemap_fault(vmf);
> > -	up_read(&zi->i_mmap_sem);
> > -
> > -	return ret;
> > -}
> > -
> >  static vm_fault_t zonefs_filemap_page_mkwrite(struct vm_fault *vmf)
> >  {
> >  	struct inode *inode = file_inode(vmf->vma->vm_file);
> > @@ -607,16 +595,16 @@ static vm_fault_t zonefs_filemap_page_mkwrite(struct vm_fault *vmf)
> >  	file_update_time(vmf->vma->vm_file);
> >  
> >  	/* Serialize against truncates */
> > -	down_read(&zi->i_mmap_sem);
> > +	down_read(&inode->i_mapping->invalidate_lock);
> >  	ret = iomap_page_mkwrite(vmf, &zonefs_iomap_ops);
> > -	up_read(&zi->i_mmap_sem);
> > +	up_read(&inode->i_mapping->invalidate_lock);
> >  
> >  	sb_end_pagefault(inode->i_sb);
> >  	return ret;
> >  }
> >  
> >  static const struct vm_operations_struct zonefs_file_vm_ops = {
> > -	.fault		= zonefs_filemap_fault,
> > +	.fault		= filemap_fault,
> >  	.map_pages	= filemap_map_pages,
> >  	.page_mkwrite	= zonefs_filemap_page_mkwrite,
> >  };
> > @@ -1158,7 +1146,6 @@ static struct inode *zonefs_alloc_inode(struct super_block *sb)
> >  
> >  	inode_init_once(&zi->i_vnode);
> >  	mutex_init(&zi->i_truncate_mutex);
> > -	init_rwsem(&zi->i_mmap_sem);
> >  	zi->i_wr_refcnt = 0;
> >  
> >  	return &zi->i_vnode;
> > diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
> > index 51141907097c..7b147907c328 100644
> > --- a/fs/zonefs/zonefs.h
> > +++ b/fs/zonefs/zonefs.h
> > @@ -70,12 +70,11 @@ struct zonefs_inode_info {
> >  	 * and changes to the inode private data, and in particular changes to
> >  	 * a sequential file size on completion of direct IO writes.
> >  	 * Serialization of mmap read IOs with truncate and syscall IO
> > -	 * operations is done with i_mmap_sem in addition to i_truncate_mutex.
> > -	 * Only zonefs_seq_file_truncate() takes both lock (i_mmap_sem first,
> > -	 * i_truncate_mutex second).
> > +	 * operations is done with invalidate_lock in addition to
> > +	 * i_truncate_mutex.  Only zonefs_seq_file_truncate() takes both lock
> > +	 * (invalidate_lock first, i_truncate_mutex second).
> >  	 */
> >  	struct mutex		i_truncate_mutex;
> > -	struct rw_semaphore	i_mmap_sem;
> >  
> >  	/* guarded by i_truncate_mutex */
> >  	unsigned int		i_wr_refcnt;
> > 
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
