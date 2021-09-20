Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC433412612
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 20:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353962AbhITSxG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 14:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1385892AbhITSwh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:52:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A9246139F;
        Mon, 20 Sep 2021 18:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632161520;
        bh=ORmP/PpPJ4jZv08mjHln2oqKkpHLuOqF1ihYmPqRs1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dxZiKWWKKbX8AXKdt5JDau76nGaxqmB0tHzbHotum6rV0iJ3SbWqgQLMYLWrtZctM
         cUDXXOvr+Fv6W0R+v6K3SN1Ya07sfEm+xGlKjDxKAISZqDConQz1ts3reRSkHrVPvS
         w7gk/dtgvfO3xRgvwD+LJm7rtF0bgyzLKHRsd6X1B8KG/u1R9LnQKDat7w3ASLC951
         mE9RjY8U4+13AXlnHyj2LgTMqZzRK7AWJH9M+JJVQFfgTETaZiUio0j8f3EMuWlrGe
         DgwVrdvaxLpSpU9by9Rq2dFxJqAEpAoqVFzuJ+bSzknR6Ct8uD24AqSCcGqIR3ANJH
         Gyp7BrpM5K8OA==
Date:   Mon, 20 Sep 2021 11:11:59 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     riteshh <riteshh@linux.ibm.com>
Cc:     jane.chu@oracle.com, linux-xfs@vger.kernel.org, hch@infradead.org,
        dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 5/5] ext4: implement FALLOC_FL_ZEROINIT_RANGE
Message-ID: <20210920181159.GA570565@magnolia>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
 <163192867220.417973.4913917281472586603.stgit@magnolia>
 <20210918170757.j5yjxo34thzks5iv@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918170757.j5yjxo34thzks5iv@riteshh-domain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 18, 2021 at 10:37:57PM +0530, riteshh wrote:
> +cc linux-ext4
> 
> [Thread]: https://lore.kernel.org/linux-xfs/163192864476.417973.143014658064006895.stgit@magnolia/T/#t
> 
> On 21/09/17 06:31PM, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Implement this new fallocate mode so that persistent memory users can,
> > upon receipt of a pmem poison notification, cause the pmem to be
> > reinitialized to a known value (zero) and clear any hardware poison
> > state that might be lurking.
> >
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  fs/ext4/extents.c           |   93 +++++++++++++++++++++++++++++++++++++++++++
> >  include/trace/events/ext4.h |    7 +++
> >  2 files changed, 99 insertions(+), 1 deletion(-)
> >
> >
> > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > index c0de30f25185..c345002e2da6 100644
> > --- a/fs/ext4/extents.c
> > +++ b/fs/ext4/extents.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/fiemap.h>
> >  #include <linux/backing-dev.h>
> >  #include <linux/iomap.h>
> > +#include <linux/dax.h>
> >  #include "ext4_jbd2.h"
> >  #include "ext4_extents.h"
> >  #include "xattr.h"
> > @@ -4475,6 +4476,90 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len);
> >
> >  static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len);
> >
> > +static long ext4_zeroinit_range(struct file *file, loff_t offset, loff_t len)
> > +{
> > +	struct inode *inode = file_inode(file);
> > +	struct address_space *mapping = inode->i_mapping;
> > +	handle_t *handle = NULL;
> > +	loff_t end = offset + len;
> > +	long ret;
> > +
> > +	trace_ext4_zeroinit_range(inode, offset, len,
> > +			FALLOC_FL_ZEROINIT_RANGE | FALLOC_FL_KEEP_SIZE);
> > +
> > +	/* We don't support data=journal mode */
> > +	if (ext4_should_journal_data(inode))
> > +		return -EOPNOTSUPP;
> > +
> > +	inode_lock(inode);
> > +
> > +	/*
> > +	 * Indirect files do not support unwritten extents
> > +	 */
> > +	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
> > +		ret = -EOPNOTSUPP;
> > +		goto out_mutex;
> > +	}
> > +
> > +	/* Wait all existing dio workers, newcomers will block on i_mutex */
> > +	inode_dio_wait(inode);
> > +
> > +	/*
> > +	 * Prevent page faults from reinstantiating pages we have released from
> > +	 * page cache.
> > +	 */
> > +	filemap_invalidate_lock(mapping);
> > +
> > +	ret = ext4_break_layouts(inode);
> > +	if (ret)
> > +		goto out_mmap;
> > +
> > +	/* Now release the pages and zero block aligned part of pages */
> > +	truncate_pagecache_range(inode, offset, end - 1);
> > +	inode->i_mtime = inode->i_ctime = current_time(inode);
> > +
> > +	if (IS_DAX(inode))
> > +		ret = dax_zeroinit_range(inode, offset, len,
> > +				&ext4_iomap_report_ops);
> > +	else
> > +		ret = iomap_zeroout_range(inode, offset, len,
> > +				&ext4_iomap_report_ops);
> > +	if (ret == -ECANCELED)
> > +		ret = -EOPNOTSUPP;
> > +	if (ret)
> > +		goto out_mmap;
> > +
> > +	/*
> > +	 * In worst case we have to writeout two nonadjacent unwritten
> > +	 * blocks and update the inode
> > +	 */
> 
> Is this comment true? We are actually not touching IOMAP_UNWRITTEN blocks no?
> So is there any need for journal transaction for this?
> We are essentially only writing to blocks which are already allocated on disk
> and zeroing it out in both dax_zeroinit_range() and iomap_zeroinit_range().

Oops.  Yeah, the comment is wrong.  Deleted.

> > +	handle = ext4_journal_start(inode, EXT4_HT_MISC, 1);
> 
> I guess credits is 1 here since only inode is getting modified.

Yep.

> 
> > +	if (IS_ERR(handle)) {
> > +		ret = PTR_ERR(handle);
> > +		ext4_std_error(inode->i_sb, ret);
> > +		goto out_mmap;
> > +	}
> > +
> > +	inode->i_mtime = inode->i_ctime = current_time(inode);
> > +	ret = ext4_mark_inode_dirty(handle, inode);
> > +	if (unlikely(ret))
> > +		goto out_handle;
> > +	ext4_fc_track_range(handle, inode, offset >> inode->i_sb->s_blocksize_bits,
> > +			(offset + len - 1) >> inode->i_sb->s_blocksize_bits);
> 
> I am not sure whether we need ext4_fc_track_range() here?
> We are not doing any metadata operation except maybe updating inode timestamp
> right?

I wasn't sure what fastcommit needs to track about the range.  Is it
/only/ tracking changes to the file mapping?

/me is sadly falling further and further behind on where ext4 is these
days... :/

--D

> 
> -ritesh
> 
> > +	ext4_update_inode_fsync_trans(handle, inode, 1);
> > +
> > +	if (file->f_flags & O_SYNC)
> > +		ext4_handle_sync(handle);
> > +
> > +out_handle:
> > +	ext4_journal_stop(handle);
> > +out_mmap:
> > +	filemap_invalidate_unlock(mapping);
> > +out_mutex:
> > +	inode_unlock(inode);
> > +	return ret;
> > +}
> > +
> >  static long ext4_zero_range(struct file *file, loff_t offset,
> >  			    loff_t len, int mode)
> >  {
> > @@ -4659,7 +4744,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
> >  	/* Return error if mode is not supported */
> >  	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
> >  		     FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
> > -		     FALLOC_FL_INSERT_RANGE))
> > +		     FALLOC_FL_INSERT_RANGE | FALLOC_FL_ZEROINIT_RANGE))
> >  		return -EOPNOTSUPP;
> >
> >  	ext4_fc_start_update(inode);
> > @@ -4687,6 +4772,12 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
> >  		ret = ext4_zero_range(file, offset, len, mode);
> >  		goto exit;
> >  	}
> > +
> > +	if (mode & FALLOC_FL_ZEROINIT_RANGE) {
> > +		ret = ext4_zeroinit_range(file, offset, len);
> > +		goto exit;
> > +	}
> > +
> >  	trace_ext4_fallocate_enter(inode, offset, len, mode);
> >  	lblk = offset >> blkbits;
> >
> > diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> > index 0ea36b2b0662..282f1208067f 100644
> > --- a/include/trace/events/ext4.h
> > +++ b/include/trace/events/ext4.h
> > @@ -1407,6 +1407,13 @@ DEFINE_EVENT(ext4__fallocate_mode, ext4_zero_range,
> >  	TP_ARGS(inode, offset, len, mode)
> >  );
> >
> > +DEFINE_EVENT(ext4__fallocate_mode, ext4_zeroinit_range,
> > +
> > +	TP_PROTO(struct inode *inode, loff_t offset, loff_t len, int mode),
> > +
> > +	TP_ARGS(inode, offset, len, mode)
> > +);
> > +
> >  TRACE_EVENT(ext4_fallocate_exit,
> >  	TP_PROTO(struct inode *inode, loff_t offset,
> >  		 unsigned int max_blocks, int ret),
> >
