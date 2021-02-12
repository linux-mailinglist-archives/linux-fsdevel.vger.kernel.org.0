Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDC931A076
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 15:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhBLOQv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 09:16:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58238 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231571AbhBLOQu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613139324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pFui2wB5cJmJppKeE9fg7DgPntP+r/xmUSyZ0JYk3sc=;
        b=HA2tFRuwvlzt0hwekuqfugAAM6LlK46uNuniBAWDxp3A7IGs0G401hXOwBJg4Dc4D9Wa3+
        FC+WLJ0zYHm4ZaLqY6Bf3iGHWCFyoMNaXOHF9j0iqhhP7azl3xv2lIJ6d1JidfSq1HPmNS
        CmTtlieXCUrqvkEAZ0ogb8ucf8kktNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-xbkPRNinPeikoybW4Bn4nQ-1; Fri, 12 Feb 2021 09:15:20 -0500
X-MC-Unique: xbkPRNinPeikoybW4Bn4nQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9737107ACF2;
        Fri, 12 Feb 2021 14:15:15 +0000 (UTC)
Received: from [10.36.114.178] (ovpn-114-178.ams2.redhat.com [10.36.114.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29EB95D9FC;
        Fri, 12 Feb 2021 14:15:09 +0000 (UTC)
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, mhocko@suse.com,
        song.bao.hua@hisilicon.com, naoya.horiguchi@nec.com,
        joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20210208085013.89436-1-songmuchun@bytedance.com>
 <20210208085013.89436-5-songmuchun@bytedance.com>
 <72e772bc-7103-62da-d834-059eb5a3ce5b@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v15 4/8] mm: hugetlb: alloc the vmemmap pages associated
 with each HugeTLB page
Message-ID: <2afd12e0-60cd-0f9e-99a8-8ded09644504@redhat.com>
Date:   Fri, 12 Feb 2021 15:15:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <72e772bc-7103-62da-d834-059eb5a3ce5b@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11.02.21 19:05, Mike Kravetz wrote:
> On 2/8/21 12:50 AM, Muchun Song wrote:
>> When we free a HugeTLB page to the buddy allocator, we should allocate the
>> vmemmap pages associated with it. But we may cannot allocate vmemmap pages
>> when the system is under memory pressure, in this case, we just refuse to
>> free the HugeTLB page instead of looping forever trying to allocate the
>> pages.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>   include/linux/mm.h   |  2 ++
>>   mm/hugetlb.c         | 19 ++++++++++++-
>>   mm/hugetlb_vmemmap.c | 30 +++++++++++++++++++++
>>   mm/hugetlb_vmemmap.h |  6 +++++
>>   mm/sparse-vmemmap.c  | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   5 files changed, 130 insertions(+), 2 deletions(-)
> 
> Muchun has done a great job simplifying this patch series and addressing
> issues as they are brought up.  This patch addresses the issue which seems
> to be the biggest stumbling block to this series.  The need to allocate
> vmemmap pages to dissolve a hugetlb page to the buddy allocator.  The way
> it is addressed in this patch is to simply fail to dissolve the hugetlb
> page if the vmmemmap pages can not be allocated.  IMO, this is an 'acceptable'
> strategy.  If we find ourselves in this situation then we are likely to be
> hitting other corner cases in the system.  I wish there was a perfect way
> to address this issue, but we have been unable to come up with one.
> 
> There was a decent discussion about this is a previous version of the
> series starting here:
> https://lore.kernel.org/linux-mm/20210126092942.GA10602@linux/
> In this thread various other options were suggested and discussed.
> 
> I would like to come to some agreement on an acceptable way to handle this
> specific issue.  IMO, it makes little sense to continue refining other
> parts of this series if we can not figure out how to move forward on this
> issue.
> 
> It would be great if David H, David R and Michal could share their opinions
> on this.  No need to review details the code yet (unless you want), but
> let's start a discussion on how to move past this issue if we can.

So a summary from my side:

We might fail freeing a huge page at any point in time iff we are low on 
kernel (!CMA, !ZONE_MOVABLE) memory. While we could play games with 
allocating the vmemmap from a huge page itself in some cases (e.g., 
!CMA, !ZONE_MOVABLE), simply retrying is way easier and we don't turn 
the huge page forever unusable.

Corner cases might be having many huge pages in ZONE_MOVABLE, freeing 
them all at once and eating up a lot of kernel memory. But then, the 
same setup would already be problematic nowadays where we simply always 
consume that kernel memory for the vmemmap.

I think this problem only really becomes visible in corner cases. And 
someone actively has to enable new behavior.


1. Failing to free a huge page triggered by the user (decrease nr_pages):

Bad luck. Try again later.

2. Failing to free a surplus huge page when freed by the application:

Bad luck. But who will try again later?

3. Failing to dissolve a free huge page on ZONE_MOVABLE via offline_pages()

This is a bit unfortunate if we have plenty of ZONE_MOVABLE memory but 
are low on kernel memory. For example, migration of huge pages would 
still work, however, dissolving the free page does not work. I'd say 
this is a corner cases. When the system is that much under memory 
pressure, offlining/unplug can be expected to fail.

4. Failing to dissolve a huge page on CMA/ZONE_MOVABLE via 
alloc_contig_range() - once we have that handling in place. Mainly 
affects CMA and virtio-mem.

Similar to 3. However, we didn't even take care of huge pages *at all* 
for now (neither migrate nor dissolve). So actually don't make the 
current state any worse. virito-mem will handle migration errors 
gracefully. CMA might be able to fallback on other free areas within the 
CMA region.


I'd say, document the changed behavior properly so people are aware that 
there might be issues in corner cases with huge pages on CMA / ZONE_MOVABLE.

-- 
Thanks,

David / dhildenb

