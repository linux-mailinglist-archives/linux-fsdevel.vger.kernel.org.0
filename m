Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BA73E9970
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 22:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhHKUO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 16:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39521 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231822AbhHKUO1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 16:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628712843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gz4tyz8ZCc1bDCBSeK8pMb5/FKvZCosp7jg60St3cH4=;
        b=GTD256IHryDs/g0+NSlqZIDqzIQ7CEgnBr4U3oL/VbwHd/oT7rXmsnpc76F+LJsmrXIwAO
        D+mZ4SzNNqBlKK/Bq1egkifeL3oVeD6oJq7QDOUMqCcnNR6gfNCGac1ezI3H9bdd48L/zV
        dVV6eR8QVxobOjip4ujlc1YlUn3kYyM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-BIiNtjatMy-ZNDMxujyKFA-1; Wed, 11 Aug 2021 16:14:02 -0400
X-MC-Unique: BIiNtjatMy-ZNDMxujyKFA-1
Received: by mail-wr1-f70.google.com with SMTP id m5-20020a5d6a050000b0290154e83dce73so1074803wru.19
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Aug 2021 13:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gz4tyz8ZCc1bDCBSeK8pMb5/FKvZCosp7jg60St3cH4=;
        b=kljgEtQTkueGPUeGIltInfH8NjWS2SnLCk55PlN/QNiWhtLzDUaqB6Aocrglrb2mTY
         +7cPeYU62EvhcsZK2d6vvK/fO0tHfJSbopXlcJFYIwM2Vb1JSE9sN4GcHjCzKpDpLzum
         hfoU3CFWGqZNh1sfAUbk0ZR0CKSHqB0+4dZPya+DZX3Tb3GfK2XGv2RlDB0dExSO9vJ1
         FTuskj9ePZZjQeoh71AosJRCTy31Lyjm+WlxY5mXpiHjzDkf5asqiN22HI+D+gVcYTZ9
         G/FAzvbsAqLocWJbTatK3SsOgBKKpQHHmNthZieaI/HK1Dg5IXC6CM9T0DkOknsz6Q7T
         OfcQ==
X-Gm-Message-State: AOAM532bNJaCPWFnIGQjfH4yl3dwK0r3U7IoYJ9rfGcDSrH+RVY63Sz8
        eg+EJIXuHXKixxN2EhDu6P9/r5rdJKit8E0q4By5MPu3n1Wx0GC2gDA06cWK4sIR9GNWcGgpL4k
        PwbZTl/ANlAulFq7AjN06sYMQ9Q==
X-Received: by 2002:adf:f08b:: with SMTP id n11mr211103wro.270.1628712840960;
        Wed, 11 Aug 2021 13:14:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiy6DNhuXIQ8jelBcikSubWXLGiIioDLtl8+n4g6o4yzcrLAkdqP0pCWQkcLUN17rtO59wBg==
X-Received: by 2002:adf:f08b:: with SMTP id n11mr211077wro.270.1628712840679;
        Wed, 11 Aug 2021 13:14:00 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64a0.dip0.t-ipconnect.de. [91.12.100.160])
        by smtp.gmail.com with ESMTPSA id y11sm452620wru.0.2021.08.11.13.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 13:14:00 -0700 (PDT)
To:     Peter Xu <peterx@redhat.com>
Cc:     Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        christian.brauner@ubuntu.com, ebiederm@xmission.com,
        adobriyan@gmail.com, songmuchun@bytedance.com, axboe@kernel.dk,
        vincenzo.frascino@arm.com, catalin.marinas@arm.com,
        peterz@infradead.org, chinwen.chang@mediatek.com,
        linmiaohe@huawei.com, jannh@google.com, apopple@nvidia.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, ivan.teterevkov@nutanix.com,
        florian.schmidt@nutanix.com, carl.waldspurger@nutanix.com,
        jonathan.davies@nutanix.com, Andrea Arcangeli <aarcange@redhat.com>
References: <20210730160826.63785-1-tiberiu.georgescu@nutanix.com>
 <YQrdY5zQOVgQJ1BI@t490s> <839e82f7-2c54-d1ef-8371-0a332a4cb447@redhat.com>
 <YQrn33pOlpdl662i@t490s> <0beb1386-d670-aab1-6291-5c3cb0d661e0@redhat.com>
 <YRQWMIBwkdBK12Z3@t490s> <253e7067-1c62-19bd-d395-d5c0495610d7@redhat.com>
 <YRQrCrOCbVkJJ6Ph@t490s>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 0/1] pagemap: swap location for shared pages
Message-ID: <154c2804-9861-ab91-4bfe-5354683fdfd3@redhat.com>
Date:   Wed, 11 Aug 2021 22:13:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRQrCrOCbVkJJ6Ph@t490s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>
>> Good question, I'd imagine e.g., file sealing could forbid uffd (or however
>> it is called) registration on a file, and there would have to be a way to
>> reject files that have uffd registered. But it's certainly a valid concern -
>> and it raises the question to *what* we actually want to apply such a
>> concept. Random files? random memfd? most probably not. Special memfds
>> created with an ALLOW_UFFD flag? sounds like a good idea.
> 
> Note that when daemons open files, they may not be aware of what's underneath
> but read that file directly.  The attacker could still create the file with
> uffd-wp enabled with any flag we introduce.

Right, but we could, for example, use a prctrl to make a process to opt 
in to opening possibly-uffd-wp-protected files at all. I guess securing 
that aspect shouldn't be a hard nut to crack. At least with my thinking.

> 
>>
>>>
>>> I also don't know the initial concept when uffd is designed and why it's
>>> designed at pte level.  Avoid vma manipulation should be a major factor, but I
>>> can't say I understand all of them.  Not sure whether Andrea has any input here.
>>
>> AFAIU originally a) avoid signal handler madness and b) avoid VMA
>> modifications and c) avoid taking the mmap lock in write (well, that didn't
>> work out completely for uffd-wp for now IIRC).
> 
> Nadav fixed that; it's with read lock now just like when it's introduced.
> Please see mwriteprotect_range() and commit 6ce64428d62026a10c.

Oh, rings a bell, thanks!

>>
>>>
>>> That's why I think current uffd can still make sense with per-process concepts
>>> and keep it that way.  When register uffd-wp yes we need to do that for
>>> multiple processes, but it also means each process is fully aware that this is
>>> happening so it's kind of verified that this is wanted behavior for that
>>> process.  It'll happen with less "surprises", and smells safer.
>>>
>>> I don't think that will not work out.  It may require all the process to
>>> support uffd-wp apis and cooperate, but that's so far how it should work for me
>>> in a safe and self-contained way.  Say, every process should be aware of what's
>>> going to happen on blocked page faults.
>>
>> That's a valid concern, although I wonder if it can just be handled via
>> specially marked memfds ("this memfd might get a uffd handler registered
>> later").
> 
> Yes, please see my above concern.  So I think we at least reached concensus on:
> (1) that idea is already not userfaultfd but something else; what's that is
> still to be defined.  And, (2) that definitely needs further thoughts and
> context to support its validity and safety.  Now uffd got people worried about
> safety already, that's why all the uffd selinux and privileged_userfaultfd
> sysctl comes to mainline; we'd wish good luck with the new concept!

Sure, whenever you introduce random ever-lasting delays, we have to be 
very careful what we support. And if means not supporting some ioctls 
for such a special memfd (hello secretmem :)).

> 
> OTOH, uffd whole idea is already in mainline, it has limitations on requiring
> to rework all processes to support uffd-wp, but actually the same to MISSING
> messages has already happened and our QE is testing those: that's what we do
> with e.g. postcopy-migrating vhost-user enabled OVS-DPDK - we pass over uffd
> registered with missing mode and let QEMU handle the page fault.  So it's a bit
> complicated but it should work.  And I hope you can also agree we don't need to
> block uffd before that idea settles.

Let's phrase it that way: instead of extending something that just 
doesn't fit cleanly and feels kind of hackish (see my approach to 
teaching QEMU background snapshots above), I'd much rather see something 
clean and actually performant for the use cases I am aware of.

That doesn't mean that your current uffd-wp approach on shmem is all bad 
IMHO  (well, I make no decisions either way :) ), I'd just like us to 
look into finding eventually an approach to handle this cleanly instead 
of trying to solve problems we might not have to solve after all (pte 
markers) when things are done differently.

> 
> The pte markers idea need comment; that's about implementation, and it'll be
> great to have comments there or even NACK (better with a better suggestion,
> though :).  But the original idea of uffd that is pte-based has never changed.

Right, I hope some other people can comment. If we want to go down that 
path for uffd-wp, pte makers make sense. I'm not convinced we want them 
to handle swapped shared pages, but that discussion is better off in 
your posting.


>>
>>>>
>>>> Again, I am not sure if uffd-wp or softdirty make too much sense in general
>>>> when applied to shmem. But I'm happy to learn more.
>>>
>>> Me too, I'm more than glad to know whether the page cache idea could be
>>> welcomed or am I just wrong about it.  Before I understand more things around
>>> this, so far I still think the per-process based and fd-based solution of uffd
>>> still makes sense.
>>
>> I'd be curious about applications where the per-process approach would
>> actually solve something a per-fd approach couldn't solve. Maybe there are
>> some that I just can't envision.
> 
> Right, that's a good point.
> 
> Actually it could be when like virtio-mem that some process shouldn't have
> write privilege, but we still allow some other process writting to the shmem.
> Something like that.

With virtio-mem, you most probably wouldn't want anybody writing to it, 
at least from what I can tell. But I understand the rough idea -- just 
that you cannot enforce something on another process that doesn't play 
along (at least with the current uffd-wp approach! you could with an 
fd-based approach).

> 
>>
>> (using shmem for a single process only isn't a use case I consider important
>> :) )
> 
> If you still remember the discussion about "having qemu start to use memfd and
> shmem as default"? :)

Oh yes :)

> 
> shmem is hard but it's indeed useful in many cases, even if single threaded.
> For example, shmem-based VMs can do local binary update without migrating guest
> RAMs (because memory is shared between old/new binaries!).  To me it's always a
> valid request to enable both shmem and write protect.

Right, but it would also just work with an fd-based approach. (well, 
unless we're dealing with shared anonymous RAM, but that is just some 
weird stuff for really exotic use cases)


-- 
Thanks,

David / dhildenb

