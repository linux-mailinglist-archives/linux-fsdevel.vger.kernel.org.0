Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7441C321313
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 10:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhBVJ0z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 04:26:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:59220 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230218AbhBVJ0O (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:26:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613985927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UahR2KSk7VlBZc3dTRORhVfUx0fNuikYUhL9eaPGX7U=;
        b=fdt1pIsDWxpYh/9cEIqlC5GwlO0EdIF1ZtDcVKC44TP72vfj4m7lrgFpLv0Z188/YoB8XD
        xzzyjQZQKyXvUjBhUPQBCOw6LHVFSs0URwuGj7QClp1QfzHFcQE5RGLVinrSWgPT9F9oZA
        ef3B0M0lGkb4nF24pGHRdCEoARo9HFw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7EFEDACCF;
        Mon, 22 Feb 2021 09:25:27 +0000 (UTC)
Date:   Mon, 22 Feb 2021 10:25:26 +0100
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
Subject: Re: [External] Re: [PATCH v16 4/9] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
Message-ID: <YDN4hhhINcn69CeV@dhcp22.suse.cz>
References: <20210219104954.67390-1-songmuchun@bytedance.com>
 <20210219104954.67390-5-songmuchun@bytedance.com>
 <YC/HRTq1MRaDWn7O@dhcp22.suse.cz>
 <CAMZfGtW-j=WizTckEWZNB2OSPkz662Vjr79Fb0he9tMD+bnT3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtW-j=WizTckEWZNB2OSPkz662Vjr79Fb0he9tMD+bnT3Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 20-02-21 12:20:36, Muchun Song wrote:
> On Fri, Feb 19, 2021 at 10:12 PM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > What about hugetlb page poisoning on HW failure (resp. soft offlining)?
> 
> If the HW poisoned hugetlb page failed to be dissolved, the page
> will go back to the free list with PG_HWPoison set. But the page
> will not be used, because we will check whether the page is HW
> poisoned when it is dequeued from the free list. If so, we will skip
> this page.

Can this lead to an underprovisioned pool then? Or is there a new
hugetlb allocated to replace the poisoned one?

-- 
Michal Hocko
SUSE Labs
