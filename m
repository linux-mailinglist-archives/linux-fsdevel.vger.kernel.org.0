Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27A07B6692
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 12:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjJCKle (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 06:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjJCKlc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:41:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A19AC;
        Tue,  3 Oct 2023 03:41:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C224D2187B;
        Tue,  3 Oct 2023 10:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696329688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K8raBC//Ab6v8XITsid3ZkGvItK6gg3vzoyh8Xrtnc0=;
        b=2/Jz6rR7SN3g9A0yK1lGV26oQ6Fex7VVwhZWfCcyQ+tE8LjjaVAxo4C5zE0DLxeift5csG
        jmBZltxWKRsEcCuN72lq9jyctaj/sNAYuKylGB2E+uHfm5f/RTWyuXIQ6lBsxZNuNCG36v
        CRxPenr6q/q8rOQYvwHrvok9ynylPYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696329688;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K8raBC//Ab6v8XITsid3ZkGvItK6gg3vzoyh8Xrtnc0=;
        b=807BjxIXwDQqO2xSDz6NDM4E+gZQXefxh0y0p9CXzDcGXw3mCKVeEqHMUEVoPYgQizlggC
        1HhtwRSrbNr2hPCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B36B6132D4;
        Tue,  3 Oct 2023 10:41:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 79zKK9jvG2VwawAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 03 Oct 2023 10:41:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4C963A07CB; Tue,  3 Oct 2023 12:41:28 +0200 (CEST)
Date:   Tue, 3 Oct 2023 12:41:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH 01/10] highmem: Add folio_release_kmap()
Message-ID: <20231003104128.75bh4y4wmwsjvfwl@quack3>
References: <20230921200746.3303942-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921200746.3303942-1-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 21-09-23 21:07:38, Matthew Wilcox (Oracle) wrote:
> This is the folio equivalent of unmap_and_put_page(), which remains as
> a wrapper for it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I'm missing a patch 10/10 in this series (and a coverletter would be nice
as well)... What's there ;)?

								Honza

> ---
>  include/linux/highmem.h | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 99c474de800d..4cacc0e43b51 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -551,10 +551,24 @@ static inline void folio_zero_range(struct folio *folio,
>  	zero_user_segments(&folio->page, start, start + length, 0, 0);
>  }
>  
> -static inline void unmap_and_put_page(struct page *page, void *addr)
> +/**
> + * folio_release_kmap - Unmap a folio and drop a refcount.
> + * @folio: The folio to release.
> + * @addr: The address previously returned by a call to kmap_local_folio().
> + *
> + * It is common, eg in directory handling to kmap a folio.  This function
> + * unmaps the folio and drops the refcount that was being held to keep the
> + * folio alive while we accessed it.
> + */
> +static inline void folio_release_kmap(struct folio *folio, void *addr)
>  {
>  	kunmap_local(addr);
> -	put_page(page);
> +	folio_put(folio);
> +}
> +
> +static inline void unmap_and_put_page(struct page *page, void *addr)
> +{
> +	folio_release_kmap(page_folio(page), addr);
>  }
>  
>  #endif /* _LINUX_HIGHMEM_H */
> -- 
> 2.40.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
