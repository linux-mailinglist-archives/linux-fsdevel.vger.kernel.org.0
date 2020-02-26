Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB95C16FEFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 13:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgBZM3k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 07:29:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:42738 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgBZM3k (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:29:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 603DBAC53;
        Wed, 26 Feb 2020 12:29:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E555F1E0EA2; Wed, 26 Feb 2020 13:29:35 +0100 (CET)
Date:   Wed, 26 Feb 2020 13:29:35 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, hch@infradead.org, cmaiolino@redhat.com
Subject: Re: [PATCHv3 3/6] ext4: Move ext4 bmap to use iomap infrastructure.
Message-ID: <20200226122935.GO10728@quack2.suse.cz>
References: <cover.1582702693.git.riteshh@linux.ibm.com>
 <1334c8284ea5fb99f74df27d6339aeb3f690bd83.1582702694.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1334c8284ea5fb99f74df27d6339aeb3f690bd83.1582702694.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 26-02-20 15:27:05, Ritesh Harjani wrote:
> ext4_iomap_begin is already implemented which provides ext4_map_blocks,
> so just move the API from generic_block_bmap to iomap_bmap for iomap
> conversion.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 3b4230cf0bc2..0f8a196d8a61 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3214,7 +3214,7 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
>  			return 0;
>  	}
>  
> -	return generic_block_bmap(mapping, block, ext4_get_block);
> +	return iomap_bmap(mapping, block, &ext4_iomap_ops);
>  }
>  
>  static int ext4_readpage(struct file *file, struct page *page)
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
