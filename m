Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9761569B913
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 10:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjBRJZC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 04:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjBRJZA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 04:25:00 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45038211DB;
        Sat, 18 Feb 2023 01:24:59 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id BBE8BC01B; Sat, 18 Feb 2023 10:25:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676712321; bh=Fv1Xa/SdJbPVdgb22Wd0HxHPViznBbgTQBzuT6vWa4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RkL7NDWgKW4g1RBq2jX65R8U6cJlq4t6VJvhNO3qbDbDWri6tHAg1h4yXjprK2jGF
         M5W4pyuCWb/bIr8t1zH4btgfeLZqnlRTsOFXFMoCHVSSvjseEvlyxaw8raQTZOCXZc
         K4N2pF9dprdl0g0cVvtu/Txju7SU6nlJge2xmgryEfMzgt+uFV34D61w1Zn4YVhMV1
         qeX6mhBljLr7J8+c4f5ss5yRidJkJNrKMO0kYqSHHYSlBGdD5TT3ONvl47DG+vnzZm
         fwzLozhWBuQr2FMC+eyah5xiEpTJAdEfxwbWuNrXXjjAgSSWSj/N5bGa0SnCkOX3GO
         Q9C40RZrOFA0Q==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id D37DCC009;
        Sat, 18 Feb 2023 10:25:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676712319; bh=Fv1Xa/SdJbPVdgb22Wd0HxHPViznBbgTQBzuT6vWa4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PCKAsESDWJSsRfs27kYSmTkWJg50dBu8i1q9ti9fDsHgZ+2XnsaSlcVrjfquQ2Yev
         UPLdh2JZkuJ611E6STtGdlW9rkfVaDJFfWSNb5rw93maSbQJfIXsONfe4Fzb3PJ76+
         bY1Uv+czQixdKinrVAgrnbL7aVJBskUZ7ewu1nmC8JTGW2M9H+5JFsTyZ8So0Bc++5
         gP+ER+CiiRB9SE2RPEOaH/MnO4vnbT11DkfimOaGvOedCm3uOADLsVjcAWSgB+baSF
         MYZgR9dPt/ag9Im+ZOGjFgH/oFG3WQQWSnib3gBSyO+3OOFRgttoToKX+Fr/Cxrx07
         0lwsjObHVou2g==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id a9009f08;
        Sat, 18 Feb 2023 09:24:51 +0000 (UTC)
Date:   Sat, 18 Feb 2023 18:24:36 +0900
From:   asmadeus@codewreck.org
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux_oss@crudebyte.com
Subject: Re: [PATCH v4 03/11] fs/9p: Consolidate file operations and add
 readahead and writeback
Message-ID: <Y/CZVEQPFFo0zMjo@codewreck.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-1-ericvh@kernel.org>
 <20230218003323.2322580-4-ericvh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230218003323.2322580-4-ericvh@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Van Hensbergen wrote on Sat, Feb 18, 2023 at 12:33:15AM +0000:
> We had 3 different sets of file operations across 2 different protocol
> variants differentiated by cache which really only changed 3
> functions.  But the real problem is that certain file modes, mount
> options, and other factors weren't being considered when we
> decided whether or not to use caches.
> 
> This consolidates all the operations and switches
> to conditionals within a common set to decide whether or not
> to do different aspects of caching.
> 
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>

Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>

> ---
>  struct inode *v9fs_alloc_inode(struct super_block *sb);
> diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
> index 59b0e8948f78..bd31593437f3 100644
> --- a/fs/9p/vfs_dir.c
> +++ b/fs/9p/vfs_dir.c
> @@ -214,6 +214,9 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
>  	p9_debug(P9_DEBUG_VFS, "inode: %p filp: %p fid: %d\n",
>  		 inode, filp, fid ? fid->fid : -1);
>  	if (fid) {
> +		if ((fid->qid.type == P9_QTFILE) && (filp->f_mode & FMODE_WRITE))
> +			v9fs_flush_inode_writeback(inode);
> +

Ok so this bugged me to no end; that seems to be because we use the same
v9fs_dir_release for v9fs_file_operations's .release and not just
v9fs_dir_operations... So it's to be expected we'll get files here.

At this point I'd suggest to use two functions, but that's probably
overdoing it.
Let's check S_ISREG(inode->i_mode) instead of fid->qid though; it
shouldn't make any difference but that's what you use in other parts of
the code and it will be easier to understand for people familiar with
the vfs.


> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index 33e521c60e2c..8ffa6631b1fd 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -219,6 +219,35 @@ v9fs_blank_wstat(struct p9_wstat *wstat)
>  	wstat->extension = NULL;
>  }
>  
> +/**
> + * v9fs_flush_inode_writeback - writeback any data associated with inode
> + * @inode: inode to writeback
> + *
> + * This is used to make sure anything that needs to be written
> + * to server gets flushed before we do certain operations (setattr, getattr, close)
> + *
> + */
> +
> +int v9fs_flush_inode_writeback(struct inode *inode)
> +{
> +	struct writeback_control wbc = {
> +		.nr_to_write = LONG_MAX,
> +		.sync_mode = WB_SYNC_ALL,
> +		.range_start = 0,
> +		.range_end = -1,
> +	};
> +
> +	int retval = filemap_fdatawrite_wbc(inode->i_mapping, &wbc);

Hmm, that function only starts the writeback, but doesn't wait for it.

Wasn't the point to replace 'filemap_write_and_wait' with
v9fs_flush_inode_writeback?
I don't think it's a good idea to remove the wait before setattrs and
the like; if you don't want to wait on close()'s release (but we
probably should too) perhaps split this in two?

> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index bff37a312e64..4f01808c3bae 100644
> --- a/fs/9p/vfs_inode_dotl.c
> +++ b/fs/9p/vfs_inode_dotl.c
> @@ -593,9 +602,14 @@ int v9fs_vfs_setattr_dotl(struct user_namespace *mnt_userns,
>  		return retval;
>  	}
>  
> -	if ((iattr->ia_valid & ATTR_SIZE) &&
> -	    iattr->ia_size != i_size_read(inode))
> +	if ((iattr->ia_valid & ATTR_SIZE) && iattr->ia_size !=
> +		 i_size_read(inode)) {
>  		truncate_setsize(inode, iattr->ia_size);
> +		if (v9ses->cache == CACHE_FSCACHE)
> +			fscache_resize_cookie(v9fs_inode_cookie(v9inode), iattr->ia_size);
> +		else
> +			invalidate_mapping_pages(&inode->i_data, 0, -1);

Hm, I don't think these are exclusive; resize_cookie doesn't seem to do
much about the page cache.

However, truncate_setsize calls trucate_pagecache which I believe does
the right thing; and I don't see why we would need to invalidate
[0;size[ here? We didn't before.

. . . . . . .
Ah, you've replaced it preciesly with that in "fs/9p: writeback mode
fixes"; this is annoying to review :/

So with that problem gone, I think I'm ok with this patch with the
exception of the flush inode writeback that doesn't wait (and the
nitpick on S_ISREG)

-- 
Dominique
