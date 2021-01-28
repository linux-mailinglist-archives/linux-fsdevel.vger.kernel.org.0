Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB91930811E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 23:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhA1W3x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 17:29:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:52292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231185AbhA1W3w (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:29:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C239FAC60;
        Thu, 28 Jan 2021 22:29:10 +0000 (UTC)
Date:   Thu, 28 Jan 2021 23:29:06 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
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
Subject: Re: [PATCH v13 05/12] mm: hugetlb: allocate the vmemmap pages
 associated with each HugeTLB page
Message-ID: <20210128222906.GA3826@localhost.localdomain>
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-6-songmuchun@bytedance.com>
 <20210126092942.GA10602@linux>
 <6fe52a7e-ebd8-f5ce-1fcd-5ed6896d3797@redhat.com>
 <20210126145819.GB16870@linux>
 <259b9669-0515-01a2-d714-617011f87194@redhat.com>
 <20210126153448.GA17455@linux>
 <9475b139-1b33-76c7-ef5c-d43d2ea1dba5@redhat.com>
 <e28399e1-3a24-0f22-b057-76e7c7e70017@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e28399e1-3a24-0f22-b057-76e7c7e70017@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 27, 2021 at 11:36:15AM +0100, David Hildenbrand wrote:
> Extending on that, I just discovered that only x86-64, ppc64, and arm64
> really support hugepage migration.
> 
> Maybe one approach with the "magic switch" really would be to disable
> hugepage migration completely in hugepage_migration_supported(), and
> consequently making hugepage_movable_supported() always return false.

Ok, so migration would not fork for these pages, and since them would
lay in !ZONE_MOVABLE there is no guarantee we can unplug the memory.
Well, we really cannot unplug it unless the hugepage is not used
(it can be dissolved at least).

Now to the allocation-when-freeing.
Current implementation uses GFP_ATOMIC(or wants to use) + forever loop.
One of the problems I see with GFP_ATOMIC is that gives you access
to memory reserves, but there are more users using those reserves.
Then, worst-scenario case we need to allocate 16MB order-0 pages
to free up 1GB hugepage, so the question would be whether reserves
really scale to 16MB + more users accessing reserves.

As I said, if anything I would go for an optimistic allocation-try
, if we fail just refuse to shrink the pool.
User can always try to shrink it later again via /sys interface.

Since hugepages would not be longer in ZONE_MOVABLE/CMA and are not
expected to be migratable, is that ok?

Using the hugepage for the vmemmap array was brought up several times,
but that would imply fragmenting memory over time.

All in all seems to be overly complicated (I might be wrong).


> Huge pages would never get placed onto ZONE_MOVABLE/CMA and cannot be
> migrated. The problem I describe would apply (careful with using
> ZONE_MOVABLE), but well, it can at least be documented.

I am not a page allocator expert but cannot the allocation fallback
to ZONE_MOVABLE under memory shortage on other zones?


-- 
Oscar Salvador
SUSE L3
