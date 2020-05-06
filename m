Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228571C6CDD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 11:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgEFJ0z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 05:26:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:53240 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728797AbgEFJ0y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 05:26:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1EBBBAC4A;
        Wed,  6 May 2020 09:26:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 833491E12B1; Wed,  6 May 2020 11:26:52 +0200 (CEST)
Date:   Wed, 6 May 2020 11:26:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        tytso@mit.edu, adilger@dilger.ca, riteshh@linux.ibm.com,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 04/11] ext4: remove the call to fiemap_check_flags in
 ext4_fiemap
Message-ID: <20200506092652.GF17863@quack2.suse.cz>
References: <20200505154324.3226743-1-hch@lst.de>
 <20200505154324.3226743-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505154324.3226743-5-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 05-05-20 17:43:17, Christoph Hellwig wrote:
> iomap_fiemap already calls fiemap_check_flags first thing, so this
> additional check is redundant.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index d2a2a3ba5c44a..a41ae7c510170 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4866,9 +4866,6 @@ int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		fieinfo->fi_flags &= ~FIEMAP_FLAG_CACHE;
>  	}
>  
> -	if (fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR))
> -		return -EBADR;
> -
>  	/*
>  	 * For bitmap files the maximum size limit could be smaller than
>  	 * s_maxbytes, so check len here manually instead of just relying on the
> -- 
> 2.26.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
