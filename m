Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561BA4668D7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 18:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbhLBRNR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 12:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbhLBRNQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:13:16 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239BEC06174A
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Dec 2021 09:09:54 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id m6so493633oim.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Dec 2021 09:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ey8f/iPkd1ggUFvetrvwC3Q4/dVlpaU6UdFUfwdQN74=;
        b=dtzyHesmMWuDvoVx0gZlos2G3UtGvV/zo4ohsOTY8XgYPxhJqgpC6Llrh6U/J+w2l1
         +WGodwrFqyxNJ2pYNbP//wAwhFgHAROEZwlJUIRIJ/P8IKcwej9ysztezEEet7URUKnx
         hDLBs83BG5e5U9EPmCSgfpEV0Jo8NUlifVemA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ey8f/iPkd1ggUFvetrvwC3Q4/dVlpaU6UdFUfwdQN74=;
        b=chwcGBozxyEu0zUyDB5x5YPhWK5esI5Eqm+0dwptlzNrOkiwwotHMvINQwyaFKZrN8
         z9jIn0ZVOKVBsauEMQWsYWQJLFAWQwGV2zWguL89o6hNn+qKGkvHcxiH5V+UFhmqcFn2
         tb1npBwScxp0zPhIfg6bmwiJoUmE+3h3rnXanh7Of6zJnkMfI6ojILT1oL0IZC1U1qIi
         KT0UkZtE2P+B2sPok7nVhz3QKClDGIbKqcOevii1l7JPcleLT0OI722QeMCfWFk3txDl
         sJZRtN18WJi1wc8mk6XghwNCslUFHXM0eHSO5dIbRe0MO+W0G8WOglHyjDqOpr9xX0f5
         TJyQ==
X-Gm-Message-State: AOAM530YYaR/6RVoer534nMJ/l6LuaS1oB1INdmkif6Z9kFOnz9p6/l3
        zk6iJsKkhRO1HJiXgI9oVE/4ThF4J2GnuOxF
X-Google-Smtp-Source: ABdhPJy/ADODphG0h7tvh1kArV36XVCpMrBMq58kOsPNAnZhJQD9ZyWwVhf7u/8UQ4QBVT3sqM+kpw==
X-Received: by 2002:a05:6808:609:: with SMTP id y9mr5511140oih.178.1638464993379;
        Thu, 02 Dec 2021 09:09:53 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:49aa:e3a:9f96:cf34])
        by smtp.gmail.com with ESMTPSA id m12sm211763oiw.23.2021.12.02.09.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 09:09:52 -0800 (PST)
Date:   Thu, 2 Dec 2021 11:09:51 -0600
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 01/10] fs: add is_idmapped_mnt() helper
Message-ID: <Yaj939e8qynS2Pc8@do-x1extreme>
References: <20211130121032.3753852-1-brauner@kernel.org>
 <20211130121032.3753852-2-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130121032.3753852-2-brauner@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 30, 2021 at 01:10:23PM +0100, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Multiple places open-code the same check to determine whether a given
> mount is idmapped. Introduce a simple helper function that can be used
> instead. This allows us to get rid of the fragile open-coding. We will
> later change the check that is used to determine whether a given mount
> is idmapped. Introducing a helper allows us to do this in a single
> place instead of doing it for multiple places.
> 
> Link: https://lore.kernel.org/r/20211123114227.3124056-2-brauner@kernel.org (v1)
> Cc: Seth Forshee <sforshee@digitalocean.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> CC: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Seth Forshee <sforshee@digitalocean.com>

> ---
> /* v2 */
> - Amir Goldstein <amir73il@gmail.com>:
>   - s/is_mapped_mnt/is_idmapped_mnt/g
> ---
>  fs/cachefiles/bind.c |  2 +-
>  fs/ecryptfs/main.c   |  2 +-
>  fs/namespace.c       |  2 +-
>  fs/nfsd/export.c     |  2 +-
>  fs/overlayfs/super.c |  2 +-
>  fs/proc_namespace.c  |  2 +-
>  include/linux/fs.h   | 14 ++++++++++++++
>  7 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
> index d463d89f5db8..146291be6263 100644
> --- a/fs/cachefiles/bind.c
> +++ b/fs/cachefiles/bind.c
> @@ -117,7 +117,7 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
>  	root = path.dentry;
>  
>  	ret = -EINVAL;
> -	if (mnt_user_ns(path.mnt) != &init_user_ns) {
> +	if (is_idmapped_mnt(path.mnt)) {
>  		pr_warn("File cache on idmapped mounts not supported");
>  		goto error_unsupported;
>  	}
> diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
> index d66bbd2df191..2dd23a82e0de 100644
> --- a/fs/ecryptfs/main.c
> +++ b/fs/ecryptfs/main.c
> @@ -537,7 +537,7 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
>  		goto out_free;
>  	}
>  
> -	if (mnt_user_ns(path.mnt) != &init_user_ns) {
> +	if (is_idmapped_mnt(path.mnt)) {
>  		rc = -EINVAL;
>  		printk(KERN_ERR "Mounting on idmapped mounts currently disallowed\n");
>  		goto out_free;
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 659a8f39c61a..4994b816a74c 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3936,7 +3936,7 @@ static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
>  	 * mapping. It makes things simpler and callers can just create
>  	 * another bind-mount they can idmap if they want to.
>  	 */
> -	if (mnt_user_ns(m) != &init_user_ns)
> +	if (is_idmapped_mnt(m))
>  		return -EPERM;
>  
>  	/* The underlying filesystem doesn't support idmapped mounts yet. */
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 9421dae22737..668c7527b17e 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -427,7 +427,7 @@ static int check_export(struct path *path, int *flags, unsigned char *uuid)
>  		return -EINVAL;
>  	}
>  
> -	if (mnt_user_ns(path->mnt) != &init_user_ns) {
> +	if (is_idmapped_mnt(path->mnt)) {
>  		dprintk("exp_export: export of idmapped mounts not yet supported.\n");
>  		return -EINVAL;
>  	}
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 265181c110ae..7bb0a47cb615 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -873,7 +873,7 @@ static int ovl_mount_dir_noesc(const char *name, struct path *path)
>  		pr_err("filesystem on '%s' not supported\n", name);
>  		goto out_put;
>  	}
> -	if (mnt_user_ns(path->mnt) != &init_user_ns) {
> +	if (is_idmapped_mnt(path->mnt)) {
>  		pr_err("idmapped layers are currently not supported\n");
>  		goto out_put;
>  	}
> diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
> index 392ef5162655..49650e54d2f8 100644
> --- a/fs/proc_namespace.c
> +++ b/fs/proc_namespace.c
> @@ -80,7 +80,7 @@ static void show_mnt_opts(struct seq_file *m, struct vfsmount *mnt)
>  			seq_puts(m, fs_infop->str);
>  	}
>  
> -	if (mnt_user_ns(mnt) != &init_user_ns)
> +	if (is_idmapped_mnt(mnt))
>  		seq_puts(m, ",idmapped");
>  }
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 1cb616fc1105..426cc7bcbeb8 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2725,6 +2725,20 @@ static inline struct user_namespace *file_mnt_user_ns(struct file *file)
>  {
>  	return mnt_user_ns(file->f_path.mnt);
>  }
> +
> +/**
> + * is_idmapped_mnt - check whether a mount is mapped
> + * @mnt: the mount to check
> + *
> + * If @mnt has an idmapping attached to it @mnt is mapped.
> + *
> + * Return: true if mount is mapped, false if not.
> + */
> +static inline bool is_idmapped_mnt(const struct vfsmount *mnt)
> +{
> +	return mnt_user_ns(mnt) != &init_user_ns;
> +}
> +
>  extern long vfs_truncate(const struct path *, loff_t);
>  int do_truncate(struct user_namespace *, struct dentry *, loff_t start,
>  		unsigned int time_attrs, struct file *filp);
> -- 
> 2.30.2
> 
