Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4827D2A0984
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 16:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgJ3PU3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 11:20:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:34002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbgJ3PUB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:20:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604071168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zv/iNs6u+OAVTN6Z3tpw+QZN/vz+QgMEfXWWRVkKQ6E=;
        b=R+UUfoG/3XkhueB/gzlPBD52A8W9HKac1+wTtnDPhRinOG85/Dxhy8JHQSqRIPITisYifO
        CMreeeSXvfAyLRjbnpYQWZoD/bW6C5a4R0M9OcV6arcpIyHMTHodeECwMjyZQRoqHy/ttf
        +650j7jJ5z99FuNB3awlOy6N38PfsgU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 53630AE2C;
        Fri, 30 Oct 2020 15:19:28 +0000 (UTC)
Date:   Fri, 30 Oct 2020 16:19:26 +0100
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
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v2 00/19] Free some vmemmap pages of
 hugetlb page
Message-ID: <20201030151926.GL1478@dhcp22.suse.cz>
References: <20201026145114.59424-1-songmuchun@bytedance.com>
 <20201030091445.GF1478@dhcp22.suse.cz>
 <CAMZfGtUoEeJTBYwxYjWJEreHefcO81WhhnvRO7vTb_k+zPCHrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtUoEeJTBYwxYjWJEreHefcO81WhhnvRO7vTb_k+zPCHrg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 30-10-20 18:24:25, Muchun Song wrote:
> On Fri, Oct 30, 2020 at 5:14 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 26-10-20 22:50:55, Muchun Song wrote:
> > > If we uses the 1G hugetlbpage, we can save 4095 pages. This is a very
> > > substantial gain. On our server, run some SPDK/QEMU applications which
> > > will use 1000GB hugetlbpage. With this feature enabled, we can save
> > > ~16GB(1G hugepage)/~11GB(2MB hugepage) memory.
> > [...]
> > >  15 files changed, 1091 insertions(+), 165 deletions(-)
> > >  create mode 100644 include/linux/bootmem_info.h
> > >  create mode 100644 mm/bootmem_info.c
> >
> > This is a neat idea but the code footprint is really non trivial. To a
> > very tricky code which hugetlb is unfortunately.
> >
> > Saving 1,6% of memory is definitely interesting especially for 1GB pages
> > which tend to be more static and where the savings are more visible.
> >
> > Anyway, I haven't seen any runtime overhead analysis here. What is the
> > price to modify the vmemmap page tables and make them pte rather than
> > pmd based (especially for 2MB hugetlb). Also, how expensive is the
> > vmemmap page tables reconstruction on the freeing path?
> 
> Yeah, I haven't tested the remapping overhead of reserving a hugetlb
> page. I can do that. But the overhead is not on the allocation/freeing of
> each hugetlb page, it is only once when we reserve some hugetlb pages
> through /proc/sys/vm/nr_hugepages. Once the reservation is successful,
> the subsequent allocation, freeing and using are the same as before
> (not patched).

Yes, that is quite clear. Except for the hugetlb overcommit and
migration if the pool is depeleted. Maybe few other cases.

> So I think that the overhead is acceptable.

Having some numbers for a such a large feature is really needed.
-- 
Michal Hocko
SUSE Labs
