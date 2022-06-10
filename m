Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B37D546BC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 19:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347115AbiFJRjn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 13:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350086AbiFJRjk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 13:39:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3815444A16
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 10:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654882776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J8z5Zt980Qbu7w4WytKw8QIuAeP80x+ID2G+tu0x/MM=;
        b=ffbUZp/OCqVfiRqIWjGX0m/PjYbc7Ium/vZGuF3KAd1Z/5TYzZz25yFCjGzBN+oWqRzzPr
        ABtTFcMf7tKBW5sxcAuN+2q8MoeNZKSVrUe3FbrMnHIZIZsgKpQCOtlkFVVJBwPYMdG5Jm
        ZXYSzmhzecMJyQwwHDm9Qjvl9gQYpR8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-zw12R2MDNa20VQqXLD6cww-1; Fri, 10 Jun 2022 13:39:35 -0400
X-MC-Unique: zw12R2MDNa20VQqXLD6cww-1
Received: by mail-wr1-f71.google.com with SMTP id v14-20020a5d610e000000b00213b51a0234so5713695wrt.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 10:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=J8z5Zt980Qbu7w4WytKw8QIuAeP80x+ID2G+tu0x/MM=;
        b=IcAnxurLGJLLR8meAd49bWW5IS+etZfxNKwoRIY05kJzgZaEkSiQKLnJjA0NeRATDv
         OC3TcacPN4J4LIbdt/7Yka7nkC5tzx1e3WfZFZNzchdtESXro4zG76DhDiMGTary8XVg
         AKZ86a+PJaQc15tROz8etq6cHyjZ3kEvnb8+ddMx9hqyjPld3tgH1wcuLdaygArB2a61
         IYLd7ZH5QgucUmCj9dTrMHTOOysjmqJ35N0VExoMAD4gL0pAkf6yxJksqY3ZLsCjtu/Y
         V0GxwfEmjzhwZMdIfpF1OWsNc+C8fsQgX3qwclPzFkKBmJtcN6Hqsi+ZtPS1io9K6Yde
         Ur3A==
X-Gm-Message-State: AOAM5306/XzF7lGIn6yr6oGZIlsFx+EiE3TqweqWNXXd3yIATbR1EqyB
        PoMfmADLR9NpJ6T2xV+bhu76BuDMGKN/bUpsE6+9LSQZQdsCc/u5DSIWnDlK7iONzXxY7HQIvr4
        9C1JAllKEznVumcAp0vv1gKaaNg==
X-Received: by 2002:a5d:40c7:0:b0:210:3135:e662 with SMTP id b7-20020a5d40c7000000b002103135e662mr44279391wrq.280.1654882774283;
        Fri, 10 Jun 2022 10:39:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxA4FremyZ3ut+fy1xQvwAFMxRGpPCjNehnAC2visnqTz3yALMvAKH9p08Lry8ai9np40pgtw==
X-Received: by 2002:a5d:40c7:0:b0:210:3135:e662 with SMTP id b7-20020a5d40c7000000b002103135e662mr44279379wrq.280.1654882774053;
        Fri, 10 Jun 2022 10:39:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:1f00:4727:6420:1d4d:ca23? (p200300cbc7051f00472764201d4dca23.dip0.t-ipconnect.de. [2003:cb:c705:1f00:4727:6420:1d4d:ca23])
        by smtp.gmail.com with ESMTPSA id j20-20020adfa554000000b002100316b126sm47617wrb.6.2022.06.10.10.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 10:39:33 -0700 (PDT)
Message-ID: <688dccfb-ec4e-7522-b5ef-18a46337df91@redhat.com>
Date:   Fri, 10 Jun 2022 19:39:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Freeing page flags
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <Yn10Iz1mJX1Mu1rv@casper.infradead.org>
 <Yosr35sTk3l9nBy1@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Yosr35sTk3l9nBy1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23.05.22 08:38, Mike Rapoport wrote:
> On Thu, May 12, 2022 at 09:54:59PM +0100, Matthew Wilcox wrote:
>> The LWN writeup [1] on merging the MGLRU reminded me that I need to send
>> out a plan for removing page flags that we can do without.
>>
>> 4. I think I can also consolidate PG_slab and PG_reserved into a "single
>> bit" (not really, but change the encoding so that effectively they only
>> take a single bit).
> 
> PG_reserved could be a PageType, AFAIR no reserved pages are ever mapped to
> userspace

include/linux/page-flags.h documents for PG_reserved:

"Pages part of the kernel image (including vDSO)"

Further, vm_normal_page() contains a comment

"NOTE! We still have PageReserved() pages in the page tables. eg. VDSO
mappings can cause them to exist."

-- 
Thanks,

David / dhildenb

