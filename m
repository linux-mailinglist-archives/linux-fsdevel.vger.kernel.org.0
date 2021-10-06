Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD8F42456F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 19:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238607AbhJFR62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 13:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJFR61 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:58:27 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57FAC061746;
        Wed,  6 Oct 2021 10:56:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v18so13002409edc.11;
        Wed, 06 Oct 2021 10:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rbo4sz5z/Bg+L8m1ke86c0jRFq2OLQpo8IrWWnxklGU=;
        b=HO6IWcH/IfJo+CoGp1Una4s+S2+rLH2FmUn+lN6vUniP/xGDotpdNz40IcjXtwzU9d
         rf5y8tM/EXpmjmrJ4UDoJcra8mw1WzR8y1pG6RNyQYQhAnvaYUbbb5tvx5QquVNpCUNk
         1xessOwH6vlLWgOOdhLVjWU7XkFhxpCh8O8vE/rUOSqYA8Fx+P1Y/ZKanAhl1UxOnqF3
         RGUrLdX1aguBrTEKV4Kqn3Nv2UMWFO/IeXCOcQazm4vzJZqHAAEWd/UFFWIQ2XTfjlsW
         jFmh0eo8WSycRPxIp+q2xzvCaGSo7MCrjL1u4+qKr8+5V8rrH+uW/VvvTTPIuRgfuHmn
         l+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rbo4sz5z/Bg+L8m1ke86c0jRFq2OLQpo8IrWWnxklGU=;
        b=GJc7f0FRY3aLFHqfzAfNVKJoynbqUEQ5uhmpf2FA8SMg//De46hyqwToz1Ozj9FyuQ
         JiZwxXNGZkemu3+yAaOp1HFnxN7w/nTsvPT/BJf8Y1Qzl7QO4VrtjRFfs6HRFPWpMD76
         IHBlI8eZfJf3KQVVjP9SaxeAZagzfSTAQPZBLJqhnhFiSC8sU5RRDoObrRwBBdlEv6ln
         P4Esfrjx8WUGMgNGnBRC81evW77bDSsqnDC3EVDUSndHGPhn4nDHANVsyhUhklxDx6Hg
         9DDRDi9T5LR3z5A6n7HCWXpStIFt+OmyxmVJDwnOM4SYM3NNJmFzEamIBOQ+Piy3UrZD
         Bh5A==
X-Gm-Message-State: AOAM531a3j05XDirgprHKH6Zw8+DvLXa1Wy4vYZRXe4fPX3C9QsJpc9h
        xFlnoUoHJ+/v4cLtPOhRj4X31j2IBQRRww/j04U=
X-Google-Smtp-Source: ABdhPJzp0acRHHskEYsBvbxPz9IoLtl30CeTbkk3WoqTzpqdTyb5xu3ViyhTgx0EeKUAAg9pOYn/1eHUtm3RRBz/Rx4=
X-Received: by 2002:a50:e044:: with SMTP id g4mr35693289edl.46.1633542993549;
 Wed, 06 Oct 2021 10:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215311.240774-1-shy828301@gmail.com> <20210930215311.240774-2-shy828301@gmail.com>
 <CAHbLzkpyxnvm3w0M_CEU7cYRCYr0coNCoiY1DvtnBzqb1R1nsw@mail.gmail.com> <20211006040015.GA1626563@u2004>
In-Reply-To: <20211006040015.GA1626563@u2004>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 6 Oct 2021 10:56:20 -0700
Message-ID: <CAHbLzkrEt3Ukr8YsJzx7AUdx7od2mqTKcG-D2sJAjo1RVs5e=w@mail.gmail.com>
Subject: Re: [v3 PATCH 1/5] mm: hwpoison: remove the unnecessary THP check
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 5, 2021 at 9:00 PM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> > Any comment on this patch and patch #3? I'd prefer to fix more
> > comments for a new version.
>
> No. Both 1/5 and 3/5 look fine to me. So ...
>
> > On Thu, Sep 30, 2021 at 2:53 PM Yang Shi <shy828301@gmail.com> wrote:
> > >
> > > When handling THP hwpoison checked if the THP is in allocation or free
> > > stage since hwpoison may mistreat it as hugetlb page.  After
> > > commit 415c64c1453a ("mm/memory-failure: split thp earlier in memory error
> > > handling") the problem has been fixed, so this check is no longer
> > > needed.  Remove it.  The side effect of the removal is hwpoison may
> > > report unsplit THP instead of unknown error for shmem THP.  It seems not
> > > like a big deal.
> > >
> > > The following patch depends on this, which fixes shmem THP with
> > > hwpoisoned subpage(s) are mapped PMD wrongly.  So this patch needs to be
> > > backported to -stable as well.
> > >
> > > Cc: <stable@vger.kernel.org>
> > > Suggested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > > Signed-off-by: Yang Shi <shy828301@gmail.com>
>
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>
> Patch 3/5 already has my Signed-off-by, so I think it can be considered
> as acked by me.

Aha, thanks. I will add your ack to patch 3/5 too.

>
> Thanks,
> Naoya Horiguchi
