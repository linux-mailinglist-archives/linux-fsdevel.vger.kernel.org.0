Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE7B5EF592
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 14:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbiI2Mjd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 08:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiI2Mjc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:39:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A59F1591D9;
        Thu, 29 Sep 2022 05:39:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7E3A81F8AC;
        Thu, 29 Sep 2022 12:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664455167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MbAAaT0JjhmR4PehVbei3qDlr4/sXHsSyKdff3GTOJU=;
        b=Jb6ip/plxhN0F8oZsMo0WLlAPVg6NXsBAtyVEJfkNxbL8ritkDH4e+GlfuyK5uJpvoobTA
        vpovzmARGcm5QrpJGHm7dNoUbus/laqPusjgNp/mdi9We+y+H7oZz9uK8J4TDjXiMaJga5
        GeJyPaPJH3ohMbeosZz4jUYv/tLmTdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664455167;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MbAAaT0JjhmR4PehVbei3qDlr4/sXHsSyKdff3GTOJU=;
        b=0+nBcD+q/yY2XsUoKHNkuBqJ6kVmv4Kxl/MD8UalqqTScOzKsKWrz8YFwp9I87BCDIXz1W
        so78TQ67HAuHJyCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E3EA13A71;
        Thu, 29 Sep 2022 12:39:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o4ThGv+RNWMXEAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 29 Sep 2022 12:39:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F2B1BA0681; Thu, 29 Sep 2022 14:39:26 +0200 (CEST)
Date:   Thu, 29 Sep 2022 14:39:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC v3 7/8] ext4: Use rbtrees to manage PAs instead of inode
 i_prealloc_list
Message-ID: <20220929123926.5jxuta43otgtcbbp@quack3>
References: <cover.1664269665.git.ojaswin@linux.ibm.com>
 <b78a3ec57625bc26f87c088c8c8165d787b15966.1664269665.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b78a3ec57625bc26f87c088c8c8165d787b15966.1664269665.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 27-09-22 14:46:47, Ojaswin Mujoo wrote:
> Currently, the kernel uses i_prealloc_list to hold all the inode
> preallocations. This is known to cause degradation in performance in
> workloads which perform large number of sparse writes on a single file.
> This is mainly because functions like ext4_mb_normalize_request() and
> ext4_mb_use_preallocated() iterate over this complete list, resulting in
> slowdowns when large number of PAs are present.
> 
> Patch 27bc446e2 partially fixed this by enforcing a limit of 512 for
> the inode preallocation list and adding logic to continually trim the
> list if it grows above the threshold, however our testing revealed that
> a hardcoded value is not suitable for all kinds of workloads.
> 
> To optimize this, add an rbtree to the inode and hold the inode
> preallocations in this rbtree. This will make iterating over inode PAs
> faster and scale much better than a linked list. Additionally, we also
> had to remove the LRU logic that was added during trimming of the list
> (in ext4_mb_release_context()) as it will add extra overhead in rbtree.
> The discards now happen in the lowest-logical-offset-first order.
> 
> ** Locking notes **
> 
> With the introduction of rbtree to maintain inode PAs, we can't use RCU
> to walk the tree for searching since it can result in partial traversals
> which might miss some nodes(or entire subtrees) while discards happen
> in parallel (which happens under a lock).  Hence this patch converts the
> ei->i_prealloc_lock spin_lock to rw_lock.
> 
> Almost all the codepaths that read/modify the PA rbtrees are protected
> by the higher level inode->i_data_sem (except
> ext4_mb_discard_group_preallocations() and ext4_clear_inode()) IIUC, the
> only place we need lock protection is when one thread is reading
> "searching" the PA rbtree (earlier protected under rcu_read_lock()) and
> another is "deleting" the PAs in ext4_mb_discard_group_preallocations()
> function (which iterates all the PAs using the grp->bb_prealloc_list and
> deletes PAs from the tree without taking any inode lock (i_data_sem)).
> 
> So, this patch converts all rcu_read_lock/unlock() paths for inode list
> PA to use read_lock() and all places where we were using
> ei->i_prealloc_lock spinlock will now be using write_lock().
> 
> Note that this makes the fast path (searching of the right PA e.g.
> ext4_mb_use_preallocated() or ext4_mb_normalize_request()), now use
> read_lock() instead of rcu_read_lock/unlock().  Ths also will now block
> due to slow discard path (ext4_mb_discard_group_preallocations()) which
> uses write_lock().
> 
> But this is not as bad as it looks. This is because -
> 
> 1. The slow path only occurs when the normal allocation failed and we
>    can say that we are low on disk space.  One can argue this scenario
>    won't be much frequent.
> 
> 2. ext4_mb_discard_group_preallocations(), locks and unlocks the rwlock
>    for deleting every individual PA.  This gives enough opportunity for
>    the fast path to acquire the read_lock for searching the PA inode
>    list.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

I've found couple of smaller issues. See below. 

> ---
>  fs/ext4/ext4.h    |   4 +-
>  fs/ext4/mballoc.c | 192 ++++++++++++++++++++++++++++++++--------------
>  fs/ext4/mballoc.h |   6 +-
>  fs/ext4/super.c   |   4 +-
>  4 files changed, 140 insertions(+), 66 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 3bf9a6926798..d54b972f1f0f 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1120,8 +1120,8 @@ struct ext4_inode_info {
>  
>  	/* mballoc */
>  	atomic_t i_prealloc_active;
> -	struct list_head i_prealloc_list;
> -	spinlock_t i_prealloc_lock;
> +	struct rb_root i_prealloc_node;
> +	rwlock_t i_prealloc_lock;
>  
>  	/* extents status tree */
>  	struct ext4_es_tree i_es_tree;
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index b91710fe881f..cd19b9e84767 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3985,6 +3985,24 @@ static void ext4_mb_normalize_group_request(struct ext4_allocation_context *ac)
>  	mb_debug(sb, "goal %u blocks for locality group\n", ac->ac_g_ex.fe_len);
>  }
>  
> +/*
> + * This function returns the next element to look at during inode
> + * PA rbtree walk. We assume that we have held the inode PA rbtree lock
> + * (ei->i_prealloc_lock)
> + *
> + * new_start	The start of the range we want to compare
> + * cur_start	The existing start that we are comparing against
> + * node	The node of the rb_tree
> + */
> +static inline struct rb_node*
> +ext4_mb_pa_rb_next_iter(int new_start, int cur_start, struct rb_node *node)

These need to be ext4_lblk_t, not int.

> +{
> +	if (new_start < cur_start)
> +		return node->rb_left;
> +	else
> +		return node->rb_right;
> +}
> +

> @@ -4032,19 +4055,29 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
>  	new_end = *end;
>  
>  	/* check we don't cross already preallocated blocks */
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
> -		if (tmp_pa->pa_deleted)
> +	read_lock(&ei->i_prealloc_lock);
> +	iter = ei->i_prealloc_node.rb_node;
> +	while (iter) {

Perhaps this would be nicer as a for-cycle? Like:

	for (iter = ei->i_prealloc_node.rb_node; iter;
	     iter = ext4_mb_pa_rb_next_iter(new_start, tmp_pa_start, iter))

> +		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
> +				  pa_node.inode_node);
> +		tmp_pa_start = tmp_pa->pa_lstart;
> +		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
> +
> +		/*
> +		 * If pa is deleted, ignore overlaps and just iterate in rbtree
> +		 * based on tmp_pa_start
> +		 */
> +		if (tmp_pa->pa_deleted) {
> +			iter = ext4_mb_pa_rb_next_iter(new_start, tmp_pa_start, iter);
>  			continue;
> +		}
>  		spin_lock(&tmp_pa->pa_lock);
>  		if (tmp_pa->pa_deleted) {
>  			spin_unlock(&tmp_pa->pa_lock);
> +			iter = ext4_mb_pa_rb_next_iter(new_start, tmp_pa_start, iter);
>  			continue;
>  		}
>  
> -		tmp_pa_start = tmp_pa->pa_lstart;
> -		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
> -
>  		/* PA must not overlap original request */
>  		BUG_ON(!(ac->ac_o_ex.fe_logical >= tmp_pa_end ||
>  			ac->ac_o_ex.fe_logical < tmp_pa_start));
> @@ -4052,6 +4085,7 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
>  		/* skip PAs this normalized request doesn't overlap with */
>  		if (tmp_pa_start >= new_end || tmp_pa_end <= new_start) {
>  			spin_unlock(&tmp_pa->pa_lock);
> +			iter = ext4_mb_pa_rb_next_iter(new_start, tmp_pa_start, iter);
>  			continue;
>  		}
>  		BUG_ON(tmp_pa_start <= new_start && tmp_pa_end >= new_end);
> @@ -4065,8 +4099,9 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
>  			new_end = tmp_pa_start;
>  		}
>  		spin_unlock(&tmp_pa->pa_lock);
> +		iter = ext4_mb_pa_rb_next_iter(new_start, tmp_pa_start, iter);
>  	}
> -	rcu_read_unlock();
> +	read_unlock(&ei->i_prealloc_lock);

....

> @@ -4409,17 +4444,23 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  		return false;
>  
>  	/* first, try per-file preallocation */
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
> +	read_lock(&ei->i_prealloc_lock);
> +	iter = ei->i_prealloc_node.rb_node;
> +	while (iter) {

Again, for-cycle would look more natural here.

> +		tmp_pa = rb_entry(iter, struct ext4_prealloc_space, pa_node.inode_node);
>  
>  		/* all fields in this condition don't change,
>  		 * so we can skip locking for them */
>  		tmp_pa_start = tmp_pa->pa_lstart;
>  		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
>  
> +		/* original request start doesn't lie in this PA */
>  		if (ac->ac_o_ex.fe_logical < tmp_pa_start ||
> -		    ac->ac_o_ex.fe_logical >= tmp_pa_end)
> +		    ac->ac_o_ex.fe_logical >= tmp_pa_end) {
> +			iter = ext4_mb_pa_rb_next_iter(ac->ac_o_ex.fe_logical,
> +						  tmp_pa_start, iter);
>  			continue;
> +		}
>  
>  		/* non-extent files can't have physical blocks past 2^32 */
>  		if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)) &&
> @@ -4439,12 +4480,14 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  			ext4_mb_use_inode_pa(ac, tmp_pa);
>  			spin_unlock(&tmp_pa->pa_lock);
>  			ac->ac_criteria = 10;
> -			rcu_read_unlock();
> +			read_unlock(&ei->i_prealloc_lock);
>  			return true;
>  		}
>  		spin_unlock(&tmp_pa->pa_lock);
> +		iter = ext4_mb_pa_rb_next_iter(ac->ac_o_ex.fe_logical,
> +				tmp_pa_start, iter);
>  	}
> -	rcu_read_unlock();
> +	read_unlock(&ei->i_prealloc_lock);
>  
>  	/* can we use group allocation? */
>  	if (!(ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC))
> @@ -4596,6 +4639,7 @@ static void ext4_mb_put_pa(struct ext4_allocation_context *ac,
>  {
>  	ext4_group_t grp;
>  	ext4_fsblk_t grp_blk;
> +	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
>  
>  	/* in this short window concurrent discard can set pa_deleted */
>  	spin_lock(&pa->pa_lock);
> @@ -4641,16 +4685,51 @@ static void ext4_mb_put_pa(struct ext4_allocation_context *ac,
>  	ext4_unlock_group(sb, grp);
>  
>  	if (pa->pa_type == MB_INODE_PA) {
> -		spin_lock(pa->pa_node_lock.inode_lock);
> -		list_del_rcu(&pa->pa_node.inode_list);
> -		spin_unlock(pa->pa_node_lock.inode_lock);
> +		write_lock(pa->pa_node_lock.inode_lock);
> +		rb_erase(&pa->pa_node.inode_node, &ei->i_prealloc_node);
> +		write_unlock(pa->pa_node_lock.inode_lock);
> +		ext4_mb_pa_free(pa);
>  	} else {
>  		spin_lock(pa->pa_node_lock.lg_lock);
>  		list_del_rcu(&pa->pa_node.lg_list);
>  		spin_unlock(pa->pa_node_lock.lg_lock);
> +		call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
>  	}
> +}
> +
> +static void ext4_mb_rb_insert(struct rb_root *root, struct rb_node *new,
> +                       int (*cmp)(struct rb_node *, struct rb_node *))
> +{

Given this has only one callsite, why not just inline ext4_mb_pa_cmp()
directly into this function?

> +       struct rb_node **iter = &root->rb_node, *parent = NULL;
> +
> +       while (*iter) {
> +               parent = *iter;
> +               if (cmp(new, *iter) > 0)
> +                       iter = &((*iter)->rb_left);
> +               else
> +                       iter = &((*iter)->rb_right);
> +       }
> +
> +       rb_link_node(new, parent, iter);
> +       rb_insert_color(new, root);
> +}
> +
> +static int ext4_mb_pa_cmp(struct rb_node *new, struct rb_node *cur)
> +{
> +	ext4_grpblk_t cur_start, new_start;
 
This should be ext4_lblk_t to match with pa->pa_lstart...

> +	struct ext4_prealloc_space *cur_pa = rb_entry(cur,
> +						      struct ext4_prealloc_space,
> +						      pa_node.inode_node);
> +	struct ext4_prealloc_space *new_pa = rb_entry(new,
> +						      struct ext4_prealloc_space,
> +						      pa_node.inode_node);
> +	cur_start = cur_pa->pa_lstart;
> +	new_start = new_pa->pa_lstart;
>  
> -	call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
> +	if (new_start < cur_start)
> +		return 1;
> +	else
> +		return -1;
>  }

Here and in ext4_mb_rb_insert() the comparison seems to be reversed (thus
effectively canceling out) but it is still confusing. Usually if we have
cmp(a,b) functions then if a < b we return -1, if a > b we return 1.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
