Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C2D315A67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 01:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbhBIX7h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 18:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbhBIXcK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 18:32:10 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F099C061574;
        Tue,  9 Feb 2021 15:31:30 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y18so408671edw.13;
        Tue, 09 Feb 2021 15:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SppdSCl2Hme6/0W5XbF7DtR4/Tbyteffik5eXOy3CDs=;
        b=Bdvt2hK50arKPZ3PpbfPSBqtvsuBzb51S/mVQNIYON95z3t/S/VkR1pX/UlUpHEGyq
         g1eTuwz9c1M9a4SJpBYF1oTxtqcrlrr+AbB8IIDxzCytack2IkYHnHrKQ6GV83TZbgrP
         ClT5iA7dcKZ0oCJCIZ86DRGQSGoPwVZ67zE0Wk8ZauiKusgVTFXnO9MBuBYGWofH8P0U
         PYZEyk9Otk6GeJ/3NbpQl3P7gehFMIbNq4Iti7wyDRCMElJapLPwIAPNE9d8jit3plgY
         g0KTxXj9CxlzS6EJA8ROKNANPKYNdE6l50bpDlNnFWdsm1tZc0WEOU0Ex6Hqlb9HK17k
         +jBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SppdSCl2Hme6/0W5XbF7DtR4/Tbyteffik5eXOy3CDs=;
        b=glvznDXlV4Y7XgpY/9Dadb7jqXMSjK44XML/eeYDJZBTgxTKyJduISBooXEbWqcxQu
         Afl0Qn9HrQJa4gnyY2tccsJatT/xawN6Rp90gDCAqBL6UWfElIiXPDIS5SnFJzMSpOLM
         V2fNK03IYrZJhHByRhh6+nU5WvobkKV3VlKG8c9ENHcoBVoVvQe5K7kOxjEfdG36T1G0
         uWvtpr+ytxNXZST0/wnR5TZRS6lbq6ZQ1fjfFdYzOlSbghZmVvq5ndQWD9zHKWiZIrAe
         Qjy+Qnk1W990dmxFzmWP2M7rHSbs2/LOerGV+x9k470NDpwf83Bf1NmPFvh6NXfYzT4o
         eMeg==
X-Gm-Message-State: AOAM530wG0V/CAqNJDt482lr+G/ElDUSsNnmd04pb/4hdjmeYctXswkZ
        fMequnmu6ssb7cxE7ywaehV4g00pdLS7oNRAnlY=
X-Google-Smtp-Source: ABdhPJwD5iBUaoZ2DF9YLO6QB40HK0Y7wa32nRRFzuU242PC6dr8mLNS8Eh8gngI+Dc2H0Y9e8RnuUaskB3yeM3xGyQ=
X-Received: by 2002:a05:6402:3069:: with SMTP id bs9mr532983edb.151.1612913488857;
 Tue, 09 Feb 2021 15:31:28 -0800 (PST)
MIME-Version: 1.0
References: <20210209174646.1310591-1-shy828301@gmail.com> <20210209174646.1310591-5-shy828301@gmail.com>
 <20210209204314.GG524633@carbon.DHCP.thefacebook.com>
In-Reply-To: <20210209204314.GG524633@carbon.DHCP.thefacebook.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 9 Feb 2021 15:31:17 -0800
Message-ID: <CAHbLzkpcvF578TPB-tfh=MhDqTB5Oc7Sf_6ndV2uZL227o6dFQ@mail.gmail.com>
Subject: Re: [v7 PATCH 04/12] mm: vmscan: remove memcg_shrinker_map_size
To:     Roman Gushchin <guro@fb.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 9, 2021 at 12:43 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Feb 09, 2021 at 09:46:38AM -0800, Yang Shi wrote:
> > Both memcg_shrinker_map_size and shrinker_nr_max is maintained, but actually the
> > map size can be calculated via shrinker_nr_max, so it seems unnecessary to keep both.
> > Remove memcg_shrinker_map_size since shrinker_nr_max is also used by iterating the
> > bit map.
> >
> > Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/vmscan.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index e4ddaaaeffe2..641077b09e5d 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -185,8 +185,10 @@ static LIST_HEAD(shrinker_list);
> >  static DECLARE_RWSEM(shrinker_rwsem);
> >
> >  #ifdef CONFIG_MEMCG
> > +static int shrinker_nr_max;
> >
> > -static int memcg_shrinker_map_size;
> > +#define NR_MAX_TO_SHR_MAP_SIZE(nr_max) \
> > +     (DIV_ROUND_UP(nr_max, BITS_PER_LONG) * sizeof(unsigned long))
>
> How about something like this?
>
> static inline int shrinker_map_size(int nr_items)
> {
>         return DIV_ROUND_UP(nr_items, BITS_PER_LONG) * sizeof(unsigned long);
> }
>
> I think it look less cryptic.

OK, I don't have a strong opinion for either one (inline function or
macro). If no one objects this I could do it in the new version.

>
> The rest of the patch looks good to me.
>
> Thanks!
