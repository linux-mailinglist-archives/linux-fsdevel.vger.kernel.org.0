Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA693042B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 16:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391313AbhAZPfv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 10:35:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:60418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406329AbhAZPfr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:35:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1D1B8AB92;
        Tue, 26 Jan 2021 15:34:57 +0000 (UTC)
Date:   Tue, 26 Jan 2021 16:34:52 +0100
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
Message-ID: <20210126153448.GA17455@linux>
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-6-songmuchun@bytedance.com>
 <20210126092942.GA10602@linux>
 <6fe52a7e-ebd8-f5ce-1fcd-5ed6896d3797@redhat.com>
 <20210126145819.GB16870@linux>
 <259b9669-0515-01a2-d714-617011f87194@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <259b9669-0515-01a2-d714-617011f87194@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 04:10:53PM +0100, David Hildenbrand wrote:
> The real issue seems to be discarding the vmemmap on any memory that has
> movability constraints - CMA and ZONE_MOVABLE; otherwise, as discussed, we
> can reuse parts of the thingy we're freeing for the vmemmap. Not that it
> would be ideal: that once-a-huge-page thing will never ever be a huge page
> again - but if it helps with OOM in corner cases, sure.

Yes, that is one way, but I am not sure how hard would it be to implement.
Plus the fact that as you pointed out, once that memory is used for vmemmap
array, we cannot use it again.
Actually, we would fragment the memory eventually?

> Possible simplification: don't perform the optimization for now with free
> huge pages residing on ZONE_MOVABLE or CMA. Certainly not perfect: what
> happens when migrating a huge page from ZONE_NORMAL to (ZONE_MOVABLE|CMA)?

But if we do not allow theose pages to be in ZONE_MOVABLE or CMA, there is no
point in migrate them, right?

> > > > Of course, this means that e.g: memory-hotplug (hot-remove) will not fully work
> > > > when this in place, but well.
> > > 
> > > Can you elaborate? Are we're talking about having hugepages in
> > > ZONE_MOVABLE that are not migratable (and/or dissolvable) anymore? Than
> > > a clear NACK from my side.
> > 
> > Pretty much, yeah.
> 
> Note that we most likely soon have to tackle migrating/dissolving (free)
> hugetlbfs pages from alloc_contig_range() context - e.g., for CMA
> allocations. That's certainly something to keep in mind regarding any
> approaches that already break offline_pages().

Definitely. I already talked to Mike about that and I am going to have
a look into it pretty soon.

-- 
Oscar Salvador
SUSE L3
