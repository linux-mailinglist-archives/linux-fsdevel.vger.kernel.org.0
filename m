Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0C07916F4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 14:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjIDMRV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 08:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjIDMRU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:17:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9FFCC4;
        Mon,  4 Sep 2023 05:17:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED4CB6162A;
        Mon,  4 Sep 2023 12:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BA0C433C8;
        Mon,  4 Sep 2023 12:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693829832;
        bh=HHXY3v7221b+SxrYI/jDf93gMIgyLJsAK1IX5/+dU2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eVx9Hwy/MKXb5WGL9r/z7C8Gyt5scaL8nY8H6JYFtCrwB7N+2INJ7fBcXDxOtLqVz
         c4agcMTPyI7GI2UzW/lIpxTeAdzkLyYVeB3myh8PmxiwDZDqYOhjr9STAz8GipAoWb
         Ect0o4qNiePgdcelvGz2zT2zK96IW0hcfJd290C5SRqh2Whc//xE7aAdshnV7BYHUQ
         sCoSJtjsA1evjh1Fnlpg2xk4NNjPh2evvO+bH44iucFtfP+tqaRDZ/aiCVUDElTUpd
         wigeWvtMN3sfnURzy8GihSrQT55sY7Hu7SrOeUwYpz26aCDlD7O12iug+nkfqtvdP7
         +/vibpZEmskOg==
Date:   Mon, 4 Sep 2023 14:17:08 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jiao Zhou <jiaozhou@google.com>
Cc:     Linux FS Development <linux-fsdevel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] kernel: Add Mount Option For Efivarfs
Message-ID: <20230904-erben-coachen-7ca9a30cdc05@brauner>
References: <20230831153108.2021554-1-jiaozhou@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831153108.2021554-1-jiaozhou@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 31, 2023 at 03:31:07PM +0000, Jiao Zhou wrote:
> Add uid and gid in efivarfs's mount option, so that
> we can mount the file system with ownership. This approach
>  is used by a number of other filesystems that don't have
> native support for ownership.
> 
> TEST=FEATURES=test emerge-reven chromeos-kernel-5_15
> 
> Signed-off-by: Jiao Zhou <jiaozhou@google.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202308291443.ea96ac66-oliver.sang@intel.com
> ---
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
>  				const struct inode *dir, int mode,
>  				dev_t dev, bool is_removable)
>  {
> +	struct efivarfs_fs_info *fsi = sb->s_fs_info;
>  	struct inode *inode = new_inode(sb);
> +	struct efivarfs_mount_opts *opts = &fsi->mount_opts;
>  
>  	if (inode) {
> +		inode->i_uid = opts->uid;
> +		inode->i_gid = opts->gid;
>  		inode->i_ino = get_next_ino();
>  		inode->i_mode = mode;
>  		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
> index 30ae44cb7453..57deaf56d8e2 100644
> --- a/fs/efivarfs/internal.h
> +++ b/fs/efivarfs/internal.h
> @@ -8,6 +8,15 @@
>  
>  #include <linux/list.h>
>  
> +struct efivarfs_mount_opts {
> +	kuid_t uid;
> +	kgid_t gid;
> +};
> +
> +struct efivarfs_fs_info {
> +	struct efivarfs_mount_opts mount_opts;
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
>  	clear_inode(inode);
>  }
>  
> +static int efivarfs_show_options(struct seq_file *m, struct dentry *root)
> +{
> +	struct super_block *sb = root->d_sb;
> +	struct efivarfs_fs_info *sbi = sb->s_fs_info;
> +	struct efivarfs_mount_opts *opts = &sbi->mount_opts;
> +
> +	/* Show partition info */
> +	if (!uid_eq(opts->uid, GLOBAL_ROOT_UID))
> +		seq_printf(m, ",uid=%u",
> +				from_kuid_munged(&init_user_ns, opts->uid));
> +	if (!gid_eq(opts->gid, GLOBAL_ROOT_GID))
> +		seq_printf(m, ",gid=%u",
> +				from_kgid_munged(&init_user_ns, opts->gid));
> +	return 0;
> +}
> +
>  static const struct super_operations efivarfs_ops = {
>  	.statfs = simple_statfs,
>  	.drop_inode = generic_delete_inode,
>  	.evict_inode = efivarfs_evict_inode,
> +	.show_options	= efivarfs_show_options,
>  };
>  
>  /*
> @@ -190,6 +208,41 @@ static int efivarfs_destroy(struct efivar_entry *entry, void *data)
>  	return 0;
>  }
>  
> +enum {
> +	Opt_uid, Opt_gid,
> +};
> +
> +static const struct fs_parameter_spec efivarfs_parameters[] = {
> +	fsparam_u32("uid",			Opt_uid),
> +	fsparam_u32("gid",			Opt_gid),
> +	{},
> +};
> +
> +static int efivarfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
> +{
> +	struct efivarfs_fs_info *sbi = fc->s_fs_info;
> +	struct efivarfs_mount_opts *opts = &sbi->mount_opts;
> +	struct fs_parse_result result;
> +	int opt;
> +
> +	opt = fs_parse(fc, efivarfs_parameters, param, &result);
> +	if (opt < 0)
> +		return opt;
> +
> +	switch (opt) {
> +	case Opt_uid:
> +		opts->uid = make_kuid(current_user_ns(), result.uint_32);
> +		break;
> +	case Opt_gid:
> +		opts->gid = make_kgid(current_user_ns(), result.uint_32);
> +		break;

This will allow the following:

# initial user namespace
fd_fs = fsopen("efivarfs")

# switch to some unprivileged userns
fsconfig(fd_fs, FSCONFIG_SET_STRING, "uid", "1000")
==> This now resolves within the caller's user namespace which might
    have an idmapping where 1000 cannot be resolved causing sb->{g,u}id
    to be set to INVALID_{G,U}ID.

    In fact this is also possible in your patch right now without the
    namespace switching. The caller could just pass -1 and that would
    cause inodes with INVALID_{G,U}ID to be created.
    So you want a check for {g,u}id_valid().

# send fd back to init_user_ns
fsconfig(fd_fs, FSCONFIG_CMD_CREATE)
fd_mnt = fsmount(fd_fs, ...)
move_mount(fd_fs, "", -EBADF, "/somehwere", ...)
