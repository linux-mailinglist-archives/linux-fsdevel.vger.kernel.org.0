Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDB5EB59B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 17:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfJaQ7I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 12:59:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:36280 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728597AbfJaQ7I (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:59:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3B4AB355;
        Thu, 31 Oct 2019 16:59:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CC7811E482D; Thu, 31 Oct 2019 17:59:05 +0100 (CET)
Date:   Thu, 31 Oct 2019 17:59:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dmitry Monakhov <dmonakhov@openvz.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        lixi@ddn.com, Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: [PATCH] fs/ext4: get project quota from inode for mangling
 statfs results
Message-ID: <20191031165905.GE13321@quack2.suse.cz>
References: <20191031110348.6991-1-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031110348.6991-1-dmonakhov@openvz.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 31-10-19 11:03:48, Dmitry Monakhov wrote:
> From: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
> 
> Right now ext4_statfs_project() does quota lookup by id every time.
> This is costly operation, especially if there is no inode who hold
> reference to this dquot. This means that each statfs performs useless
> ext4_acquire_dquot()/ext4_release_dquot() which serialized on __jbd2_log_wait_for_space()
> dqget()
>  ->ext4_acquire_dquot
>    -> ext4_journal_start
>       -> __jbd2_log_wait_for_space
> dqput()
>   -> ext4_release_dquot
>      ->ext4_journal_start
>        ->__jbd2_log_wait_for_space
> 
> 
> Function ext4_statfs_project() could be moved into generic quota code,
> it is required for every filesystem which uses generic project quota.
> 
> Reported-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Thanks! The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/ext4/super.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 2318e5f..4e8f97d68 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5532,18 +5532,23 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>  }
>  
>  #ifdef CONFIG_QUOTA
> -static int ext4_statfs_project(struct super_block *sb,
> -			       kprojid_t projid, struct kstatfs *buf)
> +static int ext4_statfs_project(struct inode *inode, struct kstatfs *buf)
>  {
> -	struct kqid qid;
> +	struct super_block *sb = inode->i_sb;
>  	struct dquot *dquot;
>  	u64 limit;
>  	u64 curblock;
> +	int err;
> +
> +	err = dquot_initialize(inode);
> +	if (err)
> +		return err;
> +
> +	spin_lock(&inode->i_lock);
> +	dquot = ext4_get_dquots(inode)[PRJQUOTA];
> +	if (!dquot)
> +		goto out_unlock;
>  
> -	qid = make_kqid_projid(projid);
> -	dquot = dqget(sb, qid);
> -	if (IS_ERR(dquot))
> -		return PTR_ERR(dquot);
>  	spin_lock(&dquot->dq_dqb_lock);
>  
>  	limit = (dquot->dq_dqb.dqb_bsoftlimit ?
> @@ -5569,7 +5574,9 @@ static int ext4_statfs_project(struct super_block *sb,
>  	}
>  
>  	spin_unlock(&dquot->dq_dqb_lock);
> -	dqput(dquot);
> +out_unlock:
> +	spin_unlock(&inode->i_lock);
> +
>  	return 0;
>  }
>  #endif
> @@ -5609,7 +5616,7 @@ static int ext4_statfs(struct dentry *dentry, struct kstatfs *buf)
>  #ifdef CONFIG_QUOTA
>  	if (ext4_test_inode_flag(dentry->d_inode, EXT4_INODE_PROJINHERIT) &&
>  	    sb_has_quota_limits_enabled(sb, PRJQUOTA))
> -		ext4_statfs_project(sb, EXT4_I(dentry->d_inode)->i_projid, buf);
> +		ext4_statfs_project(dentry->d_inode, buf);
>  #endif
>  	return 0;
>  }
> -- 
> 2.7.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
