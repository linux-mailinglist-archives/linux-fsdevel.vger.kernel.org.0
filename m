Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7370572A9C1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jun 2023 09:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjFJHN3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jun 2023 03:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjFJHN2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jun 2023 03:13:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2203A9B;
        Sat, 10 Jun 2023 00:13:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BFB860F25;
        Sat, 10 Jun 2023 07:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45761C433EF;
        Sat, 10 Jun 2023 07:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686381200;
        bh=n0FY3OnHSLCH8nrpEBoar3YYMM4tX+csyO3/9N20UQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nIBHn7vdu3HHZ0/V/2HU3ZRz6/rojHeZ9pMVCaf2nfG7rqfkJkNF35GFlhSzueiht
         yExh8XYJRgkY/KO0d6uMr1W57OPp5zJb5Ha2Dv1vX0UUr3gWqS56Z90EZQ1K8OBpVL
         6BxKJCqgIN7CqzYqU4He6LDu65k9WFpBAjSIoIi/S+2PcHYvlfnNj0ZJvBcdmkK95i
         7O04NzThggmZENTPPvcxtMtuyqxDJQDEJ4qT/MAvjnIYMr9QpqhJVxR6nRtSQtfQY+
         sa6mRLh61/BN7MP9OOBecdZaaxVzTOLgdXb4KGY+ijLpJP+JYfZS7V2RB6RQfj636F
         JaFnaCr93qUxw==
Date:   Sat, 10 Jun 2023 09:13:16 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ovl: modify layer parameter parsing
Message-ID: <20230610-pedantisch-wirsing-33532c145ed1@brauner>
References: <20230605-fs-overlayfs-mount_api-v2-0-3da91c97e0c0@kernel.org>
 <20230605-fs-overlayfs-mount_api-v2-2-3da91c97e0c0@kernel.org>
 <CAOQ4uxhE18yduSTF1tvv_J_zCjVQgWd_6ySuX6RF_rU_qwb5Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhE18yduSTF1tvv_J_zCjVQgWd_6ySuX6RF_rU_qwb5Rg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 09, 2023 at 10:52:33PM +0300, Amir Goldstein wrote:
> On Fri, Jun 9, 2023 at 6:42 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > We ran into issues where mount(8) passed multiple lower layers as one
> > big string through fsconfig(). But the fsconfig() FSCONFIG_SET_STRING
> > option is limited to 256 bytes in strndup_user(). While this would be
> > fixable by extending the fsconfig() buffer I'd rather encourage users to
> > append layers via multiple fsconfig() calls as the interface allows
> > nicely for this. This has also been requested as a feature before.
> >
> > With this port to the new mount api the following will be possible:
> >
> >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", "/lower1", 0);
> >
> >         /* set upper layer */
> >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "upperdir", "/upper", 0);
> >
> >         /* append "/lower2", "/lower3", and "/lower4" */
> >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", ":/lower2:/lower3:/lower4", 0);
> >
> >         /* turn index feature on */
> >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "index", "on", 0);
> >
> >         /* append "/lower5" */
> >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", ":/lower5", 0);
> >
> > Specifying ':' would have been rejected so this isn't a regression. And
> > we can't simply use "lowerdir=/lower" to append on top of existing
> > layers as "lowerdir=/lower,lowerdir=/other-lower" would make
> > "/other-lower" the only lower layer so we'd break uapi if we changed
> > this. So the ':' prefix seems a good compromise.
> >
> > Users can choose to specify multiple layers at once or individual
> > layers. A layer is appended if it starts with ":". This requires that
> > the user has already added at least one layer before. If lowerdir is
> > specified again without a leading ":" then all previous layers are
> > dropped and replaced with the new layers. If lowerdir is specified and
> > empty than all layers are simply dropped.
> >
> > An additional change is that overlayfs will now parse and resolve layers
> > right when they are specified in fsconfig() instead of deferring until
> > super block creation. This allows users to receive early errors.
> >
> > It also allows users to actually use up to 500 layers something which
> > was theoretically possible but ended up not working due to the mount
> > option string passed via mount(2) being too large.
> >
> > This also allows a more privileged process to set config options for a
> > lesser privileged process as the creds for fsconfig() and the creds for
> > fsopen() can differ. We could restrict that they match by enforcing that
> > the creds of fsopen() and fsconfig() match but I don't see why that
> > needs to be the case and allows for a good delegation mechanism.
> >
> > Plus, in the future it means we're able to extend overlayfs mount
> > options and allow users to specify layers via file descriptors instead
> > of paths:
> >
> >         fsconfig(FSCONFIG_SET_PATH{_EMPTY}, "lowerdir", "lower1", dirfd);
> >
> >         /* append */
> >         fsconfig(FSCONFIG_SET_PATH{_EMPTY}, "lowerdir", "lower2", dirfd);
> >
> >         /* append */
> >         fsconfig(FSCONFIG_SET_PATH{_EMPTY}, "lowerdir", "lower3", dirfd);
> >
> >         /* clear all layers specified until now */
> >         fsconfig(FSCONFIG_SET_STRING, "lowerdir", NULL, 0);
> >
> > This would be especially nice if users create an overlayfs mount on top
> > of idmapped layers or just in general private mounts created via
> > open_tree(OPEN_TREE_CLONE). Those mounts would then never have to appear
> > anywhere in the filesystem. But for now just do the minimal thing.
> >
> > We should probably aim to move more validation into ovl_fs_parse_param()
> > so users get errors before fsconfig(FSCONFIG_CMD_CREATE). But that can
> > be done in additional patches later.
> >
> > Link: https://github.com/util-linux/util-linux/issues/2287
> > Link: https://github.com/util-linux/util-linux/issues/1992
> > Link: https://bugs.archlinux.org/task/78702
> > Link: https://lore.kernel.org/linux-unionfs/20230530-klagen-zudem-32c0908c2108@brauner
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/overlayfs/Makefile       |   2 +-
> >  fs/overlayfs/layer_params.c | 288 ++++++++++++++++++++++++++++++++++++++
> >  fs/overlayfs/ovl_entry.h    |  30 ++++
> >  fs/overlayfs/super.c        | 328 +++++++++++++++-----------------------------
> >  4 files changed, 431 insertions(+), 217 deletions(-)
> >
> > diff --git a/fs/overlayfs/Makefile b/fs/overlayfs/Makefile
> > index 9164c585eb2f..a3ad81c2e64e 100644
> > --- a/fs/overlayfs/Makefile
> > +++ b/fs/overlayfs/Makefile
> > @@ -6,4 +6,4 @@
> >  obj-$(CONFIG_OVERLAY_FS) += overlay.o
> >
> >  overlay-objs := super.o namei.o util.o inode.o file.o dir.o readdir.o \
> > -               copy_up.o export.o
> > +               copy_up.o export.o layer_params.o
> > diff --git a/fs/overlayfs/layer_params.c b/fs/overlayfs/layer_params.c
> > new file mode 100644
> > index 000000000000..29907afc9d0d
> > --- /dev/null
> > +++ b/fs/overlayfs/layer_params.c
> 
> params.c please
> and please move all the params parsing code here
> not only the layers parsing.
> 
> > @@ -0,0 +1,288 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <linux/fs.h>
> > +#include <linux/namei.h>
> > +#include <linux/fs_context.h>
> > +#include <linux/fs_parser.h>
> > +#include <linux/posix_acl_xattr.h>
> > +#include <linux/xattr.h>
> > +#include "overlayfs.h"
> > +
> > +static size_t ovl_parse_param_split_lowerdirs(char *str)
> > +{
> > +       size_t ctr = 1;
> > +       char *s, *d;
> > +
> > +       for (s = d = str;; s++, d++) {
> > +               if (*s == '\\') {
> > +                       s++;
> > +               } else if (*s == ':') {
> > +                       *d = '\0';
> > +                       ctr++;
> > +                       continue;
> > +               }
> > +               *d = *s;
> > +               if (!*s)
> > +                       break;
> > +       }
> > +       return ctr;
> > +}
> > +
> > +static int ovl_mount_dir_noesc(const char *name, struct path *path)
> > +{
> > +       int err = -EINVAL;
> > +
> > +       if (!*name) {
> > +               pr_err("empty lowerdir\n");
> > +               goto out;
> > +       }
> > +       err = kern_path(name, LOOKUP_FOLLOW, path);
> > +       if (err) {
> > +               pr_err("failed to resolve '%s': %i\n", name, err);
> > +               goto out;
> > +       }
> > +       err = -EINVAL;
> > +       if (ovl_dentry_weird(path->dentry)) {
> > +               pr_err("filesystem on '%s' not supported\n", name);
> > +               goto out_put;
> > +       }
> > +       if (!d_is_dir(path->dentry)) {
> > +               pr_err("'%s' not a directory\n", name);
> > +               goto out_put;
> > +       }
> > +       return 0;
> > +
> > +out_put:
> > +       path_put_init(path);
> > +out:
> > +       return err;
> > +}
> > +
> > +static void ovl_unescape(char *s)
> > +{
> > +       char *d = s;
> > +
> > +       for (;; s++, d++) {
> > +               if (*s == '\\')
> > +                       s++;
> > +               *d = *s;
> > +               if (!*s)
> > +                       break;
> > +       }
> > +}
> > +
> > +static int ovl_mount_dir(const char *name, struct path *path)
> > +{
> > +       int err = -ENOMEM;
> > +       char *tmp = kstrdup(name, GFP_KERNEL);
> > +
> > +       if (tmp) {
> > +               ovl_unescape(tmp);
> > +               err = ovl_mount_dir_noesc(tmp, path);
> > +
> > +               if (!err && path->dentry->d_flags & DCACHE_OP_REAL) {
> > +                       pr_err("filesystem on '%s' not supported as upperdir\n",
> > +                              tmp);
> > +                       path_put_init(path);
> > +                       err = -EINVAL;
> > +               }
> > +               kfree(tmp);
> > +       }
> > +       return err;
> > +}
> > +
> > +int ovl_parse_param_upperdir(const char *name, struct fs_context *fc,
> > +                            bool workdir)
> > +{
> > +       int err;
> > +       struct ovl_fs *ofs = fc->s_fs_info;
> > +       struct ovl_config *config = &ofs->config;
> > +       struct ovl_fs_context *ctx = fc->fs_private;
> > +       struct path path;
> > +       char *dup;
> > +
> > +       err = ovl_mount_dir(name, &path);
> > +       if (err)
> > +               return err;
> > +
> > +       /*
> > +        * Check whether upper path is read-only here to report failures
> > +        * early. Don't forget to recheck when the superblock is created
> > +        * as the mount attributes could change.
> > +        */
> > +       if (__mnt_is_readonly(path.mnt)) {
> > +               path_put(&path);
> > +               return -EINVAL;
> > +       }
> > +
> > +       dup = kstrdup(name, GFP_KERNEL);
> > +       if (!dup) {
> > +               path_put(&path);
> > +               return -ENOMEM;
> > +       }
> > +
> > +       if (workdir) {
> > +               kfree(config->workdir);
> > +               config->workdir = dup;
> > +               path_put(&ctx->work);
> > +               ctx->work = path;
> > +       } else {
> > +               kfree(config->upperdir);
> > +               config->upperdir = dup;
> > +               path_put(&ctx->upper);
> > +               ctx->upper = path;
> > +       }
> > +       return 0;
> > +}
> > +
> > +void ovl_parse_param_drop_lowerdir(struct ovl_fs_context *ctx)
> > +{
> > +       for (size_t nr = 0; nr < ctx->nr; nr++) {
> > +               path_put(&ctx->lower[nr].path);
> > +               kfree(ctx->lower[nr].name);
> > +               ctx->lower[nr].name = NULL;
> > +       }
> > +       ctx->nr = 0;
> > +}
> > +
> > +/*
> > + * Parse lowerdir= mount option:
> > + *
> > + * (1) lowerdir=/lower1:/lower2:/lower3
> > + *     Set "/lower1", "/lower2", and "/lower3" as lower layers. Any
> > + *     existing lower layers are replaced.
> > + * (2) lowerdir=:/lower4
> > + *     Append "/lower4" to current stack of lower layers. This requires
> > + *     that there already is at least one lower layer configured.
> > + */
> > +int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
> > +{
> > +       int err;
> > +       struct ovl_fs_context *ctx = fc->fs_private;
> > +       struct ovl_fs_context_layer *l;
> > +       char *dup = NULL, *dup_iter;
> > +       size_t nr_lower = 0, nr = 0;
> > +       bool append = false;
> > +
> > +       /* Enforce that users are forced to specify a single ':'. */
> > +       if (strncmp(name, "::", 2) == 0)
> > +               return -EINVAL;
> > +
> > +       /*
> > +        * Ensure we're backwards compatible with mount(2)
> > +        * by allowing relative paths.
> > +        */
> > +
> > +       /* drop all existing lower layers */
> > +       if (!*name) {
> > +               ovl_parse_param_drop_lowerdir(ctx);
> > +               return 0;
> > +       }
> > +
> > +       if (*name == ':') {
> > +               /*
> > +                * If users want to append a layer enforce that they
> > +                * have already specified a first layer before. It's
> > +                * better to be strict.
> > +                */
> > +               if (ctx->nr == 0)
> > +                       return -EINVAL;
> > +
> > +               /*
> > +                * Drop the leading. We'll create the final mount option
> > +                * string for the lower layers when we create the superblock.
> > +                */
> > +               name++;
> > +               append = true;
> > +       }
> > +
> > +       dup = kstrdup(name, GFP_KERNEL);
> > +       if (!dup)
> > +               return -ENOMEM;
> > +
> > +       err = -EINVAL;
> > +       nr_lower = ovl_parse_param_split_lowerdirs(dup);
> > +       if ((nr_lower > OVL_MAX_STACK) ||
> > +           (append && (size_add(ctx->nr, nr_lower) > OVL_MAX_STACK))) {
> > +               pr_err("too many lower directories, limit is %d\n", OVL_MAX_STACK);
> > +               goto out_err;
> > +       }
> > +
> > +       if (!append)
> > +               ovl_parse_param_drop_lowerdir(ctx);
> > +
> > +       /*
> > +        * (1) append
> > +        *
> > +        * We want nr <= nr_lower <= capacity We know nr > 0 and nr <=
> > +        * capacity. If nr == 0 this wouldn't be append. If nr +
> > +        * nr_lower is <= capacity then nr <= nr_lower <= capacity
> > +        * already holds. If nr + nr_lower exceeds capacity, we realloc.
> > +        *
> > +        * (2) replace
> > +        *
> > +        * Ensure we're backwards compatible with mount(2) which allows
> > +        * "lowerdir=/a:/b:/c,lowerdir=/d:/e:/f" causing the last
> > +        * specified lowerdir mount option to win.
> > +        *
> > +        * We want nr <= nr_lower <= capacity We know either (i) nr == 0
> > +        * or (ii) nr > 0. We also know nr_lower > 0. The capacity
> > +        * could've been changed multiple times already so we only know
> > +        * nr <= capacity. If nr + nr_lower > capacity we realloc,
> > +        * otherwise nr <= nr_lower <= capacity holds already.
> > +        */
> > +       nr_lower += ctx->nr;
> > +       if (nr_lower > ctx->capacity) {
> > +               err = -ENOMEM;
> > +               l = krealloc_array(ctx->lower, nr_lower, sizeof(*ctx->lower),
> > +                                  GFP_KERNEL_ACCOUNT);
> > +               if (!l)
> > +                       goto out_err;
> > +
> > +               ctx->lower = l;
> > +               ctx->capacity = nr_lower;
> > +       }
> > +
> > +       /* By (1) and (2) we know nr <= nr_lower <= capacity. */
> > +       dup_iter = dup;
> > +       for (nr = ctx->nr; nr < nr_lower; nr++) {
> > +               l = &ctx->lower[nr];
> > +
> > +               err = ovl_mount_dir_noesc(dup_iter, &l->path);
> > +               if (err)
> > +                       goto out_put;
> > +
> > +               err = -ENOMEM;
> > +               l->name = kstrdup(dup_iter, GFP_KERNEL_ACCOUNT);
> > +               if (!l->name)
> > +                       goto out_put;
> > +
> > +               dup_iter = strchr(dup_iter, '\0') + 1;
> > +       }
> > +       ctx->nr = nr_lower;
> > +       kfree(dup);
> > +       return 0;
> > +
> > +out_put:
> > +       /*
> > +        * We know nr >= ctx->nr < nr_lower. If we failed somewhere
> > +        * we want to undo until nr == ctx->nr. This is correct for
> > +        * both ctx->nr == 0 and ctx->nr > 0.
> > +        */
> > +       for (; nr >= ctx->nr; nr--) {
> > +               l = &ctx->lower[nr];
> > +               kfree(l->name);
> > +               l->name = NULL;
> > +               path_put(&l->path);
> > +
> > +               /* don't overflow */
> > +               if (nr == 0)
> > +                       break;
> > +       }
> > +
> > +out_err:
> > +       kfree(dup);
> > +
> > +       /* Intentionally don't realloc to a smaller size. */
> > +       return err;
> > +}
> > diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> > index fd11fe6d6d45..269a9a6f177b 100644
> > --- a/fs/overlayfs/ovl_entry.h
> > +++ b/fs/overlayfs/ovl_entry.h
> > @@ -85,6 +85,36 @@ struct ovl_fs {
> >         errseq_t errseq;
> >  };
> >
> > +#define OVL_MAX_STACK 500
> > +
> > +struct ovl_fs_context_layer {
> > +       char *name;
> > +       struct path path;
> > +};
> > +
> > +/*
> > + * These options imply different behavior when they are explicitly
> > + * specified than when they are left in their default state.
> > + */
> > +#define OVL_METACOPY_SET       BIT(0)
> > +#define OVL_REDIRECT_SET       BIT(1)
> > +#define OVL_NFS_EXPORT_SET     BIT(2)
> > +#define OVL_INDEX_SET          BIT(3)
> > +
> > +struct ovl_fs_context {
> > +       struct path upper;
> > +       struct path work;
> > +       size_t capacity;
> > +       size_t nr;
> > +       u8 set;
> > +       struct ovl_fs_context_layer *lower;
> > +};
> > +
> > +int ovl_parse_param_upperdir(const char *name, struct fs_context *fc,
> > +                            bool workdir);
> > +int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc);
> > +void ovl_parse_param_drop_lowerdir(struct ovl_fs_context *ctx);
> > +
> 
> Please move all this to overlayfs.h.
> I don't think there is a good reason for it to be in this file.
> 
> 
> >  static inline struct vfsmount *ovl_upper_mnt(struct ovl_fs *ofs)
> >  {
> >         return ofs->layers[0].mnt;
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index ceaf05743f45..35c61a1d0886 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -27,8 +27,6 @@ MODULE_LICENSE("GPL");
> >
> >  struct ovl_dir_cache;
> >
> > -#define OVL_MAX_STACK 500
> > -
> >  static bool ovl_redirect_dir_def = IS_ENABLED(CONFIG_OVERLAY_FS_REDIRECT_DIR);
> >  module_param_named(redirect_dir, ovl_redirect_dir_def, bool, 0644);
> >  MODULE_PARM_DESC(redirect_dir,
> > @@ -97,8 +95,11 @@ static const struct constant_table ovl_parameter_xino[] = {
> >         {}
> >  };
> >
> > +#define fsparam_string_empty(NAME, OPT) \
> > +       __fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, NULL)
> > +
> >  static const struct fs_parameter_spec ovl_parameter_spec[] = {
> > -       fsparam_string("lowerdir",          Opt_lowerdir),
> > +       fsparam_string_empty("lowerdir",    Opt_lowerdir),
> >         fsparam_string("upperdir",          Opt_upperdir),
> >         fsparam_string("workdir",           Opt_workdir),
> >         fsparam_flag("default_permissions", Opt_default_permissions),
> > @@ -113,15 +114,6 @@ static const struct fs_parameter_spec ovl_parameter_spec[] = {
> >         {}
> >  };
> >
> > -#define OVL_METACOPY_SET       BIT(0)
> > -#define OVL_REDIRECT_SET       BIT(1)
> > -#define OVL_NFS_EXPORT_SET     BIT(2)
> > -#define OVL_INDEX_SET          BIT(3)
> > -
> > -struct ovl_fs_context {
> > -       u8 set;
> > -};
> > -
> >  static void ovl_dentry_release(struct dentry *dentry)
> >  {
> >         struct ovl_entry *oe = dentry->d_fsdata;
> > @@ -706,69 +698,6 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
> >         goto out_unlock;
> >  }
> >
> > -static void ovl_unescape(char *s)
> > -{
> > -       char *d = s;
> > -
> > -       for (;; s++, d++) {
> > -               if (*s == '\\')
> > -                       s++;
> > -               *d = *s;
> > -               if (!*s)
> > -                       break;
> > -       }
> > -}
> > -
> > -static int ovl_mount_dir_noesc(const char *name, struct path *path)
> > -{
> > -       int err = -EINVAL;
> > -
> > -       if (!*name) {
> > -               pr_err("empty lowerdir\n");
> > -               goto out;
> > -       }
> > -       err = kern_path(name, LOOKUP_FOLLOW, path);
> > -       if (err) {
> > -               pr_err("failed to resolve '%s': %i\n", name, err);
> > -               goto out;
> > -       }
> > -       err = -EINVAL;
> > -       if (ovl_dentry_weird(path->dentry)) {
> > -               pr_err("filesystem on '%s' not supported\n", name);
> > -               goto out_put;
> > -       }
> > -       if (!d_is_dir(path->dentry)) {
> > -               pr_err("'%s' not a directory\n", name);
> > -               goto out_put;
> > -       }
> > -       return 0;
> > -
> > -out_put:
> > -       path_put_init(path);
> > -out:
> > -       return err;
> > -}
> > -
> > -static int ovl_mount_dir(const char *name, struct path *path)
> > -{
> > -       int err = -ENOMEM;
> > -       char *tmp = kstrdup(name, GFP_KERNEL);
> > -
> > -       if (tmp) {
> > -               ovl_unescape(tmp);
> > -               err = ovl_mount_dir_noesc(tmp, path);
> > -
> > -               if (!err && path->dentry->d_flags & DCACHE_OP_REAL) {
> > -                       pr_err("filesystem on '%s' not supported as upperdir\n",
> > -                              tmp);
> > -                       path_put_init(path);
> > -                       err = -EINVAL;
> > -               }
> > -               kfree(tmp);
> > -       }
> > -       return err;
> > -}
> > -
> >  static int ovl_check_namelen(const struct path *path, struct ovl_fs *ofs,
> >                              const char *name)
> >  {
> > @@ -789,10 +718,6 @@ static int ovl_lower_dir(const char *name, struct path *path,
> >         int fh_type;
> >         int err;
> >
> > -       err = ovl_mount_dir_noesc(name, path);
> > -       if (err)
> > -               return err;
> > -
> >         err = ovl_check_namelen(path, ofs, name);
> >         if (err)
> >                 return err;
> > @@ -841,26 +766,6 @@ static bool ovl_workdir_ok(struct dentry *workdir, struct dentry *upperdir)
> >         return ok;
> >  }
> >
> > -static unsigned int ovl_split_lowerdirs(char *str)
> > -{
> > -       unsigned int ctr = 1;
> > -       char *s, *d;
> > -
> > -       for (s = d = str;; s++, d++) {
> > -               if (*s == '\\') {
> > -                       s++;
> > -               } else if (*s == ':') {
> > -                       *d = '\0';
> > -                       ctr++;
> > -                       continue;
> > -               }
> > -               *d = *s;
> > -               if (!*s)
> > -                       break;
> > -       }
> > -       return ctr;
> > -}
> > -
> >  static int ovl_own_xattr_get(const struct xattr_handler *handler,
> >                              struct dentry *dentry, struct inode *inode,
> >                              const char *name, void *buffer, size_t size)
> > @@ -961,15 +866,12 @@ static int ovl_report_in_use(struct ovl_fs *ofs, const char *name)
> >  }
> >
> >  static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
> > -                        struct ovl_layer *upper_layer, struct path *upperpath)
> > +                        struct ovl_layer *upper_layer,
> > +                        const struct path *upperpath)
> >  {
> >         struct vfsmount *upper_mnt;
> >         int err;
> >
> > -       err = ovl_mount_dir(ofs->config.upperdir, upperpath);
> > -       if (err)
> > -               goto out;
> > -
> >         /* Upperdir path should not be r/o */
> >         if (__mnt_is_readonly(upperpath->mnt)) {
> >                 pr_err("upper fs is r/o, try multi-lower layers mount\n");
> > @@ -1256,46 +1158,37 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
> >  }
> >
> >  static int ovl_get_workdir(struct super_block *sb, struct ovl_fs *ofs,
> > -                          const struct path *upperpath)
> > +                          const struct path *upperpath,
> > +                          const struct path *workpath)
> >  {
> >         int err;
> > -       struct path workpath = { };
> > -
> > -       err = ovl_mount_dir(ofs->config.workdir, &workpath);
> > -       if (err)
> > -               goto out;
> >
> >         err = -EINVAL;
> > -       if (upperpath->mnt != workpath.mnt) {
> > +       if (upperpath->mnt != workpath->mnt) {
> >                 pr_err("workdir and upperdir must reside under the same mount\n");
> > -               goto out;
> > +               return err;
> >         }
> > -       if (!ovl_workdir_ok(workpath.dentry, upperpath->dentry)) {
> > +       if (!ovl_workdir_ok(workpath->dentry, upperpath->dentry)) {
> >                 pr_err("workdir and upperdir must be separate subtrees\n");
> > -               goto out;
> > +               return err;
> >         }
> >
> > -       ofs->workbasedir = dget(workpath.dentry);
> > +       ofs->workbasedir = dget(workpath->dentry);
> >
> >         if (ovl_inuse_trylock(ofs->workbasedir)) {
> >                 ofs->workdir_locked = true;
> >         } else {
> >                 err = ovl_report_in_use(ofs, "workdir");
> >                 if (err)
> > -                       goto out;
> > +                       return err;
> >         }
> >
> >         err = ovl_setup_trap(sb, ofs->workbasedir, &ofs->workbasedir_trap,
> >                              "workdir");
> >         if (err)
> > -               goto out;
> > -
> > -       err = ovl_make_workdir(sb, ofs, &workpath);
> > -
> > -out:
> > -       path_put(&workpath);
> > +               return err;
> >
> > -       return err;
> > +       return ovl_make_workdir(sb, ofs, workpath);
> >  }
> >
> >  static int ovl_get_indexdir(struct super_block *sb, struct ovl_fs *ofs,
> > @@ -1449,14 +1342,13 @@ static int ovl_get_fsid(struct ovl_fs *ofs, const struct path *path)
> >  }
> >
> >  static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
> > -                         struct path *stack, unsigned int numlower,
> > -                         struct ovl_layer *layers)
> > +                         struct ovl_fs_context *ctx, struct ovl_layer *layers)
> >  {
> >         int err;
> >         unsigned int i;
> >
> >         err = -ENOMEM;
> > -       ofs->fs = kcalloc(numlower + 1, sizeof(struct ovl_sb), GFP_KERNEL);
> > +       ofs->fs = kcalloc(ctx->nr + 1, sizeof(struct ovl_sb), GFP_KERNEL);
> >         if (ofs->fs == NULL)
> >                 goto out;
> >
> > @@ -1480,12 +1372,13 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
> >                 ofs->fs[0].is_lower = false;
> >         }
> >
> > -       for (i = 0; i < numlower; i++) {
> > +       for (i = 0; i < ctx->nr; i++) {
> > +               struct ovl_fs_context_layer *l = &ctx->lower[i];
> >                 struct vfsmount *mnt;
> >                 struct inode *trap;
> >                 int fsid;
> >
> > -               err = fsid = ovl_get_fsid(ofs, &stack[i]);
> > +               err = fsid = ovl_get_fsid(ofs, &l->path);
> >                 if (err < 0)
> >                         goto out;
> >
> > @@ -1496,11 +1389,11 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
> >                  * the upperdir/workdir is in fact in-use by our
> >                  * upperdir/workdir.
> >                  */
> > -               err = ovl_setup_trap(sb, stack[i].dentry, &trap, "lowerdir");
> > +               err = ovl_setup_trap(sb, l->path.dentry, &trap, "lowerdir");
> >                 if (err)
> >                         goto out;
> >
> > -               if (ovl_is_inuse(stack[i].dentry)) {
> > +               if (ovl_is_inuse(l->path.dentry)) {
> >                         err = ovl_report_in_use(ofs, "lowerdir");
> >                         if (err) {
> >                                 iput(trap);
> > @@ -1508,7 +1401,7 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
> >                         }
> >                 }
> >
> > -               mnt = clone_private_mount(&stack[i]);
> > +               mnt = clone_private_mount(&l->path);
> >                 err = PTR_ERR(mnt);
> >                 if (IS_ERR(mnt)) {
> >                         pr_err("failed to clone lowerpath\n");
> > @@ -1569,63 +1462,86 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
> >  }
> >
> >  static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
> > -                               const char *lower, unsigned int numlower,
> > -                               struct ovl_fs *ofs, struct ovl_layer *layers)
> > +                                           struct ovl_fs_context *ctx,
> > +                                           struct ovl_fs *ofs,
> > +                                           struct ovl_layer *layers)
> >  {
> >         int err;
> > -       struct path *stack = NULL;
> >         unsigned int i;
> >         struct ovl_entry *oe;
> > +       size_t len;
> > +       char *lowerdir;
> > +       struct ovl_fs_context_layer *l;
> >
> > -       if (!ofs->config.upperdir && numlower == 1) {
> > +       if (!ofs->config.upperdir && ctx->nr == 1) {
> >                 pr_err("at least 2 lowerdir are needed while upperdir nonexistent\n");
> >                 return ERR_PTR(-EINVAL);
> >         }
> >
> > -       stack = kcalloc(numlower, sizeof(struct path), GFP_KERNEL);
> > -       if (!stack)
> > -               return ERR_PTR(-ENOMEM);
> > -
> >         err = -EINVAL;
> > -       for (i = 0; i < numlower; i++) {
> > -               err = ovl_lower_dir(lower, &stack[i], ofs, &sb->s_stack_depth);
> > +       len = 0;
> > +       for (i = 0; i < ctx->nr; i++) {
> > +               l = &ctx->lower[i];
> > +
> > +               err = ovl_lower_dir(l->name, &l->path, ofs, &sb->s_stack_depth);
> >                 if (err)
> > -                       goto out_err;
> > +                       return ERR_PTR(err);
> >
> > -               lower = strchr(lower, '\0') + 1;
> > +               len += strlen(l->name);
> >         }
> >
> >         err = -EINVAL;
> >         sb->s_stack_depth++;
> >         if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
> >                 pr_err("maximum fs stacking depth exceeded\n");
> > -               goto out_err;
> > +               return ERR_PTR(err);
> > +       }
> .> +
> > +       /*
> > +        * Create a string of all lower layers that we store in
> > +        * ofs->config.lowerdir which we can display to userspace in
> > +        * mount options. For example, this assembles "/lower1",
> > +        * "/lower2" into "/lower1:/lower2".
> > +        *
> > +        * We need to make sure we add a ':'. Thus, we need to account
> > +        * for the separators when allocating space when multiple layers
> > +        * are specified. That should be easy since we know that ctx->nr
> > +        * >= 1. So we know that ctx->nr - 1 will be correct for the
> > +        * base case ctx->nr == 1 and all other cases.
> > +        */
> > +       len += ctx->nr - 1;
> > +       len++; /* and leave room for \0 */
> > +       lowerdir = kzalloc(len, GFP_KERNEL_ACCOUNT);
> > +       if (!lowerdir)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       ofs->config.lowerdir = lowerdir;
> > +       for (i = 0; i < ctx->nr; i++) {
> > +               l = &ctx->lower[i];
> > +
> > +               len = strlen(l->name);
> > +               memcpy(lowerdir, l->name, len);
> > +               if ((ctx->nr > 1) && ((i + 1) != ctx->nr))
> > +                       lowerdir[len++] = ':';
> > +               lowerdir += len;
> >         }
> >
> 
> 
> I think it might be simpler and cleaner to move the
> ctx->lower[i]->name strings as is to layers[i].name after
> layers is allocated in ovl_get_layers() below and use a
> loop of seq_printf() in ovl_show_options() instead of preparing
> the big ofs->config.lowerdir string.
> 
> Something to consider.

Works for me. I'll try that out.
