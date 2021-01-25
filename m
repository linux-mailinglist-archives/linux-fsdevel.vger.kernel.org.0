Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC9E3049AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 21:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732590AbhAZFYf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbhAYMkh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:40:37 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD31C061788
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 04:31:09 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b8so7476839plh.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 04:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QW8QHydhaLv2kCU+6eTvr2welYmg+FLV/r+/koJuoLk=;
        b=xjDsgoFJfGSx+QNEJsDoPpI6efmJI7cXx1rArOBkvxtD5CI8yASxFFYDVnqLbfElBp
         aLK4FtgR+15ZVnswDysdST3r8KI85QituFeOZJYVdcr8YztK0VXzUEZS8kWbBK1bHUoP
         S305pTMQi8NXQ4QW/MLiaG+nkJK0HgJb0gd7hWR+K0hSfaOpDfCx4XKA/wSM6NKSJX6N
         7BWmQaIN1x1BQ+m9UeMPWDTk+2eY7wqW6BGtJsdjC1Mpl6p4DL+hgAo3reOxHMiQK9Ij
         Guuma2LpY+FkUSohEtdd9l3WTiP6AWVR4A2xM/CNxhjGd6u94DEW8dTpSSE4V818Ey53
         xtiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QW8QHydhaLv2kCU+6eTvr2welYmg+FLV/r+/koJuoLk=;
        b=ppgyWcyMVDBzUfNH07EK1mXftszifT/qfj9nV3Kqw5FcB89vzK+y611L4wM7Cfb3C0
         T+CYZ0dLFjKmO7+wL/pAkNIF4E78gH2DpGSp1ltUJH6BoDQKyK8Yz3FQqMl5RdwYK4s+
         RFm7QLZWEtbvh45dkK3JnflCRnLn4yAkTQusCa1nMmxynwrVdE6SnUB4nkF3FHpWgRkI
         M3OS3wb91nFl2PIY0aGCxvk3fwYBXJ2RCIg/xNOT6WYDNBYct/X9KgHNjBpqNpXe7Jic
         6zlpF72byFTxUMgP0Bk4XX5j2ULdWGsw1t9wMp3Z4nNSlFb1Pul/GwvnFufimJBVEXbj
         +F3w==
X-Gm-Message-State: AOAM531Z5dwESqcCcz4QdMr3mbi5VGV2uUK12JU4PJETcNzTC/BLUELT
        dnvc0ELpfzf2qTnzHJKu1fL1+KcYg9l+LUdVcA4E3w==
X-Google-Smtp-Source: ABdhPJyY+tByzJR/2m5cQEXW38XAGhEuuitjV3/Wk3nuW0Q0nL5BLsXF/owMsdW62WXyPcjcnj/9dBD1hUwTOTMdINg=
X-Received: by 2002:a17:90a:3e81:: with SMTP id k1mr179973pjc.13.1611577869029;
 Mon, 25 Jan 2021 04:31:09 -0800 (PST)
MIME-Version: 1.0
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-10-songmuchun@bytedance.com> <7550ebba-fdb5-0dc9-a517-dda56bd105d9@redhat.com>
In-Reply-To: <7550ebba-fdb5-0dc9-a517-dda56bd105d9@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 25 Jan 2021 20:30:32 +0800
Message-ID: <CAMZfGtVX4HPNgvcdbAoEoi8uYtwc=kbk0ryuGm83dH3BPQ1sFQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v13 09/12] mm: hugetlb: add a kernel
 parameter hugetlb_free_vmemmap
To:     David Hildenbrand <david@redhat.com>
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
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 7:43 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 17.01.21 16:10, Muchun Song wrote:
> > Add a kernel parameter hugetlb_free_vmemmap to enable the feature of
> > freeing unused vmemmap pages associated with each hugetlb page on boot.
>
> The description completely lacks a description of the changes performed
> in arch/x86/mm/init_64.c.

Will update. Thanks.

>
> [...]
>
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
> > +     if (is_hugetlb_free_vmemmap_enabled() ||
> > +         end - start < PAGES_PER_SECTION * sizeof(struct page))
>
> This looks irresponsible. You ignore any altmap, even though current
> altmap users (ZONE_DEVICE) will not actually result in applicable
> vmemmaps that huge pages could ever use.
>
> Why do you ignore the altmap completely? This has to be properly
> documented, but IMHO it's not even the right approach to mess with
> altmap here.

Thanks for reminding me of this. Sorry I also did not notice that.

>
> --
> Thanks,
>
> David / dhildenb
>
