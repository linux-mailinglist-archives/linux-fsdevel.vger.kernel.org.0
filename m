Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8D3C16FFE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 14:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgBZN1X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 08:27:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:39884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgBZN1X (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:27:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 77309B133;
        Wed, 26 Feb 2020 13:27:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 34F231E0EA2; Wed, 26 Feb 2020 14:27:20 +0100 (CET)
Date:   Wed, 26 Feb 2020 14:27:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, hch@infradead.org, cmaiolino@redhat.com
Subject: Re: [PATCHv3 5/6] ext4: Move ext4_fiemap to use iomap framework.
Message-ID: <20200226132720.GQ10728@quack2.suse.cz>
References: <cover.1582702693.git.riteshh@linux.ibm.com>
 <31caeb6a880e3070ace5dfcb0623fc06f751b443.1582702694.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31caeb6a880e3070ace5dfcb0623fc06f751b443.1582702694.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 26-02-20 15:27:07, Ritesh Harjani wrote:
> This patch moves ext4_fiemap to use iomap framework.
> For xattr a new 'ext4_iomap_xattr_ops' is added.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

...

> -static int ext4_xattr_fiemap(struct inode *inode,
> -				struct fiemap_extent_info *fieinfo)
> +static int ext4_iomap_xattr_fiemap(struct inode *inode, struct iomap *iomap)
>  {
>  	__u64 physical = 0;
>  	__u64 length;
> -	__u32 flags = FIEMAP_EXTENT_LAST;
>  	int blockbits = inode->i_sb->s_blocksize_bits;
>  	int error = 0;
> +	u16 iomap_type;
>  
>  	/* in-inode? */
>  	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
> @@ -5130,40 +4928,44 @@ static int ext4_xattr_fiemap(struct inode *inode,
>  				EXT4_I(inode)->i_extra_isize;
>  		physical += offset;
>  		length = EXT4_SB(inode->i_sb)->s_inode_size - offset;
> -		flags |= FIEMAP_EXTENT_DATA_INLINE;
>  		brelse(iloc.bh);
> +		iomap_type = IOMAP_INLINE;
>  	} else { /* external block */
>  		physical = (__u64)EXT4_I(inode)->i_file_acl << blockbits;
>  		length = inode->i_sb->s_blocksize;
> +		iomap_type = IOMAP_MAPPED;
>  	}

If i_file_acl is 0 (i.e., no external xattr block), then I think returned
iomap should be different...

> +static int ext4_iomap_xattr_begin(struct inode *inode, loff_t offset,
> +				  loff_t length, unsigned flags,
> +				  struct iomap *iomap, struct iomap *srcmap)
>  {
> -	ext4_lblk_t start_blk;
> -	u32 ext4_fiemap_flags = FIEMAP_FLAG_SYNC|FIEMAP_FLAG_XATTR;
> +	int error;
>  
> -	int error = 0;
> -
> -	if (ext4_has_inline_data(inode)) {
> -		int has_inline = 1;
> +	error = ext4_iomap_xattr_fiemap(inode, iomap);
> +	if (error == 0 && (offset >= iomap->length))
> +		error = -ENOENT;

Is ENOENT really correct here? It seems strange to me...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
