Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02C3A16FF2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 13:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgBZMjn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 07:39:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:47458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgBZMjn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:39:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 33F7CAC53;
        Wed, 26 Feb 2020 12:39:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B73541E0EA2; Wed, 26 Feb 2020 13:39:40 +0100 (CET)
Date:   Wed, 26 Feb 2020 13:39:40 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, hch@infradead.org, cmaiolino@redhat.com
Subject: Re: [PATCHv3 4/6] ext4: Make ext4_ind_map_blocks work with fiemap
Message-ID: <20200226123940.GP10728@quack2.suse.cz>
References: <cover.1582702693.git.riteshh@linux.ibm.com>
 <56fc8d3802c578d27d49270600946a0737cef119.1582702694.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56fc8d3802c578d27d49270600946a0737cef119.1582702694.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 26-02-20 15:27:06, Ritesh Harjani wrote:
> For indirect block mapping if the i_block > max supported block in inode
> then ext4_ind_map_blocks may return a -EIO error. But in case of fiemap
> this could be a valid query to ext4_map_blocks.
> So in case if !create then return 0. This also makes ext4_warning to
> ext4_debug in ext4_block_to_path() for the same reason.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Hmm, won't it be cleaner to just handle this in ext4_iomap_begin_report()?
We do trim map.m_len there anyway so it is only logical to trim it to
proper value supported by the inode on-disk format... BTW, note we have
sbi->s_bitmap_maxbytes value already computed in the superblock...

								Honza

> ---
>  fs/ext4/indirect.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
> index 3a4ab70fe9e0..e1ab495dd900 100644
> --- a/fs/ext4/indirect.c
> +++ b/fs/ext4/indirect.c
> @@ -102,7 +102,11 @@ static int ext4_block_to_path(struct inode *inode,
>  		offsets[n++] = i_block & (ptrs - 1);
>  		final = ptrs;
>  	} else {
> -		ext4_warning(inode->i_sb, "block %lu > max in inode %lu",
> +		/*
> +		 * It's not yet an error to just query beyond max
> +		 * block in inode. Fiemap callers may do so.
> +		 */
> +		ext4_debug("block %lu > max in inode %lu",
>  			     i_block + direct_blocks +
>  			     indirect_blocks + double_blocks, inode->i_ino);
>  	}
> @@ -537,8 +541,11 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
>  	depth = ext4_block_to_path(inode, map->m_lblk, offsets,
>  				   &blocks_to_boundary);
>  
> -	if (depth == 0)
> +	if (depth == 0) {
> +		if (!(flags & EXT4_GET_BLOCKS_CREATE))
> +			err = 0;
>  		goto out;
> +	}
>  
>  	partial = ext4_get_branch(inode, depth, offsets, chain, &err);
>  
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
