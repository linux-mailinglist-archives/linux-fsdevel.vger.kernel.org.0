Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EA032FFAE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Mar 2021 09:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhCGIkA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Mar 2021 03:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhCGIjo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Mar 2021 03:39:44 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEF6C06174A
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 Mar 2021 00:39:44 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b15so1444265pjb.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Mar 2021 00:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+ZIdAEa9OwEkxgFcDiKNp4vM+KvSh13doJNbkRyCBk=;
        b=xhjBKjSuF4exEfCWDp7cl5chAnIppGTTfOErwDX9TjXEDszpoQHxnheS0lDw/Px0GD
         auYjkp6xPVobYtnb3S5RJvK1McAT4Kx8vX4xO0J6pWGev71nx7MLrRcp9ZqpAlqWMnk8
         41yZTr35QJIAv3pOKBlvutH6ZCYXbZ15BFgpzWEx2GQ9Uan85hsZnr/bHfrhoWR3tJma
         m/nPKyAxWAJDS1igXcKnuHQqeOB5PMan3Ob/2UMVY0BpFi3ftw1E3U45qkzFTRrU9FYD
         +ykdzS8Ay9pxLZL1cZRHxyvyJaE+C2SsxklsIxZOcXdbIZMFb3GflqrqWxIcpuSctdqQ
         3/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+ZIdAEa9OwEkxgFcDiKNp4vM+KvSh13doJNbkRyCBk=;
        b=pu4DsNHTKBJd4NSbCGAV6V+ngJWxh75c0o2EVu6d2Zjs2j0nP8HvontYXHE0RvfEWw
         nzOJQlKKX6E1mROUK9UGv8CALxtaUP8H2xWiZz+zkY5IszM4ABRqBF1TYSfr65oeKMtm
         Bkc7oEzor3P5ZWXuGzLaZFqQFAKCi5bYBFpvge2+GAoC5DUBuidggG1xkkqmq53mZi3c
         kJy+dVw/kFIXJrwDVN2uGHlXDL/fcByA+RQF25u/hToWc9QpSu30pkoyUyzOkItYWKQb
         7abLbQz4l7jHdj0BMJ0ZupHsUnpE2zgh+2UX9GGltbWo/B3t+9b0zry6bvlGhqYmCjXK
         dbuw==
X-Gm-Message-State: AOAM533jnrEq7G30R3wGbNUHzs1938lD3kd2hUMZ5tzu247JO8RRQhux
        8H2WnKenI6sL1Qe6t6WPZbBCMJ8fezNCUoO/rzxMbg==
X-Google-Smtp-Source: ABdhPJzYu4GAe2KZbj6JGQ3TjLW4bhjtDiKLF8LYik5ilaN940EpS0CUXvYX1AmTwVvRaeE70SCqKvP8wVhLrFQc8B8=
X-Received: by 2002:a17:90a:778a:: with SMTP id v10mr18672246pjk.229.1615106383749;
 Sun, 07 Mar 2021 00:39:43 -0800 (PST)
MIME-Version: 1.0
References: <20210225132130.26451-1-songmuchun@bytedance.com>
 <20210225132130.26451-6-songmuchun@bytedance.com> <20210307081857.GE1223287@balbir-desktop>
In-Reply-To: <20210307081857.GE1223287@balbir-desktop>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sun, 7 Mar 2021 16:39:07 +0800
Message-ID: <CAMZfGtUjDj8e9tW2dum+JSMo-BQ5YwPo+Am4ixndkMKaCuG4gQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v17 5/9] mm: hugetlb: set the PageHWPoison
 to the raw error page
To:     Balbir Singh <bsingharora@gmail.com>
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
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 7, 2021 at 4:19 PM Balbir Singh <bsingharora@gmail.com> wrote:
>
> On Thu, Feb 25, 2021 at 09:21:26PM +0800, Muchun Song wrote:
> > Because we reuse the first tail vmemmap page frame and remap it
> > with read-only, we cannot set the PageHWPosion on some tail pages.
> > So we can use the head[4].private (There are at least 128 struct
> > page structures associated with the optimized HugeTLB page, so
> > using head[4].private is safe) to record the real error page index
> > and set the raw error page PageHWPoison later.
> >
>
> Does the hardcoding of 4 come from HUGETLB_CGROUP_MIN_ORDER, if so

Yes.

> do we need to hardcode 4? Also, I am not sure about the comment
> on safety and 128 struct pages

We can set head[4].private only if free_vmemmap_pages_per_hpage(h)
returns true. In this case, there are 128 struct page structures (we reserve
2 pages as vmemmap pages, so 2 * 4KB / sizeof(struct page) == 128) that
can be used. Instead of hardcode, I introduce another patch to make the
code more readable. Please refer to patch #8 in this series.

Thanks.

>
> Balbir
>
