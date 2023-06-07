Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDBC725B7B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 12:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbjFGKVK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 06:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbjFGKVG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:21:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B65C11D;
        Wed,  7 Jun 2023 03:21:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DD6EE219BF;
        Wed,  7 Jun 2023 10:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686133263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PaXymw7r2ADMno+XYANmnydgCB3s3HtZ/gj7X6DBhRc=;
        b=J3RP1esx98O+TAK740ShbBSTIdlVpgioz65lkUHAjtbIGb8xy5WBt+lIrCV0r9OnDoHREg
        9nlx7ksSd90DHLE1psfx9asLCpUaxyv4B1zTBIfJJuOZzZQ1Gjyy+fo4l6YYgieeuG6jtj
        lTaqiPv1XJSX9WqlZNBz7gekdX1pDmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686133263;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PaXymw7r2ADMno+XYANmnydgCB3s3HtZ/gj7X6DBhRc=;
        b=pYvlyw5JxqoI7wvZHzcb/+G8R8ZEDK5z/bLPAcqkyLXRVeqfv+ukSRUdvw2FmhPAW25a4G
        T2CBVTCsheQZ24CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE5FC13776;
        Wed,  7 Jun 2023 10:21:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a3peMg9agGSNfAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 07 Jun 2023 10:21:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4FF65A0754; Wed,  7 Jun 2023 12:21:03 +0200 (CEST)
Date:   Wed, 7 Jun 2023 12:21:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v2 11/12] ext4: Add allocation criteria 1.5 (CR1_5)
Message-ID: <20230607102103.gavbiywdudx54opk@quack3>
References: <cover.1685449706.git.ojaswin@linux.ibm.com>
 <150fdf65c8e4cc4dba71e020ce0859bcf636a5ff.1685449706.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <150fdf65c8e4cc4dba71e020ce0859bcf636a5ff.1685449706.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 30-05-23 18:03:49, Ojaswin Mujoo wrote:
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
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> ext4 squash

Why is this here?

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
> +	unsigned long num_stripe_clusters = 0;
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
> +	if (min_order < 0)
> +		min_order = 0;
> +
> +	if (1 << min_order < ac->ac_o_ex.fe_len)
> +		min_order = fls(ac->ac_o_ex.fe_len) + 1;
> +
> +	if (sbi->s_stripe > 0) {
> +		/*
> +		 * We are assuming that stripe size is always a multiple of
> +		 * cluster ratio otherwise __ext4_fill_super exists early.
> +		 */
> +		num_stripe_clusters = EXT4_NUM_B2C(sbi, sbi->s_stripe);
> +		if (1 << min_order < num_stripe_clusters)
> +			min_order = fls(num_stripe_clusters);
> +	}
> +
> +	for (i = order; i >= min_order; i--) {
> +		int frag_order;
> +		/*
> +		 * Scale down goal len to make sure we find something
> +		 * in the free fragments list. Basically, reduce
> +		 * preallocations.
> +		 */
> +		ac->ac_g_ex.fe_len = 1 << i;

I smell some off-by-one issues here. Look fls(1) == 1 so (1 << fls(n)) > n.
Hence this loop will actually *grow* the goal allocation length. Also I'm
not sure why you have +1 in min_order = fls(ac->ac_o_ex.fe_len) + 1.

> +
> +		if (num_stripe_clusters > 0) {
> +			/*
> +			 * Try to round up the adjusted goal to stripe size
						        ^^^ goal length?

> +			 * (in cluster units) multiple for efficiency.
> +			 *
> +			 * XXX: Is s->stripe always a power of 2? In that case
> +			 * we can use the faster round_up() variant.
> +			 */

I don't think s->stripe has to be a power of 2. E.g. when you have three
data disks in a RAID config.

Otherwise the patch looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
