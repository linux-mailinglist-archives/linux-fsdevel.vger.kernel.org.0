Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031FA5F9C0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 11:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbiJJJih (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 05:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiJJJia (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:38:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022F0EE13;
        Mon, 10 Oct 2022 02:38:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6842A2190B;
        Mon, 10 Oct 2022 09:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665394707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Ji9LtDNcMJzLwB/6F/UrgD1Jyjej7PiMeGxh7kVmXo=;
        b=QkMecvVQ//+8SzbCamlTUSODvKsi0YEtBBaFdojgLiV1UgZr0uO3ZnrtvRyZnQJSq785Ih
        IvswAwPG04L6k9wHtEB7BoovtjxOsxtYWNltb1z1qt2VWOoYixgItnOgnbRZts4EHhOJ81
        fnsYWFEH+po7EcB24JwNT27GtNF12dc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665394707;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Ji9LtDNcMJzLwB/6F/UrgD1Jyjej7PiMeGxh7kVmXo=;
        b=gL4KDTlLz8RzlHsjTo4Kn7rp5GV0Xnkt/xMzCjVe0d1CcsPOojIIPUbrELYeUx8F0WFn64
        wdliLsKYthlaLKAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D07813479;
        Mon, 10 Oct 2022 09:38:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xsHdDhPoQ2OgEQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 10 Oct 2022 09:38:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3B401A06ED; Mon, 10 Oct 2022 11:38:26 +0200 (CEST)
Date:   Mon, 10 Oct 2022 11:38:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH 7/8] ext4: Use rbtrees to manage PAs instead of inode
 i_prealloc_list
Message-ID: <20221010093826.uc3zvxyhcyjqosrg@quack3>
References: <cover.1665088164.git.ojaswin@linux.ibm.com>
 <ee2dd0087cea34b5fdfdbee5d9bc56fb4dd22e54.1665088164.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee2dd0087cea34b5fdfdbee5d9bc56fb4dd22e54.1665088164.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 07-10-22 02:16:18, Ojaswin Mujoo wrote:
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

Looks mostly good to me now. Just three nits below. With those fixes feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -4031,19 +4054,27 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
>  	new_end = *end;
>  
>  	/* check we don't cross already preallocated blocks */
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
> -		if (tmp_pa->pa_deleted)
> +	read_lock(&ei->i_prealloc_lock);
> +	for (iter = ei->i_prealloc_node.rb_node; iter;
> +	     iter = ext4_mb_pa_rb_next_iter(new_start, tmp_pa_start, iter)) {
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
>  			continue;
> +		}

Curly braces here are pointless.

> @@ -4408,17 +4439,21 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  		return false;
>  
>  	/* first, try per-file preallocation */
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
> +	read_lock(&ei->i_prealloc_lock);
> +	for (iter = ei->i_prealloc_node.rb_node; iter;
> +	     iter = ext4_mb_pa_rb_next_iter(ac->ac_o_ex.fe_logical, tmp_pa_start, iter)) {
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
>  			continue;
> +		}

Again, curly braces here are pointless.

> +static void ext4_mb_rb_insert(struct rb_root *root, struct rb_node *new,
> +                       int (*cmp)(struct rb_node *, struct rb_node *))
> +{
> +       struct rb_node **iter = &root->rb_node, *parent = NULL;
> +
> +       while (*iter) {
> +               parent = *iter;
> +               if (cmp(new, *iter) < 0)
> +                       iter = &((*iter)->rb_left);
> +               else
> +                       iter = &((*iter)->rb_right);
> +       }
> +
> +       rb_link_node(new, parent, iter);
> +       rb_insert_color(new, root);
> +}

I think I wrote it already last time: ext4_mb_rb_insert() is always called
with ext4_mb_pa_cmp() as the comparison function. Furthemore
ext4_mb_pa_cmp() is used nowhere else. So I'd just opencode
ext4_mb_pa_cmp() in ext4_mb_rb_insert() and get rid of the indirect call.
Better for speed as well as readability.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
