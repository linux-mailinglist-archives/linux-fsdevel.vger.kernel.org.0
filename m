Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFF077FB1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 17:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353314AbjHQPr2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 11:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353310AbjHQPqz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:46:55 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D9130D8
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 08:46:52 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-58c7bd44c7bso21649227b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 08:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692287211; x=1692892011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QumRCqY2TD9/wsdcsGqqO2YcRV/Q/3QWJUoHrZtAsWg=;
        b=KKr+Sfq/ik+51fJKSAReVA6g8adTwAw+PkWApWi8RBiSL+7YNQVGcgoectc704BBEa
         df7FH3gCK0sL/6RcvU5US4lhZiWetGNt9/woWgUPYQl9YQakN8OBvdH5D+ZvJaHSc5QP
         4xnr4eJCzU1TDYaRs37eSnl6H9ynrv2KDniUsKln+nrVW/bcEtfvoLtC8VFKqNIUqSLW
         nyFORYkjOW5ivYCjBNZSq3kVJ7CUcM1vQVlRU/eYhteDhISIZCRIH//q1COzS8kS9rEQ
         3arRUkk38dLhMJ3ZbUOtT+TnGoMCuVi90HmUdDLN1G7Ait+IKFa1wYBWv08HKBBJ8/BV
         4iAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692287211; x=1692892011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QumRCqY2TD9/wsdcsGqqO2YcRV/Q/3QWJUoHrZtAsWg=;
        b=doo2C3hxNrcR2sK1I1Kbm45wFi3if1xFcocSPxIA0Cvm22PPEMI/wU/ksWEPQ2ASSq
         OOCuPov6bM17AYRw4NXtoMEjdwGxBksnho9wXWRU6MtjIicKULseHeRAaVQRMdepW443
         PshMPiQIH4GckivbV/WvYFO0yZuGB4VNUkY64/dXjnlT7H3rTZu0A8SJXW8bTD4o91Av
         KQdK7vctzTYsQC2lffiwMUsIh7V0iBICZLD4OB5zqYq3f+r6KxFhKLWF9lCdK9Yi6X/Q
         8svnPw4Oqnkfo8m1lA9BsubswTwt224b5BzeGAVR3QZf8hDnmYlcC2OR3Agj3xK+v4iu
         5oGg==
X-Gm-Message-State: AOJu0Yz7PUOZao6uA7pC4rYfv5VsXC4GY6G6fy6WvhpoH4HHGtMrFts/
        VGXJIYw0PS/v/+jc9jfuf3gJMA==
X-Google-Smtp-Source: AGHT+IE2dT+YR9l4PMafEnIPVHvd7/y971KzVPixyVvzBOzB0V/jf10mZoTTEw1c7lWkNPJgwHlIsA==
X-Received: by 2002:a81:4a41:0:b0:583:69b4:c75a with SMTP id x62-20020a814a41000000b0058369b4c75amr5078701ywa.21.1692287211535;
        Thu, 17 Aug 2023 08:46:51 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id o131-20020a817389000000b0056cd3e598d8sm4659269ywc.114.2023.08.17.08.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 08:46:51 -0700 (PDT)
Date:   Thu, 17 Aug 2023 11:46:50 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, anand.jain@oracle.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
Subject: Re: [PATCH 1/3] btrfs-progs: Add the single-dev feature (to both
 mkfs/tune)
Message-ID: <20230817154650.GD2934386@perftesting>
References: <20230803154453.1488248-1-gpiccoli@igalia.com>
 <20230803154453.1488248-2-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803154453.1488248-2-gpiccoli@igalia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 03, 2023 at 12:43:39PM -0300, Guilherme G. Piccoli wrote:
> The single-dev feature allows a device to be mounted regardless of
> its fsid already being present in another device - in other words,
> this feature disables RAID modes / metadata_uuid, allowing a single
> device per filesystem. Its goal is mainly to allow mounting the
> same fsid at the same time in the system.
> 
> Introduce hereby the feature to both mkfs (-O single-dev) and
> btrfstune (-s), syncing the kernel-shared headers as well. The
> feature is a compat_ro, its kernel version was set to v6.5.
> 
> Suggested-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> 
> Hi folks, thanks in advance for reviews! Notice that I've added
> the feature to btrfstune as well, but I found docs online saying
> this tool is deprecated..so not sure if that was the proper approach.
> 
> Also, a design decision: I've skipped the btrfs_register_one_device()
> call when mkfs was just used with the single-dev tuning, or else
> it shows a (harmless) error and succeeds, since of course scanning
> fails for such devices, as per the feature implementation.
> So, I thought it was more straightforward to just skip the call itself.
> 

This is a reasonable approach.

> Cheers,
> 
> Guilherme
> 
>  common/fsfeatures.c        |  7 ++++
>  kernel-shared/ctree.h      |  3 +-
>  kernel-shared/uapi/btrfs.h |  7 ++++
>  mkfs/main.c                |  4 ++-
>  tune/main.c                | 72 +++++++++++++++++++++++---------------
>  5 files changed, 63 insertions(+), 30 deletions(-)
> 
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> index 00658fa5159f..a320b7062b8c 100644
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -160,6 +160,13 @@ static const struct btrfs_feature mkfs_features[] = {
>  		VERSION_NULL(default),
>  		.desc		= "RAID1 with 3 or 4 copies"
>  	},
> +	{
> +		.name		= "single-dev",
> +		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV,
> +		.sysfs_name	= "single_dev",
> +		VERSION_TO_STRING2(compat, 6,5),
> +		.desc		= "single device (allows same fsid mounting)"
> +	},
>  #ifdef BTRFS_ZONED
>  	{
>  		.name		= "zoned",
> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
> index 59533879b939..e3fd834aa6dd 100644
> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -86,7 +86,8 @@ static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize)
>  	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
>  	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID | \
>  	 BTRFS_FEATURE_COMPAT_RO_VERITY |		\
> -	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE)
> +	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE |	\
> +	 BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV)
>  
>  #if EXPERIMENTAL
>  #define BTRFS_FEATURE_INCOMPAT_SUPP			\
> diff --git a/kernel-shared/uapi/btrfs.h b/kernel-shared/uapi/btrfs.h
> index 85b04f89a2a9..2e0ee6ef6446 100644
> --- a/kernel-shared/uapi/btrfs.h
> +++ b/kernel-shared/uapi/btrfs.h
> @@ -336,6 +336,13 @@ _static_assert(sizeof(struct btrfs_ioctl_fs_info_args) == 1024);
>   */
>  #define BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE	(1ULL << 3)
>  
> +/*
> + * Single devices (as flagged by the corresponding compat_ro flag) only
> + * gets scanned during mount time; also, a random fsid is generated for
> + * them, in order to cope with same-fsid filesystem mounts.
> + */
> +#define BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV		(1ULL << 4)
> +
>  #define BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF	(1ULL << 0)
>  #define BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL	(1ULL << 1)
>  #define BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS	(1ULL << 2)
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 972ed1112ea6..429799932224 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1025,6 +1025,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  	char *label = NULL;
>  	int nr_global_roots = sysconf(_SC_NPROCESSORS_ONLN);
>  	char *source_dir = NULL;
> +	bool single_dev;
>  
>  	cpu_detect_flags();
>  	hash_init_accel();
> @@ -1218,6 +1219,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  		usage(&mkfs_cmd, 1);
>  
>  	opt_zoned = !!(features.incompat_flags & BTRFS_FEATURE_INCOMPAT_ZONED);
> +	single_dev = !!(features.compat_ro_flags & BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV);
>  
>  	if (source_dir && device_count > 1) {
>  		error("the option -r is limited to a single device");
> @@ -1815,7 +1817,7 @@ out:
>  		device_count = argc - optind;
>  		while (device_count-- > 0) {
>  			file = argv[optind++];
> -			if (path_is_block_device(file) == 1)
> +			if (path_is_block_device(file) == 1 && !single_dev)
>  				btrfs_register_one_device(file);
>  		}
>  	}
> diff --git a/tune/main.c b/tune/main.c
> index 0ca1e01282c9..95e55fcda44f 100644
> --- a/tune/main.c
> +++ b/tune/main.c
> @@ -42,27 +42,31 @@
>  #include "tune/tune.h"
>  #include "check/clear-cache.h"
>  
> +#define SET_SUPER_FLAGS(type) \
> +static int set_super_##type##_flags(struct btrfs_root *root, u64 flags) \
> +{									\
> +	struct btrfs_trans_handle *trans;				\
> +	struct btrfs_super_block *disk_super;				\
> +	u64 super_flags;						\
> +	int ret;							\
> +									\
> +	disk_super = root->fs_info->super_copy;				\
> +	super_flags = btrfs_super_##type##_flags(disk_super);		\
> +	super_flags |= flags;						\
> +	trans = btrfs_start_transaction(root, 1);			\
> +	BUG_ON(IS_ERR(trans));						\
> +	btrfs_set_super_##type##_flags(disk_super, super_flags);	\
> +	ret = btrfs_commit_transaction(trans, root);			\
> +									\
> +	return ret;							\
> +}
> +
> +SET_SUPER_FLAGS(incompat)
> +SET_SUPER_FLAGS(compat_ro)
> +
>  static char *device;
>  static int force = 0;
>  
> -static int set_super_incompat_flags(struct btrfs_root *root, u64 flags)
> -{
> -	struct btrfs_trans_handle *trans;
> -	struct btrfs_super_block *disk_super;
> -	u64 super_flags;
> -	int ret;
> -
> -	disk_super = root->fs_info->super_copy;
> -	super_flags = btrfs_super_incompat_flags(disk_super);
> -	super_flags |= flags;
> -	trans = btrfs_start_transaction(root, 1);
> -	BUG_ON(IS_ERR(trans));
> -	btrfs_set_super_incompat_flags(disk_super, super_flags);
> -	ret = btrfs_commit_transaction(trans, root);
> -
> -	return ret;
> -}
> -
>  static int convert_to_fst(struct btrfs_fs_info *fs_info)
>  {
>  	int ret;
> @@ -102,6 +106,7 @@ static const char * const tune_usage[] = {
>  	OPTLINE("-r", "enable extended inode refs (mkfs: extref, for hardlink limits)"),
>  	OPTLINE("-x", "enable skinny metadata extent refs (mkfs: skinny-metadata)"),
>  	OPTLINE("-n", "enable no-holes feature (mkfs: no-holes, more efficient sparse file representation)"),
> +	OPTLINE("-s", "enable single device feature (mkfs: single-dev, allows same fsid mounting)"),

btrfstune is going to be integrated into an actual btrfs command, so we're no
longer using short options for new btrfstune commands.  Figure out a long name
instead and use that only.  Something like

--convert-to-single-device

as you would be using this on an existing file system.  The rest of the code is
generally fine.  Thanks,

Josef
