Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A7E6B286A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 16:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjCIPJp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 10:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjCIPJU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:09:20 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6D8FA085;
        Thu,  9 Mar 2023 07:06:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1E931220A0;
        Thu,  9 Mar 2023 15:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678374411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R6g4kRDdU6Pzsf3osnmqtkBjat/AV+71HfLT7+Petq0=;
        b=Ymap7u+kMyX4vLkfKiaEhZhokT4sx2z9jpEPbZSO9rQzt0kIJj+cqmoblpnjoV1k0SyEUj
        cd7DAI8WoFdsOp/67o6qtC6SgujL+cLHeWozarmPZE1WPw568sbDtYTP9mwHYAJLwL6Qyq
        IdcW9IUA7ZJ3B7p6KlToms8GZTboVQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678374411;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R6g4kRDdU6Pzsf3osnmqtkBjat/AV+71HfLT7+Petq0=;
        b=C+pFLS1Gyn+Z1rC/kHyViduGByHJeoMNBtoejeg/Mh44UksWeUecipeduzk9dSd7usn4v5
        wp2k7mc+nu0mCUBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F7A513A10;
        Thu,  9 Mar 2023 15:06:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8fSxAwv2CWSmTgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Mar 2023 15:06:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D1ADDA06FF; Thu,  9 Mar 2023 16:06:49 +0100 (CET)
Date:   Thu, 9 Mar 2023 16:06:49 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC 11/11] ext4: Add allocation criteria 1.5 (CR1_5)
Message-ID: <20230309150649.5pnhqsf2khvffl6l@quack3>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
 <08173ee255f70cdc8de9ac3aa2e851f9d74acb12.1674822312.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08173ee255f70cdc8de9ac3aa2e851f9d74acb12.1674822312.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 27-01-23 18:07:38, Ojaswin Mujoo wrote:
> CR1_5 aims to optimize allocations which can't be satisfied in CR1. The
> fact that we couldn't find a group in CR1 suggests that it would be
> difficult to find a continuous extent to compleltely satisfy our
> allocations. So before falling to the slower CR2, in CR1.5 we
> proactively trim the the preallocations so we can find a group with
> (free / fragments) big enough.  This speeds up our allocation at the
> cost of slightly reduced preallocation.
> 
> The patch also adds a new sysfs tunable:
> 
> * /sys/fs/ext4/<partition>/mb_cr1_5_max_trim_order
> 
> This controls how much CR1.5 can trim a request before falling to CR2.
> For example, for a request of order 7 and max trim order 2, CR1.5 can
> trim this upto order 5.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

The idea looks good. Couple of questions below...

> +/*
> + * We couldn't find a group in CR1 so try to find the highest free fragment
> + * order we have and proactively trim the goal request length to that order to
> + * find a suitable group faster.
> + *
> + * This optimizes allocation speed at the cost of slightly reduced
> + * preallocations. However, we make sure that we don't trim the request too
> + * much and fall to CR2 in that case.
> + */
> +static void ext4_mb_choose_next_group_cr1_5(struct ext4_allocation_context *ac,
> +		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
> +	struct ext4_group_info *grp = NULL;
> +	int i, order, min_order;
> +
> +	if (unlikely(ac->ac_flags & EXT4_MB_CR1_5_OPTIMIZED)) {
> +		if (sbi->s_mb_stats)
> +			atomic_inc(&sbi->s_bal_cr1_5_bad_suggestions);
> +	}
> +
> +	/*
> +	 * mb_avg_fragment_size_order() returns order in a way that makes
> +	 * retrieving back the length using (1 << order) inaccurate. Hence, use
> +	 * fls() instead since we need to know the actual length while modifying
> +	 * goal length.
> +	 */
> +	order = fls(ac->ac_g_ex.fe_len);
> +	min_order = order - sbi->s_mb_cr1_5_max_trim_order;

Given we still require the allocation contains at least originally
requested blocks, is it ever the case that goal size would be 8 times
larger than original alloc size? Otherwise the
sbi->s_mb_cr1_5_max_trim_order logic seems a bit pointless...

> +	if (min_order < 0)
> +		min_order = 0;

Perhaps add:

	if (1 << min_order < ac->ac_o_ex.fe_len)
		min_order = fls(ac->ac_o_ex.fe_len) + 1;

and then you can drop the condition from the loop below...

> +
> +	for (i = order; i >= min_order; i--) {
> +		if (ac->ac_o_ex.fe_len <= (1 << i)) {
> +			/*
> +			 * Scale down goal len to make sure we find something
> +			 * in the free fragments list. Basically, reduce
> +			 * preallocations.
> +			 */
> +			ac->ac_g_ex.fe_len = 1 << i;

When scaling down the size with sbi->s_stripe > 1, it would be better to
choose multiple of sbi->s_stripe and not power of two. But our stripe
support is fairly weak anyway (e.g. initial goal size does not reflect it
at all AFAICT) so probably we don't care here either.

> +		} else {
> +			break;
> +		}
> +
> +		grp = ext4_mb_find_good_group_avg_frag_lists(ac,
> +							     mb_avg_fragment_size_order(ac->ac_sb,
> +							     ac->ac_g_ex.fe_len));
> +		if (grp)
> +			break;
> +	}
> +
> +	if (grp) {
> +		*group = grp->bb_group;
> +		ac->ac_flags |= EXT4_MB_CR1_5_OPTIMIZED;
> +	} else {
> +		/* Reset goal length to original goal length before falling into CR2 */
> +		ac->ac_g_ex.fe_len = ac->ac_orig_goal_len;
>  		*new_cr = CR2;
>  	}
>  }

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
