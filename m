Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7856B23E9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 13:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjCIMRq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 07:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjCIMRn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:17:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443E7EB8A6;
        Thu,  9 Mar 2023 04:17:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 12D4820077;
        Thu,  9 Mar 2023 12:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678364225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NZ34mnLvJ8gVQLVSVWHKU1AB3ileldqMJmN37jEgrbw=;
        b=JYZywW0ESK4fs5GcBwXUlX1WUtxibRtOY8z1Tet+qOzKJ6cAFjXQxzCdlm3rGQYTxs8uHM
        DUxomD7S+KTwxw25UPolSKNP26LKlNPjg+7fSNq+RkAwCWos2Km1wXPe/KhWduDexhO5YH
        8jBDujovmLJCUZ6+T1cmzEFtHfUthjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678364225;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NZ34mnLvJ8gVQLVSVWHKU1AB3ileldqMJmN37jEgrbw=;
        b=IqHZ1eZP/uA1sZ8SOjuVDQ89pSfw9DfHz1l19b1GpVN7SUbe7xm/1uQI6ayX3737Lf14RV
        p7hBvXusIBRVfPAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F341713A10;
        Thu,  9 Mar 2023 12:17:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OWBlO0DOCWSFawAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Mar 2023 12:17:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6C7F6A06FF; Thu,  9 Mar 2023 13:17:04 +0100 (CET)
Date:   Thu, 9 Mar 2023 13:17:04 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC 06/11] ext4: Add counter to track successful allocation of
 goal length
Message-ID: <20230309121704.ogaczohlwmlgku56@quack3>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
 <e6a33294b00b5e02eb0b621e8192a641d34eea1f.1674822311.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6a33294b00b5e02eb0b621e8192a641d34eea1f.1674822311.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 27-01-23 18:07:33, Ojaswin Mujoo wrote:
> Track number of allocations where the length of blocks allocated is equal to the
> length of goal blocks (post normalization). This metric could be useful if
> making changes to the allocator logic in the future as it could give us
> visibility into how often do we trim our requests.
> 
> PS: ac_b_ex.fe_len might get modified due to preallocation efforts and
> hence we use ac_f_ex.fe_len instead since we want to compare how much the
> allocator was able to actually find.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h    | 1 +
>  fs/ext4/mballoc.c | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 4ba2c95915eb..d8fa01e54e81 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1636,6 +1636,7 @@ struct ext4_sb_info {
>  	atomic_t s_bal_cX_ex_scanned[EXT4_MB_NUM_CRS];	/* total extents scanned */
>  	atomic_t s_bal_groups_scanned;	/* number of groups scanned */
>  	atomic_t s_bal_goals;	/* goal hits */
> +	atomic_t s_bal_len_goals;	/* len goal hits */
>  	atomic_t s_bal_breaks;	/* too long searches */
>  	atomic_t s_bal_2orders;	/* 2^order hits */
>  	atomic_t s_bal_cr0_bad_suggestions;
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 07a50a13751c..c4ab8f412d32 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2930,6 +2930,7 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
>  		   atomic64_read(&sbi->s_bal_cX_failed[CR3]));
>  	seq_printf(seq, "\textents_scanned: %u\n", atomic_read(&sbi->s_bal_ex_scanned));
>  	seq_printf(seq, "\t\tgoal_hits: %u\n", atomic_read(&sbi->s_bal_goals));
> +	seq_printf(seq, "\t\tlen_goal_hits: %u\n", atomic_read(&sbi->s_bal_len_goals));
>  	seq_printf(seq, "\t\t2^n_hits: %u\n", atomic_read(&sbi->s_bal_2orders));
>  	seq_printf(seq, "\t\tbreaks: %u\n", atomic_read(&sbi->s_bal_breaks));
>  	seq_printf(seq, "\t\tlost: %u\n", atomic_read(&sbi->s_mb_lost_chunks));
> @@ -4233,6 +4234,8 @@ static void ext4_mb_collect_stats(struct ext4_allocation_context *ac)
>  		if (ac->ac_g_ex.fe_start == ac->ac_b_ex.fe_start &&
>  				ac->ac_g_ex.fe_group == ac->ac_b_ex.fe_group)
>  			atomic_inc(&sbi->s_bal_goals);
> +		if (ac->ac_f_ex.fe_len == ac->ac_g_ex.fe_len)
> +			atomic_inc(&sbi->s_bal_len_goals);
>  		if (ac->ac_found > sbi->s_mb_max_to_scan)
>  			atomic_inc(&sbi->s_bal_breaks);
>  	}
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
