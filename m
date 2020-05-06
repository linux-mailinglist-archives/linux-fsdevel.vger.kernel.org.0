Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4181C6CFC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 11:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgEFJcl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 05:32:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:38508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728640AbgEFJcl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 05:32:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6480DB019;
        Wed,  6 May 2020 09:32:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D796E1E12B1; Wed,  6 May 2020 11:32:38 +0200 (CEST)
Date:   Wed, 6 May 2020 11:32:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        tytso@mit.edu, adilger@dilger.ca, riteshh@linux.ibm.com,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 11/11] ext4: remove the access_ok() check in
 ext4_ioctl_get_es_cache
Message-ID: <20200506093238.GH17863@quack2.suse.cz>
References: <20200505154324.3226743-1-hch@lst.de>
 <20200505154324.3226743-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505154324.3226743-12-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 05-05-20 17:43:24, Christoph Hellwig wrote:
> access_ok just checks we are fed a proper user pointer.  We also do that
> in copy_to_user itself, so no need to do this early.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ioctl.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index f81acbbb1b12e..2162db0c747d2 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -754,11 +754,6 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
>  	fieinfo.fi_extents_max = fiemap.fm_extent_count;
>  	fieinfo.fi_extents_start = ufiemap->fm_extents;
>  
> -	if (fiemap.fm_extent_count != 0 &&
> -	    !access_ok(fieinfo.fi_extents_start,
> -		       fieinfo.fi_extents_max * sizeof(struct fiemap_extent)))
> -		return -EFAULT;
> -
>  	error = ext4_get_es_cache(inode, &fieinfo, fiemap.fm_start,
>  			fiemap.fm_length);
>  	fiemap.fm_flags = fieinfo.fi_flags;
> -- 
> 2.26.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
