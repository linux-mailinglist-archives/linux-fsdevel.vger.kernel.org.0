Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BA93049C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 21:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732533AbhAZFY1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:24:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:55492 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727657AbhAYMKV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:10:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B8AA2ACF4;
        Mon, 25 Jan 2021 12:08:36 +0000 (UTC)
Date:   Mon, 25 Jan 2021 13:08:32 +0100
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
Subject: Re: [PATCH v13 09/12] mm: hugetlb: add a kernel parameter
 hugetlb_free_vmemmap
Message-ID: <20210125120827.GA29289@linux>
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-10-songmuchun@bytedance.com>
 <7550ebba-fdb5-0dc9-a517-dda56bd105d9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7550ebba-fdb5-0dc9-a517-dda56bd105d9@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 12:43:23PM +0100, David Hildenbrand wrote:
> > -	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
> > +	if (is_hugetlb_free_vmemmap_enabled() ||
> > +	    end - start < PAGES_PER_SECTION * sizeof(struct page))
> 
> This looks irresponsible. You ignore any altmap, even though current
> altmap users (ZONE_DEVICE) will not actually result in applicable
> vmemmaps that huge pages could ever use.
> 
> Why do you ignore the altmap completely? This has to be properly
> documented, but IMHO it's not even the right approach to mess with
> altmap here.

The goal was not to ignore altmap but to disable PMD mapping sections
when the feature was enabled.
Shame on me I did not notice that with this, altmap will be ignored.

Something like below maybe:

int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
                struct vmem_altmap *altmap)
{
        int err;
        bool populate_base_pages = false;

        if ((end - start < PAGES_PER_SECTION * sizeof(struct page)) ||
            (is_hugetlb_free_vmemmap_enabled() && !altmap))
                populate_base_pages = true;

        if (populate_base_pages) {
                err = vmemmap_populate_basepages(start, end, node, NULL);
        } else if (boot_cpu_has(X86_FEATURE_PSE)) {
	....


> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
> 

-- 
Oscar Salvador
SUSE L3
