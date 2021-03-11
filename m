Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3EC336E51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 09:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhCKIzj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 03:55:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:39160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231440AbhCKIze (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 03:55:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615452933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2w5ANi1macvYiB3pDe4T+IEha3dZ9yAJ5puO2kAQ6Ro=;
        b=lo3a+pfMdhV6Wh7ucDBmOJEKVOFP3mbkP+QeNwaDcBq24Zk7acF4BUqNrSU+sJNsY9aZJJ
        UBHU3squ8fz7EZKVUakckTKgd8ForrzC68n1aAr3YS/65BdLXj7+Q9kzJYzrLJ6pfjTvwK
        aH4yPIpb/Q1IneABSwpG9SWq6v1KTpo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C0646AC16;
        Thu, 11 Mar 2021 08:55:32 +0000 (UTC)
Date:   Thu, 11 Mar 2021 09:55:32 +0100
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
Message-ID: <YEnbBPviwU6N2RzK@dhcp22.suse.cz>
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-10-songmuchun@bytedance.com>
 <YEjoozshsvKeMAAu@dhcp22.suse.cz>
 <CAMZfGtV1Fp1RiQ64c9RrMmZ+=EwjGRHjwL8Wx3Q0YRWbbKF6xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtV1Fp1RiQ64c9RrMmZ+=EwjGRHjwL8Wx3Q0YRWbbKF6xg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 11-03-21 15:33:20, Muchun Song wrote:
> On Wed, Mar 10, 2021 at 11:41 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 08-03-21 18:28:07, Muchun Song wrote:
> > > When the "struct page size" crosses page boundaries we cannot
> > > make use of this feature. Let free_vmemmap_pages_per_hpage()
> > > return zero if that is the case, most of the functions can be
> > > optimized away.
> >
> > I am confused. Don't you check for this in early_hugetlb_free_vmemmap_param already?
> 
> Right.
> 
> > Why do we need any runtime checks?
> 
> If the size of the struct page is not power of 2, compiler can think
> is_hugetlb_free_vmemmap_enabled() always return false. So
> the code snippet of this user can be optimized away.
> 
> E.g.
> 
> if (is_hugetlb_free_vmemmap_enabled())
>         /* do something */
> 
> The compiler can drop "/* do something */" directly, because
> it knows is_hugetlb_free_vmemmap_enabled() always returns
> false.

OK, so this is a micro-optimization to generate a better code?
Is this measurable to warrant more code?
-- 
Michal Hocko
SUSE Labs
