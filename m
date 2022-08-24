Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DF159F4CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 10:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbiHXIKo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 04:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbiHXIKn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:10:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849A784EF2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Aug 2022 01:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661328641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FkqRyVmVnH2p/hv4jFAhKRZhXQQdh+BaDqLkaLzGuMI=;
        b=VIMDWym97Amc5j9oWyLt0sVrTpOLLja5ePZzFfYgFs7MPiiMsg2/0qMXywt9SQNN27u+hr
        8NR7FtotBwTIfu8CP1nEjwETCMfyuyaq7mbvc3C1K6//zDBdHy8S7TTRIpBtD2UghlTNyx
        CwcfRHVExovsPs4tifB2jUFY522pRFw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-594-tHMbcQobM_GFwj0yaSDMPg-1; Wed, 24 Aug 2022 04:10:40 -0400
X-MC-Unique: tHMbcQobM_GFwj0yaSDMPg-1
Received: by mail-wr1-f70.google.com with SMTP id v19-20020adf8b53000000b00225728573e6so96541wra.21
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Aug 2022 01:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=FkqRyVmVnH2p/hv4jFAhKRZhXQQdh+BaDqLkaLzGuMI=;
        b=UNAeq08Jj8K59ewQMoLfYVxBp9n/FKvumdprUj6hMa8XEdJn97AwAJs0CVztXl/9H8
         tKuiVq7xUALnjQURrHs3iVGnP0OK3F//pcZpL6GcdpPE6r+zEKpYWcj096840yRYGYws
         36Wr/ofyJ0ELHP8g3ImrWIn+bmkEn2GlxB4io1yXZUoElmqJgtuAAYrKoZ/SKJQNPyYE
         VlG3YN0b1F9eKDQQW5957VV332JA9KsknevuTBr0Xrv2DozTB6wc31yQPBe6cBqZytFN
         ojAF1BQSHCmOuUCfPRoNVguxnaZwTHw/RFw5Y9rXXEgVzOmOa0yXb0ZTnXgRCG/re2V0
         feQQ==
X-Gm-Message-State: ACgBeo0m+DyxU/ksTUj8uQ/oGE35hA/SURCJsYjlD9Rejo5IkRIN0iTE
        OKkWrt3rbGWpX7ZimOVo7gmD+8a1uHlKkZJyUOnskp9AitRJZCzHMbDhZa1qdHOhjoVmHwjnFen
        313BoPxq62WBZGjo52XcuNZoJiw==
X-Received: by 2002:a5d:5487:0:b0:225:3fa7:41c2 with SMTP id h7-20020a5d5487000000b002253fa741c2mr11668190wrv.195.1661328639300;
        Wed, 24 Aug 2022 01:10:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7oWpPdTD3abka/IUBi2UFio+jqKRoZcRc1o7eyZSl+PEi58PEdaVPrSmiTzEqsevHnndBcoQ==
X-Received: by 2002:a5d:5487:0:b0:225:3fa7:41c2 with SMTP id h7-20020a5d5487000000b002253fa741c2mr11668178wrv.195.1661328639030;
        Wed, 24 Aug 2022 01:10:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:c500:5445:cf40:2e32:6e73? (p200300cbc707c5005445cf402e326e73.dip0.t-ipconnect.de. [2003:cb:c707:c500:5445:cf40:2e32:6e73])
        by smtp.gmail.com with ESMTPSA id m9-20020adfe0c9000000b00225206dd595sm16017732wri.86.2022.08.24.01.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 01:10:38 -0700 (PDT)
Message-ID: <96433a14-1d2c-739d-95fb-3e3339200dcf@redhat.com>
Date:   Wed, 24 Aug 2022 10:10:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/2] mm: Cap zone movable's min wmark to small value
Content-Language: en-US
To:     Wupeng Ma <mawupeng1@huawei.com>, akpm@linux-foundation.org
Cc:     corbet@lwn.net, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, osalvador@suse.de, rppt@kernel.org,
        surenb@google.com, jsavitz@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, wangkefeng.wang@huawei.com
References: <20220819093025.105403-1-mawupeng1@huawei.com>
 <20220819093025.105403-2-mawupeng1@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220819093025.105403-2-mawupeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19.08.22 11:30, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> Since min_free_kbytes is based on gfp_zone(GFP_USER) which does not include
> zone movable. However zone movable will get its min share in
> __setup_per_zone_wmarks() which does not make any sense.
> 
> And like highmem pages, __GFP_HIGH and PF_MEMALLOC allocations usually
> don't need movable pages, so there is no need to assign min pages for zone
> movable.
> 
> Let's cap pages_min for zone movable to a small value here just link
> highmem pages.
> 
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> ---
>  mm/page_alloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e5486d47406e..ff644205370f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8638,7 +8638,7 @@ static void __setup_per_zone_wmarks(void)
>  
>  	/* Calculate total number of !ZONE_HIGHMEM pages */
>  	for_each_zone(zone) {
> -		if (!is_highmem(zone))
> +		if (!is_highmem(zone) && zone_idx(zone) != ZONE_MOVABLE)
>  			lowmem_pages += zone_managed_pages(zone);
>  	}
>  
> @@ -8648,7 +8648,7 @@ static void __setup_per_zone_wmarks(void)
>  		spin_lock_irqsave(&zone->lock, flags);
>  		tmp = (u64)pages_min * zone_managed_pages(zone);
>  		do_div(tmp, lowmem_pages);
> -		if (is_highmem(zone)) {
> +		if (is_highmem(zone) || zone_idx(zone) == ZONE_MOVABLE) {
>  			/*
>  			 * __GFP_HIGH and PF_MEMALLOC allocations usually don't
>  			 * need highmem pages, so cap pages_min to a small

This kind-off makes sense to me, but I'm not completely sure about all
implications. We most certainly should update the comment as well.

-- 
Thanks,

David / dhildenb

