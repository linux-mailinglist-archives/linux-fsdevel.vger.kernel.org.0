Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEEF7384F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 15:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjFUN2p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 09:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjFUN2n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:28:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB4E198D;
        Wed, 21 Jun 2023 06:28:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 226A11FE70;
        Wed, 21 Jun 2023 13:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687354120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kjdJelqDTVhJUB/xjRe3YFSz+MZjkGpTSPWW+f3VVfc=;
        b=VT7erQCIx5B9U482i18hc1ZfkKVW5obeo78ahGlb6a59CHtH8U1LW82pxwZbTip6OD1Gt6
        sC2KmiSWjoL6ARe4oO3vYd8l2tVpbcFIDWUSc22Y3+femt7NA3QfN6rNqYREqJuF63W/JR
        Tqm+WnHIP1ge31S2kNosLapdStp5nfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687354120;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kjdJelqDTVhJUB/xjRe3YFSz+MZjkGpTSPWW+f3VVfc=;
        b=e/dOLJvQtsColjPEN4nfhF32U0kiM6zDcysERVE6H/veBdnsWn0VH7/G3pND2UbiZh0kBj
        WURBZsifNDv5h1Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14CC3134B1;
        Wed, 21 Jun 2023 13:28:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YMMHBQj7kmSmaAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 21 Jun 2023 13:28:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A2190A075D; Wed, 21 Jun 2023 15:28:39 +0200 (CEST)
Date:   Wed, 21 Jun 2023 15:28:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] fsdax: remove redundant variable 'error'
Message-ID: <20230621132839.rvu2pvhcizhbzmyf@quack3>
References: <20230621130256.2676126-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621130256.2676126-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 21-06-23 14:02:56, Colin Ian King wrote:
> The variable 'error' is being assigned a value that is never read,
> the assignment and the variable and redundant and can be removed.
> Cleans up clang scan build warning:
> 
> fs/dax.c:1880:10: warning: Although the value stored to 'error' is
> used in the enclosing expression, the value is never actually read
> from 'error' [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Yeah, good spotting. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dax.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 2ababb89918d..cb36c6746fc4 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1830,7 +1830,6 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	vm_fault_t ret = VM_FAULT_FALLBACK;
>  	pgoff_t max_pgoff;
>  	void *entry;
> -	int error;
>  
>  	if (vmf->flags & FAULT_FLAG_WRITE)
>  		iter.flags |= IOMAP_WRITE;
> @@ -1877,7 +1876,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	}
>  
>  	iter.pos = (loff_t)xas.xa_index << PAGE_SHIFT;
> -	while ((error = iomap_iter(&iter, ops)) > 0) {
> +	while (iomap_iter(&iter, ops) > 0) {
>  		if (iomap_length(&iter) < PMD_SIZE)
>  			continue; /* actually breaks out of the loop */
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
