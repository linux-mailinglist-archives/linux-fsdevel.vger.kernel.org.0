Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3851D1BB635
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 08:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgD1GLW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 02:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726413AbgD1GLV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:11:21 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86182C03C1AA
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 23:11:19 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id l11so15876114lfc.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 23:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fjR2WXsg1WuSqX8WD5c+nhnalPJJVRAV+Xn9CSGG1bY=;
        b=cdP0uVyDLEuTHWB46kef943mTKZiv/Grb+3pidmYUxbnYjhqmBibE45csv9aQ88lot
         AJ3IDfIwUFyKZ0ltlC/7Xz/eIBrBQ9fKuiYosWuO9jxHiT7plltOgrcHcyVpxe7QmbFJ
         +/ZAj1QUE0+7MbjnRNVVxQdmpxWa3++ZAydGa9ZaoAwMf5FQMxsgbkOQjpNYPiBk1sY+
         4yiGOkjuYSnheFG1MggDO6unAQSkGnM4raGCF4V8kQa2tBeFbthnB+CXJOmDktWBOEtl
         eTb5TN7/Nnq4dr6LqUU6zAA7IbwWt3mzS4YUp1+NK/1MBrYrdLqkTHc4pCWe0R/ARh+9
         +0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fjR2WXsg1WuSqX8WD5c+nhnalPJJVRAV+Xn9CSGG1bY=;
        b=nBuhdUZ/rDKQzR4HD47gATEizKEUO+t6J09W99WpzY5BXhK13vJD2kLDBEhvfoid1O
         xhqAX8fLjWnuul2FHIJrUX/cr8+B/g13d43bcdmQLCdQFoY3l3rkqUdqjDz+Ac+kvNXa
         BJcdr0BXCRjf3MY5df+H3kq4b8PW3LbRZ1fhAoa82Ze79XV9cswuv7XEpkUdzrqvb20L
         3vO8VC2plnwVJ+PF9ojWgtZBM7j9GayPqQFOsFR8rjOvByR0n5P8g2OA28t3+kWnjfLa
         Fk29/RT7gZU/iL00ROCMBkHnAEDBW20vzvtNc7W1MxLAiPM+WfIjx0awIZomq2b+iko9
         14kw==
X-Gm-Message-State: AGi0PubegHdNir8jeIt7EOi0rM4w+i3TEPPjoiR3Jh0ceKwqTJTEb6Z5
        oDXw6Uba/JsNdp6qvfmQfgx3pNZSwZzyaC7ycfEIjg==
X-Google-Smtp-Source: APiQypLIie/TYTkh1e9E9TFpjYomoyBZT+NMzXY2V+G8zBhTAdtjDWAqu5o9w5HGdoenyRP931MOYycHK/t36nWbs+Q=
X-Received: by 2002:a19:e04a:: with SMTP id g10mr17744131lfj.164.1588054277719;
 Mon, 27 Apr 2020 23:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200428032745.133556-1-jannh@google.com> <20200428032745.133556-6-jannh@google.com>
 <CAHk-=wgBNSQhH1gyjo+Z2NFy4tOQnBQB4rra-jh+3XTpOjnThQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgBNSQhH1gyjo+Z2NFy4tOQnBQB4rra-jh+3XTpOjnThQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 28 Apr 2020 08:10:51 +0200
Message-ID: <CAG48ez3kLgXQBOnSJJ+XuYpM__XnKc_AqJMoiPBhFbTdmoWxag@mail.gmail.com>
Subject: Re: [PATCH 5/5] mm/gup: Take mmap_sem in get_dump_page()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 5:50 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Apr 27, 2020 at 8:28 PM Jann Horn <jannh@google.com> wrote:
> >
> > Properly take the mmap_sem before calling into the GUP code from
> > get_dump_page(); and play nice, allowing __get_user_pages_locked() to drop
> > the mmap_sem if it has to sleep.
>
> This makes my skin crawl.
>
> The only reason for this all is that page cache flushing.
>
> My gut feeling is that it should be done by get_user_pages() anyway,
> since all the other users presumably want it to be coherent in the
> cache.
>
> And in fact, looking at __get_user_pages(), it already does that
>
>                 if (pages) {
>                         pages[i] = page;
>                         flush_anon_page(vma, page, start);
>                         flush_dcache_page(page);
>                         ctx.page_mask = 0;
>                 }
>
> and I think that the get_dump_page() logic is unnecessary to begin with.

Ah! And even though flush_cache_page() is broader than
flush_dcache_page(), that's actually unnecessary, right? Since the
kernel only wants to read from the page, and therefore e.g. the icache
is irrelevant?

Yay! :) I did think this was a bit gnarly, and it's nice to know that
this can be simplified.

(And now I'm going to avert my eyes from the GUP code before I start
thinking too hard about how much it sucks that FOLL_LONGTERM doesn't
drop the mmap_sem across the access and how much I dislike the whole
idea of FOLL_LONGTERM in general...)
