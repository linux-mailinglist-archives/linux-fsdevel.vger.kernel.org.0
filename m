Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F20F816FEEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 13:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgBZM07 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 07:26:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:41826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgBZM07 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:26:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D7234AC53;
        Wed, 26 Feb 2020 12:26:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 926401E0EA2; Wed, 26 Feb 2020 13:26:55 +0100 (CET)
Date:   Wed, 26 Feb 2020 13:26:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, hch@infradead.org, cmaiolino@redhat.com
Subject: Re: [PATCHv3 1/6] ext4: Add IOMAP_F_MERGED for non-extent based
 mapping
Message-ID: <20200226122655.GM10728@quack2.suse.cz>
References: <cover.1582702693.git.riteshh@linux.ibm.com>
 <25695b1a4bc3b5c3a2f513ecb612195aa7154975.1582702693.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25695b1a4bc3b5c3a2f513ecb612195aa7154975.1582702693.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 26-02-20 15:27:03, Ritesh Harjani wrote:
> IOMAP_F_MERGED needs to be set in case of non-extent based mapping.
> This is needed in later patches for conversion of ext4_fiemap to use iomap.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/ext4/inode.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d035acab5b2a..3b4230cf0bc2 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3335,6 +3335,10 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
>  	iomap->offset = (u64) map->m_lblk << blkbits;
>  	iomap->length = (u64) map->m_len << blkbits;
>  
> +	if ((map->m_flags & (EXT4_MAP_UNWRITTEN | EXT4_MAP_MAPPED)) &&
> +		!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
   ^^ we indent the second line of condition either like:

	if ((map->m_flags & (EXT4_MAP_UNWRITTEN | EXT4_MAP_MAPPED)) &&
	    !ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))

or like:

	if ((map->m_flags & (EXT4_MAP_UNWRITTEN | EXT4_MAP_MAPPED)) &&
			!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))

But on at the same level as following code block because that's highly
confusing at times...

Also EXT4_MAP_UNWRITTEN is never set for indirect block mapped files (that
on disk format does not support unwritten extents).

								Honza

> +		iomap->flags |= IOMAP_F_MERGED;
> +
>  	/*
>  	 * Flags passed to ext4_map_blocks() for direct I/O writes can result
>  	 * in m_flags having both EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN bits
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
