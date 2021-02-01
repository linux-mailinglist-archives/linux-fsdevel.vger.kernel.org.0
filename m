Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1684730AC0A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 16:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhBAPxN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 10:53:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46789 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232070AbhBAPws (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612194682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k7JcQqia2+dIQ5jR2h/xA1wGbQRmVVlja2/HYWBBHWM=;
        b=NIcM2d4FzAuzmOJslJoQnSiqCNNfvw3eqNTbyB7oaJ5Cagpug0cNrm+IAO6WLS4XT1aH27
        gR4r5kDF+xKFA7qAHSvbkFU4lHhpVwatUVILMa4Ee06gbxcY515XbTZ73Rsm0S4tf5CltF
        0My+dO6BC3JSwyDNXYQoU6WqGNy7YF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-uXYghaC-NlG2uuwXgi1lcA-1; Mon, 01 Feb 2021 10:51:20 -0500
X-MC-Unique: uXYghaC-NlG2uuwXgi1lcA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B4781054FA3;
        Mon,  1 Feb 2021 15:51:04 +0000 (UTC)
Received: from [10.36.115.24] (ovpn-115-24.ams2.redhat.com [10.36.115.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F7F61346F;
        Mon,  1 Feb 2021 15:50:55 +0000 (UTC)
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        mhocko@suse.com, song.bao.hua@hisilicon.com,
        naoya.horiguchi@nec.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-6-songmuchun@bytedance.com>
 <20210126092942.GA10602@linux>
 <6fe52a7e-ebd8-f5ce-1fcd-5ed6896d3797@redhat.com>
 <20210126145819.GB16870@linux>
 <259b9669-0515-01a2-d714-617011f87194@redhat.com>
 <20210126153448.GA17455@linux>
 <9475b139-1b33-76c7-ef5c-d43d2ea1dba5@redhat.com>
 <e28399e1-3a24-0f22-b057-76e7c7e70017@redhat.com>
 <20210128222906.GA3826@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v13 05/12] mm: hugetlb: allocate the vmemmap pages
 associated with each HugeTLB page
Message-ID: <0f34d46b-cb42-0bbf-1d7e-0b4731bdb5e9@redhat.com>
Date:   Mon, 1 Feb 2021 16:50:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210128222906.GA3826@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28.01.21 23:29, Oscar Salvador wrote:
> On Wed, Jan 27, 2021 at 11:36:15AM +0100, David Hildenbrand wrote:
>> Extending on that, I just discovered that only x86-64, ppc64, and arm64
>> really support hugepage migration.
>>
>> Maybe one approach with the "magic switch" really would be to disable
>> hugepage migration completely in hugepage_migration_supported(), and
>> consequently making hugepage_movable_supported() always return false.
> 
> Ok, so migration would not fork for these pages, and since them would
> lay in !ZONE_MOVABLE there is no guarantee we can unplug the memory.
> Well, we really cannot unplug it unless the hugepage is not used
> (it can be dissolved at least).
> 
> Now to the allocation-when-freeing.
> Current implementation uses GFP_ATOMIC(or wants to use) + forever loop.
> One of the problems I see with GFP_ATOMIC is that gives you access
> to memory reserves, but there are more users using those reserves.
> Then, worst-scenario case we need to allocate 16MB order-0 pages
> to free up 1GB hugepage, so the question would be whether reserves
> really scale to 16MB + more users accessing reserves.
> 
> As I said, if anything I would go for an optimistic allocation-try
> , if we fail just refuse to shrink the pool.
> User can always try to shrink it later again via /sys interface.
> 
> Since hugepages would not be longer in ZONE_MOVABLE/CMA and are not
> expected to be migratable, is that ok?
> 
> Using the hugepage for the vmemmap array was brought up several times,
> but that would imply fragmenting memory over time.
> 
> All in all seems to be overly complicated (I might be wrong).
> 
> 
>> Huge pages would never get placed onto ZONE_MOVABLE/CMA and cannot be
>> migrated. The problem I describe would apply (careful with using
>> ZONE_MOVABLE), but well, it can at least be documented.
> 
> I am not a page allocator expert but cannot the allocation fallback
> to ZONE_MOVABLE under memory shortage on other zones?

No, for now it's not done. Only movable allocations target ZONE_MOVABLE. 
Doing so would be controversial: when would be the right point in time 
to start spilling unmovable allocations into CMA/ZONE_MOVABLE? You 
certainly want to try other things first (swapping, reclaim, 
compaction), before breaking any guarantees regarding 
hotunplug+migration/compaction you have with CMA/ZONE_MOVABLE. And even 
if you would allow it, your workload would already suffer extremely.

So it smells more like a setup issue. But then, who knows when 
allocating huge pages (esp. at runtime) that there are such side effects 
before actually running into them?

We can make sure that all relevant archs support migration of ordinary 
(!gigantic) huge pages (for now, only x86-64, ppc64/spapr, arm64), so we 
can place them onto ZONE_MOVABLE. It gets harder with more special cases.

Gigantic pages (without CMA) are more of a general issue, but at least 
it's simple to document ("Careful when pairing ZONE_MOVABLE with 
gigantic pages on !CMA").

An unexpected high amount of unmovable memory is just extremely 
difficult to handle with ZONE_MOVABLE; it's hard for the user/admin to 
figure out that such restrictions actually apply.

-- 
Thanks,

David / dhildenb

