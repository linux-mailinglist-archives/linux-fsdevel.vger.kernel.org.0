Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B10C486959
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 19:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242536AbiAFSEa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 13:04:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54534 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242502AbiAFSE3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:04:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8517B61D5E;
        Thu,  6 Jan 2022 18:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6642AC36AE3;
        Thu,  6 Jan 2022 18:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641492267;
        bh=zFzYedvnQkx/JKEXhTYO/gwqLA3DqUv7vETRuabLtmg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qJjhwPu2xUwjQYsODD4fKKnLXOrI2BDhhyj7cpDqilYVrJ32Zh/8aPjkdmttjDU51
         CzbcMuyZT2zHIAwayCULqnOZmN5n1Lwamr0UUYtlVg070ve5lTZ3uDkyKjts65Nz4s
         g1XHNln/Z+s+bSjxTi7IkNcfh8sRAa4lxY9dwkg7FOPjAukYJTGl4o2I5ocKbcMTYE
         ymUwcvIZ37mJ56eOEwJo83aiouJDXAtwOnPAXkxpPP8axloIH4Rf0qhb8RUhkE6bJu
         ucF+0cg11xHNJsNE14EMyO6TVIQUTVmqHfAF3uWzAuDVxBkdHozdD0BnWfNNQCuJtl
         IGxmTMB0CefQQ==
Message-ID: <94b5163b0652c6106aa01a0f4c03bdf57c0a7e71.camel@kernel.org>
Subject: Re: [PATCH v4 46/68] cachefiles: Mark a backing file in use with an
 inode flag
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Jan 2022 13:04:25 -0500
In-Reply-To: <164021552299.640689.10578652796777392062.stgit@warthog.procyon.org.uk>
References: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
         <164021552299.640689.10578652796777392062.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-12-22 at 23:25 +0000, David Howells wrote:
> Use an inode flag, S_KERNEL_FILE, to mark that a backing file is in use by
> the kernel to prevent cachefiles or other kernel services from interfering
> with that file.
> 
> Using S_SWAPFILE instead isn't really viable as that has other effects in
> the I/O paths.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-cachefs@redhat.com
> Link: https://lore.kernel.org/r/163819642273.215744.6414248677118690672.stgit@warthog.procyon.org.uk/ # v1
> Link: https://lore.kernel.org/r/163906943215.143852.16972351425323967014.stgit@warthog.procyon.org.uk/ # v2
> Link: https://lore.kernel.org/r/163967154118.1823006.13227551961786743991.stgit@warthog.procyon.org.uk/ # v3
> ---
> 
>  fs/cachefiles/internal.h |    2 ++
>  fs/cachefiles/namei.c    |   35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index 01071e7a7c02..7c67a70a3dff 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h
> @@ -187,6 +187,8 @@ extern struct kmem_cache *cachefiles_object_jar;
>  /*
>   * namei.c
>   */
> +extern void cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
> +					   struct file *file);
>  extern struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
>  					       struct dentry *dir,
>  					       const char *name,
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 11a33209ab5f..db60a671c3fc 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -31,6 +31,18 @@ static bool __cachefiles_mark_inode_in_use(struct cachefiles_object *object,
>  	return can_use;
>  }
>  
> +static bool cachefiles_mark_inode_in_use(struct cachefiles_object *object,
> +					 struct dentry *dentry)
> +{
> +	struct inode *inode = d_backing_inode(dentry);
> +	bool can_use;
> +
> +	inode_lock(inode);
> +	can_use = __cachefiles_mark_inode_in_use(object, dentry);
> +	inode_unlock(inode);
> +	return can_use;
> +}
> +
>  /*
>   * Unmark a backing inode.  The caller must hold the inode lock.
>   */
> @@ -43,6 +55,29 @@ static void __cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
>  	trace_cachefiles_mark_inactive(object, inode);
>  }
>  
> +/*
> + * Unmark a backing inode and tell cachefilesd that there's something that can
> + * be culled.
> + */
> +void cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
> +				    struct file *file)
> +{
> +	struct cachefiles_cache *cache = object->volume->cache;
> +	struct inode *inode = file_inode(file);
> +
> +	if (inode) {
> +		inode_lock(inode);
> +		__cachefiles_unmark_inode_in_use(object, file->f_path.dentry);
> +		inode_unlock(inode);
> +
> +		if (!test_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags)) {
> +			atomic_long_add(inode->i_blocks, &cache->b_released);
> +			if (atomic_inc_return(&cache->f_released))
> +				cachefiles_state_changed(cache);
> +		}
> +	}
> +}
> +
>  /*
>   * get a subdirectory
>   */
> 
> 

Probably, this patch should be merged with #38. The commit logs are the
same, and they are at least somewhat related.

-- 
Jeff Layton <jlayton@kernel.org>
