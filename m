Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C062D7D6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 18:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436682AbgLKRxt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 12:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405735AbgLKRxg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 12:53:36 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F41AC0613CF;
        Fri, 11 Dec 2020 09:52:56 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id bo9so13474263ejb.13;
        Fri, 11 Dec 2020 09:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t7GrN+vF3F8/1mfjNA8maGpiuiIYyPy43Sa2g8ExXyg=;
        b=N5V1Zt+5aVOO8IHTL4NHoHVqBfRv45HDkG1w4HbUIXIdyaMhMlNwjglAMLHv6MJRu2
         CtsZBwxTWK85pVxSx5IrwPyx+bHQ6hHWfg8lrDQ16EmOBqW7n9TNeeYhGzKbVxYUh7rt
         r0TtOlzduqhUCHRx825xdV8BAttMjUrVC318C2qCgPeEkbx9a5jYlGxv00baUg0jfEAO
         TX5zyIqvKTWT+IgkVr2GhSNb1uskKxl3AkWrNDpgC9+XUI2dxDo4ryaUZIpeiIXUWb8g
         8CBCTNUq1qoYD6vB7h3CFk8kj+V+2fCw1udyxXtB4zAJfcBiW0R4mvurCQ4Aspix9VXO
         5SxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t7GrN+vF3F8/1mfjNA8maGpiuiIYyPy43Sa2g8ExXyg=;
        b=t2AGsLKYe8nG4PiEiSr9Mb+/Mg2CgVj4geGcpJmHgEtPVW8+fzavYBjUcb7ePTGmUH
         jIdNeDpKlERZTUio0NqGiWD/kCy7RCvsRwS2TF+PqzhKT9ZBQtPEEM7j/5AA7+UL9Nmo
         us6ogFeNWT3GP5LpcJhcpRNrP8aLEzPJ+fat4Dg7VdbrptujpyJRXqdAtyV/5B58s4IR
         HHrA1V0sxwWdY826nVUobnyD9JiJRiGxKdHnS/oT486oxg2nsl7cwc4YlrfsVYviGbVi
         0VZx+a4UZQB2rY22zA0o2Jucuyew0IWc8o/qUIQrR0X34We3HLI3m85O5kfRUN6/HJWz
         LOig==
X-Gm-Message-State: AOAM5310x7leAMkvSXFMzEd9Z0ND4Yij0P1ORi3lPCm/QNDd59cCH0Df
        sVbKcWKuL9/iENxWaAgI1M8Os+sw1JDiF0BfoLA=
X-Google-Smtp-Source: ABdhPJwozfWoy777gbDNB3uqsNJHEJbZ/86HWYbed0b/GrVyJtTHjSdpc60O+eJbO4bNaFpHXbhPl3E3pY10gLSXCpQ=
X-Received: by 2002:a17:906:6a45:: with SMTP id n5mr12287655ejs.514.1607709174880;
 Fri, 11 Dec 2020 09:52:54 -0800 (PST)
MIME-Version: 1.0
References: <20201202182725.265020-1-shy828301@gmail.com> <20201202182725.265020-6-shy828301@gmail.com>
 <20201210153356.GE264602@cmpxchg.org> <CAHbLzkoSSQ_4aY1cNmJGZyL+r6yO3L41KWHi8ZQnDhFTNi-v_Q@mail.gmail.com>
In-Reply-To: <CAHbLzkoSSQ_4aY1cNmJGZyL+r6yO3L41KWHi8ZQnDhFTNi-v_Q@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 11 Dec 2020 09:52:42 -0800
Message-ID: <CAHbLzkpwAANd_Nci5Krcek+NmexJCZVVQqSsJF6=xfLVsMK34Q@mail.gmail.com>
Subject: Re: [PATCH 5/9] mm: memcontrol: add per memcg shrinker nr_deferred
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 11:12 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Thu, Dec 10, 2020 at 7:36 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Wed, Dec 02, 2020 at 10:27:21AM -0800, Yang Shi wrote:
> > > @@ -504,6 +577,34 @@ int memcg_expand_shrinker_maps(int new_id)
> > >       return ret;
> > >  }
> > >
> > > +int memcg_expand_shrinker_deferred(int new_id)
> > > +{
> > > +     int size, old_size, ret = 0;
> > > +     struct mem_cgroup *memcg;
> > > +
> > > +     size = (new_id + 1) * sizeof(atomic_long_t);
> > > +     old_size = memcg_shrinker_deferred_size;
> > > +     if (size <= old_size)
> > > +             return 0;
> > > +
> > > +     mutex_lock(&memcg_shrinker_mutex);
> >
> > The locking is somewhat confusing. I was wondering why we first read
> > memcg_shrinker_deferred_size "locklessly", then change it while
> > holding the &memcg_shrinker_mutex.
> >
> > memcg_shrinker_deferred_size only changes under shrinker_rwsem(write),
> > correct? This should be documented in a comment, IMO.
>
> Yes, it is correct.
>
> >
> > memcg_shrinker_mutex looks superfluous then. The memcg allocation path
> > is the read-side of memcg_shrinker_deferred_size, and so simply needs
> > to take shrinker_rwsem(read) to lock out shrinker (de)registration.
>
> I see you point. Yes, it seems shrinker_{maps|deferred} allocation
> could be synchronized with shrinker registration by shrinker_rwsem.
>
> memcg_shrinker_mutex is just renamed from memcg_shrinker_map_mutex
> which was introduced by shrinker_maps patchset. I'm not quite sure why
> this mutex was introduced at the first place, I guess the main purpose
> is to *not* exacerbate the contention of shrinker_rwsem?
>
> If that contention is not a concern, we could remove that dedicated mutex.

It seems using shrinker_rwsem instead of dedicated mutex should not
exacerbate the contention since we just add one read critical section.
Will do it in v2.


>
> >
> > Also, isn't memcg_shrinker_deferred_size just shrinker_nr_max? And
>
> No, it is variable. It is nr * sizeof(atomit_long_t). The nr is the
> current last shrinker ID. If a new shrinker is registered, the nr may
> grow.
>
> > memcg_expand_shrinker_deferred() is only called when size >= old_size
> > in the first place (because id >= shrinker_nr_max)?
>
> Yes.
