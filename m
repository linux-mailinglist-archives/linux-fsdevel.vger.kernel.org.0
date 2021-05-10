Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5084B378397
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 12:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhEJKqo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 06:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhEJKop (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 06:44:45 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F2CC061358
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 03:34:16 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id v191so13284484pfc.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 03:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GbEg5B1XI9iNST/E/f70TSfKy/dyLBSsJanb6FiDxic=;
        b=f59ner0D/1qo5HyqTZPlnjeQGdv7ehb8TdlVTo883tA/MXBcSAIscvH2kflRetliLC
         2ldbA4AOnMUr/99l1qryK6AOVgMBHunKzEHL/8Dh1NDK9SueoJw/qeG8RdHl2Op/gzox
         L5wdoQkSdijVZGPr49AJgJ7z3J1DewJWUEkdLff0xSkZZwvITSznBNxdWJFuwOygvU5Y
         J2dLOxY4NbqekqowGzzndqj7IrRuz4/t+O3heK9u1Xzeb2rJBWbSG9sTkueoQ+GzrKWl
         dN7rmghZQrBAgGrUeDTAIEJ1MJjXNtmUAmttQKTKQH1rrqCmJdnTbJGYurasAK/zkqwo
         ykIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GbEg5B1XI9iNST/E/f70TSfKy/dyLBSsJanb6FiDxic=;
        b=GZ9fJjaVxnMpc6Hd2adnKyIrj1whQ5Yy+DLtXSwDHbRpz5d44d1WUQBb/z5KMHV2iV
         fuX0eyvkmV4PQgLojyYDqFlMCTvl1I8Bx2DwbzstbFHpk1gTP+hKfiqsUeRzajPS0FND
         dbvl/1+701AT28s5AGBGtIrlz0N0O9kZQC8QQVFVY4tlDqKpALg9yLyJBedAjtXbt2I0
         RNjwmm7nwb+hXcaG6c28jD4Tb78JcxOO1ynpmB72qxkG0Ma7p8N5T3ZlBQsA3E+zv6gV
         36aUnoIpPnXN/G/OuDxMIF/NgLMQqBLT4j4bh/ZbvV+NtvCmjPmpg8ZgNeD8L4xcMVjm
         YrvA==
X-Gm-Message-State: AOAM5324S8E75sqa094pzImGEa77veg98TnzeJXWD1jiWUB4WSxWN3+F
        bh1REy1lSK0L2QgreOzqr5SY3kSeRvHq/zlxSDDNjQ==
X-Google-Smtp-Source: ABdhPJyHUEien5qCpH7v1ah8orxYfkawudbsyoFQsZ5IuBkIgJ3pV0ZZhlDNcBUrx9QSpxHHGhQ+bS4LMxBGt3jpl1s=
X-Received: by 2002:a63:b206:: with SMTP id x6mr11623323pge.341.1620642855648;
 Mon, 10 May 2021 03:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210510030027.56044-1-songmuchun@bytedance.com>
 <20210510030027.56044-9-songmuchun@bytedance.com> <20210510100809.GA22664@linux>
In-Reply-To: <20210510100809.GA22664@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 10 May 2021 18:33:38 +0800
Message-ID: <CAMZfGtVzwA+35az8ARxzVmTnt=pGObJvG=a23_2_7TVptmzN1g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v23 8/9] mm: memory_hotplug: disable
 memmap_on_memory when hugetlb_free_vmemmap enabled
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        X86 ML <x86@kernel.org>, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 10, 2021 at 6:08 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Mon, May 10, 2021 at 11:00:26AM +0800, Muchun Song wrote:
> > diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> > index 8cc195c4c861..0d7f595ee441 100644
> > --- a/drivers/acpi/acpi_memhotplug.c
> > +++ b/drivers/acpi/acpi_memhotplug.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/acpi.h>
> >  #include <linux/memory.h>
> >  #include <linux/memory_hotplug.h>
> > +#include <linux/hugetlb.h>
> >
> >  #include "internal.h"
>
> Uhm, I am confused.
> Why do we need this here? AFAICS, we do not.
>
> The function is in memory_hotplug.c, and that alrady has that include.
> What am I missing?

You are right. That include is redundant. I will remove it
from acpi_memhotplug.c. Thanks Oscar.

>
>
> --
> Oscar Salvador
> SUSE L3
