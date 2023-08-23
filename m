Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22DC785D4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 18:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbjHWQab (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 12:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237195AbjHWQaa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:30:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC67E78;
        Wed, 23 Aug 2023 09:30:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E844665C9;
        Wed, 23 Aug 2023 16:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BD7C433CA;
        Wed, 23 Aug 2023 16:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692808226;
        bh=JbHQzMfTju097ssW3eXYCC3joHrbhFisQqAAa3GjgPQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iZgvOdQmburvEeZjI/G2qqd7/g3Y+YyiSbRWxalCSBCTp/K1w/ZlKE2nabVSPF/lF
         5gbpIc8l1RLlprMovInmBUFC/GY6HTJuEv512HM+OdD25EoJgWIpPppAykx6eL0SyD
         NysNQ6d+TjFroMa7YHlvFzYJ7DyONJGfwxKce8EGYLXJp9ahx66jTfNU+Pt6LnR7Ed
         NaN1AUCsa5LeZYyggKg/WbCk9dOsiP1RAjz3j9L6JXeQFkA9OERjIE3RweMZahdjo7
         z10JRziPqHRYPi658t2GFXWTKuN1dDe8NKBCcRxBLI8AMqlX3KT+6T9B5A64C7F5r0
         o7GeWIi+5uNpQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50043cf2e29so6453366e87.2;
        Wed, 23 Aug 2023 09:30:26 -0700 (PDT)
X-Gm-Message-State: AOJu0YziSiFQl/RnH0NKnImxeJJ7ZdEFPAmysY19Koww6f6iBvFgZZS8
        TBysHwgyhWtj58O0A9XmY/Uxw6Ynz1w25AmUZEw=
X-Google-Smtp-Source: AGHT+IFFbjR680KqVm45CX2LAjjEgqrOHfUpdg/o4e4Hpzj4iDJ29K0NsYIVM20gtTbjwb4xhUXulysYKsK7xSGQeQw=
X-Received: by 2002:a05:6512:4026:b0:4ff:80d4:e132 with SMTP id
 br38-20020a056512402600b004ff80d4e132mr11276839lfb.29.1692808224007; Wed, 23
 Aug 2023 09:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230822162350.1.I96423a31e88428004c2f4a28ccad13828adf433e@changeid>
In-Reply-To: <20230822162350.1.I96423a31e88428004c2f4a28ccad13828adf433e@changeid>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 23 Aug 2023 18:30:12 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHkrRvUbzdNg7WGmBPFW8MtnhEsSy1FOk4GZzVZ1H4fTw@mail.gmail.com>
Message-ID: <CAMj1kXHkrRvUbzdNg7WGmBPFW8MtnhEsSy1FOk4GZzVZ1H4fTw@mail.gmail.com>
Subject: Re: [PATCH] kernel: Add Mount Option For Efivarfs
To:     Jiao Zhou <jiaozhou@google.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(cc Peter and Matthew)

On Tue, 22 Aug 2023 at 18:24, Jiao Zhou <jiaozhou@google.com> wrote:
>
> Add uid and gid in efivarfs's mount option, so that
> we can mount the file system with ownership. This approach
> is used by a number of other filesystems that don't have
> native support for ownership
>
> Signed-off-by: Jiao Zhou <jiaozhou@google.com>
> ---
>
>  fs/efivarfs/inode.c    |  4 ++++
>  fs/efivarfs/internal.h |  9 +++++++
>  fs/efivarfs/super.c    | 54 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 67 insertions(+)
>
> diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
> index b973a2c03dde..86175e229b0f 100644
> --- a/fs/efivarfs/inode.c
> +++ b/fs/efivarfs/inode.c
> @@ -20,9 +20,13 @@ struct inode *efivarfs_get_inode(struct super_block *sb,
>                                 const struct inode *dir, int mode,
>                                 dev_t dev, bool is_removable)
>  {
> +       struct efivarfs_fs_info *fsi = sb->s_fs_info;
>         struct inode *inode = new_inode(sb);
> +       struct efivarfs_mount_opts *opts = &fsi->mount_opts;
>
>         if (inode) {
> +               inode->i_uid = opts->uid;
> +               inode->i_gid = opts->gid;
>                 inode->i_ino = get_next_ino();
>                 inode->i_mode = mode;
>                 inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
> index 8ebf3a6a8aa2..2c7b6b24df19 100644
> --- a/fs/efivarfs/internal.h
> +++ b/fs/efivarfs/internal.h
> @@ -48,6 +48,15 @@ bool efivar_validate(efi_guid_t vendor, efi_char16_t *var_name, u8 *data,
>  bool efivar_variable_is_removable(efi_guid_t vendor, const char *name,
>                                   size_t len);
>
> +struct efivarfs_mount_opts {
> +       kuid_t uid;
> +       kgid_t gid;
> +};
> +
> +struct efivarfs_fs_info {
> +       struct efivarfs_mount_opts mount_opts;
> +};
> +
>  extern const struct file_operations efivarfs_file_operations;
>  extern const struct inode_operations efivarfs_dir_inode_operations;
>  extern bool efivarfs_valid_name(const char *str, int len);
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index e028fafa04f3..e3c81fac8208 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -8,6 +8,7 @@
>  #include <linux/efi.h>
>  #include <linux/fs.h>
>  #include <linux/fs_context.h>
> +#include <linux/fs_parser.h>
>  #include <linux/module.h>
>  #include <linux/pagemap.h>
>  #include <linux/ucs2_string.h>
> @@ -60,10 +61,27 @@ static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>
>         return 0;
>  }
> +static int efivarfs_show_options(struct seq_file *m, struct dentry *root)
> +{
> +       struct super_block *sb = root->d_sb;
> +       struct efivarfs_fs_info *sbi = sb->s_fs_info;
> +       struct efivarfs_mount_opts *opts = &sbi->mount_opts;
> +
> +       /* Show partition info */
> +       if (!uid_eq(opts->uid, GLOBAL_ROOT_UID))
> +               seq_printf(m, ",uid=%u",
> +                               from_kuid_munged(&init_user_ns, opts->uid));
> +       if (!gid_eq(opts->gid, GLOBAL_ROOT_GID))
> +               seq_printf(m, ",gid=%u",
> +                               from_kgid_munged(&init_user_ns, opts->gid));
> +       return 0;
> +}
> +
>  static const struct super_operations efivarfs_ops = {
>         .statfs = efivarfs_statfs,
>         .drop_inode = generic_delete_inode,
>         .evict_inode = efivarfs_evict_inode,
> +       .show_options   = efivarfs_show_options,
>  };
>
>  /*
> @@ -225,6 +243,40 @@ static int efivarfs_destroy(struct efivar_entry *entry, void *data)
>         return 0;
>  }
>
> +enum {
> +       Opt_uid, Opt_gid,
> +};
> +
> +static const struct fs_parameter_spec efivarfs_parameters[] = {
> +       fsparam_u32("uid",                      Opt_uid),
> +       fsparam_u32("gid",                      Opt_gid),
> +};
> +
> +static int efivarfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
> +{
> +       struct efivarfs_fs_info *sbi = fc->s_fs_info;
> +       struct efivarfs_mount_opts *opts = &sbi->mount_opts;
> +       struct fs_parse_result result;
> +       int opt;
> +
> +       opt = fs_parse(fc, efivarfs_parameters, param, &result);
> +       if (opt < 0)
> +               return opt;
> +
> +       switch (opt) {
> +       case Opt_uid:
> +               opts->uid = make_kuid(current_user_ns(), result.uint_32);
> +               break;
> +       case Opt_gid:
> +               opts->gid = make_kgid(current_user_ns(), result.uint_32);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>         struct inode *inode = NULL;
> @@ -271,6 +323,7 @@ static int efivarfs_get_tree(struct fs_context *fc)
>
>  static const struct fs_context_operations efivarfs_context_ops = {
>         .get_tree       = efivarfs_get_tree,
> +       .parse_param    = efivarfs_parse_param,
>  };
>
>  static int efivarfs_init_fs_context(struct fs_context *fc)
> @@ -295,6 +348,7 @@ static struct file_system_type efivarfs_type = {
>         .name    = "efivarfs",
>         .init_fs_context = efivarfs_init_fs_context,
>         .kill_sb = efivarfs_kill_sb,
> +       .parameters             = efivarfs_parameters,
>  };
>
>  static __init int efivarfs_init(void)
> --
> 2.42.0.rc1.204.g551eb34607-goog
>
