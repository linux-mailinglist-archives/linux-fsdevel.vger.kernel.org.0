Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC99775640
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 11:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjHIJVN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 05:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjHIJVM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:21:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E671FD5
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 02:21:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CA0662184F;
        Wed,  9 Aug 2023 09:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691572865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sa/Ur4Xvab0nuX/5llhwwRSNuVsSYXGazw2MR1iK1sg=;
        b=gPn+0eHIR3aHvDBuhDFyupFCpo4iecxgslyfGtGaqwipUT8GwGxqlefNMvVW7GmxA6GebR
        XIayPflXzfVmKgRyX+hqg2xheJTQNe3JES4cjHythwT/ZJCGxpuOAoYPyr583uyOGGufh3
        OoJKoNL6vf7KLXKVqaRq+ra5BziLl5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691572865;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sa/Ur4Xvab0nuX/5llhwwRSNuVsSYXGazw2MR1iK1sg=;
        b=cTmN2Y4EQpWzAkVq61Jzr1Dh27eDAVl/eU1XLLtdn0n7PX2VfaVCRlLL9BE7cAXz/s4RnS
        aGQKounQCioLU4Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A6D7133B5;
        Wed,  9 Aug 2023 09:21:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SyvaHYFa02R9DgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 09 Aug 2023 09:21:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A4916A0769; Wed,  9 Aug 2023 11:21:04 +0200 (CEST)
Date:   Wed, 9 Aug 2023 11:21:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleksandr Tymoshenko <ovt@google.com>,
        Carlos Maiolino <cem@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>, Daniel Xu <dxu@dxuuu.xyz>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH vfs.tmpfs 1/5] xattr: simple_xattr_set() return old_xattr
 to be freed
Message-ID: <20230809092104.paz5wu5m5b6blndo@quack3>
References: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com>
 <158c6585-2aa7-d4aa-90ff-f7c3f8fe407c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158c6585-2aa7-d4aa-90ff-f7c3f8fe407c@google.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 08-08-23 21:30:59, Hugh Dickins wrote:
> tmpfs wants to support limited user extended attributes, but kernfs
> (or cgroupfs, the only kernfs with KERNFS_ROOT_SUPPORT_USER_XATTR)
> already supports user extended attributes through simple xattrs: but
> limited by a policy (128KiB per inode) too liberal to be used on tmpfs.
> 
> To allow a different limiting policy for tmpfs, without affecting the
> policy for kernfs, change simple_xattr_set() to return the replaced or
> removed xattr (if any), leaving the caller to update their accounting
> then free the xattr (by simple_xattr_free(), renamed from the static
> free_simple_xattr()).
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/kernfs/inode.c     | 46 +++++++++++++++++++++++++---------------
>  fs/xattr.c            | 51 +++++++++++++++++++--------------------------
>  include/linux/xattr.h |  7 ++++---
>  mm/shmem.c            | 10 +++++----
>  4 files changed, 61 insertions(+), 53 deletions(-)
> 
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index b22b74d1a115..fec5d5f78f07 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -306,11 +306,17 @@ int kernfs_xattr_get(struct kernfs_node *kn, const char *name,
>  int kernfs_xattr_set(struct kernfs_node *kn, const char *name,
>  		     const void *value, size_t size, int flags)
>  {
> +	struct simple_xattr *old_xattr;
>  	struct kernfs_iattrs *attrs = kernfs_iattrs(kn);
>  	if (!attrs)
>  		return -ENOMEM;
>  
> -	return simple_xattr_set(&attrs->xattrs, name, value, size, flags, NULL);
> +	old_xattr = simple_xattr_set(&attrs->xattrs, name, value, size, flags);
> +	if (IS_ERR(old_xattr))
> +		return PTR_ERR(old_xattr);
> +
> +	simple_xattr_free(old_xattr);
> +	return 0;
>  }
>  
>  static int kernfs_vfs_xattr_get(const struct xattr_handler *handler,
> @@ -342,7 +348,7 @@ static int kernfs_vfs_user_xattr_add(struct kernfs_node *kn,
>  {
>  	atomic_t *sz = &kn->iattr->user_xattr_size;
>  	atomic_t *nr = &kn->iattr->nr_user_xattrs;
> -	ssize_t removed_size;
> +	struct simple_xattr *old_xattr;
>  	int ret;
>  
>  	if (atomic_inc_return(nr) > KERNFS_MAX_USER_XATTRS) {
> @@ -355,13 +361,18 @@ static int kernfs_vfs_user_xattr_add(struct kernfs_node *kn,
>  		goto dec_size_out;
>  	}
>  
> -	ret = simple_xattr_set(xattrs, full_name, value, size, flags,
> -			       &removed_size);
> -
> -	if (!ret && removed_size >= 0)
> -		size = removed_size;
> -	else if (!ret)
> +	old_xattr = simple_xattr_set(xattrs, full_name, value, size, flags);
> +	if (!old_xattr)
>  		return 0;
> +
> +	if (IS_ERR(old_xattr)) {
> +		ret = PTR_ERR(old_xattr);
> +		goto dec_size_out;
> +	}
> +
> +	ret = 0;
> +	size = old_xattr->size;
> +	simple_xattr_free(old_xattr);
>  dec_size_out:
>  	atomic_sub(size, sz);
>  dec_count_out:
> @@ -376,18 +387,19 @@ static int kernfs_vfs_user_xattr_rm(struct kernfs_node *kn,
>  {
>  	atomic_t *sz = &kn->iattr->user_xattr_size;
>  	atomic_t *nr = &kn->iattr->nr_user_xattrs;
> -	ssize_t removed_size;
> -	int ret;
> +	struct simple_xattr *old_xattr;
>  
> -	ret = simple_xattr_set(xattrs, full_name, value, size, flags,
> -			       &removed_size);
> +	old_xattr = simple_xattr_set(xattrs, full_name, value, size, flags);
> +	if (!old_xattr)
> +		return 0;
>  
> -	if (removed_size >= 0) {
> -		atomic_sub(removed_size, sz);
> -		atomic_dec(nr);
> -	}
> +	if (IS_ERR(old_xattr))
> +		return PTR_ERR(old_xattr);
>  
> -	return ret;
> +	atomic_sub(old_xattr->size, sz);
> +	atomic_dec(nr);
> +	simple_xattr_free(old_xattr);
> +	return 0;
>  }
>  
>  static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
> diff --git a/fs/xattr.c b/fs/xattr.c
> index e7bbb7f57557..ba37a8f5cfd1 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -1040,12 +1040,12 @@ const char *xattr_full_name(const struct xattr_handler *handler,
>  EXPORT_SYMBOL(xattr_full_name);
>  
>  /**
> - * free_simple_xattr - free an xattr object
> + * simple_xattr_free - free an xattr object
>   * @xattr: the xattr object
>   *
>   * Free the xattr object. Can handle @xattr being NULL.
>   */
> -static inline void free_simple_xattr(struct simple_xattr *xattr)
> +void simple_xattr_free(struct simple_xattr *xattr)
>  {
>  	if (xattr)
>  		kfree(xattr->name);
> @@ -1164,7 +1164,6 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
>   * @value: the value to store along the xattr
>   * @size: the size of @value
>   * @flags: the flags determining how to set the xattr
> - * @removed_size: the size of the removed xattr
>   *
>   * Set a new xattr object.
>   * If @value is passed a new xattr object will be allocated. If XATTR_REPLACE
> @@ -1181,29 +1180,27 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
>   * nothing if XATTR_CREATE is specified in @flags or @flags is zero. For
>   * XATTR_REPLACE we fail as mentioned above.
>   *
> - * Return: On success zero and on error a negative error code is returned.
> + * Return: On success, the removed or replaced xattr is returned, to be freed
> + * by the caller; or NULL if none. On failure a negative error code is returned.
>   */
> -int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
> -		     const void *value, size_t size, int flags,
> -		     ssize_t *removed_size)
> +struct simple_xattr *simple_xattr_set(struct simple_xattrs *xattrs,
> +				      const char *name, const void *value,
> +				      size_t size, int flags)
>  {
> -	struct simple_xattr *xattr = NULL, *new_xattr = NULL;
> +	struct simple_xattr *old_xattr = NULL, *new_xattr = NULL;
>  	struct rb_node *parent = NULL, **rbp;
>  	int err = 0, ret;
>  
> -	if (removed_size)
> -		*removed_size = -1;
> -
>  	/* value == NULL means remove */
>  	if (value) {
>  		new_xattr = simple_xattr_alloc(value, size);
>  		if (!new_xattr)
> -			return -ENOMEM;
> +			return ERR_PTR(-ENOMEM);
>  
>  		new_xattr->name = kstrdup(name, GFP_KERNEL);
>  		if (!new_xattr->name) {
> -			free_simple_xattr(new_xattr);
> -			return -ENOMEM;
> +			simple_xattr_free(new_xattr);
> +			return ERR_PTR(-ENOMEM);
>  		}
>  	}
>  
> @@ -1217,12 +1214,12 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
>  		else if (ret > 0)
>  			rbp = &(*rbp)->rb_right;
>  		else
> -			xattr = rb_entry(*rbp, struct simple_xattr, rb_node);
> -		if (xattr)
> +			old_xattr = rb_entry(*rbp, struct simple_xattr, rb_node);
> +		if (old_xattr)
>  			break;
>  	}
>  
> -	if (xattr) {
> +	if (old_xattr) {
>  		/* Fail if XATTR_CREATE is requested and the xattr exists. */
>  		if (flags & XATTR_CREATE) {
>  			err = -EEXIST;
> @@ -1230,12 +1227,10 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
>  		}
>  
>  		if (new_xattr)
> -			rb_replace_node(&xattr->rb_node, &new_xattr->rb_node,
> -					&xattrs->rb_root);
> +			rb_replace_node(&old_xattr->rb_node,
> +					&new_xattr->rb_node, &xattrs->rb_root);
>  		else
> -			rb_erase(&xattr->rb_node, &xattrs->rb_root);
> -		if (!err && removed_size)
> -			*removed_size = xattr->size;
> +			rb_erase(&old_xattr->rb_node, &xattrs->rb_root);
>  	} else {
>  		/* Fail if XATTR_REPLACE is requested but no xattr is found. */
>  		if (flags & XATTR_REPLACE) {
> @@ -1260,12 +1255,10 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
>  
>  out_unlock:
>  	write_unlock(&xattrs->lock);
> -	if (err)
> -		free_simple_xattr(new_xattr);
> -	else
> -		free_simple_xattr(xattr);
> -	return err;
> -
> +	if (!err)
> +		return old_xattr;
> +	simple_xattr_free(new_xattr);
> +	return ERR_PTR(err);
>  }
>  
>  static bool xattr_is_trusted(const char *name)
> @@ -1386,7 +1379,7 @@ void simple_xattrs_free(struct simple_xattrs *xattrs)
>  		rbp_next = rb_next(rbp);
>  		xattr = rb_entry(rbp, struct simple_xattr, rb_node);
>  		rb_erase(&xattr->rb_node, &xattrs->rb_root);
> -		free_simple_xattr(xattr);
> +		simple_xattr_free(xattr);
>  		rbp = rbp_next;
>  	}
>  }
> diff --git a/include/linux/xattr.h b/include/linux/xattr.h
> index d591ef59aa98..e37fe667ae04 100644
> --- a/include/linux/xattr.h
> +++ b/include/linux/xattr.h
> @@ -116,11 +116,12 @@ struct simple_xattr {
>  void simple_xattrs_init(struct simple_xattrs *xattrs);
>  void simple_xattrs_free(struct simple_xattrs *xattrs);
>  struct simple_xattr *simple_xattr_alloc(const void *value, size_t size);
> +void simple_xattr_free(struct simple_xattr *xattr);
>  int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
>  		     void *buffer, size_t size);
> -int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
> -		     const void *value, size_t size, int flags,
> -		     ssize_t *removed_size);
> +struct simple_xattr *simple_xattr_set(struct simple_xattrs *xattrs,
> +				      const char *name, const void *value,
> +				      size_t size, int flags);
>  ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>  			  char *buffer, size_t size);
>  void simple_xattr_add(struct simple_xattrs *xattrs,
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 0f83d86fd8b4..df3cabf54206 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3595,15 +3595,17 @@ static int shmem_xattr_handler_set(const struct xattr_handler *handler,
>  				   size_t size, int flags)
>  {
>  	struct shmem_inode_info *info = SHMEM_I(inode);
> -	int err;
> +	struct simple_xattr *old_xattr;
>  
>  	name = xattr_full_name(handler, name);
> -	err = simple_xattr_set(&info->xattrs, name, value, size, flags, NULL);
> -	if (!err) {
> +	old_xattr = simple_xattr_set(&info->xattrs, name, value, size, flags);
> +	if (!IS_ERR(old_xattr)) {
> +		simple_xattr_free(old_xattr);
> +		old_xattr = NULL;
>  		inode->i_ctime = current_time(inode);
>  		inode_inc_iversion(inode);
>  	}
> -	return err;
> +	return PTR_ERR(old_xattr);
>  }
>  
>  static const struct xattr_handler shmem_security_xattr_handler = {
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
