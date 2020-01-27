Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C245814A22F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgA0KpU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:45:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:50186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbgA0KpU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:45:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AF506ADE0;
        Mon, 27 Jan 2020 10:45:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 492081E0E4E; Mon, 27 Jan 2020 11:45:18 +0100 (CET)
Date:   Mon, 27 Jan 2020 11:45:18 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/8] quota: Allow to pass mount path to quotactl
Message-ID: <20200127104518.GC19414@quack2.suse.cz>
References: <20200124131323.23885-1-s.hauer@pengutronix.de>
 <20200124131323.23885-2-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124131323.23885-2-s.hauer@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 24-01-20 14:13:16, Sascha Hauer wrote:
> This patch introduces the Q_PATH flag to the quotactl cmd argument.
> When given, the path given in the special argument to quotactl will
> be the mount path where the filesystem is mounted, instead of a path
> to the block device.
> This is necessary for filesystems which do not have a block device as
> backing store. Particularly this is done for upcoming UBIFS support.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Thanks for the patch. Some comments are below.

> @@ -821,15 +822,20 @@ int kernel_quotactl(unsigned int cmd, const char __user *special,
>  {
>  	uint cmds, type;
>  	struct super_block *sb = NULL;
> -	struct path path, *pathp = NULL;
> +	struct path file_path, *file_pathp = NULL, sb_path;
>  	int ret;
> +	bool q_path;
>  
>  	cmds = cmd >> SUBCMDSHIFT;
>  	type = cmd & SUBCMDMASK;
>  
> +

Unnecessary empty line added...

>  	if (type >= MAXQUOTAS)
>  		return -EINVAL;
>  
> +	q_path = cmds & Q_PATH;
> +	cmds &= ~Q_PATH;
> +
>  	/*
>  	 * As a special case Q_SYNC can be called without a specific device.
>  	 * It will iterate all superblocks that have quota enabled and call
> @@ -847,28 +853,45 @@ int kernel_quotactl(unsigned int cmd, const char __user *special,
>  	 * resolution (think about autofs) and thus deadlocks could arise.
>  	 */
>  	if (cmds == Q_QUOTAON) {
> -		ret = user_path_at(AT_FDCWD, addr, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT, &path);
> +		ret = user_path_at(AT_FDCWD, addr,
> +				   LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT,
> +				   &file_path);
>  		if (ret)
> -			pathp = ERR_PTR(ret);
> +			file_pathp = ERR_PTR(ret);
>  		else
> -			pathp = &path;
> +			file_pathp = &file_path;
>  	}
>  
> -	sb = quotactl_block(special, cmds);
> -	if (IS_ERR(sb)) {
> -		ret = PTR_ERR(sb);
> -		goto out;
> +	if (q_path) {
> +		ret = user_path_at(AT_FDCWD, special,
> +				   LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT,
> +				   &sb_path);
> +		if (ret)
> +			goto out;
> +
> +		sb = sb_path.mnt->mnt_sb;

So I've realized that just looking up superblock with user_path_at() is not
enough. Quota code also expects that the superblock will be locked
(sb->s_umount) and filesystem will not be frozen (in case the quota
operation is going to modify the filesystem). This is needed to serialize
e.g. remount and quota operations or quota operations among themselves.
So you still need something like following to get superblock from the path:

static int quotactl_path(const char __user *special, int cmd, struct path *path)
{
	struct super_block *sb;

	ret = user_path_at(AT_FDCWD, special, LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT,
			   path);
	if (ret)
		return ret;
	sb = sb_path.mnt->mnt_sb;
restart:
	if (quotactl_cmd_onoff(cmd))
		down_write(&sb->s_umount);
	else
		down_read(&sb->s_umount);

	if (quotactl_cmd_write(cmd) && sb->s_writers.frozen != SB_UNFROZEN) {
		if (quotactl_cmd_onoff(cmd))
			up_write(&sb->s_umount);
		else
			up_read(&sb->s_umount);
		wait_event(sb->s_writers.wait_unfrozen,
			   sb->s_writers.frozen == SB_UNFROZEN);
		goto restart;

	}
	return sb;
}

And then appropriate counterparts when releasing the superblock.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
