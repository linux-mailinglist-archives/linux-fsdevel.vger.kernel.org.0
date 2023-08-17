Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC68277FB03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 17:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353271AbjHQPlg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 11:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353304AbjHQPlb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:41:31 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FA830DA
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 08:41:29 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bc886d1504so21664a34.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 08:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692286888; x=1692891688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CaRzgyM502u0wyRuRjHfBjeep7mbnsAMcdG/Jf+gGXk=;
        b=eVbw+RKt0txGTTaxeXds7gGAsj1u6+CI4qZG01BI4YMWOyJYoVEvTHDv7WtBezZvKw
         uybyDCxZRufEnjMLrkUXKMuLAlwoMID0oJr7NkQNDpIXhBVkU1BSCmP3VbnFLMb+V5Vm
         SOmaIQafVbJNphFZyW0aj9L993q4bXRmllDcOI9iqksnSMAee9Ury+2oJkwtUyZSXDFp
         Zl95szY9G11IwgqlW/k0Qd3pTVkjAoVBS+3LobOGDSS43Jf1YjbtT4/yB2iJotc3W/Z8
         N5T0DhNJXC2MM1fub0i9WofqmFDTStWaDEMPMFvGhQxYxiMmznxb1N99yjX+Jh0rB4/m
         XXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692286888; x=1692891688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaRzgyM502u0wyRuRjHfBjeep7mbnsAMcdG/Jf+gGXk=;
        b=XYIEcLtOb5yz+6N3bJbHQyh8JkEBG1ziV0Ozs4rButnEUUCbnNy15ESNQDbJK+9bIJ
         2Xy1hqjciOuI3GuCSm2ugoj5q+eZZn9OPRgg1N+ckxPCuzxmvXeGV66CZ044h7rx+YGp
         rz773ho3pkiP9FCgWbXS/IS7vx7ceFT5FzF0u7pVaQNAwCsly6bOWt4x9SbKHzGehZ77
         tIoNJmtHTLat7jrTrGZwgZMlJx9I+KcHE6ze07x7R+ELiY53GnPwhrZQl3gLaktMhfmp
         pv+THfQahwPdHIg4OJDXoF+bAfOYvWgr2wTPKsYCrv2M1gip8RA7Y4U4PLzT5jcZxDaL
         iptg==
X-Gm-Message-State: AOJu0YyaCbk4UpLp0ebRqWl1A0m2X1EzI5T+Odvn1GVzFtfEC0XdngI1
        Hpuon34AzDsLtbzWpDlWH7F0Uw==
X-Google-Smtp-Source: AGHT+IGd8FI22G4oKY0ivie799PzfJcM81ZYtOgYrr63wxkweqRgwEeRwQw+WZZticwp/HgApdj+Tw==
X-Received: by 2002:a05:6358:419f:b0:134:eed0:3bc5 with SMTP id w31-20020a056358419f00b00134eed03bc5mr6139009rwc.9.1692286888452;
        Thu, 17 Aug 2023 08:41:28 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w124-20020a817b82000000b005897fd75c80sm597940ywc.78.2023.08.17.08.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 08:41:28 -0700 (PDT)
Date:   Thu, 17 Aug 2023 11:41:27 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, anand.jain@oracle.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
Subject: Re: [PATCH 2/3] btrfs: Introduce the single-dev feature
Message-ID: <20230817154127.GB2934386@perftesting>
References: <20230803154453.1488248-1-gpiccoli@igalia.com>
 <20230803154453.1488248-3-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803154453.1488248-3-gpiccoli@igalia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 03, 2023 at 12:43:40PM -0300, Guilherme G. Piccoli wrote:
> Btrfs doesn't currently support to mount 2 different devices holding the
> same filesystem - the fsid is used as a unique identifier in the driver.
> This case is supported though in some other common filesystems, like
> ext4; one of the reasons for which is not trivial supporting this case
> on btrfs is due to its multi-device filesystem nature, native RAID, etc.
> 
> Supporting the same-fsid mounts has the advantage of allowing btrfs to
> be used in A/B partitioned devices, like mobile phones or the Steam Deck
> for example. Without this support, it's not safe for users to keep the
> same "image version" in both A and B partitions, a setup that is quite
> common for development, for example. Also, as a big bonus, it allows fs
> integrity check based on block devices for RO devices (whereas currently
> it is required that both have different fsid, breaking the block device
> hash comparison).
> 
> Such same-fsid mounting is hereby added through the usage of the
> filesystem feature "single-dev" - when such feature is used, btrfs
> generates a random fsid for the filesystem and leverages the long-term
> present metadata_uuid infrastructure to enable the usage of this
> secondary virtual fsid, effectively requiring few non-invasive changes
> to the code and no new potential corner cases.
> 
> In order to prevent more code complexity and corner cases, given
> the nature of this mechanism (single-devices), the single-dev feature
> is not allowed when the metadata_uuid flag is already present on the
> fs, or if the device is on fsid-change state. Device removal/replace
> is also disabled for devices presenting the single-dev feature.
> 
> Suggested-by: John Schoenick <johns@valvesoftware.com>
> Suggested-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>  fs/btrfs/disk-io.c         | 19 +++++++-
>  fs/btrfs/fs.h              |  3 +-
>  fs/btrfs/ioctl.c           | 18 +++++++
>  fs/btrfs/super.c           |  8 ++--
>  fs/btrfs/volumes.c         | 97 ++++++++++++++++++++++++++++++--------
>  fs/btrfs/volumes.h         |  3 +-
>  include/uapi/linux/btrfs.h |  7 +++
>  7 files changed, 127 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 669b10355091..455fa4949c98 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -320,7 +320,7 @@ static bool check_tree_block_fsid(struct extent_buffer *eb)
>  	/*
>  	 * alloc_fs_devices() copies the fsid into metadata_uuid if the
>  	 * metadata_uuid is unset in the superblock, including for a seed device.
> -	 * So, we can use fs_devices->metadata_uuid.
> +	 * So, we can use fs_devices->metadata_uuid; same for SINGLE_DEV devices.
>  	 */
>  	if (!memcmp(fsid, fs_info->fs_devices->metadata_uuid, BTRFS_FSID_SIZE))
>  		return false;
> @@ -2288,6 +2288,7 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
>  {
>  	u64 nodesize = btrfs_super_nodesize(sb);
>  	u64 sectorsize = btrfs_super_sectorsize(sb);
> +	u8 *fsid;
>  	int ret = 0;
>  
>  	if (btrfs_super_magic(sb) != BTRFS_MAGIC) {
> @@ -2368,7 +2369,21 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
>  		ret = -EINVAL;
>  	}
>  
> -	if (memcmp(fs_info->fs_devices->fsid, sb->fsid, BTRFS_FSID_SIZE)) {
> +	/*
> +	 * For SINGLE_DEV devices, btrfs creates a random fsid and makes
> +	 * use of the metadata_uuid infrastructure in order to allow, for
> +	 * example, two devices with same fsid getting mounted at the same
> +	 * time. But notice no changes happen at the disk level, so the
> +	 * random generated fsid is a driver abstraction, not to be written
> +	 * in the disk. That's the reason we're required here to compare the
> +	 * fsid with the metadata_uuid for such devices.
> +	 */
> +	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV))
> +		fsid = fs_info->fs_devices->metadata_uuid;
> +	else
> +		fsid = fs_info->fs_devices->fsid;
> +
> +	if (memcmp(fsid, sb->fsid, BTRFS_FSID_SIZE)) {
>  		btrfs_err(fs_info,
>  		"superblock fsid doesn't match fsid of fs_devices: %pU != %pU",
>  			  sb->fsid, fs_info->fs_devices->fsid);
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 203d2a267828..c6d124973361 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -200,7 +200,8 @@ enum {
>  	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
>  	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID | \
>  	 BTRFS_FEATURE_COMPAT_RO_VERITY |		\
> -	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE)
> +	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE |	\
> +	 BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV)
>  
>  #define BTRFS_FEATURE_COMPAT_RO_SAFE_SET	0ULL
>  #define BTRFS_FEATURE_COMPAT_RO_SAFE_CLEAR	0ULL
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index a895d105464b..56703d87def9 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2678,6 +2678,12 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> +	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV)) {
> +		btrfs_err(fs_info,
> +			  "device removal is unsupported on SINGLE_DEV devices\n");
> +		return -EINVAL;
> +	}
> +
>  	vol_args = memdup_user(arg, sizeof(*vol_args));
>  	if (IS_ERR(vol_args))
>  		return PTR_ERR(vol_args);
> @@ -2744,6 +2750,12 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> +	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV)) {
> +		btrfs_err(fs_info,
> +			  "device removal is unsupported on SINGLE_DEV devices\n");
> +		return -EINVAL;
> +	}
> +
>  	vol_args = memdup_user(arg, sizeof(*vol_args));
>  	if (IS_ERR(vol_args))
>  		return PTR_ERR(vol_args);
> @@ -3268,6 +3280,12 @@ static long btrfs_ioctl_dev_replace(struct btrfs_fs_info *fs_info,
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> +	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV)) {
> +		btrfs_err(fs_info,
> +			  "device removal is unsupported on SINGLE_DEV devices\n");
> +		return -EINVAL;
> +	}
> +
>  	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
>  		btrfs_err(fs_info, "device replace not supported on extent tree v2 yet");
>  		return -EINVAL;
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index f1dd172d8d5b..ee87189b1ccd 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -883,7 +883,7 @@ static int btrfs_parse_device_options(const char *options, blk_mode_t flags)
>  				error = -ENOMEM;
>  				goto out;
>  			}
> -			device = btrfs_scan_one_device(device_name, flags);
> +			device = btrfs_scan_one_device(device_name, flags, true);
>  			kfree(device_name);
>  			if (IS_ERR(device)) {
>  				error = PTR_ERR(device);
> @@ -1478,7 +1478,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
>  		goto error_fs_info;
>  	}
>  
> -	device = btrfs_scan_one_device(device_name, mode);
> +	device = btrfs_scan_one_device(device_name, mode, true);
>  	if (IS_ERR(device)) {
>  		mutex_unlock(&uuid_mutex);
>  		error = PTR_ERR(device);
> @@ -2190,7 +2190,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>  	switch (cmd) {
>  	case BTRFS_IOC_SCAN_DEV:
>  		mutex_lock(&uuid_mutex);
> -		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
> +		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
>  		ret = PTR_ERR_OR_ZERO(device);
>  		mutex_unlock(&uuid_mutex);
>  		break;
> @@ -2204,7 +2204,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>  		break;
>  	case BTRFS_IOC_DEVICES_READY:
>  		mutex_lock(&uuid_mutex);
> -		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
> +		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
>  		if (IS_ERR(device)) {
>  			mutex_unlock(&uuid_mutex);
>  			ret = PTR_ERR(device);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 73753dae111a..433a490f2de8 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -681,12 +681,14 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  	return -EINVAL;
>  }
>  
> -static u8 *btrfs_sb_metadata_uuid_or_null(struct btrfs_super_block *sb)
> +static u8 *btrfs_sb_metadata_uuid_single_dev(struct btrfs_super_block *sb,
> +					     bool has_metadata_uuid,
> +					     bool single_dev)

Why pass as an argument? Just do the same thing as the code currently does and
check for the single device ro compat flag.

>  {
> -	bool has_metadata_uuid = (btrfs_super_incompat_flags(sb) &
> -				  BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
> +	if (has_metadata_uuid || single_dev)
> +		return sb->metadata_uuid;
>  
> -	return has_metadata_uuid ? sb->metadata_uuid : NULL;
> +	return NULL;
>  }
>  
>  u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb)
> @@ -775,8 +777,36 @@ static struct btrfs_fs_devices *find_fsid_reverted_metadata(
>  
>  	return NULL;
>  }
> +
> +static void prepare_virtual_fsid(struct btrfs_super_block *disk_super,
> +				 const char *path)
> +{
> +	struct btrfs_fs_devices *fs_devices;
> +	u8 vfsid[BTRFS_FSID_SIZE];
> +	bool dup_fsid = true;
> +
> +	while (dup_fsid) {
> +		dup_fsid = false;
> +		generate_random_uuid(vfsid);
> +
> +		list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
> +			if (!memcmp(vfsid, fs_devices->fsid, BTRFS_FSID_SIZE) ||
> +			    !memcmp(vfsid, fs_devices->metadata_uuid,
> +				    BTRFS_FSID_SIZE))
> +				dup_fsid = true;
> +		}
> +	}
> +
> +	memcpy(disk_super->metadata_uuid, disk_super->fsid, BTRFS_FSID_SIZE);
> +	memcpy(disk_super->fsid, vfsid, BTRFS_FSID_SIZE);
> +
> +	pr_info("BTRFS: virtual fsid (%pU) set for SINGLE_DEV device %s (real fsid %pU)\n",
> +		disk_super->fsid, path, disk_super->metadata_uuid);

I think just

btrfs_info(NULL, "virtual fsid....")

is fine here.

> +}
> +
>  /*
> - * Add new device to list of registered devices
> + * Add new device to list of registered devices, or in case of a SINGLE_DEV
> + * device, also creates a virtual fsid to cope with same-fsid cases.
>   *
>   * Returns:
>   * device pointer which was just added or updated when successful
> @@ -784,7 +814,7 @@ static struct btrfs_fs_devices *find_fsid_reverted_metadata(
>   */
>  static noinline struct btrfs_device *device_list_add(const char *path,
>  			   struct btrfs_super_block *disk_super,
> -			   bool *new_device_added)
> +			   bool *new_device_added, bool single_dev)

Same as the comment above.  Generally speaking for stuff like this where we can
derive the value local to the function we want to do that instead of growing the
argument list.  Thanks,

Josef
