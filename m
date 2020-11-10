Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAA92ACFC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 07:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgKJGdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 01:33:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:53490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgKJGda (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:33:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6E1EEABCC;
        Tue, 10 Nov 2020 06:33:29 +0000 (UTC)
Date:   Tue, 10 Nov 2020 07:33:25 +0100
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
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v3 05/21] mm/hugetlb: Introduce pgtable
 allocation/freeing helpers
Message-ID: <20201110063325.GA4286@localhost.localdomain>
References: <CAMZfGtVm9buFPscDVn5F5nUE=Yq+y4NoL0ci74=hUyjaLAPQQg@mail.gmail.com>
 <20201110054250.GA2906@localhost.localdomain>
 <CAMZfGtWbGETq=3b5i0aentemXkZn2J2DNWu05mBs=4L8bJm1jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtWbGETq=3b5i0aentemXkZn2J2DNWu05mBs=4L8bJm1jg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 02:08:46PM +0800, Muchun Song wrote:
> The check should be added here.
> 
>            if (!pgtable)
>                    return NULL;
> 
> Just like my previous v2 patch does. In this case, we can drop those
> checks. What do you think?

It is too early for me, so bear with me.

page_huge_pte will only return NULL in case we did not get to preallocate
any pgtable right?

What I was talimg about is that 
> 
> >         page_huge_pte(page) = list_first_entry_or_null(&pgtable->lru,
> >                                                        struct page, lru);

here we will get the either a pgtable entry or NULL in case we already consumed
all entries from the list.
If that is the case, we can return NULL and let the caller known that we
are done.

Am I missing anything?


-- 
Oscar Salvador
SUSE L3
