Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CED765D8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 22:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjG0UoV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 16:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjG0UoS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4001271D
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 13:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690490611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lfWu2ZSOpTuxqffZRsnr4zvcADBC5ezgXzbU6lFturo=;
        b=Nqrxo9OYCUYEnYxm97rdc6HxbuEtMg7nff3j7U2SuJnwCgMYyKdNeEfyVbg6904B1O4IKY
        OUr9ws9dkhv1PkrHOJNMKBa4WGfaY4sqVYdkF56RXoqTq8jQ9Tj08k0ctU3cn2IPBZF7Ni
        NTIUMnjqUKM1npErAEkje1zIaZmZE5Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-VKWL0M-sOQif3wylyYCwiw-1; Thu, 27 Jul 2023 16:43:30 -0400
X-MC-Unique: VKWL0M-sOQif3wylyYCwiw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fbdf341934so7402075e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 13:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690490609; x=1691095409;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfWu2ZSOpTuxqffZRsnr4zvcADBC5ezgXzbU6lFturo=;
        b=gog3jT8aegYAHZOpHam6DhDKN57APkqKvwgSfFFwyHaekIaXh7kNF7TWUVnMfmuBzS
         vtkszNZwctICf/9FetcFvZpKDCCUQtifCWhLzPTiu/ITGXim75tZvi4MoC92/SilZrjR
         wtDMqVr7SrJMlI+8D/H4QDZsl9Jsg3U4qbeHMq7P53MDpgR8ZIN2paVIEyjgWJeTl5gu
         jtE+T6IPuwg6r1ZSk4W5RuuKjEhdyfkwWO15JrPLAl5fiUDk7Ri4zfEl3OhkGbcaHLyB
         e4R7KXz7cz3TI9PH5/80z+rMbCO7AVt6/MBsCpWiotcuoilZc9hnoRWquOCTj/7ea8k8
         qiSQ==
X-Gm-Message-State: ABy/qLaEvrHkJv7yYwHFX09TcgEeSuYLQ5btCUGsSyLmEMOuQoriYE48
        wNfVXaDxn+twWE5t1KTRVyejcgIhA8DX3e//qeAqgmN7GHZdGajAs3c8A7YpaqLMcGJIluq8H5o
        H0GS7UvqCxckQhngAoF6roYWKbw==
X-Received: by 2002:adf:e4c1:0:b0:317:631b:43ce with SMTP id v1-20020adfe4c1000000b00317631b43cemr211122wrm.41.1690490609101;
        Thu, 27 Jul 2023 13:43:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE5uJ/oq7k8HMKqGjTAj9YXavyFIz9pzPmDlSEtdqza/G/k9zSMt0DLfdelGn97z37co4Lb3w==
X-Received: by 2002:adf:e4c1:0:b0:317:631b:43ce with SMTP id v1-20020adfe4c1000000b00317631b43cemr211115wrm.41.1690490608705;
        Thu, 27 Jul 2023 13:43:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f43:4700:d2cd:2b81:d4e6:8b2a? (p200300d82f434700d2cd2b81d4e68b2a.dip0.t-ipconnect.de. [2003:d8:2f43:4700:d2cd:2b81:d4e6:8b2a])
        by smtp.gmail.com with ESMTPSA id m12-20020adff38c000000b00313f031876esm2985542wro.43.2023.07.27.13.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 13:43:28 -0700 (PDT)
Message-ID: <818a2511-5eed-7c29-b52f-1cab2bd40434@redhat.com>
Date:   Thu, 27 Jul 2023 22:43:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] smaps: Fix the abnormal memory statistics obtained
 through /proc/pid/smaps
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     liubo <liubo254@huawei.com>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hughd@google.com, willy@infradead.org
References: <20230726073409.631838-1-liubo254@huawei.com>
 <CADFyXm5nkgZjVMj3iJhqQnyA1AOmqZ-AKdaWyUD=UvZsOEOcPg@mail.gmail.com>
 <ZMJt+VWzIG4GAjeb@x1n> <f49c2a51-4dd8-784b-57fa-34fb397db2b7@redhat.com>
 <ZMKJjDaqZ7FW0jfe@x1n> <5a2c9ae4-50f5-3301-3b50-f57026e1f8e8@redhat.com>
 <ZMK+jSDgOmJKySTr@x1n> <30e58727-0a6a-4461-e9b1-f64d6eea026c@redhat.com>
 <ZMLT4aL9V61Bl5TG@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZMLT4aL9V61Bl5TG@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 27.07.23 22:30, Peter Xu wrote:
> On Thu, Jul 27, 2023 at 09:17:45PM +0200, David Hildenbrand wrote:
>> On 27.07.23 20:59, Peter Xu wrote:
>>> On Thu, Jul 27, 2023 at 07:27:02PM +0200, David Hildenbrand wrote:
>>>>>>
>>>>>> This was wrong from the very start. If we're not in GUP, we shouldn't call
>>>>>> GUP functions.
>>>>>
>>>>> My understanding is !GET && !PIN is also called gup.. otherwise we don't
>>>>> need GET and it can just be always implied.
>>>>
>>>> That's not the point. The point is that _arbitrary_ code shouldn't call into
>>>> GUP internal helper functions, where they bypass, for example, any sanity
>>>> checks.
>>>
>>> What's the sanity checks that you're referring to?
>>>
>>
>> For example in follow_page()
>>
>> if (vma_is_secretmem(vma))
>> 	return NULL;
>>
>> if (WARN_ON_ONCE(foll_flags & FOLL_PIN))
>> 	return NULL;
>>
>>
>> Maybe you can elaborate why you think we should *not* be using
>> vm_normal_page_pmd() and instead some arbitrary GUP internal helper? I don't
>> get it.
> 
> Because the old code was written like that?

And it's not 2014 anymore. Nowadays we do have the right helper in place.

[...]

>> FOLL_NUMA naming was nowadays wrong to begin with (not to mention, confusing
>> a we learned). There are other reasons why we have PROT_NONE -- mprotect(),
>> for example.
> 
> It doesn't really violate with the name, IMHO - protnone can be either numa
> hint or PROT_NONE for real. As long as we return NULL for a FOLL_NUMA
> request we're achieving the goal we want - we guarantee a NUMA balancing to
> trigger with when FOLL_NUMA provided.  It doesn't need to guarantee
> anything else, afaiu.  The final check relies in vma_is_accessible() in the
> fault paths anyway.  So I don't blame the old name that much.

IMHO, the name FOLL_NUMA made sense when it still was called pte_numa.

> 
>>
>> We could have a flag that goes the other way around: FOLL_IGNORE_PROTNONE
>> ... which surprisingly then ends up being exactly what FOLL_FORCE means
>> without FOLL_WRITE, and what this patch does.
>>
>> Does that make sense to you?
>>
>>
>>>
>>> The very least is if with above we should really document FOLL_FORCE - we
>>> should mention NUMA effects.  But that's ... really confusing. Thinking
>>> about that I personally prefer a revival of FOLL_NUMA, then smaps issue all
>>> go away.
>>
>> smaps needs to be changed in any case IMHO. And I'm absolutely not in favor
>> of revicing FOLL_NUMA.
> 
> As stated above, to me FOLL_NUMA is all fine and clear.  If you think
> having a flag back for protnone is worthwhile no matter as-is (FOLL_NUMA)
> or with reverted meaning, then that sounds all fine to me. Maybe the old
> name at least makes old developers know what's that.
> 
> I don't have a strong opinion on names though; mostly never had.

I'll avoid new FOLL_ flags first and post my proposal. If many people 
are unhappy with that approach, we can revert the commit and call it a day.

Thanks!

-- 
Cheers,

David / dhildenb

