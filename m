Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3B71F1BE7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 17:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbgFHPTq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 11:19:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:59478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgFHPTq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:19:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 78B3DAC77;
        Mon,  8 Jun 2020 15:19:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5D4DA1E1283; Mon,  8 Jun 2020 17:19:43 +0200 (CEST)
Date:   Mon, 8 Jun 2020 17:19:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: Rearrange fast path to minimise overhead when
 there is no watcher
Message-ID: <20200608151943.GA861@quack2.suse.cz>
References: <20200608140557.GG3127@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608140557.GG3127@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 08-06-20 15:05:57, Mel Gorman wrote:
> The fsnotify paths are trivial to hit even when there are no watchers and
> they are surprisingly expensive. For example, every successful vfs_write()
> hits fsnotify_modify which calls both fsnotify_parent and fsnotify unless
> FMODE_NONOTIFY is set which is an internal flag invisible to userspace.
> As it stands, fsnotify_parent is a guaranteed functional call even if there
> are no watchers and fsnotify() does a substantial amount of unnecessary
> work before it checks if there are any watchers. A perf profile showed
> that applying mnt->mnt_fsnotify_mask in fnotify() was almost half of the
> total samples taken in that function during a test. This patch rearranges
> the fast paths to reduce the amount of work done when there are no watchers.
> 
> The test motivating this was "perf bench sched messaging --pipe". Despite
> the fact the pipes are anonymous, fsnotify is still called a lot and
> the overhead is noticable even though it's completely pointless. It's
> likely the overhead is negligible for real IO so this is an extreme
> example. This is a comparison of hackbench using processes and pipes on
> a 1-socket machine with 8 CPU threads without fanotify watchers.
> 
>                               5.7.0                  5.7.0
>                             vanilla      fastfsnotify-v1r1
> Amean     1       0.4837 (   0.00%)      0.4630 *   4.27%*
> Amean     3       1.5447 (   0.00%)      1.4557 (   5.76%)
> Amean     5       2.6037 (   0.00%)      2.4363 (   6.43%)
> Amean     7       3.5987 (   0.00%)      3.4757 (   3.42%)
> Amean     12      5.8267 (   0.00%)      5.6983 (   2.20%)
> Amean     18      8.4400 (   0.00%)      8.1327 (   3.64%)
> Amean     24     11.0187 (   0.00%)     10.0290 *   8.98%*
> Amean     30     13.1013 (   0.00%)     12.8510 (   1.91%)
> Amean     32     13.9190 (   0.00%)     13.2410 (   4.87%)
> 
>                        5.7.0       5.7.0
>                      vanilla fastfsnotify-v1r1
> Duration User         157.05      152.79
> Duration System      1279.98     1219.32
> Duration Elapsed      182.81      174.52
> 
> This is showing that the latencies are improved by roughly 2-9%. The
> variability is not shown but some of these results are within the noise
> as this workload heavily overloads the machine. That said, the system CPU
> usage is reduced by quite a bit so it makes sense to avoid the overhead
> even if it is a bit tricky to detect at times. A perf profile of just 1
> group of tasks showed that 5.14% of samples taken were in either fsnotify()
> or fsnotify_parent(). With the patch, 2.8% of samples were in fsnotify,
> mostly function entry and the initial check for watchers.  The check for
> watchers is complicated enough that inlining it may be controversial.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Thanks for the patch! I have to tell I'm surprised this small reordering
helps so much. For pipe inode we will bail on:

       if (!to_tell->i_fsnotify_marks && !sb->s_fsnotify_marks &&
           (!mnt || !mnt->mnt_fsnotify_marks))
               return 0;

So what we save with the reordering is sb->s_fsnotify_mask and
mnt->mnt_fsnotify_mask fetch but that should be the same cacheline as
sb->s_fsnotify_marks and mnt->mnt_fsnotify_marks, respectively. We also
save a function call of fsnotify_parent() but I would think that is very
cheap (compared to the whole write path) as well.

The patch is simple enough so I have no problem merging it but I'm just
surprised by the results... Hum, maybe the structure randomization is used
in the builds and so e.g. sb->s_fsnotify_mask and sb->s_fsnotify_marks
don't end up in the same cacheline? But I don't think we enable that in
SUSE builds?

								Honza


> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 72d332ce8e12..de7bbfd973c0 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -143,7 +143,7 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
>  }
>  
>  /* Notify this dentry's parent about a child's events. */
> -int fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
> +int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
>  		    int data_type)
>  {
>  	struct dentry *parent;
> @@ -174,7 +174,7 @@ int fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(fsnotify_parent);
> +EXPORT_SYMBOL_GPL(__fsnotify_parent);
>  
>  static int send_to_group(struct inode *to_tell,
>  			 __u32 mask, const void *data,
> @@ -315,17 +315,12 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
>  	struct fsnotify_iter_info iter_info = {};
>  	struct super_block *sb = to_tell->i_sb;
>  	struct mount *mnt = NULL;
> -	__u32 mnt_or_sb_mask = sb->s_fsnotify_mask;
> +	__u32 mnt_or_sb_mask;
>  	int ret = 0;
> -	__u32 test_mask = (mask & ALL_FSNOTIFY_EVENTS);
> +	__u32 test_mask;
>  
> -	if (path) {
> +	if (path)
>  		mnt = real_mount(path->mnt);
> -		mnt_or_sb_mask |= mnt->mnt_fsnotify_mask;
> -	}
> -	/* An event "on child" is not intended for a mount/sb mark */
> -	if (mask & FS_EVENT_ON_CHILD)
> -		mnt_or_sb_mask = 0;
>  
>  	/*
>  	 * Optimization: srcu_read_lock() has a memory barrier which can
> @@ -337,11 +332,21 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
>  	if (!to_tell->i_fsnotify_marks && !sb->s_fsnotify_marks &&
>  	    (!mnt || !mnt->mnt_fsnotify_marks))
>  		return 0;
> +
> +	/* An event "on child" is not intended for a mount/sb mark */
> +	mnt_or_sb_mask = 0;
> +	if (!(mask & FS_EVENT_ON_CHILD)) {
> +		mnt_or_sb_mask = sb->s_fsnotify_mask;
> +		if (path)
> +			mnt_or_sb_mask |= mnt->mnt_fsnotify_mask;
> +	}
> +
>  	/*
>  	 * if this is a modify event we may need to clear the ignored masks
>  	 * otherwise return if neither the inode nor the vfsmount/sb care about
>  	 * this type of event.
>  	 */
> +	test_mask = (mask & ALL_FSNOTIFY_EVENTS);
>  	if (!(mask & FS_MODIFY) &&
>  	    !(test_mask & (to_tell->i_fsnotify_mask | mnt_or_sb_mask)))
>  		return 0;
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 5ab28f6c7d26..508f6bb0b06b 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -44,6 +44,16 @@ static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
>  	fsnotify_name(dir, mask, d_inode(dentry), &dentry->d_name, 0);
>  }
>  
> +/* Notify this dentry's parent about a child's events. */
> +static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
> +				  const void *data, int data_type)
> +{
> +	if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
> +		return 0;
> +
> +	return __fsnotify_parent(dentry, mask, data, data_type);
> +}
> +
>  /*
>   * Simple wrappers to consolidate calls fsnotify_parent()/fsnotify() when
>   * an event is on a file/dentry.
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index f0c506405b54..1626fa7d10ff 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -379,7 +379,7 @@ struct fsnotify_mark {
>  /* main fsnotify call to send events */
>  extern int fsnotify(struct inode *to_tell, __u32 mask, const void *data,
>  		    int data_type, const struct qstr *name, u32 cookie);
> -extern int fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
> +extern int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
>  			   int data_type);
>  extern void __fsnotify_inode_delete(struct inode *inode);
>  extern void __fsnotify_vfsmount_delete(struct vfsmount *mnt);
> @@ -541,7 +541,7 @@ static inline int fsnotify(struct inode *to_tell, __u32 mask, const void *data,
>  	return 0;
>  }
>  
> -static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
> +static inline int __fsnotify_parent(struct dentry *dentry, __u32 mask,
>  				  const void *data, int data_type)
>  {
>  	return 0;
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
