Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666A230859F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 07:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhA2GSB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 01:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbhA2GRh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:17:37 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954EAC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 22:16:57 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id cq1so5231999pjb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 22:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IVLhRnuvVbWMIlCeZcR36K8LU3Zj15Td3oSsxTVm3dw=;
        b=Si4B7X6KLGW5Z89xZzVDHl7Skoe89UmiKGduLwtiFh0G2ErduZLcoyhzxfb8G5ThI4
         syF50PNuDAMILs8Gbg3zVHAZgxzjYwu3Uw/rNASkDR2t4GqLp1BCz97iLqdk77dYA4c3
         2CkKQdm+NEK6TlvP3w9vWyB3cGnovx1bDqRVEFI1RGuFthcCxJwnq2yoH7dGXiwhK+NG
         r0P2bc3WoSPjpzim4kOkGEgTHCPAxXV8ZbURzJNwTJ2lhdkX9bfbopWe/xjDpIAL3prB
         c/pTLgzzEXjCsYV5TlheMKOfuCAisunpmi0HckFP+fJtJ5ubMdQc7AsA3gMnJSt8Jmkw
         oBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IVLhRnuvVbWMIlCeZcR36K8LU3Zj15Td3oSsxTVm3dw=;
        b=KR+8doUUziY8+7Rs7HX0f2nSKc70xx80rcc5wX4msBAMxsHJ+/HuAW40ocgMybLRCB
         XckKeMmcE2NsGpahoE4ze0nSUGz1uvmm5nGTUeQTpwUABchEgiMkbYoa2sY1XZmgfpNT
         X0q5KJg6Xh8EcLqF5KFEofS+1JtQxvH9EEVweNr9bzGshGCMFxYmy8w9UO82WEkT7q+w
         Q+G2J7LZhhIPDAV0jQeN3zhoiRCSiaESEm2/BKbrqguPb8mUIgjEvFGCpCoB+5WfSrNE
         GrZyJ11Um0fqlQTc6m9V62CKMI0q1DEcobVFrLzl+gmE79m6tciPsCPhKjUBIDM6h++w
         7jjg==
X-Gm-Message-State: AOAM530S9hUE/84jP2GVsCS9Lxyyy5M58dZcVh13HjnaPMVtcrGhjiqr
        m8h5OHcn+o25VmBO2gCo0phTGQW9jzZHG1Md0ww3mg==
X-Google-Smtp-Source: ABdhPJzlRocofXXUHhMpeg+wl6mPPzL5KoQPKYz1IbQOQ5+sTLmTyjhkh9y85ZPhI/SVxjYO862v/1WfnMigBDp1NyQ=
X-Received: by 2002:a17:902:8503:b029:dc:44f:62d8 with SMTP id
 bj3-20020a1709028503b02900dc044f62d8mr2746955plb.34.1611901017151; Thu, 28
 Jan 2021 22:16:57 -0800 (PST)
MIME-Version: 1.0
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-6-songmuchun@bytedance.com> <20210126092942.GA10602@linux>
 <6fe52a7e-ebd8-f5ce-1fcd-5ed6896d3797@redhat.com> <20210126145819.GB16870@linux>
 <259b9669-0515-01a2-d714-617011f87194@redhat.com> <20210126153448.GA17455@linux>
 <9475b139-1b33-76c7-ef5c-d43d2ea1dba5@redhat.com> <e28399e1-3a24-0f22-b057-76e7c7e70017@redhat.com>
 <20210128222906.GA3826@localhost.localdomain>
In-Reply-To: <20210128222906.GA3826@localhost.localdomain>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 29 Jan 2021 14:16:19 +0800
Message-ID: <CAMZfGtW7Bc-QhjW7MJyVwYXPEihbKyAE20NLgs3mVmgALh_X2A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v13 05/12] mm: hugetlb: allocate the
 vmemmap pages associated with each HugeTLB page
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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

On Fri, Jan 29, 2021 at 6:29 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Wed, Jan 27, 2021 at 11:36:15AM +0100, David Hildenbrand wrote:
> > Extending on that, I just discovered that only x86-64, ppc64, and arm64
> > really support hugepage migration.
> >
> > Maybe one approach with the "magic switch" really would be to disable
> > hugepage migration completely in hugepage_migration_supported(), and
> > consequently making hugepage_movable_supported() always return false.
>
> Ok, so migration would not fork for these pages, and since them would
> lay in !ZONE_MOVABLE there is no guarantee we can unplug the memory.
> Well, we really cannot unplug it unless the hugepage is not used
> (it can be dissolved at least).
>
> Now to the allocation-when-freeing.
> Current implementation uses GFP_ATOMIC(or wants to use) + forever loop.
> One of the problems I see with GFP_ATOMIC is that gives you access
> to memory reserves, but there are more users using those reserves.
> Then, worst-scenario case we need to allocate 16MB order-0 pages
> to free up 1GB hugepage, so the question would be whether reserves
> really scale to 16MB + more users accessing reserves.
>
> As I said, if anything I would go for an optimistic allocation-try
> , if we fail just refuse to shrink the pool.
> User can always try to shrink it later again via /sys interface.

Yeah. It seems that this is the easy way to move on.

Thanks.

>
> Since hugepages would not be longer in ZONE_MOVABLE/CMA and are not
> expected to be migratable, is that ok?
>
> Using the hugepage for the vmemmap array was brought up several times,
> but that would imply fragmenting memory over time.
>
> All in all seems to be overly complicated (I might be wrong).
>
>
> > Huge pages would never get placed onto ZONE_MOVABLE/CMA and cannot be
> > migrated. The problem I describe would apply (careful with using
> > ZONE_MOVABLE), but well, it can at least be documented.
>
> I am not a page allocator expert but cannot the allocation fallback
> to ZONE_MOVABLE under memory shortage on other zones?
>
>
> --
> Oscar Salvador
> SUSE L3
