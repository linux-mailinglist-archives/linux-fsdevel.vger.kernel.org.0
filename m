Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BA93EA892
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 18:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbhHLQbT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 12:31:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43754 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbhHLQbS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 12:31:18 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4CEE4212B7;
        Thu, 12 Aug 2021 16:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628785852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YxuPaNjfhrjo4LhBp5zhOFW0FadYhKOG2QHOBoJTqeo=;
        b=BYDnA+nRAAPMRth0t5EufVhWK4BTEIYdre8edDOViAOk/T8vMEGzSZOyBrtRSs7O1Qa+zq
        lAnV+2Pidt+7q62qUByxWe1wS3eUMaJwgnhp2CXtUxPvPse21ylgPpu6W6K4/cUMq0Xr6E
        DTHyHpoVmkOQBmqh0eBNkU8IRn5h/TM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628785852;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YxuPaNjfhrjo4LhBp5zhOFW0FadYhKOG2QHOBoJTqeo=;
        b=PzucL5xuMX7VMoQHJ0R8xzjg/thLXnzNg/IUL8aMJfdpdMdB/CeZqD+7VEZJmpCZyTJSHj
        KTEx2y9cJ0Z0d6Dw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 36C3613ACC;
        Thu, 12 Aug 2021 16:30:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ZyKbDLxMFWFDAwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 16:30:52 +0000
Subject: Re: [PATCH v14 076/138] mm/writeback: Add
 folio_redirty_for_writepage()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-77-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <249863ea-8b4b-df38-545a-5f083502270d@suse.cz>
Date:   Thu, 12 Aug 2021 18:30:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-77-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:36 AM, Matthew Wilcox (Oracle) wrote:
> Reimplement redirty_page_for_writepage() as a wrapper around
> folio_redirty_for_writepage().  Account the number of pages in the
> folio, add kernel-doc and move the prototype to writeback.h.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Nit:

> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2558,21 +2558,31 @@ void folio_account_redirty(struct folio *folio)
>  }
>  EXPORT_SYMBOL(folio_account_redirty);
>  
> -/*
> - * When a writepage implementation decides that it doesn't want to write this
> - * page for some reason, it should redirty the locked page via
> - * redirty_page_for_writepage() and it should then unlock the page and return 0
> +/**
> + * folio_redirty_for_writepage - Decline to write a dirty folio.
> + * @wbc: The writeback control.
> + * @folio: The folio.
> + *
> + * When a writepage implementation decides that it doesn't want to write
> + * @folio for some reason, it should call this function, unlock @folio and
> + * return 0.

s/0/false

> + *
> + * Return: True if we redirtied the folio.  False if someone else dirtied
> + * it first.
>   */
> -int redirty_page_for_writepage(struct writeback_control *wbc, struct page *page)
> +bool folio_redirty_for_writepage(struct writeback_control *wbc,
> +		struct folio *folio)
>  {
> -	int ret;
> +	bool ret;
> +	unsigned nr = folio_nr_pages(folio);
> +
> +	wbc->pages_skipped += nr;
> +	ret = filemap_dirty_folio(folio->mapping, folio);
> +	folio_account_redirty(folio);
>  
> -	wbc->pages_skipped++;
> -	ret = __set_page_dirty_nobuffers(page);
> -	account_page_redirty(page);
>  	return ret;
>  }
> -EXPORT_SYMBOL(redirty_page_for_writepage);
> +EXPORT_SYMBOL(folio_redirty_for_writepage);
>  
>  /**
>   * folio_mark_dirty - Mark a folio as being modified.
> 

