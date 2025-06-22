Return-Path: <linux-fsdevel+bounces-52420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D04AE324B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 23:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B590816F324
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 21:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230471A5B92;
	Sun, 22 Jun 2025 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="gx1zjDnc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8387FEAC6
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750627190; cv=none; b=HM4hRMUV14E7EGNy2LJfmx2aEAjQtVnkdFVYGcUbRpCZAJLTrJxECzGs1ucXb9Q7duHQmtKrbn3VXYNwe2g7yfyUDTK2NP2UPgmGSyqYN9OPoun9bNleI+MdkkSQMmVPLo/qXKk/ngRiWpZWVsCwgfV5FMtxSx0Vbo7Zl1q6HBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750627190; c=relaxed/simple;
	bh=BuW5NNZzyqCVPlEP8n+RnfgIb508yLCDcEJ7c609zf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRpP8SP+Xe2HYKrfUTWBhaSFW/ZcAciSE9/3DO1kQGiht/uXisc3D/Ad0hIhqKmUiAmztRQlcHcMff+RJTeiQ0llOrZfDT7EBWIdATA2w5ZVXGL/8XYxTuLBF3ijnzy+oNmahTaaOT43xr7q7UWayakYLjmfzv5nrlOaJwFkAwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=gx1zjDnc; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-553d52cb80dso3746894e87.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 14:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1750627187; x=1751231987; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lVZ3pAi9xeGcPwJhLJxQOvsDeFhAHrbbJOoCZmNbVwY=;
        b=gx1zjDncv1LEF4hAYQu0N7rGi3B0JPT1Uo3pihHkX+kEjg5m1gX+5+QgjS3hgZeH32
         emXyJK5vjWYLMaBjkixihGr5+PvlB1dsT3g1xhyR72kxCP+bQrxrWlN0AEi+yMYiFqiv
         TMgyOmhUEhIDY/Kr6iSBeTB8WJ+tuvTPT2wEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750627187; x=1751231987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVZ3pAi9xeGcPwJhLJxQOvsDeFhAHrbbJOoCZmNbVwY=;
        b=FfwWJB7N0LYJb20cB+f2CgPkR5I7TW1o3N2kr9um9bIXcxaHi1i6QP2UBmgDXsaOHt
         ssuH6KrlOIYaP1tiUszQcnLCN0EaY1POaUBU5D1N5cQzTtG+FDf8i0UkQtnLwMuDMmI7
         GxY8LXvtnFlxN7AhYBVCgjrh83bO0zCVr6qszU1tjxXisLh7D3PFNtrmh9iOOE7IM8W7
         rmwxo2V3coWuE7DIkS+lttx7Y8SNqMJECSlTnQ6kMzeKcl5ZknUSfCTk6L8kOWMs/0BZ
         TK7OQEX26ntV5vps1qT0Ra6AB6bCQ+D1reccJ4OpdrMNOfBII+eCyTXwFt2KYokfKc84
         bURg==
X-Gm-Message-State: AOJu0YyJgNQeB1XRq8w3Y1nCueXHgmmAfp67cpkBZ1zzXaqMgmGPeh0m
	hBz5GztDbyNoNLaP2WWoSEBRGG4oGra+90vvauDfusipEo343+qaSxWGDMmFjk/Cg4dH2SfeQEf
	x3IyNIxMzG2/2+QEWAbSKXwsXezMRwOjg+U1tsnDsuQ==
X-Gm-Gg: ASbGncthqjz9Rn9Uf6vfP3jQDtvKKaUsBqO9LR3wO1aSCgY1sGYkFbIEVtcssIhGzte
	3y9eV59MOFNQY50BIA9JswunD/znt7VhSfz2pF3ihcM6fAjA9PUJY8qWE7YMiyvL7Np83bDwtiF
	lRFVt8ZUlfaQkqbCybjIogEexoR2W3qMkJ2mC1kr5THMbJJN7Ll9saglc=
X-Google-Smtp-Source: AGHT+IFTJnwaGfFc/AJ0PwO/gS/bP63tByOtFO0RXA+KwmjIHJFV7o1enqq5uIYf893dbHSg47QKhb3D1fOhqYvh1vo=
X-Received: by 2002:a05:6512:1284:b0:550:e04d:2b66 with SMTP id
 2adb3069b0e04-553e503c1eamr2148456e87.17.1750627186467; Sun, 22 Jun 2025
 14:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org> <20250618-work-pidfs-persistent-v2-12-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-12-98f3456fd552@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Sun, 22 Jun 2025 23:19:35 +0200
X-Gm-Features: Ac12FXwfBrTStBApNQR6WKJoSSEj5fKlPKrnsElev2Ayej0VHiB42JBribE6RcI
Message-ID: <CAJqdLrpK8NARbLf4bNmy+xbqaFXpKYiRCQQhX7d+tbZMyiNnOw@mail.gmail.com>
Subject: Re: [PATCH v2 12/16] pidfs: support xattrs on pidfds
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Mi., 18. Juni 2025 um 22:54 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Now that we have a way to persist information for pidfs dentries we can
> start supporting extended attributes on pidfds. This will allow
> userspace to attach meta information to tasks.
>
> One natural extension would be to introduce a custom pidfs.* extended
> attribute space and allow for the inheritance of extended attributes
> across fork() and exec().
>
> The first simple scheme will allow privileged userspace to set trusted
> extended attributes on pidfs inodes.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/pidfs.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 102 insertions(+), 4 deletions(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index df5bc69ea1c0..15d99854d243 100644
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
> @@ -28,6 +29,7 @@
>  #define PIDFS_PID_DEAD ERR_PTR(-ESRCH)
>
>  static struct kmem_cache *pidfs_attr_cachep __ro_after_init;
> +static struct kmem_cache *pidfs_xattr_cachep __ro_after_init;
>
>  /*
>   * Stashes information that userspace needs to access even after the
> @@ -40,6 +42,7 @@ struct pidfs_exit_info {
>  };
>
>  struct pidfs_attr {
> +       struct simple_xattrs *xattrs;
>         struct pidfs_exit_info __pei;
>         struct pidfs_exit_info *exit_info;
>  };
> @@ -138,14 +141,27 @@ void pidfs_remove_pid(struct pid *pid)
>
>  void pidfs_free_pid(struct pid *pid)
>  {
> +       struct pidfs_attr *attr __free(kfree) = no_free_ptr(pid->attr);
> +       struct simple_xattrs *xattrs __free(kfree) = NULL;
> +
>         /*
>          * Any dentry must've been wiped from the pid by now.
>          * Otherwise there's a reference count bug.
>          */
>         VFS_WARN_ON_ONCE(pid->stashed);
>
> -       if (!IS_ERR(pid->attr))
> -               kfree(pid->attr);
> +       if (IS_ERR(attr))
> +               return;
> +
> +       /*
> +        * Any dentry must've been wiped from the pid by now. Otherwise
> +        * there's a reference count bug.
> +        */
> +       VFS_WARN_ON_ONCE(pid->stashed);

We have (almost) the same chunk 5 lines above. ;-)

> +
> +       xattrs = attr->xattrs;
> +       if (xattrs)
> +               simple_xattrs_free(attr->xattrs, NULL);
>  }
>
>  #ifdef CONFIG_PROC_FS
> @@ -663,9 +679,24 @@ static int pidfs_getattr(struct mnt_idmap *idmap, const struct path *path,
>         return anon_inode_getattr(idmap, path, stat, request_mask, query_flags);
>  }
>
> +static ssize_t pidfs_listxattr(struct dentry *dentry, char *buf, size_t size)
> +{
> +       struct inode *inode = d_inode(dentry);
> +       struct pid *pid = inode->i_private;
> +       struct pidfs_attr *attr = pid->attr;
> +       struct simple_xattrs *xattrs;
> +
> +       xattrs = READ_ONCE(attr->xattrs);
> +       if (!xattrs)
> +               return 0;
> +
> +       return simple_xattr_list(inode, xattrs, buf, size);
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
> @@ -905,6 +936,67 @@ static const struct stashed_operations pidfs_stashed_ops = {
>         .put_data       = pidfs_put_data,
>  };
>
> +static int pidfs_xattr_get(const struct xattr_handler *handler,
> +                          struct dentry *unused, struct inode *inode,
> +                          const char *suffix, void *value, size_t size)
> +{
> +       struct pid *pid = inode->i_private;
> +       struct pidfs_attr *attr = pid->attr;
> +       const char *name;
> +       struct simple_xattrs *xattrs;
> +
> +       xattrs = READ_ONCE(attr->xattrs);
> +       if (!xattrs)
> +               return 0;
> +
> +       name = xattr_full_name(handler, suffix);
> +       return simple_xattr_get(xattrs, name, value, size);
> +}
> +
> +static int pidfs_xattr_set(const struct xattr_handler *handler,
> +                          struct mnt_idmap *idmap, struct dentry *unused,
> +                          struct inode *inode, const char *suffix,
> +                          const void *value, size_t size, int flags)
> +{
> +       struct pid *pid = inode->i_private;
> +       struct pidfs_attr *attr = pid->attr;
> +       const char *name;
> +       struct simple_xattrs *xattrs;
> +       struct simple_xattr *old_xattr;
> +
> +       /* Ensure we're the only one to set @attr->xattrs. */
> +       WARN_ON_ONCE(!inode_is_locked(inode));
> +
> +       xattrs = READ_ONCE(attr->xattrs);
> +       if (!xattrs) {
> +               xattrs = kmem_cache_zalloc(pidfs_xattr_cachep, GFP_KERNEL);
> +               if (!xattrs)
> +                       return -ENOMEM;
> +
> +               simple_xattrs_init(xattrs);
> +               smp_store_release(&pid->attr->xattrs, xattrs);
> +       }
> +
> +       name = xattr_full_name(handler, suffix);
> +       old_xattr = simple_xattr_set(xattrs, name, value, size, flags);
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
> @@ -918,6 +1010,7 @@ static int pidfs_init_fs_context(struct fs_context *fc)
>         ctx->ops = &pidfs_sops;
>         ctx->eops = &pidfs_export_operations;
>         ctx->dops = &pidfs_dentry_operations;
> +       ctx->xattr = pidfs_xattr_handlers;
>         fc->s_fs_info = (void *)&pidfs_stashed_ops;
>         return 0;
>  }
> @@ -960,6 +1053,11 @@ void __init pidfs_init(void)
>         pidfs_attr_cachep = kmem_cache_create("pidfs_attr_cache", sizeof(struct pidfs_attr), 0,
>                                          (SLAB_HWCACHE_ALIGN | SLAB_RECLAIM_ACCOUNT |
>                                           SLAB_ACCOUNT | SLAB_PANIC), NULL);
> +
> +       pidfs_xattr_cachep = kmem_cache_create("pidfs_xattr_cache",
> +                                              sizeof(struct simple_xattrs), 0,
> +                                              SLAB_PANIC, NULL);

WDYT about adding SLAB_ACCOUNT here?

> +
>         pidfs_mnt = kern_mount(&pidfs_type);
>         if (IS_ERR(pidfs_mnt))
>                 panic("Failed to mount pidfs pseudo filesystem");
>
> --
> 2.47.2
>

