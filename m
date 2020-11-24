Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A96B2C26EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387963AbgKXNOk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:14:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:38082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387878AbgKXNOj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:14:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606223677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HqT93hPnj0lZKcD5jf1u3wzpiTA2s4b6ubLt/KHbxM8=;
        b=Pc/Opv3aa3WAuV7rrBCPOrdnlDjYA+E02bHsIe2iDUefcYRCH3QKFA3INs1m1E2VAPmWPE
        gXPJqsGzDZgiR1xyfkGlCbkWPTYhfAvLkopDie6KOSc5TSbB6K667GlWC+e5/P8E+eYnx3
        VTkZ4ROgmeNsTrcATunjXRl0UTG+JK8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 96937AC2D;
        Tue, 24 Nov 2020 13:14:37 +0000 (UTC)
Date:   Tue, 24 Nov 2020 14:14:36 +0100
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
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v6 09/16] mm/hugetlb: Defer freeing of
 HugeTLB pages
Message-ID: <20201124131436.GX27488@dhcp22.suse.cz>
References: <20201124095259.58755-1-songmuchun@bytedance.com>
 <20201124095259.58755-10-songmuchun@bytedance.com>
 <20201124115109.GW27488@dhcp22.suse.cz>
 <CAMZfGtV=_=f-AybncRDxyp9FB3e499RuPCz5B-8R2Or7285MrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtV=_=f-AybncRDxyp9FB3e499RuPCz5B-8R2Or7285MrQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 24-11-20 20:45:30, Muchun Song wrote:
> On Tue, Nov 24, 2020 at 7:51 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 24-11-20 17:52:52, Muchun Song wrote:
> > > In the subsequent patch, we will allocate the vmemmap pages when free
> > > HugeTLB pages. But update_and_free_page() is called from a non-task
> > > context(and hold hugetlb_lock), so we can defer the actual freeing in
> > > a workqueue to prevent use GFP_ATOMIC to allocate the vmemmap pages.
> >
> > This has been brought up earlier without any satisfying answer. Do we
> > really have bother with the freeing from the pool and reconstructing the
> > vmemmap page tables? Do existing usecases really require such a dynamic
> > behavior? In other words, wouldn't it be much simpler to allow to use
> 
> If someone wants to free a HugeTLB page, there is no way to do that if we
> do not allow this behavior.

Right. The question is how much that matters for the _initial_ feature
submission. Is this restriction so important that it would render it
unsuable?

> When do we need this? On our server, we will
> allocate a lot of HugeTLB pages for SPDK or virtualization. Sometimes,
> we want to debug some issues and want to apt install some debug tools,
> but if the host has little memory and the install operation can be failed
> because of no memory. In this time, we can try to free some HugeTLB
> pages to buddy in order to continue debugging. So maybe we need this.

Or maybe you can still allocate hugetlb pages for debugging in runtime
and try to free those when you need to.

> > hugetlb pages with sparse vmemmaps only for the boot time reservations
> > and never allow them to be freed back to the allocator. This is pretty
> > restrictive, no question about that, but it would drop quite some code
> 
> Yeah, if we do not allow freeing the HugeTLB page to buddy, it actually
> can drop some code. But I think that it only drop this one and next one
> patch. It seems not a lot. And if we drop this patch, we need to add some
> another code to do the boot time reservations and other code to disallow
> freeing HugeTLB pages.

you need a per hugetlb page flag to note the sparse vmemmap anyway so
the freeing path should be a trivial check for the flag. Early boot
reservation. Special casing for the early boot reservation shouldn't be
that hard either. But I haven't checked closely.

> So why not support freeing now.

Because it adds some non trivial challenges which would be better to
deal with with a stable and tested and feature limited implementation.
The most obvious one is the problem with vmemmap allocations when
freeing hugetlb page. Others like vmemmap manipulation is quite some
code but no surprises. Btw. that should be implemented in vmemmap proper
and ready for other potential users. But this is a minor detail.

-- 
Michal Hocko
SUSE Labs
