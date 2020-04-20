Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0761B0E8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 16:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbgDTOiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 10:38:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:60000 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbgDTOiL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:38:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5D00EABD7;
        Mon, 20 Apr 2020 14:38:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AB5561E0E4E; Mon, 20 Apr 2020 16:38:07 +0200 (CEST)
Date:   Mon, 20 Apr 2020 16:38:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, sandeen@sandeen.net
Subject: Re: [RFCv2 1/1] ext4: Fix race in ext4 mb discard group
 preallocations
Message-ID: <20200420143807.GE17130@quack2.suse.cz>
References: <cover.1586954511.git.riteshh@linux.ibm.com>
 <533ac1f5b19c520b08f8c99aec5baf8729185714.1586954511.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <533ac1f5b19c520b08f8c99aec5baf8729185714.1586954511.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 15-04-20 22:53:01, Ritesh Harjani wrote:
> There could be a race in function ext4_mb_discard_group_preallocations()
> where the 1st thread may iterate through group's bb_prealloc_list and
> remove all the PAs and add to function's local list head.
> Now if the 2nd thread comes in to discard the group preallocations,
> it will see that the group->bb_prealloc_list is empty and will return 0.
> 
> Consider for a case where we have less number of groups (for e.g. just group 0),
> this may even return an -ENOSPC error from ext4_mb_new_blocks()
> (where we call for ext4_mb_discard_group_preallocations()).
> But that is wrong, since 2nd thread should have waited for 1st thread to release
> all the PAs and should have retried for allocation. Since 1st thread
> was anyway going to discard the PAs.
> 
> This patch fixes this race by introducing two paths (fastpath and
> slowpath). We first try the fastpath via
> ext4_mb_discard_preallocations(). So if any of the group's PA list is
> empty then instead of waiting on the group_lock we continue to discard
> other group's PA. This could help maintain the parallelism in trying to
> discard multiple group's PA list. So if at the end some process is
> not able to find any freed block, then we retry freeing all of the
> groups PA list while holding the group_lock. And in case if the PA list
> is empty, then we try return grp->bb_free which should tell us
> whether there are any free blocks in the given group or not to make any
> forward progress.
> 
> Suggested-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Ritesh, do you still want to push this patch as is or do you plan to change
it after a discussion on Thursday?

> @@ -3967,9 +3986,15 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
>  		goto repeat;
>  	}
>  
> -	/* found anything to free? */
> +	/*
> +	 * If this list is empty, then return the grp->bb_free. As someone
> +	 * else may have freed the PAs and updated grp->bb_free.
> +	 */
>  	if (list_empty(&list)) {
>  		BUG_ON(free != 0);
> +		mb_debug(1, "Someone may have freed PA for this group %u, grp->bb_free %d\n",
> +			 group, grp->bb_free);
> +		free = grp->bb_free;
>  		goto out;
>  	}

I'm still somewhat concerned about the forward progress guarantee here...
If you're convinced the allocation from goal is the only possibility of
lockup and that logic can be removed, then please remove it and then write a
good comment why lockup is not possible due to this.

> @@ -4464,17 +4492,39 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
>  	return 0;
>  }
>  
> +/*
> + * ext4_mb_discard_preallocations: This function loop over each group's prealloc
> + * list and try to free it. It may so happen that more than 1 process try to
> + * call this function in parallel. That's why we initially take a fastpath
> + * approach in which we first check if the grp->bb_prealloc_list is empty,
> + * that could mean that, someone else may have removed all of it's PA and added
> + * into it's local list. So we quickly return from there and try to discard
> + * next group's PAs. This way we try to parallelize discarding of multiple group
> + * PAs. But in case if any of the process is unfortunate to not able to free
> + * any of group's PA, then we retry with slow path which will gurantee that
> + * either some PAs will be made free or we will get group->bb_free blocks
> + * (grp->bb_free if non-zero gurantees forward progress in ext4_mb_new_blocks())
> + */
>  static int ext4_mb_discard_preallocations(struct super_block *sb, int needed)
>  {
>  	ext4_group_t i, ngroups = ext4_get_groups_count(sb);
>  	int ret;
>  	int freed = 0;
> +	bool fastpath = true;
> +	int tmp_needed;
>  
> -	trace_ext4_mb_discard_preallocations(sb, needed);
> -	for (i = 0; i < ngroups && needed > 0; i++) {
> -		ret = ext4_mb_discard_group_preallocations(sb, i, needed);
> +repeat:
> +	tmp_needed = needed;
> +	trace_ext4_mb_discard_preallocations(sb, tmp_needed);
> +	for (i = 0; i < ngroups && tmp_needed > 0; i++) {
> +		ret = ext4_mb_discard_group_preallocations(sb, i, tmp_needed,
> +							   fastpath);
>  		freed += ret;
> -		needed -= ret;
> +		tmp_needed -= ret;
> +	}

Why do you need 'tmp_needed'? When freed is 0, tmp_needed == needed, right?

> +	if (!freed && fastpath) {
> +		fastpath = false;
> +		goto repeat;
>  	}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
