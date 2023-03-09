Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1086B23C9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 13:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjCIMOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 07:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCIMOW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:14:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B747FE9CEE;
        Thu,  9 Mar 2023 04:14:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E644A2007C;
        Thu,  9 Mar 2023 12:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678364059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aBTpwRtSZwODcRZc+KS9FuZwWg+phVRoROCrcVOYgZ4=;
        b=KAk5HYaGN0wgGxyGMR5Nes+9n7pfzAFObTgrbLUfwx8mrl564qinsjxjXrRuZzwmLamEer
        wwjuzPKhywzavuKO39q1ctpWBcu5yjyWSlWWLgGc97Z90iKozuumMPnTfAC29kAls1GOth
        j9X2iiX+TNTCKPH6WExZ/+dvRe3soCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678364059;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aBTpwRtSZwODcRZc+KS9FuZwWg+phVRoROCrcVOYgZ4=;
        b=w8hwoGsOr/sm+JEJcTv5NeTLU88ifV/Esul3vGts/Xo8HsJrhUI5SL4kvRq5KYPmEadtLE
        qCXiHM0JokzHPsDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D09EF13A10;
        Thu,  9 Mar 2023 12:14:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NTzoMpvNCWQDagAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Mar 2023 12:14:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 46003A06FF; Thu,  9 Mar 2023 13:14:19 +0100 (CET)
Date:   Thu, 9 Mar 2023 13:14:19 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC 05/11] ext4: Add per CR extent scanned counter
Message-ID: <20230309121419.juuadfpa5ytzgnfl@quack3>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
 <e320e13e0f966b8878f923b3a700568064dbe634.1674822311.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e320e13e0f966b8878f923b3a700568064dbe634.1674822311.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 27-01-23 18:07:32, Ojaswin Mujoo wrote:
> This gives better visibility into the number of extents scanned in each
> particular CR. For example, this information can be used to see how out
> block group scanning logic is performing when the BG is fragmented.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h    |  1 +
>  fs/ext4/mballoc.c | 12 ++++++++++++
>  fs/ext4/mballoc.h |  1 +
>  3 files changed, 14 insertions(+)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 6037b8e0af86..4ba2c95915eb 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1633,6 +1633,7 @@ struct ext4_sb_info {
>  	atomic_t s_bal_success;	/* we found long enough chunks */
>  	atomic_t s_bal_allocated;	/* in blocks */
>  	atomic_t s_bal_ex_scanned;	/* total extents scanned */
> +	atomic_t s_bal_cX_ex_scanned[EXT4_MB_NUM_CRS];	/* total extents scanned */
>  	atomic_t s_bal_groups_scanned;	/* number of groups scanned */
>  	atomic_t s_bal_goals;	/* goal hits */
>  	atomic_t s_bal_breaks;	/* too long searches */
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 323604a2ff45..07a50a13751c 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2077,6 +2077,7 @@ static void ext4_mb_measure_extent(struct ext4_allocation_context *ac,
>  	BUG_ON(ac->ac_status != AC_STATUS_CONTINUE);
>  
>  	ac->ac_found++;
> +	ac->ac_cX_found[ac->ac_criteria]++;
>  
>  	/*
>  	 * The special case - take what you catch first
> @@ -2249,6 +2250,7 @@ void ext4_mb_simple_scan_group(struct ext4_allocation_context *ac,
>  			break;
>  		}
>  		ac->ac_found++;
> +		ac->ac_cX_found[ac->ac_criteria]++;
>  
>  		ac->ac_b_ex.fe_len = 1 << i;
>  		ac->ac_b_ex.fe_start = k << i;
> @@ -2362,6 +2364,7 @@ void ext4_mb_scan_aligned(struct ext4_allocation_context *ac,
>  			max = mb_find_extent(e4b, i, sbi->s_stripe, &ex);
>  			if (max >= sbi->s_stripe) {
>  				ac->ac_found++;
> +				ac->ac_cX_found[ac->ac_criteria]++;
>  				ex.fe_logical = 0xDEADF00D; /* debug value */
>  				ac->ac_b_ex = ex;
>  				ext4_mb_use_best_found(ac, e4b);
> @@ -2894,6 +2897,7 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
>  	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR0]));
>  	seq_printf(seq, "\t\tgroups_considered: %llu\n",
>  		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR0]));
> +	seq_printf(seq, "\t\textents_scanned: %u\n", atomic_read(&sbi->s_bal_cX_ex_scanned[CR0]));
>  	seq_printf(seq, "\t\tuseless_loops: %llu\n",
>  		   atomic64_read(&sbi->s_bal_cX_failed[CR0]));
>  	seq_printf(seq, "\t\tbad_suggestions: %u\n",
> @@ -2903,6 +2907,7 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
>  	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR1]));
>  	seq_printf(seq, "\t\tgroups_considered: %llu\n",
>  		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR1]));
> +	seq_printf(seq, "\t\textents_scanned: %u\n", atomic_read(&sbi->s_bal_cX_ex_scanned[CR1]));
>  	seq_printf(seq, "\t\tuseless_loops: %llu\n",
>  		   atomic64_read(&sbi->s_bal_cX_failed[CR1]));
>  	seq_printf(seq, "\t\tbad_suggestions: %u\n",
> @@ -2912,6 +2917,7 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
>  	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR2]));
>  	seq_printf(seq, "\t\tgroups_considered: %llu\n",
>  		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR2]));
> +	seq_printf(seq, "\t\textents_scanned: %u\n", atomic_read(&sbi->s_bal_cX_ex_scanned[CR2]));
>  	seq_printf(seq, "\t\tuseless_loops: %llu\n",
>  		   atomic64_read(&sbi->s_bal_cX_failed[CR2]));
>  
> @@ -2919,6 +2925,7 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
>  	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR3]));
>  	seq_printf(seq, "\t\tgroups_considered: %llu\n",
>  		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR3]));
> +	seq_printf(seq, "\t\textents_scanned: %u\n", atomic_read(&sbi->s_bal_cX_ex_scanned[CR3]));
>  	seq_printf(seq, "\t\tuseless_loops: %llu\n",
>  		   atomic64_read(&sbi->s_bal_cX_failed[CR3]));
>  	seq_printf(seq, "\textents_scanned: %u\n", atomic_read(&sbi->s_bal_ex_scanned));
> @@ -4216,7 +4223,12 @@ static void ext4_mb_collect_stats(struct ext4_allocation_context *ac)
>  		atomic_add(ac->ac_b_ex.fe_len, &sbi->s_bal_allocated);
>  		if (ac->ac_b_ex.fe_len >= ac->ac_o_ex.fe_len)
>  			atomic_inc(&sbi->s_bal_success);
> +
>  		atomic_add(ac->ac_found, &sbi->s_bal_ex_scanned);
> +		for (int i=0; i<EXT4_MB_NUM_CRS; i++) {
> +			atomic_add(ac->ac_cX_found[i], &sbi->s_bal_cX_ex_scanned[i]);
> +		}
> +
>  		atomic_add(ac->ac_groups_scanned, &sbi->s_bal_groups_scanned);
>  		if (ac->ac_g_ex.fe_start == ac->ac_b_ex.fe_start &&
>  				ac->ac_g_ex.fe_group == ac->ac_b_ex.fe_group)
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index f0087a85e366..004b8d163cc9 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -193,6 +193,7 @@ struct ext4_allocation_context {
>  	__u16 ac_groups_scanned;
>  	__u16 ac_groups_linear_remaining;
>  	__u16 ac_found;
> +	__u16 ac_cX_found[EXT4_MB_NUM_CRS];
>  	__u16 ac_tail;
>  	__u16 ac_buddy;
>  	__u8 ac_status;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
