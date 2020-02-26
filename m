Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAD016FEF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 13:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgBZM2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 07:28:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:42638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgBZM2t (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:28:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CB0F9AC53;
        Wed, 26 Feb 2020 12:28:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 730321E0EA2; Wed, 26 Feb 2020 13:28:47 +0100 (CET)
Date:   Wed, 26 Feb 2020 13:28:47 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, hch@infradead.org, cmaiolino@redhat.com
Subject: Re: [PATCHv3 2/6] ext4: Optimize ext4_ext_precache for 0 depth
Message-ID: <20200226122847.GN10728@quack2.suse.cz>
References: <cover.1582702693.git.riteshh@linux.ibm.com>
 <30a143eafd931603d54bef8026411d89c71ffdda.1582702694.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30a143eafd931603d54bef8026411d89c71ffdda.1582702694.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 26-02-20 15:27:04, Ritesh Harjani wrote:
> This patch avoids the memory alloc & free path when depth is 0, 
> since anyway there is no extra caching done in that case.
> So on checking depth 0, simply return early.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index ee83fe7c98aa..0de548bb3c90 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -594,6 +594,12 @@ int ext4_ext_precache(struct inode *inode)
>  	down_read(&ei->i_data_sem);
>  	depth = ext_depth(inode);
>  
> +	/* Don't cache anything if there are no external extent blocks */
> +	if (!depth) {
> +		up_read(&ei->i_data_sem);
> +		return ret;
> +	}
> +
>  	path = kcalloc(depth + 1, sizeof(struct ext4_ext_path),
>  		       GFP_NOFS);
>  	if (path == NULL) {
> @@ -601,9 +607,6 @@ int ext4_ext_precache(struct inode *inode)
>  		return -ENOMEM;
>  	}
>  
> -	/* Don't cache anything if there are no external extent blocks */
> -	if (depth == 0)
> -		goto out;
>  	path[0].p_hdr = ext_inode_hdr(inode);
>  	ret = ext4_ext_check(inode, path[0].p_hdr, depth, 0);
>  	if (ret)
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
