Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD9631FA61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 15:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhBSONQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 09:13:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:60188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229799AbhBSONJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 09:13:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613743942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E+USPRqgN/Kvs1vKcFSGjJ866vTEg0TvC4G84Ip+KFg=;
        b=VVGs6Gzbps3TiRPDVnJniqgF440MGZD562bPBpZzHg+L/83JMZABxDLxLUuNh8RyIQ5FX+
        5do62w8Y5b3/gjk2YbNAJXSAyXbdysChF7Ep7U6HlDVLE96BgnFmUfYI6DzRGzStyPuCh6
        /UscW72CNfGAS+2RP13mtY4I8/woSKg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A889FABAE;
        Fri, 19 Feb 2021 14:12:22 +0000 (UTC)
Date:   Fri, 19 Feb 2021 15:12:21 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v16 4/9] mm: hugetlb: alloc the vmemmap pages associated
 with each HugeTLB page
Message-ID: <YC/HRTq1MRaDWn7O@dhcp22.suse.cz>
References: <20210219104954.67390-1-songmuchun@bytedance.com>
 <20210219104954.67390-5-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219104954.67390-5-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 19-02-21 18:49:49, Muchun Song wrote:
> When we free a HugeTLB page to the buddy allocator, we should allocate
> the vmemmap pages associated with it. But we may cannot allocate vmemmap
> pages when the system is under memory pressure, in this case, we just
> refuse to free the HugeTLB page instead of looping forever trying to
> allocate the pages. This changes some behavior (list below) on some
> corner cases.
> 
>  1) Failing to free a huge page triggered by the user (decrease nr_pages).
> 
>     Need try again later by the user.
> 
>  2) Failing to free a surplus huge page when freed by the application.
> 
>     Try again later when freeing a huge page next time.

This means that surplus pages can accumulate right? This should be
rather unlikely because one released huge page could then be reused for
normal allocations - including vmemmap. Unlucky timing might still end
up in the accumulation though. Not something critical though.

>  3) Failing to dissolve a free huge page on ZONE_MOVABLE via
>     offline_pages().
> 
>     This is a bit unfortunate if we have plenty of ZONE_MOVABLE memory
>     but are low on kernel memory. For example, migration of huge pages
>     would still work, however, dissolving the free page does not work.
>     This is a corner cases. When the system is that much under memory
>     pressure, offlining/unplug can be expected to fail.

Please mention that this is unfortunate because it prevents from the
memory offlining which shouldn't happen for movable zones. People
depending on the memory hotplug and movable zone should carefuly
consider whether savings on unmovable memory are worth losing their
hotplug functionality in some situations.

>  4) Failing to dissolve a huge page on CMA/ZONE_MOVABLE via
>     alloc_contig_range() - once we have that handling in place. Mainly
>     affects CMA and virtio-mem.

What about hugetlb page poisoning on HW failure (resp. soft offlining)?

> 
>     Similar to 3). virito-mem will handle migration errors gracefully.
>     CMA might be able to fallback on other free areas within the CMA
>     region.
> 
> We do not want to use GFP_ATOMIC to allocate vmemmap pages. Because it
> grants access to memory reserves and we do not think it is reasonable
> to use memory reserves. We use GFP_KERNEL in alloc_huge_page_vmemmap().

This likely needs more context around. Maybe something like
"
Vmemmap pages are allocated from the page freeing context. In order for
those allocations to be not disruptive (e.g. trigger oom killer)
__GFP_NORETRY is used. hugetlb_lock is dropped for the allocation
because a non sleeping allocation would be too fragile and it could fail
too easily under memory pressure. GFP_ATOMIC or other modes to access
memory reserves is not used because we want to prevent consuming
reserves under heavy hugetlb freeing.
"

I haven't gone through the patch in a great detail yet, from a high
level POV it looks good although the counter changes and reshuffling
seems little wild. That requires a more detailed look I do not have time
for right now. Mike would be much better for that anywya ;)

I do not see any check for an atomic context in free_huge_page path. I
have suggested to replace in_task by in_atomic check (with a gotcha that
the later doesn't work without preempt_count but there is a work to
address that).
-- 
Michal Hocko
SUSE Labs
