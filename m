Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C103238AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 09:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbhBXIdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 03:33:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:44288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232563AbhBXIcj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 03:32:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F39D9AF3E;
        Wed, 24 Feb 2021 08:31:55 +0000 (UTC)
Date:   Wed, 24 Feb 2021 09:31:49 +0100
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
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v16 4/9] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
Message-ID: <20210224083145.GA14894@linux>
References: <20210219104954.67390-1-songmuchun@bytedance.com>
 <20210219104954.67390-5-songmuchun@bytedance.com>
 <13a5363c-6af4-1e1f-9a18-972ca18278b5@oracle.com>
 <20210223092740.GA1998@linux>
 <CAMZfGtVRSBkKe=tKAKLY8dp_hywotq3xL+EJZNjXuSKt3HK3bQ@mail.gmail.com>
 <20210223104957.GA3844@linux>
 <20210223154128.GA21082@localhost.localdomain>
 <20210223223157.GA2740@localhost.localdomain>
 <CAMZfGtUBMzAgPVgm=9wgJg+yytxwSGOK_BVOw93RPLb3_tFS_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtUBMzAgPVgm=9wgJg+yytxwSGOK_BVOw93RPLb3_tFS_g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 24, 2021 at 11:47:49AM +0800, Muchun Song wrote:
> I have been looking at the dequeue_huge_page_node_exact().
> If a PageHWPoison huge page is in the free pool list, the page will
> not be allocated to the user. The PageHWPoison huge page
> will be skip in the dequeue_huge_page_node_exact().

Yes, now I see where the problem lies.

hugetlb_no_page()->..->dequeue_huge_page_node_exact() will fail if the only
page in the pool is hwpoisoned, as expected.
Then alloc_buddy_huge_page_with_mpol() will be tried, but since surplus_huge_pages
counter is stale, we will fail there.
That relates to the problem Mike pointed out, that we should decrease again the
surplus_huge_pages.

I think hwpoisoned pages should not be in the free pool though.
Probably we want to take them off when we notice we have one:
e.g: dequeue_huge_page_node_exact could place the page in another list 
and place it back in case it was unpoisoned.

But anyway, that has nothing to do with this (apart from the surplus problem).

-- 
Oscar Salvador
SUSE L3
