Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829BA6B26D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 15:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCIOZg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 09:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCIOZL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:25:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5381930EA8;
        Thu,  9 Mar 2023 06:25:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0CE4C20104;
        Thu,  9 Mar 2023 14:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678371905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9km87gWKPt/hR64G0P6iiRtDVIALQm6SUo8cyyoUdME=;
        b=wIPcxg0ELD4kHYzuuZJwZDQZnP28eRn90SZVA9jIQvB9tfENPLXue0TuvoxTpzoNItcpnB
        TAGjDoR3oQICRx3KlOCLi6p2rJzs2tkbruOZr+/X9sDT5vbC36tNSU4FkJzxgyMkc7ByXh
        ETqfYYZDFyp/vEQXJvr29rHoSi4txiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678371905;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9km87gWKPt/hR64G0P6iiRtDVIALQm6SUo8cyyoUdME=;
        b=lqxHrQpyiVPiCweBXDaXfj0qECyjgfCtBCWokqdRxNUYDYhjnVq3yrMhs16K59BUZF59GO
        M5Z+mhKc1+C9EzCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE4B213A10;
        Thu,  9 Mar 2023 14:25:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UKgnOkDsCWQvNwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Mar 2023 14:25:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6E27DA06FF; Thu,  9 Mar 2023 15:25:04 +0100 (CET)
Date:   Thu, 9 Mar 2023 15:25:04 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC 10/11] ext4: Abstract out logic to search average fragment
 list
Message-ID: <20230309142504.5lodm4inrn7bnfmk@quack3>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
 <3f0afae57eeaf47aa4b980eddc5e54efc78efa66.1674822311.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f0afae57eeaf47aa4b980eddc5e54efc78efa66.1674822311.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 27-01-23 18:07:37, Ojaswin Mujoo wrote:
> Make the logic of searching average fragment list of a given order reusable
> by abstracting it out to a differnet function. This will also avoid
> code duplication in upcoming patches.
> 
> No functional changes.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 51 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 410c9636907b..1ce1174aea52 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -902,6 +902,37 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
>  	}
>  }
>  
> +/*
> + * Find a suitable group of given order from the average fragments list.
> + */
> +static struct ext4_group_info *
> +ext4_mb_find_good_group_avg_frag_lists(struct ext4_allocation_context *ac, int order)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
> +	struct list_head *frag_list = &sbi->s_mb_avg_fragment_size[order];
> +	rwlock_t *frag_list_lock = &sbi->s_mb_avg_fragment_size_locks[order];
> +	struct ext4_group_info *grp = NULL, *iter;
> +	enum criteria cr = ac->ac_criteria;
> +
> +	if (list_empty(frag_list))
> +		return NULL;
> +	read_lock(frag_list_lock);
> +	if (list_empty(frag_list)) {
> +		read_unlock(frag_list_lock);
> +		return NULL;
> +	}
> +	list_for_each_entry(iter, frag_list, bb_avg_fragment_size_node) {
> +		if (sbi->s_mb_stats)
> +			atomic64_inc(&sbi->s_bal_cX_groups_considered[cr]);
> +		if (likely(ext4_mb_good_group(ac, iter->bb_group, cr))) {
> +			grp = iter;
> +			break;
> +		}
> +	}
> +	read_unlock(frag_list_lock);
> +	return grp;
> +}
> +
>  /*
>   * Choose next group by traversing average fragment size list of suitable
>   * order. Updates *new_cr if cr level needs an update.
> @@ -910,7 +941,7 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
>  		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
> -	struct ext4_group_info *grp = NULL, *iter;
> +	struct ext4_group_info *grp = NULL;
>  	int i;
>  
>  	if (unlikely(ac->ac_flags & EXT4_MB_CR1_OPTIMIZED)) {
> @@ -920,23 +951,7 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
>  
>  	for (i = mb_avg_fragment_size_order(ac->ac_sb, ac->ac_g_ex.fe_len);
>  	     i < MB_NUM_ORDERS(ac->ac_sb); i++) {
> -		if (list_empty(&sbi->s_mb_avg_fragment_size[i]))
> -			continue;
> -		read_lock(&sbi->s_mb_avg_fragment_size_locks[i]);
> -		if (list_empty(&sbi->s_mb_avg_fragment_size[i])) {
> -			read_unlock(&sbi->s_mb_avg_fragment_size_locks[i]);
> -			continue;
> -		}
> -		list_for_each_entry(iter, &sbi->s_mb_avg_fragment_size[i],
> -				    bb_avg_fragment_size_node) {
> -			if (sbi->s_mb_stats)
> -				atomic64_inc(&sbi->s_bal_cX_groups_considered[CR1]);
> -			if (likely(ext4_mb_good_group(ac, iter->bb_group, CR1))) {
> -				grp = iter;
> -				break;
> -			}
> -		}
> -		read_unlock(&sbi->s_mb_avg_fragment_size_locks[i]);
> +		grp = ext4_mb_find_good_group_avg_frag_lists(ac, i);
>  		if (grp)
>  			break;
>  	}
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
