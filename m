Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C00445C5F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 23:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhKDWsB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 18:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbhKDWr6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 18:47:58 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD39C061714
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Nov 2021 15:45:19 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id p8so5365802pgh.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Nov 2021 15:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ez2Kc0qXfdZyVoueN+pRzSOTizwvVrWSdL7MhI68c/Y=;
        b=Nc5Ztqd9MT0ZUdLObZFAeRL2+SQYPyGlV4Sarkhyd9wRLOOShAuNS1GkpBUPRmdOOd
         RoESPqO/cJ9pKhy4ylZ6iQ6OPwTbZ59cKJPiceR2v/IjjCoEK/qHC6YuIgQHW/646zvB
         pTVMgjhR61eVK/HSdy/hDG07731O6d4qkxk87l31AN3nEHU0nYr8y0RoG5P9moF3KQZP
         216NP565fi5Fxy+ffK3IjZr/furTG0zHEtzabwmGV9VeTwvsRJQ6fN9CHXgv42XpPUSJ
         b+X5cHlQEKE9qvf6xVJqm8Vw47LAaYS0E6zaLZZBX5hhvc59cs6AJfoKBh92BvtsuDNB
         WrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ez2Kc0qXfdZyVoueN+pRzSOTizwvVrWSdL7MhI68c/Y=;
        b=vJQmx7sEKBxnNmPGpt1jLN/7rUCOQfHwP8lvPTPOEHxQfwZS9TQ872XuKgxGBEOa7A
         3ICRmRk1yXYJqFMGn6Z4fxe+JjzWu+GxKuQyl6lWCra4ff09Ll/6qqCLay4ELlMeMYlv
         daveArjv2EEGlNvRTnD0n7Tyx/NssLPqL81N/aMsJvgqSiH8QP8IjyPcVCPzC5riH58B
         LkE9KpcqjXOB/WErI0I/8e6ZK8oeMf90xAjyXyBb5iecgSCN7c7a+n9fv48YCC1mY47p
         kuQtLQBMjIzfxebcHZHQlXfr+h3sBw3FGuB1jDsuGpDQ6i+QqYvEgo3wJm1lzUVuI6Vh
         J16Q==
X-Gm-Message-State: AOAM532hB/1rzeqI5JdkUx0meTe6PGHlR4kJwIai/xa7eA0UsuNza3U7
        1EzRAJzkvw1xRVgmeQ6glHvuRBYxc98/pZqO1s9nrA==
X-Google-Smtp-Source: ABdhPJyyaBvoljTK7Xrm6XhzgfUQ/jdbwXvs/7ewAf+ELaJzbp6FekSKyfbkoStxKxUZyf/31byNV+ks+CYodyeVKYM=
X-Received: by 2002:a05:6a00:1484:b0:48c:2e58:8d39 with SMTP id
 v4-20020a056a00148400b0048c2e588d39mr18010577pfu.13.1636065919224; Thu, 04
 Nov 2021 15:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211104214636.450782-1-almasrymina@google.com> <YYRZNWZqHy9+11KW@casper.infradead.org>
In-Reply-To: <YYRZNWZqHy9+11KW@casper.infradead.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 4 Nov 2021 15:45:07 -0700
Message-ID: <CAHS8izPisLXTmAsvZR6w2piSXPidVvJMHfQR7oikJgkuTJyRQA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Add PM_THP to /proc/pid/pagemap
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        David Hildenbrand <david@redhat.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 4, 2021 at 3:08 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Nov 04, 2021 at 02:46:35PM -0700, Mina Almasry wrote:
> > Add PM_THP to allow userspace to detect whether a given virt address is
> > currently mapped by a hugepage or not.
>
> Well, no, that's not what that means.
>

Sorry, that was the intention, but I didn't implement the intention correctly.

> > @@ -1396,6 +1397,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
> >               flags |= PM_FILE;
> >       if (page && page_mapcount(page) == 1)
> >               flags |= PM_MMAP_EXCLUSIVE;
> > +     if (page && PageTransCompound(page))
> > +             flags |= PM_THP;
>
> All that PageTransCompound() does is call PageCompound().  It doesn't
> tell you if the underlying allocation is PMD sized, nor properly aligned.
>
> And you didn't answer my question about whether you want information about
> whether a large page is being used that's not quite as large as a PMD.
>

Sorry, I thought the implementation would make it clear but I didn't
do that correctly. Right now and for the foreseeable future what I
want to know is whether the page is mapped by a PMD. All the below
work for me:

1. Flag is set if the page is either a PMD size THP page.
2. Flag is set if the page is either a PMD size THP page or PMD size
hugetlbfs page.
3. Flag is set if the page is either a PMD size THP page or PMD size
hugetlbfs page or contig PTE size hugetlbfs page.

I prefer #2 and I think it's maybe most extensible for future use
cases that 1 flag tells whether the page is PMD hugepage and another
flag is a large cont PTE page.
