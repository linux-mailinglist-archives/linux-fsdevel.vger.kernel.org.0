Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3206831E769
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 09:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhBRIZ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 03:25:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:46448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230353AbhBRIXG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:23:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613636495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iy07AOSgNqm+R91SC7oREQlpbXz4qmRIVGZCrE6AhuY=;
        b=ExfopU0B8BLib5q2xKI/qzE1ZkLkoWTD+4+HXnhga/CtFgYKnD2gf2so3fkfp09ilqNHrL
        5SyVNbfeNbiEqeFxLV5tylw3Gm2F8zeMVaDF/44uq4kFZxea1Kc3lYkfQz6kKsgi/rsL8o
        Nf5I1WEP01gCovDHsswXFOx3/8XyyIc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E45B3AFC1;
        Thu, 18 Feb 2021 08:21:34 +0000 (UTC)
Date:   Thu, 18 Feb 2021 09:21:31 +0100
From:   Michal Hocko <mhocko@suse.com>
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
Message-ID: <YC4ji+pMhtOs+KVM@dhcp22.suse.cz>
References: <CAMZfGtWT8CJ-QpVofB2X-+R7GE7sMa40eiAJm6PyD0ji=FzBYQ@mail.gmail.com>
 <YCpmlGuoTakPJs1u@dhcp22.suse.cz>
 <CAMZfGtWd_ZaXtiEdMKhpnAHDw5CTm-CSPSXW+GfKhyX5qQK=Og@mail.gmail.com>
 <YCp04NVBZpZZ5k7G@dhcp22.suse.cz>
 <CAMZfGtV8-yJa_eGYtSXc0YY8KhYpgUo=pfj6TZ9zMo8fbz8nWA@mail.gmail.com>
 <YCqhDZ0EAgvCz+wX@dhcp22.suse.cz>
 <29cdbd0f-dbc2-1a72-15b7-55f81000fa9e@oracle.com>
 <YCzQJIeI+dj9vphw@dhcp22.suse.cz>
 <f956c39a-6043-6d0e-9f4c-6013f54c2768@oracle.com>
 <CAMZfGtWVSWN0dL+2Dm=7bPSNFyomTQYEijCdd_ThXvArsA04ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtWVSWN0dL+2Dm=7bPSNFyomTQYEijCdd_ThXvArsA04ug@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 18-02-21 11:20:51, Muchun Song wrote:
> On Thu, Feb 18, 2021 at 9:00 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 2/17/21 12:13 AM, Michal Hocko wrote:
> > > On Tue 16-02-21 11:44:34, Mike Kravetz wrote:
> > > [...]
> > >> If we are not going to do the allocations under the lock, then we will need
> > >> to either preallocate or take the workqueue approach.
> > >
> > > We can still drop the lock temporarily right? As we already do before
> > > calling destroy_compound_gigantic_page...
> > >
> >
> > Yes we can.  I forgot about that.
> >
> > Actually, very little of what update_and_free_page does needs to be done
> > under the lock.  Perhaps, just decrementing the global count and clearing
> > the destructor so PageHuge() is no longer true.
> 
> Right. I have another question about using GFP flags. Michal
> suggested using GFP_KERNEL instead of GFP_ATOMIC to
> save reserve memory. From your last email, you suggested
> using non-blocking allocation GFP flags (perhaps GFP_NOWAIT).
> 
> Hi Mike and Michal,
> 
> What is the consensus we finally reached? Thanks.

If the lock can be dropped and you make sure the final put on page is
not called from an atomic context then use (for starter)
GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE. I have intentionaly dropped
__GFP_NOWARN because likely want to hear about the failure so that we
can evaluate how often this happens.

This would be my recommendation.
-- 
Michal Hocko
SUSE Labs
