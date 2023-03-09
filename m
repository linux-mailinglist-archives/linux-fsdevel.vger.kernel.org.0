Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3816B26C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 15:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjCIOX2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 09:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjCIOXL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:23:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6536B4ECF2;
        Thu,  9 Mar 2023 06:23:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C805520106;
        Thu,  9 Mar 2023 14:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678371787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=500HkQAhd/wkc0kkHSkZ+RiwhS0XNpxSyFvvUSshsCY=;
        b=2CUSoRi6g47lADdJMS8gpsKmcPazyKn1/EgYXJ36U0pXKFLnZ6DHvqdvy6E89q+qJvSjdH
        DMx+GlgfXgq0i120TyYVCV/yMAG+7cutSQrT7BJ4KhyNexAoXw95rpKz7q5RagktxO1dwZ
        twC49UmL7GsVc50LQkOPpxykwEHHSNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678371787;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=500HkQAhd/wkc0kkHSkZ+RiwhS0XNpxSyFvvUSshsCY=;
        b=rOW6Dg/t9vPCTlzJsGtAsS7Hxk8BejZIB1PYzY7ZvMArrh3qb2+qfwuMd/LGdwo+w57wdF
        mS2ER9z+g9SsJGCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9E5D1391B;
        Thu,  9 Mar 2023 14:23:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jwVZLcvrCWQxNgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Mar 2023 14:23:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4C9E4A06FF; Thu,  9 Mar 2023 15:23:07 +0100 (CET)
Date:   Thu, 9 Mar 2023 15:23:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC 09/11] ext4: Ensure ext4_mb_prefetch_fini() is called for
 all prefetched BGs
Message-ID: <20230309142307.zkjnspjyc6ymqgeh@quack3>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
 <7540e4069b22fce42dbef34ee0796d5cf5d82fe3.1674822311.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7540e4069b22fce42dbef34ee0796d5cf5d82fe3.1674822311.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 27-01-23 18:07:36, Ojaswin Mujoo wrote:
> Before this patch, the call stack in ext4_run_li_request is as follows:
> 
>   /*
>    * nr = no. of BGs we want to fetch (=s_mb_prefetch)
>    * prefetch_ios = no. of BGs not uptodate after
>    * 		    ext4_read_block_bitmap_nowait()
>    */
>   next_group = ext4_mb_prefetch(sb, group, nr, prefetch_ios);
>   ext4_mb_prefetch_fini(sb, next_group prefetch_ios);
> 
> ext4_mb_prefetch_fini() will only try to initialize buddies for BGs in
> range [next_group - prefetch_ios, next_group). This is incorrect since
> sometimes (prefetch_ios < nr), which causes ext4_mb_prefetch_fini() to
> incorrectly ignore some of the BGs that might need initialization. This
> issue is more notable now with the previous patch enabling "fetching" of
> BLOCK_UNINIT BGs which are marked buffer_uptodate by default.
> 
> Fix this by passing nr to ext4_mb_prefetch_fini() instead of
> prefetch_ios so that it considers the right range of groups.
> 
> Similarly, make sure we don't pass nr=0 to ext4_mb_prefetch_fini() in
> ext4_mb_regular_allocator() since we might have prefetched BLOCK_UNINIT
> groups that would need buddy initialization.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c |  4 ----
>  fs/ext4/super.c   | 11 ++++-------
>  2 files changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 48726a831264..410c9636907b 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2702,8 +2702,6 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  			if ((prefetch_grp == group) &&
>  			    (cr > CR1 ||
>  			     prefetch_ios < sbi->s_mb_prefetch_limit)) {
> -				unsigned int curr_ios = prefetch_ios;
> -
>  				nr = sbi->s_mb_prefetch;
>  				if (ext4_has_feature_flex_bg(sb)) {
>  					nr = 1 << sbi->s_log_groups_per_flex;
> @@ -2712,8 +2710,6 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  				}
>  				prefetch_grp = ext4_mb_prefetch(sb, group,
>  							nr, &prefetch_ios);
> -				if (prefetch_ios == curr_ios)
> -					nr = 0;
>  			}
>  
>  			/* This now checks without needing the buddy page */
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 72ead3b56706..9dbb09cfc8f7 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3636,16 +3636,13 @@ static int ext4_run_li_request(struct ext4_li_request *elr)
>  	ext4_group_t group = elr->lr_next_group;
>  	unsigned int prefetch_ios = 0;
>  	int ret = 0;
> +	int nr = EXT4_SB(sb)->s_mb_prefetch;
>  	u64 start_time;
>  
>  	if (elr->lr_mode == EXT4_LI_MODE_PREFETCH_BBITMAP) {
> -		elr->lr_next_group = ext4_mb_prefetch(sb, group,
> -				EXT4_SB(sb)->s_mb_prefetch, &prefetch_ios);
> -		if (prefetch_ios)
> -			ext4_mb_prefetch_fini(sb, elr->lr_next_group,
> -					      prefetch_ios);
> -		trace_ext4_prefetch_bitmaps(sb, group, elr->lr_next_group,
> -					    prefetch_ios);
> +		elr->lr_next_group = ext4_mb_prefetch(sb, group, nr, &prefetch_ios);
> +		ext4_mb_prefetch_fini(sb, elr->lr_next_group, nr);
> +		trace_ext4_prefetch_bitmaps(sb, group, elr->lr_next_group, nr);
>  		if (group >= elr->lr_next_group) {
>  			ret = 1;
>  			if (elr->lr_first_not_zeroed != ngroups &&
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
