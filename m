Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA047B6A52
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 15:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbjJCNVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 09:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjJCNVh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:21:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43465A6;
        Tue,  3 Oct 2023 06:21:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EFB6B2188C;
        Tue,  3 Oct 2023 13:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696339291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iozkCg85Ccozy8MyCle8fR6zkI5m8e4LQYBL4ht/UCc=;
        b=MvDWSdDZHoI5Z8yy34FreQsOactXQbXnmKhrjaC36zgWmJFPP7cpJWAif38fdw3Rp7tu3F
        VGjQGp/fSV1dz4Mgda5z0dsoy+E3ihzbtgGUJe4MihO/KicX3+apT66ewfpseXWtUuTNmq
        GZnAuXtF3JAbLU3BNxo+/FNqSMnOaZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696339291;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iozkCg85Ccozy8MyCle8fR6zkI5m8e4LQYBL4ht/UCc=;
        b=51K0h5Yaz9ZwJey9g5fagh6ZQx+yCjsMBrgvMLKyaXCpGLMKKkN3qZgj75B7Cwa577Bjry
        GdFPkR//rU3RiqAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD95A132D4;
        Tue,  3 Oct 2023 13:21:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8dIRNlsVHGVWNQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 03 Oct 2023 13:21:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5AE2FA07CC; Tue,  3 Oct 2023 15:21:31 +0200 (CEST)
Date:   Tue, 3 Oct 2023 15:21:31 +0200
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
Subject: Re: [PATCH 5/8] shmem: shmem_acct_blocks() and
 shmem_inode_acct_blocks()
Message-ID: <20231003132131.j4mnrryyftbmzvtb@quack3>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
 <9124094-e4ab-8be7-ef80-9a87bdc2e4fc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9124094-e4ab-8be7-ef80-9a87bdc2e4fc@google.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 29-09-23 20:30:03, Hugh Dickins wrote:
> By historical accident, shmem_acct_block() and shmem_inode_acct_block()
> were never pluralized when the pages argument was added, despite their
> complements being shmem_unacct_blocks() and shmem_inode_unacct_blocks()
> all along.  It has been an irritation: fix their naming at last.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

OK. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/shmem.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index caee8ba841f7..63ba6037b23a 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -189,10 +189,10 @@ static inline int shmem_reacct_size(unsigned long flags,
>  /*
>   * ... whereas tmpfs objects are accounted incrementally as
>   * pages are allocated, in order to allow large sparse files.
> - * shmem_get_folio reports shmem_acct_block failure as -ENOSPC not -ENOMEM,
> + * shmem_get_folio reports shmem_acct_blocks failure as -ENOSPC not -ENOMEM,
>   * so that a failure on a sparse tmpfs mapping will give SIGBUS not OOM.
>   */
> -static inline int shmem_acct_block(unsigned long flags, long pages)
> +static inline int shmem_acct_blocks(unsigned long flags, long pages)
>  {
>  	if (!(flags & VM_NORESERVE))
>  		return 0;
> @@ -207,13 +207,13 @@ static inline void shmem_unacct_blocks(unsigned long flags, long pages)
>  		vm_unacct_memory(pages * VM_ACCT(PAGE_SIZE));
>  }
>  
> -static int shmem_inode_acct_block(struct inode *inode, long pages)
> +static int shmem_inode_acct_blocks(struct inode *inode, long pages)
>  {
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
>  	int err = -ENOSPC;
>  
> -	if (shmem_acct_block(info->flags, pages))
> +	if (shmem_acct_blocks(info->flags, pages))
>  		return err;
>  
>  	might_sleep();	/* when quotas */
> @@ -447,7 +447,7 @@ bool shmem_charge(struct inode *inode, long pages)
>  {
>  	struct address_space *mapping = inode->i_mapping;
>  
> -	if (shmem_inode_acct_block(inode, pages))
> +	if (shmem_inode_acct_blocks(inode, pages))
>  		return false;
>  
>  	/* nrpages adjustment first, then shmem_recalc_inode() when balanced */
> @@ -1671,7 +1671,7 @@ static struct folio *shmem_alloc_and_acct_folio(gfp_t gfp, struct inode *inode,
>  		huge = false;
>  	nr = huge ? HPAGE_PMD_NR : 1;
>  
> -	err = shmem_inode_acct_block(inode, nr);
> +	err = shmem_inode_acct_blocks(inode, nr);
>  	if (err)
>  		goto failed;
>  
> @@ -2572,7 +2572,7 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
>  	int ret;
>  	pgoff_t max_off;
>  
> -	if (shmem_inode_acct_block(inode, 1)) {
> +	if (shmem_inode_acct_blocks(inode, 1)) {
>  		/*
>  		 * We may have got a page, returned -ENOENT triggering a retry,
>  		 * and now we find ourselves with -ENOMEM. Release the page, to
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
