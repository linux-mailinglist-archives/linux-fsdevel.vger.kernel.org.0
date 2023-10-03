Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2FE7B69D7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 15:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjJCNHg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 09:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjJCNHf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:07:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF66893;
        Tue,  3 Oct 2023 06:07:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A76911F45B;
        Tue,  3 Oct 2023 13:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696338450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FrpETq8twusJ5sdH9d+XrhUFsRvR1gF/4TiRFUUmkNo=;
        b=tOXjeMZGVlb97/Zga+TON5k8gXv2c7gmG4KxASLu0sE/TvavPKgmvnkSVcpY5tCwIgqIMJ
        JdgDc1Hx1IuePwvXuFIRv9VJMtfufVzx6B8B1RPpjjOF8rfyiHvgKAYr3VGQLitpsCbAl3
        fiVAJ0Oh6Dnx/oe7HtEjBFRLL1WG5JI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696338450;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FrpETq8twusJ5sdH9d+XrhUFsRvR1gF/4TiRFUUmkNo=;
        b=Tc5HhKdZU8QKXE3JUQyWi4uE30im3D3QubNCSrnQjD7NHbDOKkdpTAkHv1shINBQYVdCIF
        jz/GIVFtdYoFfJBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A6D4132D4;
        Tue,  3 Oct 2023 13:07:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0Aa4JRISHGWVLgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 03 Oct 2023 13:07:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 48209A07CC; Tue,  3 Oct 2023 15:07:30 +0200 (CEST)
Date:   Tue, 3 Oct 2023 15:07:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/8] shmem: remove vma arg from shmem_get_folio_gfp()
Message-ID: <20231003130730.hiag5s6ubditcazg@quack3>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
 <d9ce6f65-a2ed-48f4-4299-fdb0544875c5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9ce6f65-a2ed-48f4-4299-fdb0544875c5@google.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 29-09-23 20:26:53, Hugh Dickins wrote:
> The vma is already there in vmf->vma, so no need for a separate arg.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/shmem.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 69595d341882..824eb55671d2 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1921,14 +1921,13 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>   * vm. If we swap it in we mark it dirty since we also free the swap
>   * entry since a page cannot live in both the swap and page cache.
>   *
> - * vma, vmf, and fault_type are only supplied by shmem_fault:
> - * otherwise they are NULL.
> + * vmf and fault_type are only supplied by shmem_fault: otherwise they are NULL.
>   */
>  static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>  		struct folio **foliop, enum sgp_type sgp, gfp_t gfp,
> -		struct vm_area_struct *vma, struct vm_fault *vmf,
> -		vm_fault_t *fault_type)
> +		struct vm_fault *vmf, vm_fault_t *fault_type)
>  {
> +	struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
>  	struct address_space *mapping = inode->i_mapping;
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	struct shmem_sb_info *sbinfo;
> @@ -2141,7 +2140,7 @@ int shmem_get_folio(struct inode *inode, pgoff_t index, struct folio **foliop,
>  		enum sgp_type sgp)
>  {
>  	return shmem_get_folio_gfp(inode, index, foliop, sgp,
> -			mapping_gfp_mask(inode->i_mapping), NULL, NULL, NULL);
> +			mapping_gfp_mask(inode->i_mapping), NULL, NULL);
>  }
>  
>  /*
> @@ -2225,7 +2224,7 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
>  	}
>  
>  	err = shmem_get_folio_gfp(inode, vmf->pgoff, &folio, SGP_CACHE,
> -				  gfp, vma, vmf, &ret);
> +				  gfp, vmf, &ret);
>  	if (err)
>  		return vmf_error(err);
>  	if (folio)
> @@ -4897,7 +4896,7 @@ struct folio *shmem_read_folio_gfp(struct address_space *mapping,
>  
>  	BUG_ON(!shmem_mapping(mapping));
>  	error = shmem_get_folio_gfp(inode, index, &folio, SGP_CACHE,
> -				  gfp, NULL, NULL, NULL);
> +				    gfp, NULL, NULL);
>  	if (error)
>  		return ERR_PTR(error);
>  
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
