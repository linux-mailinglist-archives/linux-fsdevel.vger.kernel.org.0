Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D0257E549
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 19:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbiGVRTZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 13:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbiGVRTY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:19:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981F388E2E;
        Fri, 22 Jul 2022 10:19:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E6C5B8296E;
        Fri, 22 Jul 2022 17:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9E5C341C6;
        Fri, 22 Jul 2022 17:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658510360;
        bh=2GxzLl6u2AY30dpZe4mOytY1rt9M1iptzukBSc+uvNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UJxniS8lmmHTFUTM5uy+DPiAOXfQGcxbeam9ChAvSfNlVnOaMsQukCr/65+eDs9HO
         Qu1+UqkzDFRV+os/YhhqDhCbY+27p2kwq8jrfZvLNnU04qdr0jNzhbOm439l1m0XGe
         oQuyatKHpCQ/zqYzJd4yBCiA7wpsMxIzixh3mgeVA2IdqyXMMtidCnR1WPKDbJwKVl
         3wupJCtqLcSK3araWXSOzyR9DX0kW5cHdmZ4lfK9nG74zS+xbTwlFCLGfDuDOGNrIL
         yY9WccBpySKSzn7tqqx92IiX5OR+Mdairky7xhQSOxLqkYDTa9sunuXLub933qafbC
         hIM9Ugtvv4mBA==
Date:   Fri, 22 Jul 2022 10:19:19 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeremy Bongio <bongiojp@gmail.com>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5] Add ioctls to get/set the ext4 superblock uuid.
Message-ID: <YtrcFyBRGnh5sgR/@magnolia>
References: <20220721224422.438351-1-bongiojp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721224422.438351-1-bongiojp@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 21, 2022 at 03:44:22PM -0700, Jeremy Bongio wrote:
> This fixes a race between changing the ext4 superblock uuid and operations
> like mounting, resizing, changing features, etc.
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>

It's possibly too late for this, but:
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
> ---
> 
> Changes in v5:
> 
> Return size of uuid in a EXT4_IOC_GETFSUUID operation if fsu_len is 0.
> 
>  fs/ext4/ext4.h  | 11 +++++++
>  fs/ext4/ioctl.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 94 insertions(+)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 75b8d81b2469..b760d669a1ca 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -724,6 +724,8 @@ enum {
>  #define EXT4_IOC_GETSTATE		_IOW('f', 41, __u32)
>  #define EXT4_IOC_GET_ES_CACHE		_IOWR('f', 42, struct fiemap)
>  #define EXT4_IOC_CHECKPOINT		_IOW('f', 43, __u32)
> +#define EXT4_IOC_GETFSUUID		_IOR('f', 44, struct fsuuid)
> +#define EXT4_IOC_SETFSUUID		_IOW('f', 44, struct fsuuid)
>  
>  #define EXT4_IOC_SHUTDOWN _IOR ('X', 125, __u32)
>  
> @@ -753,6 +755,15 @@ enum {
>  						EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT | \
>  						EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN)
>  
> +/*
> + * Structure for EXT4_IOC_GETFSUUID/EXT4_IOC_SETFSUUID
> + */
> +struct fsuuid {
> +	__u32       fsu_len;
> +	__u32       fsu_flags;
> +	__u8        fsu_uuid[];
> +};
> +
>  #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
>  /*
>   * ioctl commands in 32 bit emulation
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index cb01c1da0f9d..b7c9bf9e7864 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -20,6 +20,7 @@
>  #include <linux/delay.h>
>  #include <linux/iversion.h>
>  #include <linux/fileattr.h>
> +#include <linux/uuid.h>
>  #include "ext4_jbd2.h"
>  #include "ext4.h"
>  #include <linux/fsmap.h>
> @@ -41,6 +42,15 @@ static void ext4_sb_setlabel(struct ext4_super_block *es, const void *arg)
>  	memcpy(es->s_volume_name, (char *)arg, EXT4_LABEL_MAX);
>  }
>  
> +/*
> + * Superblock modification callback function for changing file system
> + * UUID.
> + */
> +static void ext4_sb_setuuid(struct ext4_super_block *es, const void *arg)
> +{
> +	memcpy(es->s_uuid, (__u8 *)arg, UUID_SIZE);
> +}
> +
>  static
>  int ext4_update_primary_sb(struct super_block *sb, handle_t *handle,
>  			   ext4_update_sb_callback func,
> @@ -1131,6 +1141,73 @@ static int ext4_ioctl_getlabel(struct ext4_sb_info *sbi, char __user *user_label
>  	return 0;
>  }
>  
> +static int ext4_ioctl_getuuid(struct ext4_sb_info *sbi,
> +			struct fsuuid __user *ufsuuid)
> +{
> +	struct fsuuid fsuuid;
> +	__u8 uuid[UUID_SIZE];
> +
> +	if (copy_from_user(&fsuuid, ufsuuid, sizeof(fsuuid)))
> +		return -EFAULT;
> +
> +	if (fsuuid.fsu_len == 0) {
> +		fsuuid.fsu_len = UUID_SIZE;
> +		if (copy_to_user(ufsuuid, &fsuuid, sizeof(fsuuid.fsu_len)))
> +			return -EFAULT;
> +		return -EINVAL;
> +	}
> +
> +	if (fsuuid.fsu_len != UUID_SIZE || fsuuid.fsu_flags != 0)
> +		return -EINVAL;
> +
> +	lock_buffer(sbi->s_sbh);
> +	memcpy(uuid, sbi->s_es->s_uuid, UUID_SIZE);
> +	unlock_buffer(sbi->s_sbh);
> +
> +	if (copy_to_user(&ufsuuid->fsu_uuid[0], uuid, UUID_SIZE))
> +		return -EFAULT;
> +	return 0;
> +}
> +
> +static int ext4_ioctl_setuuid(struct file *filp,
> +			const struct fsuuid __user *ufsuuid)
> +{
> +	int ret = 0;
> +	struct super_block *sb = file_inode(filp)->i_sb;
> +	struct fsuuid fsuuid;
> +	__u8 uuid[UUID_SIZE];
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	/*
> +	 * If any checksums (group descriptors or metadata) are being used
> +	 * then the checksum seed feature is required to change the UUID.
> +	 */
> +	if (((ext4_has_feature_gdt_csum(sb) || ext4_has_metadata_csum(sb))
> +			&& !ext4_has_feature_csum_seed(sb))
> +		|| ext4_has_feature_stable_inodes(sb))
> +		return -EOPNOTSUPP;
> +
> +	if (copy_from_user(&fsuuid, ufsuuid, sizeof(fsuuid)))
> +		return -EFAULT;
> +
> +	if (fsuuid.fsu_len != UUID_SIZE || fsuuid.fsu_flags != 0)
> +		return -EINVAL;
> +
> +	if (copy_from_user(uuid, &ufsuuid->fsu_uuid[0], UUID_SIZE))
> +		return -EFAULT;
> +
> +	ret = mnt_want_write_file(filp);
> +	if (ret)
> +		return ret;
> +
> +	ret = ext4_update_superblocks_fn(sb, ext4_sb_setuuid, &uuid);
> +	mnt_drop_write_file(filp);
> +
> +	return ret;
> +}
> +
>  static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>  	struct inode *inode = file_inode(filp);
> @@ -1509,6 +1586,10 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		return ext4_ioctl_setlabel(filp,
>  					   (const void __user *)arg);
>  
> +	case EXT4_IOC_GETFSUUID:
> +		return ext4_ioctl_getuuid(EXT4_SB(sb), (void __user *)arg);
> +	case EXT4_IOC_SETFSUUID:
> +		return ext4_ioctl_setuuid(filp, (const void __user *)arg);
>  	default:
>  		return -ENOTTY;
>  	}
> @@ -1586,6 +1667,8 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	case EXT4_IOC_CHECKPOINT:
>  	case FS_IOC_GETFSLABEL:
>  	case FS_IOC_SETFSLABEL:
> +	case EXT4_IOC_GETFSUUID:
> +	case EXT4_IOC_SETFSUUID:
>  		break;
>  	default:
>  		return -ENOIOCTLCMD;
> -- 
> 2.37.1.359.gd136c6c3e2-goog
> 
