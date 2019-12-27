Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A98312B020
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 02:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfL0BMB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 20:12:01 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33960 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfL0BMB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 20:12:01 -0500
Received: by mail-io1-f65.google.com with SMTP id z193so24543619iof.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2019 17:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2yY3FjVteeoVVTl55LcBKOn6wVKD6QJ7uHyRGPTrzgQ=;
        b=vD2Hd6zWOvuHyJvyDaDjfl3WLQf1/qcvTFLz5ogFx96fXyJMYV+2sD4q9VBjqzABBX
         Crq/P9bpJpzCz9NFU9NOCLc/RLZ7EkYG396dK/ibBZ97x37fX6upIUPC08v8ToC46jPx
         2Oy6aWunbJ0ynSD1NRrGZKJpLGf6VmHo31hISDhznVznbRxdfmDFnD630p4Ue3PhXvsQ
         t/at7gqV+fIcpVmH1TjCCnqlQm26sPFkcgku3pRj6HPAltyvw0mQ8gcKBq7zhZwc/QMp
         LuzXmk7dxbDykR3a5bX1zLhIJAAU9/4GMM0MnWp3pFU37UZ1jHsnJuWM120vJcCfmvmM
         TRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2yY3FjVteeoVVTl55LcBKOn6wVKD6QJ7uHyRGPTrzgQ=;
        b=KkZBcfNhe+SlbAGC47UuTN9hwY+SNmimIog555Ucj2IhPChFZT97r/Na6xSbvyJGDE
         EI+p6t97tVWrvKcYMEX9IED8bu72RuiaMChtLU47WFSgqoyIZrOPwRwcNRcEvyWIhhS6
         axt8+MCczOiJe73QRbBe29w4V6wHFVJxQrNdq0+0S2QjEeoUJWknE2wc4F58iQ0ADDpT
         cS9fDkUJSRDjA5IyQ3zUqxmE+9BBQNcWqOYO5GFYifJRPcpkYgCKgZ/+bA+y5R2QCmW9
         eqhUNdH6wwgUFlKrkCOS2wqTbzzuQVXuvU0wbBEqcmEfyobfnM695YwImmtPm6aqeZy1
         iefQ==
X-Gm-Message-State: APjAAAWMi0Bqz64nhZJu1Mg6DMCNY10Zuw/MdRsncLo+SvU2JlPsW2ma
        VQwcTaBSp/3SBg0n8B07IJv/JRu+bxdvOf1JF/M=
X-Google-Smtp-Source: APXvYqy49XK//UQ4rOBQozBYu7EAzrh1qYFqJ52S6XJAjtFutn8sx3rREpV2ya+MWOMSkxvxlbIMaan3xGauP35kbhA=
X-Received: by 2002:a6b:5503:: with SMTP id j3mr32572357iob.142.1577409120458;
 Thu, 26 Dec 2019 17:12:00 -0800 (PST)
MIME-Version: 1.0
References: <1577174006-13025-1-git-send-email-laoar.shao@gmail.com>
 <1577174006-13025-4-git-send-email-laoar.shao@gmail.com> <20191226214539.GC22734@tower.dhcp.thefacebook.com>
In-Reply-To: <20191226214539.GC22734@tower.dhcp.thefacebook.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 27 Dec 2019 09:11:24 +0800
Message-ID: <CALOAHbDK6EZopmpgirgm-h=EFcFtZg8HK22D98eeL_w1fgBFAg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm, memcg: reset memcg's memory.{min, low} for
 reclaiming itself
To:     Roman Gushchin <guro@fb.com>
Cc:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Chris Down <chris@chrisdown.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 27, 2019 at 5:46 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Dec 24, 2019 at 02:53:24AM -0500, Yafang Shao wrote:
> > memory.{emin, elow} are set in mem_cgroup_protected(), and the values of
> > them won't be changed until next recalculation in this function. After
> > either or both of them are set, the next reclaimer to relcaim this memcg
> > may be a different reclaimer, e.g. this memcg is also the root memcg of
> > the new reclaimer, and then in mem_cgroup_protection() in get_scan_count()
> > the old values of them will be used to calculate scan count, that is not
> > proper. We should reset them to zero in this case.
> >
> > Here's an example of this issue.
> >
> >     root_mem_cgroup
> >          /
> >         A   memory.max=1024M memory.min=512M memory.current=800M
> >
> > Once kswapd is waked up, it will try to scan all MEMCGs, including
> > this A, and it will assign memory.emin of A with 512M.
> > After that, A may reach its hard limit(memory.max), and then it will
> > do memcg reclaim. Because A is the root of this reclaimer, so it will
> > not calculate its memory.emin. So the memory.emin is the old value
> > 512M, and then this old value will be used in
> > mem_cgroup_protection() in get_scan_count() to get the scan count.
> > That is not proper.
>
> Good catch!
>
> But it seems to be a bug introduced with the implementation of the proportional
> reclaim. So I'd remove it from the patchset, add the "Fixes" tag and cc stable@.
> Then it will have chances to be backported to stable trees.
>

Sure, will do it.

Thanks!

>
> >
> > Cc: Chris Down <chris@chrisdown.name>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  mm/memcontrol.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index f35fcca..2e78931 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6287,8 +6287,17 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
> >
> >       if (!root)
> >               root = root_mem_cgroup;
> > -     if (memcg == root)
> > +     if (memcg == root) {
> > +             /*
> > +              * Reset memory.(emin, elow) for reclaiming the memcg
> > +              * itself.
> > +              */
> > +             if (memcg != root_mem_cgroup) {
> > +                     memcg->memory.emin = 0;
> > +                     memcg->memory.elow = 0;
> > +             }
> >               return MEMCG_PROT_NONE;
> > +     }
> >
> >       usage = page_counter_read(&memcg->memory);
> >       if (!usage)
> > --
> > 1.8.3.1
> >
> >
