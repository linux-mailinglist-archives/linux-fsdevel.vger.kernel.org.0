Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0241D2E98
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 13:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgENLnq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 07:43:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:48506 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgENLnq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 07:43:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 705B3ACCE;
        Thu, 14 May 2020 11:25:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EB8E81E12A8; Thu, 14 May 2020 13:25:53 +0200 (CEST)
Date:   Thu, 14 May 2020 13:25:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     ira.weiny@intel.com
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 7/9] fs/ext4: Make DAX mount option a tri-state
Message-ID: <20200514112553.GH9569@quack2.suse.cz>
References: <20200514065316.2500078-1-ira.weiny@intel.com>
 <20200514065316.2500078-8-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514065316.2500078-8-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 13-05-20 23:53:13, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> We add 'always', 'never', and 'inode' (default).  '-o dax' continue to
> operate the same.
> 
> Specifically we introduce a 2nd DAX mount flag EXT4_MOUNT2_DAX_NEVER and set
> it and EXT4_MOUNT_DAX_ALWAYS appropriately.
> 
> We also force EXT4_MOUNT2_DAX_NEVER if !CONFIG_FS_DAX.
> 
> https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from RFC:
> 	Combine remount check for DAX_NEVER with DAX_ALWAYS
> 	Update ext4_should_enable_dax()

...

> @@ -2076,13 +2079,32 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
>  		}
>  		sbi->s_jquota_fmt = m->mount_opt;
>  #endif
> -	} else if (token == Opt_dax) {
> +	} else if (token == Opt_dax || token == Opt_dax_str) {
>  #ifdef CONFIG_FS_DAX
> -		ext4_msg(sb, KERN_WARNING,
> -		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> -		sbi->s_mount_opt |= m->mount_opt;
> +		char *tmp = match_strdup(&args[0]);
> +
> +		if (!tmp || !strcmp(tmp, "always")) {
> +			ext4_msg(sb, KERN_WARNING,
> +				"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> +			sbi->s_mount_opt |= EXT4_MOUNT_DAX_ALWAYS;
> +			sbi->s_mount_opt2 &= ~EXT4_MOUNT2_DAX_NEVER;
> +		} else if (!strcmp(tmp, "never")) {
> +			sbi->s_mount_opt2 |= EXT4_MOUNT2_DAX_NEVER;
> +			sbi->s_mount_opt &= ~EXT4_MOUNT_DAX_ALWAYS;
> +		} else if (!strcmp(tmp, "inode")) {
> +			sbi->s_mount_opt &= ~EXT4_MOUNT_DAX_ALWAYS;
> +			sbi->s_mount_opt2 &= ~EXT4_MOUNT2_DAX_NEVER;
> +		} else {
> +			ext4_msg(sb, KERN_WARNING, "DAX invalid option.");
> +			kfree(tmp);
> +			return -1;
> +		}
> +
> +		kfree(tmp);

As I wrote in my reply to previous version of this patch, I'd prefer if we
handled this like e.g. 'data=' mount option. I don't think any unification
in option parsing with XFS makes sence and I'd rather keep consistent how
ext4 handles these 'enum' options.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
