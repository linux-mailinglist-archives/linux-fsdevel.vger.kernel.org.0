Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3794A65EA95
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 13:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjAEMTq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Jan 2023 07:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjAEMT3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:19:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB44B59D3F
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jan 2023 04:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672921122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UpuMYEsePXzx9kv6GFcWl6NcxTKfD6zAAzJE3ZeIEQU=;
        b=K0YLJJupxBrAqJROa62g98AZ8E5BQjNnsQe/FAUCltcibStAtuWKlBhObPdn3rwN4gx0+w
        R70lH5UZoIS/5Pev30WK6rP5KkY3p0u7stvWdlwxU7o/gISZfrtsMv9p0i9bAQ9plQjvEO
        XlGOLJcibwkNCaxjn7OJd/r7t8dTySA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-115-N1dZEArnOsOKllsCbYDNDQ-1; Thu, 05 Jan 2023 07:18:41 -0500
X-MC-Unique: N1dZEArnOsOKllsCbYDNDQ-1
Received: by mail-wr1-f69.google.com with SMTP id e3-20020adfa443000000b00296b280432dso2088152wra.19
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jan 2023 04:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpuMYEsePXzx9kv6GFcWl6NcxTKfD6zAAzJE3ZeIEQU=;
        b=mB2v3jd3doVUGLkefXhDzIpiCIglK5BftcMaf7AYlQHHi2eCIo1TqKCJ4fCHa54nBr
         QC1zPRX+6FGfkP/Pj5QZTpgTjEt0G0LkxTBve0ZRI5sFnoEvElSF/kHszc5wIDZ4Vp/G
         8hEdahWXoT6p8wjon+CRWvp5WvN53YMtEagoiWfG+Ds2T6+MPYLwWPV2O6K6NodGK4bY
         UNM+x+hkqhiA5X3sEaL06RFkFH97GEHHUPbu211uvND27SV/ApK0Rjkc1+hDNC2CI4sz
         nP+3rf9awcXQprUapQsCnMXxXRLRhT5GFE+TzCf+MegSfsrV8DR2XSLooJJTzjWCZ9NE
         ufBQ==
X-Gm-Message-State: AFqh2kp7IM5jKgtmbwFbSkeEdzSlcjxJ5IGg4yjv67KqO7UJjbfvhyQ2
        SDAM+w7KcYWWHZmLC4vP0vuFVQ3jjvL4mPBhnzOne4wB7DvkW64NY2RQE0F/snc1sEas6cdthlz
        K0ct7cAetE2WIqomcmvP8idXAAg==
X-Received: by 2002:adf:e19d:0:b0:28f:29b3:1a7f with SMTP id az29-20020adfe19d000000b0028f29b31a7fmr15595031wrb.36.1672921120491;
        Thu, 05 Jan 2023 04:18:40 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvq09fSoIEeG5qGPLrKcrVN6jrNUhwHquWZJZyMNzUSQSucWjIritMW8MPP8tUoPSh+7mQ1vw==
X-Received: by 2002:adf:e19d:0:b0:28f:29b3:1a7f with SMTP id az29-20020adfe19d000000b0028f29b31a7fmr15595018wrb.36.1672921120215;
        Thu, 05 Jan 2023 04:18:40 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e? (p200300cbc7076e00ff02ec7aded5ec1e.dip0.t-ipconnect.de. [2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e])
        by smtp.gmail.com with ESMTPSA id d14-20020adfa40e000000b0029d9ed7e707sm8462775wra.44.2023.01.05.04.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 04:18:39 -0800 (PST)
Message-ID: <02312607-e399-b859-ffc8-ea65a560fe3f@redhat.com>
Date:   Thu, 5 Jan 2023 13:18:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/1] mm: fix vma->anon_name memory leak for anonymous
 shmem VMAs
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     hughd@google.com, hannes@cmpxchg.org, vincent.whitchurch@axis.com,
        seanjc@google.com, rppt@kernel.org, shy828301@gmail.com,
        pasha.tatashin@soleen.com, paul.gortmaker@windriver.com,
        peterx@redhat.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
        ccross@google.com, willy@infradead.org, arnd@arndb.de,
        cgel.zte@gmail.com, yuzhao@google.com, bagasdotme@gmail.com,
        suleiman@google.com, steven@liquorix.net, heftig@archlinux.org,
        cuigaosheng1@huawei.com, kirill@shutemov.name,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
References: <20230105000241.1450843-1-surenb@google.com>
 <20230104173855.48e8734a25c08d7d7587d508@linux-foundation.org>
 <CAJuCfpGHMeWSSp+ge3pPppLrQ5BpGiga=fjKmDk65GTjFDV=3w@mail.gmail.com>
 <ed9dc172-e519-3fd5-afa4-0089b083ee10@redhat.com>
 <22aab888-75c1-ffad-d72b-f87c9d9d80c8@applied-asynchrony.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <22aab888-75c1-ffad-d72b-f87c9d9d80c8@applied-asynchrony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05.01.23 13:07, Holger Hoffstätte wrote:
> On 2023-01-05 10:03, David Hildenbrand wrote:
>> On 05.01.23 03:39, Suren Baghdasaryan wrote:
>>> On Wed, Jan 4, 2023 at 5:38 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>>>
>>>> On Wed,  4 Jan 2023 16:02:40 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
>>>>
>>>>> free_anon_vma_name() is missing a check for anonymous shmem VMA which
>>>>> leads to a memory leak due to refcount not being dropped.  Fix this by
>>>>> calling anon_vma_name_put() unconditionally. It will free vma->anon_name
>>>>> whenever it's non-NULL.
>>>>>
>>>>> Fixes: d09e8ca6cb93 ("mm: anonymous shared memory naming")
>>>>
>>>> A cc:stable is appropriate here, yes?
>>>
>>> Hmm. The patch we are fixing here was merged in 6.2-rc1. Should I CC
>>> stable to fix the previous -rc branch?
>>>
>>
>> No need for stable if it's not in a release kernel yet.
> 
> Commit d09e8ca6cb93 is in 6.1. The fix applies cleanly.

$ git tag --contains d09e8ca6cb93 | grep "^v"
v6.2-rc1
v6.2-rc2

Doesn't look like 6.1 to me.

-- 
Thanks,

David / dhildenb

