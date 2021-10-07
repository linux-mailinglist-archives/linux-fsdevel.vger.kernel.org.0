Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59371425D38
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 22:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhJGU3U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 16:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhJGU3T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 16:29:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBC1C061570;
        Thu,  7 Oct 2021 13:27:25 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v18so28036926edc.11;
        Thu, 07 Oct 2021 13:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=meVJZ/Jk9W+dixJB/LuoRy3/ra68qi2MQkPwKdp2JR0=;
        b=dC3cFYY77OUrg+THR4IJ3I2oKuVLU5NSml5IEdGdu6ALMQsgw7cGj1UOTk+KnVafC8
         WmMnI2+MGrYTNPMEsAYvM4Zu3CRhN0teC0n5DOZhRZciYUG0Fetg16qbxTcZSNhMU3Tp
         JujjjOUoFS9YamfOmoBzKq+V5TbhO0vk9t7lUAk4L0/vHkvXFyak1xXYvDGIebJ23aq2
         hi3trJbkmsgYlk7Khk9I6T4vZwH4CJZBuaCXtD+hptTOB3SCIMtJkwQ0mkb5DMCW6IZd
         nJkx8OiRHss3dQDysCNPuNadNVY6furpZhVuSqTjCWtr3RfsdfqzJJkpTiDpXQsGaCUT
         1+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=meVJZ/Jk9W+dixJB/LuoRy3/ra68qi2MQkPwKdp2JR0=;
        b=BM/9pA0Agfuq5w7F1CJeSiWoJjirD4EQtH4zT0U2gDI1pI7VVsmTPzBQwHn4S6ZOv1
         8azR8CS+FGhqgAnng5GyxWVAhaiI9C9wAsk5bl07fqV+gljE9Vs8f6mkqS875DceAU82
         LVIt8ZK9dbR0d9N7uZVPr0l9gJdYlDI33hkpF27Rx4d/s3GX33ckOZvHHDrxTKW+PuPN
         TdyFsoldK2Do0OWRhPP+XLCtM4RKgGmSLFOWlL86ujY6jZ3uSTgLrD86yyKDVaxyjnII
         Lb76GmFAFfIfBqxFuNaelc0jSohaCMk5G5+CzRS1ghCJCimfUkeTaPOUlT0CoGlt1nHb
         Qq0A==
X-Gm-Message-State: AOAM530H2ZyCHYriK/I3q00Xc5n6kTvxNBiChxwaMsfCq00ezD8o1Bc3
        E4OBS8X5WYHwSZJRIVhDoGv8WBzhG4DizJnUwBE=
X-Google-Smtp-Source: ABdhPJyVJJHP5DLZjFy9sZ2fQ4TiUIi7xOmAIdHWsergF9thozLAZHG3qA9EUTfaiTDl1+7P+HlIL3WfongsKIaiFx8=
X-Received: by 2002:a17:906:c2ca:: with SMTP id ch10mr5567576ejb.311.1633638443670;
 Thu, 07 Oct 2021 13:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215311.240774-1-shy828301@gmail.com> <20210930215311.240774-3-shy828301@gmail.com>
 <YV4Dz3y4NXhtqd6V@t490s> <CAHbLzkp8oO9qvDN66_ALOqNrUDrzHH7RZc3G5GQ1pxz8qXJjqw@mail.gmail.com>
 <YV8bChbXop3FuwPC@t490s> <CAHbLzkq-18rDvfVepNTfKzPbb0+Tg9S=bwFCgjXGv0RxgouptA@mail.gmail.com>
In-Reply-To: <CAHbLzkq-18rDvfVepNTfKzPbb0+Tg9S=bwFCgjXGv0RxgouptA@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 7 Oct 2021 13:27:11 -0700
Message-ID: <CAHbLzkoRtASPUejXwDJOd9794hXyC9pnccwO1hx8sanpoTECtQ@mail.gmail.com>
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
To:     Peter Xu <peterx@redhat.com>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 7, 2021 at 11:19 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Thu, Oct 7, 2021 at 9:06 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Wed, Oct 06, 2021 at 04:57:38PM -0700, Yang Shi wrote:
> > > > For example, I see that both unpoison_memory() and soft_offline_page() will
> > > > call it too, does it mean that we'll also set the bits e.g. even when we want
> > > > to inject an unpoison event too?
> > >
> > > unpoison_memory() should be not a problem since it will just bail out
> > > once THP is met as the comment says:
> > >
> > > /*
> > > * unpoison_memory() can encounter thp only when the thp is being
> > > * worked by memory_failure() and the page lock is not held yet.
> > > * In such case, we yield to memory_failure() and make unpoison fail.
> > > */
> >
> > But I still think setting the subpage-hwpoison bit hides too deep there, it'll
> > be great we can keep get_hwpoison_page() as simple as a safe version of getting
> > the refcount of the page we want.  Or we'd still better touch up the comment
> > above get_hwpoison_page() to show that side effect.
> >
> > >
> > >
> > > And I think we should set the flag for soft offline too, right? The
> >
> > I'm not familiar with either memory failure or soft offline, so far it looks
> > right to me.  However..
> >
> > > soft offline does set the hwpoison flag for the corrupted sub page and
> > > doesn't split file THP,
> >
> > .. I believe this will become not true after your patch 5, right?
>
> But THP split may fail, right?
>
> >
> > > so it should be captured by page fault as well. And yes for poison injection.
> >
> > One more thing: besides thp split and page free, do we need to conditionally
> > drop the HasHwpoisoned bit when received an unpoison event?
>
> It seems not to me, as the above comment from unpoison_memory() says
> unpoison can encounter thp only when the thp is being worked by
> memory_failure() and the page lock is not held yet. So it just bails
> out.
>
> In addition, unpoison just works for software injected errors, not
> real hardware failure.
>
> >
> > If my understanding is correct, we may need to scan all the subpages there, to
> > make sure HasHwpoisoned bit reflects the latest status for the thp in question.
> >
> > >
> > > But your comment reminds me that get_hwpoison_page() is just called
> > > when !MF_COUNT_INCREASED, so it means MADV_HWPOISON still could
> > > escape. This needs to be covered too.
> >
> > Right, maybe that's also a clue that we shouldn't set the new page flag within
> > get_hwpoison_page(), since get_hwpoison_page() is actually well coupled with
> > MF_COUNT_INCREASED and all of them are only about refcounting of the pages.
>
> Yeah, maybe, as long as there is not early bail out in some error
> handling paths.

It seems fine to move setting the flag out of get_hwpoison_page() to
right before splitting THP so that both MF_COUNT_INCREASED and
!MF_COUNT_INCREASED could be covered.


>
> >
> > --
> > Peter Xu
> >
