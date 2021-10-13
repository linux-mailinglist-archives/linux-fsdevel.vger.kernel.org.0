Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A61E42B394
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 05:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbhJMDbU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 23:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237377AbhJMDbQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:31:16 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B98BC061746;
        Tue, 12 Oct 2021 20:29:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a25so4116784edx.8;
        Tue, 12 Oct 2021 20:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQNzKhmWO0HGdKOXS89qG3A9ZaAzZaeuitB9xg0P9Ao=;
        b=f6qT0uRPXcqOGtMmEVof+51Xl5cKE7prSFUJeMauW7N+C6L3sOqFGwT1ekFZJhEd70
         vPMywWIudQiUiWUNOVO+yNZVwEQlW4GoGW4O+vqMQTrALs/WY3S45JSTlVEdKOIB/VYQ
         h40sKy7usu9bba4pLDqe2E6E8CHUZpCu1h1hoUbny22Z/B3p5EugiLiZ4+Fi2zeb8nz1
         HeeDLamf+P9B/350ATB4/JzLBEWcB6+ET8QxSQ+GQCe2DhIvyeD9vHUfxgdDxMnZ8abz
         HDfsV+HjTFt9WhpqUOe8LvuF+ez5Qj3fuVOw8eiKpL1xPAApMg9h4zWETOa6NNRUY9V4
         jFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQNzKhmWO0HGdKOXS89qG3A9ZaAzZaeuitB9xg0P9Ao=;
        b=6m2adtmo3ihGtF8rvZaSHRrLPHvCT4vjj3cVEndnwam2TpC3E/ViJuJdEI4Z9WUheb
         s336rj163WBJ65nuajf/6+iQQaqaNMozH6ymlLMr3IcBqqzWu+airxvAmcEO/6XHd2+j
         OV4uxoGLTbeCHHwaC9HWDqNWf1Duk0QEnlLzvkaEwn4GdRbSzAIbMKSQ9WpbOFlfExP8
         R73SxBu0g15dzwdMPDleVeoQczh7lvvFc8od3fUTF+2Y/OJS9wslvSeU3XVPYgI/8bhT
         SDJTEbrFXs7oEQwkQkIT3QVlKXtqS5ohoCGk9WTjRrPbSDl+AbXksYFSl6LfxHnARZFR
         Dnrg==
X-Gm-Message-State: AOAM533FXh3YfdVDrI14v+DPStJoSrwwlBSdgQG2gzReF7/171tt4WEi
        lynOY1KuLitt7jdQgLXdjW6PHS8KbRyWI+mVmkqeNcdo
X-Google-Smtp-Source: ABdhPJxvk0vJYLQJ1vV4YH05l7GLiZPOWUjnKHqMswz4TzPRmLJueLbEJU0nSPkZJevYe2sl2IKfRHRcOVTIpDwYWKo=
X-Received: by 2002:a17:907:2bdf:: with SMTP id gv31mr38358350ejc.521.1634095752792;
 Tue, 12 Oct 2021 20:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215311.240774-1-shy828301@gmail.com> <20210930215311.240774-5-shy828301@gmail.com>
 <YWTrbgf0kpwayWHL@t490s> <CAHbLzkrJ9YZYUS+T64L9vFzg77qVg2SZ4DBGC013kgGTRvpieA@mail.gmail.com>
 <YWYLr3vOTgLDNiNL@t490s> <CAHbLzkrYBpbDN4QHGP_HYwcoxOxOpEK1Q=mUxcos3MtdZ5fEzw@mail.gmail.com>
 <YWZNTUT4HQzdekzt@t490s>
In-Reply-To: <YWZNTUT4HQzdekzt@t490s>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 12 Oct 2021 20:29:01 -0700
Message-ID: <CAHbLzko=_ycgcLrR_70XAAQuJbmpKgXKR5SfxEoFVZADYG+4Pw@mail.gmail.com>
Subject: Re: [v3 PATCH 4/5] mm: shmem: don't truncate page if memory failure happens
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

On Tue, Oct 12, 2021 at 8:07 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Oct 12, 2021 at 08:00:31PM -0700, Yang Shi wrote:
> > The page refcount could stop collapsing hwpoison page. One could argue
> > khugepaged could bail out earlier by checking hwpoison flag, but it is
> > definitely not a must do. So it relies on refcount now.
>
> I suppose you mean the page_ref_freeze() in collapse_file()?  Yeah that seems
> to work too.  Thanks,

Yes, exactly.

>
> --
> Peter Xu
>
