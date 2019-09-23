Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9188FBB78B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 17:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfIWPIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 11:08:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:42800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726054AbfIWPIn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:08:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7C50AB9B;
        Mon, 23 Sep 2019 15:08:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 865BE1E4669; Mon, 23 Sep 2019 17:08:56 +0200 (CEST)
Date:   Mon, 23 Sep 2019 17:08:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: Re: [PATCH v3 4/6] ext4: reorder map.m_flags checks in
 ext4_iomap_begin()
Message-ID: <20190923150856.GE20367@quack2.suse.cz>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <8aa099e66ece73578f32cbbc411b6f3e52d53e52.1568282664.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aa099e66ece73578f32cbbc411b6f3e52d53e52.1568282664.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 12-09-19 21:04:30, Matthew Bobrowski wrote:
> For iomap direct IO write code path changes, we need to accommodate
> for the case where the block mapping flags passed to ext4_map_blocks()
> will result in m_flags having both EXT4_MAP_MAPPED and
> EXT4_MAP_UNWRITTEN bits set. In order for the allocated unwritten
> extents to be converted properly in the end_io handler, iomap->type
> must be set to IOMAP_UNWRITTEN, so we need to reshuffle the
> conditional statement in order to achieve this.
> 
> This change is a no-op for DAX code path as the block mapping flag
> passed to ext4_map_blocks() when IS_DAX(inode) never results in
> EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN being set at once.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 761ce6286b05..efb184928e51 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3581,10 +3581,21 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  		iomap->type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
>  		iomap->addr = IOMAP_NULL_ADDR;
>  	} else {
> -		if (map.m_flags & EXT4_MAP_MAPPED) {
> -			iomap->type = IOMAP_MAPPED;
> -		} else if (map.m_flags & EXT4_MAP_UNWRITTEN) {
> +		/*
> +		 * Flags passed to ext4_map_blocks() for direct IO
> +		 * writes can result in m_flags having both
> +		 * EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN bits set. In
> +		 * order for allocated unwritten extents to be
> +		 * converted to written extents in the end_io handler
> +		 * correctly, we need to ensure that the iomap->type
> +		 * is also set appropriately in that case. Thus, we
> +		 * need to check whether EXT4_MAP_UNWRITTEN is set
> +		 * first.
> +		 */
> +		if (map.m_flags & EXT4_MAP_UNWRITTEN) {
>  			iomap->type = IOMAP_UNWRITTEN;
> +		} else if (map.m_flags & EXT4_MAP_MAPPED) {
> +			iomap->type = IOMAP_MAPPED;
>  		} else {
>  			WARN_ON_ONCE(1);
>  			return -EIO;
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
