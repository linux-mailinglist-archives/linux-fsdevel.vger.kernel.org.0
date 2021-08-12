Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8178F3EA857
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 18:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhHLQP7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 12:15:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52032 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbhHLQOy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 12:14:54 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 298E31FF61;
        Thu, 12 Aug 2021 16:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628784863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DbKpH3fObpqF4YoutZpZCXlOx6vnUfgj3EGpl5lhHJE=;
        b=gVnMmlBdln6b8Pzg9FVVu3DYRCvmcSfTU/lSasolqjxbCkTUI+A3KL+cUADf+mt627WClb
        pNX7SmxGBTv0UuUsujpISDFK95JtJDoaqVIN+Z5c5dK+babdebAZYLU4HgNRfBff6i8nmw
        jPoXY43K2bQtbN22stNjfPd2F33K3+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628784863;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DbKpH3fObpqF4YoutZpZCXlOx6vnUfgj3EGpl5lhHJE=;
        b=YkfeMqGbvDhNvt+a691HrPiuV6yKoiZ0Zr2H/FN/8BXXr1NQxSHJcsPMp3hNzmmpKiv5Ql
        +2iaVZqrJsZELjDQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 13F3B13ACC;
        Thu, 12 Aug 2021 16:14:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id yCE/BN9IFWEpfgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 16:14:23 +0000
Subject: Re: [PATCH v14 072/138] mm/writeback: Add folio_account_cleaned()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-73-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ea89a40c-68b3-c54d-8e7f-3c09757ddd8d@suse.cz>
Date:   Thu, 12 Aug 2021 18:14:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-73-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> Get the statistics right; compound pages were being accounted as a
> single page.  This didn't matter before now as no filesystem which
> supported compound pages did writeback.  Also move the declaration
> to filemap.h since this is part of the page cache.  Add a wrapper for

Seems to be pagemap.h :)

> account_page_cleaned().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Nit below:
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index bd97c461d499..792a83bd3917 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2453,14 +2453,15 @@ static void folio_account_dirtied(struct folio *folio,
>   *
>   * Caller must hold lock_page_memcg().
>   */
> -void account_page_cleaned(struct page *page, struct address_space *mapping,
> +void folio_account_cleaned(struct folio *folio, struct address_space *mapping,
>  			  struct bdi_writeback *wb)
>  {
>  	if (mapping_can_writeback(mapping)) {
> -		dec_lruvec_page_state(page, NR_FILE_DIRTY);
> -		dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
> -		dec_wb_stat(wb, WB_RECLAIMABLE);
> -		task_io_account_cancelled_write(PAGE_SIZE);
> +		long nr = folio_nr_pages(folio);
> +		lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, -nr);
> +		zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
> +		wb_stat_mod(wb, WB_RECLAIMABLE, -nr);
> +		task_io_account_cancelled_write(folio_size(folio));

In "mm/writeback: Add __folio_mark_dirty()" you used nr*PAGE_SIZE. Consistency?

>  	}
>  }
>  
> 

