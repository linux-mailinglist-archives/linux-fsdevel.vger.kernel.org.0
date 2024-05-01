Return-Path: <linux-fsdevel+bounces-18413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 924ED8B86C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 10:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF0B1F24053
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 08:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DF74EB31;
	Wed,  1 May 2024 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="iafXz9zO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2514CE1F
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 May 2024 08:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714551079; cv=none; b=P1o+28wMSZ3J/Qu5FRNAQFoHaTbk9h/BSzzzBlEd9poLJA4sf/AGxk3tQuzFSqkDqKVKzymMlsWEppPEi67Rta+jLRpqt7jky0cxpjlKbbP2y7jQ1OoMW4jd+FJraKInFEHZYJ5MIsgSynn0PoG0zYcAhNU1gL5vrVaOxQck1Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714551079; c=relaxed/simple;
	bh=rF18oZhZ7iFAHJVUJBC8xUYuRnp+juu+DBURf6UAmNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V498dGURUGEdAAt3lrybaSn4JgE1SOQsN3UHYFKXLRmgm3IAc8gKY33W0mNp02nlzSy0Z2Iut7sXIx4v9h6qNckHczlDCwhNwPN6uSu75JvviUCbWdA2ynFc50ejJLIym4gcspXsPvyYvy70pY3YbiUm4Y4Ei+rfb4muzbf4JRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=iafXz9zO; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6123726725eso2526588a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2024 01:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714551077; x=1715155877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RCv0XoUxtwGu7CqXQBG2S9RvRVUsuvWpS02r0QITg4Y=;
        b=iafXz9zON+eRa0pvgEC7Pu5V6DymnTjYSVh5wUa7Uwbk0Hjxjej6X+NqnzRHztPgSR
         0sWWGEk8o8ZIOYc7kyIbIs4YyIhbd/ZN4ZJqH4HK3EYFFlizgdn/pd31NNVSYftrUua/
         9xGzoDfvIxJiTI6IK14I6Ckjp3PVRJrzIsLY7eW/NOtDLGlz2HYw7Lv1mB5JlZ0gsXNM
         8gcDuf/m4gEXiy9BtGV1BJqCVFoAyvjtK1YWcHt36HznEdPb4HSBUVU50yC9b/fRo0IB
         G0hn778CWNU+jr/Sw/i3bQA+Aon/LdyouwrMV8UJQdMqn5Sfce1lZv5sLbSHFaJopVdV
         TLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714551077; x=1715155877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCv0XoUxtwGu7CqXQBG2S9RvRVUsuvWpS02r0QITg4Y=;
        b=QSPprpPrVGq4IRUggloti9MqV22DWOrb6Yy2r2aIaA9RNohkwBdyarOyQ/WhWVVE3G
         2+Zf9Tn6zVmAPDM6D5yD17Qt5clg1ZmM2xC9ypUXS7m2n0GLj3cK2CbXriiZkSm8UJwP
         NoeZxw5MNz5O+E1MJ7a/0NTTiARtGD+4T+cDZw7GVMmmRFyOtmu6QHwdrSMCleUE/RBp
         Lnf0Ctcg9rVx66qtG1pTr6UpqE859v1eRkToxhOyOv93MGe9JGKdQNaHdyCM8H7gZgVE
         Q0dxYvc/1dPMc6FYsUq0rBKNO5nDfeNTMLcbvGMVWvlc3EqY7JQWhJ6pX9tND0DWYtSk
         E3Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVkCh3Ga7ZodK4hu/T5t+k0SYhdxZdo83TbHfb1HVtYbgDmZFd/bovFebpriWKcEeDhWt+1go0RzsuzxniZVaXLFeY5MhBqq64lb3FX3w==
X-Gm-Message-State: AOJu0YwaT63G7CEPQNggfCNdCY6iRWMqyf6eCrj/FQTFNi6HdZuNP07S
	FdXMV4j/oUXhWyxxv/6cxQrdPUDJrZ2wiyQvNf2vghZ/qPYgzHnVN9HBvtS4XL8=
X-Google-Smtp-Source: AGHT+IFTWLbPFA+nd6gmvYTqwqnSgDqVXNKVB+O1GG6+9S4CZi8Sdb0Tf1uHIFSH1D9IBisDluOtEw==
X-Received: by 2002:a05:6a21:8196:b0:1aa:59ff:5902 with SMTP id pd22-20020a056a21819600b001aa59ff5902mr2127063pzb.9.1714551076783;
        Wed, 01 May 2024 01:11:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id i16-20020a170902c95000b001eb542b85aasm7769134pla.117.2024.05.01.01.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 01:11:16 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s253Z-00H9G8-1s;
	Wed, 01 May 2024 18:11:13 +1000
Date: Wed, 1 May 2024 18:11:13 +1000
From: Dave Chinner <david@fromorbit.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	hch@infradead.org, djwong@kernel.org, willy@infradead.org,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH v4 24/34] ext4: implement buffered write iomap path
Message-ID: <ZjH5Ia+dWGss5Duv@dread.disaster.area>
References: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
 <20240410142948.2817554-25-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410142948.2817554-25-yi.zhang@huaweicloud.com>

On Wed, Apr 10, 2024 at 10:29:38PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Implement buffered write iomap path, use ext4_da_map_blocks() to map
> delalloc extents and add ext4_iomap_get_blocks() to allocate blocks if
> delalloc is disabled or free space is about to run out.
> 
> Note that we always allocate unwritten extents for new blocks in the
> iomap write path, this means that the allocation type is no longer
> controlled by the dioread_nolock mount option. After that, we could
> postpone the i_disksize updating to the writeback path, and drop journal
> handle in the buffered dealloc write path completely.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/ext4.h  |   3 +
>  fs/ext4/file.c  |  19 +++++-
>  fs/ext4/inode.c | 168 ++++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 183 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 05949a8136ae..2bd543c43341 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2970,6 +2970,7 @@ int ext4_walk_page_buffers(handle_t *handle,
>  				     struct buffer_head *bh));
>  int do_journal_get_write_access(handle_t *handle, struct inode *inode,
>  				struct buffer_head *bh);
> +int ext4_nonda_switch(struct super_block *sb);
>  #define FALL_BACK_TO_NONDELALLOC 1
>  #define CONVERT_INLINE_DATA	 2
>  
> @@ -3827,6 +3828,8 @@ static inline void ext4_clear_io_unwritten_flag(ext4_io_end_t *io_end)
>  extern const struct iomap_ops ext4_iomap_ops;
>  extern const struct iomap_ops ext4_iomap_overwrite_ops;
>  extern const struct iomap_ops ext4_iomap_report_ops;
> +extern const struct iomap_ops ext4_iomap_buffered_write_ops;
> +extern const struct iomap_ops ext4_iomap_buffered_da_write_ops;
>  
>  static inline int ext4_buffer_uptodate(struct buffer_head *bh)
>  {
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 54d6ff22585c..52f37c49572a 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -282,6 +282,20 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
>  	return count;
>  }
>  
> +static ssize_t ext4_iomap_buffered_write(struct kiocb *iocb,
> +					 struct iov_iter *from)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	const struct iomap_ops *iomap_ops;
> +
> +	if (test_opt(inode->i_sb, DELALLOC) && !ext4_nonda_switch(inode->i_sb))
> +		iomap_ops = &ext4_iomap_buffered_da_write_ops;
> +	else
> +		iomap_ops = &ext4_iomap_buffered_write_ops;
> +
> +	return iomap_file_buffered_write(iocb, from, iomap_ops);
> +}
> +
>  static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
>  					struct iov_iter *from)
>  {
> @@ -296,7 +310,10 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
>  	if (ret <= 0)
>  		goto out;
>  
> -	ret = generic_perform_write(iocb, from);
> +	if (ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP))
> +		ret = ext4_iomap_buffered_write(iocb, from);
> +	else
> +		ret = generic_perform_write(iocb, from);
>  
>  out:
>  	inode_unlock(inode);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 20eb772f4f62..e825ed16fd60 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2857,7 +2857,7 @@ static int ext4_dax_writepages(struct address_space *mapping,
>  	return ret;
>  }
>  
> -static int ext4_nonda_switch(struct super_block *sb)
> +int ext4_nonda_switch(struct super_block *sb)
>  {
>  	s64 free_clusters, dirty_clusters;
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
> @@ -3254,6 +3254,15 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
>  	return inode->i_state & I_DIRTY_DATASYNC;
>  }
>  
> +static bool ext4_iomap_valid(struct inode *inode, const struct iomap *iomap)
> +{
> +	return iomap->validity_cookie == READ_ONCE(EXT4_I(inode)->i_es_seq);
> +}
> +
> +static const struct iomap_folio_ops ext4_iomap_folio_ops = {
> +	.iomap_valid = ext4_iomap_valid,
> +};
> +
>  static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
>  			   struct ext4_map_blocks *map, loff_t offset,
>  			   loff_t length, unsigned int flags)
> @@ -3284,6 +3293,9 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
>  	    !ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>  		iomap->flags |= IOMAP_F_MERGED;
>  
> +	iomap->validity_cookie = READ_ONCE(EXT4_I(inode)->i_es_seq);
> +	iomap->folio_ops = &ext4_iomap_folio_ops;
> +
>  	/*
>  	 * Flags passed to ext4_map_blocks() for direct I/O writes can result
>  	 * in m_flags having both EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN bits
> @@ -3523,11 +3535,42 @@ const struct iomap_ops ext4_iomap_report_ops = {
>  	.iomap_begin = ext4_iomap_begin_report,
>  };
>  
> -static int ext4_iomap_buffered_io_begin(struct inode *inode, loff_t offset,
> +static int ext4_iomap_get_blocks(struct inode *inode,
> +				 struct ext4_map_blocks *map)
> +{
> +	handle_t *handle;
> +	int ret, needed_blocks;
> +
> +	/*
> +	 * Reserve one block more for addition to orphan list in case
> +	 * we allocate blocks but write fails for some reason.
> +	 */
> +	needed_blocks = ext4_writepage_trans_blocks(inode) + 1;
> +	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE, needed_blocks);
> +	if (IS_ERR(handle))
> +		return PTR_ERR(handle);
> +
> +	ret = ext4_map_blocks(handle, inode, map,
> +			      EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT);
> +	/*
> +	 * Have to stop journal here since there is a potential deadlock
> +	 * caused by later balance_dirty_pages(), it might wait on the
> +	 * ditry pages to be written back, which might start another
> +	 * handle and wait this handle stop.
> +	 */
> +	ext4_journal_stop(handle);
> +
> +	return ret;
> +}
> +
> +#define IOMAP_F_EXT4_DELALLOC		IOMAP_F_PRIVATE
> +
> +static int __ext4_iomap_buffered_io_begin(struct inode *inode, loff_t offset,
>  				loff_t length, unsigned int iomap_flags,
> -				struct iomap *iomap, struct iomap *srcmap)
> +				struct iomap *iomap, struct iomap *srcmap,
> +				bool delalloc)
>  {
> -	int ret;
> +	int ret, retries = 0;
>  	struct ext4_map_blocks map;
>  	u8 blkbits = inode->i_blkbits;
>  
> @@ -3537,20 +3580,133 @@ static int ext4_iomap_buffered_io_begin(struct inode *inode, loff_t offset,
>  		return -EINVAL;
>  	if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
>  		return -ERANGE;
> -
> +retry:
>  	/* Calculate the first and last logical blocks respectively. */
>  	map.m_lblk = offset >> blkbits;
>  	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
>  			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
> +	if (iomap_flags & IOMAP_WRITE) {
> +		if (delalloc)
> +			ret = ext4_da_map_blocks(inode, &map);
> +		else
> +			ret = ext4_iomap_get_blocks(inode, &map);
>  
> -	ret = ext4_map_blocks(NULL, inode, &map, 0);
> +		if (ret == -ENOSPC &&
> +		    ext4_should_retry_alloc(inode->i_sb, &retries))
> +			goto retry;
> +	} else {
> +		ret = ext4_map_blocks(NULL, inode, &map, 0);
> +	}
>  	if (ret < 0)
>  		return ret;
>  
>  	ext4_set_iomap(inode, iomap, &map, offset, length, iomap_flags);
> +	if (delalloc)
> +		iomap->flags |= IOMAP_F_EXT4_DELALLOC;
> +
> +	return 0;
> +}

Why are you implementing both read and write mapping paths in
the one function? The whole point of having separate ops vectors for
read and write is that it allows a clean separation of the read and
write mapping operations. i.e. there is no need to use "if (write)
else {do read}" code constructs at all.

You can even have a different delalloc mapping function so you don't
need "if (delalloc) else {do nonda}" branches everiywhere...

> +
> +static inline int ext4_iomap_buffered_io_begin(struct inode *inode,
> +			loff_t offset, loff_t length, unsigned int flags,
> +			struct iomap *iomap, struct iomap *srcmap)
> +{
> +	return __ext4_iomap_buffered_io_begin(inode, offset, length, flags,
> +					      iomap, srcmap, false);
> +}
> +
> +static inline int ext4_iomap_buffered_da_write_begin(struct inode *inode,
> +			loff_t offset, loff_t length, unsigned int flags,
> +			struct iomap *iomap, struct iomap *srcmap)
> +{
> +	return __ext4_iomap_buffered_io_begin(inode, offset, length, flags,
> +					      iomap, srcmap, true);
> +}
> +
> +/*
> + * Drop the staled delayed allocation range from the write failure,
> + * including both start and end blocks. If not, we could leave a range
> + * of delayed extents covered by a clean folio, it could lead to
> + * inaccurate space reservation.
> + */
> +static int ext4_iomap_punch_delalloc(struct inode *inode, loff_t offset,
> +				     loff_t length)
> +{
> +	ext4_es_remove_extent(inode, offset >> inode->i_blkbits,
> +			DIV_ROUND_UP_ULL(length, EXT4_BLOCK_SIZE(inode->i_sb)));
>  	return 0;
>  }
>  
> +static int ext4_iomap_buffered_write_end(struct inode *inode, loff_t offset,
> +					 loff_t length, ssize_t written,
> +					 unsigned int flags,
> +					 struct iomap *iomap)
> +{
> +	handle_t *handle;
> +	loff_t end;
> +	int ret = 0, ret2;
> +
> +	/* delalloc */
> +	if (iomap->flags & IOMAP_F_EXT4_DELALLOC) {
> +		ret = iomap_file_buffered_write_punch_delalloc(inode, iomap,
> +			offset, length, written, ext4_iomap_punch_delalloc);
> +		if (ret)
> +			ext4_warning(inode->i_sb,
> +			     "Failed to clean up delalloc for inode %lu, %d",
> +			     inode->i_ino, ret);
> +		return ret;
> +	}

Why are you creating a delalloc extent for the write operation and
then immediately deleting it from the extent tree once the write
operation is done? Delayed allocation is a state that persists for
that file range until the data is written back, right, but this
appears to return the range to a hole in the extent state tree?

What happens when we do a second write to this same range? WIll it
do another delayed allocation because there are no extents over this
range?

Also, why do you need IOMAP_F_EXT4_DELALLOC? Isn't a delalloc iomap
set up with iomap->type = IOMAP_DELALLOC? Why can't that be used?

-Dave.

-- 
Dave Chinner
david@fromorbit.com

