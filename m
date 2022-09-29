Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FCD5EF465
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 13:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbiI2Lge (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 07:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiI2Lgd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:36:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCB813C846;
        Thu, 29 Sep 2022 04:36:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3B7F71F388;
        Thu, 29 Sep 2022 11:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664451391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xMRJe1MU1ptYwTyQ+JepMZmanBEMC61aFRA+CflrhZU=;
        b=rAISbCTn0I1rjrXjAraHtB+HRHHuhe3fp6fgjCjCHK6qP2I5fuppESrN5U2bKXOkQmxeed
        BxqKDYqtb9Vc+EsvriwWuMaU4oZmHKOiq53AToxmve4hrlC5MWvIf0ZVj3K1B6qQ3SYRvq
        325DWAoKxdSK8ksM0ZFR4FIz9Aou/os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664451391;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xMRJe1MU1ptYwTyQ+JepMZmanBEMC61aFRA+CflrhZU=;
        b=x+MK6pVvnlyjLFCpv7YrIQQUYebfY/BJoIXqBNqZVzM1O3JHSyHJhivYZ6aQ0YwjO5Miqq
        74JOf0iLBNteSODQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D2041348E;
        Thu, 29 Sep 2022 11:36:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id E576Cj+DNWNocgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 29 Sep 2022 11:36:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7DEECA0681; Thu, 29 Sep 2022 13:36:30 +0200 (CEST)
Date:   Thu, 29 Sep 2022 13:36:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC v3 5/8] ext4: Abstract out overlap fix/check logic in
 ext4_mb_normalize_request()
Message-ID: <20220929113630.xdergbnbru63q6s7@quack3>
References: <cover.1664269665.git.ojaswin@linux.ibm.com>
 <f6787e57f6deb1bff2a1d1c070dfe20d281ed5d1.1664269665.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6787e57f6deb1bff2a1d1c070dfe20d281ed5d1.1664269665.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 27-09-22 14:46:45, Ojaswin Mujoo wrote:
> Abstract out the logic of fixing PA overlaps in ext4_mb_normalize_request to
> improve readability of code. This also makes it easier to make changes
> to the overlap logic in future.
> 
> There are no functional changes in this patch
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 110 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 69 insertions(+), 41 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index d1ce34888dcc..dda9a72c81d9 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4008,6 +4008,74 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
>  	rcu_read_unlock();
>  }
>  
> +/*
> + * Given an allocation context "ac" and a range "start", "end", check
> + * and adjust boundaries if the range overlaps with any of the existing
> + * preallocatoins stored in the corresponding inode of the allocation context.
> + *
> + *Parameters:
> + *	ac			allocation context
> + *	start			start of the new range
> + *	end			end of the new range
> + */
> +static inline void
> +ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
> +			 ext4_lblk_t *start, ext4_lblk_t *end)
> +{
> +	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
> +	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
> +	struct ext4_prealloc_space *tmp_pa;
> +	ext4_lblk_t new_start, new_end;
> +	ext4_lblk_t tmp_pa_start, tmp_pa_end;
> +
> +	new_start = *start;
> +	new_end = *end;
> +
> +	/* check we don't cross already preallocated blocks */
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
> +		if (tmp_pa->pa_deleted)
> +			continue;
> +		spin_lock(&tmp_pa->pa_lock);
> +		if (tmp_pa->pa_deleted) {
> +			spin_unlock(&tmp_pa->pa_lock);
> +			continue;
> +		}
> +
> +		tmp_pa_start = tmp_pa->pa_lstart;
> +		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
> +
> +		/* PA must not overlap original request */
> +		BUG_ON(!(ac->ac_o_ex.fe_logical >= tmp_pa_end ||
> +			ac->ac_o_ex.fe_logical < tmp_pa_start));
> +
> +		/* skip PAs this normalized request doesn't overlap with */
> +		if (tmp_pa_start >= new_end || tmp_pa_end <= new_start) {
> +			spin_unlock(&tmp_pa->pa_lock);
> +			continue;
> +		}
> +		BUG_ON(tmp_pa_start <= new_start && tmp_pa_end >= new_end);
> +
> +		/* adjust start or end to be adjacent to this pa */
> +		if (tmp_pa_end <= ac->ac_o_ex.fe_logical) {
> +			BUG_ON(tmp_pa_end < new_start);
> +			new_start = tmp_pa_end;
> +		} else if (tmp_pa_start > ac->ac_o_ex.fe_logical) {
> +			BUG_ON(tmp_pa_start > new_end);
> +			new_end = tmp_pa_start;
> +		}
> +		spin_unlock(&tmp_pa->pa_lock);
> +	}
> +	rcu_read_unlock();
> +
> +	/* XXX: extra loop to check we really don't overlap preallocations */
> +	ext4_mb_pa_assert_overlap(ac, new_start, new_end);
> +
> +	*start = new_start;
> +	*end = new_end;
> +	return;
> +}
> +
>  /*
>   * Normalization means making request better in terms of
>   * size and alignment
> @@ -4022,9 +4090,6 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  	loff_t size, start_off;
>  	loff_t orig_size __maybe_unused;
>  	ext4_lblk_t start;
> -	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
> -	struct ext4_prealloc_space *tmp_pa;
> -	ext4_lblk_t tmp_pa_start, tmp_pa_end;
>  
>  	/* do normalize only data requests, metadata requests
>  	   do not need preallocation */
> @@ -4125,47 +4190,10 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  
>  	end = start + size;
>  
> -	/* check we don't cross already preallocated blocks */
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
> -		if (tmp_pa->pa_deleted)
> -			continue;
> -		spin_lock(&tmp_pa->pa_lock);
> -		if (tmp_pa->pa_deleted) {
> -			spin_unlock(&tmp_pa->pa_lock);
> -			continue;
> -		}
> -
> -		tmp_pa_start = tmp_pa->pa_lstart;
> -		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
> -
> -		/* PA must not overlap original request */
> -		BUG_ON(!(ac->ac_o_ex.fe_logical >= tmp_pa_end ||
> -			ac->ac_o_ex.fe_logical < tmp_pa_start));
> -
> -		/* skip PAs this normalized request doesn't overlap with */
> -		if (tmp_pa_start >= end || tmp_pa_end <= start) {
> -			spin_unlock(&tmp_pa->pa_lock);
> -			continue;
> -		}
> -		BUG_ON(tmp_pa_start <= start && tmp_pa_end >= end);
> +	ext4_mb_pa_adjust_overlap(ac, &start, &end);
>  
> -		/* adjust start or end to be adjacent to this pa */
> -		if (tmp_pa_end <= ac->ac_o_ex.fe_logical) {
> -			BUG_ON(tmp_pa_end < start);
> -			start = tmp_pa_end;
> -		} else if (tmp_pa_start > ac->ac_o_ex.fe_logical) {
> -			BUG_ON(tmp_pa_start > end);
> -			end = tmp_pa_start;
> -		}
> -		spin_unlock(&tmp_pa->pa_lock);
> -	}
> -	rcu_read_unlock();
>  	size = end - start;
>  
> -	/* XXX: extra loop to check we really don't overlap preallocations */
> -	ext4_mb_pa_assert_overlap(ac, start, end);
> -
>  	/*
>  	 * In this function "start" and "size" are normalized for better
>  	 * alignment and length such that we could preallocate more blocks.
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
