Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74AABF1341
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 11:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfKFKFR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 05:05:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:54526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726143AbfKFKFR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 05:05:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 903CDB35D;
        Wed,  6 Nov 2019 10:05:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 469741E47E5; Wed,  6 Nov 2019 11:05:15 +0100 (CET)
Date:   Wed, 6 Nov 2019 11:05:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/7] quota: Allow to pass mount path to quotactl
Message-ID: <20191106100515.GC16085@quack2.suse.cz>
References: <20191106091537.32480-1-s.hauer@pengutronix.de>
 <20191106091537.32480-2-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106091537.32480-2-s.hauer@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 06-11-19 10:15:31, Sascha Hauer wrote:
> This patch introduces the Q_PATH flag to the quotactl cmd argument.
> When given, the path given in the special argument to quotactl will
> be the mount path where the filesystem is mounted, instead of a path
> to the block device.
> This is necessary for filesystems which do not have a block device as
> backing store. Particularly this is done for upcoming UBIFS support.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

It seems you forgot to implement changes I've asked for in [1]?

[1] https://lore.kernel.org/linux-fsdevel/20191101160706.GA23441@quack2.suse.cz

								Honza
> ---
>  fs/quota/quota.c           | 37 ++++++++++++++++++++++++++++---------
>  include/uapi/linux/quota.h |  1 +
>  2 files changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> index cb13fb76dbee..035cdd1b022b 100644
> --- a/fs/quota/quota.c
> +++ b/fs/quota/quota.c
> @@ -19,6 +19,7 @@
>  #include <linux/types.h>
>  #include <linux/writeback.h>
>  #include <linux/nospec.h>
> +#include <linux/mount.h>
>  
>  static int check_quotactl_permission(struct super_block *sb, int type, int cmd,
>  				     qid_t id)
> @@ -825,12 +826,16 @@ int kernel_quotactl(unsigned int cmd, const char __user *special,
>  {
>  	uint cmds, type;
>  	struct super_block *sb = NULL;
> -	struct path path, *pathp = NULL;
> +	struct path path, *pathp = NULL, qpath;
>  	int ret;
> +	bool q_path;
>  
>  	cmds = cmd >> SUBCMDSHIFT;
>  	type = cmd & SUBCMDMASK;
>  
> +	q_path = cmds & Q_PATH;
> +	cmds &= ~Q_PATH;
> +
>  	/*
>  	 * As a special case Q_SYNC can be called without a specific device.
>  	 * It will iterate all superblocks that have quota enabled and call
> @@ -855,19 +860,33 @@ int kernel_quotactl(unsigned int cmd, const char __user *special,
>  			pathp = &path;
>  	}
>  
> -	sb = quotactl_block(special, cmds);
> -	if (IS_ERR(sb)) {
> -		ret = PTR_ERR(sb);
> -		goto out;
> +	if (q_path) {
> +		ret = user_path_at(AT_FDCWD, special, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT,
> +				   &qpath);
> +		if (ret)
> +			goto out1;
> +
> +		sb = qpath.mnt->mnt_sb;
> +	} else {
> +		sb = quotactl_block(special, cmds);
> +		if (IS_ERR(sb)) {
> +			ret = PTR_ERR(sb);
> +			goto out;
> +		}
>  	}
>  
>  	ret = do_quotactl(sb, type, cmds, id, addr, pathp);
>  
> -	if (!quotactl_cmd_onoff(cmds))
> -		drop_super(sb);
> -	else
> -		drop_super_exclusive(sb);
> +	if (!q_path) {
> +		if (!quotactl_cmd_onoff(cmds))
> +			drop_super(sb);
> +		else
> +			drop_super_exclusive(sb);
> +	}
>  out:
> +	if (q_path)
> +		path_put(&qpath);
> +out1:
>  	if (pathp && !IS_ERR(pathp))
>  		path_put(pathp);
>  	return ret;
> diff --git a/include/uapi/linux/quota.h b/include/uapi/linux/quota.h
> index f17c9636a859..e1787c0df601 100644
> --- a/include/uapi/linux/quota.h
> +++ b/include/uapi/linux/quota.h
> @@ -71,6 +71,7 @@
>  #define Q_GETQUOTA 0x800007	/* get user quota structure */
>  #define Q_SETQUOTA 0x800008	/* set user quota structure */
>  #define Q_GETNEXTQUOTA 0x800009	/* get disk limits and usage >= ID */
> +#define Q_PATH     0x400000	/* quotactl special arg contains mount path */
>  
>  /* Quota format type IDs */
>  #define	QFMT_VFS_OLD 1
> -- 
> 2.24.0.rc1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
