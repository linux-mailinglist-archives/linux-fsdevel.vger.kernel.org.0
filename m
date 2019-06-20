Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD9204CCB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 13:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfFTLQA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 07:16:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:42022 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726234AbfFTLQA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 07:16:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 17F02AE82;
        Thu, 20 Jun 2019 11:15:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C461F1E4241; Thu, 20 Jun 2019 13:15:57 +0200 (CEST)
Date:   Thu, 20 Jun 2019 13:15:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ross Zwisler <zwisler@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Fletcher Woodruff <fletcherw@google.com>,
        Justin TerAvest <teravest@google.com>
Subject: Re: [PATCH 3/3] ext4: use jbd2_inode dirty range scoping
Message-ID: <20190620111557.GM13630@quack2.suse.cz>
References: <20190619172156.105508-1-zwisler@google.com>
 <20190619172156.105508-4-zwisler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619172156.105508-4-zwisler@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 19-06-19 11:21:56, Ross Zwisler wrote:
> Use the newly introduced jbd2_inode dirty range scoping to prevent us
> from waiting forever when trying to complete a journal transaction.
> 
> Signed-off-by: Ross Zwisler <zwisler@google.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4_jbd2.h   | 12 ++++++------
>  fs/ext4/inode.c       | 13 ++++++++++---
>  fs/ext4/move_extent.c |  3 ++-
>  3 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index 75a5309f22315..ef8fcf7d0d3b3 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
> @@ -361,20 +361,20 @@ static inline int ext4_journal_force_commit(journal_t *journal)
>  }
>  
>  static inline int ext4_jbd2_inode_add_write(handle_t *handle,
> -					    struct inode *inode)
> +		struct inode *inode, loff_t start_byte, loff_t length)
>  {
>  	if (ext4_handle_valid(handle))
> -		return jbd2_journal_inode_add_write(handle,
> -						    EXT4_I(inode)->jinode);
> +		return jbd2_journal_inode_ranged_write(handle,
> +				EXT4_I(inode)->jinode, start_byte, length);
>  	return 0;
>  }
>  
>  static inline int ext4_jbd2_inode_add_wait(handle_t *handle,
> -					   struct inode *inode)
> +		struct inode *inode, loff_t start_byte, loff_t length)
>  {
>  	if (ext4_handle_valid(handle))
> -		return jbd2_journal_inode_add_wait(handle,
> -						   EXT4_I(inode)->jinode);
> +		return jbd2_journal_inode_ranged_wait(handle,
> +				EXT4_I(inode)->jinode, start_byte, length);
>  	return 0;
>  }
>  
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index c7f77c6430085..27fec5c594459 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -731,10 +731,16 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  		    !(flags & EXT4_GET_BLOCKS_ZERO) &&
>  		    !ext4_is_quota_file(inode) &&
>  		    ext4_should_order_data(inode)) {
> +			loff_t start_byte =
> +				(loff_t)map->m_lblk << inode->i_blkbits;
> +			loff_t length = (loff_t)map->m_len << inode->i_blkbits;
> +
>  			if (flags & EXT4_GET_BLOCKS_IO_SUBMIT)
> -				ret = ext4_jbd2_inode_add_wait(handle, inode);
> +				ret = ext4_jbd2_inode_add_wait(handle, inode,
> +						start_byte, length);
>  			else
> -				ret = ext4_jbd2_inode_add_write(handle, inode);
> +				ret = ext4_jbd2_inode_add_write(handle, inode,
> +						start_byte, length);
>  			if (ret)
>  				return ret;
>  		}
> @@ -4085,7 +4091,8 @@ static int __ext4_block_zero_page_range(handle_t *handle,
>  		err = 0;
>  		mark_buffer_dirty(bh);
>  		if (ext4_should_order_data(inode))
> -			err = ext4_jbd2_inode_add_write(handle, inode);
> +			err = ext4_jbd2_inode_add_write(handle, inode, from,
> +					length);
>  	}
>  
>  unlock:
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 1083a9f3f16a1..c7ded4e2adff5 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -390,7 +390,8 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
>  
>  	/* Even in case of data=writeback it is reasonable to pin
>  	 * inode to transaction, to prevent unexpected data loss */
> -	*err = ext4_jbd2_inode_add_write(handle, orig_inode);
> +	*err = ext4_jbd2_inode_add_write(handle, orig_inode,
> +			(loff_t)orig_page_offset << PAGE_SHIFT, replaced_size);
>  
>  unlock_pages:
>  	unlock_page(pagep[0]);
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
