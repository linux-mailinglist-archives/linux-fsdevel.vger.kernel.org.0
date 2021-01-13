Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA582F476D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 10:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbhAMJVP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 04:21:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:45218 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbhAMJVO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 04:21:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8F350ACF5;
        Wed, 13 Jan 2021 09:20:32 +0000 (UTC)
Date:   Wed, 13 Jan 2021 10:20:28 +0100
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
Message-ID: <20210113092028.GB24816@linux>
References: <20210106141931.73931-1-songmuchun@bytedance.com>
 <20210106141931.73931-5-songmuchun@bytedance.com>
 <20210112080453.GA10895@linux>
 <CAMZfGtUqN2BZH28i9VJhRJ3VH3OGKBQ7hDUuX1-F5LcwbKk+4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtUqN2BZH28i9VJhRJ3VH3OGKBQ7hDUuX1-F5LcwbKk+4A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 07:33:33PM +0800, Muchun Song wrote:
> > It seems a bit odd to only pass "start" for the BUG_ON.
> > Also, I kind of dislike the "addr += PAGE_SIZE" in vmemmap_pte_range.
> >
> > I wonder if adding a ".remap_start_addr" would make more sense.
> > And adding it here with the vmemmap_remap_walk init.
> 
> How about introducing a new function which aims to get the reuse
> page? In this case, we can drop the BUG_ON() and "addr += PAGE_SIZE"
> which is in vmemmap_pte_range. The vmemmap_remap_range only
> does the remapping.

How would that look? 
It might be good, dunno, but the point is, we should try to make the rules as
simple as possible, dropping weird assumptions.

Callers of vmemmap_remap_free should know three things:

- Range to be remapped
- Addr to remap to
- Current implemantion needs addr to be remap to to be part of the complete
  range

right?

-- 
Oscar Salvador
SUSE L3
