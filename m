Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261B3304504
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 18:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390860AbhAZRVK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 12:21:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:58664 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387605AbhAZHtG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 02:49:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CF3AEAD4E;
        Tue, 26 Jan 2021 07:48:24 +0000 (UTC)
Date:   Tue, 26 Jan 2021 08:48:20 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v13 05/12] mm: hugetlb: allocate the
 vmemmap pages associated with each HugeTLB page
Message-ID: <20210126074815.GA8809@linux>
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-6-songmuchun@bytedance.com>
 <6a68fde-583d-b8bb-a2c8-fbe32e03b@google.com>
 <CAMZfGtXpg30RhrPm836S6Tr09ynKRPG=_DXtXt9sVTTponnC-g@mail.gmail.com>
 <CAMZfGtX19x8m+Bkvj+8Ue31m5L_4DmgtZevp2fd++JL7nuSzWw@mail.gmail.com>
 <552e8214-bc6f-8d90-0ed8-b3aff75d0e47@redhat.com>
 <CAMZfGtWK=zBri_zAx=uP_dLv2Kh-2_vfjAyN7XtESwqukg5Eug@mail.gmail.com>
 <b8ef43c1-e4b5-eae2-0cdf-1ce25accc36f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8ef43c1-e4b5-eae2-0cdf-1ce25accc36f@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 03:25:35PM -0800, Mike Kravetz wrote:
> IIUC, even non-gigantic hugetlb pages can exist in CMA.  They can be migrated
> out of CMA if needed (except free pages in the pool, but that is a separate
> issue David H already noted in another thread).

Yeah, as discussed I am taking a look at that.
 
> When we first started discussing this patch set, one suggestion was to force
> hugetlb pool pages to be allocated at boot time and never permit them to be
> freed back to the buddy allocator.  A primary reason for the suggestion was
> to avoid this issue of needing to allocate memory when freeing a hugetlb page
> to buddy.  IMO, that would be an unreasonable restriction for many existing
> hugetlb use cases.

AFAIK it was suggested as a way to simplify things in the first go of this
patchset.
Please note that the first versions of this patchset was dealing with PMD
mapped vmemmap pages and overall it was quite convulated for a first
version.
Since then, things had simplified quite a lot (e.g: we went from 22 patches to 12),
so I do not feel the need to force the pages to be allocated at boot time.

> A simple thought is that we simply fail the 'freeing hugetlb page to buddy'
> if we can not allocate the required vmemmap pages.  However, as David R says
> freeing hugetlb pages to buddy is a reasonable way to free up memory in oom
> situations.  However, failing the operation 'might' be better than looping
> forever trying to allocate the pages needed?  As mentioned in the previous
> patch, it would be better to use GFP_ATOMIC to at least dip into reserves if
> we can.

I also agree that GFP_ATOMIC might make some sense.
If the system is under memory pressure, I think it is best if we go the extra
mile in order to free up to 4096 pages or 512 pages.
Otherwise we might have a nice hugetlb page we might not need and a lack of
memory.

> I think using pages of the hugetlb for vmemmap to cover pages of the hugetlb
> is the only way we can guarantee success of freeing a hugetlb page to buddy.
> However, this should only only be used when there is no other option and could
> result in vmemmap pages residing in CMA or ZONE_MOVABLE.  I'm not sure how
> much better this is than failing the free to buddy operation.

And how would you tell when there is no other option?

> I don't have a solution.  Just wanted to share some thoughts.
> 
> BTW, just thought of something else.  Consider offlining a memory section that
> contains a free hugetlb page.  The offline code will try to disolve the hugetlb
> page (free to buddy).  So, vmemmap pages will need to be allocated.  We will
> try to allocate vmemap pages on the same node as the hugetlb page.  But, if
> this memory section is the last of the node all the pages will have been
> isolated and no allocations will succeed.  Is that a possible scenario, or am
> I just having too many negative thoughts?

IIUC, GFP_ATOMIC will reset ALLOC_CPUSET flags at some point and the nodemask will
be cleared, so I guess the system will try to allocate from another node.
But I am not sure about that one.

I would like to hear Michal's thoughts on this.


-- 
Oscar Salvador
SUSE L3
