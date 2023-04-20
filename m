Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420196E95D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 15:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjDTN2B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 09:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDTN2A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:28:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0D14220
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 06:27:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5E26421AE5;
        Thu, 20 Apr 2023 13:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681997278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2hvC/P1vumbLaX08ojUUrQkLBTTJp+TM+NOYrdCUhHU=;
        b=w7hrfdWnuY+T2vHkiJOc7QUz+vzF3Ld8VpxEYn4mnxM05B5Wrkhc3KjlirMhK391U9ko+W
        3A5fLGaYA8Gp32Zf/LiRumpCSJQ+5xqIPp2fSd/n7I6pCoJ7qHThINWnGDFyOxg3T+wJRB
        YqSwthe712x00F1E+1xzbbZ6C26Wmvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681997278;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2hvC/P1vumbLaX08ojUUrQkLBTTJp+TM+NOYrdCUhHU=;
        b=stnNSiqptpuHkoiYb/ye4CBCzuHg6ePwrSQwW2EyQhLeCy7oZuYeKCuOcD9vq/xAZyXfYP
        KcBZ0ZlKoNEA8VAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5298413584;
        Thu, 20 Apr 2023 13:27:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OP8nFN49QWTsGgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 20 Apr 2023 13:27:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 891F3A0729; Thu, 20 Apr 2023 15:17:54 +0200 (CEST)
Date:   Thu, 20 Apr 2023 15:17:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     cem@kernel.org
Cc:     hughd@google.com, jack@suse.cz, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH V2 1/6] shmem: make shmem_inode_acct_block() return error
Message-ID: <20230420131754.wncxnlqwcd5s5g3o@quack3>
References: <20230420080359.2551150-1-cem@kernel.org>
 <20230420080359.2551150-2-cem@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420080359.2551150-2-cem@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 20-04-23 10:03:54, cem@kernel.org wrote:
> From: Lukas Czerner <lczerner@redhat.com>
> 
> Make shmem_inode_acct_block() return proper error code instead of bool.
> This will be useful later when we introduce quota support.
> 
> There should be no functional change.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> ---
> V2:
> 	- remove unused variable initialization on
> 	  shmem_alloc_and_acct_folio
> 
>  mm/shmem.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 448f393d8ab2b..b1b3b826f6189 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -198,13 +198,14 @@ static inline void shmem_unacct_blocks(unsigned long flags, long pages)
>  		vm_unacct_memory(pages * VM_ACCT(PAGE_SIZE));
>  }
>  
> -static inline bool shmem_inode_acct_block(struct inode *inode, long pages)
> +static inline int shmem_inode_acct_block(struct inode *inode, long pages)
>  {
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
> +	int err = -ENOSPC;
>  
>  	if (shmem_acct_block(info->flags, pages))
> -		return false;
> +		return err;
>  
>  	if (sbinfo->max_blocks) {
>  		if (percpu_counter_compare(&sbinfo->used_blocks,
> @@ -213,11 +214,11 @@ static inline bool shmem_inode_acct_block(struct inode *inode, long pages)
>  		percpu_counter_add(&sbinfo->used_blocks, pages);
>  	}
>  
> -	return true;
> +	return 0;
>  
>  unacct:
>  	shmem_unacct_blocks(info->flags, pages);
> -	return false;
> +	return err;
>  }
>  
>  static inline void shmem_inode_unacct_blocks(struct inode *inode, long pages)
> @@ -369,7 +370,7 @@ bool shmem_charge(struct inode *inode, long pages)
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	unsigned long flags;
>  
> -	if (!shmem_inode_acct_block(inode, pages))
> +	if (shmem_inode_acct_block(inode, pages))
>  		return false;
>  
>  	/* nrpages adjustment first, then shmem_recalc_inode() when balanced */
> @@ -1583,13 +1584,14 @@ static struct folio *shmem_alloc_and_acct_folio(gfp_t gfp, struct inode *inode,
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	struct folio *folio;
>  	int nr;
> -	int err = -ENOSPC;
> +	int err;
>  
>  	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
>  		huge = false;
>  	nr = huge ? HPAGE_PMD_NR : 1;
>  
> -	if (!shmem_inode_acct_block(inode, nr))
> +	err = shmem_inode_acct_block(inode, nr);
> +	if (err)
>  		goto failed;
>  
>  	if (huge)
> @@ -2433,7 +2435,7 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>  	int ret;
>  	pgoff_t max_off;
>  
> -	if (!shmem_inode_acct_block(inode, 1)) {
> +	if (shmem_inode_acct_block(inode, 1)) {
>  		/*
>  		 * We may have got a page, returned -ENOENT triggering a retry,
>  		 * and now we find ourselves with -ENOMEM. Release the page, to
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
