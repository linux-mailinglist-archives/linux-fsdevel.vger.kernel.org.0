Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6359C5EF479
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 13:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbiI2Lkc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 07:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbiI2Lkb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:40:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5C9D4A93;
        Thu, 29 Sep 2022 04:40:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6AF2B21DE3;
        Thu, 29 Sep 2022 11:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664451628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pIwyTN1Jhv9fSSoHPUNjp9dxNNEUkLpwamFPKZB26Fw=;
        b=dxa3LUUjoCaJz0mPVHbxfJ2FyxBTvWSH4f6NdvKVbQmiCu30LEaY/NhNNaXMLSk5O/LFMx
        AYAuc4sqs6gdI4F6Ijmni8tyNIfF8DVVncdhIKof9moicuxKXByhVKUYO9LFNoFAQpXQfB
        5ZTZnWAUXaRUCvidHiTCyNvQRERGwPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664451628;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pIwyTN1Jhv9fSSoHPUNjp9dxNNEUkLpwamFPKZB26Fw=;
        b=qPC0Lh4+D1b90Nl8ChVshSHuXSfr7LBWjgUnqq3GUFvB1b2srD1uhf8OptZgp1O4C5+sUk
        MASE5I6XYONwo3CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51ECF1348E;
        Thu, 29 Sep 2022 11:40:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7H//EyyENWMJdAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 29 Sep 2022 11:40:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 995C2A0681; Thu, 29 Sep 2022 13:40:27 +0200 (CEST)
Date:   Thu, 29 Sep 2022 13:40:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC v3 6/8] ext4: Convert pa->pa_inode_list and pa->pa_obj_lock
 into a union
Message-ID: <20220929114027.xr6tlqlfbn4asaod@quack3>
References: <cover.1664269665.git.ojaswin@linux.ibm.com>
 <68364daa1af99536695b9a1df07652c14caf7cac.1664269665.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68364daa1af99536695b9a1df07652c14caf7cac.1664269665.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 27-09-22 14:46:46, Ojaswin Mujoo wrote:
> ** Splitting pa->pa_inode_list **
> 
> Currently, we use the same pa->pa_inode_list to add a pa to either
> the inode preallocation list or the locality group preallocation list.
> For better clarity, split this list into a union of 2 list_heads and use
> either of the them based on the type of pa.
> 
> ** Splitting pa->pa_obj_lock **
> 
> Currently, pa->pa_obj_lock is either assigned &ei->i_prealloc_lock for
> inode PAs or lg_prealloc_lock for lg PAs, and is then used to lock the
> lists containing these PAs. Make the distinction between the 2 PA types
> clear by changing this lock to a union of 2 locks. Explicitly use the
> pa_lock_node.inode_lock for inode PAs and pa_lock_node.lg_lock for lg
> PAs.
> 
> This patch is required so that the locality group preallocation code
> remains the same as in upcoming patches we are going to make changes to
> inode preallocation code to move from list to rbtree based
> implementation. This patch also makes it easier to review the upcoming
> patches.
> 
> There are no functional changes in this patch.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Nice intermediate step. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 76 +++++++++++++++++++++++++++--------------------
>  fs/ext4/mballoc.h | 10 +++++--
>  2 files changed, 52 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index dda9a72c81d9..b91710fe881f 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3995,7 +3995,7 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
>  	ext4_lblk_t tmp_pa_start, tmp_pa_end;
>  
>  	rcu_read_lock();
> -	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
> +	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
>  		spin_lock(&tmp_pa->pa_lock);
>  		if (tmp_pa->pa_deleted == 0) {
>  			tmp_pa_start = tmp_pa->pa_lstart;
> @@ -4033,7 +4033,7 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
>  
>  	/* check we don't cross already preallocated blocks */
>  	rcu_read_lock();
> -	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
> +	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
>  		if (tmp_pa->pa_deleted)
>  			continue;
>  		spin_lock(&tmp_pa->pa_lock);
> @@ -4410,7 +4410,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  
>  	/* first, try per-file preallocation */
>  	rcu_read_lock();
> -	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
> +	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
>  
>  		/* all fields in this condition don't change,
>  		 * so we can skip locking for them */
> @@ -4467,7 +4467,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  	for (i = order; i < PREALLOC_TB_SIZE; i++) {
>  		rcu_read_lock();
>  		list_for_each_entry_rcu(tmp_pa, &lg->lg_prealloc_list[i],
> -					pa_inode_list) {
> +					pa_node.lg_list) {
>  			spin_lock(&tmp_pa->pa_lock);
>  			if (tmp_pa->pa_deleted == 0 &&
>  					tmp_pa->pa_free >= ac->ac_o_ex.fe_len) {
> @@ -4640,9 +4640,15 @@ static void ext4_mb_put_pa(struct ext4_allocation_context *ac,
>  	list_del(&pa->pa_group_list);
>  	ext4_unlock_group(sb, grp);
>  
> -	spin_lock(pa->pa_obj_lock);
> -	list_del_rcu(&pa->pa_inode_list);
> -	spin_unlock(pa->pa_obj_lock);
> +	if (pa->pa_type == MB_INODE_PA) {
> +		spin_lock(pa->pa_node_lock.inode_lock);
> +		list_del_rcu(&pa->pa_node.inode_list);
> +		spin_unlock(pa->pa_node_lock.inode_lock);
> +	} else {
> +		spin_lock(pa->pa_node_lock.lg_lock);
> +		list_del_rcu(&pa->pa_node.lg_list);
> +		spin_unlock(pa->pa_node_lock.lg_lock);
> +	}
>  
>  	call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
>  }
> @@ -4710,7 +4716,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>  	pa->pa_len = ac->ac_b_ex.fe_len;
>  	pa->pa_free = pa->pa_len;
>  	spin_lock_init(&pa->pa_lock);
> -	INIT_LIST_HEAD(&pa->pa_inode_list);
> +	INIT_LIST_HEAD(&pa->pa_node.inode_list);
>  	INIT_LIST_HEAD(&pa->pa_group_list);
>  	pa->pa_deleted = 0;
>  	pa->pa_type = MB_INODE_PA;
> @@ -4725,14 +4731,14 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>  	ei = EXT4_I(ac->ac_inode);
>  	grp = ext4_get_group_info(sb, ac->ac_b_ex.fe_group);
>  
> -	pa->pa_obj_lock = &ei->i_prealloc_lock;
> +	pa->pa_node_lock.inode_lock = &ei->i_prealloc_lock;
>  	pa->pa_inode = ac->ac_inode;
>  
>  	list_add(&pa->pa_group_list, &grp->bb_prealloc_list);
>  
> -	spin_lock(pa->pa_obj_lock);
> -	list_add_rcu(&pa->pa_inode_list, &ei->i_prealloc_list);
> -	spin_unlock(pa->pa_obj_lock);
> +	spin_lock(pa->pa_node_lock.inode_lock);
> +	list_add_rcu(&pa->pa_node.inode_list, &ei->i_prealloc_list);
> +	spin_unlock(pa->pa_node_lock.inode_lock);
>  	atomic_inc(&ei->i_prealloc_active);
>  }
>  
> @@ -4764,7 +4770,7 @@ ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
>  	pa->pa_len = ac->ac_b_ex.fe_len;
>  	pa->pa_free = pa->pa_len;
>  	spin_lock_init(&pa->pa_lock);
> -	INIT_LIST_HEAD(&pa->pa_inode_list);
> +	INIT_LIST_HEAD(&pa->pa_node.lg_list);
>  	INIT_LIST_HEAD(&pa->pa_group_list);
>  	pa->pa_deleted = 0;
>  	pa->pa_type = MB_GROUP_PA;
> @@ -4780,7 +4786,7 @@ ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
>  	lg = ac->ac_lg;
>  	BUG_ON(lg == NULL);
>  
> -	pa->pa_obj_lock = &lg->lg_prealloc_lock;
> +	pa->pa_node_lock.lg_lock = &lg->lg_prealloc_lock;
>  	pa->pa_inode = NULL;
>  
>  	list_add(&pa->pa_group_list, &grp->bb_prealloc_list);
> @@ -4956,9 +4962,15 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
>  	list_for_each_entry_safe(pa, tmp, &list, u.pa_tmp_list) {
>  
>  		/* remove from object (inode or locality group) */
> -		spin_lock(pa->pa_obj_lock);
> -		list_del_rcu(&pa->pa_inode_list);
> -		spin_unlock(pa->pa_obj_lock);
> +		if (pa->pa_type == MB_GROUP_PA) {
> +			spin_lock(pa->pa_node_lock.lg_lock);
> +			list_del_rcu(&pa->pa_node.lg_list);
> +			spin_unlock(pa->pa_node_lock.lg_lock);
> +		} else {
> +			spin_lock(pa->pa_node_lock.inode_lock);
> +			list_del_rcu(&pa->pa_node.inode_list);
> +			spin_unlock(pa->pa_node_lock.inode_lock);
> +		}
>  
>  		if (pa->pa_type == MB_GROUP_PA)
>  			ext4_mb_release_group_pa(&e4b, pa);
> @@ -5021,8 +5033,8 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
>  	spin_lock(&ei->i_prealloc_lock);
>  	while (!list_empty(&ei->i_prealloc_list) && needed) {
>  		pa = list_entry(ei->i_prealloc_list.prev,
> -				struct ext4_prealloc_space, pa_inode_list);
> -		BUG_ON(pa->pa_obj_lock != &ei->i_prealloc_lock);
> +				struct ext4_prealloc_space, pa_node.inode_list);
> +		BUG_ON(pa->pa_node_lock.inode_lock != &ei->i_prealloc_lock);
>  		spin_lock(&pa->pa_lock);
>  		if (atomic_read(&pa->pa_count)) {
>  			/* this shouldn't happen often - nobody should
> @@ -5039,7 +5051,7 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
>  		if (pa->pa_deleted == 0) {
>  			ext4_mb_mark_pa_deleted(sb, pa);
>  			spin_unlock(&pa->pa_lock);
> -			list_del_rcu(&pa->pa_inode_list);
> +			list_del_rcu(&pa->pa_node.inode_list);
>  			list_add(&pa->u.pa_tmp_list, &list);
>  			needed--;
>  			continue;
> @@ -5331,7 +5343,7 @@ ext4_mb_discard_lg_preallocations(struct super_block *sb,
>  
>  	spin_lock(&lg->lg_prealloc_lock);
>  	list_for_each_entry_rcu(pa, &lg->lg_prealloc_list[order],
> -				pa_inode_list,
> +				pa_node.lg_list,
>  				lockdep_is_held(&lg->lg_prealloc_lock)) {
>  		spin_lock(&pa->pa_lock);
>  		if (atomic_read(&pa->pa_count)) {
> @@ -5354,7 +5366,7 @@ ext4_mb_discard_lg_preallocations(struct super_block *sb,
>  		ext4_mb_mark_pa_deleted(sb, pa);
>  		spin_unlock(&pa->pa_lock);
>  
> -		list_del_rcu(&pa->pa_inode_list);
> +		list_del_rcu(&pa->pa_node.lg_list);
>  		list_add(&pa->u.pa_tmp_list, &discard_list);
>  
>  		total_entries--;
> @@ -5415,7 +5427,7 @@ static void ext4_mb_add_n_trim(struct ext4_allocation_context *ac)
>  	/* Add the prealloc space to lg */
>  	spin_lock(&lg->lg_prealloc_lock);
>  	list_for_each_entry_rcu(tmp_pa, &lg->lg_prealloc_list[order],
> -				pa_inode_list,
> +				pa_node.lg_list,
>  				lockdep_is_held(&lg->lg_prealloc_lock)) {
>  		spin_lock(&tmp_pa->pa_lock);
>  		if (tmp_pa->pa_deleted) {
> @@ -5424,8 +5436,8 @@ static void ext4_mb_add_n_trim(struct ext4_allocation_context *ac)
>  		}
>  		if (!added && pa->pa_free < tmp_pa->pa_free) {
>  			/* Add to the tail of the previous entry */
> -			list_add_tail_rcu(&pa->pa_inode_list,
> -						&tmp_pa->pa_inode_list);
> +			list_add_tail_rcu(&pa->pa_node.lg_list,
> +						&tmp_pa->pa_node.lg_list);
>  			added = 1;
>  			/*
>  			 * we want to count the total
> @@ -5436,7 +5448,7 @@ static void ext4_mb_add_n_trim(struct ext4_allocation_context *ac)
>  		lg_prealloc_count++;
>  	}
>  	if (!added)
> -		list_add_tail_rcu(&pa->pa_inode_list,
> +		list_add_tail_rcu(&pa->pa_node.lg_list,
>  					&lg->lg_prealloc_list[order]);
>  	spin_unlock(&lg->lg_prealloc_lock);
>  
> @@ -5492,9 +5504,9 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
>  			 * doesn't grow big.
>  			 */
>  			if (likely(pa->pa_free)) {
> -				spin_lock(pa->pa_obj_lock);
> -				list_del_rcu(&pa->pa_inode_list);
> -				spin_unlock(pa->pa_obj_lock);
> +				spin_lock(pa->pa_node_lock.lg_lock);
> +				list_del_rcu(&pa->pa_node.lg_list);
> +				spin_unlock(pa->pa_node_lock.lg_lock);
>  				ext4_mb_add_n_trim(ac);
>  			}
>  		}
> @@ -5504,9 +5516,9 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
>  			 * treat per-inode prealloc list as a lru list, then try
>  			 * to trim the least recently used PA.
>  			 */
> -			spin_lock(pa->pa_obj_lock);
> -			list_move(&pa->pa_inode_list, &ei->i_prealloc_list);
> -			spin_unlock(pa->pa_obj_lock);
> +			spin_lock(pa->pa_node_lock.inode_lock);
> +			list_move(&pa->pa_node.inode_list, &ei->i_prealloc_list);
> +			spin_unlock(pa->pa_node_lock.inode_lock);
>  		}
>  
>  		ext4_mb_put_pa(ac, ac->ac_sb, pa);
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index dcda2a943cee..398a6688c341 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -114,7 +114,10 @@ struct ext4_free_data {
>  };
>  
>  struct ext4_prealloc_space {
> -	struct list_head	pa_inode_list;
> +	union {
> +		struct list_head	inode_list; /* for inode PAs */
> +		struct list_head	lg_list;	/* for lg PAs */
> +	} pa_node;
>  	struct list_head	pa_group_list;
>  	union {
>  		struct list_head pa_tmp_list;
> @@ -128,7 +131,10 @@ struct ext4_prealloc_space {
>  	ext4_grpblk_t		pa_len;		/* len of preallocated chunk */
>  	ext4_grpblk_t		pa_free;	/* how many blocks are free */
>  	unsigned short		pa_type;	/* pa type. inode or group */
> -	spinlock_t		*pa_obj_lock;
> +	union {
> +		spinlock_t		*inode_lock;	/* locks the inode list holding this PA */
> +		spinlock_t		*lg_lock;	/* locks the lg list holding this PA */
> +	} pa_node_lock;
>  	struct inode		*pa_inode;	/* hack, for history only */
>  };
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
