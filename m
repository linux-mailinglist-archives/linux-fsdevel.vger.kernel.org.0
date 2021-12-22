Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B4D47CADF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Dec 2021 02:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhLVBnE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 20:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhLVBnD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 20:43:03 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8822AC061574;
        Tue, 21 Dec 2021 17:43:03 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m21so3487948edc.0;
        Tue, 21 Dec 2021 17:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L5HXUbtpZbhWm0eIO9n7xuZrUAU7FSVNXrbbO8GknXU=;
        b=NEUc48d3pV7T70Mad+r745216ViF/UiBsPRrOZNfCbAdiJ4i/IB4EmQsKSiWlusBzR
         ByTc90tR/Tef2isGxSHzHRw+MjpcAxMpfftrADlO2ruYhS72E/xX/lV31Evh/RDkNhdS
         QyWtZQYduwKOSlbHSrtcj93Z7cE+AmqTr1/lOMAK8N7/vD9o/NC4vt6k4vohMyPlAGXy
         OboBUDZ3h13j5KdIBKLvUviyFXW8XeKcFsTTL2vRTlKSfSN1gFgps/YB01o5/a/RXf4D
         KKnst8LvdQcFFjWPd/GujX0jRjn/DTSzoaBO94/bqb1SBQc8tHz8Qs7fzkuDCHZFvwvI
         OdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L5HXUbtpZbhWm0eIO9n7xuZrUAU7FSVNXrbbO8GknXU=;
        b=sRKvYiys4+TNY2ZKWAxG+1nSsybrGCzezQ9T0vbIklgbAoPRr0ruH3ECQZ7RfWxNQA
         mhPHIz/QJuAzU68cowoIsDVVjt1f2UqCgt4GDa0S2ny9cSJJ67zR2q50ihCpROtHugS7
         RnedaiVdA2ypVkJQ4NkOW4548FcmK+6pSeMo7CZ2FG0jxOIgsJ6ax/rka5mePTZ7DowD
         BqrzWhQn5tW7WgBLvt+Ov3cHhYfR+LaGTexdJ0CY7hEKIcXzFV6/+DzAM6KtOR2xGhMx
         QnUE6x9mpKkYCI3RUtAlPK2h45XrGBsD3TEhBsnITfyn1TR2wfo83oZkf7CAuouSGaap
         kIAQ==
X-Gm-Message-State: AOAM532ZensjduSUnMnZZWZkG8z1DxN9kL+8iq6PozCYr6/fzNrANjsR
        AT061+bJuAd6iy5RecXa94RYWW1YpMcix+xEVyj/1ng3234=
X-Google-Smtp-Source: ABdhPJz0jGbJWhu/e5N5szknK6r9Io4+lI7/ZYYX7hLb/2bNH22rQV3x82NofTbJBi8j7He29LcP0XrciJe5eM9g6s0=
X-Received: by 2002:a17:907:3d88:: with SMTP id he8mr766963ejc.239.1640137382153;
 Tue, 21 Dec 2021 17:43:02 -0800 (PST)
MIME-Version: 1.0
References: <00000000000017977605c395a751@google.com> <0000000000009411bb05d3ab468f@google.com>
 <CAHbLzkoU_giAFiOyhHZvxLT9Vie2-8TmQv_XLDpRxbec5r5weg@mail.gmail.com>
 <YcIfj3nfuL0kzkFO@casper.infradead.org> <CAHbLzkqYhtYNRs83DP-Cgti8-4kZn-iXHTdkesK+=U3d3N0U+w@mail.gmail.com>
In-Reply-To: <CAHbLzkqYhtYNRs83DP-Cgti8-4kZn-iXHTdkesK+=U3d3N0U+w@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 21 Dec 2021 17:42:50 -0800
Message-ID: <CAHbLzkpj8tKykWfOUkffsnc7SXn395e67HVH+ys7cQ19aw-fPg@mail.gmail.com>
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
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 21, 2021 at 11:07 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Tue, Dec 21, 2021 at 10:40 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Dec 21, 2021 at 10:24:27AM -0800, Yang Shi wrote:
> > > It seems the THP is split during smaps walk. The reproducer does call
> > > MADV_FREE on partial THP which may split the huge page.
> > >
> > > The below fix (untested) should be able to fix it.
> >
> > Did you read the rest of the thread on this?  If the page is being
> > migrated, we should still account it ... also, you've changed the
>
> Yes, the being migrated pages may be skipped. We should be able to add
> a new flag to smaps_account() to indicate this is a migration entry
> then don't elevate the page count.

It seems not that straightforward. THP split converts PTEs to
migration entries too. So we can't tell if it is real migration or
just in the middle of THP split.

We just need to serialize against THP split for PTE mapped subpages.
So in real life workload it might be ok to skip accounting migration
pages? Typically the migration is a transient state, so the under
accounting should be transient too. Or account migration pages
separately, just like swap entries?

I may revisit this after the holiday. If you have any better ideas,
please feel free to propose.

>
> > refcount, so this:
> >
> >         if (page_count(page) == 1) {
> >                 smaps_page_accumulate(mss, page, size, size << PSS_SHIFT, dirty,
> >                         locked, true);
> >                 return;
> >         }
> >
> > will never trigger.
>
> The get_page_unless_zero() is called after this block.
