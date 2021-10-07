Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC25424BE5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 04:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbhJGCt2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 22:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbhJGCt1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 22:49:27 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34D5C061746;
        Wed,  6 Oct 2021 19:47:33 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x7so16540751edd.6;
        Wed, 06 Oct 2021 19:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VyqxLGwIUlQqC1Zl70rnuaga2NhkHcEvoeQooiZvHpc=;
        b=KpYpF99/J1U8AB4Yg+f9FLyspi817QPhOlycUj58ufDQZjblYuPUQE03e57iuzjqLu
         8oaXnl5GS4Fbr3eRlxseg91/g6YAgVck0VmK+0lUjc0ikXDnuB97yUYcv8KeQABV5wEo
         ZGYywMcMgm2paHxMYLqXK3/DIa2OoctbhkxgzarElrIoLgLczf+U1522/KHZCJStU0pD
         t6HugBhmK4OFi0WmAi8my9HfvvhgoDfqOSQdrAE34a8eIHGzCBlozTcqMUEc/6mOPoXy
         tr4dYRaVAcSCo4sDGCROFa6mNHYCxhTfMH/Y2mK/xemucQ6lnkcN6N181hChnYyYvVTB
         fkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VyqxLGwIUlQqC1Zl70rnuaga2NhkHcEvoeQooiZvHpc=;
        b=GmWeTr4FOz0y/FJUeDpkEN/DLXNkiYx19kCnxYzel/V+Yg/BQd5HQA3RchkYQ3rfh/
         1Uo5y9qa9/5YHDea3+VLjIao3Z6rJ5TiWhR7x90BmER6X4cJn+nAM5GKgZhNfHgTQkhV
         dIsY+rhzdo2BxsQsSdqIimBMVfkGjnjy/DwSdIIn8CRpZyoDHHGeq4Psmf4CG/KHVD+Z
         LVL/XjU9xso4tRnmLULCfFxEf3w+yKnJBxTu0T/4owwKunIk7nxJYlMhY9Karit5JEe8
         tDiMQD6JuPCDfkDWsvuX52g5PVcSE0NYuC0gWTlVIa8I3FRjI2lVDK+VigXi3Tt5D4/9
         kLzA==
X-Gm-Message-State: AOAM533/zCpxZ7S3vuyzFH1Qg084qvH0/357anKeUgo/flbjVmggvgJ3
        RrktsM9RhwGHOL8fVnv1f9l/C8v6s21j89t98Rop+bv7V+Y=
X-Google-Smtp-Source: ABdhPJw+gjwOXm4udeiroALI6GqG2qKHnZUWg6Wg2e0RBEhgFKnvwFQdmdDL021sW7ojKqbyvtYBBJf1jeD8T1fBP4I=
X-Received: by 2002:a05:6402:1b11:: with SMTP id by17mr2549661edb.71.1633574852376;
 Wed, 06 Oct 2021 19:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215311.240774-1-shy828301@gmail.com> <20210930215311.240774-4-shy828301@gmail.com>
 <YV4c1dOfctEMnH2s@t490s>
In-Reply-To: <YV4c1dOfctEMnH2s@t490s>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 6 Oct 2021 19:47:20 -0700
Message-ID: <CAHbLzkqtaF2iFwg0TmMm_1q+o+-O=CXAAPY2izxL6N=8umX_Cg@mail.gmail.com>
Subject: Re: [v3 PATCH 3/5] mm: hwpoison: refactor refcount check handling
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

On Wed, Oct 6, 2021 at 3:02 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Sep 30, 2021 at 02:53:09PM -0700, Yang Shi wrote:
> > +/*
> > + * Return true if page is still referenced by others, otherwise return
> > + * false.
> > + *
> > + * The dec is true when one extra refcount is expected.
> > + */
> > +static bool has_extra_refcount(struct page_state *ps, struct page *p,
> > +                            bool dec)
>
> Nit: would it be nicer to keep using things like "extra_pins", so we pass in 1
> for swapcache dirty case and 0 for the rest?  Then it'll also match with most
> of the similar cases in e.g. huge_memory.c (please try grep "extra_pins" there).

Thanks for the suggestion. Yes, it makes some sense to me. And the
code comments in patch 4/5 does says (the suggested version by Naoya):

/*
 * The shmem page is kept in page cache instead of truncating
 * so is expected to have an extra refcount after error-handling.
 */

Will rename it in the new version.

>
> > +{
> > +     int count = page_count(p) - 1;
> > +
> > +     if (dec)
> > +             count -= 1;
> > +
> > +     if (count > 0) {
> > +             pr_err("Memory failure: %#lx: %s still referenced by %d users\n",
> > +                    page_to_pfn(p), action_page_types[ps->type], count);
> > +             return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> >  /*
> >   * Error hit kernel page.
> >   * Do nothing, try to be lucky and not touch this instead. For a few cases we
> >   * could be more sophisticated.
> >   */
> > -static int me_kernel(struct page *p, unsigned long pfn)
> > +static int me_kernel(struct page_state *ps, struct page *p)
>
> Not sure whether it's intended, but some of the action() hooks do not call the
> refcount check now while in the past they'll all do.  Just to double check
> they're expected, like this one and me_unknown().

Yeah, it is intentional. Before this change all me_* handlers did
check refcount even though it was not necessary, for example,
me_kernel() and me_unknown().

>
> >  {
> >       unlock_page(p);
> >       return MF_IGNORED;
> > @@ -820,9 +852,9 @@ static int me_kernel(struct page *p, unsigned long pfn)
> >  /*
> >   * Page in unknown state. Do nothing.
> >   */
> > -static int me_unknown(struct page *p, unsigned long pfn)
> > +static int me_unknown(struct page_state *ps, struct page *p)
> >  {
> > -     pr_err("Memory failure: %#lx: Unknown page state\n", pfn);
> > +     pr_err("Memory failure: %#lx: Unknown page state\n", page_to_pfn(p));
> >       unlock_page(p);
> >       return MF_FAILED;
> >  }
>
> Thanks,
>
> --
> Peter Xu
>
