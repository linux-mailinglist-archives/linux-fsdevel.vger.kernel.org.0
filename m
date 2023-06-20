Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7193736A66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 13:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjFTLKD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 07:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjFTLJy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:09:54 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A9AB2;
        Tue, 20 Jun 2023 04:09:51 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-43f55b63ebfso1037404137.2;
        Tue, 20 Jun 2023 04:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687259390; x=1689851390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMNQr3NT2UCaIscdx7V4xVsy5fZjFp54MPcRBMbcwAY=;
        b=Mwh2vMLK1nurquGj2oR+qHrRauLOr/x3BNKqxqKmisi+pk9DtF7q5HOGTOoSmUdWqb
         3hS/8WH7yWjbY6LByi7ZxxMDb3cG8NbL34mrqeE1TjWoxndbKypVEGI43ixkwzcXRWCm
         mW8Od5GK0DQBd5tWYwqqM+woZbSd//uKh00FHg1wDrgK7HjU+LaYzlK+P6DGTyTYMJU6
         eNZA7JWhG4RJXLxctNyKw0jrCrA8juvSNIQY1TW7xduJ8L0HwDeBAwqjnkSN3l2Pn4PJ
         Coq8J3l559JGeRKDKcl7hRRgWmuaYemYGjSSc7AyF1lE7KVZB6kxIzanML9bGX4mX2iV
         BK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687259390; x=1689851390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMNQr3NT2UCaIscdx7V4xVsy5fZjFp54MPcRBMbcwAY=;
        b=CLXurl/3o4sGihO8ADtfoWSWaelckdY3sEhB1vx9aBHOR6/n6FMB19jh+lhOzqN7oz
         NsLyDoPLoIykDajVIBlXgHLqAetyo3UmUWG4KtbkaJovf4D88IRDiTbYkRyLaiXFs6G6
         TXKRjNNKk3u1JVVggKf/SeKrxvQVOOLPVg72hdIrb4nnRjOsPyMcuiS1zv635OWGz9Tl
         Ia0dTz3V8DK43fyPh8o99+CQg8f8yxjk/Ka3IhvMp04QPVCpwBZ4dDiY3XDFBTqcHAvQ
         RcbARYKzfS372GW37+NV3mtPZGT0J+xScY7nASzF7U6mQ+13Y5eW4z1WP5xNwwti0PwA
         AnFA==
X-Gm-Message-State: AC+VfDxwBfXW8C7K9Gi7wDO9P6SkagviiqNtcLZ8wEShju+VtqMqcgLJ
        ADSNxWmYJxG26s6ZkA+MB689ageAvfaErSWrqPw=
X-Google-Smtp-Source: ACHHUZ4xiPUqvWN1ilTbxdLjulYg5pNv3b5udEK0p3O1iK5QKvpOHNzf/fMhKqRz7WAZxvV/pEs7tU4J49DAc75T6Js=
X-Received: by 2002:a67:ec4c:0:b0:43c:89d6:ef6 with SMTP id
 z12-20020a67ec4c000000b0043c89d60ef6mr3065019vso.8.1687259389810; Tue, 20 Jun
 2023 04:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230605-fs-overlayfs-mount_api-v3-0-730d9646b27d@kernel.org> <20230605-fs-overlayfs-mount_api-v3-3-730d9646b27d@kernel.org>
In-Reply-To: <20230605-fs-overlayfs-mount_api-v3-3-730d9646b27d@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 20 Jun 2023 14:09:38 +0300
Message-ID: <CAOQ4uxg-hASCxD4iFSnWFyVXSJQUCNgUZ7ouAHbh3+wWPY2dTQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ovl: change layer mount option handling
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 5:49=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> We ran into issues where mount(8) passed multiple lower layers as one
> big string through fsconfig(). But the fsconfig() FSCONFIG_SET_STRING
> option is limited to 256 bytes in strndup_user(). While this would be
> fixable by extending the fsconfig() buffer I'd rather encourage users to
> append layers via multiple fsconfig() calls as the interface allows
> nicely for this. This has also been requested as a feature before.
>
> With this port to the new mount api the following will be possible:
>
>         fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", "/lower1", 0);
>
>         /* set upper layer */
>         fsconfig(fs_fd, FSCONFIG_SET_STRING, "upperdir", "/upper", 0);
>
>         /* append "/lower2", "/lower3", and "/lower4" */
>         fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", ":/lower2:/lower=
3:/lower4", 0);
>
>         /* turn index feature on */
>         fsconfig(fs_fd, FSCONFIG_SET_STRING, "index", "on", 0);
>
>         /* append "/lower5" */
>         fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", ":/lower5", 0);
>
> Specifying ':' would have been rejected so this isn't a regression. And
> we can't simply use "lowerdir=3D/lower" to append on top of existing
> layers as "lowerdir=3D/lower,lowerdir=3D/other-lower" would make
> "/other-lower" the only lower layer so we'd break uapi if we changed
> this. So the ':' prefix seems a good compromise.
>
> Users can choose to specify multiple layers at once or individual
> layers. A layer is appended if it starts with ":". This requires that
> the user has already added at least one layer before. If lowerdir is
> specified again without a leading ":" then all previous layers are
> dropped and replaced with the new layers. If lowerdir is specified and
> empty than all layers are simply dropped.
>
> An additional change is that overlayfs will now parse and resolve layers
> right when they are specified in fsconfig() instead of deferring until
> super block creation. This allows users to receive early errors.
>
> It also allows users to actually use up to 500 layers something which
> was theoretically possible but ended up not working due to the mount
> option string passed via mount(2) being too large.
>
> This also allows a more privileged process to set config options for a
> lesser privileged process as the creds for fsconfig() and the creds for
> fsopen() can differ. We could restrict that they match by enforcing that
> the creds of fsopen() and fsconfig() match but I don't see why that
> needs to be the case and allows for a good delegation mechanism.
>
> Plus, in the future it means we're able to extend overlayfs mount
> options and allow users to specify layers via file descriptors instead
> of paths:
>
>         fsconfig(FSCONFIG_SET_PATH{_EMPTY}, "lowerdir", "lower1", dirfd);
>
>         /* append */
>         fsconfig(FSCONFIG_SET_PATH{_EMPTY}, "lowerdir", "lower2", dirfd);
>
>         /* append */
>         fsconfig(FSCONFIG_SET_PATH{_EMPTY}, "lowerdir", "lower3", dirfd);
>
>         /* clear all layers specified until now */
>         fsconfig(FSCONFIG_SET_STRING, "lowerdir", NULL, 0);
>
> This would be especially nice if users create an overlayfs mount on top
> of idmapped layers or just in general private mounts created via
> open_tree(OPEN_TREE_CLONE). Those mounts would then never have to appear
> anywhere in the filesystem. But for now just do the minimal thing.
>
> We should probably aim to move more validation into ovl_fs_parse_param()
> so users get errors before fsconfig(FSCONFIG_CMD_CREATE). But that can
> be done in additional patches later.
>
> This is now also rebased on top of the lazy lowerdata lookup which
> allows the specificatin of data only layers using the new "::" syntax.
>
> The rules are simple. A data only layers cannot be followed by any
> regular layers and data layers must be preceeded by at least one regular
> layer.
>
> Parsing the lowerdir mount option must change because of this. The
> original patchset used the old lowerdir parsing function to split a
> lowerdir mount option string such as:
>
>         lowerdir=3D/lower1:/lower2::/lower3::/lower4
>
> simply replacing each non-escaped ":" by "\0". So sequences of
> non-escaped ":" were counted as layers. For example, the previous
> lowerdir mount option above would've counted 6 layers instead of 4 and a
> lowerdir mount option such as:
>
>         lowerdir=3D"/lower1:/lower2::/lower3::/lower4::::::::::::::::::::=
:::::::"
>
> would be counted as 33 layers. Other than being ugly this didn't matter
> much because kern_path() would reject the first "\0" layer. However,
> this overcounting of layers becomes problematic when we base allocations
> on it where we very much only want to allocate space for 4 layers
> instead of 33.
>
> So the new parsing function rejects non-escaped sequences of colons
> other than ":" and "::" immediately instead of relying on kern_path().
>
> Link: https://github.com/util-linux/util-linux/issues/2287
> Link: https://github.com/util-linux/util-linux/issues/1992
> Link: https://bugs.archlinux.org/task/78702
> Link: https://lore.kernel.org/linux-unionfs/20230530-klagen-zudem-32c0908=
c2108@brauner
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/overlayfs/Makefile    |   2 +-
>  fs/overlayfs/overlayfs.h |  23 +++
>  fs/overlayfs/ovl_entry.h |   3 +-
>  fs/overlayfs/params.c    | 388 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/overlayfs/super.c     | 376 +++++++++++++++--------------------------=
----
>  5 files changed, 534 insertions(+), 258 deletions(-)
>
> diff --git a/fs/overlayfs/Makefile b/fs/overlayfs/Makefile
> index 9164c585eb2f..4e173d56b11f 100644
> --- a/fs/overlayfs/Makefile
> +++ b/fs/overlayfs/Makefile
> @@ -6,4 +6,4 @@
>  obj-$(CONFIG_OVERLAY_FS) +=3D overlay.o
>
>  overlay-objs :=3D super.o namei.o util.o inode.o file.o dir.o readdir.o =
\
> -               copy_up.o export.o
> +               copy_up.o export.o params.o
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index fcac4e2c56ab..7659ea6e02cb 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -119,6 +119,29 @@ struct ovl_fh {
>  #define OVL_FH_FID_OFFSET      (OVL_FH_WIRE_OFFSET + \
>                                  offsetof(struct ovl_fb, fid))
>
> +/* params.c */
> +#define OVL_MAX_STACK 500
> +
> +struct ovl_fs_context_layer {
> +       char *name;
> +       struct path path;
> +};
> +
> +struct ovl_fs_context {
> +       struct path upper;
> +       struct path work;
> +       size_t capacity;
> +       size_t nr; /* includes nr_data */
> +       size_t nr_data;
> +       u8 set;
> +       struct ovl_fs_context_layer *lower;
> +};
> +
> +int ovl_parse_param_upperdir(const char *name, struct fs_context *fc,
> +                            bool workdir);
> +int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc);
> +void ovl_parse_param_drop_lowerdir(struct ovl_fs_context *ctx);
> +
>  extern const char *const ovl_xattr_table[][2];
>  static inline const char *ovl_xattr(struct ovl_fs *ofs, enum ovl_xattr o=
x)
>  {
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index c72433c06006..7888ab33730b 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -6,7 +6,6 @@
>   */
>
>  struct ovl_config {
> -       char *lowerdir;
>         char *upperdir;
>         char *workdir;
>         bool default_permissions;
> @@ -41,6 +40,7 @@ struct ovl_layer {
>         int idx;
>         /* One fsid per unique underlying sb (upper fsid =3D=3D 0) */
>         int fsid;
> +       char *name;
>  };
>
>  /*
> @@ -101,7 +101,6 @@ struct ovl_fs {
>         errseq_t errseq;
>  };
>
> -
>  /* Number of lower layers, not including data-only layers */
>  static inline unsigned int ovl_numlowerlayer(struct ovl_fs *ofs)
>  {
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> new file mode 100644
> index 000000000000..a1606af1613f
> --- /dev/null
> +++ b/fs/overlayfs/params.c
> @@ -0,0 +1,388 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/fs.h>
> +#include <linux/namei.h>
> +#include <linux/fs_context.h>
> +#include <linux/fs_parser.h>
> +#include <linux/posix_acl_xattr.h>
> +#include <linux/xattr.h>
> +#include "overlayfs.h"
> +
> +static ssize_t ovl_parse_param_split_lowerdirs(char *str)
> +{
> +       ssize_t nr_layers =3D 1, nr_colons =3D 0;
> +       char *s, *d;
> +
> +       for (s =3D d =3D str;; s++, d++) {
> +               if (*s =3D=3D '\\') {
> +                       s++;
> +               } else if (*s =3D=3D ':') {
> +                       bool next_colon =3D (*(s + 1) =3D=3D ':');
> +
> +                       nr_colons++;
> +                       if (nr_colons =3D=3D 2 && next_colon) {
> +                               pr_err("only single ':' or double '::' se=
quences of unescaped colons in lowerdir mount option allowed.\n");
> +                               return -EINVAL;
> +                       }
> +                       /* count layers, not colons */
> +                       if (!next_colon)
> +                               nr_layers++;
> +
> +                       *d =3D '\0';
> +                       continue;
> +               }
> +
> +               *d =3D *s;
> +               if (!*s) {
> +                       /* trailing colons */
> +                       if (nr_colons) {
> +                               pr_err("unescaped trailing colons in lowe=
rdir mount option.\n");
> +                               return -EINVAL;
> +                       }
> +                       break;
> +               }
> +               nr_colons =3D 0;
> +       }
> +
> +       return nr_layers;
> +}
> +
> +static int ovl_mount_dir_noesc(const char *name, struct path *path)
> +{
> +       int err =3D -EINVAL;
> +
> +       if (!*name) {
> +               pr_err("empty lowerdir\n");
> +               goto out;
> +       }
> +       err =3D kern_path(name, LOOKUP_FOLLOW, path);
> +       if (err) {
> +               pr_err("failed to resolve '%s': %i\n", name, err);
> +               goto out;
> +       }
> +       err =3D -EINVAL;
> +       if (ovl_dentry_weird(path->dentry)) {
> +               pr_err("filesystem on '%s' not supported\n", name);
> +               goto out_put;
> +       }
> +       if (!d_is_dir(path->dentry)) {
> +               pr_err("'%s' not a directory\n", name);
> +               goto out_put;
> +       }
> +       return 0;
> +
> +out_put:
> +       path_put_init(path);
> +out:
> +       return err;
> +}
> +
> +static void ovl_unescape(char *s)
> +{
> +       char *d =3D s;
> +
> +       for (;; s++, d++) {
> +               if (*s =3D=3D '\\')
> +                       s++;
> +               *d =3D *s;
> +               if (!*s)
> +                       break;
> +       }
> +}
> +
> +static int ovl_mount_dir(const char *name, struct path *path)
> +{
> +       int err =3D -ENOMEM;
> +       char *tmp =3D kstrdup(name, GFP_KERNEL);
> +
> +       if (tmp) {
> +               ovl_unescape(tmp);
> +               err =3D ovl_mount_dir_noesc(tmp, path);
> +
> +               if (!err && path->dentry->d_flags & DCACHE_OP_REAL) {
> +                       pr_err("filesystem on '%s' not supported as upper=
dir\n",
> +                              tmp);
> +                       path_put_init(path);
> +                       err =3D -EINVAL;
> +               }
> +               kfree(tmp);
> +       }
> +       return err;
> +}
> +
> +int ovl_parse_param_upperdir(const char *name, struct fs_context *fc,
> +                            bool workdir)
> +{
> +       int err;
> +       struct ovl_fs *ofs =3D fc->s_fs_info;
> +       struct ovl_config *config =3D &ofs->config;
> +       struct ovl_fs_context *ctx =3D fc->fs_private;
> +       struct path path;
> +       char *dup;
> +
> +       err =3D ovl_mount_dir(name, &path);
> +       if (err)
> +               return err;
> +
> +       /*
> +        * Check whether upper path is read-only here to report failures
> +        * early. Don't forget to recheck when the superblock is created
> +        * as the mount attributes could change.
> +        */
> +       if (__mnt_is_readonly(path.mnt)) {
> +               path_put(&path);
> +               return -EINVAL;
> +       }
> +
> +       dup =3D kstrdup(name, GFP_KERNEL);
> +       if (!dup) {
> +               path_put(&path);
> +               return -ENOMEM;
> +       }
> +
> +       if (workdir) {
> +               kfree(config->workdir);
> +               config->workdir =3D dup;
> +               path_put(&ctx->work);
> +               ctx->work =3D path;
> +       } else {
> +               kfree(config->upperdir);
> +               config->upperdir =3D dup;
> +               path_put(&ctx->upper);
> +               ctx->upper =3D path;
> +       }
> +       return 0;
> +}
> +
> +void ovl_parse_param_drop_lowerdir(struct ovl_fs_context *ctx)
> +{
> +       for (size_t nr =3D 0; nr < ctx->nr; nr++) {
> +               path_put(&ctx->lower[nr].path);
> +               kfree(ctx->lower[nr].name);
> +               ctx->lower[nr].name =3D NULL;
> +       }
> +       ctx->nr =3D 0;
> +       ctx->nr_data =3D 0;
> +}
> +
> +/*
> + * Parse lowerdir=3D mount option:
> + *
> + * (1) lowerdir=3D/lower1:/lower2:/lower3::/data1::/data2
> + *     Set "/lower1", "/lower2", and "/lower3" as lower layers and
> + *     "/data1" and "/data2" as data lower layers. Any existing lower
> + *     layers are replaced.
> + * (2) lowerdir=3D:/lower4
> + *     Append "/lower4" to current stack of lower layers. This requires
> + *     that there already is at least one lower layer configured.
> + * (3) lowerdir=3D::/lower5
> + *     Append data "/lower5" as data lower layer. This requires that
> + *     there's at least one regular lower layer present.
> + */
> +int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
> +{
> +       int err;
> +       struct ovl_fs_context *ctx =3D fc->fs_private;
> +       struct ovl_fs_context_layer *l;
> +       char *dup =3D NULL, *dup_iter;
> +       ssize_t nr_lower =3D 0, nr =3D 0, nr_data =3D 0;
> +       bool append =3D false, data_layer =3D false;
> +
> +       /*
> +        * Ensure we're backwards compatible with mount(2)
> +        * by allowing relative paths.
> +        */
> +
> +       /* drop all existing lower layers */
> +       if (!*name) {
> +               ovl_parse_param_drop_lowerdir(ctx);
> +               return 0;
> +       }
> +
> +       if (strncmp(name, "::", 2) =3D=3D 0) {
> +               /*
> +                * This is a data layer.
> +                * There must be at least one regular lower layer
> +                * specified.
> +                */
> +               if (ctx->nr =3D=3D 0) {
> +                       pr_err("data lower layers without regular lower l=
ayers not allowed");
> +                       return -EINVAL;
> +               }
> +
> +               /* Skip the leading "::". */
> +               name +=3D 2;
> +               data_layer =3D true;
> +               /*
> +                * A data layer is automatically an append as there
> +                * must've been at least one regular lower layer.
> +                */
> +               append =3D true;
> +       } else if (*name =3D=3D ':') {
> +               /*
> +                * This is a regular lower layer.
> +                * If users want to append a layer enforce that they
> +                * have already specified a first layer before. It's
> +                * better to be strict.
> +                */
> +               if (ctx->nr =3D=3D 0) {
> +                       pr_err("cannot append layer if no previous layer =
has been specified");
> +                       return -EINVAL;
> +               }
> +
> +               /*
> +                * Once a sequence of data layers has started regular
> +                * lower layers are forbidden.
> +                */
> +               if (ctx->nr_data > 0) {
> +                       pr_err("regular lower layers cannot follow data l=
ower layers");
> +                       return -EINVAL;
> +               }
> +
> +               /* Skip the leading ":". */
> +               name++;
> +               append =3D true;
> +       }
> +
> +       dup =3D kstrdup(name, GFP_KERNEL);
> +       if (!dup)
> +               return -ENOMEM;
> +
> +       err =3D -EINVAL;
> +       nr_lower =3D ovl_parse_param_split_lowerdirs(dup);
> +       if (nr_lower < 0)
> +               goto out_err;
> +
> +       if ((nr_lower > OVL_MAX_STACK) ||
> +           (append && (size_add(ctx->nr, nr_lower) > OVL_MAX_STACK))) {
> +               pr_err("too many lower directories, limit is %d\n", OVL_M=
AX_STACK);
> +               goto out_err;
> +       }
> +
> +       if (!append)
> +               ovl_parse_param_drop_lowerdir(ctx);
> +
> +       /*
> +        * (1) append
> +        *
> +        * We want nr <=3D nr_lower <=3D capacity We know nr > 0 and nr <=
=3D
> +        * capacity. If nr =3D=3D 0 this wouldn't be append. If nr +
> +        * nr_lower is <=3D capacity then nr <=3D nr_lower <=3D capacity
> +        * already holds. If nr + nr_lower exceeds capacity, we realloc.
> +        *
> +        * (2) replace
> +        *
> +        * Ensure we're backwards compatible with mount(2) which allows
> +        * "lowerdir=3D/a:/b:/c,lowerdir=3D/d:/e:/f" causing the last
> +        * specified lowerdir mount option to win.
> +        *
> +        * We want nr <=3D nr_lower <=3D capacity We know either (i) nr =
=3D=3D 0
> +        * or (ii) nr > 0. We also know nr_lower > 0. The capacity
> +        * could've been changed multiple times already so we only know
> +        * nr <=3D capacity. If nr + nr_lower > capacity we realloc,
> +        * otherwise nr <=3D nr_lower <=3D capacity holds already.
> +        */
> +       nr_lower +=3D ctx->nr;
> +       if (nr_lower > ctx->capacity) {
> +               err =3D -ENOMEM;
> +               l =3D krealloc_array(ctx->lower, nr_lower, sizeof(*ctx->l=
ower),
> +                                  GFP_KERNEL_ACCOUNT);
> +               if (!l)
> +                       goto out_err;
> +
> +               ctx->lower =3D l;
> +               ctx->capacity =3D nr_lower;
> +       }
> +
> +       /*
> +        *   (3) By (1) and (2) we know nr <=3D nr_lower <=3D capacity.
> +        *   (4) If ctx->nr =3D=3D 0 =3D> replace
> +        *       We have verified above that the lowerdir mount option
> +        *       isn't an append, i.e., the lowerdir mount option
> +        *       doesn't start with ":" or "::".
> +        * (4.1) The lowerdir mount options only contains regular lower
> +        *       layers ":".
> +        *       =3D> Nothing to verify.
> +        * (4.2) The lowerdir mount options contains regular ":" and
> +        *       data "::" layers.
> +        *       =3D> We need to verify that data lower layers "::" aren'=
t
> +        *          followed by regular ":" lower layers
> +        *   (5) If ctx->nr > 0 =3D> append
> +        *       We know that there's at least one regular layer
> +        *       otherwise we would've failed when parsing the previous
> +        *       lowerdir mount option.
> +        * (5.1) The lowerdir mount option is a regular layer ":" append
> +        *       =3D> We need to verify that no data layers have been
> +        *          specified before.
> +        * (5.2) The lowerdir mount option is a data layer "::" append
> +        *       We know that there's at least one regular layer or
> +        *       other data layers. =3D> There's nothing to verify.
> +        */
> +       dup_iter =3D dup;
> +       for (nr =3D ctx->nr; nr < nr_lower; nr++) {
> +               l =3D &ctx->lower[nr];

missing here:
                   memset(l, 0, sizeof(*l));

otherwise, when trying to mount ovl over illegal fs (vfat)...

> +
> +               err =3D ovl_mount_dir_noesc(dup_iter, &l->path);
> +               if (err)
> +                       goto out_put;
> +
> +               err =3D -ENOMEM;
> +               l->name =3D kstrdup(dup_iter, GFP_KERNEL_ACCOUNT);
> +               if (!l->name)
> +                       goto out_put;
> +
> +               if (data_layer)
> +                       nr_data++;
> +
> +               /* Calling strchr() again would overrun. */
> +               if ((nr + 1) =3D=3D nr_lower)
> +                       break;
> +
> +               err =3D -EINVAL;
> +               dup_iter =3D strchr(dup_iter, '\0') + 1;
> +               if (*dup_iter) {
> +                       /*
> +                        * This is a regular layer so we require that
> +                        * there are no data layers.
> +                        */
> +                       if ((ctx->nr_data + nr_data) > 0) {
> +                               pr_err("regular lower layers cannot follo=
w data lower layers");
> +                               goto out_put;
> +                       }
> +
> +                       data_layer =3D false;
> +                       continue;
> +               }
> +
> +               /* This is a data lower layer. */
> +               data_layer =3D true;
> +               dup_iter++;
> +       }
> +       ctx->nr =3D nr_lower;
> +       ctx->nr_data +=3D nr_data;
> +       kfree(dup);
> +       return 0;
> +
> +out_put:
> +       /*
> +        * We know nr >=3D ctx->nr < nr_lower. If we failed somewhere
> +        * we want to undo until nr =3D=3D ctx->nr. This is correct for
> +        * both ctx->nr =3D=3D 0 and ctx->nr > 0.
> +        */
> +       for (; nr >=3D ctx->nr; nr--) {
> +               l =3D &ctx->lower[nr];
> +               kfree(l->name);
> +               l->name =3D NULL;
> +               path_put(&l->path);
> +

...this is kfreeing a garbage pointer.

I will fold that into my overlayfs-next branch.

Thanks,
Amir.
