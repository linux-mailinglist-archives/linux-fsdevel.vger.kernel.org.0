Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FACD2A9320
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 10:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgKFJqy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 04:46:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:57546 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgKFJqx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:46:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EDCFEAC35;
        Fri,  6 Nov 2020 09:46:51 +0000 (UTC)
Date:   Fri, 6 Nov 2020 10:46:48 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v2 05/19] mm/hugetlb: Introduce pgtable
 allocation/freeing helpers
Message-ID: <20201106094643.GA15654@linux>
References: <20201026145114.59424-1-songmuchun@bytedance.com>
 <20201026145114.59424-6-songmuchun@bytedance.com>
 <20201105132337.GA7552@linux>
 <CAMZfGtXwKJ3uCuNC3mxHQLNJqTcUzj7Gd2-JRuOWEjZ1C7Oh=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtXwKJ3uCuNC3mxHQLNJqTcUzj7Gd2-JRuOWEjZ1C7Oh=A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 06, 2020 at 12:08:22AM +0800, Muchun Song wrote:
> > I do not think you need this.
> > We already have hugepages_supported().
> 
> Maybe some architectures support hugepage, but the vmemmap do not
> use the hugepage map. In  this case, we need it. But I am not sure if it
> exists in the real world. At least, x86 can reuse hugepages_supported.

Yes, but that is the point.
IIUC, this patchset will enable HugeTLB vmemmap pages only for x86_64.
Then, let us make the patchset specific to that architecture.

If at some point this grows more users (powerpc, arm, ...), then we
can add the missing code, but for now it makes sense to only include
the bits to make this work on x86_64.

And also according to this the changelog is a bit "misleading".

"On some architectures, the vmemmap areas use huge page mapping.
If we want to free the unused vmemmap pages, we have to split
the huge pmd firstly. So we should pre-allocate pgtable to split
huge pmd."

On x86_64, vmemmap is always PMD mapped if the machine has hugepages
support and if we have 2MB contiguos pages and PMD aligned.
e.g: I have seen cases where after the system has ran for a period
of time hotplug operations were mapping the vmemmap representing
the hot-added range on page base, because we could not find
enough contiguos and aligned memory.

Something that [1] tries to solve:

[1] https://patchwork.kernel.org/project/linux-mm/cover/20201022125835.26396-1-osalvador@suse.de/

But anyway, my point is that let us make it clear in the changelog that
this is aimed for x86_64 at the moment.
Saying "on some architures" might make think people that this is not
x86_64 specific.

>> > > +     vmemmap_pgtable_init(page);
> >
> > Maybe just open code this one?
> 
> Sorry. I don't quite understand what it means. Could you explain?

I meant doing 

page_huge_pte(page) = NULL

But no strong feelings.

-- 
Oscar Salvador
SUSE L3
