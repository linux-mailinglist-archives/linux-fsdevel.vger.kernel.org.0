Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803D17B5949
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 19:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjJBRg7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 13:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjJBRg6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:36:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC6993
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 10:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696268166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AWvha6fRF1SNOXs+/+D3XvvHHwIpB0ZKCqYjNNw4DJ0=;
        b=Xc/jgPDTBZdyGsQtGv7S5Ke/z1+DF920kyAKvSK+DMuRXUx4T0CX1qJQCJm7Nvl+JrHvJh
        UFgwgJ5O/6ObLlqSFuWK2DGA8vhe3R/wsmJgJFDiFuNpvRsDadCfzQT+VxQAHSiGKFQieX
        6ewLxxA5Pta3f0rcfRXMBr29KdssZug=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-qN0tQGHsP5ajIpds79Km3A-1; Mon, 02 Oct 2023 13:36:04 -0400
X-MC-Unique: qN0tQGHsP5ajIpds79Km3A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32320b3ee93so30088f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 10:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696268163; x=1696872963;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWvha6fRF1SNOXs+/+D3XvvHHwIpB0ZKCqYjNNw4DJ0=;
        b=mjYLkOCJJcEErtjO0Wc46XD+t5J+Y3GiuuGXnQxRElQaUz0Q6qy/NhTOzHBnp0Zib1
         bnATnYg4Ug6MiHj4DE9ZY65TZUyvtLBP7EecgPUejAvsennRcMtK+Q4zY+BTgKp3ULIf
         QInafBFuzeg4K8g/AiXLpkr3Hmj3ULJsWkf1W1mPVWst51uw0hhrNLVAJVVipMtKUgaW
         C84emmlkNfIpf8ZTLaoX0KM152Si8Mtxo8xUeXmzvrlip4szqn1j+TSJKgXpzQtOQk7n
         21U4aXQbos3SEDJLR+xgNdJzFoaAxrDEiHYap/GzfSHIMJN12CXA+CS+jsfYqm5+Jbnn
         u06w==
X-Gm-Message-State: AOJu0YzhXNwVw47eWkAUx1p1nA5PTzJF1s02W8UmFB/Et5ayGT4LnmYl
        M4RFKJtoYOHuNqaxzgna3yOmRlXW2HCgIxqBtpp+Bjb6zKcbc98Z0Ek+mloWCtJjgjKRuNc3ZLk
        wRdSFkhWU7rx5J0hORtys3yBUug==
X-Received: by 2002:adf:f051:0:b0:319:85e2:6972 with SMTP id t17-20020adff051000000b0031985e26972mr10691559wro.42.1696268163572;
        Mon, 02 Oct 2023 10:36:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuvx/KeHzqrds9UsnjoUzmDcg51LBJ7y3jmgAeA81+WENxMHL6lgJz18K85ppvucakyeJY0g==
X-Received: by 2002:adf:f051:0:b0:319:85e2:6972 with SMTP id t17-20020adff051000000b0031985e26972mr10691531wro.42.1696268163093;
        Mon, 02 Oct 2023 10:36:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:f200:cb49:cb8f:88fc:9446? (p200300cbc735f200cb49cb8f88fc9446.dip0.t-ipconnect.de. [2003:cb:c735:f200:cb49:cb8f:88fc:9446])
        by smtp.gmail.com with ESMTPSA id y7-20020adfd087000000b00317f70240afsm28206600wrh.27.2023.10.02.10.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 10:36:02 -0700 (PDT)
Message-ID: <47daf31f-e242-43e3-289c-8015eb516c6d@redhat.com>
Date:   Mon, 2 Oct 2023 19:36:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
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
 <d613c21e-c76c-f40a-23ec-b9bb3feb5b85@redhat.com>
Organization: Red Hat
In-Reply-To: <d613c21e-c76c-f40a-23ec-b9bb3feb5b85@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02.10.23 19:33, David Hildenbrand wrote:
> On 02.10.23 17:21, Peter Xu wrote:
>> On Mon, Oct 02, 2023 at 10:00:03AM +0200, David Hildenbrand wrote:
>>> In case we cannot simply remap the page, the fallback sequence (from the
>>> cover letter) would be triggered.
>>>
>>> 1) UFFDIO_COPY
>>> 2) MADV_DONTNEED
>>>
>>> So we would just handle the operation internally without a fallback.
>>
>> Note that I think there will be a slight difference on whole remap
>> atomicity, on what happens if the page is modified after UFFDIO_COPY but
>> before DONTNEED.
> 
> If the page is writable (implies PAE), we can always move it. If it is
> R/O, it cannot change before we get a page fault and grab the PT lock
> (well, and page lock).
> 
> So I think something atomic can be implemented without too much issues.
> 
>>
>> UFFDIO_REMAP guarantees full atomicity when moving the page, IOW, threads
>> can be updating the pages when ioctl(UFFDIO_REMAP), data won't get lost
>> during movement, and it will generate a missing event after moved, with
>> latest data showing up on dest.
> 
> If the page has to be copied, grab a reference and unmap it, then copy
> it and map it into the new process. Should be doable and handle all
> kinds of situations just fine.
> 
> Just throwing out ideas to get a less low-level interface.
> 
> [if one really wants to get notified when one cannot move without a
> copy, one could have a flag for such power users to control the behavior]
> 

[of course, if someone would have a GUP-pin on such a page, the page 
exchange would be observable. Just have to documented the UFFDIO_MOVE 
semantics properly]

-- 
Cheers,

David / dhildenb

