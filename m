Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181C75608D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 20:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiF2SOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 14:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiF2SOl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:14:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D59162F388
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jun 2022 11:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656526478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ifz9v9KEaa+b7vWFXvzOX9Kld7QOZaISqlDQ5NcG7dY=;
        b=bgCnemWN6vLKw7Ac97U9hxnnIR7592tsFOWMfXAqWBRT9Pq76Uu/GLifB6IXvAE2L5AITv
        vU5q6UKJ5fyf5zU3AiboXXFlLCFuZLsraLPMWesaNIeMOc5d5KM0buFQbnDdytnkAyN12M
        uuEgdrmAlojiiuUVlH15CPssV6LYvaA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-Q9ZVg3DtMwaEzhu2DogUrA-1; Wed, 29 Jun 2022 14:14:37 -0400
X-MC-Unique: Q9ZVg3DtMwaEzhu2DogUrA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31575802A5E;
        Wed, 29 Jun 2022 18:14:37 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1757341638B;
        Wed, 29 Jun 2022 18:14:37 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C76E2220463; Wed, 29 Jun 2022 14:14:36 -0400 (EDT)
Date:   Wed, 29 Jun 2022 14:14:36 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, xieyongji@bytedance.com,
        fam.zheng@bytedance.com, Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH] fuse: writeback_cache consistency enhancement
 (writeback_cache_v2)
Message-ID: <YryWjGe6MgBmSkhO@redhat.com>
References: <20220624055825.29183-1-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624055825.29183-1-zhangjiachen.jaycee@bytedance.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 24, 2022 at 01:58:25PM +0800, Jiachen Zhang wrote:
> Some users may want both the high performance of the writeback_cahe mode and
> a little bit more consistency among FUSE mounts. In the current writeback
> mode implementation, users of one FUSE mount can never see the file
> expansion done by other FUSE mounts.
> 
> Based on the suggested writeback V2 patch in the upstream mailing-list [1],
> this commit allows the cmtime and size to be updated from server in
> writeback mode. Compared with the writeback V2 patch in [1], this commit has
> several differences:
> 
>     1. Ensure c/mtime are not updated from kernel to server. IOW, the cmtime
>     generated by kernel are just temporary values that are never flushed to
>     server, and they can also be updated by the official server cmtime when
>     the writeback cache is clean.

Can this give the appearance of time going backwards. If file server
is getting time stamps from another remote filesystem (say NFS), it
is possible that client and server clocks are not in sync. So for 
a stat() might return temporary value of c/mtime from local kernel and
once it gets udpated, it returns a time which might be behind previous
time. Sounds like trouble to me.

This can happen more often on virtiofs (even without a remote filesystem
being involved).

> 
>     2. Skip mtime-based revalidation when fc->auto_inval_data is set with
>     fc->writeback_cache_v2. Because the kernel-generated temporary cmtime
>     are likely not equal to the offical server cmtime.
> 
>     3. If any page is ever flushed to the server during FUSE_GETATTR
>     handling on fuse server, even if the cache is clean when
>     fuse_change_attributes() checks, we should not update the i_size. This
>     is because the FUSE_GETATTR may get a staled size before the FUSE_WRITE
>     request changes server inode size. This commit ensures this by
>     increasing attr_version after writeback for writeback_cache_v2. In that
>     case, we should also ensure the ordering of the attr_version updating
>     and the fi->writepages RB-tree updating. So that if a fuse page
>     writeback ever happens during fuse_change_attributes(), either the
>     fi->writepages is not empty, or the attr_version is increased. So we
>     never mistakenly update a stale file size from server to kernel.
> 
> With this patch, writeback mode can consider the server c/mtime as the
> official one. When inode attr is timeout or invalidated, kernel has chance
> to see size and c/mtime modified by others.
> 
> Together with another patch [2], a FUSE daemon is able to implement
> close-to-open (CTO) consistency like what is done in NFS clients.

If your goal is to implement NFS style CTO with writeback cache mode, then
is it not enough to query and udpate attributes at file open time. Instead
of worrying about also updating attrs while file is open (and cache is
clean). Updating attrs when cache is clean, is non-deterministic anyway,
so I don't see how it can be very useful for applications.

Thanks
Vivek


> 
> [1] https://lore.kernel.org/linux-fsdevel/Ymfu8fGbfYi4FxQ4@miu.piliscsaba.redhat.com
> [2] https://lore.kernel.org/linux-fsdevel/20220608104202.19461-1-zhangjiachen.jaycee@bytedance.com/
> 
> Suggested-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> ---
>  fs/fuse/file.c            | 17 +++++++++++++++
>  fs/fuse/fuse_i.h          |  3 +++
>  fs/fuse/inode.c           | 44 +++++++++++++++++++++++++++++++++++++--
>  include/uapi/linux/fuse.h |  5 +++++
>  4 files changed, 67 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 9b64e2ff1c96..35bdc7af8468 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1829,6 +1829,15 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
>  		 */
>  		fuse_send_writepage(fm, next, inarg->offset + inarg->size);
>  	}
> +
> +	if (fc->writeback_cache_v2)
> +		fi->attr_version = atomic64_inc_return(&fc->attr_version);
> +	/*
> +	 * Ensure attr_version increases before the page is move out of the
> +	 * writepages rb-tree.
> +	 */
> +	smp_mb();
> +
>  	fi->writectr--;
>  	fuse_writepage_finish(fm, wpa);
>  	spin_unlock(&fi->lock);
> @@ -1858,10 +1867,18 @@ static struct fuse_file *fuse_write_file_get(struct fuse_inode *fi)
>  
>  int fuse_write_inode(struct inode *inode, struct writeback_control *wbc)
>  {
> +	struct fuse_conn *fc = get_fuse_conn(inode);
>  	struct fuse_inode *fi = get_fuse_inode(inode);
>  	struct fuse_file *ff;
>  	int err;
>  
> +	/*
> +	 * Kernel c/mtime should not be updated to the server in the
> +	 * writeback_cache_v2 mode as server c/mtime are official.
> +	 */
> +	if (fc->writeback_cache_v2)
> +		return 0;
> +
>  	/*
>  	 * Inode is always written before the last reference is dropped and
>  	 * hence this should not be reached from reclaim.
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 488b460e046f..47de36146fb8 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -654,6 +654,9 @@ struct fuse_conn {
>  	/* show legacy mount options */
>  	unsigned int legacy_opts_show:1;
>  
> +	/* Improved writeback cache policy */
> +	unsigned writeback_cache_v2:1;
> +
>  	/*
>  	 * fs kills suid/sgid/cap on write/chown/trunc. suid is killed on
>  	 * write/trunc only if caller did not have CAP_FSETID.  sgid is killed
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 8c0665c5dff8..2d5fa82b08b6 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -237,14 +237,41 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
>  	u32 cache_mask;
>  	loff_t oldsize;
>  	struct timespec64 old_mtime;
> +	bool try_wb_update = false;
> +
> +	if (fc->writeback_cache_v2 && S_ISREG(inode->i_mode)) {
> +		inode_lock(inode);
> +		try_wb_update = true;
> +	}
>  
>  	spin_lock(&fi->lock);
>  	/*
>  	 * In case of writeback_cache enabled, writes update mtime, ctime and
>  	 * may update i_size.  In these cases trust the cached value in the
>  	 * inode.
> +	 *
> +	 * In writeback_cache_v2 mode, if all the following conditions are met,
> +	 * then we allow the attributes to be refreshed:
> +	 *
> +	 * - inode is not in the process of being written (I_SYNC)
> +	 * - inode has no dirty pages (I_DIRTY_PAGES)
> +	 * - inode data-related attributes are clean (I_DIRTY_DATASYNC)
> +	 * - inode does not have any page writeback in progress
> +	 *
> +	 * Note: checking PAGECACHE_TAG_WRITEBACK is not sufficient in fuse,
> +	 * since inode can appear to have no PageWriteback pages, yet still have
> +	 * outstanding write request.
>  	 */
>  	cache_mask = fuse_get_cache_mask(inode);
> +	if (try_wb_update && !(inode->i_state & (I_DIRTY_PAGES | I_SYNC |
> +	    I_DIRTY_DATASYNC)) && RB_EMPTY_ROOT(&fi->writepages))
> +		cache_mask &= ~(STATX_MTIME | STATX_CTIME | STATX_SIZE);
> +	/*
> +	 * Ensure the ordering of cleanness checking and following attr_version
> +	 * comparison.
> +	 */
> +	smp_mb();
> +
>  	if (cache_mask & STATX_SIZE)
>  		attr->size = i_size_read(inode);
>  
> @@ -283,7 +310,13 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
>  			truncate_pagecache(inode, attr->size);
>  			if (!fc->explicit_inval_data)
>  				inval = true;
> -		} else if (fc->auto_inval_data) {
> +		} else if (!fc->writeback_cache_v2 && fc->auto_inval_data) {
> +			/*
> +			 * When fc->writeback_cache_v2 is set, the old_mtime
> +			 * can be generated by kernel and must not equal to
> +			 * new_mtime generated by server. So skip in such
> +			 * case.
> +			 */
>  			struct timespec64 new_mtime = {
>  				.tv_sec = attr->mtime,
>  				.tv_nsec = attr->mtimensec,
> @@ -303,6 +336,9 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
>  
>  	if (IS_ENABLED(CONFIG_FUSE_DAX))
>  		fuse_dax_dontcache(inode, attr->flags);
> +
> +	if (try_wb_update)
> +		inode_unlock(inode);
>  }
>  
>  static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
> @@ -1153,6 +1189,10 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>  				fc->async_dio = 1;
>  			if (flags & FUSE_WRITEBACK_CACHE)
>  				fc->writeback_cache = 1;
> +			if (flags & FUSE_WRITEBACK_CACHE_V2) {
> +				fc->writeback_cache = 1;
> +				fc->writeback_cache_v2 = 1;
> +			}
>  			if (flags & FUSE_PARALLEL_DIROPS)
>  				fc->parallel_dirops = 1;
>  			if (flags & FUSE_HANDLE_KILLPRIV)
> @@ -1234,7 +1274,7 @@ void fuse_send_init(struct fuse_mount *fm)
>  		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
>  		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
>  		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
> -		FUSE_SECURITY_CTX;
> +		FUSE_SECURITY_CTX | FUSE_WRITEBACK_CACHE_V2;
>  #ifdef CONFIG_FUSE_DAX
>  	if (fm->fc->dax)
>  		flags |= FUSE_MAP_ALIGNMENT;
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index d6ccee961891..b474763bcf59 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -194,6 +194,7 @@
>   *  - add FUSE_SECURITY_CTX init flag
>   *  - add security context to create, mkdir, symlink, and mknod requests
>   *  - add FUSE_HAS_INODE_DAX, FUSE_ATTR_DAX
> + *  - add FUSE_WRITEBACK_CACHE_V2 init flag
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -353,6 +354,9 @@ struct fuse_file_lock {
>   * FUSE_SECURITY_CTX:	add security context to create, mkdir, symlink, and
>   *			mknod
>   * FUSE_HAS_INODE_DAX:  use per inode DAX
> + * FUSE_WRITEBACK_CACHE_V2:
> + *			allow time/size to be refreshed if no pending write
> + *			c/mtime not updated from kernel to server
>   */
>  #define FUSE_ASYNC_READ		(1 << 0)
>  #define FUSE_POSIX_LOCKS	(1 << 1)
> @@ -389,6 +393,7 @@ struct fuse_file_lock {
>  /* bits 32..63 get shifted down 32 bits into the flags2 field */
>  #define FUSE_SECURITY_CTX	(1ULL << 32)
>  #define FUSE_HAS_INODE_DAX	(1ULL << 33)
> +#define FUSE_WRITEBACK_CACHE_V2	(1ULL << 34)
>  
>  /**
>   * CUSE INIT request/reply flags
> -- 
> 2.20.1
> 

