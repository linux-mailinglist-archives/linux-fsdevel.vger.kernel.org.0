Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721747091C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 10:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjESIj0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 04:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjESIjV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 04:39:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCABE56
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 01:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684485514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tX9NkuaMfOfCKs1FCdEqGfDAsl8Ds/2jqifxpDMQKog=;
        b=D561lFdafay1NhkBb2dY5VSEopkbivV0wVlMjM2FUN4R9i+vG/RKCdF8PIDm4N5dXwrXUM
        P3MtwE0klO9m6NKPCyPgWWZVqXZX8QU1OaEDXc+29BFc3tnzBZl2U8aahZCoPSHc3z+hdG
        VSYTgO8h66KyfxhQdysTG8+By1y5z7s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-a8kzH9LzMwq0QrRWhwC_kg-1; Fri, 19 May 2023 04:38:33 -0400
X-MC-Unique: a8kzH9LzMwq0QrRWhwC_kg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f4f2f5098bso17272885e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 01:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684485512; x=1687077512;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tX9NkuaMfOfCKs1FCdEqGfDAsl8Ds/2jqifxpDMQKog=;
        b=HubYApm4BBfdN4v55jwqYdU63PjUTiPOTS4SSh0m2gEKh2CctIL7MiXOVQD0bPLdQc
         z90EU1pGY4RBqJkF/Mm8W23QHAm0VRfS/ZNiDkr8wYAthVh8h7hEIA1exClNnjg0piLP
         OipKLt6HElB63YQLrIoPVi6l5fIRrDk4biKj19M7AUapSQBPa6lwLTA0HuB+kb1pTitI
         nT2liD3qRHE9vyyv47A5zjmzJuc6SbxxZPysoyh4a6PJuxmPgqrGSWBRPsGamOQSGmPn
         8VBT938LBd1qqTVriBi5oc72dKQPMuWofKGQht3igEdhQphicVrhdf4GbkcMbA/jqTpv
         WHWg==
X-Gm-Message-State: AC+VfDz3Q393AL5UJTtH7UxWtRWEetu0BNtjLGWl3K0/Bi4rH+1kofKf
        MTzEKbwJ7XS6tDB8+bTINQ/zU7Abm7vxgUq8ya4gZG7lPORzGks8CJFH7xP1DgvGfJeqAEmsB65
        rlv5MJ5a5T7V/gPg6V0UF8vEtew==
X-Received: by 2002:a7b:c39a:0:b0:3f4:2198:dc2b with SMTP id s26-20020a7bc39a000000b003f42198dc2bmr693578wmj.37.1684485511863;
        Fri, 19 May 2023 01:38:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7LtglJFB9R2JhDU+tff4uPwmts/Q/Nk8YQIEhGQ9liamKeS2OKMjiL1/ZjRuXRD48OUaDpuA==
X-Received: by 2002:a7b:c39a:0:b0:3f4:2198:dc2b with SMTP id s26-20020a7bc39a000000b003f42198dc2bmr693547wmj.37.1684485511344;
        Fri, 19 May 2023 01:38:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c722:9d00:7421:54d8:9227:a3e8? (p200300cbc7229d00742154d89227a3e8.dip0.t-ipconnect.de. [2003:cb:c722:9d00:7421:54d8:9227:a3e8])
        by smtp.gmail.com with ESMTPSA id q28-20020a056000137c00b003093a412310sm4570816wrz.92.2023.05.19.01.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 01:38:30 -0700 (PDT)
Message-ID: <32fdc2c8-b86b-92f3-1d5e-64db6be29126@redhat.com>
Date:   Fri, 19 May 2023 10:38:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>
Cc:     Jiaqi Yan <jiaqiyan@google.com>,
        James Houghton <jthoughton@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Huang Ying <ying.huang@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Anish Moorthy <amoorthy@google.com>
References: <20230511182426.1898675-1-axelrasmussen@google.com>
 <CADrL8HXFiTL-RDnETS2BUg_qH8CvcCMZiX-kutsrS1-8Uy25=w@mail.gmail.com>
 <ZGVRUeCWr8209m8d@x1n> <ZGVTMnVKNcQDM0x4@x1n>
 <CAJHvVcgXynHcuoS6eCfOAB2SgzqYy_zMGrRMR2kFuxOtSdUwvQ@mail.gmail.com>
 <CACw3F52MNOVv6KA5n7wRYDT2ujwYkco=aYngbo-zGA3zW1yq+w@mail.gmail.com>
 <ZGZMtK6PzoTuLZ1b@x1n>
 <CAJHvVcgcYPu-G3RDVrkrM_J48NUiUY0SH0G1sd+=X9BDgnQEuQ@mail.gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/3] mm: userfaultfd: add new UFFDIO_SIGBUS ioctl
In-Reply-To: <CAJHvVcgcYPu-G3RDVrkrM_J48NUiUY0SH0G1sd+=X9BDgnQEuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18.05.23 22:38, Axel Rasmussen wrote:
> On Thu, May 18, 2023 at 9:05 AM Peter Xu <peterx@redhat.com> wrote:
>>
>> On Wed, May 17, 2023 at 05:43:53PM -0700, Jiaqi Yan wrote:
>>> On Wed, May 17, 2023 at 3:29 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>>>>
>>>> On Wed, May 17, 2023 at 3:20 PM Peter Xu <peterx@redhat.com> wrote:
>>>>>
>>>>> On Wed, May 17, 2023 at 06:12:33PM -0400, Peter Xu wrote:
>>>>>> On Thu, May 11, 2023 at 03:00:09PM -0700, James Houghton wrote:
>>>>>>> On Thu, May 11, 2023 at 11:24 AM Axel Rasmussen
>>>>>>> <axelrasmussen@google.com> wrote:
>>>>>>>>
>>>>>>>> So the basic way to use this new feature is:
>>>>>>>>
>>>>>>>> - On the new host, the guest's memory is registered with userfaultfd, in
>>>>>>>>    either MISSING or MINOR mode (doesn't really matter for this purpose).
>>>>>>>> - On any first access, we get a userfaultfd event. At this point we can
>>>>>>>>    communicate with the old host to find out if the page was poisoned.
>>>>>>>> - If so, we can respond with a UFFDIO_SIGBUS - this places a swap marker
>>>>>>>>    so any future accesses will SIGBUS. Because the pte is now "present",
>>>>>>>>    future accesses won't generate more userfaultfd events, they'll just
>>>>>>>>    SIGBUS directly.
>>>>>>>
>>>>>>> I want to clarify the SIGBUS mechanism here when KVM is involved,
>>>>>>> keeping in mind that we need to be able to inject an MCE into the
>>>>>>> guest for this to be useful.
>>>>>>>
>>>>>>> 1. vCPU gets an EPT violation --> KVM attempts GUP.
>>>>>>> 2. GUP finds a PTE_MARKER_UFFD_SIGBUS and returns VM_FAULT_SIGBUS.
>>>>>>> 3. KVM finds that GUP failed and returns -EFAULT.
>>>>>>>
>>>>>>> This is different than if GUP found poison, in which case KVM will
>>>>>>> actually queue up a SIGBUS *containing the address of the fault*, and
>>>>>>> userspace can use it to inject an appropriate MCE into the guest. With
>>>>>>> UFFDIO_SIGBUS, we are missing the address!
>>>>>>>
>>>>>>> I see three options:
>>>>>>> 1. Make KVM_RUN queue up a signal for any VM_FAULT_SIGBUS. I think
>>>>>>> this is pointless.
>>>>>>> 2. Don't have UFFDIO_SIGBUS install a PTE entry, but instead have a
>>>>>>> UFFDIO_WAKE_MODE_SIGBUS, where upon waking, we return VM_FAULT_SIGBUS
>>>>>>> instead of VM_FAULT_RETRY. We will keep getting userfaults on repeated
>>>>>>> accesses, just like how we get repeated signals for real poison.
>>>>>>> 3. Use this in conjunction with the additional KVM EFAULT info that
>>>>>>> Anish proposed (the first part of [1]).
>>>>>>>
>>>>>>> I think option 3 is fine. :)
>>>>>>
>>>>>> Or... option 4) just to use either MADV_HWPOISON or hwpoison-inject? :)
>>>>>
>>>>> I just remember Axel mentioned this in the commit message, and just in case
>>>>> this is why option 4) was ruled out:
>>>>>
>>>>>          They expect that once poisoned, pages can never become
>>>>>          "un-poisoned". So, when we live migrate the VM, we need to preserve
>>>>>          the poisoned status of these pages.
>>>>>
>>>>> Just to supplement on this point: we do have unpoison (echoing to
>>>>> "debug/hwpoison/hwpoison_unpoison"), or am I wrong?
>>>
>>> If I read unpoison_memory() correctly, once there is a real hardware
>>> memory corruption (hw_memory_failure will be set), unpoison will stop
>>> working and return EOPNOTSUPP.
>>>
>>> I know some cloud providers evacuating VMs once a single memory error
>>> happens, so not supporting unpoison is probably not a big deal for
>>> them. BUT others do keep VM running until more errors show up later,
>>> which could be long after the 1st error.
>>
>> We're talking about postcopy migrating a VM has poisoned page on src,
>> rather than on dst host, am I right?  IOW, the dest hwpoison should be
>> fake.
>>
>> If so, then I would assume that's the case where all the pages on the dest
>> host is still all good (so hw_memory_failure not yet set, or I doubt the
>> judgement of being a migration target after all)?
>>
>> The other thing is even if dest host has hw poisoned page, I'm not sure
>> whether hw_memory_failure is the only way to solve this.
>>
>> I saw that this is something got worked on before from Zhenwei, David used
>> to have some reasoning on why it was suggested like using a global knob:
>>
>> https://lore.kernel.org/all/d7927214-e433-c26d-7a9c-a291ced81887@redhat.com/
>>
>> Two major issues here afaics:
>>
>>    - Zhenwei's approach only considered x86 hwpoison - it relies on kpte
>>      having !present in entries but that's x86 specific rather than generic
>>      to memory_failure.c.
>>
>>    - It is _assumed_ that hwpoison injection is for debugging only.
>>
>> I'm not sure whether you can fix 1) by some other ways, e.g., what if the
>> host just remember all the hardware poisoned pfns (or remember
>> soft-poisoned ones, but then here we need to be careful on removing them
>> from the list when it's hwpoisoned for real)?  It sounds like there's
>> opportunity on providing a generic solution rather than relying on
>> !pte_present().
>>
>> For 2) IMHO that's not a big issue, you can declare it'll be used in !debug
>> but production systems so as to boost the feature importance with a real
>> use case.
>>
>> So far I'd say it'll be great to leverage what it's already there in linux
>> and make it as generic as possible. The only issue is probably
>> CAP_ADMIN... not sure whether we can have some way to provide !ADMIN
>> somehow, or you can simply work around this issue.
> 
> As you mention below I think the key distinction is the scope - I
> think MADV_HWPOISON affects the whole system, including other
> processes.
> 
> For our purposes, we really just want to "poison" this particular
> virtual address (the HVA, from the VM's perspective), not even other
> mappings of the same shared memory. I think that behavior is different
> from MADV_HWPOISON, at least.

MADV_HWPOISON really is the wrong interface to use. See "man madvise".

We don't want to allow arbitrary users to hwpoison+offline absolutely 
healthy physical memory, which is what MADV_HWPOISON is all about.

As you say, we want to turn an unpopulated (!present) virtual address to 
mimic like we had a MCE on a page that would have been previously mapped 
here: install a hwpoison marker without actually poisoning any present 
page. In fact, we'd even want to fail if there *is* something mapped.

Sure, one could teach MADV_HWPOISON to allow unprivileged users to do 
that for !present PTE entries, and fail for unprivileged users if there 
is a present PTE entry. I'm not sure if that's the cleanest approach, 
though, and a new MADV as suggested in this thread would eventually be 
cleaner.

-- 
Thanks,

David / dhildenb

