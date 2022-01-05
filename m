Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CD94858D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 20:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243300AbiAETF7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 14:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243276AbiAETF6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 14:05:58 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77200C061245;
        Wed,  5 Jan 2022 11:05:57 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id bm14so353053edb.5;
        Wed, 05 Jan 2022 11:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QaOZQ0OUuHDLxriDkymCTGEPKjB60kDV2I9cpOteQ2U=;
        b=TjeHxlu90TTQ95wxkxQJaNIuybmeIYTrZbiFamYLS0GAEfXyvXCPApfpPLk0bfplbE
         CQ3TadGk+TFQbe6j2luKjMY6yKyp7uEsjNMZhKURQlN4mmXhoGr1IhCadw+1HAkcxz9Q
         QBU2didKB01Wu6u4Ts0zvQhAZKAcK7xf86uTnNzYuRFfAFYLMGhSFnPUwu9g/xgkhJc7
         Z4ZfxPwTqkwOjWceT3Roj1etOhoz/0BOBfWUe5YlstavVWWmvqPt0+jKkVwvvU6Imf9t
         o9ZxUznQ8nsFeyYyDEtRw8O/uG6KAX0fYfqK+ju4zHObD9F50KkjGH04MDtuyRciH+NT
         vyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QaOZQ0OUuHDLxriDkymCTGEPKjB60kDV2I9cpOteQ2U=;
        b=3sDhLCNAhMk97o+yjq/ecBJ1J6Sxyg5YmvqSiviPz6BBHe2lv7SvIRT040f+LylUk8
         TjcmXyQw4XCxy/TuUy+265sc139jPmanx8U0qZGYx1oAAJSsUSQQwflczyylb1A0/+Yv
         nkYZ64XKkMdWtuRiz+JO73AYwMlrIOrN1Ve6LZkrK5AAkpTQQHIsRKk4j4mLVu1+q7DE
         ukcQEZ/yZQvMv8+9LYmOnQqQyNvKta9FQwv7e5QNcQ0mAn55ynXlumG11+dM2Wiqo8Jv
         A47sfTvlN2yOalU2iGgTKd2HgNa0eeFI4jZLSwUc6WOO1JzZeV8jCue9ZBDACKgBO1xD
         ueOw==
X-Gm-Message-State: AOAM531cmp/AorNBC6VS9zzhCdFcUE0VK89UxHgMDu6JA4q6/tvlhReF
        WSPr2nWCiIBVgbFZCf0+QLNCutSIkWljuJKn8mI=
X-Google-Smtp-Source: ABdhPJwbaXebUAFb9swq2o131QbPOqMyMsX8CUnROGp26DPv5QJJ5q//ZQvaXFH50XOPGFNyJ09h/glumGq88GL2MZ8=
X-Received: by 2002:a17:907:da3:: with SMTP id go35mr44838487ejc.637.1641409556068;
 Wed, 05 Jan 2022 11:05:56 -0800 (PST)
MIME-Version: 1.0
References: <00000000000017977605c395a751@google.com> <0000000000009411bb05d3ab468f@google.com>
 <CAHbLzkoU_giAFiOyhHZvxLT9Vie2-8TmQv_XLDpRxbec5r5weg@mail.gmail.com> <YcIfj3nfuL0kzkFO@casper.infradead.org>
In-Reply-To: <YcIfj3nfuL0kzkFO@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 5 Jan 2022 11:05:44 -0800
Message-ID: <CAHbLzkqExMrdmJ=vy1Hmz16i6GhqWh_5RFaAZ9q4CzUpFv+v+g@mail.gmail.com>
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

I just revisited this. Now I see what you mean about "the rest of the
thread". My gmail client doesn't put them in the same thread, sigh...

Yeah, try_get_compound_head() seems like the right way.

Or we just simply treat migration entries as mapcount == 1 as Kirill
suggested or just skip migration entries since they are transient or
show migration entries separately.


> migrated, we should still account it ... also, you've changed the
> refcount, so this:
>
>         if (page_count(page) == 1) {
>                 smaps_page_accumulate(mss, page, size, size << PSS_SHIFT, dirty,
>                         locked, true);
>                 return;
>         }
>
> will never trigger.
