Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6693E95AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 18:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhHKQQG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 12:16:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29131 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229481AbhHKQQG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 12:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628698542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31qE1bVII2HIf93HYG2MbHWEfiiik6GenrXLfQ/a8MA=;
        b=GRW9TSehoBoJvDRrXN6rprznS+uivAJuEQjvTRV7DQNwCKlLmiTJqXGwsBe2eDI/uSeos/
        nCLyWmGfLpVGjivIiUs2GR++eJbzrWGKSfCcbGfaYTKbx8RKrBX0WqJ2ckYpW1PMkFpITj
        85oEKcc+yfWdgx3vuuqzjRGd7YgR8+Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-LYwBHKaqNFWLo65Yd-vSIQ-1; Wed, 11 Aug 2021 12:15:41 -0400
X-MC-Unique: LYwBHKaqNFWLo65Yd-vSIQ-1
Received: by mail-wr1-f71.google.com with SMTP id l12-20020a5d6d8c0000b029015488313d96so911850wrs.15
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Aug 2021 09:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=31qE1bVII2HIf93HYG2MbHWEfiiik6GenrXLfQ/a8MA=;
        b=dcXIADgEyx2fWU6UStDBCxFl+9mF4EgyDXnVLlk1JvBJ1JeYv8Uo54ZSCLCBVBtOaL
         9dxv8B/0Cz+xuCPlqqQQpqcGbmpBtxgMmsucFPS1crsqQhxUoKcL1vcNrn3W7wSLUsRP
         wOOFc16BWzOu0hhGuQcUReaTWAZE5MrsSvuX3cu2yNQOboDFzlQoHZVUhXqRY0aYKAoT
         xDg42Ywf7DMQSgUNHuLiTg+DQ9jprDXI2mNldzwOCa6LSZurOnDhDaUZvcPxD5Hm2R5N
         iqWIVIx2vcZelIKyFSqHdNjvzjMwIqWu1fVmkRt+1i63dMthAmdkGQNbvGGh7Eg3Ks07
         /moQ==
X-Gm-Message-State: AOAM533na6jx2Y9Qw12OyYjRHjtEMh62eRPnpoXp3X0u69/HK5p1/8ay
        9EzEGcvrPAZkKfG86gxvrH8+aHQlW+7gVynJn1Gcz1NHjadpkr6G8LVsmG6oXaS3KLdNSpMlFQR
        j3KGMf7NX23M5+bHlXaRNK9czzQ==
X-Received: by 2002:a5d:42c9:: with SMTP id t9mr3932938wrr.356.1628698539896;
        Wed, 11 Aug 2021 09:15:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4hMFf5taUyGh68P+K4K446qluU1H8SPaIK2FUHBp8IrAP9TpNdfncoCfAlpaLQtVS57MwaQ==
X-Received: by 2002:a5d:42c9:: with SMTP id t9mr3932915wrr.356.1628698539636;
        Wed, 11 Aug 2021 09:15:39 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64a0.dip0.t-ipconnect.de. [91.12.100.160])
        by smtp.gmail.com with ESMTPSA id n8sm26832112wrx.46.2021.08.11.09.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 09:15:39 -0700 (PDT)
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
        jonathan.davies@nutanix.com
References: <20210730160826.63785-1-tiberiu.georgescu@nutanix.com>
 <YQrdY5zQOVgQJ1BI@t490s> <839e82f7-2c54-d1ef-8371-0a332a4cb447@redhat.com>
 <YQrn33pOlpdl662i@t490s>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 0/1] pagemap: swap location for shared pages
Message-ID: <0beb1386-d670-aab1-6291-5c3cb0d661e0@redhat.com>
Date:   Wed, 11 Aug 2021 18:15:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQrn33pOlpdl662i@t490s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04.08.21 21:17, Peter Xu wrote:
> On Wed, Aug 04, 2021 at 08:49:14PM +0200, David Hildenbrand wrote:
>> TBH, I tend to really dislike the PTE marker idea. IMHO, we shouldn't store
>> any state information regarding shared memory in per-process page tables: it
>> just doesn't make too much sense.
>>
>> And this is similar to SOFTDIRTY or UFFD_WP bits: this information actually
>> belongs to the shared file ("did *someone* write to this page", "is
>> *someone* interested into changes to that page", "is there something"). I
>> know, that screams for a completely different design in respect to these
>> features.
>>
>> I guess we start learning the hard way that shared memory is just different
>> and requires different interfaces than per-process page table interfaces we
>> have (pagemap, userfaultfd).
>>
>> I didn't have time to explore any alternatives yet, but I wonder if tracking
>> such stuff per an actual fd/memfd and not via process page tables is
>> actually the right and clean approach. There are certainly many issues to
>> solve, but conceptually to me it feels more natural to have these shared
>> memory features not mangled into process page tables.
> 
> Yes, we can explore all the possibilities, I'm totally fine with it.
> 
> I just want to say I still don't think when there's page cache then we must put
> all the page-relevant things into the page cache.

[sorry for the late reply]

Right, but for the case of shared, swapped out pages, the information is 
already there, in the page cache :)

> 
> They're shared by processes, but process can still have its own way to describe
> the relationship to that page in the cache, to me it's as simple as "we allow
> process A to write to page cache P", while "we don't allow process B to write
> to the same page" like the write bit.

The issue I'm having uffd-wp as it was proposed for shared memory is 
that there is hardly a sane use case where we would *want* it to work 
that way.

A UFFD-WP flag in a page table for shared memory means "please notify 
once this process modifies the shared memory (via page tables, not via 
any other fd modification)". Do we have an example application where 
these semantics makes sense and don't over-complicate the whole 
approach? I don't know any, thus I'm asking dumb questions :)


For background snapshots in QEMU the flow would currently be like this, 
assuming all processes have the shared guest memory mapped.

1. Background snapshot preparation: QEMU requests all processes
    to uffd-wp the range
a) All processes register a uffd handler on guest RAM
b) All processes fault in all guest memory (essentially populating all
    memory): with a uffd-WP extensions we might be able to get rid of
    that, I remember you were working on that.
c) All processes uffd-WP the range to set the bit in their page table

2. Background snapshot runs:
a) A process either receives a UFFD-WP event and forwards it to QEMU or
    QEMU polls all other processes for UFFD events.
b) QEMU writes the to-be-changed page to the migration stream.
c) QEMU triggers all processes to un-protect the page and wake up any
    waiters. All processes clear the uffd-WP bit in their page tables.

3. Background snapshot completes:
a) All processes unregister the uffd handler


Now imagine something like this:

1. Background snapshot preparation:
a) QEMU registers a UFFD-WP handler on a *memfd file* that corresponds
    to guest memory.
b) QEMU uffd-wp's the whole file

2. Background snapshot runs:
a) QEMU receives a UFFD-WP event.
b) QEMU writes the to-be-changed page to the migration stream.
c) QEMU un-protect the page and wake up any waiters.

3. Background snapshot completes:
a) QEMU unregister the uffd handler


Wouldn't that be much nicer and much easier to handle? Yes, it is much 
harder to implement because such an infrastructure does not exist yet, 
and it most probably wouldn't be called uffd anymore, because we are 
dealing with file access. But this way, it would actually be super easy 
to use the feature across multiple processes and eventually to even 
catch other file modifications.

Again, I am not sure if uffd-wp or softdirty make too much sense in 
general when applied to shmem. But I'm happy to learn more.

-- 
Thanks,

David / dhildenb

