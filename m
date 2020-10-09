Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8E428810E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 06:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgJIEO1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 00:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbgJIEOZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 00:14:25 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF77C0613D4
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2020 21:14:23 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y1so302084plp.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Oct 2020 21:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2EdRl1RZSZyQAx1Q/Ie821/xWpZ1zaRf0wSS4lUA3SI=;
        b=v7gBYn5/EZRmnBAafloGJqCSbpmjFsH9/KMYR1XRcVdwbTsT+m1XSFlQI84qBLDeOT
         b6kqq2Jl1eNr7H6VNFbnPEN3x97qDCgPpi/SPmll2afdgy/agYkIwQeMQYm2S8IO9ztp
         OHcPIBkoKPNfbYmailisJnqZthEwjvGgu8lniBGv3y5+22eE7vAsugCQiA6cnJ9pNAfO
         TBz4fOgAgQiOOiyrCe6fjZuO1tQ5Ougo0x6zCMAT8nLaQBtch2+Y+la2jwgpauoS2nyi
         VJi1YXlCmmzENl7kiOneL+0Q+/1cXu+BVnEXk3bhxCwELuqUtAHE+dkeLkC03XLw7fUe
         va5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2EdRl1RZSZyQAx1Q/Ie821/xWpZ1zaRf0wSS4lUA3SI=;
        b=SzM7jJOKdff0lTOcMC582p2e+keczzPup3GxUMDF64sE5kWI45/MGYOv/laapQFZ5/
         OOvBsiDg3zXG8uqWJEKGuj+CKTNLEksykKOpXbmU8UwzU+ANxBdeu9qWTfRydb6TTUwi
         MDLHBCh6ABjywIWZVMeBYUqQtMbLUFQVh3F91ORP6XhLFXTpWu/xN/h6G5chHp6QufdY
         1rU2yRaGh2J03zxFnewxVvqtMjnYuZ95Fx3opiqakpx1MKN6hEucjidSYzcXbU+kgYQZ
         LYm6MkOqqDXSlVZJ9AQC7OgIOR5rCJMA7/tK+q3Wq3KZjWS2o+ltQFh/a+23R0Lt9ui1
         0kXQ==
X-Gm-Message-State: AOAM531tQsDejKL4rnUXjbIshiVe3lJy+csXGtYDbHjtcauBFuJiQ+Pr
        1USdd9A2sIbrNy8/31/tKzTdSpj0Rl/qHzXslbUvlg==
X-Google-Smtp-Source: ABdhPJy+9zgYNBhCq4QlEB9KjNxaK/TjK9EK5mKamVQ74y0m5jXebPwnkkW6871aHrnVRAd4WHnZoDUCYUoEHq5INcY=
X-Received: by 2002:a17:902:7681:b029:d2:88b1:b130 with SMTP id
 m1-20020a1709027681b02900d288b1b130mr10859993pll.20.1602216863306; Thu, 08
 Oct 2020 21:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200915125947.26204-1-songmuchun@bytedance.com>
 <31eac1d8-69ba-ed2f-8e47-d957d6bb908c@oracle.com> <9d220de0-f06d-cb5b-363f-6ae97d5b4146@oracle.com>
In-Reply-To: <9d220de0-f06d-cb5b-363f-6ae97d5b4146@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 9 Oct 2020 12:13:44 +0800
Message-ID: <CAMZfGtXAB7CqNxp2Et=SSY4iPDbxS92cwcDEo2C_88m92JNWoQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 00/24] mm/hugetlb: Free some vmemmap
 pages of hugetlb page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 8, 2020 at 5:15 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 9/29/20 2:58 PM, Mike Kravetz wrote:
> > On 9/15/20 5:59 AM, Muchun Song wrote:
> >> Hi all,
> >>
> >> This patch series will free some vmemmap pages(struct page structures)
> >> associated with each hugetlbpage when preallocated to save memory.
> > ...
> >> The mapping of the first page(index 0) and the second page(index 1) is
> >> unchanged. The remaining 6 pages are all mapped to the same page(index
> >> 1). So we only need 2 pages for vmemmap area and free 6 pages to the
> >> buddy system to save memory. Why we can do this? Because the content
> >> of the remaining 7 pages are usually same except the first page.
> >>
> >> When a hugetlbpage is freed to the buddy system, we should allocate 6
> >> pages for vmemmap pages and restore the previous mapping relationship.
> >>
> >> If we uses the 1G hugetlbpage, we can save 4095 pages. This is a very
> >> substantial gain. On our server, run some SPDK applications which will
> >> use 300GB hugetlbpage. With this feature enabled, we can save 4797MB
> >> memory.
>
> I had a hard time going through the patch series as it is currently
> structured, and instead examined all the code together.  Muchun put in
> much effort and the code does reduce memory usage.
> - For 2MB hugetlb pages, we save 5 pages of struct pages
> - For 1GB hugetlb pages, we save 4086 pages of struct pages
>
> Code is even in pace to handle poisoned pages, although I have not looked
> at this closely.  The code survives the libhugetlbfs and ltp huge page tests.
>
> To date, nobody has asked the important question "Is the added complexity
> worth the memory savings?".  I suppose it all depends on one's use case.
> Obviously, the savings are more significant when one uses 1G huge pages but
> that may not be the common case today.
>
> > At a high level this seems like a reasonable optimization for hugetlb
> > pages.  It is possible because hugetlb pages are 'special' and mostly
> > handled differently than pages in normal mm paths.
>
> Such an optimization only makes sense for something like hugetlb pages.  One
> reason is the 'special' nature of hugetlbfs as stated above.  The other is
> that this optimization mostly makes sense for huge pages that are created
> once and stick around for a long time.  hugetlb pool pages are a perfect
> example.  This is because manipulation of struct page mappings is done when
> a huge page is created or destroyed.

Yeah, in our cloud server, we have some application scenarios(e.g. SPDK,
DPDK, QEMU and jemalloc). These applications may use a lot of hugetlb
pages.

>
> > The majority of the new code is hugetlb specific, so it should not be
> > of too much concern for the general mm code paths.
>
> It is true that much of the code in this series was put in hugetlb.c.  However,
> I would argue that there is a bunch of code that only deals with remapping
> the memmap which should more generic and added to sparse-vmemmap.c.  This
> would at least allow for easier reuse.

I agree with you.

>
> Before Muchun and myself put more effort into this series, I would really
> like to get feedback on the whether or not this should move forward.
> Specifically, is the memory savings worth added complexity?  Is the removing
> of struct pages going to come back and cause issues for future features?

Some users do need this optimization to save memory. But if some users
do not need this optimization, they also can disable it by using a kernel boot
parameter 'hugetlb_free_vmemmap=off' or not configuring
CONFIG_HUGETLB_PAGE_FREE_VMEMMAP.

I have no idea about "cause issues for future features". Is there any feature
ongoing or planned?

-- 
Yours,
Muchun
