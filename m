Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F42E39F9B8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 16:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhFHO6y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 10:58:54 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38364 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbhFHO6w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:58:52 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by linux.microsoft.com (Postfix) with ESMTPSA id 684B520B83C5;
        Tue,  8 Jun 2021 07:56:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 684B520B83C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623164219;
        bh=5adkBab5YgC4ua7cy6g3IJlMevjI3rkkXDpAoANH9ho=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BaXOma7rHPHFSCxmGUeLjFRe22Dav9/8UdX+EwMLhxCiIfkKRd9/FnXM4JLfKnnCz
         143ihX/qoVP5IyJq6KydhH+lUN8bDRzB4bP2jupk6lQ6rDocZXtFtf1OmunaiwTTqg
         3eyIEW7OcCiSKjGRMAJFitXJgFUZEYz6MXLPayZc=
Received: by mail-pj1-f54.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so2449670pjq.3;
        Tue, 08 Jun 2021 07:56:59 -0700 (PDT)
X-Gm-Message-State: AOAM53358IoVhrT5nc/7gdIX+vqrNX+pAKQumyegiTwYUEmHvUjzdPQR
        ELjn69Vs5fiJGA/YX0/Qxlh4OU0TP2RZbJLf+M0=
X-Google-Smtp-Source: ABdhPJzNnGHBMRnqD7hcfQnkP4ftZvW9/ffkse696Bzy4x7VTQyeIyWA6fK1974zMmVl3AKfQy85iM5JjczuDF0rpu8=
X-Received: by 2002:a17:90b:109:: with SMTP id p9mr5359058pjz.11.1623164218966;
 Tue, 08 Jun 2021 07:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210511214735.1836149-1-willy@infradead.org> <20210604030712.11b31259@linux.microsoft.com>
 <YLmMQJgld6ndNzqI@casper.infradead.org>
In-Reply-To: <YLmMQJgld6ndNzqI@casper.infradead.org>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Tue, 8 Jun 2021 16:56:23 +0200
X-Gmail-Original-Message-ID: <CAFnufp0=N-dyW4dwMLLdeg-AZE_uYBXMsNNh6FFpG869v0_aFw@mail.gmail.com>
Message-ID: <CAFnufp0=N-dyW4dwMLLdeg-AZE_uYBXMsNNh6FFpG869v0_aFw@mail.gmail.com>
Subject: Re: [PATCH v10 00/33] Memory folios
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 4, 2021 at 4:13 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jun 04, 2021 at 03:07:12AM +0200, Matteo Croce wrote:
> > On Tue, 11 May 2021 22:47:02 +0100
> > "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> >
> > > We also waste a lot of instructions ensuring that we're not looking at
> > > a tail page.  Almost every call to PageFoo() contains one or more
> > > hidden calls to compound_head().  This also happens for get_page(),
> > > put_page() and many more functions.  There does not appear to be a
> > > way to tell gcc that it can cache the result of compound_head(), nor
> > > is there a way to tell it that compound_head() is idempotent.
> > >
> >
> > Maybe it's not effective in all situations but the following hint to
> > the compiler seems to have an effect, at least according to bloat-o-meter:
>
> It definitely has an effect ;-)
>
>      Note that a function that has pointer arguments and examines the
>      data pointed to must _not_ be declared 'const' if the pointed-to
>      data might change between successive invocations of the function.
>      In general, since a function cannot distinguish data that might
>      change from data that cannot, const functions should never take
>      pointer or, in C++, reference arguments.  Likewise, a function that
>      calls a non-const function usually must not be const itself.
>
> So that's not going to work because a call to split_huge_page() won't
> tell the compiler that it's changed.
>
> Reading the documentation, we might be able to get away with marking the
> function as pure:
>
>      The 'pure' attribute imposes similar but looser restrictions on a
>      function's definition than the 'const' attribute: 'pure' allows the
>      function to read any non-volatile memory, even if it changes in
>      between successive invocations of the function.
>
> although that's going to miss opportunities, since taking a lock will
> modify the contents of struct page, meaning the compiler won't cache
> the results of compound_head().
>
> > $ scripts/bloat-o-meter vmlinux.o.orig vmlinux.o
> > add/remove: 3/13 grow/shrink: 65/689 up/down: 21080/-198089 (-177009)
>
> I assume this is an allyesconfig kernel?    I think it's a good
> indication of how much opportunity there is.
>

Yes, it's an allyesconfig kernel.
I did the same with pure:

$ git diff
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 04a34c08e0a6..548b72b46eb1 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -179,7 +179,7 @@ enum pageflags {

struct page;   /* forward declaration */

-static inline struct page *compound_head(struct page *page)
+static inline __pure struct page *compound_head(struct page *page)
{
       unsigned long head = READ_ONCE(page->compound_head);


$ scripts/bloat-o-meter vmlinux.o.orig vmlinux.o
add/remove: 3/13 grow/shrink: 63/689 up/down: 20910/-192081 (-171171)
Function                                     old     new   delta
ntfs_mft_record_alloc                      14414   16627   +2213
migrate_pages                               8891   10819   +1928
ext2_get_page.isra                          1029    2343   +1314
kfence_init                                  180    1331   +1151
page_remove_rmap                             754    1893   +1139
f2fs_fsync_node_pages                       4378    5406   +1028
[...]
migrate_page_states                         7088    4842   -2246
ntfs_mft_record_format                      2940       -   -2940
lru_deactivate_file_fn                      9220    6277   -2943
shrink_page_list                           20653   15749   -4904
page_memcg                                  5149     193   -4956
Total: Before=388869713, After=388698542, chg -0.04%

$ ls -l vmlinux.o.orig vmlinux.o
-rw-rw-r-- 1 mcroce mcroce 1295502680 Jun  8 16:47 vmlinux.o
-rw-rw-r-- 1 mcroce mcroce 1295934624 Jun  8 16:28 vmlinux.o.orig

vmlinux is ~420 kb smaller..

-- 
per aspera ad upstream
