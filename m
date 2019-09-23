Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E88AFBB97A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 18:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389122AbfIWQVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 12:21:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:52292 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388951AbfIWQVF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:21:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0E2CAF7B;
        Mon, 23 Sep 2019 16:21:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F294A1E4669; Mon, 23 Sep 2019 18:21:15 +0200 (CEST)
Date:   Mon, 23 Sep 2019 18:21:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: Re: [PATCH v3 2/6] ext4: move inode extension/truncate code out from
 ext4_iomap_end()
Message-ID: <20190923162115.GG20367@quack2.suse.cz>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <784214745d589dd2bdcde2d69a69e837e6980592.1568282664.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <784214745d589dd2bdcde2d69a69e837e6980592.1568282664.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 12-09-19 21:04:00, Matthew Bobrowski wrote:
> @@ -233,12 +234,90 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
>  	return iov_iter_count(from);
>  }
>  
> +static int ext4_handle_inode_extension(struct inode *inode, loff_t offset,
> +				       ssize_t len, size_t count)

Traditionally, we call one of the length arguments 'copied' or 'written' to
denote actual amount of data processed and the original length is called
'len' or 'length' in iomap code. Can you please rename the arguments to
follow this convention?

> +{
> +	handle_t *handle;
> +	bool truncate = false;
> +	ext4_lblk_t written_blk, end_blk;
> +	int ret = 0, blkbits = inode->i_blkbits;
> +
> +	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> +	if (IS_ERR(handle)) {
> +		ret = PTR_ERR(handle);
> +		goto orphan_del;
> +	}
> +
> +	if (ext4_update_inode_size(inode, offset + len))
> +		ext4_mark_inode_dirty(handle, inode);
> +
> +	/*
> +	 * We may need truncate allocated but not written blocks
> +	 * beyond EOF.
> +	 */
> +	written_blk = ALIGN(offset + len, 1 << blkbits);
> +	end_blk = ALIGN(offset + count, 1 << blkbits);
> +	if (written_blk < end_blk && ext4_can_truncate(inode))
> +		truncate = true;
> +
> +	/*
> +	 * Remove the inode from the orphan list if it has been
> +	 * extended and everything went OK.
> +	 */
> +	if (!truncate && inode->i_nlink)
> +		ext4_orphan_del(handle, inode);
> +	ext4_journal_stop(handle);
> +
> +	if (truncate) {
> +		ext4_truncate_failed_write(inode);
> +orphan_del:
> +		/*
> +		 * If the truncate operation failed early the inode
> +		 * may still be on the orphan list. In that case, we
> +		 * need try remove the inode from the linked list in
> +		 * memory.
> +		 */
> +		if (inode->i_nlink)
> +			ext4_orphan_del(NULL, inode);
> +	}
> +	return ret;
> +}
> +
> +/*
> + * The inode may have been placed onto the orphan list or has had
> + * blocks allocated beyond EOF as a result of an extension. We need to
> + * ensure that any necessary cleanup routines are performed if the
> + * error path has been taken for a write.
> + */
> +static int ext4_handle_failed_inode_extension(struct inode *inode, loff_t size)
> +{
> +	handle_t *handle;
> +
> +	if (size > i_size_read(inode))
> +		ext4_truncate_failed_write(inode);
> +
> +	if (!list_empty(&EXT4_I(inode)->i_orphan)) {
> +		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> +		if (IS_ERR(handle)) {
> +			if (inode->i_nlink)
> +				ext4_orphan_del(NULL, inode);
> +			return PTR_ERR(handle);
> +		}
> +		if (inode->i_nlink)
> +			ext4_orphan_del(handle, inode);
> +		ext4_journal_stop(handle);
> +	}
> +	return 0;
> +}
> +

After some thought, I'd just drop this function and fold the functionality
into ext4_handle_inode_extension() by making it accept negative 'len'
argument indicating error. The code just happens to be the simplest in that
case (see below).

> @@ -255,7 +334,18 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	if (ret)
>  		goto out;
>  
> +	offset = iocb->ki_pos;
>  	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
> +	if (ret > 0 && iocb->ki_pos > i_size_read(inode))
> +		error = ext4_handle_inode_extension(inode, offset, ret,
> +						    iov_iter_count(from));

You need to sample iov_iter_count(from) before calling dax_iomap_rw(). At
this point iov_iter_count(from) is just what's left in the iter after
writing what we could.

Also I don't think the condition iocb->ki_pos > i_size_read(inode) is
correct here. Because it may happen that offset + count > i_size so we
allocate some blocks beyond i_size but then we manage to copy only less so
offset + ret == iocb->ki_pos <= i_size and you will not call
ext4_handle_inode_extension() to truncate allocated blocks beyond i_size.

So I'd just call ext4_handle_inode_extension() unconditionally like:

	error = ext4_handle_inode_extension(inode, offset, ret, len);

and have a quick check at the beginning of that function to avoid starting
transaction when there isn't anything to do. Something like:

	/*
	 * DIO and DAX writes get exclusion from truncate (i_rwsem) and
	 * page writeback (i_rwsem and flushing all dirty pages).
	 */
	WARN_ON_ONCE(i_size_read(inode) != EXT4_I(inode)->i_disksize);
	if (offset + count <= i_size_read(inode))
		return 0;
	if (len < 0)
		goto truncate;

	... do the heavylifting with transaction start, inode size update,
	and orphan handling...

	if (truncate) {
truncate:
		ext4_truncate_failed_write(inode);
orphan_del:
		/*
		 * If the truncate operation failed early the inode
		 * may still be on the orphan list. In that case, we
		 * need try remove the inode from the linked list in
		 * memory.
		 */
		if (inode->i_nlink)
			ext4_orphan_del(NULL, inode);
	}

> +
> +	if (ret < 0)
> +		error = ext4_handle_failed_inode_extension(inode,
> +							   iocb->ki_pos);
> +
> +	if (error)
> +		ret = error;
>  out:
>  	inode_unlock(inode);
>  	if (ret > 0)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
