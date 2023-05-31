Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B491671785A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 09:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbjEaHfa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 03:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjEaHfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 03:35:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0EB1A1
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 00:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685518461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZMG4vUmpGMZQcynLYMZszKgD6M1TLYmEBHSlh9g4e6w=;
        b=TLxBBEJUfs7mI3wVCY/yNHUQ+F9/a+hAEsWUC6ReKxc5oJn/fZIPmcN8z+9jz7B3RHi8VG
        4njanAZDVOQYgjwevwOsgObw/s9ynpyiIdbB4f0Lhkv01eYv0CcEhfbT0nh+b64D6xg+cX
        XiHaCXu2nMszQ9MUDuR9W3CyDs8KAyI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-PKeI_LZXP5uyBEsZDhLX2Q-1; Wed, 31 May 2023 03:34:20 -0400
X-MC-Unique: PKeI_LZXP5uyBEsZDhLX2Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30b590d5931so297890f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 00:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685518459; x=1688110459;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMG4vUmpGMZQcynLYMZszKgD6M1TLYmEBHSlh9g4e6w=;
        b=G/bDlVm1C9nSXH4O5he1lFYIrJE8RAZrSYDerZYajwVf7njCYc5azVz7TV+LNkap9K
         q8rKdOGSR7EIeWnHL271jLq75lnniuW+NdibUcfQwHCRJsy616Etz8Gx4wddq8eQwIzX
         H85DdxsG9NwsX2Qrog2urXNO/GrW7jy5XOLOW6HwMQVrdMzWP0gYF+hxJt0VGqaB4F9o
         SJJERgkicN/5xOa6z0OYCynn1GdIvY3Gy/uZTMtEJR6H0lqtFNMxUMCFgQqRZ4pNrvyg
         37NxoM3K0/lrviXQX/J2Lph0/fcUrT6O9cuQ1IE2oMrtIR5h8dNFdASDYhfkTfArjSGn
         eAAw==
X-Gm-Message-State: AC+VfDy8BHFSPcesCsjGkUr5tBW1cj36Do70tSiXp3wirAUcz2kx7J9C
        UEmlsDdDIbgkXmejXw/XKIQc/M33kB/loOpLn+cij4ZoHZilNIH7Rum/hHEX+tuM1FBP/e/Vr6H
        7P+CNybg2RD+0esZiA6UUCQsfy0b0iIqi8w==
X-Received: by 2002:a5d:644f:0:b0:306:4239:4cd with SMTP id d15-20020a5d644f000000b00306423904cdmr3377850wrw.31.1685518458877;
        Wed, 31 May 2023 00:34:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6eJ595pUOfxsxQ4hon0QFaAasTBo5N69tj71Iql1/xOKcxhfwzMWOl33hDEBmacxD6kBOTIA==
X-Received: by 2002:a5d:644f:0:b0:306:4239:4cd with SMTP id d15-20020a5d644f000000b00306423904cdmr3377817wrw.31.1685518458465;
        Wed, 31 May 2023 00:34:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c749:cb00:fc9f:d303:d4cc:9f26? (p200300cbc749cb00fc9fd303d4cc9f26.dip0.t-ipconnect.de. [2003:cb:c749:cb00:fc9f:d303:d4cc:9f26])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d5272000000b002fb60c7995esm5713370wrc.8.2023.05.31.00.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 00:34:18 -0700 (PDT)
Message-ID: <cbd39f94-407a-03b6-9c43-8144d0efc8bb@redhat.com>
Date:   Wed, 31 May 2023 09:34:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230526214142.958751-1-dhowells@redhat.com>
 <20230526214142.958751-2-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 1/3] mm: Don't pin ZERO_PAGE in pin_user_pages()
In-Reply-To: <20230526214142.958751-2-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26.05.23 23:41, David Howells wrote:
> Make pin_user_pages*() leave a ZERO_PAGE unpinned if it extracts a pointer
> to it from the page tables and make unpin_user_page*() correspondingly
> ignore a ZERO_PAGE when unpinning.  We don't want to risk overrunning a
> zero page's refcount as we're only allowed ~2 million pins on it -
> something that userspace can conceivably trigger.

2 millions pins (FOLL_PIN, which increments the refcount by 1024) or 2 
million references ?

> 
> Add a pair of functions to test whether a page or a folio is a ZERO_PAGE.
> 

[...]

> diff --git a/mm/gup.c b/mm/gup.c
> index bbe416236593..ad28261dcafd 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -51,7 +51,8 @@ static inline void sanity_check_pinned_pages(struct page **pages,
>   		struct page *page = *pages;
>   		struct folio *folio = page_folio(page);
>   
> -		if (!folio_test_anon(folio))
> +		if (is_zero_page(page) ||
> +		    !folio_test_anon(folio))

Nit: Fits into a single line (without harming readability IMHO).

>   			continue;
>   		if (!folio_test_large(folio) || folio_test_hugetlb(folio))
>   			VM_BUG_ON_PAGE(!PageAnonExclusive(&folio->page), page);
> @@ -131,6 +132,13 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
>   	else if (flags & FOLL_PIN) {
>   		struct folio *folio;
>   
> +		/*
> +		 * Don't take a pin on the zero page - it's not going anywhere
> +		 * and it is used in a *lot* of places.
> +		 */
> +		if (is_zero_page(page))
> +			return page_folio(page);
> +
>   		/*
>   		 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
>   		 * right zone, so fail and let the caller fall back to the slow
> @@ -180,6 +188,8 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
>   static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
>   {
>   	if (flags & FOLL_PIN) {
> +		if (is_zero_folio(folio))
> +			return;
>   		node_stat_mod_folio(folio, NR_FOLL_PIN_RELEASED, refs);
>   		if (folio_test_large(folio))
>   			atomic_sub(refs, &folio->_pincount);
> @@ -224,6 +234,13 @@ int __must_check try_grab_page(struct page *page, unsigned int flags)
>   	if (flags & FOLL_GET)
>   		folio_ref_inc(folio);
>   	else if (flags & FOLL_PIN) {
> +		/*
> +		 * Don't take a pin on the zero page - it's not going anywhere
> +		 * and it is used in a *lot* of places.
> +		 */
> +		if (is_zero_page(page))
> +			return 0;
> +
>   		/*
>   		 * Similar to try_grab_folio(): be sure to *also*
>   		 * increment the normal page refcount field at least once,
> @@ -3079,6 +3096,9 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
>    *
>    * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
>    * see Documentation/core-api/pin_user_pages.rst for further details.
> + *
> + * Note that if a zero_page is amongst the returned pages, it will not have
> + * pins in it and unpin_user_page() will not remove pins from it.
>    */

"it will not have pins in it" sounds fairly weird to a non-native speaker.

"Note that the refcount of any zero_pages returned among the pinned 
pages will not be incremented, and unpin_user_page() will similarly not 
decrement it."


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

