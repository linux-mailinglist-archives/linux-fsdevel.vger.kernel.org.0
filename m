Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802BA341C12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 13:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhCSMQ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 08:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhCSMQf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:16:35 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F46C06175F
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 05:16:35 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id w8so4567218pjf.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 05:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=affLRntRZcInzHgZqXHL31AIW6roXMHiPl+j3xoyydw=;
        b=Wwr3uymKFr1n+YOBEyGZs0UOSJMaYAZ56KTR7KZVL7k18g5qAOBt+YgiJoL8G92Uv7
         t5ZSkP2F51JdFVKcgvsGhdWRS7lBXt+T83x/JmFbldKB7GuiA6oVMRQVllzP+A/nlfkY
         6OcwpsxZjmDLyHA/jJjRsthgxYbLCRaPfUTWLfYy0qtmxHxEYx3++3yEzCHb5ZFIPP1Y
         FpwnGU/AiT/7tJroR5E+LgvNyPu96pkAcyTaIqSrz1CHc4HSrezFYQysVJOjCSLEPuTm
         n4wgQWBO10IbmJMFeSAGIs16rA6lAm7o93XYLQCZp76IUd9q9ZtS/iK9+4fEbZan6bVK
         WWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=affLRntRZcInzHgZqXHL31AIW6roXMHiPl+j3xoyydw=;
        b=QgFiZSWvQ1U7y8WZRxanXDP06l2NEbByrH5A+EAVthIDDWPkXFoefDVHZwzA5AP3oI
         YRRKUQdx8C1uDXJhh5cKiz0D2OHJzRpT9EF2UzB0vdtW5smY8vjPUyUYJYbkcGS5gYFv
         zrgG0jjIUscNz6KAHs0zi9CGgONt3xWrf/wyHekiLogktWShz1uHZ4tCPDBTNkdH57oE
         9oyNM3FbVxBSs1XCq/n3LVE3sESYt6T/BaIN7idBgy62kaLnoY+EcVmnaxUS2rO9Vx1j
         OmgPu7NyFbMoPn2Bnnfd+A6XsqUg1gIKkivJv9w/jrxNuchBFdi6mox8Tg5JVtxO+Wd2
         UYyg==
X-Gm-Message-State: AOAM531DcEfxOj9kjK1Fw5PM0j5CmMI49ujP3ZJvTIoGeAA8Qd8e9tyU
        avdSupM5M6LMf6KXv/kxbpzqGtsu4/Wv/amrzQHrag==
X-Google-Smtp-Source: ABdhPJwrqbdyuQfn4t1x4h3FwSP0uWjg3FdAAnwpfMkicRuHl1UB8RVx3Ukwq3U6YKkcOX2CFsmx8BMA4NisJmIyh6E=
X-Received: by 2002:a17:90a:d991:: with SMTP id d17mr9339151pjv.229.1616156194913;
 Fri, 19 Mar 2021 05:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210315092015.35396-1-songmuchun@bytedance.com>
 <20210315092015.35396-8-songmuchun@bytedance.com> <20210319085948.GA5695@linux>
In-Reply-To: <20210319085948.GA5695@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 19 Mar 2021 20:15:58 +0800
Message-ID: <CAMZfGtXAgcJQp59AVuieqLT+1Qb3RGQmFK-SGNZH-T6K83Y=HQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v19 7/8] mm: hugetlb: add a kernel
 parameter hugetlb_free_vmemmap
To:     Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        X86 ML <x86@kernel.org>, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 19, 2021 at 4:59 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Mon, Mar 15, 2021 at 05:20:14PM +0800, Muchun Song wrote:
> > --- a/arch/x86/mm/init_64.c
> > +++ b/arch/x86/mm/init_64.c
> > @@ -34,6 +34,7 @@
> >  #include <linux/gfp.h>
> >  #include <linux/kcore.h>
> >  #include <linux/bootmem_info.h>
> > +#include <linux/hugetlb.h>
> >
> >  #include <asm/processor.h>
> >  #include <asm/bios_ebda.h>
> > @@ -1557,7 +1558,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
> >  {
> >       int err;
> >
> > -     if (end - start < PAGES_PER_SECTION * sizeof(struct page))
> > +     if ((is_hugetlb_free_vmemmap_enabled()  && !altmap) ||
> > +         end - start < PAGES_PER_SECTION * sizeof(struct page))
> >               err = vmemmap_populate_basepages(start, end, node, NULL);
> >       else if (boot_cpu_has(X86_FEATURE_PSE))
> >               err = vmemmap_populate_hugepages(start, end, node, altmap);
>
> I've been thinking about this some more.
>
> Assume you opt-in the hugetlb-vmemmap feature, and assume you pass a valid altmap
> to vmemmap_populate.
> This will lead to use populating the vmemmap array with hugepages.

Right.

>
> What if then, a HugeTLB gets allocated and falls within that memory range (backed
> by hugetpages)?

I am not sure whether we can allocate the HugeTLB pages from there.
Will only device memory pass a valid altmap parameter to
vmemmap_populate()? If yes, can we allocate HugeTLB pages from
device memory? Sorry, I am not an expert on this.


> AFAIK, this will get us in trouble as currently the code can only operate on memory
> backed by PAGE_SIZE pages, right?
>
> I cannot remember, but I do not think nothing prevents that from happening?
> Am I missing anything?

Maybe David H is more familiar with this.

Hi David,

Do you have some suggestions on this?

Thanks.


>
> --
> Oscar Salvador
> SUSE L3
