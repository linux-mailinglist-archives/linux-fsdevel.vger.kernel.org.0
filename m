Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17782F608F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 12:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbhANLxf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jan 2021 06:53:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:45704 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbhANLxf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jan 2021 06:53:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2723CB7A5;
        Thu, 14 Jan 2021 11:52:53 +0000 (UTC)
Date:   Thu, 14 Jan 2021 12:52:48 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
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
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v12 04/13] mm/hugetlb: Free the vmemmap
 pages associated with each HugeTLB page
Message-ID: <20210114115248.GA24592@localhost.localdomain>
References: <20210106141931.73931-1-songmuchun@bytedance.com>
 <20210106141931.73931-5-songmuchun@bytedance.com>
 <20210112080453.GA10895@linux>
 <CAMZfGtUqN2BZH28i9VJhRJ3VH3OGKBQ7hDUuX1-F5LcwbKk+4A@mail.gmail.com>
 <20210113092028.GB24816@linux>
 <a9baf18c-22c7-4946-9778-678f6bc808dc@oracle.com>
 <CAMZfGtUhhMDCaZKeayS1+w0MvBijDZC2AiUV4z5rUFrfbXBefw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtUhhMDCaZKeayS1+w0MvBijDZC2AiUV4z5rUFrfbXBefw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 14, 2021 at 06:54:30PM +0800, Muchun Song wrote:
> I think this approach may be only suitable for generic huge page only.
> So we can implement it only for huge page.
> 
> Hi Oscar,
> 
> What's your opinion about this?

I tried something like:

static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
			      unsigned long end,
			      struct vmemmap_remap_walk *walk)
{
	pte_t *pte;

	pte = pte_offset_kernel(pmd, addr);

	if (!walk->reuse_page) {
		BUG_ON(pte_none(*pte));

		walk->reuse_page = pte_page(*pte++);
		addr = walk->remap_start;
	}

	for (; addr != end; addr += PAGE_SIZE, pte++) {
		BUG_ON(pte_none(*pte));

		walk->remap_pte(pte, addr, walk);
	}
}

void vmemmap_remap_free(unsigned long start, unsigned long end,
			unsigned long reuse)
{
	LIST_HEAD(vmemmap_pages);
	struct vmemmap_remap_walk walk = {
		.remap_pte	= vmemmap_remap_pte,
		.reuse_addr	= reuse,
		.remap_start = start,
		.vmemmap_pages	= &vmemmap_pages,
	};

	BUG_ON(start != reuse + PAGE_SIZE);

	vmemmap_remap_range(reuse, end, &walk);
	free_vmemmap_page_list(&vmemmap_pages);
}

but it might overcomplicate things and I am not sure it is any better.
So I am fine with keeping it as is.
Should another user come in the future, we can always revisit.
Maybe just add a little comment in vmemmap_pte_range(), explaining while we
are "+= PAGE_SIZE" for address and I would like to see a comment in 
vmemmap_remap_free why the BUG_ON and more important what it is checking.

-- 
Oscar Salvador
SUSE L3
