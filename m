Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D334247C730
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 20:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241692AbhLUTHS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 14:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbhLUTHR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 14:07:17 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2443C06173F;
        Tue, 21 Dec 2021 11:07:16 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y13so55852865edd.13;
        Tue, 21 Dec 2021 11:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SYL7p6rg2ZGLY23GDBM6DdykFRw4Wpd+sl8f5dfe0HQ=;
        b=jm6OvmvKVFdUE4VKUPhOCpQIZaZloyuVkUe0ms2HFMVyl2B2hToMWnYXIMTVDwiiPS
         Yi/12zYY6WaL7/MsBSKgdL9rUr/Te5P6y+2NxiUjdmwvn6Oq+wJZ4QhXV01OjBn13Ik9
         A8xmed5O2ZSMRC0mDfv4b8X6nNprCdkT7/jZngnsmhRJmNWnte2YtzvqI56UvF9rg2yV
         u7sKeJQfz7iD0mGpImbrZj3rgv2/M6j8MSyP/TB4+VAJTCrgdNu1oRc6x7PHchYsN17v
         uoqhVOBjMpPbXQrULlfLIXFbvJ6By3ZReUpLHurhSVj8r7H4Tu6JWJKX0gMvNw4u88XD
         RBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SYL7p6rg2ZGLY23GDBM6DdykFRw4Wpd+sl8f5dfe0HQ=;
        b=dI+3ecrwIQVBnIRQt8w6kBy8D95NPM2VDwTsqteKUFfQikG48Ul1Ho0xMyFVDUnwsi
         PEr75XPAte4o1IhF4QOCLHsWdTkHBcPMhDgWPkLl07XpdrWugt/CLO4HlSAKhhRnfzKw
         LVjQqNm5I2/dpFG3uZ54bmCtUSXZFh9Sn/yb6HF8x58QWSJ5afypvf/utqCn9jsB1V8Z
         E8iQ0HBQoLrNycz8MryMwqHgdSBrV6RquNdTXwQdFZBMpWPob7ey5axiEC2MjyL6Ntcs
         htMxhRk7psL/BSkfRA2GRxjWA2KtE9PcqV4LMJW57nKg5MayOxbw+CPNh8PmlNUIC+5D
         jpnA==
X-Gm-Message-State: AOAM533FRIegF3pz/K1e5BKUBojGHF61CsJGc+W4xgyKdRKdOqepdD7o
        90/+rRw0SNrRQbcCiPx3LarRW/u9ABSlbiiH+gs=
X-Google-Smtp-Source: ABdhPJzySlK4xITZYwVfLwDEf2SjSPZpULPkRbGBFglWu+X4qW0FhOGNGmASRi2GIsaTnJ60iD29KgfGGEeol7wOB+8=
X-Received: by 2002:aa7:c641:: with SMTP id z1mr4664998edr.84.1640113635609;
 Tue, 21 Dec 2021 11:07:15 -0800 (PST)
MIME-Version: 1.0
References: <00000000000017977605c395a751@google.com> <0000000000009411bb05d3ab468f@google.com>
 <CAHbLzkoU_giAFiOyhHZvxLT9Vie2-8TmQv_XLDpRxbec5r5weg@mail.gmail.com> <YcIfj3nfuL0kzkFO@casper.infradead.org>
In-Reply-To: <YcIfj3nfuL0kzkFO@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 21 Dec 2021 11:07:03 -0800
Message-ID: <CAHbLzkqYhtYNRs83DP-Cgti8-4kZn-iXHTdkesK+=U3d3N0U+w@mail.gmail.com>
Subject: Re: [syzbot] kernel BUG in __page_mapcount
To:     Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+1f52b3a18d5633fa7f82@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        chinwen.chang@mediatek.com, fgheet255t@gmail.com,
        Jann Horn <jannh@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs@googlegroups.com, tonymarislogistics@yandex.com,
        Vlastimil Babka <vbabka@suse.cz>, walken@google.com,
        Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 21, 2021 at 10:40 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Dec 21, 2021 at 10:24:27AM -0800, Yang Shi wrote:
> > It seems the THP is split during smaps walk. The reproducer does call
> > MADV_FREE on partial THP which may split the huge page.
> >
> > The below fix (untested) should be able to fix it.
>
> Did you read the rest of the thread on this?  If the page is being
> migrated, we should still account it ... also, you've changed the

Yes, the being migrated pages may be skipped. We should be able to add
a new flag to smaps_account() to indicate this is a migration entry
then don't elevate the page count.

> refcount, so this:
>
>         if (page_count(page) == 1) {
>                 smaps_page_accumulate(mss, page, size, size << PSS_SHIFT, dirty,
>                         locked, true);
>                 return;
>         }
>
> will never trigger.

The get_page_unless_zero() is called after this block.
