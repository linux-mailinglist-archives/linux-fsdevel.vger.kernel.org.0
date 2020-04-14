Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF77E1A83CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 17:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440962AbgDNPu2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 11:50:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:37980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440940AbgDNPuU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:50:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 15767ACBA;
        Tue, 14 Apr 2020 15:50:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 983311E125F; Tue, 14 Apr 2020 17:50:13 +0200 (CEST)
Date:   Tue, 14 Apr 2020 17:50:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        adilger@dilger.ca, darrick.wong@oracle.com, hch@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-unionfs@vger.kernel.org,
        syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com
Subject: Re: [RFC 1/1] ext4: Fix overflow case for map.m_len in
 ext4_iomap_begin_*
Message-ID: <20200414155013.GF28226@quack2.suse.cz>
References: <00000000000048518b05a2fef23a@google.com>
 <dea98f0b07e16de219d8741c1fefc7cb476cb482.1586681010.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dea98f0b07e16de219d8741c1fefc7cb476cb482.1586681010.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 12-04-20 14:54:35, Ritesh Harjani wrote:
> EXT4_MAX_LOGICAL_BLOCK - map.m_lblk + 1 in case when
> map.m_lblk (offset) is 0 could overflow an unsigned int
> and become 0.
> 
> Fix this.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Reported-by: syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com
> Fixes: d3b6f23f7167 ("ext4: move ext4_fiemap to use iomap framework")

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index e416096fc081..d630ec7a9c8e 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3424,6 +3424,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  	int ret;
>  	struct ext4_map_blocks map;
>  	u8 blkbits = inode->i_blkbits;
> +	loff_t len;
>  
>  	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
>  		return -EINVAL;
> @@ -3435,8 +3436,11 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  	 * Calculate the first and last logical blocks respectively.
>  	 */
>  	map.m_lblk = offset >> blkbits;
> -	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
> +	len = min_t(loff_t, (offset + length - 1) >> blkbits,
>  			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
> +	if (len > EXT4_MAX_LOGICAL_BLOCK)
> +		len = EXT4_MAX_LOGICAL_BLOCK;
> +	map.m_len = len;
>  
>  	if (flags & IOMAP_WRITE)
>  		ret = ext4_iomap_alloc(inode, &map, flags);
> @@ -3524,6 +3528,7 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
>  	bool delalloc = false;
>  	struct ext4_map_blocks map;
>  	u8 blkbits = inode->i_blkbits;
> +	loff_t len
>  
>  	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
>  		return -EINVAL;
> @@ -3541,8 +3546,11 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
>  	 * Calculate the first and last logical block respectively.
>  	 */
>  	map.m_lblk = offset >> blkbits;
> -	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
> +	len = min_t(loff_t, (offset + length - 1) >> blkbits,
>  			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
> +	if (len > EXT4_MAX_LOGICAL_BLOCK)
> +		len = EXT4_MAX_LOGICAL_BLOCK;
> +	map.m_len = len;
>  
>  	/*
>  	 * Fiemap callers may call for offset beyond s_bitmap_maxbytes.
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
