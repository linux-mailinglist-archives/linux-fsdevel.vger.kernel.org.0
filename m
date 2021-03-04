Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9882B32CE26
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 09:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbhCDIJd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 03:09:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44343 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236161AbhCDIJD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 03:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614845257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2c1ILN3q9sGba/2LIo3VeOZCilzIXtGwhnmwt+QTvoc=;
        b=AGAi4PFqOGoTidLUY9cMvLYttypiqzMepODR/jiEcqfHmStwgAreRXyFg8Ml+gQSFaefJP
        rbbTIfAud2a0gpdv+/+h+w4GJ1T5kU32vG9Svf/JG2u/cs4ipowMq6oDL2aRqZUN++P8NG
        X7IqZhPFgvGUZrosm/mzR8AsduYBUE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-Zojm_bYOPQif52QJBmbxEQ-1; Thu, 04 Mar 2021 03:07:34 -0500
X-MC-Unique: Zojm_bYOPQif52QJBmbxEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E9AA804023;
        Thu,  4 Mar 2021 08:07:32 +0000 (UTC)
Received: from [10.36.113.171] (ovpn-113-171.ams2.redhat.com [10.36.113.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99EDA614ED;
        Thu,  4 Mar 2021 08:07:29 +0000 (UTC)
Subject: Re: [PATCH 1/2] mm: disable LRU pagevec during the migration
 temporarily
To:     Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com,
        surenb@google.com, cgoldswo@codeaurora.org, willy@infradead.org,
        vbabka@suse.cz, linux-fsdevel@vger.kernel.org
References: <20210302210949.2440120-1-minchan@kernel.org>
 <YD+F4LgPH0zMBDGW@dhcp22.suse.cz> <YD/wOq3lf9I5HK85@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <fc76eca3-f986-3980-065f-64c8dc92530a@redhat.com>
Date:   Thu, 4 Mar 2021 09:07:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YD/wOq3lf9I5HK85@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03.03.21 21:23, Minchan Kim wrote:
> On Wed, Mar 03, 2021 at 01:49:36PM +0100, Michal Hocko wrote:
>> On Tue 02-03-21 13:09:48, Minchan Kim wrote:
>>> LRU pagevec holds refcount of pages until the pagevec are drained.
>>> It could prevent migration since the refcount of the page is greater
>>> than the expection in migration logic. To mitigate the issue,
>>> callers of migrate_pages drains LRU pagevec via migrate_prep or
>>> lru_add_drain_all before migrate_pages call.
>>>
>>> However, it's not enough because pages coming into pagevec after the
>>> draining call still could stay at the pagevec so it could keep
>>> preventing page migration. Since some callers of migrate_pages have
>>> retrial logic with LRU draining, the page would migrate at next trail
>>> but it is still fragile in that it doesn't close the fundamental race
>>> between upcoming LRU pages into pagvec and migration so the migration
>>> failure could cause contiguous memory allocation failure in the end.
>>>
>>> To close the race, this patch disables lru caches(i.e, pagevec)
>>> during ongoing migration until migrate is done.
>>>
>>> Since it's really hard to reproduce, I measured how many times
>>> migrate_pages retried with force mode below debug code.
>>>
>>> int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>> 			..
>>> 			..
>>>
>>> if (rc && reason == MR_CONTIG_RANGE && pass > 2) {
>>>         printk(KERN_ERR, "pfn 0x%lx reason %d\n", page_to_pfn(page), rc);
>>>         dump_page(page, "fail to migrate");
>>> }
>>>
>>> The test was repeating android apps launching with cma allocation
>>> in background every five seconds. Total cma allocation count was
>>> about 500 during the testing. With this patch, the dump_page count
>>> was reduced from 400 to 30.
>>
>> Have you seen any improvement on the CMA allocation success rate?
> 
> Unfortunately, the cma alloc failure rate with reasonable margin
> of error is really hard to reproduce under real workload.
> That's why I measured the soft metric instead of direct cma fail
> under real workload(I don't want to make some adhoc artificial
> benchmark and keep tunes system knobs until it could show
> extremly exaggerated result to convice patch effect).
> 
> Please say if you belive this work is pointless unless there is
> stable data under reproducible scenario. I am happy to drop it.

Do you have *some* application that triggers such a high retry count?

I'd love to run it along with virtio-mem and report the actual 
allocation success rate / necessary retries. That could give an 
indication of how helpful your work would be.

Anything that improves the reliability of alloc_contig_range() is of 
high interest to me. If it doesn't increase the reliability but merely 
does some internal improvements (less retries), it might still be 
valuable, but not that important.

-- 
Thanks,

David / dhildenb

