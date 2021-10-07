Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF434425A8B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 20:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243559AbhJGSVY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 14:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbhJGSVX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:21:23 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4769BC061570;
        Thu,  7 Oct 2021 11:19:29 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id l7so26600506edq.3;
        Thu, 07 Oct 2021 11:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iLeSFUziBQBa2nfyLYU7/W4j+xBwKu7dSm2xdvN4YL4=;
        b=m8okmC3zr7UD9/li1nvBU2McS2L9K4AnobrF92DJzJ9Z9tffjsHoSEuW+70rUZvQMN
         AdcMSJJeZ4ZNvPIRAlqPGej2NlOHfSmJICDdNQgH/RpdSkyZfXsG8EKam4pcUn9IyT9s
         5kJRYQGC9ejisi2qDiyq3DFRwiYYrkG/iNw4UAlFIZVkn/y6FfgKGZYBJGEBBvl6OzQh
         lhQMKI95h37zzezwhmFmIazKpRkpY7SDm612HQKvua2Vrzjl3pgSG9KcAJx5FOLl0boW
         H3jkue6ubrw2SwsdhyhLbt38/7/6b89HifwYOw7fuaEZQGx5GB88NOdRLIkde16ipsdc
         XdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iLeSFUziBQBa2nfyLYU7/W4j+xBwKu7dSm2xdvN4YL4=;
        b=v8kxt76PzGIJ5Yvb4z9vZ+Qv218tnCXzGWBKCedSAITnB+H7P9WpMEGYC4gCGqeBLO
         qZN5baoT0p5Xd5LTpA6NGr6uz4dXkpEBHS1DDJAb/vD9huU1QdXbxZYgHEQJUWXpdNjD
         QlasByzab0tCzT1TDoonoEXbbA5yJ5B95Hx+BFMrGxZ05Cls+admytaekWwU+tdb7dcR
         g4bvpJJQSd8N1BziH+/tgOkNBmCc4b9wPf3FfsOtggcjL4WxXRHGwmDjVCEiXFuJWK4c
         oLt5EJWOdtGYVC+rOaF5xUAr7uKKu8LoCNtQWBIBDWq7FxvMFLXmb9ArZ9H72CM6Zcs6
         EFTA==
X-Gm-Message-State: AOAM531lv3lzGnsBqn4/ZHMRV8w/afHnRuLv1DRV3Jnm8SiJI8hDUGAi
        1A60xa+/tXIhuA/Zsr+joObQEmibOEt4YdL5cYo=
X-Google-Smtp-Source: ABdhPJxoNh6UJJ8wPJQfMSzbLWFicPr+jLK/UU9HxPMV70hLqQy0n9zs3d+z/584Rcc28s0HGFyu+/EKZhfBZCyFhN8=
X-Received: by 2002:a50:e044:: with SMTP id g4mr8162515edl.46.1633630767900;
 Thu, 07 Oct 2021 11:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215311.240774-1-shy828301@gmail.com> <20210930215311.240774-3-shy828301@gmail.com>
 <YV4Dz3y4NXhtqd6V@t490s> <CAHbLzkp8oO9qvDN66_ALOqNrUDrzHH7RZc3G5GQ1pxz8qXJjqw@mail.gmail.com>
 <YV8bChbXop3FuwPC@t490s>
In-Reply-To: <YV8bChbXop3FuwPC@t490s>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 7 Oct 2021 11:19:15 -0700
Message-ID: <CAHbLzkq-18rDvfVepNTfKzPbb0+Tg9S=bwFCgjXGv0RxgouptA@mail.gmail.com>
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

On Thu, Oct 7, 2021 at 9:06 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Oct 06, 2021 at 04:57:38PM -0700, Yang Shi wrote:
> > > For example, I see that both unpoison_memory() and soft_offline_page() will
> > > call it too, does it mean that we'll also set the bits e.g. even when we want
> > > to inject an unpoison event too?
> >
> > unpoison_memory() should be not a problem since it will just bail out
> > once THP is met as the comment says:
> >
> > /*
> > * unpoison_memory() can encounter thp only when the thp is being
> > * worked by memory_failure() and the page lock is not held yet.
> > * In such case, we yield to memory_failure() and make unpoison fail.
> > */
>
> But I still think setting the subpage-hwpoison bit hides too deep there, it'll
> be great we can keep get_hwpoison_page() as simple as a safe version of getting
> the refcount of the page we want.  Or we'd still better touch up the comment
> above get_hwpoison_page() to show that side effect.
>
> >
> >
> > And I think we should set the flag for soft offline too, right? The
>
> I'm not familiar with either memory failure or soft offline, so far it looks
> right to me.  However..
>
> > soft offline does set the hwpoison flag for the corrupted sub page and
> > doesn't split file THP,
>
> .. I believe this will become not true after your patch 5, right?

But THP split may fail, right?

>
> > so it should be captured by page fault as well. And yes for poison injection.
>
> One more thing: besides thp split and page free, do we need to conditionally
> drop the HasHwpoisoned bit when received an unpoison event?

It seems not to me, as the above comment from unpoison_memory() says
unpoison can encounter thp only when the thp is being worked by
memory_failure() and the page lock is not held yet. So it just bails
out.

In addition, unpoison just works for software injected errors, not
real hardware failure.

>
> If my understanding is correct, we may need to scan all the subpages there, to
> make sure HasHwpoisoned bit reflects the latest status for the thp in question.
>
> >
> > But your comment reminds me that get_hwpoison_page() is just called
> > when !MF_COUNT_INCREASED, so it means MADV_HWPOISON still could
> > escape. This needs to be covered too.
>
> Right, maybe that's also a clue that we shouldn't set the new page flag within
> get_hwpoison_page(), since get_hwpoison_page() is actually well coupled with
> MF_COUNT_INCREASED and all of them are only about refcounting of the pages.

Yeah, maybe, as long as there is not early bail out in some error
handling paths.

>
> --
> Peter Xu
>
