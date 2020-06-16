Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39BF1FAC61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 11:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgFPJ3h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 05:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgFPJ3g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 05:29:36 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EC2C05BD43
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2020 02:29:36 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id q19so20737583eja.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2020 02:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jlFA+GTjGZ+L42JiWyLY/sT3a84aFaqvE9tLcVF3C/0=;
        b=ku/p9KfEweLEgoNEM1FGzPBvAZajr2kRWxHXI6hUWg6LjXkzy4zLKaJqMFauvaFjt8
         V8waq3P0rV4zzRStT6Z5JqLwPSeLeyK4Jk70qdLpABAE2tL1+i+kRpj8CqLUiGRjV4+V
         ZZ+y9J/Lw5+a7okEFEh4R88aZos7fsM9E+brE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jlFA+GTjGZ+L42JiWyLY/sT3a84aFaqvE9tLcVF3C/0=;
        b=ZtCewZ8/RW7aqkKa2B14ld3BHPpozM4VJX8SrnEWDjVvOFC2gzA4lykRI620SZ08/T
         8/aP6k14sDEaOEBLQYQ1aBmOAcYNuEZCfCryGf5AYglVoQz5/96f03RU3MKsO5GaBBZZ
         HtW3XtFjKP/p9mYiYh62PJ+RGZ87czdqApx9Wbs9oEubVztgB/npYRwWErPd89ELuQwq
         Njz9LhjRtvr8tsEIbdgRVonv2X+Ko4gAsKbL12DyymQFjnlPcKUB0txgqGUMOO/UWhOH
         cwY49PHO4aUB+Gb5uzKoqPdfu6QgjRv5z7mfIhUwHOah1XBduvVtB90rGlEYYoG8jLnF
         grQA==
X-Gm-Message-State: AOAM530hYCj2m1GB1WUy6B7uIuE2kjMU5iTLPOtfOtBSqlIMwj+F+hGF
        9Ayo0qR03fjrRrn2MSFmd1sF9oAqE9MaBU/atru+jA==
X-Google-Smtp-Source: ABdhPJyG96tRwK2q4LWrLqp38mxwpBY0UgQOH0OEvduxu53ODjV0lolUMgbI+b71DQqoLy4I0qrblpxIBLmk5ZM1hXA=
X-Received: by 2002:a17:906:b7cd:: with SMTP id fy13mr1807669ejb.443.1592299774818;
 Tue, 16 Jun 2020 02:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200601053214.201723-1-chirantan@chromium.org> <20200610092744.140038-1-chirantan@chromium.org>
In-Reply-To: <20200610092744.140038-1-chirantan@chromium.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 16 Jun 2020 11:29:23 +0200
Message-ID: <CAJfpegs4Dt9gjQPQch=i_GW5EtBVaycG0_nD11xspG3x8f_W9Q@mail.gmail.com>
Subject: Re: [PATCH v2] RFC: fuse: Call security hooks on new inodes
To:     Chirantan Ekbote <chirantan@chromium.org>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 10, 2020 at 11:27 AM Chirantan Ekbote
<chirantan@chromium.org> wrote:
>
> Add a new `init_security` field to `fuse_conn` that controls whether we
> initialize security when a new inode is created.  Also add a
> `FUSE_SECURITY_CTX` flag that can be set in the `flags` field of the
> `fuse_init_out` struct that controls when the `init_security` field is
> set.
>
> When set to true, get the security context for a newly created inode via
> `security_dentry_init_security` and append it to the create, mkdir,
> mknod, and symlink requests.  The server should use this context by
> writing it to `/proc/thread-self/attr/fscreate` before creating the
> requested inode.

This is confusing.  You mean if the server is stacking on top of a
real fs, then it can force the created new inode to have the given
security attributes by writing to that proc file?

> Calling security hooks is needed for `setfscreatecon` to work since it
> is applied as part of the selinux security hook.
>
> Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
> ---
> Changes in v2:
>   * Added the FUSE_SECURITY_CTX flag for init_out responses.
>   * Switched to security_dentry_init_security.
>   * Send security context with create, mknod, mkdir, and symlink
>     requests instead of applying it after creation.
>
>  fs/fuse/dir.c             | 99 +++++++++++++++++++++++++++++++++++++--
>  fs/fuse/fuse_i.h          |  3 ++
>  fs/fuse/inode.c           |  5 +-
>  include/uapi/linux/fuse.h |  8 +++-
>  4 files changed, 110 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index ee190119f45cc..86bc073bb4f0a 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -16,6 +16,9 @@
>  #include <linux/xattr.h>
>  #include <linux/iversion.h>
>  #include <linux/posix_acl.h>
> +#include <linux/security.h>
> +#include <linux/types.h>
> +#include <linux/kernel.h>
>
>  static void fuse_advise_use_readdirplus(struct inode *dir)
>  {
> @@ -442,6 +445,8 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>         struct fuse_entry_out outentry;
>         struct fuse_inode *fi;
>         struct fuse_file *ff;
> +       void *security_ctx = NULL;
> +       u32 security_ctxlen = 0;
>
>         /* Userspace expects S_IFREG in create mode */
>         BUG_ON((mode & S_IFMT) != S_IFREG);
> @@ -477,6 +482,21 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>         args.out_args[0].value = &outentry;
>         args.out_args[1].size = sizeof(outopen);
>         args.out_args[1].value = &outopen;
> +
> +       if (fc->init_security) {
> +               err = security_dentry_init_security(entry, mode, &entry->d_name,
> +                                                   &security_ctx,
> +                                                   &security_ctxlen);
> +               if (err)
> +                       goto out_put_forget_req;
> +
> +               if (security_ctxlen > 0) {
> +                       args.in_numargs = 3;
> +                       args.in_args[2].size = security_ctxlen;
> +                       args.in_args[2].value = security_ctx;
> +               }
> +       }
> +

The above is quadruplicated, a helper is in order.

>         err = fuse_simple_request(fc, &args);
>         if (err)
>                 goto out_free_ff;
> @@ -513,6 +533,8 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>         return err;
>
>  out_free_ff:
> +       if (security_ctxlen > 0)
> +               kfree(security_ctx);

Freeing NULL is okay, if that's guaranteed in case of security_ctxlen
== 0, then you need not check that condition.

>         fuse_file_free(ff);
>  out_put_forget_req:
>         kfree(forget);
> @@ -629,6 +651,9 @@ static int fuse_mknod(struct inode *dir, struct dentry *entry, umode_t mode,
>  {
>         struct fuse_mknod_in inarg;
>         struct fuse_conn *fc = get_fuse_conn(dir);
> +       void *security_ctx = NULL;
> +       u32 security_ctxlen = 0;
> +       int ret;
>         FUSE_ARGS(args);
>
>         if (!fc->dont_mask)
> @@ -644,7 +669,27 @@ static int fuse_mknod(struct inode *dir, struct dentry *entry, umode_t mode,
>         args.in_args[0].value = &inarg;
>         args.in_args[1].size = entry->d_name.len + 1;
>         args.in_args[1].value = entry->d_name.name;
> -       return create_new_entry(fc, &args, dir, entry, mode);
> +
> +       if (fc->init_security) {
> +               ret = security_dentry_init_security(entry, mode, &entry->d_name,
> +                                                   &security_ctx,
> +                                                   &security_ctxlen);
> +               if (ret)
> +                       goto out;
> +
> +               if (security_ctxlen > 0) {
> +                       args.in_numargs = 3;
> +                       args.in_args[2].size = security_ctxlen;
> +                       args.in_args[2].value = security_ctx;
> +               }
> +       }
> +
> +       ret = create_new_entry(fc, &args, dir, entry, mode);
> +
> +       if (security_ctxlen > 0)
> +               kfree(security_ctx);
> +out:
> +       return ret;
>  }
>
>  static int fuse_create(struct inode *dir, struct dentry *entry, umode_t mode,
> @@ -657,6 +702,9 @@ static int fuse_mkdir(struct inode *dir, struct dentry *entry, umode_t mode)
>  {
>         struct fuse_mkdir_in inarg;
>         struct fuse_conn *fc = get_fuse_conn(dir);
> +       void *security_ctx = NULL;
> +       u32 security_ctxlen = 0;
> +       int ret;
>         FUSE_ARGS(args);
>
>         if (!fc->dont_mask)
> @@ -671,7 +719,28 @@ static int fuse_mkdir(struct inode *dir, struct dentry *entry, umode_t mode)
>         args.in_args[0].value = &inarg;
>         args.in_args[1].size = entry->d_name.len + 1;
>         args.in_args[1].value = entry->d_name.name;
> -       return create_new_entry(fc, &args, dir, entry, S_IFDIR);
> +
> +       if (fc->init_security) {
> +               ret = security_dentry_init_security(entry, S_IFDIR,
> +                                                   &entry->d_name,
> +                                                   &security_ctx,
> +                                                   &security_ctxlen);
> +               if (ret)
> +                       goto out;
> +
> +               if (security_ctxlen > 0) {
> +                       args.in_numargs = 3;
> +                       args.in_args[2].size = security_ctxlen;
> +                       args.in_args[2].value = security_ctx;
> +               }
> +       }
> +
> +       ret = create_new_entry(fc, &args, dir, entry, S_IFDIR);
> +
> +       if (security_ctxlen > 0)
> +               kfree(security_ctx);
> +out:
> +       return ret;
>  }
>
>  static int fuse_symlink(struct inode *dir, struct dentry *entry,
> @@ -679,6 +748,9 @@ static int fuse_symlink(struct inode *dir, struct dentry *entry,
>  {
>         struct fuse_conn *fc = get_fuse_conn(dir);
>         unsigned len = strlen(link) + 1;
> +       void *security_ctx = NULL;
> +       u32 security_ctxlen = 0;
> +       int ret;
>         FUSE_ARGS(args);
>
>         args.opcode = FUSE_SYMLINK;
> @@ -687,7 +759,28 @@ static int fuse_symlink(struct inode *dir, struct dentry *entry,
>         args.in_args[0].value = entry->d_name.name;
>         args.in_args[1].size = len;
>         args.in_args[1].value = link;
> -       return create_new_entry(fc, &args, dir, entry, S_IFLNK);
> +
> +       if (fc->init_security) {
> +               ret = security_dentry_init_security(entry, S_IFLNK,
> +                                                   &entry->d_name,
> +                                                   &security_ctx,
> +                                                   &security_ctxlen);
> +               if (ret)
> +                       goto out;
> +
> +               if (security_ctxlen > 0) {
> +                       args.in_numargs = 3;
> +                       args.in_args[2].size = security_ctxlen;
> +                       args.in_args[2].value = security_ctx;
> +               }
> +       }
> +
> +       ret = create_new_entry(fc, &args, dir, entry, S_IFLNK);
> +
> +       if (security_ctxlen > 0)
> +               kfree(security_ctx);
> +out:
> +       return ret;
>  }
>
>  void fuse_update_ctime(struct inode *inode)
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index ca344bf714045..5ea9212b0a71c 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -719,6 +719,9 @@ struct fuse_conn {
>         /* Do not show mount options */
>         unsigned int no_mount_options:1;
>
> +       /* Initialize security xattrs when creating a new inode */
> +       unsigned int init_security : 1;
> +
>         /** The number of requests waiting for completion */
>         atomic_t num_waiting;
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 16aec32f7f3d7..1a311771c5555 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -951,6 +951,8 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_args *args,
>                                         min_t(unsigned int, FUSE_MAX_MAX_PAGES,
>                                         max_t(unsigned int, arg->max_pages, 1));
>                         }
> +                       if (arg->flags & FUSE_SECURITY_CTX)
> +                               fc->init_security = 1;
>                 } else {
>                         ra_pages = fc->max_read / PAGE_SIZE;
>                         fc->no_lock = 1;
> @@ -988,7 +990,8 @@ void fuse_send_init(struct fuse_conn *fc)
>                 FUSE_WRITEBACK_CACHE | FUSE_NO_OPEN_SUPPORT |
>                 FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
>                 FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
> -               FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA;
> +               FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
> +               FUSE_SECURITY_CTX;
>         ia->args.opcode = FUSE_INIT;
>         ia->args.in_numargs = 1;
>         ia->args.in_args[0].size = sizeof(ia->in);
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 373cada898159..00919c214149d 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -172,6 +172,10 @@
>   *  - add FUSE_WRITE_KILL_PRIV flag
>   *  - add FUSE_SETUPMAPPING and FUSE_REMOVEMAPPING
>   *  - add map_alignment to fuse_init_out, add FUSE_MAP_ALIGNMENT flag
> + *
> + *  7.32
> + *  - add FUSE_SECURITY_CTX flag for fuse_init_out
> + *  - add security context to create, mkdir, and mknod requests
>   */
>
>  #ifndef _LINUX_FUSE_H
> @@ -207,7 +211,7 @@
>  #define FUSE_KERNEL_VERSION 7
>
>  /** Minor version number of this interface */
> -#define FUSE_KERNEL_MINOR_VERSION 31
> +#define FUSE_KERNEL_MINOR_VERSION 32
>
>  /** The node ID of the root inode */
>  #define FUSE_ROOT_ID 1
> @@ -314,6 +318,7 @@ struct fuse_file_lock {
>   * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
>   * FUSE_EXPLICIT_INVAL_DATA: only invalidate cached pages on explicit request
>   * FUSE_MAP_ALIGNMENT: map_alignment field is valid
> + * FUSE_SECURITY_CTX: add security context to create, mkdir, symlink, and mknod
>   */
>  #define FUSE_ASYNC_READ                (1 << 0)
>  #define FUSE_POSIX_LOCKS       (1 << 1)
> @@ -342,6 +347,7 @@ struct fuse_file_lock {
>  #define FUSE_NO_OPENDIR_SUPPORT (1 << 24)
>  #define FUSE_EXPLICIT_INVAL_DATA (1 << 25)
>  #define FUSE_MAP_ALIGNMENT     (1 << 26)
> +#define FUSE_SECURITY_CTX      (1 << 27)
>
>  /**
>   * CUSE INIT request/reply flags
> --
> 2.27.0.278.ge193c7cf3a9-goog
>
