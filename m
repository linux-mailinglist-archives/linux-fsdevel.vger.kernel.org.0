Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F036A76A0C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 21:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjGaTBJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 15:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjGaTBH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:01:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DC31711
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 12:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690830012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LRN4iXZUggA9gxv0XWtRGIRu1LUQCEe4QBtdGPEZ4EM=;
        b=YgaPBcyb7eOXxyQ73Duqrrww7fHt1lWv0QZcXRBAYmtN9Vo3OvYdADSC+NTukm1EcW49qo
        6aXIVqeA6VesKMWk95JWF8tgzD5K+4TX2asjcacKsp8MDfIJJW8Gwrxuy9kO4AvoRVW5r5
        NjDuqqxpWN0fFuMe+5+Fj3iCgryImZ4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-X1L8jTU9N_idIbIkVx3mjw-1; Mon, 31 Jul 2023 15:00:09 -0400
X-MC-Unique: X1L8jTU9N_idIbIkVx3mjw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fe2477947eso4616645e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 12:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690830008; x=1691434808;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRN4iXZUggA9gxv0XWtRGIRu1LUQCEe4QBtdGPEZ4EM=;
        b=cZhvq4tdP/dQwhqxJI2UVk0oCNVtfGBAsyBWKCQBddZ/PL3k9M4G4OTYa2ARSsGwtQ
         Vk2dF/N5xBuqjTblee/vcualTx3An6lauIxK7T8eh5ma/fBgpzvZKpUOOrnq3Azs8aUp
         Iek46MCkjA1KuQzcqT29pJ2rv96kIeJ22JxZTab24gbf6jagwGWSziktoPcynq5y3SJl
         OwTKDJaNmmE4xZOjpjOf0WC/vkMg9iOpZTj2HaadddGP7HlaUvAs/WgoyBZc1vIh6w+f
         HtWB3fCsjKZcQPdrt7bHLNpYyWllaFdFvX08GAzRsvQWmZLAIzUyN6iAXu/gLVHiRBns
         l6Pg==
X-Gm-Message-State: ABy/qLb2ZTNZvPdfBMhx/mYjcIwj+kJOgL6KePE/H++C6jbY24eKTBXU
        vakwQ8KAOyqJIIHyUw0Yub4KPMwFhmsBhaV11aQSjdpPR1oQfxuT+oxWbeX4L9p+dXaBe3EuQh0
        Sgy6uJYLYDlvsZH6Pcj6BmOx8mg==
X-Received: by 2002:adf:dd8a:0:b0:317:6e62:b124 with SMTP id x10-20020adfdd8a000000b003176e62b124mr423301wrl.18.1690830008404;
        Mon, 31 Jul 2023 12:00:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFqiX9tpRijhcAmgDWj/xfoH3k7N2YHmd2jP9GAIEyCL0XqSLGXqpeGNftPDRTmLgmfpte+Vg==
X-Received: by 2002:adf:dd8a:0:b0:317:6e62:b124 with SMTP id x10-20020adfdd8a000000b003176e62b124mr423280wrl.18.1690830007915;
        Mon, 31 Jul 2023 12:00:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c723:4c00:5c85:5575:c321:cea3? (p200300cbc7234c005c855575c321cea3.dip0.t-ipconnect.de. [2003:cb:c723:4c00:5c85:5575:c321:cea3])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4407000000b0031766e99429sm13799820wrq.115.2023.07.31.12.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 12:00:07 -0700 (PDT)
Message-ID: <a453d403-fc96-e4a0-71ee-c61d527e70da@redhat.com>
Date:   Mon, 31 Jul 2023 21:00:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>
References: <20230727212845.135673-1-david@redhat.com>
 <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <412bb30f-0417-802c-3fc4-a4e9d5891c5d@redhat.com>
 <66e26ad5-982e-fe2a-e4cd-de0e552da0ca@redhat.com> <ZMfc9+/44kViqjeN@x1n>
 <a3349cdb-f76f-eb87-4629-9ccba9f435a1@redhat.com>
 <CAHk-=wiREarX5MQx9AppxPzV6jXCCQRs5KVKgHoGYwATRL6nPg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
In-Reply-To: <CAHk-=wiREarX5MQx9AppxPzV6jXCCQRs5KVKgHoGYwATRL6nPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 31.07.23 20:23, Linus Torvalds wrote:
> On Mon, 31 Jul 2023 at 09:20, David Hildenbrand <david@redhat.com> wrote:
>>

Hi Linus,

>> I modified it slightly: FOLL_HONOR_NUMA_FAULT is now set in
>> is_valid_gup_args(), such that it will always be set for any GUP users,
>> including GUP-fast.
> 
> But do we actually want that? It is actively crazy to honor NUMA
> faulting at least for get_user_pages_remote().

This would only be for the stable backport that would go in first and 
where I want to be a bit careful.

Next step would be to let the callers (KVM) specify 
FOLL_HONOR_NUMA_FAULT, as suggested by you.

> 
> So right now, GUP-fast requires us to honor NUMA faults, because
> GUP-fast doesn't have a vma (which in turn is because GUP-fast doesn't
> take any locks).

With FOLL_HONOR_NUMA_FAULT moved to the GUP caller that would no longer 
be the case.

Anybody who

(1) doesn't specify FOLL_HONOR_NUMA_FAULT, which is the majority
(2) doesn't specify FOLL_WRITE

Would get GUP-fast just grabbing these pte_protnone() pages.

> 
> So GUP-fast can only look at the page table data, and as such *has* to
> fail if the page table is inaccessible.

gup_fast_only, yes, which is what KVM uses if a writable PFN is desired.

> 
> But GUP in general? Why would it want to honor numa faulting?
> Particularly by default, and _particularly_ for things like
> FOLL_REMOTE.

KVM currently does [virt/kvm/kvm_main.c]:

(1) hva_to_pfn_fast(): call get_user_page_fast_only(FOLL_WRITE) if a
     writable PFN is desired
(2) hva_to_pfn_slow(): call get_user_pages_unlocked()


So in the "!writable" case, we would always call 
get_user_pages_unlocked() and never honor NUMA faults.

Converting that to some other pattern might be possible (although KVM 
plays quite some tricks here!), but assuming we would always first do a 
get_user_page_fast_only(), then when not intending to write (!FOLL_WRITE)

(1) get_user_page_fast_only() would honor NUMA faults and fail
(2) get_user_pages() would not honor NUMA faults and succeed

Hmmm ... so we would have to use get_user_pages_fast()? It might be 
possible, but I am not sure if we want get_user_pages_fast() to always 
honor NUMA faults, because ...

> 
> In fact, I feel like this is what the real rule should be: we simply
> define that get_user_pages_fast() is about looking up the page in the
> page tables.
> 
> So if you want something that acts like a page table lookup, you use
> that "fast" thing.  It's literally how it is designed. The whole - and
> pretty much only - point of it is that it can be used with no locking
> at all, because it basically acts like the hardware lookup does.
> 

... I see what you mean (HW would similarly refuse to use such a page), 
but I do wonder if that makes the API clearer and if this is what we 
actually want.

We do have callers of pin_user_pages_fast() and friends that maybe 
*really* shouldn't care about NUMA hinting. 
iov_iter_extract_user_pages() is one example -- used for O_DIRECT nowadays.

Their logic is "if it's directly in the page table, create, hand it 
over. If not, please go the slow path.". In many cases user space just 
touched these pages so they are very likely in the page table.

Converting them to pin_user_pages() would mean they will just run slower 
in the common case.

Converting them to a manual pin_user_pages_fast_only() + 
pin_user_pages() doesn't seem very compelling.


... so we would need a new API? :/

> So then if KVM wants to look up a page in the page table, that is what
> kvm should use, and it automatically gets the "honor numa faults"
> behavior, not because it sets a magic flag, but simply because that is
> how GUP-fast *works*.
> 
> But if you use the "normal" get/pin_user_pages() function, which looks
> up the vma, at that point you are following things at a "software
> level", and it wouldn't do NUMA faulting, it would just get the page.

My main problem with that is that pin_user_pages_fast() and friends are 
used all over the place for a "likely already in the page table case, so 
just make everything faster as default".

Always honoring NUMA faults here does not sound like the improvement we 
wanted to have :) ... we actually *don't* want to honor NUMA faults here.


We just have to find a way to make the KVM special case happy.

Thanks!

-- 
Cheers,

David / dhildenb

