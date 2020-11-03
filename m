Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F15D2A45CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 13:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgKCM7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 07:59:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:57904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728721AbgKCM7R (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:59:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 20A6AAC6F;
        Tue,  3 Nov 2020 12:59:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5547CDA7D2; Tue,  3 Nov 2020 13:57:37 +0100 (CET)
Date:   Tue, 3 Nov 2020 13:57:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v9 08/41] btrfs: disallow NODATACOW in ZONED mode
Message-ID: <20201103125737.GS6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1604065156.git.naohiro.aota@wdc.com>
 <4129ba21e887cff5dc707b34920fb825ca1c61a4.1604065695.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4129ba21e887cff5dc707b34920fb825ca1c61a4.1604065695.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 30, 2020 at 10:51:15PM +0900, Naohiro Aota wrote:
>  
> +static int check_fsflags_compatible(struct btrfs_fs_info *fs_info,
> +				    unsigned int flags)
> +{
> +	bool zoned = btrfs_is_zoned(fs_info);

No need for variable when it's one time use.

> +
> +	if (zoned && (flags & FS_NOCOW_FL))
> +		return -EPERM;
> +
> +	return 0;
> +}
> +
> +
>  static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
>  {
>  	struct inode *inode = file_inode(file);
> @@ -230,6 +242,10 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
>  	if (ret)
>  		goto out_unlock;
>  
> +	ret = check_fsflags_compatible(fs_info, fsflags);
> +	if (ret)
> +		goto out_unlock;

This is called under inode lock although it technically does not need
to but I don't see a problem it logically fits to the sequence and
rarely fails.

> +
>  	binode_flags = binode->flags;
>  	if (fsflags & FS_SYNC_FL)
>  		binode_flags |= BTRFS_INODE_SYNC;
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 3885fa327049..1939b3ee6c10 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -281,5 +281,11 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
>  		return -EOPNOTSUPP;
>  	}
>  
> +	if (btrfs_test_opt(info, NODATACOW)) {
> +		btrfs_err(info,
> +		  "cannot enable nodatacow with ZONED mode");

		"zoned: NODATACOW not supported"

Eventually all incompatible features will use same message style, there
may be more in the patchset

> +		return -EOPNOTSUPP;

Also EINVAL

> +	}
> +
>  	return 0;
>  }
> -- 
> 2.27.0
