Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3661FE773A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 18:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbfJ1RET (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 13:04:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42682 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbfJ1RES (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 13:04:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9SGwxDi090607;
        Mon, 28 Oct 2019 17:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=2fxoQefLChE/IW/taayQVgIr+NZVjADXdZe6D/65l88=;
 b=CtKI1Ul5lemySS2KNZ5o92qgms9SvlriuRE8+fw0dMfoUGHk0HQ9o4LXtO7pZL2KVfb4
 VBOAdks/vMsJrcjFo3tBuJukRr16ZS1dbcvya8vn/oShkeh2AyYT8DENg8AxmPRo7jWe
 wGqaqyuIzzSIXPjzCwP+nNmL/UWbOTJZMV2F+VWUXFdsm9BeB7cv+aPyCm4wCY2DU6Hy
 2rXex+uyKZqSE6knvfYiFZfqWehyQFUHfKuMyErBBjgZRJ5HDQxkKR+jKc3Untak3jrZ
 kreMU+2nnp1DIFkmYX/GNA/q9fKYi80W9qKg4ThHvNjYtpyHRWZU3ei+VejhEwyIwQX/ 2w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vvdju3hdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 17:03:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9SH08oi036054;
        Mon, 28 Oct 2019 17:03:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vw09g3fmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 17:03:58 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9SH3suk006611;
        Mon, 28 Oct 2019 17:03:54 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Oct 2019 10:03:53 -0700
Date:   Mon, 28 Oct 2019 10:03:48 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com
Subject: Re: [PATCH v6 04/11] ext4: move set iomap routines into a separate
 helper ext4_set_iomap()
Message-ID: <20191028170348.GA15203@magnolia>
References: <cover.1572255424.git.mbobrowski@mbobrowski.org>
 <36c0b0028215ed0a39697512054f3fa4799b0701.1572255425.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36c0b0028215ed0a39697512054f3fa4799b0701.1572255425.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9424 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910280164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9424 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910280164
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 28, 2019 at 09:51:31PM +1100, Matthew Bobrowski wrote:
> Separate the iomap field population code that is currently within
> ext4_iomap_begin() into a separate helper ext4_set_iomap(). The intent
> of this function is self explanatory, however the rationale behind
> taking this step is to reeduce the overall clutter that we currently
> have within the ext4_iomap_begin() callback.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/ext4/inode.c | 92 +++++++++++++++++++++++++++----------------------
>  1 file changed, 50 insertions(+), 42 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index da2ca81e3d9c..073b7c873bb2 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3406,10 +3406,56 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
>  	return inode->i_state & I_DIRTY_DATASYNC;
>  }
>  
> +static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
> +			   struct ext4_map_blocks *map, loff_t offset,
> +			   loff_t length)
> +{
> +	u8 blkbits = inode->i_blkbits;
> +
> +	/*
> +	 * Writes that span EOF might trigger an I/O size update on completion,
> +	 * so consider them to be dirty for the purpose of O_DSYNC, even if
> +	 * there is no other metadata changes being made or are pending.
> +	 */
> +	iomap->flags = 0;
> +	if (ext4_inode_datasync_dirty(inode) ||
> +	    offset + length > i_size_read(inode))
> +		iomap->flags |= IOMAP_F_DIRTY;
> +
> +	if (map->m_flags & EXT4_MAP_NEW)
> +		iomap->flags |= IOMAP_F_NEW;
> +
> +	iomap->bdev = inode->i_sb->s_bdev;
> +	iomap->dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
> +	iomap->offset = (u64) map->m_lblk << blkbits;
> +	iomap->length = (u64) map->m_len << blkbits;
> +
> +	if (map->m_flags & (EXT4_MAP_MAPPED | EXT4_MAP_UNWRITTEN)) {

/me wonders if this would be easier to follow if it was less indenty:

/*
 * <giant comment from below>
 */
if (m_flags & EXT4_MAP_UNWRITTEN) {
	iomap->type = IOMAP_UNWRITTEN;
	iomap->addr = ...
} else if (m_flags & EXT4_MAP_MAPPED) {
	iomap->type = IOAMP_MAPPED;
	iomap->addr = ...
} else {
	iomap->type = IOMAP_HOLE;
	iomap->addr = IOMAP_NULL_ADDR;
}

Rather than double-checking m_flags?

Otherwise looks fine to me...

--D

> +		/*
> +		 * Flags passed to ext4_map_blocks() for direct I/O writes can
> +		 * result in m_flags having both EXT4_MAP_MAPPED and
> +		 * EXT4_MAP_UNWRITTEN bits set. In order for any allocated
> +		 * unwritten extents to be converted into written extents
> +		 * correctly within the ->end_io() handler, we need to ensure
> +		 * that the iomap->type is set appropriately. Hence, the reason
> +		 * why we need to check whether the EXT4_MAP_UNWRITTEN bit has
> +		 * been set first.
> +		 */
> +		if (map->m_flags & EXT4_MAP_UNWRITTEN)
> +			iomap->type = IOMAP_UNWRITTEN;
> +		else if (map->m_flags & EXT4_MAP_MAPPED)
> +			iomap->type = IOMAP_MAPPED;
> +
> +		iomap->addr = (u64) map->m_pblk << blkbits;
> +	} else {
> +		iomap->type = IOMAP_HOLE;
> +		iomap->addr = IOMAP_NULL_ADDR;
> +	}
> +}
> +
>  static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
>  {
> -	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	unsigned int blkbits = inode->i_blkbits;
>  	unsigned long first_block, last_block;
>  	struct ext4_map_blocks map;
> @@ -3523,47 +3569,9 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  			return ret;
>  	}
>  
> -	/*
> -	 * Writes that span EOF might trigger an I/O size update on completion,
> -	 * so consider them to be dirty for the purposes of O_DSYNC, even if
> -	 * there is no other metadata changes being made or are pending here.
> -	 */
> -	iomap->flags = 0;
> -	if (ext4_inode_datasync_dirty(inode) ||
> -	    offset + length > i_size_read(inode))
> -		iomap->flags |= IOMAP_F_DIRTY;
> -	iomap->bdev = inode->i_sb->s_bdev;
> -	iomap->dax_dev = sbi->s_daxdev;
> -	iomap->offset = (u64)first_block << blkbits;
> -	iomap->length = (u64)map.m_len << blkbits;
> -
> -	if (ret == 0) {
> -		iomap->type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
> -		iomap->addr = IOMAP_NULL_ADDR;
> -	} else {
> -		/*
> -		 * Flags passed into ext4_map_blocks() for direct I/O writes
> -		 * can result in m_flags having both EXT4_MAP_MAPPED and
> -		 * EXT4_MAP_UNWRITTEN bits set. In order for any allocated
> -		 * unwritten extents to be converted into written extents
> -		 * correctly within the ->end_io() handler, we need to ensure
> -		 * that the iomap->type is set appropriately. Hence the reason
> -		 * why we need to check whether EXT4_MAP_UNWRITTEN is set
> -		 * first.
> -		 */
> -		if (map.m_flags & EXT4_MAP_UNWRITTEN) {
> -			iomap->type = IOMAP_UNWRITTEN;
> -		} else if (map.m_flags & EXT4_MAP_MAPPED) {
> -			iomap->type = IOMAP_MAPPED;
> -		} else {
> -			WARN_ON_ONCE(1);
> -			return -EIO;
> -		}
> -		iomap->addr = (u64)map.m_pblk << blkbits;
> -	}
> -
> -	if (map.m_flags & EXT4_MAP_NEW)
> -		iomap->flags |= IOMAP_F_NEW;
> +	ext4_set_iomap(inode, iomap, &map, offset, length);
> +	if (delalloc && iomap->type == IOMAP_HOLE)
> +		iomap->type = IOMAP_DELALLOC;
>  
>  	return 0;
>  }
> -- 
> 2.20.1
> 
