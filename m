Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29ED55EF44F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 13:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiI2LaK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 07:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbiI2LaG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:30:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C181076471;
        Thu, 29 Sep 2022 04:30:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DE86321DD0;
        Thu, 29 Sep 2022 11:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664451002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jnXmL/O9aqdai7am+y1p+Too1DWcLEj7ik/HMoGYMEY=;
        b=DKhtSVwdo29fcXIwhOTYWiuyN5sP7LrFxcRQbeL1214svAgXs8QIlkVzAxTVX8WDkKXY8W
        1KmnlhpvZuox3DEHrgO06glG6xlIROWf8aphU978/64pQA0hRvIQk5yPuAD0Vjk6Yox23P
        kXCmlGzHKFnIt/iCq3yXkRINT2Du4Y4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664451002;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jnXmL/O9aqdai7am+y1p+Too1DWcLEj7ik/HMoGYMEY=;
        b=2XtbdcnUCa7T2wOHD62X/zoI9rYoa81Gxu+NvIbCi4KrxvclUiAQGDkwNOSwjEx0XVz57B
        VDn9oifphgCfxaAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D174C1348E;
        Thu, 29 Sep 2022 11:30:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LG8gM7qBNWOQbwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 29 Sep 2022 11:30:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5AC71A0681; Thu, 29 Sep 2022 13:30:02 +0200 (CEST)
Date:   Thu, 29 Sep 2022 13:30:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC v3 3/8] ext4: Refactor code in ext4_mb_normalize_request()
 and ext4_mb_use_preallocated()
Message-ID: <20220929113002.wjoskqpvzamsxdht@quack3>
References: <cover.1664269665.git.ojaswin@linux.ibm.com>
 <8ec3ed728f046495c39f01881b57ef12fdabeb2a.1664269665.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ec3ed728f046495c39f01881b57ef12fdabeb2a.1664269665.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 27-09-22 14:46:43, Ojaswin Mujoo wrote:
> Change some variable names to be more consistent and
> refactor some of the code to make it easier to read.
> 
> There are no functional changes in this patch
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks good, although I have to say I don't find renaming pa -> tmp_pa
making the code any more readable. Anyways, feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 97 ++++++++++++++++++++++++-----------------------
>  1 file changed, 49 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 8be6f8765a6f..84950df709bb 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4000,7 +4000,8 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  	loff_t orig_size __maybe_unused;
>  	ext4_lblk_t start;
>  	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
> -	struct ext4_prealloc_space *pa;
> +	struct ext4_prealloc_space *tmp_pa;
> +	ext4_lblk_t tmp_pa_start, tmp_pa_end;
>  
>  	/* do normalize only data requests, metadata requests
>  	   do not need preallocation */
> @@ -4103,56 +4104,53 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  
>  	/* check we don't cross already preallocated blocks */
>  	rcu_read_lock();
> -	list_for_each_entry_rcu(pa, &ei->i_prealloc_list, pa_inode_list) {
> -		ext4_lblk_t pa_end;
> -
> -		if (pa->pa_deleted)
> +	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
> +		if (tmp_pa->pa_deleted)
>  			continue;
> -		spin_lock(&pa->pa_lock);
> -		if (pa->pa_deleted) {
> -			spin_unlock(&pa->pa_lock);
> +		spin_lock(&tmp_pa->pa_lock);
> +		if (tmp_pa->pa_deleted) {
> +			spin_unlock(&tmp_pa->pa_lock);
>  			continue;
>  		}
>  
> -		pa_end = pa->pa_lstart + EXT4_C2B(EXT4_SB(ac->ac_sb),
> -						  pa->pa_len);
> +		tmp_pa_start = tmp_pa->pa_lstart;
> +		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
>  
>  		/* PA must not overlap original request */
> -		BUG_ON(!(ac->ac_o_ex.fe_logical >= pa_end ||
> -			ac->ac_o_ex.fe_logical < pa->pa_lstart));
> +		BUG_ON(!(ac->ac_o_ex.fe_logical >= tmp_pa_end ||
> +			ac->ac_o_ex.fe_logical < tmp_pa_start));
>  
>  		/* skip PAs this normalized request doesn't overlap with */
> -		if (pa->pa_lstart >= end || pa_end <= start) {
> -			spin_unlock(&pa->pa_lock);
> +		if (tmp_pa_start >= end || tmp_pa_end <= start) {
> +			spin_unlock(&tmp_pa->pa_lock);
>  			continue;
>  		}
> -		BUG_ON(pa->pa_lstart <= start && pa_end >= end);
> +		BUG_ON(tmp_pa_start <= start && tmp_pa_end >= end);
>  
>  		/* adjust start or end to be adjacent to this pa */
> -		if (pa_end <= ac->ac_o_ex.fe_logical) {
> -			BUG_ON(pa_end < start);
> -			start = pa_end;
> -		} else if (pa->pa_lstart > ac->ac_o_ex.fe_logical) {
> -			BUG_ON(pa->pa_lstart > end);
> -			end = pa->pa_lstart;
> +		if (tmp_pa_end <= ac->ac_o_ex.fe_logical) {
> +			BUG_ON(tmp_pa_end < start);
> +			start = tmp_pa_end;
> +		} else if (tmp_pa_start > ac->ac_o_ex.fe_logical) {
> +			BUG_ON(tmp_pa_start > end);
> +			end = tmp_pa_start;
>  		}
> -		spin_unlock(&pa->pa_lock);
> +		spin_unlock(&tmp_pa->pa_lock);
>  	}
>  	rcu_read_unlock();
>  	size = end - start;
>  
>  	/* XXX: extra loop to check we really don't overlap preallocations */
>  	rcu_read_lock();
> -	list_for_each_entry_rcu(pa, &ei->i_prealloc_list, pa_inode_list) {
> -		ext4_lblk_t pa_end;
> +	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
> +		spin_lock(&tmp_pa->pa_lock);
> +		if (tmp_pa->pa_deleted == 0) {
> +			tmp_pa_start = tmp_pa->pa_lstart;
> +			tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
>  
> -		spin_lock(&pa->pa_lock);
> -		if (pa->pa_deleted == 0) {
> -			pa_end = pa->pa_lstart + EXT4_C2B(EXT4_SB(ac->ac_sb),
> -							  pa->pa_len);
> -			BUG_ON(!(start >= pa_end || end <= pa->pa_lstart));
> +			BUG_ON(!(start >= tmp_pa_end || end <= tmp_pa_start));
>  		}
> -		spin_unlock(&pa->pa_lock);
> +		spin_unlock(&tmp_pa->pa_lock);
>  	}
>  	rcu_read_unlock();
>  
> @@ -4362,7 +4360,8 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  	int order, i;
>  	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
>  	struct ext4_locality_group *lg;
> -	struct ext4_prealloc_space *pa, *cpa = NULL;
> +	struct ext4_prealloc_space *tmp_pa, *cpa = NULL;
> +	ext4_lblk_t tmp_pa_start, tmp_pa_end;
>  	ext4_fsblk_t goal_block;
>  
>  	/* only data can be preallocated */
> @@ -4371,18 +4370,20 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  
>  	/* first, try per-file preallocation */
>  	rcu_read_lock();
> -	list_for_each_entry_rcu(pa, &ei->i_prealloc_list, pa_inode_list) {
> +	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
>  
>  		/* all fields in this condition don't change,
>  		 * so we can skip locking for them */
> -		if (ac->ac_o_ex.fe_logical < pa->pa_lstart ||
> -		    ac->ac_o_ex.fe_logical >= (pa->pa_lstart +
> -					       EXT4_C2B(sbi, pa->pa_len)))
> +		tmp_pa_start = tmp_pa->pa_lstart;
> +		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
> +
> +		if (ac->ac_o_ex.fe_logical < tmp_pa_start ||
> +		    ac->ac_o_ex.fe_logical >= tmp_pa_end)
>  			continue;
>  
>  		/* non-extent files can't have physical blocks past 2^32 */
>  		if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)) &&
> -		    (pa->pa_pstart + EXT4_C2B(sbi, pa->pa_len) >
> +		    (tmp_pa->pa_pstart + EXT4_C2B(sbi, tmp_pa->pa_len) >
>  		     EXT4_MAX_BLOCK_FILE_PHYS)) {
>  			/*
>  			 * Since PAs don't overlap, we won't find any
> @@ -4392,16 +4393,16 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  		}
>  
>  		/* found preallocated blocks, use them */
> -		spin_lock(&pa->pa_lock);
> -		if (pa->pa_deleted == 0 && pa->pa_free) {
> -			atomic_inc(&pa->pa_count);
> -			ext4_mb_use_inode_pa(ac, pa);
> -			spin_unlock(&pa->pa_lock);
> +		spin_lock(&tmp_pa->pa_lock);
> +		if (tmp_pa->pa_deleted == 0 && tmp_pa->pa_free) {
> +			atomic_inc(&tmp_pa->pa_count);
> +			ext4_mb_use_inode_pa(ac, tmp_pa);
> +			spin_unlock(&tmp_pa->pa_lock);
>  			ac->ac_criteria = 10;
>  			rcu_read_unlock();
>  			return true;
>  		}
> -		spin_unlock(&pa->pa_lock);
> +		spin_unlock(&tmp_pa->pa_lock);
>  	}
>  	rcu_read_unlock();
>  
> @@ -4425,16 +4426,16 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  	 */
>  	for (i = order; i < PREALLOC_TB_SIZE; i++) {
>  		rcu_read_lock();
> -		list_for_each_entry_rcu(pa, &lg->lg_prealloc_list[i],
> +		list_for_each_entry_rcu(tmp_pa, &lg->lg_prealloc_list[i],
>  					pa_inode_list) {
> -			spin_lock(&pa->pa_lock);
> -			if (pa->pa_deleted == 0 &&
> -					pa->pa_free >= ac->ac_o_ex.fe_len) {
> +			spin_lock(&tmp_pa->pa_lock);
> +			if (tmp_pa->pa_deleted == 0 &&
> +					tmp_pa->pa_free >= ac->ac_o_ex.fe_len) {
>  
>  				cpa = ext4_mb_check_group_pa(goal_block,
> -								pa, cpa);
> +								tmp_pa, cpa);
>  			}
> -			spin_unlock(&pa->pa_lock);
> +			spin_unlock(&tmp_pa->pa_lock);
>  		}
>  		rcu_read_unlock();
>  	}
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
