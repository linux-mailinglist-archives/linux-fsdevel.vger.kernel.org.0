Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557D524BCD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 14:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbgHTMyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 08:54:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:43960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730541AbgHTMxD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 08:53:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3ECC6B0BA;
        Thu, 20 Aug 2020 12:53:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CCF4A1E1312; Thu, 20 Aug 2020 14:53:00 +0200 (CEST)
Date:   Thu, 20 Aug 2020 14:53:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC 1/1] ext4: Optimize ext4 DAX overwrites
Message-ID: <20200820125300.GK1902@quack2.suse.cz>
References: <cover.1597855360.git.riteshh@linux.ibm.com>
 <696f5386f1c306e769be409c8b1d90a3358bbf8d.1597855360.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <696f5386f1c306e769be409c8b1d90a3358bbf8d.1597855360.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 20-08-20 17:06:28, Ritesh Harjani wrote:
> Currently in case of DAX, we are starting a transaction
> everytime for IOMAP_WRITE case. This can be optimized
> away in case of an overwrite (where the blocks were already
> allocated). This could give a significant performance boost
> for multi-threaded random writes.
> 
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Thanks for returning to this and I'm glad to see how much this helped :)
BTW, I'd suspect there could be also significant contention and cache line
bouncing on j_state_lock and transaction's atomic counters...

> ---
>  fs/ext4/ext4.h  | 1 +
>  fs/ext4/file.c  | 2 +-
>  fs/ext4/inode.c | 8 +++++++-
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 42f5060f3cdf..9a2138afc751 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3232,6 +3232,7 @@ extern const struct dentry_operations ext4_dentry_ops;
>  extern const struct inode_operations ext4_file_inode_operations;
>  extern const struct file_operations ext4_file_operations;
>  extern loff_t ext4_llseek(struct file *file, loff_t offset, int origin);
> +extern bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len);
>  
>  /* inline.c */
>  extern int ext4_get_max_inline_size(struct inode *inode);
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 2a01e31a032c..51cd92ac1758 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -188,7 +188,7 @@ ext4_extending_io(struct inode *inode, loff_t offset, size_t len)
>  }
>  
>  /* Is IO overwriting allocated and initialized blocks? */
> -static bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len)
> +bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len)
>  {
>  	struct ext4_map_blocks map;
>  	unsigned int blkbits = inode->i_blkbits;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 10dd470876b3..f0ac0ee9e991 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3423,6 +3423,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  	int ret;
>  	struct ext4_map_blocks map;
>  	u8 blkbits = inode->i_blkbits;
> +	bool overwrite = false;
>  
>  	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
>  		return -EINVAL;
> @@ -3430,6 +3431,9 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  	if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
>  		return -ERANGE;
>  
> +	if (IS_DAX(inode) && (flags & IOMAP_WRITE) &&
> +	    ext4_overwrite_io(inode, offset, length))
> +		overwrite = true;

So the patch looks correct but using ext4_overwrite_io() seems a bit
foolish since under the hood it does ext4_map_blocks() only to be able to
decide whether to call ext4_map_blocks() once again with exactly the same
arguments :). So I'd rather slightly refactor the code in
ext4_iomap_begin() to avoid this double calling of ext4_map_blocks() for
the fast path.

								Honza

>  	/*
>  	 * Calculate the first and last logical blocks respectively.
>  	 */
> @@ -3437,13 +3441,15 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
>  			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
>  
> -	if (flags & IOMAP_WRITE)
> +	if ((flags & IOMAP_WRITE) && !overwrite)
>  		ret = ext4_iomap_alloc(inode, &map, flags);
>  	else
>  		ret = ext4_map_blocks(NULL, inode, &map, 0);
>  
>  	if (ret < 0)
>  		return ret;
> +	if (IS_DAX(inode) && overwrite)
> +		WARN_ON(!(map.m_flags & EXT4_MAP_MAPPED));
>  
>  	ext4_set_iomap(inode, iomap, &map, offset, length);
>  
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
