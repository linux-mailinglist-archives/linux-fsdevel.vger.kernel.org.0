Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF62B31C21C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 20:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhBOTEA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 14:04:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:43338 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229908AbhBOTD6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:03:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613415792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+fd7ihZjbhcZ8UUvdOazTdIjmKtVbqj7x1WqiHSTYpo=;
        b=PWlJyJF9epJo/+kqbywJfNJKobXG+JhtYEtY1HliEUOiac+chaXYl2jiGSBLMu7eV4qsCa
        oxm2AsOwKtBTAcXzOj2fFapPWffqp3ihTo3iFgaLcpwm1sYA2IAjf/3Fc8imYtbLQekL7R
        CF282g/eNl+JimV7h/fWNdWrWJpxnGY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DBB47ACD4;
        Mon, 15 Feb 2021 19:03:11 +0000 (UTC)
Date:   Mon, 15 Feb 2021 20:02:59 +0100
From:   Michal Hocko <mhocko@suse.com>
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
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v15 4/8] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
Message-ID: <YCrFY4ODu/O9KSND@dhcp22.suse.cz>
References: <CAMZfGtXgVUvCejpxu1o5WDvmQ7S88rWqGi3DAGM6j5NHJgtdcg@mail.gmail.com>
 <YCpN38i75olgispI@dhcp22.suse.cz>
 <CAMZfGtUXJTaMo36aB4nTFuYFy3qfWW69o=4uUo-FjocO8obDgw@mail.gmail.com>
 <CAMZfGtWT8CJ-QpVofB2X-+R7GE7sMa40eiAJm6PyD0ji=FzBYQ@mail.gmail.com>
 <YCpmlGuoTakPJs1u@dhcp22.suse.cz>
 <CAMZfGtWd_ZaXtiEdMKhpnAHDw5CTm-CSPSXW+GfKhyX5qQK=Og@mail.gmail.com>
 <YCp04NVBZpZZ5k7G@dhcp22.suse.cz>
 <CAMZfGtV8-yJa_eGYtSXc0YY8KhYpgUo=pfj6TZ9zMo8fbz8nWA@mail.gmail.com>
 <YCqhDZ0EAgvCz+wX@dhcp22.suse.cz>
 <CAMZfGtW6n_YUbZOPFbivzn-HP4Q2yi0DrUoQ3JAjSYy5m17VWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtW6n_YUbZOPFbivzn-HP4Q2yi0DrUoQ3JAjSYy5m17VWw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 16-02-21 01:48:29, Muchun Song wrote:
> On Tue, Feb 16, 2021 at 12:28 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 15-02-21 23:36:49, Muchun Song wrote:
> > [...]
> > > > There shouldn't be any real reason why the memory allocation for
> > > > vmemmaps, or handling vmemmap in general, has to be done from within the
> > > > hugetlb lock and therefore requiring a non-sleeping semantic. All that
> > > > can be deferred to a more relaxed context. If you want to make a
> > >
> > > Yeah, you are right. We can put the freeing hugetlb routine to a
> > > workqueue. Just like I do in the previous version (before v13) patch.
> > > I will pick up these patches.
> >
> > I haven't seen your v13 and I will unlikely have time to revisit that
> > version. I just wanted to point out that the actual allocation doesn't
> > have to happen from under the spinlock. There are multiple ways to go
> > around that. Dropping the lock would be one of them. Preallocation
> > before the spin lock is taken is another. WQ is certainly an option but
> > I would take it as the last resort when other paths are not feasible.
> >
> 
> "Dropping the lock" and "Preallocation before the spin lock" can limit
> the context of put_page to non-atomic context. I am not sure if there
> is a page puted somewhere under an atomic context. e.g. compaction.
> I am not an expert on this.

Then do a due research or ask for a help from the MM community. Do
not just try to go around harder problems and somehow duct tape a
solution. I am sorry for sounding harsh here but this is a repetitive
pattern.

Now to the merit. put_page can indeed be called from all sorts of
contexts. And it might be indeed impossible to guarantee that hugetlb
pages are never freed up from an atomic context. Requiring that would be
even hard to maintain longterm. There are ways around that, I believe,
though.

The most simple one that I can think of right now would be using
in_atomic() rather than in_task() check free_huge_page. IIRC recent
changes would allow in_atomic to be reliable also on !PREEMPT kernels
(via RCU tree, not sure where this stands right now). That would make
__free_huge_page always run in a non-atomic context which sounds like an
easy enough solution.
Another way would be to keep a pool of ready pages to use in case of
GFP_NOWAIT allocation fails and have means to keep that pool replenished
when needed. Would it be feasible to reused parts of the freed page in
the worst case?

-- 
Michal Hocko
SUSE Labs
