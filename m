Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDD5590F40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 12:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbiHLKV0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 06:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238778AbiHLKVH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:21:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2750D62D3;
        Fri, 12 Aug 2022 03:21:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0C53B823D2;
        Fri, 12 Aug 2022 10:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD535C433D7;
        Fri, 12 Aug 2022 10:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660299659;
        bh=NVQ9pm884AYZwMhL7h5OVjO4qszHxNUuJ+1wER4FQ3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EKjxCG4mA9zNJCvuGxbu6peqzR+4ROwtuwM9BnLdlW5VYeAOz/vq4mnvA7g9zcXNq
         bCzG13+WuN78/7hjuBDzbx+gH5eDDAOHQArtQX7nm57PjfbkxI1+BGICyh3N5qCAMs
         GsA3SlL3UxqO74wN9V8CbRyq6yO3DWs+Cgevx52uj429AySm9M0T5qWQ9TzIozCmpa
         o68yV3K8PUIkpn/ybCgf9gn54wiaIwraUxf7gD+Mch3Px2ZDU9Iuk8QaWHn1Ir61Gu
         OFL3yJKycMv/efhL21HiYaaXxd83vDAs2TQG8uKzy9IbnKFhSmS8Rp9iJI8myz++vz
         DaSYEL2EYyzAQ==
Date:   Fri, 12 Aug 2022 12:20:52 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel@openvz.org
Subject: Re: [RFC PATCH] kernfs: enable per-inode limits for all xattr types
Message-ID: <20220812102052.adiqtlsxx273t7wk@wittgenstein>
References: <b816f58a-ce25-c079-c6b3-a3406df246f9@openvz.org>
 <8ace5255-ce23-0a05-2d50-1455dd68acb6@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ace5255-ce23-0a05-2d50-1455dd68acb6@openvz.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 11, 2022 at 07:58:46AM +0300, Vasily Averin wrote:
> Currently it's possible to create a huge number of xattr per inode,
> and I would like to add USER-like restrcition to all xattr types.
> 
> I've prepared RFC patch and would like to discuss it.
> 
> This patch moves counters calculations into simple_xattr_set,
> under simple_xattrs spinlock. This allows to replace atomic counters
> used currently for USER xattr to ints.
> 
> To keep current behaviour for USER xattr I keep current limits
> and counters and add separated limits and counters for all another
> xattr types. However I would like to merge these limits and counters
> together, because it simplifies the code even more.
> Could someone please clarify if this is acceptable?
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>
> ---

Hey Vasily,

Fyi, this patch doesn't seem to apply cleanly to anything from v5.17 up
until current master. It's a bit unfortunate that it's the middle of the
merge window so ideally you'd resend once the merge window closes on top
of v5.20-rc1.

A few questions below.

>  fs/kernfs/inode.c           | 67 ++-----------------------------------
>  fs/kernfs/kernfs-internal.h |  2 --
>  fs/xattr.c                  | 56 +++++++++++++++++++------------
>  include/linux/kernfs.h      |  2 ++
>  include/linux/xattr.h       | 11 ++++--
>  mm/shmem.c                  | 29 +++++++---------
>  6 files changed, 61 insertions(+), 106 deletions(-)
> 
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index 3d783d80f5da..7cfdda41fc89 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -47,8 +47,6 @@ static struct kernfs_iattrs *__kernfs_iattrs(struct kernfs_node *kn, int alloc)
>  	kn->iattr->ia_ctime = kn->iattr->ia_atime;
>  
>  	simple_xattrs_init(&kn->iattr->xattrs);
> -	atomic_set(&kn->iattr->nr_user_xattrs, 0);
> -	atomic_set(&kn->iattr->user_xattr_size, 0);
>  out_unlock:
>  	ret = kn->iattr;
>  	mutex_unlock(&iattr_mutex);
> @@ -314,7 +312,7 @@ int kernfs_xattr_set(struct kernfs_node *kn, const char *name,
>  	if (!attrs)
>  		return -ENOMEM;
>  
> -	return simple_xattr_set(&attrs->xattrs, name, value, size, flags, NULL);
> +	return simple_xattr_set(&attrs->xattrs, name, value, size, flags);
>  }
>  
>  static int kernfs_vfs_xattr_get(const struct xattr_handler *handler,
> @@ -339,61 +337,6 @@ static int kernfs_vfs_xattr_set(const struct xattr_handler *handler,
>  	return kernfs_xattr_set(kn, name, value, size, flags);
>  }
>  
> -static int kernfs_vfs_user_xattr_add(struct kernfs_node *kn,
> -				     const char *full_name,
> -				     struct simple_xattrs *xattrs,
> -				     const void *value, size_t size, int flags)
> -{
> -	atomic_t *sz = &kn->iattr->user_xattr_size;
> -	atomic_t *nr = &kn->iattr->nr_user_xattrs;
> -	ssize_t removed_size;
> -	int ret;
> -
> -	if (atomic_inc_return(nr) > KERNFS_MAX_USER_XATTRS) {
> -		ret = -ENOSPC;
> -		goto dec_count_out;
> -	}
> -
> -	if (atomic_add_return(size, sz) > KERNFS_USER_XATTR_SIZE_LIMIT) {
> -		ret = -ENOSPC;
> -		goto dec_size_out;
> -	}
> -
> -	ret = simple_xattr_set(xattrs, full_name, value, size, flags,
> -			       &removed_size);
> -
> -	if (!ret && removed_size >= 0)
> -		size = removed_size;
> -	else if (!ret)
> -		return 0;
> -dec_size_out:
> -	atomic_sub(size, sz);
> -dec_count_out:
> -	atomic_dec(nr);
> -	return ret;
> -}
> -
> -static int kernfs_vfs_user_xattr_rm(struct kernfs_node *kn,
> -				    const char *full_name,
> -				    struct simple_xattrs *xattrs,
> -				    const void *value, size_t size, int flags)
> -{
> -	atomic_t *sz = &kn->iattr->user_xattr_size;
> -	atomic_t *nr = &kn->iattr->nr_user_xattrs;
> -	ssize_t removed_size;
> -	int ret;
> -
> -	ret = simple_xattr_set(xattrs, full_name, value, size, flags,
> -			       &removed_size);
> -
> -	if (removed_size >= 0) {
> -		atomic_sub(removed_size, sz);
> -		atomic_dec(nr);
> -	}
> -
> -	return ret;
> -}
> -
>  static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
>  				     struct user_namespace *mnt_userns,
>  				     struct dentry *unused, struct inode *inode,
> @@ -411,13 +354,7 @@ static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
>  	if (!attrs)
>  		return -ENOMEM;
>  
> -	if (value)
> -		return kernfs_vfs_user_xattr_add(kn, full_name, &attrs->xattrs,
> -						 value, size, flags);
> -	else
> -		return kernfs_vfs_user_xattr_rm(kn, full_name, &attrs->xattrs,
> -						value, size, flags);
> -
> +	return simple_xattr_set(&attrs->xattrs, full_name, value, size, flags);
>  }
>  
>  static const struct xattr_handler kernfs_trusted_xattr_handler = {
> diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> index eeaa779b929c..a2b89bd48c9d 100644
> --- a/fs/kernfs/kernfs-internal.h
> +++ b/fs/kernfs/kernfs-internal.h
> @@ -27,8 +27,6 @@ struct kernfs_iattrs {
>  	struct timespec64	ia_ctime;
>  
>  	struct simple_xattrs	xattrs;
> -	atomic_t		nr_user_xattrs;
> -	atomic_t		user_xattr_size;
>  };
>  
>  struct kernfs_root {
> diff --git a/fs/xattr.c b/fs/xattr.c
> index b4875514a3ee..de4a2efc7fa4 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -1037,6 +1037,11 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
>  	return ret;
>  }
>  
> +static bool xattr_is_user(const char *name)
> +{
> +	return !strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN);
> +}
> +
>  /**
>   * simple_xattr_set - xattr SET operation for in-memory/pseudo filesystems
>   * @xattrs: target simple_xattr list
> @@ -1053,16 +1058,17 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
>   * Returns 0 on success, -errno on failure.
>   */
>  int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
> -		     const void *value, size_t size, int flags,
> -		     ssize_t *removed_size)
> +		     const void *value, size_t size, int flags)
>  {
>  	struct simple_xattr *xattr;
>  	struct simple_xattr *new_xattr = NULL;
> +	bool is_user_xattr = false;
> +	int *sz = &xattrs->xattr_size;
> +	int *nr = &xattrs->nr_xattrs;
> +	int sz_limit = KERNFS_XATTR_SIZE_LIMIT;
> +	int nr_limit = KERNFS_MAX_XATTRS;
>  	int err = 0;
>  
> -	if (removed_size)
> -		*removed_size = -1;
> -
>  	/* value == NULL means remove */
>  	if (value) {
>  		new_xattr = simple_xattr_alloc(value, size);
> @@ -1076,6 +1082,14 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
>  		}
>  	}
>  
> +	is_user_xattr = xattr_is_user(name);
> +	if (is_user_xattr) {
> +		sz = &xattrs->user_xattr_size;
> +		nr = &xattrs->nr_user_xattrs;
> +		sz_limit = KERNFS_USER_XATTR_SIZE_LIMIT;
> +		nr_limit = KERNFS_MAX_USER_XATTRS;
> +	}
> +
>  	spin_lock(&xattrs->lock);
>  	list_for_each_entry(xattr, &xattrs->head, list) {
>  		if (!strcmp(name, xattr->name)) {
> @@ -1083,13 +1097,19 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
>  				xattr = new_xattr;
>  				err = -EEXIST;
>  			} else if (new_xattr) {
> -				list_replace(&xattr->list, &new_xattr->list);
> -				if (removed_size)
> -					*removed_size = xattr->size;
> +				int delta = new_xattr->size - xattr->size;
> +
> +				if (*sz + delta > sz_limit) {
> +					xattr = new_xattr;
> +					err = -ENOSPC;
> +				} else {
> +					*sz += delta;
> +					list_replace(&xattr->list, &new_xattr->list);
> +				}
>  			} else {
> +				*sz -= xattr->size;
> +				(*nr)--;
>  				list_del(&xattr->list);
> -				if (removed_size)
> -					*removed_size = xattr->size;
>  			}
>  			goto out;
>  		}
> @@ -1096,7 +1117,12 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
>  	if (flags & XATTR_REPLACE) {
>  		xattr = new_xattr;
>  		err = -ENODATA;
> +	} else if ((*sz + new_xattr->size > sz_limit) || (*nr == nr_limit)) {
> +		xattr = new_xattr;
> +		err = -ENOSPC;
>  	} else {
> +		*sz += new_xattr->size;
> +		(*nr)++;
>  		list_add(&new_xattr->list, &xattrs->head);
>  		xattr = NULL;
>  	}
> @@ -1172,14 +1197,3 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>  
>  	return err ? err : size - remaining_size;
>  }
> -
> -/*
> - * Adds an extended attribute to the list
> - */
> -void simple_xattr_list_add(struct simple_xattrs *xattrs,
> -			   struct simple_xattr *new_xattr)

You should also remove the function from the header.

> -{
> -	spin_lock(&xattrs->lock);
> -	list_add(&new_xattr->list, &xattrs->head);
> -	spin_unlock(&xattrs->lock);
> -}
> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> index e2ae15a6225e..1972beb0d7b9 100644
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -44,6 +44,8 @@ enum kernfs_node_type {
>  #define KERNFS_FLAG_MASK		~KERNFS_TYPE_MASK
>  #define KERNFS_MAX_USER_XATTRS		128
>  #define KERNFS_USER_XATTR_SIZE_LIMIT	(128 << 10)
> +#define KERNFS_MAX_XATTRS		128
> +#define KERNFS_XATTR_SIZE_LIMIT		(128 << 10)

So iiuc, for tmpfs this is effectively a per-inode limit of 128 xattrs
and 128 user xattrs; nr_inodes * 256. I honestly have no idea if there
are legimitate use-cases to want more. But there's at least a remote
chance that this might break someone.

Apart from

> Currently it's possible to create a huge number of xattr per inode,

what exactly is this limit protecting against? In other words, the
commit message misses the motivation for the patch.
(The original thread it was spun out of was so scattered I honestly
don't have time to dig through it currently. So it'd be great if this
patch expanded on that a bit.)

I'd also prefer to see a summary of what filesystems are affected by
this change. Afaict, the patchset doesn't change anything for kernfs
users such as cgroup{1,2} so it should only be tmpfs and potential
future users of the simple_xattr_* api.

Sidenote: While looking at this I found out that cgroup{1,2} supports
e.g. security.capability to be set on say cpu.stat or similar files.
That seems very strange to me.
