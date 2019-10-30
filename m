Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13AC4E9A91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 12:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfJ3K74 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 06:59:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:38820 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726096AbfJ3K74 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 06:59:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B1740B188;
        Wed, 30 Oct 2019 10:59:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 157DC1E485C; Wed, 30 Oct 2019 11:59:53 +0100 (CET)
Date:   Wed, 30 Oct 2019 11:59:53 +0100
From:   Jan Kara <jack@suse.cz>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>, Li Xi <lixi@ddn.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH] fs/ext4: get project quota from inode for mangling
 statfs results
Message-ID: <20191030105953.GC28525@quack2.suse.cz>
References: <157225912326.3929.8539227851002947260.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157225912326.3929.8539227851002947260.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 28-10-19 13:38:43, Konstantin Khlebnikov wrote:
> Right now ext4_statfs_project() does quota lookup by id every time.
> This is costly operation, especially if there is no inode who hold
> reference to this quota and dqget() reads it from disk each time.
> 
> Function ext4_statfs_project() could be moved into generic quota code,
> it is required for every filesystem which uses generic project quota.
> 
> Reported-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  fs/ext4/super.c |   25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index dd654e53ba3d..f841c66aa499 100644
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

Hum, I'm kind of puzzled here: Your patch seems to be concerned with
performance but how is this any faster than what we do now?
dquot_initialize() will look up three dquots instead of one in the current
code? Oh, I guess you are concerned about *repeated* calls to statfs() and
thus repeated lookups of dquot structure? And this patch effectively caches
looked up dquots in the inode?

That starts to make some sense but still, even if dquot isn't cached in any
inode, we still hold on to it (it's in the free_list) until shrinker evicts
it. So lookup of such dquot should be just a hash table lookup which should
be very fast. Then there's the cost of dquot_acquire() / dquot_release()
that get always called on first / last get of a dquot. So are you concerned
about that cost? Or do you really see IO happening to fetch quota structure
on each statfs call again and again? The only situation where I could see
that happening is when the quota structure would be actually completely
empty (i.e., not originally present in the quota file). But then this
cannot be a case when there's actually an inode belonging to this
project...

So I'm really curious about the details of what you are seeing as the
changelog / patch doesn't quite make sense to me yet.

								Honza


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
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
