Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D211312B01D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 02:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfL0BKb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 20:10:31 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45968 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfL0BKb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 20:10:31 -0500
Received: by mail-io1-f67.google.com with SMTP id i11so24523936ioi.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2019 17:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1GRFRPnNQ0j9VDLy5xDDK1SFhmCSZ3Lj0rMxOvVuSg=;
        b=K7YTp5qR4EqXRMxB5KkC84WtoJ1zhuFYs9U7GEoZwVfu8dOC8/Dgjyfn85vqZBGCX5
         m8/tI8gj0uF78Lp7M/cqlfs8C7R68l19Tj/Wgqy3g0KnAHzuO48OsERyXBQJMq1mw6ca
         6+dNtktRqbwEJc6sBBtQ4P7mEKPmJwH9A/pyO/laVKcnEwhdwadnWV5CADc1CWoWiZKo
         Xt2OP2NXnXyRmAiB1g7EqhTjA252SPmy26YOnSGLqQbhGD0O5+BP4jA3wM6QMvHqYTya
         4S0ErHoQled9NQQYm/8TsRb9bCOkpFgJxU9JfhJgWXkC2tDAcTsf1sMQTXmh/11/qC+E
         7cjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1GRFRPnNQ0j9VDLy5xDDK1SFhmCSZ3Lj0rMxOvVuSg=;
        b=D+4W9+Z97J2wOMwi0hSgq0uf3B731zUAvn/MKfjZUkVfKW+Kfbe55iF3N6Y3ihO2xD
         rOLPvpmdZf1MORnGY84ixQrvicEB9ScYCTmTIjvc2Y4sCRhkVPGlxJSRmA7BhpOnBlsQ
         Vsl5vj+ZSnatbGeSJ5bTbW1mgAFnnfkx+IRkxbSsblfkDfetqdS2aYlkXsk0ncv6Czp0
         m3qiWMOVBCe02mwFOdVTnm6ubqYzQ5y1a8w364YuMN45IP84FFAusOei2L+6BrNfgb/p
         lEIc+OqGnKVlp11VtQp7s+YBzS4cHkuavuMQcl00iF9vd2P4JLzaEUC0pJ6o2GJtT11e
         rvlg==
X-Gm-Message-State: APjAAAUlb5OKd2KWiYLtk9UtvP8ahWvTzikk1HTJ+xXQJjAd11xGXhob
        sDyKW+SMUQKL5VIJSBvYHsYcvRPIYXdyIYzCWro=
X-Google-Smtp-Source: APXvYqyMKdoNufCBdhXPbrHoQ1wdGuHcK5iZZdpGdKEeCSqRti5/yUqSvBcWsDbS2qdfF/k+ntJkfMRTFpnW/G9fcOY=
X-Received: by 2002:a6b:b941:: with SMTP id j62mr34860236iof.168.1577409030866;
 Thu, 26 Dec 2019 17:10:30 -0800 (PST)
MIME-Version: 1.0
References: <1577174006-13025-1-git-send-email-laoar.shao@gmail.com>
 <1577174006-13025-3-git-send-email-laoar.shao@gmail.com> <20191226213619.GB22734@tower.dhcp.thefacebook.com>
In-Reply-To: <20191226213619.GB22734@tower.dhcp.thefacebook.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 27 Dec 2019 09:09:54 +0800
Message-ID: <CALOAHbAkXBAH1WGPDvRGiy8Pwb1iAA0exiQufUZ8QwCPPoWyuw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mm, memcg: introduce MEMCG_PROT_SKIP for memcg
 zero usage case
To:     Roman Gushchin <guro@fb.com>
Cc:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 27, 2019 at 5:36 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Dec 24, 2019 at 02:53:23AM -0500, Yafang Shao wrote:
> > If the usage of a memcg is zero, we don't need to do useless work to scan
> > it. That is a minor optimization.
>
> The optimization isn't really related to the main idea of the patchset,
> so I'd prefer to treat it separately.
>

Sure.

> >
> > Cc: Roman Gushchin <guro@fb.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/linux/memcontrol.h | 1 +
> >  mm/memcontrol.c            | 2 +-
> >  mm/vmscan.c                | 6 ++++++
> >  3 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 612a457..1a315c7 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -54,6 +54,7 @@ enum mem_cgroup_protection {
> >       MEMCG_PROT_NONE,
> >       MEMCG_PROT_LOW,
> >       MEMCG_PROT_MIN,
> > +     MEMCG_PROT_SKIP,        /* For zero usage case */
> >  };
> >
> >  struct mem_cgroup_reclaim_cookie {
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index c5b5f74..f35fcca 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6292,7 +6292,7 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
> >
> >       usage = page_counter_read(&memcg->memory);
> >       if (!usage)
> > -             return MEMCG_PROT_NONE;
> > +             return MEMCG_PROT_SKIP;
>
> I'm concerned that it might lead to a regression with the scraping of
> last pages from a memcg. Charge is batched using percpu stocks, so the
> value of the page counter is approximate. Skipping the cgroup entirely
> we're losing all chances to reclaim these few pages.
>

Agree with you. It may lose the chances to reclaim these last few pages.
I will think about it.

> Idk how serious the problem could be in the real life, and maybe it's OK
> to skip if the cgroup is online, but I'd triple check here.
>
> Also, because this optimization isn't really related to protection,
> why not check the page counter first, e.g.:
>
>         memcg = mem_cgroup_iter(root, NULL, NULL);
>         do {
>                 unsigned long reclaimed;
>                 unsigned long scanned;
>
>                 if (!page_counter_read(&memcg->memory))
>                         continue;
>

Seems better. Thanks for your suggestion.

>                 switch (mem_cgroup_protected(root, memcg)) {
>                 case MEMCG_PROT_MIN:
>                         /*
>                          * Hard protection.
>                          * If there is no reclaimable memory, OOM.
>                          */
>                         continue;
>                 case MEMCG_PROT_LOW:
>
> --
>
> Thank you!
