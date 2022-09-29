Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B580F5EF442
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 13:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbiI2L0U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 07:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbiI2L0Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:26:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EB114D499;
        Thu, 29 Sep 2022 04:26:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 999F121AC4;
        Thu, 29 Sep 2022 11:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664450773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xR0Nk/sNdu7ZIksq1QM9BpsUZ7c9WAN9HzxGcxznGh8=;
        b=eWZ6pckQkn9K9so0gwaSOPZYDVisZoKZCRWvlgJqKa91lxa6/rMj8cF5cLlb4Oz/xClmMh
        ayOMr/thsavR1xSGL2VS9/g4ekWEjCpbQpAbDyAwE+eaQm79eQI5ykdQ0vhmms120wegKs
        s8h8Qd1OzsoOt2vvoRCN1DjYW/fd+8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664450773;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xR0Nk/sNdu7ZIksq1QM9BpsUZ7c9WAN9HzxGcxznGh8=;
        b=0vrkJcKs5owgAhMtnaaFjHjz8yhK07c0yKtelN1aE1gcPn/xzsi/FHy+fRq0jBFlduGhOs
        +JsRklu3ycgtc9DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B86B1348E;
        Thu, 29 Sep 2022 11:26:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6n8OItWANWPobQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 29 Sep 2022 11:26:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 27719A0681; Thu, 29 Sep 2022 13:26:13 +0200 (CEST)
Date:   Thu, 29 Sep 2022 13:26:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC v3 2/8] ext4: Refactor code related to freeing PAs
Message-ID: <20220929112613.3pwvxod3tpkbvmc2@quack3>
References: <cover.1664269665.git.ojaswin@linux.ibm.com>
 <dd083c3e6db5c2938bcaecbd247bc9ecd6646d89.1664269665.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd083c3e6db5c2938bcaecbd247bc9ecd6646d89.1664269665.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 27-09-22 14:46:42, Ojaswin Mujoo wrote:
> This patch makes the following changes:
> 
> *  Rename ext4_mb_pa_free to ext4_mb_pa_put_free
>    to better reflect its purpose
> 
> *  Add new ext4_mb_pa_free() which only handles freeing
> 
> *  Refactor ext4_mb_pa_callback() to use ext4_mb_pa_free()
> 
> There are no functional changes in this patch
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 2e3eb632a216..8be6f8765a6f 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4531,16 +4531,21 @@ static void ext4_mb_mark_pa_deleted(struct super_block *sb,
>  	}
>  }
>  
> -static void ext4_mb_pa_callback(struct rcu_head *head)
> +static void inline ext4_mb_pa_free(struct ext4_prealloc_space *pa)
>  {
> -	struct ext4_prealloc_space *pa;
> -	pa = container_of(head, struct ext4_prealloc_space, u.pa_rcu);
> -
> +	BUG_ON(!pa);
>  	BUG_ON(atomic_read(&pa->pa_count));
>  	BUG_ON(pa->pa_deleted == 0);
>  	kmem_cache_free(ext4_pspace_cachep, pa);
>  }
>  
> +static void ext4_mb_pa_callback(struct rcu_head *head)
> +{
> +	struct ext4_prealloc_space *pa;
> +	pa = container_of(head, struct ext4_prealloc_space, u.pa_rcu);
> +	ext4_mb_pa_free(pa);
> +}
> +
>  /*
>   * drops a reference to preallocated space descriptor
>   * if this was the last reference and the space is consumed
> @@ -5067,14 +5072,20 @@ static int ext4_mb_pa_alloc(struct ext4_allocation_context *ac)
>  	return 0;
>  }
>  
> -static void ext4_mb_pa_free(struct ext4_allocation_context *ac)
> +static void ext4_mb_pa_put_free(struct ext4_allocation_context *ac)
>  {
>  	struct ext4_prealloc_space *pa = ac->ac_pa;
>  
>  	BUG_ON(!pa);
>  	ac->ac_pa = NULL;
>  	WARN_ON(!atomic_dec_and_test(&pa->pa_count));
> -	kmem_cache_free(ext4_pspace_cachep, pa);
> +	/*
> +	 * current function is only called due to an error or due to
> +	 * len of found blocks < len of requested blocks hence the PA has not
> +	 * been added to grp->bb_prealloc_list. So we don't need to lock it
> +	 */
> +	pa->pa_deleted = 1;
> +	ext4_mb_pa_free(pa);
>  }
>  
>  #ifdef CONFIG_EXT4_DEBUG
> @@ -5623,13 +5634,13 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
>  		 * So we have to free this pa here itself.
>  		 */
>  		if (*errp) {
> -			ext4_mb_pa_free(ac);
> +			ext4_mb_pa_put_free(ac);
>  			ext4_discard_allocated_blocks(ac);
>  			goto errout;
>  		}
>  		if (ac->ac_status == AC_STATUS_FOUND &&
>  			ac->ac_o_ex.fe_len >= ac->ac_f_ex.fe_len)
> -			ext4_mb_pa_free(ac);
> +			ext4_mb_pa_put_free(ac);
>  	}
>  	if (likely(ac->ac_status == AC_STATUS_FOUND)) {
>  		*errp = ext4_mb_mark_diskspace_used(ac, handle, reserv_clstrs);
> @@ -5648,7 +5659,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
>  		 * If block allocation fails then the pa allocated above
>  		 * needs to be freed here itself.
>  		 */
> -		ext4_mb_pa_free(ac);
> +		ext4_mb_pa_put_free(ac);
>  		*errp = -ENOSPC;
>  	}
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
