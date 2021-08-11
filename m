Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5C83E945D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 17:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbhHKPQx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 11:16:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44318 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbhHKPOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 11:14:40 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 371191FED6;
        Wed, 11 Aug 2021 15:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628694843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t+eHGdoT5jzm2HSlG+BIy5L9hl1UwoXahRV2J4sxtj4=;
        b=LwH5/6Bzv7OxzEM3iByhsLJsOXF9F+yTMpFahzxeaoO8JqtDs+K504kKpD1nNjUAzUTA5D
        A3jbAnAMOtKXNQOzZUTGC0tX5CojSuzYWgARK5gi5bBxnAqhRgzQzNCSuODynaDBACBFA6
        5aLF/EQ40ElxVzuAutllYfJZA/YjB1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628694843;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t+eHGdoT5jzm2HSlG+BIy5L9hl1UwoXahRV2J4sxtj4=;
        b=faDBDoocMSbbQKGWq4QPvSps0bem5q9vJkmrRO2A+WD4W6Ecm89AeYgtEyzDDQFKm5KN/g
        tSotztGPZxjTbfAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id EBDA2136D9;
        Wed, 11 Aug 2021 15:14:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id GgJhNjrpE2F6VwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 15:14:02 +0000
Subject: Re: [PATCH v14 061/138] mm/migrate: Add folio_migrate_flags()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-62-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <601db7e4-eb11-d235-8362-79e204d284d8@suse.cz>
Date:   Wed, 11 Aug 2021 17:14:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-62-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> Turn migrate_page_states() into a wrapper around folio_migrate_flags().
> Also convert two functions only called from folio_migrate_flags() to
> be folio-based.  ksm_migrate_page() becomes folio_migrate_ksm() and
> copy_page_owner() becomes folio_copy_owner().  folio_migrate_flags()
> alone shrinks by two thirds -- 1967 bytes down to 642 bytes.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

After fixing the bug below,
Acked-by: Vlastimil Babka <vbabka@suse.cz>


> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h

...

> @@ -36,10 +36,10 @@ static inline void split_page_owner(struct page *page, unsigned int nr)
>  	if (static_branch_unlikely(&page_owner_inited))
>  		__split_page_owner(page, nr);
>  }
> -static inline void copy_page_owner(struct page *oldpage, struct page *newpage)
> +static inline void folio_copy_owner(struct folio *newfolio, struct folio *old)

This changed order so that new is first.

...

> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -538,82 +538,80 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
>  }
>  
>  /*
> - * Copy the page to its new location
> + * Copy the flags and some other ancillary information
>   */
> -void migrate_page_states(struct page *newpage, struct page *page)
> +void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
>  {

...

> -	copy_page_owner(page, newpage);
> +	folio_copy_owner(folio, newfolio);

This passes old first.

>  
> -	if (!PageHuge(page))
> +	if (!folio_test_hugetlb(folio))
>  		mem_cgroup_migrate(folio, newfolio);
>  }
> -EXPORT_SYMBOL(migrate_page_states);
> +EXPORT_SYMBOL(folio_migrate_flags);
