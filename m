Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A888438EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732899AbfFMPJw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:09:52 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39271 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732348AbfFMN5O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:57:14 -0400
Received: by mail-qk1-f194.google.com with SMTP id i125so12781248qkd.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2019 06:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f8oWkNqIH/DyMOHXpAxjAXd9mO+eys1GPI1tYBrhm3o=;
        b=slju5Mk6NV/PybHINi/s0pm6qI/7D6HmQM7KjmNLHuc4tFszrsyyy2yzDtVxHIyZXU
         D16qWNlslGJsEDu9eDPf3JwbhandiXXH++FTeppARL3Qd/NiqI5Pp2oCtFEZhIAwLyUv
         yeeTLdKcReDi3yCS+hpmrO9v6m1Cue5zcQwZ7NMqUeGI09kjehpUfvP/YAp+4+5/1aHs
         yJCLWDijzSXk/Vb0zuf0I0T+fN/Axvx4dP/JbBiWZxiHsw8xEqHo/XuCklQnd+DUeRQn
         bvbiuPQMt6+MjmCX57lD2xIeNihagvn8rpuGrrJSKJkTh66ndPXMZmwj2z7rOEgjWcLW
         UvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f8oWkNqIH/DyMOHXpAxjAXd9mO+eys1GPI1tYBrhm3o=;
        b=V8g2EmPwY/vVmX8/xn5MxMPpvHaST29gRHXk/d8IqCsBVvjXweCEN2LX+k+w867cDl
         OTx1Hjmt6FChfH8MKFAPynNQOhIgyHQcXt7dhQTgvGJ9dhGzLTweLf1r1LX0NExBvcYE
         yNiH9fclKzrfLNMw6Xzt5ZiYdBvX4C+FKfWCUpAgZSXO2kuB7asWiwwqRXwuJkVkyQdA
         KQnFR1IKtZKZByOGD88hJrT/jvOXcUsN3y1BeMIzbW4VWLAEMPo7GHFs7KKOsS2B1GTJ
         xYHrBHvfEMbIB5uq4dqUrkxolt0qCJCAl78JO6XKD09kMLzEbRtVbM4QOSvaZeGXiiNw
         tQ3Q==
X-Gm-Message-State: APjAAAXV6RT/r0H1XYV5fThKCLE1tT131QiDdWmYF/aCHQOcnWhl6yOX
        eXDcFJd9HUy5E8IEviWZ2235xA==
X-Google-Smtp-Source: APXvYqxGT1il2X6VOFbyz2RJsVGEMTFswkGE2VcTUWavs7aHJ61x1eQsmlCA1IQqdvrv4u7hG1Ld+w==
X-Received: by 2002:ae9:f303:: with SMTP id p3mr5719058qkg.320.1560434233077;
        Thu, 13 Jun 2019 06:57:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::9d6b])
        by smtp.gmail.com with ESMTPSA id m44sm1846636qtm.54.2019.06.13.06.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 06:57:12 -0700 (PDT)
Date:   Thu, 13 Jun 2019 09:57:11 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 03/19] btrfs: Check and enable HMZONED mode
Message-ID: <20190613135710.nu5r5bpcwdm4we2w@MacBook-Pro-91.local>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-4-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607131025.31996-4-naohiro.aota@wdc.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 07, 2019 at 10:10:09PM +0900, Naohiro Aota wrote:
> HMZONED mode cannot be used together with the RAID5/6 profile for now.
> Introduce the function btrfs_check_hmzoned_mode() to check this. This
> function will also check if HMZONED flag is enabled on the file system and
> if the file system consists of zoned devices with equal zone size.
> 
> Additionally, as updates to the space cache are in-place, the space cache
> cannot be located over sequential zones and there is no guarantees that the
> device will have enough conventional zones to store this cache. Resolve
> this problem by disabling completely the space cache.  This does not
> introduces any problems with sequential block groups: all the free space is
> located after the allocation pointer and no free space before the pointer.
> There is no need to have such cache.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/ctree.h       |  3 ++
>  fs/btrfs/dev-replace.c |  7 +++
>  fs/btrfs/disk-io.c     |  7 +++
>  fs/btrfs/super.c       | 12 ++---
>  fs/btrfs/volumes.c     | 99 ++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/volumes.h     |  1 +
>  6 files changed, 124 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index b81c331b28fa..6c00101407e4 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -806,6 +806,9 @@ struct btrfs_fs_info {
>  	struct btrfs_root *uuid_root;
>  	struct btrfs_root *free_space_root;
>  
> +	/* Zone size when in HMZONED mode */
> +	u64 zone_size;
> +
>  	/* the log root tree is a directory of all the other log roots */
>  	struct btrfs_root *log_root_tree;
>  
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index ee0989c7e3a9..fbe5ea2a04ed 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -201,6 +201,13 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>  		return PTR_ERR(bdev);
>  	}
>  
> +	if ((bdev_zoned_model(bdev) == BLK_ZONED_HM &&
> +	     !btrfs_fs_incompat(fs_info, HMZONED)) ||
> +	    (!bdev_is_zoned(bdev) && btrfs_fs_incompat(fs_info, HMZONED))) {

You do this in a few places, turn this into a helper please.

> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
>  	filemap_write_and_wait(bdev->bd_inode->i_mapping);
>  
>  	devices = &fs_info->fs_devices->devices;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 663efce22d98..7c1404c76768 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3086,6 +3086,13 @@ int open_ctree(struct super_block *sb,
>  
>  	btrfs_free_extra_devids(fs_devices, 1);
>  
> +	ret = btrfs_check_hmzoned_mode(fs_info);
> +	if (ret) {
> +		btrfs_err(fs_info, "failed to init hmzoned mode: %d",
> +				ret);
> +		goto fail_block_groups;
> +	}
> +
>  	ret = btrfs_sysfs_add_fsid(fs_devices, NULL);
>  	if (ret) {
>  		btrfs_err(fs_info, "failed to init sysfs fsid interface: %d",
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 2c66d9ea6a3b..740a701f16c5 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -435,11 +435,13 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>  	bool saved_compress_force;
>  	int no_compress = 0;
>  
> -	cache_gen = btrfs_super_cache_generation(info->super_copy);
> -	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
> -		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
> -	else if (cache_gen)
> -		btrfs_set_opt(info->mount_opt, SPACE_CACHE);
> +	if (!btrfs_fs_incompat(info, HMZONED)) {
> +		cache_gen = btrfs_super_cache_generation(info->super_copy);
> +		if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
> +			btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
> +		else if (cache_gen)
> +			btrfs_set_opt(info->mount_opt, SPACE_CACHE);
> +	}
>  

This disables the free space tree as well as the cache, sounds like you only
need to disable the free space cache?  Thanks,

Josef
