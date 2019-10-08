Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 085C1CF82D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 13:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbfJHLaP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 07:30:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:40466 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729876AbfJHLaP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:30:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36A1FAE35;
        Tue,  8 Oct 2019 11:30:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6E84A1E4827; Tue,  8 Oct 2019 13:30:12 +0200 (CEST)
Date:   Tue, 8 Oct 2019 13:30:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 7/8] ext4: reorder map.m_flags checks in
 ext4_set_iomap()
Message-ID: <20191008113012.GJ5078@quack2.suse.cz>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <3551610e53aa1984210a4de04ad6e1a89f5bf0a3.1570100361.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3551610e53aa1984210a4de04ad6e1a89f5bf0a3.1570100361.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 03-10-19 21:34:51, Matthew Bobrowski wrote:
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

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

Just those 72 columns limited comment lines... ;)

								Honza

> ---
>  fs/ext4/inode.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index e133dda55063..63ad23ae05b8 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3420,10 +3420,20 @@ static int ext4_set_iomap(struct inode *inode, struct iomap *iomap, u16 type,
>  		iomap->type = type;
>  		iomap->addr = IOMAP_NULL_ADDR;
>  	} else {
> -		if (map->m_flags & EXT4_MAP_MAPPED) {
> -			iomap->type = IOMAP_MAPPED;
> -		} else if (map->m_flags & EXT4_MAP_UNWRITTEN) {
> +		/*
> +		 * Flags passed to ext4_map_blocks() for direct I/O
> +		 * writes can result in map->m_flags having both
> +		 * EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN bits set. In
> +		 * order for allocated extents to be converted to
> +		 * written extents in the ->end_io handler correctly,
> +		 * we need to ensure that the iomap->type is set
> +		 * approprately. Thus, we need to check whether
> +		 * EXT4_MAP_UNWRITTEN is set first.
> +		 */
> +		if (map->m_flags & EXT4_MAP_UNWRITTEN) {
>  			iomap->type = IOMAP_UNWRITTEN;
> +		} else if (map->m_flags & EXT4_MAP_MAPPED) {
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
