Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FF32DD4A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 16:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgLQPx3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 10:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgLQPx0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 10:53:26 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EC4C061794
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 07:52:46 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id c22so5156943pgg.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 07:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7OV9R4drFVeTku6dunPe0dURgcLywII3vMyOLzHOjbo=;
        b=yIBLJwwwDEHWJYBXBXaDOCOIOlu1mzIWwwnbbYQQfRQ7LMkU8qv2JkgGg26nogIKSs
         gxn3EeARR2JyL2paSPPTy8ZZOLVboX9eX3dPocdwjayLq4ljEaMz9tUUS7eoFsq61rpO
         vQfCxyF+sy1wilxSU4GP9nCyRGicjzMz1xnoQ5CSZOMcjYmsIGmlIfL59XL6Sj/+js1P
         llf3TuHQXpH+jtwajIkC0hNlgujwNjiNEXG1kNvJwQVxRQj34fRA2bjR1G1wYaPUkZUf
         aD3n/TscPNVA97au0sGrkDHWaARlvnOewXs22G5Iewdj4dM7VdJHL6fzM0jp1uJZ1kDq
         N8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7OV9R4drFVeTku6dunPe0dURgcLywII3vMyOLzHOjbo=;
        b=qTf2ALEpRSHmsOAlWVITzJuWqfMYR9C3/8tCnt5MygZczsGRyILbNGe40tot2L4WAM
         7u1L45g9V1cZk/qY9Epv0xjixK3NWIro8g2IgWnDPe4iwCF3roDC29KYUXUOqrrDB3km
         4BuKlVzgVHVMzQRO7qCrxsu5ZJ7ow3swnqvM8qiiEG73kyVcn3KklBNs9Oft/FB5K6zx
         UiKDpGUTuiy4hbdpMGN1A2TneUe98K+hHg6QREFyEhZk2yxWSrFH6fVamqsy1hO2bHPq
         NHkzGkdL/PGn7syyN6RokKXIk5URJNDIQgoSb15I2eGi5WBFzJwvD4/E4HWb9i1Jh68Z
         2xRQ==
X-Gm-Message-State: AOAM533XE0dTVcta9s1VcGQnFasdiSo/Tpcidx1PQhAkHUWog+4s8kYI
        p0d/LrkD3t4Izy6gtWMUEFZoRTvlZaEScplQbBxkKA==
X-Google-Smtp-Source: ABdhPJyTI/Q5bVzBSZ27aLlJM/iDQhjOE7mhc5Lg63MoMB/+jhXY3WlVE+4+B5+ELdOXR7SAXo9VOCUMfJ9+AK6tiv8=
X-Received: by 2002:aa7:979d:0:b029:1a4:3b76:a559 with SMTP id
 o29-20020aa7979d0000b02901a43b76a559mr22509754pfp.49.1608220366075; Thu, 17
 Dec 2020 07:52:46 -0800 (PST)
MIME-Version: 1.0
References: <20201217121303.13386-1-songmuchun@bytedance.com> <20201217145953.GA13874@linux>
In-Reply-To: <20201217145953.GA13874@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 17 Dec 2020 23:52:09 +0800
Message-ID: <CAMZfGtX__Ys+ccGyMBYTO+i+0u+btaK1NF6tSafTP3B53zm+cg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v10 00/11] Free some vmemmap pages of
 HugeTLB page
To:     Oscar Salvador <osalvador@suse.de>
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
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>, naoya.horiguchi@nec.com,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 11:00 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Thu, Dec 17, 2020 at 08:12:52PM +0800, Muchun Song wrote:
> > In this case, for the 1GB HugeTLB page, we can save 4088 pages(There are
> > 4096 pages for struct page structs, we reserve 2 pages for vmemmap and 8
> > pages for page tables. So we can save 4088 pages). This is a very substantial
> > gain. On our server, run some SPDK/QEMU applications which will use 1024GB
> > hugetlbpage. With this feature enabled, we can save ~16GB(1G hugepage)/~11GB
> > (2MB hugepage, the worst case is 10GB while the best is 12GB) memory.
>
> Is the above really true?
> We no longer need to allocate pagetables, so the savings go up to 4094, right?

Yeah, you are right. I forget to update this.

>
> I will be off for a few days but I expect to get back to this and review the
> missing bits when I am back.
>

Thanks.

> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
