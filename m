Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337676B2329
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 12:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjCILgr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 06:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCILgq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:36:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5AF2C659;
        Thu,  9 Mar 2023 03:36:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BB2C121EC3;
        Thu,  9 Mar 2023 11:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678361803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UFLwk3CURL1yX53lyCf7/30PNixTYcC5gLluvRO2Img=;
        b=p2/VRyn/3AW0vcDv3JZBSPjWLMgRmpwl31MVsV2NQcHtuQ1xRubKaXw0IXhaWuIzLsuJPc
        0gFib0prec0r6ii+2mWwXzIRcFVvXrEWRCLFWudlaGXk62ts5UamOCM92ViwwKiJotIaSq
        DnBZdRKiK4dLvwjgVkZGWN1+76mx76I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678361803;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UFLwk3CURL1yX53lyCf7/30PNixTYcC5gLluvRO2Img=;
        b=SB6VDibhrtWkblCbWpb+KRUmFmNx4nP3uctXBQGRJfpzBTJde795VXbhloQdNh81uuo6wm
        HfbZzfDUQfJ+jcBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACB481391B;
        Thu,  9 Mar 2023 11:36:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3t7SKcvECWSwVAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Mar 2023 11:36:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2A6D5A06FF; Thu,  9 Mar 2023 12:36:43 +0100 (CET)
Date:   Thu, 9 Mar 2023 12:36:43 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC 01/11] ext4: mballoc: Remove useless setting of ac_criteria
Message-ID: <20230309113643.tlyyo3ssv7braw7a@quack3>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
 <08aadf4fd475d87020c60792d81276a28d7176c1.1674822311.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08aadf4fd475d87020c60792d81276a28d7176c1.1674822311.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 27-01-23 18:07:28, Ojaswin Mujoo wrote:
> There will be changes coming in future patches which will introduce a new
> criteria for block allocation. This removes the useless setting of ac_criteria.
> AFAIU, this might be only used to differentiate between whether a preallocated
> blocks was allocated or was regular allocator called for allocating blocks.
> Hence this also adds the debug prints to identify what type of block allocation
> was done in ext4_mb_show_ac().
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 5b2ae37a8b80..572e79a698d4 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4391,7 +4391,6 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  			atomic_inc(&pa->pa_count);
>  			ext4_mb_use_inode_pa(ac, pa);
>  			spin_unlock(&pa->pa_lock);
> -			ac->ac_criteria = 10;
>  			rcu_read_unlock();
>  			return true;
>  		}
> @@ -4434,7 +4433,6 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  	}
>  	if (cpa) {
>  		ext4_mb_use_group_pa(ac, cpa);
> -		ac->ac_criteria = 20;
>  		return true;
>  	}
>  	return false;
> @@ -5131,6 +5129,10 @@ static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
>  			(unsigned long)ac->ac_b_ex.fe_logical,
>  			(int)ac->ac_criteria);
>  	mb_debug(sb, "%u found", ac->ac_found);
> +	mb_debug(sb, "used pa: %s, ", ac->ac_pa ? "yes" : "no");
> +	if (ac->ac_pa)
> +		mb_debug(sb, "pa_type %s\n", ac->ac_pa->pa_type == MB_GROUP_PA ?
> +			 "group pa" : "inode pa");
>  	ext4_mb_show_pa(sb);
>  }
>  #else
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
