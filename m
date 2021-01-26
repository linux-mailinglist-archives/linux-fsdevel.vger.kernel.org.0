Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887B03040E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 15:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391197AbhAZOvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 09:51:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391288AbhAZJiF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611653799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oNqVieVd9v1G344GzpIPbD3/DSjB6v+2rop/NW6XtKU=;
        b=hsyFOEe0ll0azuBECxMEHDIow/YZybt/koSsuzK6UkWagNzbGqEROgZeIoC84XfO87K1t+
        ufA1P4KwjNLPstsQeezjLPEhnjVIsq0f/Ki0GWkUJz0biilMv0ePvquyBrIRIEuOiXgLXy
        TqHKL41Xxg04ZUl6al22/FMrwPlbgpE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-U-Izs0d0Oeif6_p39Ww8hw-1; Tue, 26 Jan 2021 04:36:33 -0500
X-MC-Unique: U-Izs0d0Oeif6_p39Ww8hw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BD021005504;
        Tue, 26 Jan 2021 09:36:29 +0000 (UTC)
Received: from [10.36.114.192] (ovpn-114-192.ams2.redhat.com [10.36.114.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1481D60871;
        Tue, 26 Jan 2021 09:36:21 +0000 (UTC)
Subject: Re: [PATCH v13 05/12] mm: hugetlb: allocate the vmemmap pages
 associated with each HugeTLB page
To:     Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <6fe52a7e-ebd8-f5ce-1fcd-5ed6896d3797@redhat.com>
Date:   Tue, 26 Jan 2021 10:36:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210126092942.GA10602@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26.01.21 10:29, Oscar Salvador wrote:
> On Sun, Jan 17, 2021 at 11:10:46PM +0800, Muchun Song wrote:
>> When we free a HugeTLB page to the buddy allocator, we should allocate the
>> vmemmap pages associated with it. We can do that in the __free_hugepage()
>> before freeing it to buddy.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> 
> This series has grown a certain grade of madurity and improvment, but it seems
> to me that we have been stuck in this patch (and patch#4) for quite some time.
> 
> Would it be acceptable for a first implementation to not let hugetlb pages to
> be freed when this feature is in use?
> This would simplify things for now, as we could get rid of patch#4 and patch#5.
> We can always extend functionality once this has been merged, right?

I think either keep it completely simple (only free vmemmap of hugetlb
pages allocated early during boot - which is what's not sufficient for
some use cases) or implement the full thing properly (meaning, solve
most challenging issues to get the basics running).

I don't want to have some easy parts of complex features merged (e.g.,
breaking other stuff as you indicate below), and later finding out "it's
not that easy" again and being stuck with it forever.

> 
> Of course, this means that e.g: memory-hotplug (hot-remove) will not fully work
> when this in place, but well.

Can you elaborate? Are we're talking about having hugepages in
ZONE_MOVABLE that are not migratable (and/or dissolvable) anymore? Than
a clear NACK from my side.

-- 
Thanks,

David / dhildenb

