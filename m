Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141E376D1FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 17:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbjHBPcP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 11:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbjHBPbz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8403F3AB8
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 08:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690990201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zpl8aOOTIJ9mlaQuYNUfJFxKv/U9O46R/LTmVpfLtOc=;
        b=Tszg2KFjFWc6p2eCoQprY1kaXZ/lBQ4PR9IZivXTXA60Z0TGeLYsgvEaExBxC8aCY7JtMy
        hDZsGVIee7yCXFDsjbWD/AzxM8FkH8/ERU06Iosh/BK4UUxwQRWIC8OGNRzwrUpfWZqXD+
        E/KqGpfcdLrvVpGoz0Xv+2T/WZYItfw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-IMrmtIKVOzuRyN0vlLQDbw-1; Wed, 02 Aug 2023 11:30:00 -0400
X-MC-Unique: IMrmtIKVOzuRyN0vlLQDbw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3175b757bbfso4237821f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Aug 2023 08:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690990199; x=1691594999;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zpl8aOOTIJ9mlaQuYNUfJFxKv/U9O46R/LTmVpfLtOc=;
        b=cAIsdEgX2HXQJOoACjVdWzOn2gEgevOGfhPF6Z0BceRQEsXKFGE7pRtQc9ezzXQM8M
         9+b/rqQSdX3WSecUCzbPJXLU9Ec1uIP1/o84lhKFOVR4M14C/K7Wmb3qM+eb83yx5hCp
         mgRXtVNykskVEMNu1Ym29WPXYY4aBpQHbBXNcS/846g//G6s1+hjpct2p8TrbQ+xDx7g
         0hRa1adxyHh4khhZSOG2PlrId4OdXTiZpHLYFKToDL8bgUNEAkjAtQp11pfaJWDIaeEB
         7NimYD4kzS3ueisV7XlNC0GFu6++KRTrQne5qsdQmnLfRWuTZzhSIjTS6zyI6hC+nUiL
         igxw==
X-Gm-Message-State: ABy/qLbtY/Qoej/NS5nHO6Q43wvh1CxPKRHQmSpM8JP+EEEOP7kUSfma
        Gf8i18neRpl+oa/+gkcDllBmtV7RIIUX9TOkknaD90WNlGN2RpRnRYo3O4e8bZCb0aXvrPxVxbJ
        gvRiR6vcybG+doCmscAS2ikutIQ==
X-Received: by 2002:adf:e68b:0:b0:314:824:3788 with SMTP id r11-20020adfe68b000000b0031408243788mr5186037wrm.27.1690990198976;
        Wed, 02 Aug 2023 08:29:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGPZ/gSkVfcDR0DyBgF0AO8vuUoscywmniaGjeRDFdrJLQLEfW8GrNw+nUwMNbFo2XQBknSkA==
X-Received: by 2002:adf:e68b:0:b0:314:824:3788 with SMTP id r11-20020adfe68b000000b0031408243788mr5186009wrm.27.1690990198551;
        Wed, 02 Aug 2023 08:29:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:e00:b8a4:8613:1529:1caf? (p200300cbc70b0e00b8a4861315291caf.dip0.t-ipconnect.de. [2003:cb:c70b:e00:b8a4:8613:1529:1caf])
        by smtp.gmail.com with ESMTPSA id o20-20020a5d58d4000000b0031762e89f94sm19173032wrf.117.2023.08.02.08.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 08:29:58 -0700 (PDT)
Message-ID: <cc408a90-9044-54cd-04a5-5977ffe8b24b@redhat.com>
Date:   Wed, 2 Aug 2023 17:29:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/8] kvm: explicitly set FOLL_HONOR_NUMA_FAULT in
 hva_to_pfn_slow()
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>, Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>, Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20230801124844.278698-1-david@redhat.com>
 <20230801124844.278698-4-david@redhat.com>
 <20230802152702.wamtroy3zm7nbtvs@techsingularity.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230802152702.wamtroy3zm7nbtvs@techsingularity.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02.08.23 17:27, Mel Gorman wrote:
> On Tue, Aug 01, 2023 at 02:48:39PM +0200, David Hildenbrand wrote:
>> KVM is *the* case we know that really wants to honor NUMA hinting falls.
>> As we want to stop setting FOLL_HONOR_NUMA_FAULT implicitly, set
>> FOLL_HONOR_NUMA_FAULT whenever we might obtain pages on behalf of a VCPU
>> to map them into a secondary MMU, and add a comment why.
>>
>> Do that unconditionally in hva_to_pfn_slow() when calling
>> get_user_pages_unlocked().
>>
>> kvmppc_book3s_instantiate_page(), hva_to_pfn_fast() and
>> gfn_to_page_many_atomic() are similarly used to map pages into a
>> secondary MMU. However, FOLL_WRITE and get_user_page_fast_only() always
>> implicitly honor NUMA hinting faults -- as documented for
>> FOLL_HONOR_NUMA_FAULT -- so we can limit this change to a single location
>> for now.
>>
>> Don't set it in check_user_page_hwpoison(), where we really only want to
>> check if the mapped page is HW-poisoned.
>>
>> We won't set it for other KVM users of get_user_pages()/pin_user_pages()
>> * arch/powerpc/kvm/book3s_64_mmu_hv.c: not used to map pages into a
>>    secondary MMU.
>> * arch/powerpc/kvm/e500_mmu.c: only used on shared TLB pages with userspace
>> * arch/s390/kvm/*: s390x only supports a single NUMA node either way
>> * arch/x86/kvm/svm/sev.c: not used to map pages into a secondary MMU.
>>
>> This is a preparation for making FOLL_HONOR_NUMA_FAULT no longer
>> implicitly be set by get_user_pages() and friends.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Seems sane but I don't know KVM well enough to know if this is the only
> relevant case so didn't ack.

Makes sense, some careful eyes from KVM people would be appreciated.

At least from kvm_main.c POV, I'm pretty confident that that's it.

-- 
Cheers,

David / dhildenb

