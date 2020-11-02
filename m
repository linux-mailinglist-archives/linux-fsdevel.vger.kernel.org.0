Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C072A313C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 18:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgKBRRo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 12:17:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:36778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbgKBRRn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:17:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0AD00B2AF;
        Mon,  2 Nov 2020 17:17:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 40B2A1E12FB; Mon,  2 Nov 2020 18:17:41 +0100 (CET)
Date:   Mon, 2 Nov 2020 18:17:41 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     miklos@szeredi.hu, amir73il@gmail.com, jack@suse.cz,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/8] ovl: implement ->writepages operation
Message-ID: <20201102171741.GE23988@quack2.suse.cz>
References: <20201025034117.4918-1-cgxu519@mykernel.net>
 <20201025034117.4918-3-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025034117.4918-3-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 25-10-20 11:41:11, Chengguang Xu wrote:
> Implement overlayfs' ->writepages operation so that
> we can sync dirty data/metadata to upper filesystem.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
>  fs/overlayfs/inode.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index b584dca845ba..f27fc5be34df 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -11,6 +11,7 @@
>  #include <linux/posix_acl.h>
>  #include <linux/ratelimit.h>
>  #include <linux/fiemap.h>
> +#include <linux/writeback.h>
>  #include "overlayfs.h"
>  
>  
> @@ -516,7 +517,32 @@ static const struct inode_operations ovl_special_inode_operations = {
>  	.update_time	= ovl_update_time,
>  };
>  
> +static int ovl_writepages(struct address_space *mapping,
> +			  struct writeback_control *wbc)
> +{
> +	struct inode *upper_inode = ovl_inode_upper(mapping->host);
> +	struct ovl_fs *ofs =  mapping->host->i_sb->s_fs_info;
> +	struct writeback_control tmp_wbc = *wbc;
> +
> +	if (!ovl_should_sync(ofs))
> +		return 0;
> +
> +	/*
> +	 * for sync(2) writeback, it has a separate external IO
> +	 * completion path by checking PAGECACHE_TAG_WRITEBACK
> +	 * in pagecache, we have to set for_sync to 0 in thie case,
> +	 * let writeback waits completion after syncing individual
> +	 * dirty inode, because we haven't implemented overlayfs'
> +	 * own pagecache yet.
> +	 */
> +	if (wbc->for_sync && (wbc->sync_mode == WB_SYNC_ALL))
> +		tmp_wbc.for_sync = 0;

This looks really hacky as it closely depends on the internal details of
writeback implementation. I'd be more open to say export wait_sb_inodes()
for overlayfs use... Because that's what I gather you need in your
overlayfs ->syncfs() implementation.

								Honza

> +
> +	return sync_inode(upper_inode, &tmp_wbc);
> +}
> +
>  static const struct address_space_operations ovl_aops = {
> +	.writepages		= ovl_writepages,
>  	/* For O_DIRECT dentry_open() checks f_mapping->a_ops->direct_IO */
>  	.direct_IO		= noop_direct_IO,
>  };
> -- 
> 2.26.2
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
