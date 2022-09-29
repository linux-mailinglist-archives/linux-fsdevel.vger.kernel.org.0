Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BEA5EF458
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 13:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiI2LcF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 07:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiI2LcE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:32:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7D81432AF;
        Thu, 29 Sep 2022 04:32:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D447621C08;
        Thu, 29 Sep 2022 11:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664451121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jeGyVzxEPfCc3Ba6i0mzqGwb3fxnvxrlnA7gUpxqvlE=;
        b=MnQn5C1fuvzrzKKTEyLL0eltGlUXjNy+RtBzsis8lMZsfBgnYKwhM0jnAfA16CDAxCkHid
        nXCxJRbCIe0QTpu+9GKGev8fe71FmxIYb0eAcM8q9gY+TPpQ4LGt/GbaesOvNxP1rGd9hN
        5weYlHb6jMfHRMRO10mAcU/72bFgRJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664451121;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jeGyVzxEPfCc3Ba6i0mzqGwb3fxnvxrlnA7gUpxqvlE=;
        b=3/J8ojuXmWeDuCancxCdwkBH745Wgt9vLLjio8YMLp2QOo2M4LkVFEnCAgU08zzCg37V3b
        hDzkiyZ2TNhZpnBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C57DF1348E;
        Thu, 29 Sep 2022 11:32:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Vvg0MDGCNWNrcAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 29 Sep 2022 11:32:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 39211A0681; Thu, 29 Sep 2022 13:32:01 +0200 (CEST)
Date:   Thu, 29 Sep 2022 13:32:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC v3 4/8] ext4: Move overlap assert logic into a separate
 function
Message-ID: <20220929113201.2fbwzw2c7vecnduc@quack3>
References: <cover.1664269665.git.ojaswin@linux.ibm.com>
 <a762293342ceadc5c49870db0394a15ca53eebaa.1664269665.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a762293342ceadc5c49870db0394a15ca53eebaa.1664269665.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 27-09-22 14:46:44, Ojaswin Mujoo wrote:
> Abstract out the logic to double check for overlaps in normalize_pa to
> a separate function. Since there has been no reports in past where we
> have seen any overlaps which hits this bug_on(), in future we can
> consider calling this function under "#ifdef AGGRESSIVE_CHECK" only.
> 
> There are no functional changes in this patch
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

And I agree it might be interesting to move this code under appropriate
ifdef.

								Honza

> ---
>  fs/ext4/mballoc.c | 36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 84950df709bb..d1ce34888dcc 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3985,6 +3985,29 @@ static void ext4_mb_normalize_group_request(struct ext4_allocation_context *ac)
>  	mb_debug(sb, "goal %u blocks for locality group\n", ac->ac_g_ex.fe_len);
>  }
>  
> +static inline void
> +ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
> +			  ext4_lblk_t start, ext4_lblk_t end)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
> +	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
> +	struct ext4_prealloc_space *tmp_pa;
> +	ext4_lblk_t tmp_pa_start, tmp_pa_end;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
> +		spin_lock(&tmp_pa->pa_lock);
> +		if (tmp_pa->pa_deleted == 0) {
> +			tmp_pa_start = tmp_pa->pa_lstart;
> +			tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
> +
> +			BUG_ON(!(start >= tmp_pa_end || end <= tmp_pa_start));
> +		}
> +		spin_unlock(&tmp_pa->pa_lock);
> +	}
> +	rcu_read_unlock();
> +}
> +
>  /*
>   * Normalization means making request better in terms of
>   * size and alignment
> @@ -4141,18 +4164,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  	size = end - start;
>  
>  	/* XXX: extra loop to check we really don't overlap preallocations */
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
> -		spin_lock(&tmp_pa->pa_lock);
> -		if (tmp_pa->pa_deleted == 0) {
> -			tmp_pa_start = tmp_pa->pa_lstart;
> -			tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
> -
> -			BUG_ON(!(start >= tmp_pa_end || end <= tmp_pa_start));
> -		}
> -		spin_unlock(&tmp_pa->pa_lock);
> -	}
> -	rcu_read_unlock();
> +	ext4_mb_pa_assert_overlap(ac, start, end);
>  
>  	/*
>  	 * In this function "start" and "size" are normalized for better
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
