Return-Path: <linux-fsdevel+bounces-52114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EF1ADF748
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 21:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A8F4A364D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45F3219E8D;
	Wed, 18 Jun 2025 19:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="MfibKnta"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E081E0B91
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750276501; cv=none; b=C5ez6IJaExB3B0VxtN51DDbfCmae0ZkdM73GDO4qS5pQ8K0YnujEUp+2bz9DvUfMk2LIkz+Dw83dF4d45Qn1yawus82GAEB4EEW7jpUKNjny2rtGBVA91n+TCbc2zXjd3hfrtmdkp1vfA4ZSLIy6nwjFAbw4BwxT7XZSfIEryEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750276501; c=relaxed/simple;
	bh=2FLGK73hQjegtWrWrK39yGvV9+siNyTGhXfzaQ33rHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jv9QtIwJd33hqyOXtPmw0J+b9f+pyLsGa24TDscPOl9WAekrgHjyi3Kftx2NIVvR2ep/s6JABRsXHEYAwxrwxObbwVpi0BXRIKy5yswM7aSKLldmm9G3vpjBhFt4W8A4vSUqZmTndOwiyImJH5LET9ACXnbeg0XWF/AhJt1/hso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=MfibKnta; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-553b9eb2299so1106651e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 12:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1750276497; x=1750881297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g73XySW/JrqKh9fn3CUVRV7CcSACxhCH2iyOMCK8k1s=;
        b=MfibKntauuvjqvunlIwU6cEoi8X4KZ52OYe3n3D53JnwVGXAypVIB/lFT4E0ZGm1RD
         tzvjnOExBZgGnDfXDl6IvhhPUbNQ24uAr6jTxKJlRWBYP7mmhsKAOwzWKvxEHx4EbggT
         nccrROUiPQuUVdXzzXDQuZ+ERp8HuhrDYUFKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750276497; x=1750881297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g73XySW/JrqKh9fn3CUVRV7CcSACxhCH2iyOMCK8k1s=;
        b=DjXu2XNy1AeGEQxHhr5kyc5tmp3D0fs7orpWFlHc9J99kL0+I6uTOuAYpdlMMgd1fD
         fbjRXIBsyQRgA9oQhR5LuFgT6xJFYXsOxcztGfTZH01POnKjWSDNPHzOJ0agUr99WBqn
         1gT1Iz3ypPKf1TsOUeQlum1yHYZrFW6pZVQx3z4UiXK0cQQeEzzY0p+EPgmy/AM7uISK
         EauEhnoPooqvkVRD5KWP/p6ZA+WGhhy4+Te0CXix6NyUg3DkshPvJV5NTATw0855UGDa
         +wGD0G9v2J2MDoQQ1muMTL5chcbD/MWFDBILOldr1NoZ0GIuyFCkPeOlTdLNFDGBAKfl
         oIOw==
X-Gm-Message-State: AOJu0YwdVErm66JvBq9Xpck66+PD56DCru8uYrUNMbic0uNP9d0THSSx
	RUwgl8GPYtggXLdVhObcsvNmI8L8+rmurPbdZejQYQBHJH6iC0Eii0piza8gcsmLJT3+BvUYwyO
	yz4R9LqwKcp9+pq4QX4KW/mPL/DIppZB0sD9zUkd8FA==
X-Gm-Gg: ASbGnct/DCGlrOZdT6h1UYU46zE4+zH2t4eZ/YuOjDWoq8oBGEa7Flkyw9DkxCRrG/F
	pFIckg+c01ZQzwDfJe8M92NDYjJdrv3vVTWLKb0kU4pI7hhjvhv9ye75MKUlGTJhTRiS/mbD/f/
	5wBq9tQd2pJtzqTyNuhDgKNbwV95QMFSzSj2NqCBgVvXre4E8KPxRyjd8=
X-Google-Smtp-Source: AGHT+IHbqdkr48hgmbl5IDZzocLJVotdhuRT40zYbIMh6GffdqnHJpCCCoLvn9utNDov6Q3ykz9yglfHYWEfqinR+ak=
X-Received: by 2002:ac2:568d:0:b0:553:243c:c1d3 with SMTP id
 2adb3069b0e04-553d9812ae5mr251272e87.18.1750276497234; Wed, 18 Jun 2025
 12:54:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617-work-pidfs-xattr-v1-0-d9466a20da2e@kernel.org> <20250617-work-pidfs-xattr-v1-4-d9466a20da2e@kernel.org>
In-Reply-To: <20250617-work-pidfs-xattr-v1-4-d9466a20da2e@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 18 Jun 2025 21:54:45 +0200
X-Gm-Features: Ac12FXyjxXRK557QgI6tH8knEzWq3DgpOBARF2b64WTN3ThIIWd0_ZJJz_p59IQ
Message-ID: <CAJqdLrqWPKQnF84yDptFxk3dWCJvBbhOz7x9BhEfx64=Jgq84g@mail.gmail.com>
Subject: Re: [PATCH RFC 4/7] pidfs: support xattrs on pidfds
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Di., 17. Juni 2025 um 17:45 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/pidfs.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 92 insertions(+), 2 deletions(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 1343bfc60e3f..b1968f628417 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -21,6 +21,7 @@
>  #include <linux/utsname.h>
>  #include <net/net_namespace.h>
>  #include <linux/coredump.h>
> +#include <linux/xattr.h>
>
>  #include "internal.h"
>  #include "mount.h"
> @@ -40,6 +41,7 @@
>  #define PIDFS_PID_DEAD ERR_PTR(-ESRCH)
>
>  static struct kmem_cache *pidfs_cachep __ro_after_init;
> +static struct kmem_cache *pidfs_attrs_cachep __ro_after_init;
>
>  /*
>   * Stashes information that userspace needs to access even after the
> @@ -51,9 +53,14 @@ struct pidfs_exit_info {
>         __u32 coredump_mask;
>  };
>
> +struct pidfs_attrs {
> +       struct simple_xattrs xattrs;
> +};
> +
>  struct pidfs_inode {
>         struct pidfs_exit_info __pei;
>         struct pidfs_exit_info *exit_info;
> +       struct pidfs_attrs *attrs;
>         struct inode vfs_inode;
>  };
>
> @@ -672,15 +679,34 @@ static int pidfs_getattr(struct mnt_idmap *idmap, const struct path *path,
>         return anon_inode_getattr(idmap, path, stat, request_mask, query_flags);
>  }
>
> +static ssize_t pidfs_listxattr(struct dentry *dentry, char *buf, size_t size)
> +{
> +       struct inode *inode = d_inode(dentry);
> +       struct pidfs_attrs *attrs;
> +
> +       attrs = READ_ONCE(pidfs_i(inode)->attrs);
> +       if (!attrs)
> +               return -ENODATA;
> +
> +       return simple_xattr_list(inode, &attrs->xattrs, buf, size);
> +}
> +
>  static const struct inode_operations pidfs_inode_operations = {
> -       .getattr = pidfs_getattr,
> -       .setattr = pidfs_setattr,
> +       .getattr        = pidfs_getattr,
> +       .setattr        = pidfs_setattr,
> +       .listxattr      = pidfs_listxattr,
>  };
>
>  static void pidfs_evict_inode(struct inode *inode)
>  {
>         struct pid *pid = inode->i_private;
> +       struct pidfs_attrs *attrs;
>
> +       attrs = READ_ONCE(pidfs_i(inode)->attrs);
> +       if (attrs) {
> +               simple_xattrs_free(&attrs->xattrs, NULL);
> +               kmem_cache_free(pidfs_attrs_cachep, attrs);
> +       }
>         clear_inode(inode);
>         put_pid(pid);
>  }
> @@ -695,6 +721,7 @@ static struct inode *pidfs_alloc_inode(struct super_block *sb)
>
>         memset(&pi->__pei, 0, sizeof(pi->__pei));
>         pi->exit_info = NULL;
> +       pi->attrs = NULL;
>
>         return &pi->vfs_inode;
>  }
> @@ -951,6 +978,63 @@ static const struct stashed_operations pidfs_stashed_ops = {
>         .put_data       = pidfs_put_data,
>  };
>
> +static int pidfs_xattr_get(const struct xattr_handler *handler,
> +                          struct dentry *unused, struct inode *inode,
> +                          const char *suffix, void *value, size_t size)
> +{
> +       const char *name;
> +       struct pidfs_attrs *attrs;
> +
> +       attrs = READ_ONCE(pidfs_i(inode)->attrs);
> +       if (!attrs)
> +               return -ENODATA;
> +
> +       name = xattr_full_name(handler, suffix);
> +       return simple_xattr_get(&attrs->xattrs, name, value, size);
> +}
> +
> +static int pidfs_xattr_set(const struct xattr_handler *handler,
> +                          struct mnt_idmap *idmap, struct dentry *unused,
> +                          struct inode *inode, const char *suffix,
> +                          const void *value, size_t size, int flags)
> +{
> +       const char *name;
> +       struct pidfs_attrs *attrs;
> +       struct simple_xattr *old_xattr;
> +
> +       /* Make sure we're the only one here. */
> +       WARN_ON_ONCE(!inode_is_locked(inode));
> +
> +       attrs = READ_ONCE(pidfs_i(inode)->attrs);
> +       if (!attrs) {
> +               attrs = kmem_cache_zalloc(pidfs_attrs_cachep, GFP_KERNEL);
> +               if (!attrs)
> +                       return -ENOMEM;
> +
> +               simple_xattrs_init(&attrs->xattrs);
> +               smp_store_release(&pidfs_i(inode)->attrs, attrs);
> +       }
> +
> +       name = xattr_full_name(handler, suffix);
> +       old_xattr = simple_xattr_set(&attrs->xattrs, name, value, size, flags);
> +       if (IS_ERR(old_xattr))
> +               return PTR_ERR(old_xattr);
> +
> +       simple_xattr_free(old_xattr);
> +       return 0;
> +}
> +
> +static const struct xattr_handler pidfs_trusted_xattr_handler = {
> +       .prefix = XATTR_TRUSTED_PREFIX,
> +       .get    = pidfs_xattr_get,
> +       .set    = pidfs_xattr_set,
> +};
> +
> +static const struct xattr_handler *const pidfs_xattr_handlers[] = {
> +       &pidfs_trusted_xattr_handler,
> +       NULL
> +};
> +
>  static int pidfs_init_fs_context(struct fs_context *fc)
>  {
>         struct pseudo_fs_context *ctx;
> @@ -964,6 +1048,7 @@ static int pidfs_init_fs_context(struct fs_context *fc)
>         ctx->ops = &pidfs_sops;
>         ctx->eops = &pidfs_export_operations;
>         ctx->dops = &pidfs_dentry_operations;
> +       ctx->xattr = pidfs_xattr_handlers;
>         fc->s_fs_info = (void *)&pidfs_stashed_ops;
>         return 0;
>  }
> @@ -1073,6 +1158,11 @@ void __init pidfs_init(void)
>                                          (SLAB_HWCACHE_ALIGN | SLAB_RECLAIM_ACCOUNT |
>                                           SLAB_ACCOUNT | SLAB_PANIC),
>                                          pidfs_inode_init_once);
> +
> +       pidfs_attrs_cachep = kmem_cache_create("pidfs_attrs_cache",
> +                                              sizeof(struct pidfs_attrs), 0,
> +                                              SLAB_PANIC, NULL);

nit: WDYT about adding SLAB_ACCOUNT too?

> +
>         pidfs_mnt = kern_mount(&pidfs_type);
>         if (IS_ERR(pidfs_mnt))
>                 panic("Failed to mount pidfs pseudo filesystem");
>
> --
> 2.47.2
>

