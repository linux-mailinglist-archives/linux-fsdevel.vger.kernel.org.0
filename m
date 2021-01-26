Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F303041E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 16:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392773AbhAZPM4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 10:12:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23036 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391840AbhAZPMi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611673871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rKPAVmdSu3nxsiB9pgAVODRr/xR8Ner0j63a+nV5B7k=;
        b=C5OA6TxpNsxJa5JKSy8j45Jjf3RE454bLZ4T6eJwuYdOUOSyv41vu++UVuFKopALvu6tIi
        0DuouYwtNGwUr+GX5XD10a8ZXg8j/JHLCbcu794upWdD0XnW6seDRQLncmM52TFXCpNeGb
        dN1Hr8ftqcank1UEML/EdtbCvht3MuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-olBCcwDpMf-_8EC8eT48xQ-1; Tue, 26 Jan 2021 10:11:07 -0500
X-MC-Unique: olBCcwDpMf-_8EC8eT48xQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCE34193410C;
        Tue, 26 Jan 2021 15:11:00 +0000 (UTC)
Received: from [10.36.114.192] (ovpn-114-192.ams2.redhat.com [10.36.114.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 624EC1F0;
        Tue, 26 Jan 2021 15:10:54 +0000 (UTC)
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v13 05/12] mm: hugetlb: allocate the vmemmap pages
 associated with each HugeTLB page
Message-ID: <259b9669-0515-01a2-d714-617011f87194@redhat.com>
Date:   Tue, 26 Jan 2021 16:10:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210126145819.GB16870@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26.01.21 15:58, Oscar Salvador wrote:
> On Tue, Jan 26, 2021 at 10:36:21AM +0100, David Hildenbrand wrote:
>> I think either keep it completely simple (only free vmemmap of hugetlb
>> pages allocated early during boot - which is what's not sufficient for
>> some use cases) or implement the full thing properly (meaning, solve
>> most challenging issues to get the basics running).
>>
>> I don't want to have some easy parts of complex features merged (e.g.,
>> breaking other stuff as you indicate below), and later finding out "it's
>> not that easy" again and being stuck with it forever.
> 
> Well, we could try to do an optimistic allocation, without tricky loopings.
> If that fails, refuse to shrink the pool at that moment.
> 
> The user could always try to shrink it later via /proc/sys/vm/nr_hugepages
> interface.
> 
> But I am just thinking out loud..

The real issue seems to be discarding the vmemmap on any memory that has 
movability constraints - CMA and ZONE_MOVABLE; otherwise, as discussed, 
we can reuse parts of the thingy we're freeing for the vmemmap. Not that 
it would be ideal: that once-a-huge-page thing will never ever be a huge 
page again - but if it helps with OOM in corner cases, sure.

Possible simplification: don't perform the optimization for now with 
free huge pages residing on ZONE_MOVABLE or CMA. Certainly not perfect: 
what happens when migrating a huge page from ZONE_NORMAL to 
(ZONE_MOVABLE|CMA)?

> 
>>> Of course, this means that e.g: memory-hotplug (hot-remove) will not fully work
>>> when this in place, but well.
>>
>> Can you elaborate? Are we're talking about having hugepages in
>> ZONE_MOVABLE that are not migratable (and/or dissolvable) anymore? Than
>> a clear NACK from my side.
> 
> Pretty much, yeah.

Note that we most likely soon have to tackle migrating/dissolving (free) 
hugetlbfs pages from alloc_contig_range() context - e.g., for CMA 
allocations. That's certainly something to keep in mind regarding any 
approaches that already break offline_pages().

-- 
Thanks,

David / dhildenb

