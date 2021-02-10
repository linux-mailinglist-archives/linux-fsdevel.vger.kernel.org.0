Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD15315BEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 02:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbhBJBKM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 20:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbhBJBIB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 20:08:01 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F5CC061574;
        Tue,  9 Feb 2021 17:07:20 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id p20so959940ejb.6;
        Tue, 09 Feb 2021 17:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ePOOgJ1bRE7sZrw4203J7YVw7l2PTtMtobAvSfxZsE8=;
        b=GyyJJ/YjmAijxmg74wofh+2bQ0XakpFCm424T5jbHcOLM/qUrPvmEQk6wOQ95qlWS9
         Gk1QfPaSXbUX9cSP16QgEP68Hgo+wRKKpKKq+syClxOwTlQnrqJWaH9qoHcFeT9/3StP
         ZrxNd7cQuiRmYgcy1pHgJ3HY7O/xkSs50bH0XDWHx7rIzorLmS8+Tq8UQp00IlfAqzs2
         p3elJnl+n5+s+UIYGcE5mBa9w885JXbgitP5XAjKPAYnD1M3BzsxHDifE3AXa5fNmKk2
         UEZOoiP4L0534FaamPfN6OaulnBllYmpYYKhyhXUYsC/f/LtQU/Kwt9q9A7KQlxNCUU2
         hWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ePOOgJ1bRE7sZrw4203J7YVw7l2PTtMtobAvSfxZsE8=;
        b=UeH+RbCDs5fbkSat5kaCBEnwwLJ74fG2015lmSWOrYRhc9BrznECdd/WB9Tqq1wuIZ
         QGaZJvTsGBJhGE7fCviUb7QfX0VXaYIEkcz/brxnXQdvg24LLBsOCRv5b/tb448I8AIm
         fxhYno9XbQBTVjMdu/eq6qZpGi8K9h/8WZfBR6nHZPMUZCjOA0p6MOVw2pBBJ9hl6feQ
         sylDmaLtultON727i11ms7kIEN26WqGuoU3cF8pQF8FwpF40pjoysjPl30++hJez9M5N
         xGWZgtHoM8IwiUj21aQg4NKwHZALPIBuc5B0RBktThBn55XSAHch93CnJN57ck6Zc9V7
         9Igg==
X-Gm-Message-State: AOAM530sVE52utf3LeW5a+IbOyojHzzhTIH3m578eVoGQ+nsXreEml2c
        qiyN+GWhOztTiosCLYEoBm47jDZ5SEFMO5e3EA0=
X-Google-Smtp-Source: ABdhPJw4DItb779I2iVr2ra7DPTmnwUuXp3XWcNxJXP4T0tQgBy4M3uYGgqeOu3ilbXbTM9VyEvJJ6VdPOIB+WjhakQ=
X-Received: by 2002:a17:906:2583:: with SMTP id m3mr383234ejb.499.1612919239346;
 Tue, 09 Feb 2021 17:07:19 -0800 (PST)
MIME-Version: 1.0
References: <20210209174646.1310591-1-shy828301@gmail.com> <20210209174646.1310591-7-shy828301@gmail.com>
 <20210210002218.GJ524633@carbon.DHCP.thefacebook.com>
In-Reply-To: <20210210002218.GJ524633@carbon.DHCP.thefacebook.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 9 Feb 2021 17:07:07 -0800
Message-ID: <CAHbLzkp6q60pGBGKB-H6k5YoCy8ZHcLVj4rrZOsXi3=jOfbGzQ@mail.gmail.com>
Subject: Re: [v7 PATCH 06/12] mm: vmscan: add shrinker_info_protected() helper
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

On Tue, Feb 9, 2021 at 4:22 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Feb 09, 2021 at 09:46:40AM -0800, Yang Shi wrote:
> > The shrinker_info is dereferenced in a couple of places via rcu_dereference_protected
> > with different calling conventions, for example, using mem_cgroup_nodeinfo helper
> > or dereferencing memcg->nodeinfo[nid]->shrinker_info.  And the later patch
> > will add more dereference places.
> >
> > So extract the dereference into a helper to make the code more readable.  No
> > functional change.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/vmscan.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 9436f9246d32..273efbf4d53c 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -190,6 +190,13 @@ static int shrinker_nr_max;
> >  #define NR_MAX_TO_SHR_MAP_SIZE(nr_max) \
> >       (DIV_ROUND_UP(nr_max, BITS_PER_LONG) * sizeof(unsigned long))
> >
> > +static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
> > +                                                  int nid)
> > +{
> > +     return rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
> > +                                      lockdep_is_held(&shrinker_rwsem));
> > +}
> > +
>
>
> I'd probably drop the "protected" suffix (because there is no unprotected version,
> right?).

No, actually there is one "unprotected" call in set_shrinker_bit().

>
> Other than that LGTM.
>
> Acked-by: Roman Gushchin <guro@fb.com>
