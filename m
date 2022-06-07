Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8B653F754
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 09:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237643AbiFGHga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 03:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiFGHg2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:36:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38ACD69B62
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 00:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654587386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=poSLf3SQpSQVqGAvfY9ZUAc4mDsdNw09sPQoA12+Xn0=;
        b=hfSm24hAkAxOtxAdK5RtalOFpv2znDhW0w8uprj18UcuDvaE1104doT8gg0EGQRE7IVVae
        Iv9ibPBqibKHQJSPOIOBqaEpuEYNNXoxMCplEm6QKG0vQjt/Q4MwCr3NAXeroafSH4Hism
        Hc6SSzDGX6eaNpnk8i7CZOns7zf1qCw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-ErILNDbvNr6rupVMh2Rmqw-1; Tue, 07 Jun 2022 03:36:25 -0400
X-MC-Unique: ErILNDbvNr6rupVMh2Rmqw-1
Received: by mail-wr1-f72.google.com with SMTP id v4-20020adfebc4000000b002102c69be5eso3571489wrn.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jun 2022 00:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=poSLf3SQpSQVqGAvfY9ZUAc4mDsdNw09sPQoA12+Xn0=;
        b=y+jRrKpdxQdNXSHSNHC0FDiKy7dlfvfRuorIf/YgTj7OrHyPeFAe9bf2jCWXgQRotS
         eiMJIA7Y5X3DFg2j5bUeq2F+MCxNuUTOqHLWTiojAEyRbZiLKmxZUvhQIvXx6tL3y9E/
         iJAH66NTB7yKKwb1ec72FA8tdti912ifxcUTgJkLomZXMxLLTdl/8OdjdSdIJASTAeX1
         tbQdwYeW/16otbXQl33LFh25STh18GM7p7oq3kEhoAMm8yOLB2gVrBY3AVaM6dGitJIO
         m06wEGYxnwDfNDmqn6/ZrhmRjvb4o3Imw9JlWal3Au4ejlzOrc2V4uRCnJcCUVRea4yx
         JaPA==
X-Gm-Message-State: AOAM531xecSZrujDT3ZObfrUZ2+MhpxQ8xKx4MXBuobd0ONrSVaIVJoV
        lomreFM/w7kMOtJNpktOfGWb1AinSjCkOPDmMmCtaTbKsip2csF0iqSm4UhPME0fwozezKKOL12
        qKreEi7euuQIDZO3v2zRL1OXWpQ==
X-Received: by 2002:a05:600c:4ec9:b0:397:750a:798a with SMTP id g9-20020a05600c4ec900b00397750a798amr56010319wmq.169.1654587384023;
        Tue, 07 Jun 2022 00:36:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/TT1zDaD6ih4ST/0Z6l6/VJexv/LUjWrit9gRiSM2S633qB8aLjqIdjv8Hs+falCUt0H+YA==
X-Received: by 2002:a05:600c:4ec9:b0:397:750a:798a with SMTP id g9-20020a05600c4ec900b00397750a798amr56010293wmq.169.1654587383789;
        Tue, 07 Jun 2022 00:36:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:500:4c8d:4886:f874:7b6f? (p200300cbc70905004c8d4886f8747b6f.dip0.t-ipconnect.de. [2003:cb:c709:500:4c8d:4886:f874:7b6f])
        by smtp.gmail.com with ESMTPSA id j37-20020a05600c1c2500b0039c235fb6a5sm19943141wms.8.2022.06.07.00.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 00:36:22 -0700 (PDT)
Message-ID: <e4d017a4-556d-bb5f-9830-a8843591bc8d@redhat.com>
Date:   Tue, 7 Jun 2022 09:36:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 15/20] balloon: Convert to migrate_folio
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org
References: <20220606204050.2625949-1-willy@infradead.org>
 <20220606204050.2625949-16-willy@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220606204050.2625949-16-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06.06.22 22:40, Matthew Wilcox (Oracle) wrote:
> This is little more than changing the types over; there's no real work
> being done in this function.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/balloon_compaction.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index 4b8eab4b3f45..3f75b876ad76 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -230,11 +230,10 @@ static void balloon_page_putback(struct page *page)
>  
>  
>  /* move_to_new_page() counterpart for a ballooned page */
> -static int balloon_page_migrate(struct address_space *mapping,
> -		struct page *newpage, struct page *page,
> -		enum migrate_mode mode)
> +static int balloon_migrate_folio(struct address_space *mapping,
> +		struct folio *dst, struct folio *src, enum migrate_mode mode)
>  {
> -	struct balloon_dev_info *balloon = balloon_page_device(page);
> +	struct balloon_dev_info *balloon = balloon_page_device(&src->page);
>  
>  	/*
>  	 * We can not easily support the no copy case here so ignore it as it
> @@ -244,14 +243,14 @@ static int balloon_page_migrate(struct address_space *mapping,
>  	if (mode == MIGRATE_SYNC_NO_COPY)
>  		return -EINVAL;
>  
> -	VM_BUG_ON_PAGE(!PageLocked(page), page);
> -	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
> +	VM_BUG_ON_FOLIO(!folio_test_locked(src), src);
> +	VM_BUG_ON_FOLIO(!folio_test_locked(dst), dst);
>  
> -	return balloon->migratepage(balloon, newpage, page, mode);
> +	return balloon->migratepage(balloon, &dst->page, &src->page, mode);
>  }
>  
>  const struct address_space_operations balloon_aops = {
> -	.migratepage = balloon_page_migrate,
> +	.migrate_folio = balloon_migrate_folio,
>  	.isolate_page = balloon_page_isolate,
>  	.putback_page = balloon_page_putback,
>  };

I assume you're working on conversion of the other callbacks as well,
because otherwise, this ends up looking a bit inconsistent and confusing :)

Change LGTM.

-- 
Thanks,

David / dhildenb

