Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA22A171657
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 12:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgB0Lt0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 06:49:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:47416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729042AbgB0LtZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:49:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BB694AC54;
        Thu, 27 Feb 2020 11:49:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 82D1F1E0E88; Thu, 27 Feb 2020 12:49:23 +0100 (CET)
Date:   Thu, 27 Feb 2020 12:49:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, hch@infradead.org, cmaiolino@redhat.com,
        david@fromorbit.com
Subject: Re: [PATCHv4 4/6] ext4: Make ext4_ind_map_blocks work with fiemap
Message-ID: <20200227114923.GB10728@quack2.suse.cz>
References: <cover.1582800839.git.riteshh@linux.ibm.com>
 <9657f0570bd4163ee85afc6d949c864f7cba20fa.1582800839.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9657f0570bd4163ee85afc6d949c864f7cba20fa.1582800839.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 27-02-20 16:40:25, Ritesh Harjani wrote:
> For indirect block mapping if the i_block > max supported block in inode
> then ext4_ind_map_blocks() returns a -EIO error. But in case of fiemap
> this could be a valid query to ->iomap_begin call.
> So check if the offset >= s_bitmap_maxbytes in ext4_iomap_begin_report(),
> then simply skip calling ext4_map_blocks().
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 81fccbae0aea..4364864fc709 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3548,12 +3548,28 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
>  	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
>  			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
>  
> +	/*
> +	 * Fiemap callers may call for offset beyond s_bitmap_maxbytes.
> +	 * So handle it here itself instead of querying ext4_map_blocks().
> +	 * Since ext4_map_blocks() will warn about it and will return
> +	 * -EIO error.
> +	 */
> +	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
> +		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +
> +		if (offset >= sbi->s_bitmap_maxbytes) {
> +			map.m_flags = 0;
> +			goto set_iomap;
> +		}
> +	}
> +
>  	ret = ext4_map_blocks(NULL, inode, &map, 0);
>  	if (ret < 0)
>  		return ret;
>  	if (ret == 0)
>  		delalloc = ext4_iomap_is_delalloc(inode, &map);
>  
> +set_iomap:
>  	ext4_set_iomap(inode, iomap, &map, offset, length);
>  	if (delalloc && iomap->type == IOMAP_HOLE)
>  		iomap->type = IOMAP_DELALLOC;
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
