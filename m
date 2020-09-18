Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0EC26F99B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 11:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIRJwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 05:52:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:58042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgIRJwN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:52:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2D05B170;
        Fri, 18 Sep 2020 09:52:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AF9491E12E1; Fri, 18 Sep 2020 11:52:10 +0200 (CEST)
Date:   Fri, 18 Sep 2020 11:52:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        dan.j.williams@intel.com, anju@linux.vnet.ibm.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/1] ext4: Optimize file overwrites
Message-ID: <20200918095210.GE18920@quack2.suse.cz>
References: <cover.1600401668.git.riteshh@linux.ibm.com>
 <88e795d8a4d5cd22165c7ebe857ba91d68d8813e.1600401668.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88e795d8a4d5cd22165c7ebe857ba91d68d8813e.1600401668.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 18-09-20 10:36:35, Ritesh Harjani wrote:
> In case if the file already has underlying blocks/extents allocated
> then we don't need to start a journal txn and can directly return
> the underlying mapping. Currently ext4_iomap_begin() is used by
> both DAX & DIO path. We can check if the write request is an
> overwrite & then directly return the mapping information.
> 
> This could give a significant perf boost for multi-threaded writes
> specially random overwrites.
> On PPC64 VM with simulated pmem(DAX) device, ~10x perf improvement
> could be seen in random writes (overwrite). Also bcoz this optimizes
> away the spinlock contention during jbd2 slab cache allocation
> (jbd2_journal_handle). On x86 VM, ~2x perf improvement was observed.
> 
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 10dd470876b3..6eae17758ece 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3437,14 +3437,26 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
>  			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
>  
> -	if (flags & IOMAP_WRITE)
> +	if (flags & IOMAP_WRITE) {
> +		/*
> +		 * We check here if the blocks are already allocated, then we
> +		 * don't need to start a journal txn and we can directly return
> +		 * the mapping information. This could boost performance
> +		 * especially in multi-threaded overwrite requests.
> +		 */
> +		if (offset + length <= i_size_read(inode)) {
> +			ret = ext4_map_blocks(NULL, inode, &map, 0);
> +			if (ret > 0 && (map.m_flags & EXT4_MAP_MAPPED))
> +				goto out;
> +		}
>  		ret = ext4_iomap_alloc(inode, &map, flags);
> -	else
> +	} else {
>  		ret = ext4_map_blocks(NULL, inode, &map, 0);
> +	}
>  
>  	if (ret < 0)
>  		return ret;
> -
> +out:
>  	ext4_set_iomap(inode, iomap, &map, offset, length);
>  
>  	return 0;
> -- 
> 2.26.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
