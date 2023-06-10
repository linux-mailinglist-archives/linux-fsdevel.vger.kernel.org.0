Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA2872A9C7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jun 2023 09:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjFJHPz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jun 2023 03:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjFJHPy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jun 2023 03:15:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15898AC;
        Sat, 10 Jun 2023 00:15:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9552A6337F;
        Sat, 10 Jun 2023 07:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DABC433D2;
        Sat, 10 Jun 2023 07:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686381352;
        bh=ef7dLTT9xeoe6YBt2R0Le59aUg2fGPrF+/zfGXQE2c4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NNEfT2pLT4amVaFG1QagnLmAvV1BVM7mlOBNZLMbY7YjjYuR2XLCeWJjvhxizkC2Z
         4joOmTraVS0lUH0GPIJKWhOCra0p2dFcNPrjYcQ3+wUD1MIHVweHo4dPOECy/4ZT27
         0w0rG0wz4MfwblnQSv7b6QLXjnwL2Zs5IPML/B0MB/Lh96DXOpCb/j1uJzcSq0Bymn
         nNjPf+MlqL8OGHfqAm4II2G4iIG2Aez6ibRMWmhSO3/icsBbqRpB1pLcPjF3ud9ctX
         9/h1VkiqC3b9jHLkT/+u8bEx6ZCqRzz4LuuSo1D1+A+OnDvguYl3mMny0qMEg2qDEB
         DEpJ+5B5r3BlQ==
Date:   Sat, 10 Jun 2023 09:15:48 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ovl: port to new mount api
Message-ID: <20230610-erbitten-umlaufen-a39b08256e1a@brauner>
References: <20230605-fs-overlayfs-mount_api-v2-0-3da91c97e0c0@kernel.org>
 <20230605-fs-overlayfs-mount_api-v2-1-3da91c97e0c0@kernel.org>
 <CAOQ4uxge44J1SCF6YiscchB0SjfcqPXf8wQfNuVBfCh6dU5rXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxge44J1SCF6YiscchB0SjfcqPXf8wQfNuVBfCh6dU5rXA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 09, 2023 at 10:25:21PM +0300, Amir Goldstein wrote:
> On Fri, Jun 9, 2023 at 6:42 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > We recently ported util-linux to the new mount api. Now the mount(8)
> > tool will by default use the new mount api. While trying hard to fall
> > back to the old mount api gracefully there are still cases where we run
> > into issues that are difficult to handle nicely.
> >
> > Now with mount(8) and libmount supporting the new mount api I expect an
> > increase in the number of bug reports and issues we're going to see with
> > filesystems that don't yet support the new mount api. So it's time we
> > rectify this.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/overlayfs/super.c | 515 ++++++++++++++++++++++++++++-----------------------
> >  1 file changed, 279 insertions(+), 236 deletions(-)
> >
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index f97ad8b40dbb..ceaf05743f45 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -16,6 +16,8 @@
> >  #include <linux/posix_acl_xattr.h>
> >  #include <linux/exportfs.h>
> >  #include <linux/file.h>
> > +#include <linux/fs_context.h>
> > +#include <linux/fs_parser.h>
> >  #include "overlayfs.h"
> >
> >  MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
> > @@ -67,6 +69,59 @@ module_param_named(metacopy, ovl_metacopy_def, bool, 0644);
> >  MODULE_PARM_DESC(metacopy,
> >                  "Default to on or off for the metadata only copy up feature");
> >
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
> > +static const struct constant_table ovl_parameter_bool[] = {
> > +       { "on",         true  },
> > +       { "off",        false },
> > +       {}
> > +};
> > +
> > +static const struct constant_table ovl_parameter_xino[] = {
> > +       { "on",         OVL_XINO_ON   },
> > +       { "off",        OVL_XINO_OFF  },
> > +       { "auto",       OVL_XINO_AUTO },
> > +       {}
> > +};
> > +
> > +static const struct fs_parameter_spec ovl_parameter_spec[] = {
> > +       fsparam_string("lowerdir",          Opt_lowerdir),
> > +       fsparam_string("upperdir",          Opt_upperdir),
> > +       fsparam_string("workdir",           Opt_workdir),
> > +       fsparam_flag("default_permissions", Opt_default_permissions),
> > +       fsparam_enum("redirect_dir",        Opt_redirect_dir, ovl_parameter_bool),
> > +       fsparam_enum("index",               Opt_index, ovl_parameter_bool),
> > +       fsparam_enum("uuid",                Opt_uuid, ovl_parameter_bool),
> > +       fsparam_enum("nfs_export",          Opt_nfs_export, ovl_parameter_bool),
> > +       fsparam_flag("userxattr",           Opt_userxattr),
> > +       fsparam_enum("xino",                Opt_xino, ovl_parameter_xino),
> > +       fsparam_enum("metacopy",            Opt_metacopy, ovl_parameter_bool),
> > +       fsparam_flag("volatile",            Opt_volatile),
> > +       {}
> > +};
> > +
> > +#define OVL_METACOPY_SET       BIT(0)
> > +#define OVL_REDIRECT_SET       BIT(1)
> > +#define OVL_NFS_EXPORT_SET     BIT(2)
> > +#define OVL_INDEX_SET          BIT(3)
> > +
> > +struct ovl_fs_context {
> > +       u8 set;
> > +};
> > +
> >  static void ovl_dentry_release(struct dentry *dentry)
> >  {
> >         struct ovl_entry *oe = dentry->d_fsdata;
> > @@ -394,27 +449,6 @@ static int ovl_show_options(struct seq_file *m, struct dentry *dentry)
> >         return 0;
> >  }
> >
> > -static int ovl_remount(struct super_block *sb, int *flags, char *data)
> > -{
> > -       struct ovl_fs *ofs = sb->s_fs_info;
> > -       struct super_block *upper_sb;
> > -       int ret = 0;
> > -
> > -       if (!(*flags & SB_RDONLY) && ovl_force_readonly(ofs))
> > -               return -EROFS;
> > -
> > -       if (*flags & SB_RDONLY && !sb_rdonly(sb)) {
> > -               upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
> > -               if (ovl_should_sync(ofs)) {
> > -                       down_read(&upper_sb->s_umount);
> > -                       ret = sync_filesystem(upper_sb);
> > -                       up_read(&upper_sb->s_umount);
> > -               }
> > -       }
> > -
> > -       return ret;
> > -}
> > -
> >  static const struct super_operations ovl_super_operations = {
> >         .alloc_inode    = ovl_alloc_inode,
> >         .free_inode     = ovl_free_inode,
> > @@ -424,76 +458,8 @@ static const struct super_operations ovl_super_operations = {
> >         .sync_fs        = ovl_sync_fs,
> >         .statfs         = ovl_statfs,
> >         .show_options   = ovl_show_options,
> > -       .remount_fs     = ovl_remount,
> > -};
> > -
> > -enum {
> > -       OPT_LOWERDIR,
> > -       OPT_UPPERDIR,
> > -       OPT_WORKDIR,
> > -       OPT_DEFAULT_PERMISSIONS,
> > -       OPT_REDIRECT_DIR,
> > -       OPT_INDEX_ON,
> > -       OPT_INDEX_OFF,
> > -       OPT_UUID_ON,
> > -       OPT_UUID_OFF,
> > -       OPT_NFS_EXPORT_ON,
> > -       OPT_USERXATTR,
> > -       OPT_NFS_EXPORT_OFF,
> > -       OPT_XINO_ON,
> > -       OPT_XINO_OFF,
> > -       OPT_XINO_AUTO,
> > -       OPT_METACOPY_ON,
> > -       OPT_METACOPY_OFF,
> > -       OPT_VOLATILE,
> > -       OPT_ERR,
> > -};
> > -
> > -static const match_table_t ovl_tokens = {
> > -       {OPT_LOWERDIR,                  "lowerdir=%s"},
> > -       {OPT_UPPERDIR,                  "upperdir=%s"},
> > -       {OPT_WORKDIR,                   "workdir=%s"},
> > -       {OPT_DEFAULT_PERMISSIONS,       "default_permissions"},
> > -       {OPT_REDIRECT_DIR,              "redirect_dir=%s"},
> > -       {OPT_INDEX_ON,                  "index=on"},
> > -       {OPT_INDEX_OFF,                 "index=off"},
> > -       {OPT_USERXATTR,                 "userxattr"},
> > -       {OPT_UUID_ON,                   "uuid=on"},
> > -       {OPT_UUID_OFF,                  "uuid=off"},
> > -       {OPT_NFS_EXPORT_ON,             "nfs_export=on"},
> > -       {OPT_NFS_EXPORT_OFF,            "nfs_export=off"},
> > -       {OPT_XINO_ON,                   "xino=on"},
> > -       {OPT_XINO_OFF,                  "xino=off"},
> > -       {OPT_XINO_AUTO,                 "xino=auto"},
> > -       {OPT_METACOPY_ON,               "metacopy=on"},
> > -       {OPT_METACOPY_OFF,              "metacopy=off"},
> > -       {OPT_VOLATILE,                  "volatile"},
> > -       {OPT_ERR,                       NULL}
> >  };
> >
> > -static char *ovl_next_opt(char **s)
> > -{
> > -       char *sbegin = *s;
> > -       char *p;
> > -
> > -       if (sbegin == NULL)
> > -               return NULL;
> > -
> > -       for (p = sbegin; *p; p++) {
> > -               if (*p == '\\') {
> > -                       p++;
> > -                       if (!*p)
> > -                               break;
> > -               } else if (*p == ',') {
> > -                       *p = '\0';
> > -                       *s = p + 1;
> > -                       return sbegin;
> > -               }
> > -       }
> > -       *s = NULL;
> > -       return sbegin;
> > -}
> > -
> >  static int ovl_parse_redirect_mode(struct ovl_config *config, const char *mode)
> >  {
> >         if (strcmp(mode, "on") == 0) {
> > @@ -517,123 +483,14 @@ static int ovl_parse_redirect_mode(struct ovl_config *config, const char *mode)
> >         return 0;
> >  }
> >
> > -static int ovl_parse_opt(char *opt, struct ovl_config *config)
> > +static int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
> > +                               struct ovl_config *config)
> >  {
> > -       char *p;
> >         int err;
> > -       bool metacopy_opt = false, redirect_opt = false;
> > -       bool nfs_export_opt = false, index_opt = false;
> > -
> > -       config->redirect_mode = kstrdup(ovl_redirect_mode_def(), GFP_KERNEL);
> > -       if (!config->redirect_mode)
> > -               return -ENOMEM;
> > -
> > -       while ((p = ovl_next_opt(&opt)) != NULL) {
> > -               int token;
> > -               substring_t args[MAX_OPT_ARGS];
> > -
> > -               if (!*p)
> > -                       continue;
> > -
> > -               token = match_token(p, ovl_tokens, args);
> > -               switch (token) {
> > -               case OPT_UPPERDIR:
> > -                       kfree(config->upperdir);
> > -                       config->upperdir = match_strdup(&args[0]);
> > -                       if (!config->upperdir)
> > -                               return -ENOMEM;
> > -                       break;
> > -
> > -               case OPT_LOWERDIR:
> > -                       kfree(config->lowerdir);
> > -                       config->lowerdir = match_strdup(&args[0]);
> > -                       if (!config->lowerdir)
> > -                               return -ENOMEM;
> > -                       break;
> > -
> > -               case OPT_WORKDIR:
> > -                       kfree(config->workdir);
> > -                       config->workdir = match_strdup(&args[0]);
> > -                       if (!config->workdir)
> > -                               return -ENOMEM;
> > -                       break;
> > -
> > -               case OPT_DEFAULT_PERMISSIONS:
> > -                       config->default_permissions = true;
> > -                       break;
> > -
> > -               case OPT_REDIRECT_DIR:
> > -                       kfree(config->redirect_mode);
> > -                       config->redirect_mode = match_strdup(&args[0]);
> > -                       if (!config->redirect_mode)
> > -                               return -ENOMEM;
> > -                       redirect_opt = true;
> > -                       break;
> > -
> > -               case OPT_INDEX_ON:
> > -                       config->index = true;
> > -                       index_opt = true;
> > -                       break;
> > -
> > -               case OPT_INDEX_OFF:
> > -                       config->index = false;
> > -                       index_opt = true;
> > -                       break;
> > -
> > -               case OPT_UUID_ON:
> > -                       config->uuid = true;
> > -                       break;
> > -
> > -               case OPT_UUID_OFF:
> > -                       config->uuid = false;
> > -                       break;
> > -
> > -               case OPT_NFS_EXPORT_ON:
> > -                       config->nfs_export = true;
> > -                       nfs_export_opt = true;
> > -                       break;
> > -
> > -               case OPT_NFS_EXPORT_OFF:
> > -                       config->nfs_export = false;
> > -                       nfs_export_opt = true;
> > -                       break;
> > -
> > -               case OPT_XINO_ON:
> > -                       config->xino = OVL_XINO_ON;
> > -                       break;
> > -
> > -               case OPT_XINO_OFF:
> > -                       config->xino = OVL_XINO_OFF;
> > -                       break;
> > -
> > -               case OPT_XINO_AUTO:
> > -                       config->xino = OVL_XINO_AUTO;
> > -                       break;
> > -
> > -               case OPT_METACOPY_ON:
> > -                       config->metacopy = true;
> > -                       metacopy_opt = true;
> > -                       break;
> > -
> > -               case OPT_METACOPY_OFF:
> > -                       config->metacopy = false;
> > -                       metacopy_opt = true;
> > -                       break;
> > -
> > -               case OPT_VOLATILE:
> > -                       config->ovl_volatile = true;
> > -                       break;
> > -
> > -               case OPT_USERXATTR:
> > -                       config->userxattr = true;
> > -                       break;
> > -
> > -               default:
> > -                       pr_err("unrecognized mount option \"%s\" or missing value\n",
> > -                                       p);
> > -                       return -EINVAL;
> > -               }
> > -       }
> > +       bool metacopy_opt = ctx->set & OVL_METACOPY_SET,
> > +            redirect_opt = ctx->set & OVL_REDIRECT_SET;
> > +       bool nfs_export_opt = ctx->set & OVL_NFS_EXPORT_SET,
> > +            index_opt = ctx->set & OVL_INDEX_SET;
> 
> Nit: please split lines here.
> 
> >
> >         /* Workdir/index are useless in non-upper mount */
> >         if (!config->upperdir) {
> > @@ -1882,12 +1739,143 @@ static struct dentry *ovl_get_root(struct super_block *sb,
> >         return root;
> >  }
> >
> > -static int ovl_fill_super(struct super_block *sb, void *data, int silent)
> > +static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
> >  {
> > -       struct path upperpath = { };
> > +       int err = 0;
> > +       struct fs_parse_result result;
> > +       struct ovl_fs *ofs = fc->s_fs_info;
> > +       struct ovl_config *config = &ofs->config;
> > +       struct ovl_fs_context *ctx = fc->fs_private;
> > +       struct path path;
> > +       char *dup;
> > +       int opt;
> > +       char *sval;
> > +
> > +       /*
> > +        * On remount overlayfs has always ignored all mount options no
> > +        * matter if malformed or not so for backwards compatibility we
> > +        * do the same here.
> > +        */
> > +       if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
> > +               return 0;
> > +
> > +       opt = fs_parse(fc, ovl_parameter_spec, param, &result);
> > +       if (opt < 0)
> > +               return opt;
> > +
> > +       switch (opt) {
> > +       case Opt_lowerdir:
> > +               dup = kstrdup(param->string, GFP_KERNEL);
> > +               if (!dup) {
> > +                       path_put(&path);
> > +                       err = -ENOMEM;
> > +                       break;
> > +               }
> > +
> > +               kfree(config->lowerdir);
> > +               config->lowerdir = dup;
> > +               break;
> > +       case Opt_upperdir:
> > +               dup = kstrdup(param->string, GFP_KERNEL);
> > +               if (!dup) {
> > +                       path_put(&path);
> > +                       err = -ENOMEM;
> > +                       break;
> > +               }
> > +
> > +               kfree(config->upperdir);
> > +               config->upperdir = dup;
> > +               break;
> > +       case Opt_workdir:
> > +               dup = kstrdup(param->string, GFP_KERNEL);
> > +               if (!dup) {
> > +                       path_put(&path);
> > +                       err = -ENOMEM;
> > +                       break;
> > +               }
> > +
> > +               kfree(config->workdir);
> > +               config->workdir = dup;
> > +               break;
> > +       case Opt_default_permissions:
> > +               config->default_permissions = true;
> > +               break;
> > +       case Opt_index:
> > +               config->index = result.uint_32;
> > +               ctx->set |= OVL_INDEX_SET;
> > +               break;
> > +       case Opt_uuid:
> > +               config->uuid = result.uint_32;
> > +               break;
> > +       case Opt_nfs_export:
> > +               config->nfs_export = result.uint_32;
> > +               ctx->set |= OVL_NFS_EXPORT_SET;
> > +               break;
> > +       case Opt_metacopy:
> > +               config->metacopy = result.uint_32;
> > +               ctx->set |= OVL_METACOPY_SET;
> > +               break;
> > +       case Opt_userxattr:
> > +               config->userxattr = true;
> > +               break;
> > +       case Opt_volatile:
> > +               config->ovl_volatile = true;
> > +               break;
> > +       case Opt_xino:
> > +               config->xino = result.uint_32;
> > +               break;
> > +       case Opt_redirect_dir:
> > +               if (result.uint_32 == true)
> > +                       sval = kstrdup("on", GFP_KERNEL);
> > +               else
> > +                       sval = kstrdup("off", GFP_KERNEL);
> > +               if (!sval) {
> > +                       err = -ENOMEM;
> > +                       break;
> > +               }
> > +
> > +               kfree(config->redirect_mode);
> > +               config->redirect_mode = sval;
> > +               ctx->set |= OVL_REDIRECT_SET;
> > +               break;
> > +       default:
> > +               pr_err("unrecognized mount option \"%s\" or missing value\n", param->key);
> > +               return -EINVAL;
> > +       }
> > +
> > +       return err;
> > +}
> 
> 
> For the end result, all these functions above should be in params.c
> I don't mind if you move it with an extra patch at the beginning
> Probably easier at the end. Just as long as you do not move
> ovl_fs_params_verify() in the same patch that changes half of it.

Ok.
