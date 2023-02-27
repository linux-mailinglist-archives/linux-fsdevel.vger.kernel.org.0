Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373366A4197
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 13:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjB0MTw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 07:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjB0MTr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 07:19:47 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840EA136FA;
        Mon, 27 Feb 2023 04:19:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0CC19219F4;
        Mon, 27 Feb 2023 12:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677500366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n02tg4wj3+t2zzOcoWPJBy2Uth0+tgTQ+wdjFImxPeM=;
        b=D7G9oyBkY+IfvMqDBzlPRDz10EcHBfiGDqnAwmBTcGNdR7q+LoYXKNQ8xMM/SmgEcsSarK
        evxmRQ6uIBjovobvfUP7ssae4gzl/XHOTxxxjB5bW6S+YKBk5lK7691k3SCkez5jmcjtiZ
        0b+BhHk23Ot01B8nWIA4rSc8jgYvIV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677500366;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n02tg4wj3+t2zzOcoWPJBy2Uth0+tgTQ+wdjFImxPeM=;
        b=tW5yus1K1iKCgcIsiGw+Uh8ShoosxGa560yhR1vj2Xot+OgXNqPMXBne0J0h6Y9u8GNY4g
        kVH/wlI5fQLTBiDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E912113A43;
        Mon, 27 Feb 2023 12:19:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P0/hOM2f/GNZOwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 27 Feb 2023 12:19:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 733DDA06F2; Mon, 27 Feb 2023 13:19:25 +0100 (CET)
Date:   Mon, 27 Feb 2023 13:19:25 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>
Subject: Re: [PATCH v4 8/9] ext4: Use rbtrees to manage PAs instead of inode
 i_prealloc_list
Message-ID: <20230227121925.6hfrrhq4gn5g2vlh@quack3>
References: <cover.1676634592.git.ojaswin@linux.ibm.com>
 <bc5f70ca1d2974a41b77154966e736d1e58a8d20.1676634592.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc5f70ca1d2974a41b77154966e736d1e58a8d20.1676634592.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 17-02-23 17:44:17, Ojaswin Mujoo wrote:
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

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Just a few style nits below...

> @@ -3992,80 +4010,162 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
>  	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
>  	struct ext4_prealloc_space *tmp_pa;
>  	ext4_lblk_t tmp_pa_start, tmp_pa_end;
> +	struct rb_node *iter;
>  
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
> -		spin_lock(&tmp_pa->pa_lock);
> -		if (tmp_pa->pa_deleted == 0) {
> -			tmp_pa_start = tmp_pa->pa_lstart;
> -			tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
> +	read_lock(&ei->i_prealloc_lock);
> +	for (iter = ei->i_prealloc_node.rb_node; iter;
> +	     iter = ext4_mb_pa_rb_next_iter(start, tmp_pa_start, iter)) {
> +		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
> +				  pa_node.inode_node);
> +		tmp_pa_start = tmp_pa->pa_lstart;
> +		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
>  
> +		spin_lock(&tmp_pa->pa_lock);
> +		if (tmp_pa->pa_deleted == 0)
>  			BUG_ON(!(start >= tmp_pa_end || end <= tmp_pa_start));
> -		}
>  		spin_unlock(&tmp_pa->pa_lock);
>  	}
> -	rcu_read_unlock();
> +	read_unlock(&ei->i_prealloc_lock);
>  }
> -

Please keep the empty line here.

> @@ -4402,6 +4502,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  	struct ext4_locality_group *lg;
>  	struct ext4_prealloc_space *tmp_pa, *cpa = NULL;
>  	ext4_lblk_t tmp_pa_start, tmp_pa_end;
> +	struct rb_node *iter;
>  	ext4_fsblk_t goal_block;
>  
>  	/* only data can be preallocated */
> @@ -4409,14 +4510,17 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  		return false;
>  
>  	/* first, try per-file preallocation */
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
> +	read_lock(&ei->i_prealloc_lock);
> +	for (iter = ei->i_prealloc_node.rb_node; iter;
> +	     iter = ext4_mb_pa_rb_next_iter(ac->ac_o_ex.fe_logical, tmp_pa_start, iter)) {
> +		tmp_pa = rb_entry(iter, struct ext4_prealloc_space, pa_node.inode_node);

Perhaps wrap above two lines to fit in 80 characters?

> @@ -5043,17 +5177,18 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
>  
>  repeat:
>  	/* first, collect all pa's in the inode */
> -	spin_lock(&ei->i_prealloc_lock);
> -	while (!list_empty(&ei->i_prealloc_list) && needed) {
> -		pa = list_entry(ei->i_prealloc_list.prev,
> -				struct ext4_prealloc_space, pa_node.inode_list);
> +	write_lock(&ei->i_prealloc_lock);
> +	for (iter = rb_first(&ei->i_prealloc_node); iter && needed; iter = rb_next(iter)) {

Wrap this line as well?

> +		pa = rb_entry(iter, struct ext4_prealloc_space,
> +				pa_node.inode_node);
>  		BUG_ON(pa->pa_node_lock.inode_lock != &ei->i_prealloc_lock);
> +

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
