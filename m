Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDE63DD597
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 14:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbhHBMYp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 08:24:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233498AbhHBMYo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 08:24:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C148D600D4;
        Mon,  2 Aug 2021 12:24:32 +0000 (UTC)
Date:   Mon, 2 Aug 2021 14:24:30 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 01/21] namei: add mapping aware lookup helper
Message-ID: <20210802122430.25hlgpnkwfemvih3@wittgenstein>
References: <20210727104900.829215-1-brauner@kernel.org>
 <20210727104900.829215-2-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210727104900.829215-2-brauner@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 12:48:40PM +0200, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Various filesystems rely on the lookup_one_len() helper to lookup a single path
> component relative to a well-known starting point. Allow such filesystems to
> support idmapped mounts by adding a version of this helper to take the idmap
> into account when calling inode_permission(). This change is a required to let
> btrfs (and other filesystems) support idmapped mounts.
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: linux-fsdevel@vger.kernel.org
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---

Christoph, Matthew are you ok with this now?

Christian

> /* v2 */
> - Al Viro <viro@zeniv.linux.org.uk>:
>   - Add a new lookup helper instead of changing the old ones.
> 
> /* v3 */
> unchanged
> 
> /* v4 */
> - Christoph Hellwig <hch@infradead.org>,
>   Matthew Wilcox (Oracle) <willy@infradead.org>:
>   - Simplify the name of lookup_mapped_one_len() to either lookup_one_mapped()
>     or lookup_one(). The *_len() prefix in all those helper apparently just
>     exists for historical reasons because we used to have lookup_dentry(), then
>     grew lookup_one(), and then grew lookup_one_len().
> ---
>  fs/namei.c            | 43 +++++++++++++++++++++++++++++++++++++------
>  include/linux/namei.h |  2 ++
>  2 files changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index bf6d8a738c59..902df46e7dd3 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2575,8 +2575,9 @@ int vfs_path_lookup(struct dentry *dentry, struct vfsmount *mnt,
>  }
>  EXPORT_SYMBOL(vfs_path_lookup);
>  
> -static int lookup_one_len_common(const char *name, struct dentry *base,
> -				 int len, struct qstr *this)
> +static int lookup_one_common(struct user_namespace *mnt_userns,
> +			     const char *name, struct dentry *base, int len,
> +			     struct qstr *this)
>  {
>  	this->name = name;
>  	this->len = len;
> @@ -2604,7 +2605,7 @@ static int lookup_one_len_common(const char *name, struct dentry *base,
>  			return err;
>  	}
>  
> -	return inode_permission(&init_user_ns, base->d_inode, MAY_EXEC);
> +	return inode_permission(mnt_userns, base->d_inode, MAY_EXEC);
>  }
>  
>  /**
> @@ -2628,7 +2629,7 @@ struct dentry *try_lookup_one_len(const char *name, struct dentry *base, int len
>  
>  	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
>  
> -	err = lookup_one_len_common(name, base, len, &this);
> +	err = lookup_one_common(&init_user_ns, name, base, len, &this);
>  	if (err)
>  		return ERR_PTR(err);
>  
> @@ -2655,7 +2656,7 @@ struct dentry *lookup_one_len(const char *name, struct dentry *base, int len)
>  
>  	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
>  
> -	err = lookup_one_len_common(name, base, len, &this);
> +	err = lookup_one_common(&init_user_ns, name, base, len, &this);
>  	if (err)
>  		return ERR_PTR(err);
>  
> @@ -2664,6 +2665,36 @@ struct dentry *lookup_one_len(const char *name, struct dentry *base, int len)
>  }
>  EXPORT_SYMBOL(lookup_one_len);
>  
> +/**
> + * lookup_one - filesystem helper to lookup single pathname component
> + * @mnt_userns:	user namespace of the mount the lookup is performed from
> + * @name:	pathname component to lookup
> + * @base:	base directory to lookup from
> + * @len:	maximum length @len should be interpreted to
> + *
> + * Note that this routine is purely a helper for filesystem usage and should
> + * not be called by generic code.
> + *
> + * The caller must hold base->i_mutex.
> + */
> +struct dentry *lookup_one(struct user_namespace *mnt_userns, const char *name,
> +			  struct dentry *base, int len)
> +{
> +	struct dentry *dentry;
> +	struct qstr this;
> +	int err;
> +
> +	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
> +
> +	err = lookup_one_common(mnt_userns, name, base, len, &this);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	dentry = lookup_dcache(&this, base, 0);
> +	return dentry ? dentry : __lookup_slow(&this, base, 0);
> +}
> +EXPORT_SYMBOL(lookup_one);
> +
>  /**
>   * lookup_one_len_unlocked - filesystem helper to lookup single pathname component
>   * @name:	pathname component to lookup
> @@ -2683,7 +2714,7 @@ struct dentry *lookup_one_len_unlocked(const char *name,
>  	int err;
>  	struct dentry *ret;
>  
> -	err = lookup_one_len_common(name, base, len, &this);
> +	err = lookup_one_common(&init_user_ns, name, base, len, &this);
>  	if (err)
>  		return ERR_PTR(err);
>  
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index be9a2b349ca7..df106b6d3cc5 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -68,6 +68,8 @@ extern struct dentry *try_lookup_one_len(const char *, struct dentry *, int);
>  extern struct dentry *lookup_one_len(const char *, struct dentry *, int);
>  extern struct dentry *lookup_one_len_unlocked(const char *, struct dentry *, int);
>  extern struct dentry *lookup_positive_unlocked(const char *, struct dentry *, int);
> +extern struct dentry *lookup_one(struct user_namespace *, const char *,
> +				 struct dentry *, int);
>  
>  extern int follow_down_one(struct path *);
>  extern int follow_down(struct path *);
> -- 
> 2.30.2
> 
