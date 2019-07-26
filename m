Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C38BB766A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 14:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfGZMye (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 08:54:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38261 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfGZMyY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:54:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id f5so15938322pgu.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2019 05:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1CV30Ulmhw3UVs5wZJSfxlQX22PQyu6508MpeQYH9hA=;
        b=gQuH0RicdNOowMPYfbO1oCrLPCJQ7RG5vRhySY5uKbNmTPgJ9gjJhxIQlgovgpa61j
         /fesyTgUhfC6NkYtNzLPj9OFsHLRlFOnE6bQDcY/2tkHHiMxdFrnqXA8ZynuSTScFhap
         MsVrgmBpEcAREpwym2Gd4zS7Og3lnANQ201d0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1CV30Ulmhw3UVs5wZJSfxlQX22PQyu6508MpeQYH9hA=;
        b=is/DkbFIBiO1OZGvmWrWhLMSBL8WYRSRhQZR4YKY8yrJPjGLwubO8IaIC1XPFo0Sml
         vMpeqXbha0DXZ69sBQGjnil8nL+KaVjWJJ7O9Jy0Fv1yOoxDWEqGLe0dcMbpl2zmuOqe
         dzpkMPmjdZwgKEN45HbpTMAFVsi2QBmWsjSrYRHitow6Sov5j36FkbfsIlPKNv+ZuAAa
         3mehB4jRXzPDJ1TH9yBKw3pKwaM3B/es30Hvh3dHwTUae0HKxi2noKMinB5V2jLNKi8z
         059nQ51s779XLPzk5UZjVGkkyccgtAG+L6tXDHWVqRhkLIwr4qPMIexcqOz1qyu80+8W
         SFPQ==
X-Gm-Message-State: APjAAAUm6L1nF9p4qNnrtYCpVN6FRAfPwK00VHppDfLY0bwyimVFvkMI
        brBsapS7GWnNHFY+vslcf4k=
X-Google-Smtp-Source: APXvYqzilkkbU1jvUSqJ7GWTJJgame/K3EOovYUFU8dAxa/kz5mkVmVgYiB/rX3VOXqDrSKNafzHjQ==
X-Received: by 2002:a63:ee0c:: with SMTP id e12mr92603350pgi.184.1564145663513;
        Fri, 26 Jul 2019 05:54:23 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o129sm23051451pfg.1.2019.07.26.05.54.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 05:54:22 -0700 (PDT)
Date:   Fri, 26 Jul 2019 08:54:21 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        vdavydov.dev@gmail.com, Brendan Gregg <bgregg@netflix.com>,
        kernel-team@android.com, Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        carmenjackson@google.com, Christian Hansen <chansen3@cisco.com>,
        Colin Ian King <colin.king@canonical.com>, dancol@google.com,
        David Howells <dhowells@redhat.com>, fmayer@google.com,
        joaodias@google.com, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, namhyung@google.com,
        sspatil@google.com
Subject: Re: [PATCH v1 1/2] mm/page_idle: Add support for per-pid page_idle
 using virtual indexing
Message-ID: <20190726125421.GA103959@google.com>
References: <20190722213205.140845-1-joel@joelfernandes.org>
 <20190723061358.GD128252@google.com>
 <20190723142049.GC104199@google.com>
 <20190724042842.GA39273@google.com>
 <20190724141052.GB9945@google.com>
 <c116f836-5a72-c6e6-498f-a904497ef557@yandex-team.ru>
 <20190726000654.GB66718@google.com>
 <9cba9acb-9451-a53e-278d-92f7b66ae20b@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cba9acb-9451-a53e-278d-92f7b66ae20b@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 26, 2019 at 02:16:20PM +0300, Konstantin Khlebnikov wrote:
> On 26.07.2019 3:06, Joel Fernandes wrote:
> > On Thu, Jul 25, 2019 at 11:15:53AM +0300, Konstantin Khlebnikov wrote:
> > [snip]
> > > > > > Thanks for bringing up the swapping corner case..  Perhaps we can improve
> > > > > > the heap profiler to detect this by looking at bits 0-4 in pagemap. While it
> > > > > 
> > > > > Yeb, that could work but it could add overhead again what you want to remove?
> > > > > Even, userspace should keep metadata to identify that page was already swapped
> > > > > in last period or newly swapped in new period.
> > > > 
> > > > Yep.
> > > Between samples page could be read from swap and swapped out back multiple times.
> > > For tracking this swap ptes could be marked with idle bit too.
> > > I believe it's not so hard to find free bit for this.
> > > 
> > > Refault\swapout will automatically clear this bit in pte even if
> > > page goes nowhere stays if swap-cache.
> > 
> > Could you clarify more about your idea? Do you mean swapout will clear the new
> > idle swap-pte bit if the page was accessed just before the swapout? >
> > Instead, I thought of using is_swap_pte() to detect if the PTE belong to a
> > page that was swapped. And if so, then assume the page was idle. Sure we
> > would miss data that the page was accessed before the swap out in the
> > sampling window, however if the page was swapped out, then it is likely idle
> > anyway.
> 
> 
> I mean page might be in swap when you mark pages idle and
> then been accessed and swapped back before second pass.
> 
> I propose marking swap pte with idle bit which will be automatically
> cleared by following swapin/swapout pair:
> 
> page alloc -> install page pte
> page swapout -> install swap entry in pte
> mark vm idle -> set swap-idle bit in swap pte
> access/swapin -> install page pte (clear page idle if set)
> page swapout -> install swap entry in pte (without swap idle bit)
> scan vm idle -> see swap entry without idle bit -> page has been accessed since marking idle
> 
> One bit in pte is enough for tracking. This does not needs any propagation for
> idle bits between page and swap, or marking pages as idle in swap cache.

Ok I see the case you are referring to now. This can be a follow-up patch to
address the case, because.. the limitation you mentioned is also something
inherrent in the (traditional) physical page_idle tracking if that were used.
The reason being, after swapping, the PTE is not mapped to any page so there
is nothing to mark as idle. So if the page gets swapped out and in in the
meanwhile, then you would run into the same issue.

But yes, we should certainly address it in the future. I just want to keep
things simple at the moment. I will make a note about your suggestion but you
are welcomed to write a patch for it on top of my patch. I am about to send
another revision shortly for futhre review.

thanks,

 - Joel

