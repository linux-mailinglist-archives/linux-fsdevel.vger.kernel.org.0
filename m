Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2EC2AC359
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 19:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbgKISLL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 13:11:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:48958 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730691AbgKISLL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:11:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 15554AD2F;
        Mon,  9 Nov 2020 18:11:09 +0000 (UTC)
Date:   Mon, 9 Nov 2020 19:11:04 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        mhocko@suse.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 08/21] mm/vmemmap: Initialize page table lock for
 vmemmap
Message-ID: <20201109181104.GC17356@linux>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-9-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201108141113.65450-9-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 08, 2020 at 10:11:00PM +0800, Muchun Song wrote:
> In the register_page_bootmem_memmap, the slab allocator is not ready
> yet. So when ALLOC_SPLIT_PTLOCKS, we use init_mm.page_table_lock.
> otherwise we use per page table lock(page->ptl). In the later patch,
> we will use the vmemmap page table lock to guard the splitting of
> the vmemmap huge PMD.

I am not sure about this one.
Grabbing init_mm's pagetable lock for specific hugetlb operations does not
seem like a good idea, and we do not know how contented is that one.

I think a better fit would be to find another hook to initialize
page_table_lock at a later stage.
Anyway, we do not need till we are going to perform an operation
on the range, right?

Unless I am missing something, this should be doable in hugetlb_init.

hugetlb_init is part from a init_call that gets called during do_initcalls.
At this time, slab is fully operative.

start_kernel
 kmem_cache_init_late
 kmem_cache_init_late
 ...
 arch_call_rest_init
  rest_init
   kernel_init_freeable
    do_basic_setup
     do_initcalls
      hugetlb_init

-- 
Oscar Salvador
SUSE L3
