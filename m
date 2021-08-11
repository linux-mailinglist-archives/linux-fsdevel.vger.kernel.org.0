Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5013E93F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 16:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhHKOvB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 10:51:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41722 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbhHKOvA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:51:00 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 086131FED1;
        Wed, 11 Aug 2021 14:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628693436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YwtrtkUl9113t4lr7UC064OuObRR9nzlwURX6E47Ejk=;
        b=lvigIX8mFaSzgQuTDf0WzrdIDjb8Cmi4SKNrV6/WkKbalfeccyELkgcKHM2ZB9Uqrt7J5Z
        w83az5wJua6gMQlodw2DHWjn48na0c7F9iHd+bpSP0gK03V+5D6qClnVEIAtEGFLhA8bwc
        Nj3WbCS4zoDn+bdfCyo/FtW6IqmzRK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628693436;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YwtrtkUl9113t4lr7UC064OuObRR9nzlwURX6E47Ejk=;
        b=00aZUMGe8DAXnaS2BDapK+Mr+Eoi/fjwnUnCICeIbY1nJYfQxYL6MFYkzuuzpHiInaB0jj
        RiUDnj24eQG6sPBA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E931B136D9;
        Wed, 11 Aug 2021 14:50:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ULIfOLvjE2GcUQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 14:50:35 +0000
Subject: Re: [PATCH v14 058/138] mm/swap: Add folio_mark_accessed()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-59-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <114cd25f-8c75-9a7a-f46d-60c31685a055@suse.cz>
Date:   Wed, 11 Aug 2021 16:50:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-59-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> Convert mark_page_accessed() to folio_mark_accessed().  It already
> operated on the entire compound page, but now we can avoid calling
> compound_head quite so many times.  Shrinks the function from 424 bytes
> to 295 bytes (shrinking by 129 bytes).  The compatibility wrapper is 30
> bytes, plus the 8 bytes for the exported symbol means the kernel shrinks
> by 91 bytes.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Question below:

> @@ -430,36 +430,34 @@ static void __lru_cache_activate_page(struct page *page)
>   * When a newly allocated page is not yet visible, so safe for non-atomic ops,
>   * __SetPageReferenced(page) may be substituted for mark_page_accessed(page).
>   */

The other patches converting whole functions rewrote also comments to be about
folios, but not this one?

> -void mark_page_accessed(struct page *page)
> +void folio_mark_accessed(struct folio *folio)
>  {
> -	page = compound_head(page);
> -
> -	if (!PageReferenced(page)) {
> -		SetPageReferenced(page);
> -	} else if (PageUnevictable(page)) {
> +	if (!folio_test_referenced(folio)) {
> +		folio_set_referenced(folio);
> +	} else if (folio_test_unevictable(folio)) {
>  		/*
>  		 * Unevictable pages are on the "LRU_UNEVICTABLE" list. But,
>  		 * this list is never rotated or maintained, so marking an
>  		 * evictable page accessed has no effect.
>  		 */

These comments too?

> -	} else if (!PageActive(page)) {
> +	} else if (!folio_test_active(folio)) {
>  		/*
>  		 * If the page is on the LRU, queue it for activation via
>  		 * lru_pvecs.activate_page. Otherwise, assume the page is on a
>  		 * pagevec, mark it active and it'll be moved to the active
>  		 * LRU on the next drain.
>  		 */
> -		if (PageLRU(page))
> -			folio_activate(page_folio(page));
> +		if (folio_test_lru(folio))
> +			folio_activate(folio);
>  		else
> -			__lru_cache_activate_page(page);
> -		ClearPageReferenced(page);
> -		workingset_activation(page_folio(page));
> +			__lru_cache_activate_folio(folio);
> +		folio_clear_referenced(folio);
> +		workingset_activation(folio);
>  	}
> -	if (page_is_idle(page))
> -		clear_page_idle(page);
> +	if (folio_test_idle(folio))
> +		folio_clear_idle(folio);
>  }
> -EXPORT_SYMBOL(mark_page_accessed);
> +EXPORT_SYMBOL(folio_mark_accessed);
>  
>  /**
>   * lru_cache_add - add a page to a page list
> 

