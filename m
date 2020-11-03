Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7B62A458C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 13:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgKCMuP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 07:50:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:49338 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgKCMuP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:50:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6CEF7ABF4;
        Tue,  3 Nov 2020 12:50:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 628DCDA7D2; Tue,  3 Nov 2020 13:48:35 +0100 (CET)
Date:   Tue, 3 Nov 2020 13:48:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 07/41] btrfs: disallow space_cache in ZONED mode
Message-ID: <20201103124834.GR6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
References: <cover.1604065156.git.naohiro.aota@wdc.com>
 <f0a4ae9168940bf1756f89a140cabedb8972e0d1.1604065695.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0a4ae9168940bf1756f89a140cabedb8972e0d1.1604065695.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 30, 2020 at 10:51:14PM +0900, Naohiro Aota wrote:
> INODE_MAP_CACHE inode.
> 
> In summary, ZONED will disable:
> 
> | Disabled features | Reason                                              |
> |-------------------+-----------------------------------------------------|
> | RAID/Dup          | Cannot handle two zone append writes to different   |
> |                   | zones                                               |
> |-------------------+-----------------------------------------------------|
> | space_cache (v1)  | In-place updating                                   |
> | NODATACOW         | In-place updating                                   |
> |-------------------+-----------------------------------------------------|
> | fallocate         | Reserved extent will be a write hole                |
> | INODE_MAP_CACHE   | Need pre-allocation. (and will be deprecated?)      |

space_cache is deprecated and actually in current dev cycle (5.11)

> |-------------------+-----------------------------------------------------|
> | MIXED_BG          | Allocated metadata region will be write holes for   |
> |                   | data writes                                         |
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/super.c | 12 ++++++++++--
>  fs/btrfs/zoned.c | 18 ++++++++++++++++++
>  fs/btrfs/zoned.h |  5 +++++
>  3 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 3312fe08168f..9064ca62b0a0 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -525,8 +525,14 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>  	cache_gen = btrfs_super_cache_generation(info->super_copy);
>  	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
>  		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
> -	else if (cache_gen)
> -		btrfs_set_opt(info->mount_opt, SPACE_CACHE);
> +	else if (cache_gen) {
> +		if (btrfs_is_zoned(info)) {
> +			btrfs_info(info,
> +			"clearring existing space cache in ZONED mode");

			"zoned: clearing existing space cache"

Is it clearing or just invalidating it? We have the same problem with
enabling v2 so this could share some code once Boris' patches are
merged.

> +			btrfs_set_super_cache_generation(info->super_copy, 0);
> +		} else

		} else {

> +			btrfs_set_opt(info->mount_opt, SPACE_CACHE);

		}
> +	}
>  
>  	/*
>  	 * Even the options are empty, we still need to do extra check

> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -265,3 +265,21 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>  out:
>  	return ret;
>  }
> +
> +int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
> +{
> +	if (!btrfs_is_zoned(info))
> +		return 0;
> +
> +	/*
> +	 * SPACE CACHE writing is not CoWed. Disable that to avoid write

	 * Space cache writing is nod COWed. ...

> +	 * errors in sequential zones.
> +	 */
> +	if (btrfs_test_opt(info, SPACE_CACHE)) {
> +		btrfs_err(info,
> +			  "space cache v1 not supportted in ZONED mode");

		"zoned: space cache v1 is not supported"

> +		return -EOPNOTSUPP;

This should be EINVAL, like invalid cobination. EOPNOTSUPP is for cases
where it's not supported but could be if implemented.

> +	}
> +
> +	return 0;
> +}
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index a63f6177f9ee..0b7756a7104d 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -24,6 +24,7 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>  int btrfs_get_dev_zone_info(struct btrfs_device *device);
>  void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
>  int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
> +int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info);
>  #else /* CONFIG_BLK_DEV_ZONED */
>  static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>  				     struct blk_zone *zone)
> @@ -43,6 +44,10 @@ static inline int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>  	btrfs_err(fs_info, "Zoned block devices support is not enabled");
>  	return -EOPNOTSUPP;
>  }

newline

> +static inline int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
> +{
> +	return 0;
> +}

newline

>  #endif
>  
>  static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
