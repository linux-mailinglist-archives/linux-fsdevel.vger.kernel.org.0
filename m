Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3069B797B54
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 20:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245199AbjIGSMd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 14:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240530AbjIGSMa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:12:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44664E57;
        Thu,  7 Sep 2023 11:12:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6100CC4AF1E;
        Thu,  7 Sep 2023 16:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694105745;
        bh=otjLzPS6OdYIAAXvkB5yaashitUxiajsQdkwSAtN6t4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PIa8yCNoCOEXDYywjCytcOpNsamNg8kipPXxhINQtaLx3Oj7XvaofQsYE7njU1HnE
         RErGp2KFkf/ViYgnYePngIcBtd9lJnq4PKuADsKqeT1k3SBgZ2/IXr+f+6ddGznpJ2
         Tf/jxHIkxrq11xtnQHwiDtimvHVmzpH1xpNuZ8xvyjSR3219ki2lhkcW2GrAbVw870
         w6Z12PN8cVU/C8cJcPGHFy8rWe46KkmqedCkSNSRKI9Ybi8ZKU/QcvxeQKiN8YLznU
         QqAgWPrQbPJQb/USTP2LZV9w2UPEAz6tqBPH1ND8ZCEFogVIqHkWEIkzPf5SrHj8Qn
         1MH8HKsm+mGJg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-500760b296aso1414187e87.0;
        Thu, 07 Sep 2023 09:55:45 -0700 (PDT)
X-Gm-Message-State: AOJu0YwHayib5q81n5Hq4TtGkssl3bSnSf3xEznR/7+1DwOGC9vn/s3/
        zJjaj1rCrD/k6S5gUgPkmy+/Y5R3rznbtd6ncr4=
X-Google-Smtp-Source: AGHT+IFXU7YT9c586a+MNvCwcDGKovS/Im1kIv7Xrv7B8U5nC4X1RMSMNKvUQJG00FQWf0/W8tIkzKVUEft+IkrsFws=
X-Received: by 2002:a05:6512:3d8e:b0:4fe:8be:6065 with SMTP id
 k14-20020a0565123d8e00b004fe08be6065mr3623lfv.5.1694105743323; Thu, 07 Sep
 2023 09:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230907164341.1051637-1-jiaozhou@google.com>
In-Reply-To: <20230907164341.1051637-1-jiaozhou@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 7 Sep 2023 18:55:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHC9PR1EhPYnYqqvh0TLY56NK-vhHeJKjLNGoKi-AZyXw@mail.gmail.com>
Message-ID: <CAMj1kXHC9PR1EhPYnYqqvh0TLY56NK-vhHeJKjLNGoKi-AZyXw@mail.gmail.com>
Subject: Re: [PATCH v4] efivarfs: Add uid/gid mount options
To:     Jiao Zhou <jiaozhou@google.com>
Cc:     Linux FS Development <linux-fsdevel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org,
        Matthew Garrett <mgarrett@aurora.tech>,
        Christian Brauner <brauner@kernel.org>
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

(cc Christian)

Hi,

On Thu, 7 Sept 2023 at 18:43, Jiao Zhou <jiaozhou@google.com> wrote:
>
> Allow UEFI variables to be modified by non-root processes
> in order to run sandboxed code. This doesn't change the behavior
> of mounting efivarfs unless uid/gid are specified;
> by default both are set to root.
>
> Signed-off-by: Jiao Zhou <jiaozhou@google.com>
> Acked-by: Matthew Garrett <mgarrett@aurora.tech>
> ---
> Changelog since v1:
> - Add missing sentinel entry in fs_parameter_spec[] array.
> - Fix a NULL pointer dereference.
>
> Changelog since v2:
> - Format the patch description.
>
> Changelog since v3:
> - Use sizeof(*sfi) to allocate memory to avoids future problems if sfi ever changes type.
> - Add gid and uid check to make sure that ids are valid.
> - Drop the indentation for one block.
>
>  fs/efivarfs/inode.c    |  4 +++
>  fs/efivarfs/internal.h |  9 +++++
>  fs/efivarfs/super.c    | 75 ++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 85 insertions(+), 3 deletions(-)
>

The commit log looks fine now - thanks for taking the time to dive
into the docs.


> diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
> index db9231f0e77b..06dfc73fda04 100644
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
>                 inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
> diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
> index 8ebf3a6a8aa2..c66647f5c0bd 100644
> --- a/fs/efivarfs/internal.h
> +++ b/fs/efivarfs/internal.h
> @@ -9,6 +9,15 @@
>  #include <linux/list.h>
>  #include <linux/efi.h>
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
>  struct efi_variable {
>         efi_char16_t  VariableName[EFI_VAR_NAME_LEN/sizeof(efi_char16_t)];
>         efi_guid_t    VendorGuid;
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index e028fafa04f3..c53cebf45ac5 100644
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
> @@ -24,6 +25,22 @@ static void efivarfs_evict_inode(struct inode *inode)
>         clear_inode(inode);
>  }
>
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
>  static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  {
>         const u32 attr = EFI_VARIABLE_NON_VOLATILE |
> @@ -64,6 +81,7 @@ static const struct super_operations efivarfs_ops = {
>         .statfs = efivarfs_statfs,
>         .drop_inode = generic_delete_inode,
>         .evict_inode = efivarfs_evict_inode,
> +       .show_options = efivarfs_show_options,
>  };
>
>  /*
> @@ -225,6 +243,45 @@ static int efivarfs_destroy(struct efivar_entry *entry, void *data)
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
> +       {},
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
> +               if (!uid_valid(opts->uid))
> +                       return -EINVAL;
> +               break;
> +       case Opt_gid:
> +               opts->gid = make_kgid(current_user_ns(), result.uint_32);
> +               if (!gid_valid(opts->gid))
> +                       return -EINVAL;
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
> @@ -270,11 +327,22 @@ static int efivarfs_get_tree(struct fs_context *fc)
>  }
>
>  static const struct fs_context_operations efivarfs_context_ops = {
> -       .get_tree       = efivarfs_get_tree,
> +       .get_tree = efivarfs_get_tree,
> +       .parse_param = efivarfs_parse_param,
>  };
>
>  static int efivarfs_init_fs_context(struct fs_context *fc)
>  {
> +       struct efivarfs_fs_info *sfi;
> +
> +       sfi = kzalloc(sizeof(struct efivarfs_fs_info), GFP_KERNEL);
> +       if (!sizeof(*sfi))

Something went wrong here


> +               return -ENOMEM;
> +
> +       sfi->mount_opts.uid = GLOBAL_ROOT_UID;
> +       sfi->mount_opts.gid = GLOBAL_ROOT_GID;
> +
> +       fc->s_fs_info = sfi;
>         fc->ops = &efivarfs_context_ops;
>         return 0;
>  }
> @@ -291,10 +359,11 @@ static void efivarfs_kill_sb(struct super_block *sb)
>  }
>
>  static struct file_system_type efivarfs_type = {
> -       .owner   = THIS_MODULE,
> -       .name    = "efivarfs",
> +       .owner = THIS_MODULE,
> +       .name = "efivarfs",
>         .init_fs_context = efivarfs_init_fs_context,
>         .kill_sb = efivarfs_kill_sb,
> +       .parameters     = efivarfs_parameters,
>  };
>
>  static __init int efivarfs_init(void)
> --
> 2.42.0.283.g2d96d420d3-goog
>
