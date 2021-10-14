Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21BC42D301
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 08:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhJNG40 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 02:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhJNG4Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 02:56:25 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64853C061570;
        Wed, 13 Oct 2021 23:54:20 -0700 (PDT)
Date:   Thu, 14 Oct 2021 15:54:08 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1634194458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CVDe8En+IZWhjai+cfsatfH8CtNAmmtQm4RPgAbLMdA=;
        b=IlxAqI/go2rYK5DkhGiWSlIrOhDOHjgjOs4NkrfBKSuw8wVrC7pt5uvK8BkQylJI93zYmw
        1/pPXJYAC+cDX1p5b6A0H+MtXolrHK8hDL9o6jFjck1DI2meNkYwVlTmpbnWov7Zd1o9dr
        b/y9N2DWB/PsjlhgeRvo8f5uX4H9tLQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Peter Xu <peterx@redhat.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v3 PATCH 0/5] Solve silent data loss caused by poisoned
 page cache (shmem/tmpfs)
Message-ID: <20211014065408.GA2017714@u2004>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <YWZHOYgFrMYbmNA/@t490s>
 <CAHbLzkoz6Gm31Qz-u_ohR6NK2RRE5OdEkSq_3t9Cjwkqf1+a7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkoz6Gm31Qz-u_ohR6NK2RRE5OdEkSq_3t9Cjwkqf1+a7w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 12, 2021 at 08:09:24PM -0700, Yang Shi wrote:
> On Tue, Oct 12, 2021 at 7:41 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Sep 30, 2021 at 02:53:06PM -0700, Yang Shi wrote:
> > > Yang Shi (5):
> > >       mm: hwpoison: remove the unnecessary THP check
> > >       mm: filemap: check if THP has hwpoisoned subpage for PMD page fault
> > >       mm: hwpoison: refactor refcount check handling
> > >       mm: shmem: don't truncate page if memory failure happens
> > >       mm: hwpoison: handle non-anonymous THP correctly
> >
> > Today I just noticed one more thing: unpoison path has (unpoison_memory):
> >
> >         if (page_mapping(page)) {
> >                 unpoison_pr_info("Unpoison: the hwpoison page has non-NULL mapping %#lx\n",
> >                                  pfn, &unpoison_rs);
> >                 return 0;
> >         }
> >
> > I _think_ it was used to make sure we ignore page that was not successfully
> > poisoned/offlined before (for anonymous), so raising this question up on
> > whether we should make sure e.g. shmem hwpoisoned pages still can be unpoisoned
> > for debugging purposes.
> 
> Yes, not only mapping, the refcount check is not right if page cache
> page is kept in page cache instead of being truncated after this
> series. But actually unpoison has been broken since commit
> 0ed950d1f28142ccd9a9453c60df87853530d778 ("mm,hwpoison: make
> get_hwpoison_page() call get_any_page()"). And Naoya said in the
> commit "unpoison_memory() is also unchanged because it's broken and
> need thorough fixes (will be done later)."
> 

Yeah, I have a patch but still not make it merged to upstream.
Sorry about that...

> I do have some fixes in my tree to unblock tests and fix unpoison for
> this series (just make it work for testing). Naoya may have some ideas
> in mind and it is just a debugging feature so I don't think it must be
> fixed in this series. It could be done later. I could add a TODO
> section in the cover letter to make this more clear.

Yes, it's fine to me that you leave this unsolved in this patchset.

Thanks,
Naoya Horiguchi
