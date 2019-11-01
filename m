Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 987C1EC83E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 19:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfKASHY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 14:07:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:37552 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726991AbfKASHX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 14:07:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8235CB4C3;
        Fri,  1 Nov 2019 18:07:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 27A751E482F; Fri,  1 Nov 2019 19:07:21 +0100 (CET)
Date:   Fri, 1 Nov 2019 19:07:21 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>,
        kernel@pengutronix.de
Subject: Re: [PATCH 01/10] quota: Make inode optional
Message-ID: <20191101180721.GB23441@quack2.suse.cz>
References: <20191030152702.14269-1-s.hauer@pengutronix.de>
 <20191030152702.14269-2-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030152702.14269-2-s.hauer@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 30-10-19 16:26:53, Sascha Hauer wrote:
> To add support for filesystems which do not store quota informations in
> an inode make the inode optional.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Umm, I don't quite like how the first three patches work out. I have
somewhat refactored quota code to make things nicer and allow enabling of
quotas only with superblock at hand. I'll post the patches once they pass
some testing early next week.

								Honza

> ---
>  fs/quota/dquot.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 6e826b454082..59f31735fe79 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -2313,11 +2313,11 @@ static int vfs_load_quota_inode(struct inode *inode, int type, int format_id,
>  
>  	if (!fmt)
>  		return -ESRCH;
> -	if (!S_ISREG(inode->i_mode)) {
> +	if (inode && !S_ISREG(inode->i_mode)) {
>  		error = -EACCES;
>  		goto out_fmt;
>  	}
> -	if (IS_RDONLY(inode)) {
> +	if (inode && IS_RDONLY(inode)) {
>  		error = -EROFS;
>  		goto out_fmt;
>  	}
> @@ -2352,7 +2352,7 @@ static int vfs_load_quota_inode(struct inode *inode, int type, int format_id,
>  		invalidate_bdev(sb->s_bdev);
>  	}
>  
> -	if (!(dqopt->flags & DQUOT_QUOTA_SYS_FILE)) {
> +	if (inode && !(dqopt->flags & DQUOT_QUOTA_SYS_FILE)) {
>  		/* We don't want quota and atime on quota files (deadlocks
>  		 * possible) Also nobody should write to the file - we use
>  		 * special IO operations which ignore the immutable bit. */
> @@ -2367,9 +2367,13 @@ static int vfs_load_quota_inode(struct inode *inode, int type, int format_id,
>  	}
>  
>  	error = -EIO;
> -	dqopt->files[type] = igrab(inode);
> -	if (!dqopt->files[type])
> -		goto out_file_flags;
> +
> +	if (inode) {
> +		dqopt->files[type] = igrab(inode);
> +		if (!dqopt->files[type])
> +			goto out_file_flags;
> +	}
> +
>  	error = -EINVAL;
>  	if (!fmt->qf_ops->check_quota_file(sb, type))
>  		goto out_file_init;
> @@ -2397,11 +2401,14 @@ static int vfs_load_quota_inode(struct inode *inode, int type, int format_id,
>  	return error;
>  out_file_init:
>  	dqopt->files[type] = NULL;
> -	iput(inode);
> +	if (inode)
> +		iput(inode);
>  out_file_flags:
> -	inode_lock(inode);
> -	inode->i_flags &= ~S_NOQUOTA;
> -	inode_unlock(inode);
> +	if (inode) {
> +		inode_lock(inode);
> +		inode->i_flags &= ~S_NOQUOTA;
> +		inode_unlock(inode);
> +	}
>  out_fmt:
>  	put_quota_format(fmt);
>  
> @@ -2800,8 +2807,10 @@ int dquot_get_state(struct super_block *sb, struct qc_state *state)
>  			tstate->flags |= QCI_LIMITS_ENFORCED;
>  		tstate->spc_timelimit = mi->dqi_bgrace;
>  		tstate->ino_timelimit = mi->dqi_igrace;
> -		tstate->ino = dqopt->files[type]->i_ino;
> -		tstate->blocks = dqopt->files[type]->i_blocks;
> +		if (dqopt->files[type]) {
> +			tstate->ino = dqopt->files[type]->i_ino;
> +			tstate->blocks = dqopt->files[type]->i_blocks;
> +		}
>  		tstate->nextents = 1;	/* We don't know... */
>  		spin_unlock(&dq_data_lock);
>  	}
> -- 
> 2.24.0.rc1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
