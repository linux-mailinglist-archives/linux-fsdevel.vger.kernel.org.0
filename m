Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FB978F0B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 17:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346654AbjHaPz5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 11:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244344AbjHaPz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:55:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DC51BF;
        Thu, 31 Aug 2023 08:55:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A460160C86;
        Thu, 31 Aug 2023 15:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18603C433C9;
        Thu, 31 Aug 2023 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693497353;
        bh=tNXifSiQHZBG29lO09mqc7pDxfteGdJCL9kXovhDnKI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mifc4DfhQc6w0kGlDvUq6C7bBg7gAMvCubSyYKgHwFKQ/Qjqb7NWXQzdgjUBTXoET
         VoT6VIKl2Dte5i6nbQelnbeRbTZRMOpiMwbWRGyyBXOn/0Wz6H+WLle07xW1kxe/7f
         BxQouvxuEZ6G6Pdvga19MJ+ETwatyQikh7Xm23kzZmLXk2iZoP7mUsCStqQY6Jsfk3
         4pOr34jBwE+kZulxthUmd9ymhvjcdyi7A9V4nH3EMKCFGq83FCN5zajcsK5abbc7Ay
         JGignWh/MwJZ8Ur3yTarQOc2Gn0cz98BGOrsyoOB+jL42ijQ+fpd8BUpf/DkruCsDt
         52A+u9DDK7IJQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2bcb54226e7so11231151fa.1;
        Thu, 31 Aug 2023 08:55:52 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzt6DD8j2yQwGYtulAihk1R0DFdMSRQsboktjaAUxnXZLlDOu/c
        XE73MhLnhwx3VQ+girq8jWjbYkEuNtgWow9qt2g=
X-Google-Smtp-Source: AGHT+IEY5GoXsFCov5SJWiJggz3wcaMCrwHepMriHH9ykWAeGhLUAuw+In0odqUHWAqXRMuqVxP9pXlh9+OifB9IVmU=
X-Received: by 2002:a2e:b532:0:b0:2b9:aad7:9d89 with SMTP id
 z18-20020a2eb532000000b002b9aad79d89mr1061025ljm.15.1693497351006; Thu, 31
 Aug 2023 08:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230831153108.2021554-1-jiaozhou@google.com>
In-Reply-To: <20230831153108.2021554-1-jiaozhou@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 31 Aug 2023 17:55:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH0jAgP2RJOUiXftZMbQnwkTr_EUqF3VnVU1_esLN=Bvw@mail.gmail.com>
Message-ID: <CAMj1kXH0jAgP2RJOUiXftZMbQnwkTr_EUqF3VnVU1_esLN=Bvw@mail.gmail.com>
Subject: Re: [PATCH] kernel: Add Mount Option For Efivarfs
To:     Jiao Zhou <jiaozhou@google.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Linux FS Development <linux-fsdevel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Jiao Zhou,

This is the second revision of your patch. Please include this fact in
the subject header, i.e., [PATCH v2] so it is clearly visible.

On Thu, 31 Aug 2023 at 17:31, Jiao Zhou <jiaozhou@google.com> wrote:
>
> Add uid and gid in efivarfs's mount option, so that
> we can mount the file system with ownership. This approach
>  is used by a number of other filesystems that don't have
> native support for ownership.
>
> TEST=FEATURES=test emerge-reven chromeos-kernel-5_15

What does this line mean? Please drop it if it has internal relevance only.

>
> Signed-off-by: Jiao Zhou <jiaozhou@google.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202308291443.ea96ac66-oliver.sang@intel.com

Please drop these lines - the robot found an issue caused by a
proposed patch, and the newest revision should no longer trigger that
issue. So these reports have no long term value, and don't deserve a
mention in the commit log. I understand that the instructions in those
reports are inconsistent with this, but those reports should generally
be taken with a grain of salt in any case.

You also failed to include Matthew Garrett's ack.

> ---

Here (below the ---) is where we generally expect an informal revision
history of the patch.

So something like

v2:
- add missing sentinel entry in fs_parameter_spec[] array
- whatever else you did to fix the issue reported by the robot.

For subsequent revisions, please append (or prepend) to the existing
changelog so the entire revision history is documented.

Please fix all of those issues in a v3. Some more below.

>  fs/efivarfs/inode.c    |  4 +++
>  fs/efivarfs/internal.h |  9 ++++++
>  fs/efivarfs/super.c    | 65 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+)
>
> diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
> index 939e5e242b98..de57fb6c28e1 100644
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
> index 30ae44cb7453..57deaf56d8e2 100644
> --- a/fs/efivarfs/internal.h
> +++ b/fs/efivarfs/internal.h
> @@ -8,6 +8,15 @@
>
>  #include <linux/list.h>
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
> index 15880a68faad..d67b0d157ff5 100644
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
> @@ -23,10 +24,27 @@ static void efivarfs_evict_inode(struct inode *inode)
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
>  static const struct super_operations efivarfs_ops = {
>         .statfs = simple_statfs,
>         .drop_inode = generic_delete_inode,
>         .evict_inode = efivarfs_evict_inode,
> +       .show_options   = efivarfs_show_options,
>  };
>
>  /*
> @@ -190,6 +208,41 @@ static int efivarfs_destroy(struct efivar_entry *entry, void *data)
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
> @@ -233,10 +286,21 @@ static int efivarfs_get_tree(struct fs_context *fc)
>
>  static const struct fs_context_operations efivarfs_context_ops = {
>         .get_tree       = efivarfs_get_tree,
> +       .parse_param    = efivarfs_parse_param,
>  };
>
>  static int efivarfs_init_fs_context(struct fs_context *fc)
>  {
> +       struct efivarfs_fs_info *sfi;
> +
> +       sfi = kzalloc(sizeof(struct efivarfs_fs_info), GFP_KERNEL);

Please use sizeof(*sfi) here - this avoids future problems if sfi ever
changes type.

> +       if (!sfi)
> +               return -ENOMEM;
> +
> +       sfi->mount_opts.uid = current_uid();
> +       sfi->mount_opts.gid = current_gid();
> +

Could this affect existing users of efivarfs? IIIUC, this will result
in efivarfs being mounted with the uid/gid of the caller instead of
root/root, right? So if existing scripts use some other user with the
right capabilities to mount efivarfs, the uid/gid will change.

Is this part of the change important to your use case?

> +       fc->s_fs_info = sfi;
>         fc->ops = &efivarfs_context_ops;
>         return 0;
>  }
> @@ -254,6 +318,7 @@ static struct file_system_type efivarfs_type = {
>         .name    = "efivarfs",
>         .init_fs_context = efivarfs_init_fs_context,
>         .kill_sb = efivarfs_kill_sb,
> +       .parameters             = efivarfs_parameters,

Please either drop the indentation, or re-indent the whole block.

>  };
>
>  static __init int efivarfs_init(void)
> --
> 2.42.0.rc2.253.gd59a3bf2b4-goog
>
