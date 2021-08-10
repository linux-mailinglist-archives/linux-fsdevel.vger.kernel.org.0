Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7E83E7CCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 17:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238772AbhHJPu7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 11:50:59 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47530 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbhHJPu6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:50:58 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B79A32208D;
        Tue, 10 Aug 2021 15:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628610635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lt2mvvE5qtXjRVl2z1RyaGVP0y2CrAVMypjTt2t1xQU=;
        b=Z2uOSY6AJDi756R00sHydJEfY33aSWidCHGhlFKdkarO+Iv7YSpqGn8vrTIEyMyD2tCNCK
        p1rcL9s8reVttfmVxou0xrjfbcCP8KdJZg91uJ27r4mHXmUPx73Pfvvxz+z9JoTL2i5pS3
        GOoMoniRtS5XOrEt9LgxA0dnqsXdLRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628610635;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lt2mvvE5qtXjRVl2z1RyaGVP0y2CrAVMypjTt2t1xQU=;
        b=NQrBIwOx7EygXQqYc2M0GaPceFukJqbk5nnzdAHcrPRZmReUOVCiokkqfwU2yhWXA8D19S
        TT4MuJ9fXycUh6Bw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 964E7137DA;
        Tue, 10 Aug 2021 15:50:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id RLC8I0ugEmFGSQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 10 Aug 2021 15:50:35 +0000
Subject: Re: [PATCH v14 001/138] mm: Convert get_page_unless_zero() to return
 bool
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-2-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7affb1ee-9029-6cdb-71e8-5e01d4a90ffc@suse.cz>
Date:   Tue, 10 Aug 2021 17:50:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-2-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:34 AM, Matthew Wilcox (Oracle) wrote:
> atomic_add_unless() returns bool, so remove the widening casts to int
> in page_ref_add_unless() and get_page_unless_zero().  This causes gcc
> to produce slightly larger code in isolate_migratepages_block(), but
> it's not clear that it's worse code.  Net +19 bytes of text.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/mm.h       | 2 +-
>  include/linux/page_ref.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7ca22e6e694a..8dd65290bac0 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -755,7 +755,7 @@ static inline int put_page_testzero(struct page *page)
>   * This can be called when MMU is off so it must not access
>   * any of the virtual mappings.
>   */
> -static inline int get_page_unless_zero(struct page *page)
> +static inline bool get_page_unless_zero(struct page *page)
>  {
>  	return page_ref_add_unless(page, 1, 0);
>  }
> diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
> index 7ad46f45df39..3a799de8ad52 100644
> --- a/include/linux/page_ref.h
> +++ b/include/linux/page_ref.h
> @@ -161,9 +161,9 @@ static inline int page_ref_dec_return(struct page *page)
>  	return ret;
>  }
>  
> -static inline int page_ref_add_unless(struct page *page, int nr, int u)
> +static inline bool page_ref_add_unless(struct page *page, int nr, int u)
>  {
> -	int ret = atomic_add_unless(&page->_refcount, nr, u);
> +	bool ret = atomic_add_unless(&page->_refcount, nr, u);
>  
>  	if (page_ref_tracepoint_active(page_ref_mod_unless))
>  		__page_ref_mod_unless(page, nr, ret);
> 

