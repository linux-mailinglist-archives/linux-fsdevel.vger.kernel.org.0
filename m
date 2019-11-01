Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD197EC659
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 17:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfKAQHJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 12:07:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:36450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727229AbfKAQHJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 12:07:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D4BDB4B9;
        Fri,  1 Nov 2019 16:07:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F0F0D1E482F; Fri,  1 Nov 2019 17:07:06 +0100 (CET)
Date:   Fri, 1 Nov 2019 17:07:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>,
        kernel@pengutronix.de
Subject: Re: [PATCH 04/10] quota: Allow to pass mount path to quotactl
Message-ID: <20191101160706.GA23441@quack2.suse.cz>
References: <20191030152702.14269-1-s.hauer@pengutronix.de>
 <20191030152702.14269-5-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030152702.14269-5-s.hauer@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 30-10-19 16:26:56, Sascha Hauer wrote:
> This patch introduces the Q_PATH flag to the quotactl cmd argument.
> When given, the path given in the special argument to quotactl will
> be the mount path where the filesystem is mounted, instead of a path
> to the block device.
> This is necessary for filesystems which do not have a block device as
> backing store. Particularly this is done for upcoming UBIFS support.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Thanks for the patch! Some smaller comments below...

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

Maybe call these two 'file_path', 'file_pathp', and 'sb_path' to make it
clearer which path is which?

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

Why do you need out1? If you leave 'out' as is, things should just work.
And you can also combine the above if like:

	if (q_path) {
		path_put(&qpath);
	} else {
		if (!quotactl_cmd_onoff(cmds))
			drop_super(sb);
		else
			drop_super_exclusive(sb);
	}

which would then make it more obvious, what's actually going on...

Otherwise the patch looks good to me.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
