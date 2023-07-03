Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4F8745832
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 11:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjGCJRM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 05:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjGCJRH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:17:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CC812C
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jul 2023 02:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688375780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SbDk57a1jqeG67LcA2+RWxjHEIv5HuirNtVaiIbPz/c=;
        b=bhNT4Ak+kiTwmv7pmID2A3n9aW/gvBF+inmIvpCj55eWlVF4LXZ4pm9toUGqObyDHpo7Ob
        ozxpfqFC4kWavISCUr9J5lF3Y4vA725iNBLzNWBOEuJkxvU3cPvPPL7jm2BWNIPuzDt/XH
        jsbSYYy/B6bCA8OhkezLiEMi3Z67XB4=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-5uxPJPDtNier2mJ2Kt008Q-1; Mon, 03 Jul 2023 05:16:19 -0400
X-MC-Unique: 5uxPJPDtNier2mJ2Kt008Q-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-346083e0744so4545805ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jul 2023 02:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688375778; x=1690967778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbDk57a1jqeG67LcA2+RWxjHEIv5HuirNtVaiIbPz/c=;
        b=IBqRspv+n2GDvFf9qY/PZD6NdV+mD7hdAxQ3bPHVm1dFNYUqC1+lBbvCGBTa/L8LBe
         yElM74b7qGpMBkgLyVYjSSghdSRMfHpngADuhqqSuCDzvZ5nGE7aolGVvkyana0buf2h
         LMQSqDhMo6WhWPkAJbDBV9VZdsweUf8bawL+I/rGtEkY99fRzDabE11NuBte+hvbgcnU
         NDJCboUo9IpOXAOgRhu2U0VnxXPoI5NL5YgbzJIeYJBKW0SQp9ClETkcJLj2ICqnl9+F
         tV3qXuktUawOq8c0mgajH6iQrILb9fX6p7lJtU2G5kuNsa21xzgMP4yb/62YAw3lDsri
         rm1g==
X-Gm-Message-State: ABy/qLa8RRRJkYSBeJt4gMD0Z6Tt6EFm6TDCtYnXzqYjnU+7O1TxtJ0m
        yl/QPwPetaqxhR4U0limDZLw5dKZQDZfBLj8XIrUtsglqYKUthQh8I+o+qE9dy4enwte2W/5vFY
        Es4fVW5o0ML8yp7558xtmipk9vXyL0yJUZDvE+fTxJA==
X-Received: by 2002:a92:cf45:0:b0:342:1b4e:609a with SMTP id c5-20020a92cf45000000b003421b4e609amr9797654ilr.2.1688375777907;
        Mon, 03 Jul 2023 02:16:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFgIBYjuRgJ3DPdFUupIWffQFqgCB33SCYDACcTuVMB2AuI3SV5wsG766XyfP+yYrZt6qLHugyQUP51f+o0YfI=
X-Received: by 2002:a92:cf45:0:b0:342:1b4e:609a with SMTP id
 c5-20020a92cf45000000b003421b4e609amr9797631ilr.2.1688375777387; Mon, 03 Jul
 2023 02:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230626-fs-overlayfs-mount-api-param-v1-1-29afb997a19f@kernel.org>
 <CAOQ4uxiOsHEx30ERLYeLdnOdFG1rw_OnXo+rBbKCY-ZzNxV_uQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxiOsHEx30ERLYeLdnOdFG1rw_OnXo+rBbKCY-ZzNxV_uQ@mail.gmail.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Mon, 3 Jul 2023 11:16:06 +0200
Message-ID: <CAL7ro1GgW-2gUhB=TBxwDAiybbQBbFabkU2tBNbBH85Q_KZWew@mail.gmail.com>
Subject: Re: [PATCH] ovl: move all parameter handling into params.{c,h}
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 4:40=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Mon, Jun 26, 2023 at 1:23=E2=80=AFPM Christian Brauner <brauner@kernel=
.org> wrote:
> >
> > While initially I thought that we couldn't move all new mount api
> > handling into params.{c,h} it turns out it is possible. So this just
> > moves a good chunk of code out of super.c and into params.{c,h}.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >
>
> Thank you for this cleanup!
>
> Alex,
>
> I took the liberty to resolve the conflicts with your branch, see:
>
> https://github.com/amir73il/linux/commits/overlay-verity

Thanks, I took a look at this and it seems good. Updated my branch to this =
too.

> Thanks,
> Amir.
>
> > ---
> >  fs/overlayfs/overlayfs.h |  41 +---
> >  fs/overlayfs/params.c    | 532 +++++++++++++++++++++++++++++++++++++++=
+++++++-
> >  fs/overlayfs/params.h    |  42 ++++
> >  fs/overlayfs/super.c     | 530 +--------------------------------------=
-------
> >  4 files changed, 581 insertions(+), 564 deletions(-)
> >
> > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > index 5b6ac03af192..ece77737df8d 100644
> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -70,14 +70,6 @@ enum {
> >         OVL_XINO_ON,
> >  };
> >
> > -/* The set of options that user requested explicitly via mount options=
 */
> > -struct ovl_opt_set {
> > -       bool metacopy;
> > -       bool redirect;
> > -       bool nfs_export;
> > -       bool index;
> > -};
> > -
> >  /*
> >   * The tuple (fh,uuid) is a universal unique identifier for a copy up =
origin,
> >   * where:
> > @@ -134,6 +126,12 @@ struct ovl_fh {
> >  #define OVL_FH_FID_OFFSET      (OVL_FH_WIRE_OFFSET + \
> >                                  offsetof(struct ovl_fb, fid))
> >
> > +/* Will this overlay be forced to mount/remount ro? */
> > +static inline bool ovl_force_readonly(struct ovl_fs *ofs)
> > +{
> > +       return (!ovl_upper_mnt(ofs) || !ofs->workdir);
> > +}
> > +
> >  extern const char *const ovl_xattr_table[][2];
> >  static inline const char *ovl_xattr(struct ovl_fs *ofs, enum ovl_xattr=
 ox)
> >  {
> > @@ -367,30 +365,6 @@ static inline bool ovl_open_flags_need_copy_up(int=
 flags)
> >         return ((OPEN_FMODE(flags) & FMODE_WRITE) || (flags & O_TRUNC))=
;
> >  }
> >
> > -
> > -/* params.c */
> > -#define OVL_MAX_STACK 500
> > -
> > -struct ovl_fs_context_layer {
> > -       char *name;
> > -       struct path path;
> > -};
> > -
> > -struct ovl_fs_context {
> > -       struct path upper;
> > -       struct path work;
> > -       size_t capacity;
> > -       size_t nr; /* includes nr_data */
> > -       size_t nr_data;
> > -       struct ovl_opt_set set;
> > -       struct ovl_fs_context_layer *lower;
> > -};
> > -
> > -int ovl_parse_param_upperdir(const char *name, struct fs_context *fc,
> > -                            bool workdir);
> > -int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc);
> > -void ovl_parse_param_drop_lowerdir(struct ovl_fs_context *ctx);
> > -
> >  /* util.c */
> >  int ovl_want_write(struct dentry *dentry);
> >  void ovl_drop_write(struct dentry *dentry);
> > @@ -790,3 +764,6 @@ int ovl_set_origin(struct ovl_fs *ofs, struct dentr=
y *lower,
> >
> >  /* export.c */
> >  extern const struct export_operations ovl_export_operations;
> > +
> > +/* super.c */
> > +int ovl_fill_super(struct super_block *sb, struct fs_context *fc);
> > diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> > index d17d6b483dd0..b8c2f6056a9a 100644
> > --- a/fs/overlayfs/params.c
> > +++ b/fs/overlayfs/params.c
> > @@ -1,12 +1,124 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >
> >  #include <linux/fs.h>
> > +#include <linux/module.h>
> >  #include <linux/namei.h>
> >  #include <linux/fs_context.h>
> >  #include <linux/fs_parser.h>
> >  #include <linux/posix_acl_xattr.h>
> > +#include <linux/seq_file.h>
> >  #include <linux/xattr.h>
> >  #include "overlayfs.h"
> > +#include "params.h"
> > +
> > +static bool ovl_redirect_dir_def =3D IS_ENABLED(CONFIG_OVERLAY_FS_REDI=
RECT_DIR);
> > +module_param_named(redirect_dir, ovl_redirect_dir_def, bool, 0644);
> > +MODULE_PARM_DESC(redirect_dir,
> > +                "Default to on or off for the redirect_dir feature");
> > +
> > +static bool ovl_redirect_always_follow =3D
> > +       IS_ENABLED(CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW);
> > +module_param_named(redirect_always_follow, ovl_redirect_always_follow,
> > +                  bool, 0644);
> > +MODULE_PARM_DESC(redirect_always_follow,
> > +                "Follow redirects even if redirect_dir feature is turn=
ed off");
> > +
> > +static bool ovl_xino_auto_def =3D IS_ENABLED(CONFIG_OVERLAY_FS_XINO_AU=
TO);
> > +module_param_named(xino_auto, ovl_xino_auto_def, bool, 0644);
> > +MODULE_PARM_DESC(xino_auto,
> > +                "Auto enable xino feature");
> > +
> > +static bool ovl_index_def =3D IS_ENABLED(CONFIG_OVERLAY_FS_INDEX);
> > +module_param_named(index, ovl_index_def, bool, 0644);
> > +MODULE_PARM_DESC(index,
> > +                "Default to on or off for the inodes index feature");
> > +
> > +static bool ovl_nfs_export_def =3D IS_ENABLED(CONFIG_OVERLAY_FS_NFS_EX=
PORT);
> > +module_param_named(nfs_export, ovl_nfs_export_def, bool, 0644);
> > +MODULE_PARM_DESC(nfs_export,
> > +                "Default to on or off for the NFS export feature");
> > +
> > +static bool ovl_metacopy_def =3D IS_ENABLED(CONFIG_OVERLAY_FS_METACOPY=
);
> > +module_param_named(metacopy, ovl_metacopy_def, bool, 0644);
> > +MODULE_PARM_DESC(metacopy,
> > +                "Default to on or off for the metadata only copy up fe=
ature");
> > +
> > +enum {
> > +       Opt_lowerdir,
> > +       Opt_upperdir,
> > +       Opt_workdir,
> > +       Opt_default_permissions,
> > +       Opt_redirect_dir,
> > +       Opt_index,
> > +       Opt_uuid,
> > +       Opt_nfs_export,
> > +       Opt_userxattr,
> > +       Opt_xino,
> > +       Opt_metacopy,
> > +       Opt_volatile,
> > +};
> > +
> > +static const struct constant_table ovl_parameter_bool[] =3D {
> > +       { "on",         true  },
> > +       { "off",        false },
> > +       {}
> > +};
> > +
> > +static const struct constant_table ovl_parameter_xino[] =3D {
> > +       { "off",        OVL_XINO_OFF  },
> > +       { "auto",       OVL_XINO_AUTO },
> > +       { "on",         OVL_XINO_ON   },
> > +       {}
> > +};
> > +
> > +const char *ovl_xino_mode(struct ovl_config *config)
> > +{
> > +       return ovl_parameter_xino[config->xino].name;
> > +}
> > +
> > +static int ovl_xino_def(void)
> > +{
> > +       return ovl_xino_auto_def ? OVL_XINO_AUTO : OVL_XINO_OFF;
> > +}
> > +
> > +const struct constant_table ovl_parameter_redirect_dir[] =3D {
> > +       { "off",        OVL_REDIRECT_OFF      },
> > +       { "follow",     OVL_REDIRECT_FOLLOW   },
> > +       { "nofollow",   OVL_REDIRECT_NOFOLLOW },
> > +       { "on",         OVL_REDIRECT_ON       },
> > +       {}
> > +};
> > +
> > +const char *ovl_redirect_mode(struct ovl_config *config)
> > +{
> > +       return ovl_parameter_redirect_dir[config->redirect_mode].name;
> > +}
> > +
> > +static int ovl_redirect_mode_def(void)
> > +{
> > +       return ovl_redirect_dir_def       ? OVL_REDIRECT_ON :
> > +              ovl_redirect_always_follow ? OVL_REDIRECT_FOLLOW :
> > +                                           OVL_REDIRECT_NOFOLLOW;
> > +}
> > +
> > +#define fsparam_string_empty(NAME, OPT) \
> > +       __fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty,=
 NULL)
> > +
> > +const struct fs_parameter_spec ovl_parameter_spec[] =3D {
> > +       fsparam_string_empty("lowerdir",    Opt_lowerdir),
> > +       fsparam_string("upperdir",          Opt_upperdir),
> > +       fsparam_string("workdir",           Opt_workdir),
> > +       fsparam_flag("default_permissions", Opt_default_permissions),
> > +       fsparam_enum("redirect_dir",        Opt_redirect_dir, ovl_param=
eter_redirect_dir),
> > +       fsparam_enum("index",               Opt_index, ovl_parameter_bo=
ol),
> > +       fsparam_enum("uuid",                Opt_uuid, ovl_parameter_boo=
l),
> > +       fsparam_enum("nfs_export",          Opt_nfs_export, ovl_paramet=
er_bool),
> > +       fsparam_flag("userxattr",           Opt_userxattr),
> > +       fsparam_enum("xino",                Opt_xino, ovl_parameter_xin=
o),
> > +       fsparam_enum("metacopy",            Opt_metacopy, ovl_parameter=
_bool),
> > +       fsparam_flag("volatile",            Opt_volatile),
> > +       {}
> > +};
> >
> >  static ssize_t ovl_parse_param_split_lowerdirs(char *str)
> >  {
> > @@ -110,8 +222,8 @@ static int ovl_mount_dir(const char *name, struct p=
ath *path)
> >         return err;
> >  }
> >
> > -int ovl_parse_param_upperdir(const char *name, struct fs_context *fc,
> > -                            bool workdir)
> > +static int ovl_parse_param_upperdir(const char *name, struct fs_contex=
t *fc,
> > +                                   bool workdir)
> >  {
> >         int err;
> >         struct ovl_fs *ofs =3D fc->s_fs_info;
> > @@ -154,7 +266,7 @@ int ovl_parse_param_upperdir(const char *name, stru=
ct fs_context *fc,
> >         return 0;
> >  }
> >
> > -void ovl_parse_param_drop_lowerdir(struct ovl_fs_context *ctx)
> > +static void ovl_parse_param_drop_lowerdir(struct ovl_fs_context *ctx)
> >  {
> >         for (size_t nr =3D 0; nr < ctx->nr; nr++) {
> >                 path_put(&ctx->lower[nr].path);
> > @@ -179,7 +291,7 @@ void ovl_parse_param_drop_lowerdir(struct ovl_fs_co=
ntext *ctx)
> >   *     Append data "/lower5" as data lower layer. This requires that
> >   *     there's at least one regular lower layer present.
> >   */
> > -int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
> > +static int ovl_parse_param_lowerdir(const char *name, struct fs_contex=
t *fc)
> >  {
> >         int err;
> >         struct ovl_fs_context *ctx =3D fc->fs_private;
> > @@ -387,3 +499,415 @@ int ovl_parse_param_lowerdir(const char *name, st=
ruct fs_context *fc)
> >         /* Intentionally don't realloc to a smaller size. */
> >         return err;
> >  }
> > +
> > +static int ovl_parse_param(struct fs_context *fc, struct fs_parameter =
*param)
> > +{
> > +       int err =3D 0;
> > +       struct fs_parse_result result;
> > +       struct ovl_fs *ofs =3D fc->s_fs_info;
> > +       struct ovl_config *config =3D &ofs->config;
> > +       struct ovl_fs_context *ctx =3D fc->fs_private;
> > +       int opt;
> > +
> > +       if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
> > +               /*
> > +                * On remount overlayfs has always ignored all mount
> > +                * options no matter if malformed or not so for
> > +                * backwards compatibility we do the same here.
> > +                */
> > +               if (fc->oldapi)
> > +                       return 0;
> > +
> > +               /*
> > +                * Give us the freedom to allow changing mount options
> > +                * with the new mount api in the future. So instead of
> > +                * silently ignoring everything we report a proper
> > +                * error. This is only visible for users of the new
> > +                * mount api.
> > +                */
> > +               return invalfc(fc, "No changes allowed in reconfigure")=
;
> > +       }
> > +
> > +       opt =3D fs_parse(fc, ovl_parameter_spec, param, &result);
> > +       if (opt < 0)
> > +               return opt;
> > +
> > +       switch (opt) {
> > +       case Opt_lowerdir:
> > +               err =3D ovl_parse_param_lowerdir(param->string, fc);
> > +               break;
> > +       case Opt_upperdir:
> > +               fallthrough;
> > +       case Opt_workdir:
> > +               err =3D ovl_parse_param_upperdir(param->string, fc,
> > +                                              (Opt_workdir =3D=3D opt)=
);
> > +               break;
> > +       case Opt_default_permissions:
> > +               config->default_permissions =3D true;
> > +               break;
> > +       case Opt_redirect_dir:
> > +               config->redirect_mode =3D result.uint_32;
> > +               if (config->redirect_mode =3D=3D OVL_REDIRECT_OFF) {
> > +                       config->redirect_mode =3D ovl_redirect_always_f=
ollow ?
> > +                                               OVL_REDIRECT_FOLLOW :
> > +                                               OVL_REDIRECT_NOFOLLOW;
> > +               }
> > +               ctx->set.redirect =3D true;
> > +               break;
> > +       case Opt_index:
> > +               config->index =3D result.uint_32;
> > +               ctx->set.index =3D true;
> > +               break;
> > +       case Opt_uuid:
> > +               config->uuid =3D result.uint_32;
> > +               break;
> > +       case Opt_nfs_export:
> > +               config->nfs_export =3D result.uint_32;
> > +               ctx->set.nfs_export =3D true;
> > +               break;
> > +       case Opt_xino:
> > +               config->xino =3D result.uint_32;
> > +               break;
> > +       case Opt_metacopy:
> > +               config->metacopy =3D result.uint_32;
> > +               ctx->set.metacopy =3D true;
> > +               break;
> > +       case Opt_volatile:
> > +               config->ovl_volatile =3D true;
> > +               break;
> > +       case Opt_userxattr:
> > +               config->userxattr =3D true;
> > +               break;
> > +       default:
> > +               pr_err("unrecognized mount option \"%s\" or missing val=
ue\n",
> > +                      param->key);
> > +               return -EINVAL;
> > +       }
> > +
> > +       return err;
> > +}
> > +
> > +static int ovl_get_tree(struct fs_context *fc)
> > +{
> > +       return get_tree_nodev(fc, ovl_fill_super);
> > +}
> > +
> > +static inline void ovl_fs_context_free(struct ovl_fs_context *ctx)
> > +{
> > +       ovl_parse_param_drop_lowerdir(ctx);
> > +       path_put(&ctx->upper);
> > +       path_put(&ctx->work);
> > +       kfree(ctx->lower);
> > +       kfree(ctx);
> > +}
> > +
> > +static void ovl_free(struct fs_context *fc)
> > +{
> > +       struct ovl_fs *ofs =3D fc->s_fs_info;
> > +       struct ovl_fs_context *ctx =3D fc->fs_private;
> > +
> > +       /*
> > +        * ofs is stored in the fs_context when it is initialized.
> > +        * ofs is transferred to the superblock on a successful mount,
> > +        * but if an error occurs before the transfer we have to free
> > +        * it here.
> > +        */
> > +       if (ofs)
> > +               ovl_free_fs(ofs);
> > +
> > +       if (ctx)
> > +               ovl_fs_context_free(ctx);
> > +}
> > +
> > +static int ovl_reconfigure(struct fs_context *fc)
> > +{
> > +       struct super_block *sb =3D fc->root->d_sb;
> > +       struct ovl_fs *ofs =3D sb->s_fs_info;
> > +       struct super_block *upper_sb;
> > +       int ret =3D 0;
> > +
> > +       if (!(fc->sb_flags & SB_RDONLY) && ovl_force_readonly(ofs))
> > +               return -EROFS;
> > +
> > +       if (fc->sb_flags & SB_RDONLY && !sb_rdonly(sb)) {
> > +               upper_sb =3D ovl_upper_mnt(ofs)->mnt_sb;
> > +               if (ovl_should_sync(ofs)) {
> > +                       down_read(&upper_sb->s_umount);
> > +                       ret =3D sync_filesystem(upper_sb);
> > +                       up_read(&upper_sb->s_umount);
> > +               }
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static const struct fs_context_operations ovl_context_ops =3D {
> > +       .parse_param =3D ovl_parse_param,
> > +       .get_tree    =3D ovl_get_tree,
> > +       .reconfigure =3D ovl_reconfigure,
> > +       .free        =3D ovl_free,
> > +};
> > +
> > +/*
> > + * This is called during fsopen() and will record the user namespace o=
f
> > + * the caller in fc->user_ns since we've raised FS_USERNS_MOUNT. We'll
> > + * need it when we actually create the superblock to verify that the
> > + * process creating the superblock is in the same user namespace as
> > + * process that called fsopen().
> > + */
> > +int ovl_init_fs_context(struct fs_context *fc)
> > +{
> > +       struct ovl_fs_context *ctx;
> > +       struct ovl_fs *ofs;
> > +
> > +       ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
> > +       if (!ctx)
> > +               return -ENOMEM;
> > +
> > +       /*
> > +        * By default we allocate for three lower layers. It's likely
> > +        * that it'll cover most users.
> > +        */
> > +       ctx->lower =3D kmalloc_array(3, sizeof(*ctx->lower), GFP_KERNEL=
_ACCOUNT);
> > +       if (!ctx->lower)
> > +               goto out_err;
> > +       ctx->capacity =3D 3;
> > +
> > +       ofs =3D kzalloc(sizeof(struct ovl_fs), GFP_KERNEL);
> > +       if (!ofs)
> > +               goto out_err;
> > +
> > +       ofs->config.redirect_mode       =3D ovl_redirect_mode_def();
> > +       ofs->config.index               =3D ovl_index_def;
> > +       ofs->config.uuid                =3D true;
> > +       ofs->config.nfs_export          =3D ovl_nfs_export_def;
> > +       ofs->config.xino                =3D ovl_xino_def();
> > +       ofs->config.metacopy            =3D ovl_metacopy_def;
> > +
> > +       fc->s_fs_info           =3D ofs;
> > +       fc->fs_private          =3D ctx;
> > +       fc->ops                 =3D &ovl_context_ops;
> > +       return 0;
> > +
> > +out_err:
> > +       ovl_fs_context_free(ctx);
> > +       return -ENOMEM;
> > +
> > +}
> > +
> > +void ovl_free_fs(struct ovl_fs *ofs)
> > +{
> > +       struct vfsmount **mounts;
> > +       unsigned i;
> > +
> > +       iput(ofs->workbasedir_trap);
> > +       iput(ofs->indexdir_trap);
> > +       iput(ofs->workdir_trap);
> > +       dput(ofs->whiteout);
> > +       dput(ofs->indexdir);
> > +       dput(ofs->workdir);
> > +       if (ofs->workdir_locked)
> > +               ovl_inuse_unlock(ofs->workbasedir);
> > +       dput(ofs->workbasedir);
> > +       if (ofs->upperdir_locked)
> > +               ovl_inuse_unlock(ovl_upper_mnt(ofs)->mnt_root);
> > +
> > +       /* Hack!  Reuse ofs->layers as a vfsmount array before freeing =
it */
> > +       mounts =3D (struct vfsmount **) ofs->layers;
> > +       for (i =3D 0; i < ofs->numlayer; i++) {
> > +               iput(ofs->layers[i].trap);
> > +               mounts[i] =3D ofs->layers[i].mnt;
> > +               kfree(ofs->layers[i].name);
> > +       }
> > +       kern_unmount_array(mounts, ofs->numlayer);
> > +       kfree(ofs->layers);
> > +       for (i =3D 0; i < ofs->numfs; i++)
> > +               free_anon_bdev(ofs->fs[i].pseudo_dev);
> > +       kfree(ofs->fs);
> > +
> > +       kfree(ofs->config.upperdir);
> > +       kfree(ofs->config.workdir);
> > +       if (ofs->creator_cred)
> > +               put_cred(ofs->creator_cred);
> > +       kfree(ofs);
> > +}
> > +
> > +int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
> > +                        struct ovl_config *config)
> > +{
> > +       struct ovl_opt_set set =3D ctx->set;
> > +
> > +       if (ctx->nr_data > 0 && !config->metacopy) {
> > +               pr_err("lower data-only dirs require metacopy support.\=
n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* Workdir/index are useless in non-upper mount */
> > +       if (!config->upperdir) {
> > +               if (config->workdir) {
> > +                       pr_info("option \"workdir=3D%s\" is useless in =
a non-upper mount, ignore\n",
> > +                               config->workdir);
> > +                       kfree(config->workdir);
> > +                       config->workdir =3D NULL;
> > +               }
> > +               if (config->index && set.index) {
> > +                       pr_info("option \"index=3Don\" is useless in a =
non-upper mount, ignore\n");
> > +                       set.index =3D false;
> > +               }
> > +               config->index =3D false;
> > +       }
> > +
> > +       if (!config->upperdir && config->ovl_volatile) {
> > +               pr_info("option \"volatile\" is meaningless in a non-up=
per mount, ignoring it.\n");
> > +               config->ovl_volatile =3D false;
> > +       }
> > +
> > +       /*
> > +        * This is to make the logic below simpler.  It doesn't make an=
y other
> > +        * difference, since redirect_dir=3Don is only used for upper.
> > +        */
> > +       if (!config->upperdir && config->redirect_mode =3D=3D OVL_REDIR=
ECT_FOLLOW)
> > +               config->redirect_mode =3D OVL_REDIRECT_ON;
> > +
> > +       /* Resolve metacopy -> redirect_dir dependency */
> > +       if (config->metacopy && config->redirect_mode !=3D OVL_REDIRECT=
_ON) {
> > +               if (set.metacopy && set.redirect) {
> > +                       pr_err("conflicting options: metacopy=3Don,redi=
rect_dir=3D%s\n",
> > +                              ovl_redirect_mode(config));
> > +                       return -EINVAL;
> > +               }
> > +               if (set.redirect) {
> > +                       /*
> > +                        * There was an explicit redirect_dir=3D... tha=
t resulted
> > +                        * in this conflict.
> > +                        */
> > +                       pr_info("disabling metacopy due to redirect_dir=
=3D%s\n",
> > +                               ovl_redirect_mode(config));
> > +                       config->metacopy =3D false;
> > +               } else {
> > +                       /* Automatically enable redirect otherwise. */
> > +                       config->redirect_mode =3D OVL_REDIRECT_ON;
> > +               }
> > +       }
> > +
> > +       /* Resolve nfs_export -> index dependency */
> > +       if (config->nfs_export && !config->index) {
> > +               if (!config->upperdir &&
> > +                   config->redirect_mode !=3D OVL_REDIRECT_NOFOLLOW) {
> > +                       pr_info("NFS export requires \"redirect_dir=3Dn=
ofollow\" on non-upper mount, falling back to nfs_export=3Doff.\n");
> > +                       config->nfs_export =3D false;
> > +               } else if (set.nfs_export && set.index) {
> > +                       pr_err("conflicting options: nfs_export=3Don,in=
dex=3Doff\n");
> > +                       return -EINVAL;
> > +               } else if (set.index) {
> > +                       /*
> > +                        * There was an explicit index=3Doff that resul=
ted
> > +                        * in this conflict.
> > +                        */
> > +                       pr_info("disabling nfs_export due to index=3Dof=
f\n");
> > +                       config->nfs_export =3D false;
> > +               } else {
> > +                       /* Automatically enable index otherwise. */
> > +                       config->index =3D true;
> > +               }
> > +       }
> > +
> > +       /* Resolve nfs_export -> !metacopy dependency */
> > +       if (config->nfs_export && config->metacopy) {
> > +               if (set.nfs_export && set.metacopy) {
> > +                       pr_err("conflicting options: nfs_export=3Don,me=
tacopy=3Don\n");
> > +                       return -EINVAL;
> > +               }
> > +               if (set.metacopy) {
> > +                       /*
> > +                        * There was an explicit metacopy=3Don that res=
ulted
> > +                        * in this conflict.
> > +                        */
> > +                       pr_info("disabling nfs_export due to metacopy=
=3Don\n");
> > +                       config->nfs_export =3D false;
> > +               } else {
> > +                       /*
> > +                        * There was an explicit nfs_export=3Don that r=
esulted
> > +                        * in this conflict.
> > +                        */
> > +                       pr_info("disabling metacopy due to nfs_export=
=3Don\n");
> > +                       config->metacopy =3D false;
> > +               }
> > +       }
> > +
> > +
> > +       /* Resolve userxattr -> !redirect && !metacopy dependency */
> > +       if (config->userxattr) {
> > +               if (set.redirect &&
> > +                   config->redirect_mode !=3D OVL_REDIRECT_NOFOLLOW) {
> > +                       pr_err("conflicting options: userxattr,redirect=
_dir=3D%s\n",
> > +                              ovl_redirect_mode(config));
> > +                       return -EINVAL;
> > +               }
> > +               if (config->metacopy && set.metacopy) {
> > +                       pr_err("conflicting options: userxattr,metacopy=
=3Don\n");
> > +                       return -EINVAL;
> > +               }
> > +               /*
> > +                * Silently disable default setting of redirect and met=
acopy.
> > +                * This shall be the default in the future as well: the=
se
> > +                * options must be explicitly enabled if used together =
with
> > +                * userxattr.
> > +                */
> > +               config->redirect_mode =3D OVL_REDIRECT_NOFOLLOW;
> > +               config->metacopy =3D false;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * ovl_show_options
> > + * @m: the seq_file handle
> > + * @dentry: The dentry to query
> > + *
> > + * Prints the mount options for a given superblock.
> > + * Returns zero; does not fail.
> > + */
> > +int ovl_show_options(struct seq_file *m, struct dentry *dentry)
> > +{
> > +       struct super_block *sb =3D dentry->d_sb;
> > +       struct ovl_fs *ofs =3D sb->s_fs_info;
> > +       size_t nr, nr_merged_lower =3D ofs->numlayer - ofs->numdatalaye=
r;
> > +       const struct ovl_layer *data_layers =3D &ofs->layers[nr_merged_=
lower];
> > +
> > +       /* ofs->layers[0] is the upper layer */
> > +       seq_printf(m, ",lowerdir=3D%s", ofs->layers[1].name);
> > +       /* dump regular lower layers */
> > +       for (nr =3D 2; nr < nr_merged_lower; nr++)
> > +               seq_printf(m, ":%s", ofs->layers[nr].name);
> > +       /* dump data lower layers */
> > +       for (nr =3D 0; nr < ofs->numdatalayer; nr++)
> > +               seq_printf(m, "::%s", data_layers[nr].name);
> > +       if (ofs->config.upperdir) {
> > +               seq_show_option(m, "upperdir", ofs->config.upperdir);
> > +               seq_show_option(m, "workdir", ofs->config.workdir);
> > +       }
> > +       if (ofs->config.default_permissions)
> > +               seq_puts(m, ",default_permissions");
> > +       if (ofs->config.redirect_mode !=3D ovl_redirect_mode_def())
> > +               seq_printf(m, ",redirect_dir=3D%s",
> > +                          ovl_redirect_mode(&ofs->config));
> > +       if (ofs->config.index !=3D ovl_index_def)
> > +               seq_printf(m, ",index=3D%s", ofs->config.index ? "on" :=
 "off");
> > +       if (!ofs->config.uuid)
> > +               seq_puts(m, ",uuid=3Doff");
> > +       if (ofs->config.nfs_export !=3D ovl_nfs_export_def)
> > +               seq_printf(m, ",nfs_export=3D%s", ofs->config.nfs_expor=
t ?
> > +                                               "on" : "off");
> > +       if (ofs->config.xino !=3D ovl_xino_def() && !ovl_same_fs(ofs))
> > +               seq_printf(m, ",xino=3D%s", ovl_xino_mode(&ofs->config)=
);
> > +       if (ofs->config.metacopy !=3D ovl_metacopy_def)
> > +               seq_printf(m, ",metacopy=3D%s",
> > +                          ofs->config.metacopy ? "on" : "off");
> > +       if (ofs->config.ovl_volatile)
> > +               seq_puts(m, ",volatile");
> > +       if (ofs->config.userxattr)
> > +               seq_puts(m, ",userxattr");
> > +       return 0;
> > +}
> > diff --git a/fs/overlayfs/params.h b/fs/overlayfs/params.h
> > new file mode 100644
> > index 000000000000..8750da68ab2a
> > --- /dev/null
> > +++ b/fs/overlayfs/params.h
> > @@ -0,0 +1,42 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#include <linux/fs_context.h>
> > +#include <linux/fs_parser.h>
> > +
> > +struct ovl_fs;
> > +struct ovl_config;
> > +
> > +extern const struct fs_parameter_spec ovl_parameter_spec[];
> > +extern const struct constant_table ovl_parameter_redirect_dir[];
> > +
> > +/* The set of options that user requested explicitly via mount options=
 */
> > +struct ovl_opt_set {
> > +       bool metacopy;
> > +       bool redirect;
> > +       bool nfs_export;
> > +       bool index;
> > +};
> > +
> > +#define OVL_MAX_STACK 500
> > +
> > +struct ovl_fs_context_layer {
> > +       char *name;
> > +       struct path path;
> > +};
> > +
> > +struct ovl_fs_context {
> > +       struct path upper;
> > +       struct path work;
> > +       size_t capacity;
> > +       size_t nr; /* includes nr_data */
> > +       size_t nr_data;
> > +       struct ovl_opt_set set;
> > +       struct ovl_fs_context_layer *lower;
> > +};
> > +
> > +int ovl_init_fs_context(struct fs_context *fc);
> > +void ovl_free_fs(struct ovl_fs *ofs);
> > +int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
> > +                        struct ovl_config *config);
> > +int ovl_show_options(struct seq_file *m, struct dentry *dentry);
> > +const char *ovl_xino_mode(struct ovl_config *config);
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index c14c52560fd6..5b069f1a1e44 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/fs_context.h>
> >  #include <linux/fs_parser.h>
> >  #include "overlayfs.h"
> > +#include "params.h"
> >
> >  MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
> >  MODULE_DESCRIPTION("Overlay filesystem");
> > @@ -27,38 +28,6 @@ MODULE_LICENSE("GPL");
> >
> >  struct ovl_dir_cache;
> >
> > -static bool ovl_redirect_dir_def =3D IS_ENABLED(CONFIG_OVERLAY_FS_REDI=
RECT_DIR);
> > -module_param_named(redirect_dir, ovl_redirect_dir_def, bool, 0644);
> > -MODULE_PARM_DESC(redirect_dir,
> > -                "Default to on or off for the redirect_dir feature");
> > -
> > -static bool ovl_redirect_always_follow =3D
> > -       IS_ENABLED(CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW);
> > -module_param_named(redirect_always_follow, ovl_redirect_always_follow,
> > -                  bool, 0644);
> > -MODULE_PARM_DESC(redirect_always_follow,
> > -                "Follow redirects even if redirect_dir feature is turn=
ed off");
> > -
> > -static bool ovl_index_def =3D IS_ENABLED(CONFIG_OVERLAY_FS_INDEX);
> > -module_param_named(index, ovl_index_def, bool, 0644);
> > -MODULE_PARM_DESC(index,
> > -                "Default to on or off for the inodes index feature");
> > -
> > -static bool ovl_nfs_export_def =3D IS_ENABLED(CONFIG_OVERLAY_FS_NFS_EX=
PORT);
> > -module_param_named(nfs_export, ovl_nfs_export_def, bool, 0644);
> > -MODULE_PARM_DESC(nfs_export,
> > -                "Default to on or off for the NFS export feature");
> > -
> > -static bool ovl_xino_auto_def =3D IS_ENABLED(CONFIG_OVERLAY_FS_XINO_AU=
TO);
> > -module_param_named(xino_auto, ovl_xino_auto_def, bool, 0644);
> > -MODULE_PARM_DESC(xino_auto,
> > -                "Auto enable xino feature");
> > -
> > -static bool ovl_metacopy_def =3D IS_ENABLED(CONFIG_OVERLAY_FS_METACOPY=
);
> > -module_param_named(metacopy, ovl_metacopy_def, bool, 0644);
> > -MODULE_PARM_DESC(metacopy,
> > -                "Default to on or off for the metadata only copy up fe=
ature");
> > -
> >  static struct dentry *ovl_d_real(struct dentry *dentry,
> >                                  const struct inode *inode)
> >  {
> > @@ -211,43 +180,6 @@ static void ovl_destroy_inode(struct inode *inode)
> >                 kfree(oi->lowerdata_redirect);
> >  }
> >
> > -static void ovl_free_fs(struct ovl_fs *ofs)
> > -{
> > -       struct vfsmount **mounts;
> > -       unsigned i;
> > -
> > -       iput(ofs->workbasedir_trap);
> > -       iput(ofs->indexdir_trap);
> > -       iput(ofs->workdir_trap);
> > -       dput(ofs->whiteout);
> > -       dput(ofs->indexdir);
> > -       dput(ofs->workdir);
> > -       if (ofs->workdir_locked)
> > -               ovl_inuse_unlock(ofs->workbasedir);
> > -       dput(ofs->workbasedir);
> > -       if (ofs->upperdir_locked)
> > -               ovl_inuse_unlock(ovl_upper_mnt(ofs)->mnt_root);
> > -
> > -       /* Hack!  Reuse ofs->layers as a vfsmount array before freeing =
it */
> > -       mounts =3D (struct vfsmount **) ofs->layers;
> > -       for (i =3D 0; i < ofs->numlayer; i++) {
> > -               iput(ofs->layers[i].trap);
> > -               mounts[i] =3D ofs->layers[i].mnt;
> > -               kfree(ofs->layers[i].name);
> > -       }
> > -       kern_unmount_array(mounts, ofs->numlayer);
> > -       kfree(ofs->layers);
> > -       for (i =3D 0; i < ofs->numfs; i++)
> > -               free_anon_bdev(ofs->fs[i].pseudo_dev);
> > -       kfree(ofs->fs);
> > -
> > -       kfree(ofs->config.upperdir);
> > -       kfree(ofs->config.workdir);
> > -       if (ofs->creator_cred)
> > -               put_cred(ofs->creator_cred);
> > -       kfree(ofs);
> > -}
> > -
> >  static void ovl_put_super(struct super_block *sb)
> >  {
> >         struct ovl_fs *ofs =3D sb->s_fs_info;
> > @@ -323,122 +255,6 @@ static int ovl_statfs(struct dentry *dentry, stru=
ct kstatfs *buf)
> >         return err;
> >  }
> >
> > -/* Will this overlay be forced to mount/remount ro? */
> > -static bool ovl_force_readonly(struct ovl_fs *ofs)
> > -{
> > -       return (!ovl_upper_mnt(ofs) || !ofs->workdir);
> > -}
> > -
> > -static const struct constant_table ovl_parameter_redirect_dir[] =3D {
> > -       { "off",        OVL_REDIRECT_OFF      },
> > -       { "follow",     OVL_REDIRECT_FOLLOW   },
> > -       { "nofollow",   OVL_REDIRECT_NOFOLLOW },
> > -       { "on",         OVL_REDIRECT_ON       },
> > -       {}
> > -};
> > -
> > -static const char *ovl_redirect_mode(struct ovl_config *config)
> > -{
> > -       return ovl_parameter_redirect_dir[config->redirect_mode].name;
> > -}
> > -
> > -static int ovl_redirect_mode_def(void)
> > -{
> > -       return ovl_redirect_dir_def ? OVL_REDIRECT_ON :
> > -               ovl_redirect_always_follow ? OVL_REDIRECT_FOLLOW :
> > -                                            OVL_REDIRECT_NOFOLLOW;
> > -}
> > -
> > -static const struct constant_table ovl_parameter_xino[] =3D {
> > -       { "off",        OVL_XINO_OFF  },
> > -       { "auto",       OVL_XINO_AUTO },
> > -       { "on",         OVL_XINO_ON   },
> > -       {}
> > -};
> > -
> > -static const char *ovl_xino_mode(struct ovl_config *config)
> > -{
> > -       return ovl_parameter_xino[config->xino].name;
> > -}
> > -
> > -static inline int ovl_xino_def(void)
> > -{
> > -       return ovl_xino_auto_def ? OVL_XINO_AUTO : OVL_XINO_OFF;
> > -}
> > -
> > -/**
> > - * ovl_show_options
> > - * @m: the seq_file handle
> > - * @dentry: The dentry to query
> > - *
> > - * Prints the mount options for a given superblock.
> > - * Returns zero; does not fail.
> > - */
> > -static int ovl_show_options(struct seq_file *m, struct dentry *dentry)
> > -{
> > -       struct super_block *sb =3D dentry->d_sb;
> > -       struct ovl_fs *ofs =3D sb->s_fs_info;
> > -       size_t nr, nr_merged_lower =3D ofs->numlayer - ofs->numdatalaye=
r;
> > -       const struct ovl_layer *data_layers =3D &ofs->layers[nr_merged_=
lower];
> > -
> > -       /* ofs->layers[0] is the upper layer */
> > -       seq_printf(m, ",lowerdir=3D%s", ofs->layers[1].name);
> > -       /* dump regular lower layers */
> > -       for (nr =3D 2; nr < nr_merged_lower; nr++)
> > -               seq_printf(m, ":%s", ofs->layers[nr].name);
> > -       /* dump data lower layers */
> > -       for (nr =3D 0; nr < ofs->numdatalayer; nr++)
> > -               seq_printf(m, "::%s", data_layers[nr].name);
> > -       if (ofs->config.upperdir) {
> > -               seq_show_option(m, "upperdir", ofs->config.upperdir);
> > -               seq_show_option(m, "workdir", ofs->config.workdir);
> > -       }
> > -       if (ofs->config.default_permissions)
> > -               seq_puts(m, ",default_permissions");
> > -       if (ofs->config.redirect_mode !=3D ovl_redirect_mode_def())
> > -               seq_printf(m, ",redirect_dir=3D%s",
> > -                          ovl_redirect_mode(&ofs->config));
> > -       if (ofs->config.index !=3D ovl_index_def)
> > -               seq_printf(m, ",index=3D%s", ofs->config.index ? "on" :=
 "off");
> > -       if (!ofs->config.uuid)
> > -               seq_puts(m, ",uuid=3Doff");
> > -       if (ofs->config.nfs_export !=3D ovl_nfs_export_def)
> > -               seq_printf(m, ",nfs_export=3D%s", ofs->config.nfs_expor=
t ?
> > -                                               "on" : "off");
> > -       if (ofs->config.xino !=3D ovl_xino_def() && !ovl_same_fs(ofs))
> > -               seq_printf(m, ",xino=3D%s", ovl_xino_mode(&ofs->config)=
);
> > -       if (ofs->config.metacopy !=3D ovl_metacopy_def)
> > -               seq_printf(m, ",metacopy=3D%s",
> > -                          ofs->config.metacopy ? "on" : "off");
> > -       if (ofs->config.ovl_volatile)
> > -               seq_puts(m, ",volatile");
> > -       if (ofs->config.userxattr)
> > -               seq_puts(m, ",userxattr");
> > -       return 0;
> > -}
> > -
> > -static int ovl_reconfigure(struct fs_context *fc)
> > -{
> > -       struct super_block *sb =3D fc->root->d_sb;
> > -       struct ovl_fs *ofs =3D sb->s_fs_info;
> > -       struct super_block *upper_sb;
> > -       int ret =3D 0;
> > -
> > -       if (!(fc->sb_flags & SB_RDONLY) && ovl_force_readonly(ofs))
> > -               return -EROFS;
> > -
> > -       if (fc->sb_flags & SB_RDONLY && !sb_rdonly(sb)) {
> > -               upper_sb =3D ovl_upper_mnt(ofs)->mnt_sb;
> > -               if (ovl_should_sync(ofs)) {
> > -                       down_read(&upper_sb->s_umount);
> > -                       ret =3D sync_filesystem(upper_sb);
> > -                       up_read(&upper_sb->s_umount);
> > -               }
> > -       }
> > -
> > -       return ret;
> > -}
> > -
> >  static const struct super_operations ovl_super_operations =3D {
> >         .alloc_inode    =3D ovl_alloc_inode,
> >         .free_inode     =3D ovl_free_inode,
> > @@ -450,262 +266,6 @@ static const struct super_operations ovl_super_op=
erations =3D {
> >         .show_options   =3D ovl_show_options,
> >  };
> >
> > -enum {
> > -       Opt_lowerdir,
> > -       Opt_upperdir,
> > -       Opt_workdir,
> > -       Opt_default_permissions,
> > -       Opt_redirect_dir,
> > -       Opt_index,
> > -       Opt_uuid,
> > -       Opt_nfs_export,
> > -       Opt_userxattr,
> > -       Opt_xino,
> > -       Opt_metacopy,
> > -       Opt_volatile,
> > -};
> > -
> > -static const struct constant_table ovl_parameter_bool[] =3D {
> > -       { "on",         true  },
> > -       { "off",        false },
> > -       {}
> > -};
> > -
> > -#define fsparam_string_empty(NAME, OPT) \
> > -       __fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty,=
 NULL)
> > -
> > -static const struct fs_parameter_spec ovl_parameter_spec[] =3D {
> > -       fsparam_string_empty("lowerdir",    Opt_lowerdir),
> > -       fsparam_string("upperdir",          Opt_upperdir),
> > -       fsparam_string("workdir",           Opt_workdir),
> > -       fsparam_flag("default_permissions", Opt_default_permissions),
> > -       fsparam_enum("redirect_dir",        Opt_redirect_dir, ovl_param=
eter_redirect_dir),
> > -       fsparam_enum("index",               Opt_index, ovl_parameter_bo=
ol),
> > -       fsparam_enum("uuid",                Opt_uuid, ovl_parameter_boo=
l),
> > -       fsparam_enum("nfs_export",          Opt_nfs_export, ovl_paramet=
er_bool),
> > -       fsparam_flag("userxattr",           Opt_userxattr),
> > -       fsparam_enum("xino",                Opt_xino, ovl_parameter_xin=
o),
> > -       fsparam_enum("metacopy",            Opt_metacopy, ovl_parameter=
_bool),
> > -       fsparam_flag("volatile",            Opt_volatile),
> > -       {}
> > -};
> > -
> > -static int ovl_parse_param(struct fs_context *fc, struct fs_parameter =
*param)
> > -{
> > -       int err =3D 0;
> > -       struct fs_parse_result result;
> > -       struct ovl_fs *ofs =3D fc->s_fs_info;
> > -       struct ovl_config *config =3D &ofs->config;
> > -       struct ovl_fs_context *ctx =3D fc->fs_private;
> > -       int opt;
> > -
> > -       if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
> > -               /*
> > -                * On remount overlayfs has always ignored all mount
> > -                * options no matter if malformed or not so for
> > -                * backwards compatibility we do the same here.
> > -                */
> > -               if (fc->oldapi)
> > -                       return 0;
> > -
> > -               /*
> > -                * Give us the freedom to allow changing mount options
> > -                * with the new mount api in the future. So instead of
> > -                * silently ignoring everything we report a proper
> > -                * error. This is only visible for users of the new
> > -                * mount api.
> > -                */
> > -               return invalfc(fc, "No changes allowed in reconfigure")=
;
> > -       }
> > -
> > -       opt =3D fs_parse(fc, ovl_parameter_spec, param, &result);
> > -       if (opt < 0)
> > -               return opt;
> > -
> > -       switch (opt) {
> > -       case Opt_lowerdir:
> > -               err =3D ovl_parse_param_lowerdir(param->string, fc);
> > -               break;
> > -       case Opt_upperdir:
> > -               fallthrough;
> > -       case Opt_workdir:
> > -               err =3D ovl_parse_param_upperdir(param->string, fc,
> > -                                              (Opt_workdir =3D=3D opt)=
);
> > -               break;
> > -       case Opt_default_permissions:
> > -               config->default_permissions =3D true;
> > -               break;
> > -       case Opt_redirect_dir:
> > -               config->redirect_mode =3D result.uint_32;
> > -               if (config->redirect_mode =3D=3D OVL_REDIRECT_OFF) {
> > -                       config->redirect_mode =3D ovl_redirect_always_f=
ollow ?
> > -                                               OVL_REDIRECT_FOLLOW :
> > -                                               OVL_REDIRECT_NOFOLLOW;
> > -               }
> > -               ctx->set.redirect =3D true;
> > -               break;
> > -       case Opt_index:
> > -               config->index =3D result.uint_32;
> > -               ctx->set.index =3D true;
> > -               break;
> > -       case Opt_uuid:
> > -               config->uuid =3D result.uint_32;
> > -               break;
> > -       case Opt_nfs_export:
> > -               config->nfs_export =3D result.uint_32;
> > -               ctx->set.nfs_export =3D true;
> > -               break;
> > -       case Opt_xino:
> > -               config->xino =3D result.uint_32;
> > -               break;
> > -       case Opt_metacopy:
> > -               config->metacopy =3D result.uint_32;
> > -               ctx->set.metacopy =3D true;
> > -               break;
> > -       case Opt_volatile:
> > -               config->ovl_volatile =3D true;
> > -               break;
> > -       case Opt_userxattr:
> > -               config->userxattr =3D true;
> > -               break;
> > -       default:
> > -               pr_err("unrecognized mount option \"%s\" or missing val=
ue\n",
> > -                      param->key);
> > -               return -EINVAL;
> > -       }
> > -
> > -       return err;
> > -}
> > -
> > -static int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
> > -                               struct ovl_config *config)
> > -{
> > -       struct ovl_opt_set set =3D ctx->set;
> > -
> > -       if (ctx->nr_data > 0 && !config->metacopy) {
> > -               pr_err("lower data-only dirs require metacopy support.\=
n");
> > -               return -EINVAL;
> > -       }
> > -
> > -       /* Workdir/index are useless in non-upper mount */
> > -       if (!config->upperdir) {
> > -               if (config->workdir) {
> > -                       pr_info("option \"workdir=3D%s\" is useless in =
a non-upper mount, ignore\n",
> > -                               config->workdir);
> > -                       kfree(config->workdir);
> > -                       config->workdir =3D NULL;
> > -               }
> > -               if (config->index && set.index) {
> > -                       pr_info("option \"index=3Don\" is useless in a =
non-upper mount, ignore\n");
> > -                       set.index =3D false;
> > -               }
> > -               config->index =3D false;
> > -       }
> > -
> > -       if (!config->upperdir && config->ovl_volatile) {
> > -               pr_info("option \"volatile\" is meaningless in a non-up=
per mount, ignoring it.\n");
> > -               config->ovl_volatile =3D false;
> > -       }
> > -
> > -       /*
> > -        * This is to make the logic below simpler.  It doesn't make an=
y other
> > -        * difference, since redirect_dir=3Don is only used for upper.
> > -        */
> > -       if (!config->upperdir && config->redirect_mode =3D=3D OVL_REDIR=
ECT_FOLLOW)
> > -               config->redirect_mode =3D OVL_REDIRECT_ON;
> > -
> > -       /* Resolve metacopy -> redirect_dir dependency */
> > -       if (config->metacopy && config->redirect_mode !=3D OVL_REDIRECT=
_ON) {
> > -               if (set.metacopy && set.redirect) {
> > -                       pr_err("conflicting options: metacopy=3Don,redi=
rect_dir=3D%s\n",
> > -                              ovl_redirect_mode(config));
> > -                       return -EINVAL;
> > -               }
> > -               if (set.redirect) {
> > -                       /*
> > -                        * There was an explicit redirect_dir=3D... tha=
t resulted
> > -                        * in this conflict.
> > -                        */
> > -                       pr_info("disabling metacopy due to redirect_dir=
=3D%s\n",
> > -                               ovl_redirect_mode(config));
> > -                       config->metacopy =3D false;
> > -               } else {
> > -                       /* Automatically enable redirect otherwise. */
> > -                       config->redirect_mode =3D OVL_REDIRECT_ON;
> > -               }
> > -       }
> > -
> > -       /* Resolve nfs_export -> index dependency */
> > -       if (config->nfs_export && !config->index) {
> > -               if (!config->upperdir &&
> > -                   config->redirect_mode !=3D OVL_REDIRECT_NOFOLLOW) {
> > -                       pr_info("NFS export requires \"redirect_dir=3Dn=
ofollow\" on non-upper mount, falling back to nfs_export=3Doff.\n");
> > -                       config->nfs_export =3D false;
> > -               } else if (set.nfs_export && set.index) {
> > -                       pr_err("conflicting options: nfs_export=3Don,in=
dex=3Doff\n");
> > -                       return -EINVAL;
> > -               } else if (set.index) {
> > -                       /*
> > -                        * There was an explicit index=3Doff that resul=
ted
> > -                        * in this conflict.
> > -                        */
> > -                       pr_info("disabling nfs_export due to index=3Dof=
f\n");
> > -                       config->nfs_export =3D false;
> > -               } else {
> > -                       /* Automatically enable index otherwise. */
> > -                       config->index =3D true;
> > -               }
> > -       }
> > -
> > -       /* Resolve nfs_export -> !metacopy dependency */
> > -       if (config->nfs_export && config->metacopy) {
> > -               if (set.nfs_export && set.metacopy) {
> > -                       pr_err("conflicting options: nfs_export=3Don,me=
tacopy=3Don\n");
> > -                       return -EINVAL;
> > -               }
> > -               if (set.metacopy) {
> > -                       /*
> > -                        * There was an explicit metacopy=3Don that res=
ulted
> > -                        * in this conflict.
> > -                        */
> > -                       pr_info("disabling nfs_export due to metacopy=
=3Don\n");
> > -                       config->nfs_export =3D false;
> > -               } else {
> > -                       /*
> > -                        * There was an explicit nfs_export=3Don that r=
esulted
> > -                        * in this conflict.
> > -                        */
> > -                       pr_info("disabling metacopy due to nfs_export=
=3Don\n");
> > -                       config->metacopy =3D false;
> > -               }
> > -       }
> > -
> > -
> > -       /* Resolve userxattr -> !redirect && !metacopy dependency */
> > -       if (config->userxattr) {
> > -               if (set.redirect &&
> > -                   config->redirect_mode !=3D OVL_REDIRECT_NOFOLLOW) {
> > -                       pr_err("conflicting options: userxattr,redirect=
_dir=3D%s\n",
> > -                              ovl_redirect_mode(config));
> > -                       return -EINVAL;
> > -               }
> > -               if (config->metacopy && set.metacopy) {
> > -                       pr_err("conflicting options: userxattr,metacopy=
=3Don\n");
> > -                       return -EINVAL;
> > -               }
> > -               /*
> > -                * Silently disable default setting of redirect and met=
acopy.
> > -                * This shall be the default in the future as well: the=
se
> > -                * options must be explicitly enabled if used together =
with
> > -                * userxattr.
> > -                */
> > -               config->redirect_mode =3D OVL_REDIRECT_NOFOLLOW;
> > -               config->metacopy =3D false;
> > -       }
> > -
> > -       return 0;
> > -}
> > -
> >  #define OVL_WORKDIR_NAME "work"
> >  #define OVL_INDEXDIR_NAME "index"
> >
> > @@ -1758,7 +1318,7 @@ static struct dentry *ovl_get_root(struct super_b=
lock *sb,
> >         return root;
> >  }
> >
> > -static int ovl_fill_super(struct super_block *sb, struct fs_context *f=
c)
> > +int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
> >  {
> >         struct ovl_fs *ofs =3D sb->s_fs_info;
> >         struct ovl_fs_context *ctx =3D fc->fs_private;
> > @@ -1919,92 +1479,6 @@ static int ovl_fill_super(struct super_block *sb=
, struct fs_context *fc)
> >         return err;
> >  }
> >
> > -static int ovl_get_tree(struct fs_context *fc)
> > -{
> > -       return get_tree_nodev(fc, ovl_fill_super);
> > -}
> > -
> > -static inline void ovl_fs_context_free(struct ovl_fs_context *ctx)
> > -{
> > -       ovl_parse_param_drop_lowerdir(ctx);
> > -       path_put(&ctx->upper);
> > -       path_put(&ctx->work);
> > -       kfree(ctx->lower);
> > -       kfree(ctx);
> > -}
> > -
> > -static void ovl_free(struct fs_context *fc)
> > -{
> > -       struct ovl_fs *ofs =3D fc->s_fs_info;
> > -       struct ovl_fs_context *ctx =3D fc->fs_private;
> > -
> > -       /*
> > -        * ofs is stored in the fs_context when it is initialized.
> > -        * ofs is transferred to the superblock on a successful mount,
> > -        * but if an error occurs before the transfer we have to free
> > -        * it here.
> > -        */
> > -       if (ofs)
> > -               ovl_free_fs(ofs);
> > -
> > -       if (ctx)
> > -               ovl_fs_context_free(ctx);
> > -}
> > -
> > -static const struct fs_context_operations ovl_context_ops =3D {
> > -       .parse_param =3D ovl_parse_param,
> > -       .get_tree    =3D ovl_get_tree,
> > -       .reconfigure =3D ovl_reconfigure,
> > -       .free        =3D ovl_free,
> > -};
> > -
> > -/*
> > - * This is called during fsopen() and will record the user namespace o=
f
> > - * the caller in fc->user_ns since we've raised FS_USERNS_MOUNT. We'll
> > - * need it when we actually create the superblock to verify that the
> > - * process creating the superblock is in the same user namespace as
> > - * process that called fsopen().
> > - */
> > -static int ovl_init_fs_context(struct fs_context *fc)
> > -{
> > -       struct ovl_fs_context *ctx;
> > -       struct ovl_fs *ofs;
> > -
> > -       ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
> > -       if (!ctx)
> > -               return -ENOMEM;
> > -
> > -       /*
> > -        * By default we allocate for three lower layers. It's likely
> > -        * that it'll cover most users.
> > -        */
> > -       ctx->lower =3D kmalloc_array(3, sizeof(*ctx->lower), GFP_KERNEL=
_ACCOUNT);
> > -       if (!ctx->lower)
> > -               goto out_err;
> > -       ctx->capacity =3D 3;
> > -
> > -       ofs =3D kzalloc(sizeof(struct ovl_fs), GFP_KERNEL);
> > -       if (!ofs)
> > -               goto out_err;
> > -
> > -       ofs->config.redirect_mode =3D ovl_redirect_mode_def();
> > -       ofs->config.index       =3D ovl_index_def;
> > -       ofs->config.uuid        =3D true;
> > -       ofs->config.nfs_export  =3D ovl_nfs_export_def;
> > -       ofs->config.xino        =3D ovl_xino_def();
> > -       ofs->config.metacopy    =3D ovl_metacopy_def;
> > -
> > -       fc->s_fs_info           =3D ofs;
> > -       fc->fs_private          =3D ctx;
> > -       fc->ops                 =3D &ovl_context_ops;
> > -       return 0;
> > -
> > -out_err:
> > -       ovl_fs_context_free(ctx);
> > -       return -ENOMEM;
> > -
> > -}
> > -
> >  static struct file_system_type ovl_fs_type =3D {
> >         .owner                  =3D THIS_MODULE,
> >         .name                   =3D "overlay",
> >
> > ---
> > base-commit: 62149a745eee03194f025021640c80b84353089b
> > change-id: 20230625-fs-overlayfs-mount-api-param-993d1caa86ff
> >
>


--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

