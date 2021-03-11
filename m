Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23530336F02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 10:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhCKJja (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 04:39:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:57588 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231826AbhCKJjW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:39:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615455560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hu/Cdr4n+Fu84h51ILPTJCG7x6gjXFjYTqSY3KHqpS0=;
        b=ntsEAuleumNwt6HsDqK9dvf9jZZ+AVd9uXArrgRm8MTdJKc/R/St7o6eZN8YcuiuBG0HzV
        2HpWBpQPfP0pWP+7rJeQ7Tf5D5aVBfg8pwAKhfQ1x2sV2Y6s4uewB0lApg1FaDahSkwlMt
        Vmu4AWUKOJdszdWokf4dquhaaT9xjG0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 550E2AB8C;
        Thu, 11 Mar 2021 09:39:20 +0000 (UTC)
Date:   Thu, 11 Mar 2021 10:39:18 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Subject: Re: [External] Re: [PATCH v18 9/9] mm: hugetlb: optimize the code
 with the help of the compiler
Message-ID: <YEnlRlLJD1bK/Dup@dhcp22.suse.cz>
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-10-songmuchun@bytedance.com>
 <YEjoozshsvKeMAAu@dhcp22.suse.cz>
 <CAMZfGtV1Fp1RiQ64c9RrMmZ+=EwjGRHjwL8Wx3Q0YRWbbKF6xg@mail.gmail.com>
 <YEnbBPviwU6N2RzK@dhcp22.suse.cz>
 <CAMZfGtW5uHYiA_1an3W-jEmemsoN3Org7JwieeE2V271wh9X-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtW5uHYiA_1an3W-jEmemsoN3Org7JwieeE2V271wh9X-A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 11-03-21 17:08:34, Muchun Song wrote:
> On Thu, Mar 11, 2021 at 4:55 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 11-03-21 15:33:20, Muchun Song wrote:
> > > On Wed, Mar 10, 2021 at 11:41 PM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Mon 08-03-21 18:28:07, Muchun Song wrote:
> > > > > When the "struct page size" crosses page boundaries we cannot
> > > > > make use of this feature. Let free_vmemmap_pages_per_hpage()
> > > > > return zero if that is the case, most of the functions can be
> > > > > optimized away.
> > > >
> > > > I am confused. Don't you check for this in early_hugetlb_free_vmemmap_param already?
> > >
> > > Right.
> > >
> > > > Why do we need any runtime checks?
> > >
> > > If the size of the struct page is not power of 2, compiler can think
> > > is_hugetlb_free_vmemmap_enabled() always return false. So
> > > the code snippet of this user can be optimized away.
> > >
> > > E.g.
> > >
> > > if (is_hugetlb_free_vmemmap_enabled())
> > >         /* do something */
> > >
> > > The compiler can drop "/* do something */" directly, because
> > > it knows is_hugetlb_free_vmemmap_enabled() always returns
> > > false.
> >
> > OK, so this is a micro-optimization to generate a better code?
> 
> Right.
> 
> > Is this measurable to warrant more code?
> 
> I have disassembled the code to confirm this behavior.
> I know this is not the hot path. But it actually can decrease
> the code size.

struct page which is not power of 2 is not a common case. Are you sure
it makes sense to micro optimize for an outliar. If you really want to
microptimize then do that for a common case - the feature being
disabled - via static key.
-- 
Michal Hocko
SUSE Labs
