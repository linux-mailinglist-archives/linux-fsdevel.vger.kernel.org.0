Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE7F7B58D3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 19:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbjJBRe4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 13:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237850AbjJBRey (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647E994
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 10:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696268045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ycaPEXE57RgkhfEN2l1Hbx0ds50RPCHq0uPD2XiXlY0=;
        b=gfMFnymtX4QwQRR9NZzVeYLaEHR4Zi4m5ES+QmoIjaNutybmvoLREb0uchqELogdGYur9P
        PDt5kyRpArdMITUplMGokJEMxlMY3Dk/X2jM5lIM7P/8OdE47LiyYadYIas7HjI4TXyy00
        LLCWAPLniJhXUGGfvL5Ydi8128peSy0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-z6Or8oCOOau2praDr-G3-g-1; Mon, 02 Oct 2023 13:33:54 -0400
X-MC-Unique: z6Or8oCOOau2praDr-G3-g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32320b3ee93so28434f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 10:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696268033; x=1696872833;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ycaPEXE57RgkhfEN2l1Hbx0ds50RPCHq0uPD2XiXlY0=;
        b=ccgO7eeVm61pqYDR9GuibcmJ5do2Tuh228Q9NdG+nr6GZ1LwrjU5JoOMkKUUNvjBzN
         Zmf/iQwbtGkBIM5orVPkpMNrPwEUaCYR0Cih/gqV2iB5Pdz5GUp9Ai53oTT6sOOU/HYl
         neKujUAgyUlDtPUZ/2OHXqRxALDjHvCwcNnMeRLwSnLY2q4Zp7txNAhs1HOegK1mBSSP
         FXGRO/3psGB6CtdVVHDxu9ADltqqRLmqIwy2xp7XfDEINLwQqANAYroPIJVKfeeHL+SB
         hcNc1kv7q1JYxAn3CqGZ3cby9PXT+CwSYzIzpRyncIfXdn8mD09zU0pZcNeaBBkasjDj
         4SlA==
X-Gm-Message-State: AOJu0YztlD/fKlMa1P5CxO5YYP0pTEon7ZDH7H/KOmGj0vYQSvJiztjp
        NZGdenz7fiJRuEgxsNHjfk6RZQgKtq4eervzibIPmeIkkkVha9oYt711Ayla9p6j5it2dlBNjO5
        Hrg6hEhvsh3vTOSNaXxxpq5FHVw==
X-Received: by 2002:a7b:c392:0:b0:405:4a9d:b2bc with SMTP id s18-20020a7bc392000000b004054a9db2bcmr10174627wmj.22.1696268033339;
        Mon, 02 Oct 2023 10:33:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6OH8aY1+9aqrgbgtOpu85+2xJbjCF9QgW2wew0ab2APA3ftxFGN8117E8JTqoZU4pvNvgWA==
X-Received: by 2002:a7b:c392:0:b0:405:4a9d:b2bc with SMTP id s18-20020a7bc392000000b004054a9db2bcmr10174607wmj.22.1696268032828;
        Mon, 02 Oct 2023 10:33:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:f200:cb49:cb8f:88fc:9446? (p200300cbc735f200cb49cb8f88fc9446.dip0.t-ipconnect.de. [2003:cb:c735:f200:cb49:cb8f:88fc:9446])
        by smtp.gmail.com with ESMTPSA id r1-20020a05600c298100b0040586360a36sm7706418wmd.17.2023.10.02.10.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 10:33:52 -0700 (PDT)
Message-ID: <d613c21e-c76c-f40a-23ec-b9bb3feb5b85@redhat.com>
Date:   Mon, 2 Oct 2023 19:33:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
References: <20230923013148.1390521-1-surenb@google.com>
 <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com> <ZRWo1daWBnwNz0/O@x1n>
 <98b21e78-a90d-8b54-3659-e9b890be094f@redhat.com> <ZRW2CBUDNks9RGQJ@x1n>
 <85e5390c-660c-ef9e-b415-00ee71bc5cbf@redhat.com> <ZRXHK3hbdjfQvCCp@x1n>
 <fc27ce41-bc97-91a7-deb6-67538689021c@redhat.com> <ZRrf8NligMzwqx97@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZRrf8NligMzwqx97@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02.10.23 17:21, Peter Xu wrote:
> On Mon, Oct 02, 2023 at 10:00:03AM +0200, David Hildenbrand wrote:
>> In case we cannot simply remap the page, the fallback sequence (from the
>> cover letter) would be triggered.
>>
>> 1) UFFDIO_COPY
>> 2) MADV_DONTNEED
>>
>> So we would just handle the operation internally without a fallback.
> 
> Note that I think there will be a slight difference on whole remap
> atomicity, on what happens if the page is modified after UFFDIO_COPY but
> before DONTNEED.

If the page is writable (implies PAE), we can always move it. If it is 
R/O, it cannot change before we get a page fault and grab the PT lock 
(well, and page lock).

So I think something atomic can be implemented without too much issues.

> 
> UFFDIO_REMAP guarantees full atomicity when moving the page, IOW, threads
> can be updating the pages when ioctl(UFFDIO_REMAP), data won't get lost
> during movement, and it will generate a missing event after moved, with
> latest data showing up on dest.

If the page has to be copied, grab a reference and unmap it, then copy 
it and map it into the new process. Should be doable and handle all 
kinds of situations just fine.

Just throwing out ideas to get a less low-level interface.

[if one really wants to get notified when one cannot move without a 
copy, one could have a flag for such power users to control the behavior]

-- 
Cheers,

David / dhildenb

