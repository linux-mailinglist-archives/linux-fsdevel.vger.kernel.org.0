Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC9D45EA29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 10:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344392AbhKZJTp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 04:19:45 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38772 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238592AbhKZJRo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:17:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 113941FDFC;
        Fri, 26 Nov 2021 09:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637918071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FDUSoaVt0lTZVk0aMZeEyXLl/ppZReczcS4VhXv16hQ=;
        b=GTb3EcYUvNfHi0uJQNUx3uerbmokj59xiqz7vZUikqhxlW6Qs9pRmSG3LzkP9nxPG6XeC/
        bPbuTFIWC5BciyIAy2Z+e9CEwcG3eo65wXkhuuA3PUYY4BoHFJThPlFLU5UWZ48Behqp4D
        WtSRyJqIZr9qdLgCpzExrVjLoPfXLw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637918071;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FDUSoaVt0lTZVk0aMZeEyXLl/ppZReczcS4VhXv16hQ=;
        b=4zvz7z45ub2sjQQIVAbDft9reNg2/tqZhHKo7MWyhooaPLZ8kod5xDGhefvX83NKwtSBTb
        OBbli8va0kPF6KDQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 50205A3B81;
        Fri, 26 Nov 2021 09:14:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 325F41E11F3; Fri, 26 Nov 2021 10:14:30 +0100 (CET)
Date:   Fri, 26 Nov 2021 10:14:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengguang Xu <charliecgxu@tencent.com>
Subject: Re: [RFC PATCH V6 3/7] ovl: implement overlayfs' own ->write_inode
 operation
Message-ID: <20211126091430.GC13004@quack2.suse.cz>
References: <20211122030038.1938875-1-cgxu519@mykernel.net>
 <20211122030038.1938875-4-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122030038.1938875-4-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 22-11-21 11:00:34, Chengguang Xu wrote:
> From: Chengguang Xu <charliecgxu@tencent.com>
> 
> Sync dirty data and meta of upper inode in overlayfs' ->write_inode()
> and redirty overlayfs' inode.
> 
> Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>

Looks good. I'm still not 100% convinced keeping inodes dirty all the time
will not fire back in excessive writeback activity (e.g. flush worker will
traverse the list of all dirty inodes every 30 seconds and try to write
them) but I guess we can start with this and if people complain, dirtiness
handling can be improved. So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/overlayfs/super.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 18a12088a37b..12acf0ec7395 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -15,6 +15,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/posix_acl_xattr.h>
>  #include <linux/exportfs.h>
> +#include <linux/writeback.h>
>  #include "overlayfs.h"
>  
>  MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
> @@ -406,12 +407,32 @@ static int ovl_remount(struct super_block *sb, int *flags, char *data)
>  	return ret;
>  }
>  
> +static int ovl_write_inode(struct inode *inode,
> +			   struct writeback_control *wbc)
> +{
> +	struct ovl_fs *ofs = inode->i_sb->s_fs_info;
> +	struct inode *upper_inode = ovl_inode_upper(inode);
> +	int ret = 0;
> +
> +	if (!upper_inode)
> +		return 0;
> +
> +	if (!ovl_should_sync(ofs))
> +		return 0;
> +
> +	ret = write_inode_now(upper_inode, wbc->sync_mode == WB_SYNC_ALL);
> +	mark_inode_dirty(inode);
> +
> +	return ret;
> +}
> +
>  static const struct super_operations ovl_super_operations = {
>  	.alloc_inode	= ovl_alloc_inode,
>  	.free_inode	= ovl_free_inode,
>  	.destroy_inode	= ovl_destroy_inode,
>  	.drop_inode	= generic_delete_inode,
>  	.put_super	= ovl_put_super,
> +	.write_inode	= ovl_write_inode,
>  	.sync_fs	= ovl_sync_fs,
>  	.statfs		= ovl_statfs,
>  	.show_options	= ovl_show_options,
> -- 
> 2.27.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
