Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFF33EA927
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 19:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbhHLRJC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 13:09:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59354 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhHLRJA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:09:00 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 131041FF6F;
        Thu, 12 Aug 2021 17:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628788114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3m98n/atZZydB46tkb5RF23lygdqB+tHcuz/yS7Dyn4=;
        b=tH4eMfgThZb3Oeond2/3Dl5kybFKzRfLx0ZiXplbN5clkp5hTxN72/GrsJ7P89DXXG6OpK
        VDShpH7TkoW0JKpAtH1ZQOSsUcpBMlMuU+qlURPp4JgpyXdieIeNhuJM1ibdsIonniTC3U
        oh7eE20Bi0AJJqgr2syISqryokbctOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628788114;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3m98n/atZZydB46tkb5RF23lygdqB+tHcuz/yS7Dyn4=;
        b=HkyGQI7/Dlqms8w/mAWmpDGCvvDkbVddIHrHHo17n6KRfnrPT+VVV7vC1+Zfsbcc8ySOkL
        /DOHDin+jQE7KBAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E301713AC3;
        Thu, 12 Aug 2021 17:08:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id uoZDNpFVFWGqCwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 17:08:33 +0000
Subject: Re: [PATCH v14 078/138] mm/filemap: Add
 folio_mkwrite_check_truncate()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-79-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <658f52db-47a1-606d-f19a-a666f5817ad9@suse.cz>
Date:   Thu, 12 Aug 2021 19:08:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-79-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:36 AM, Matthew Wilcox (Oracle) wrote:
> This is the folio equivalent of page_mkwrite_check_truncate().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/pagemap.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 412db88b8d0c..18c06c3e42c3 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -1121,6 +1121,34 @@ static inline unsigned long dir_pages(struct inode *inode)
>  			       PAGE_SHIFT;
>  }
>  
> +/**
> + * folio_mkwrite_check_truncate - check if folio was truncated
> + * @folio: the folio to check
> + * @inode: the inode to check the folio against
> + *
> + * Return: the number of bytes in the folio up to EOF,
> + * or -EFAULT if the folio was truncated.
> + */
> +static inline ssize_t folio_mkwrite_check_truncate(struct folio *folio,
> +					      struct inode *inode)
> +{
> +	loff_t size = i_size_read(inode);
> +	pgoff_t index = size >> PAGE_SHIFT;
> +	size_t offset = offset_in_folio(folio, size);
> +
> +	if (!folio->mapping)

The check in the page_ version is
if (page->mapping != inode->i_mapping)

Why is the one above sufficient?

> +		return -EFAULT;
> +
> +	/* folio is wholly inside EOF */
> +	if (folio_next_index(folio) - 1 < index)
> +		return folio_size(folio);
> +	/* folio is wholly past EOF */
> +	if (folio->index > index || !offset)
> +		return -EFAULT;
> +	/* folio is partially inside EOF */
> +	return offset;
> +}
> +
>  /**
>   * page_mkwrite_check_truncate - check if page was truncated
>   * @page: the page to check
> 

