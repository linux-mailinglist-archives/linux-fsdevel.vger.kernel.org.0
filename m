Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0392CF469
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 19:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgLDSzd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Dec 2020 13:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbgLDSzb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Dec 2020 13:55:31 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49516C061A4F
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Dec 2020 10:54:51 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id v143so6435157qkb.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Dec 2020 10:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rg7lrS/4cr2DIOho7mbjVZXSDz3+KMSUQybW7MPBlNA=;
        b=twndtQ1CF5ITaAzRNV/5rAfbKfs+6rjo4uTloJ1pRExv5sQhw1SELhyHv/uLbYchHG
         OTGkOYTH1eBROSNK+yTXPNY62q7M+aOkghEDJ584QyK2euCGKPBdsdakiW1Cwic33peI
         glBoNZbYxdxPfibwDuInPMBJ+f3IXfiGqHjz56KaIG8jGSC6Jth5BgqVuCJSCTxOL58a
         yWVIgJVys6vFWeVmIHMhhLOFar4qS0BX8QJzRClyQU9UjNct0DdeQLYYQyyiKHJVZUV/
         axI8PAqs1DqDTd9/kv9P7gjaA66x1EatLotAAc6sXtbvkA3ugA0ba8mdPPwQlm6ycK7D
         aO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rg7lrS/4cr2DIOho7mbjVZXSDz3+KMSUQybW7MPBlNA=;
        b=Ag9VmknKpOUiAN9vRrtTMyOMuXNAHirtzTkjUgM3mkBtAWDlin6MCJwxAUfPaY8zWB
         uAJlIuu32NS+P//H2EzmbObfk5uVReY1fYR6aajpD3QruAOe1W/GAkDgaa6JuuLhIwsm
         SHDDeMzaFyDQ64Q8V1S/8FG4qiiIJHnJpKkwHImmRYzSNO3uvQvZTzuNUpxAIrs9Y1TX
         x9v2ZvVm+9tkkvmBG4bnuZBwARWT2IH5naL6AgNjB/XHS8sT/u7APVFnTi7cvLqhLQ63
         Cwu0JzoVq/t1AmcK337aAj4j6ZDba44JdSSn+WszgIu25ufcgwmYat/XAp/qd21BvsVs
         B0wg==
X-Gm-Message-State: AOAM5315OsRCIYcEDEwnpbrxbvKBw3fGohvJA8q53BgJ+SJ9sCfEpiMZ
        dzcRJYyS4d76bvQaaO0ZZNAXLA==
X-Google-Smtp-Source: ABdhPJyQVuWk9koWKozYjk4xSbqAGSTa/BUZAQJ0yr3p51asd8OHOsW1+VTpzgu+YAEf8hAdK7BrVw==
X-Received: by 2002:a37:6358:: with SMTP id x85mr10465468qkb.405.1607108090466;
        Fri, 04 Dec 2020 10:54:50 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:a180])
        by smtp.gmail.com with ESMTPSA id 60sm1938803qth.14.2020.12.04.10.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 10:54:49 -0800 (PST)
Date:   Fri, 4 Dec 2020 13:52:47 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/9] mm: vmscan: use a new flag to indicate shrinker is
 registered
Message-ID: <20201204185247.GA182921@cmpxchg.org>
References: <20201202182725.265020-1-shy828301@gmail.com>
 <20201202182725.265020-5-shy828301@gmail.com>
 <20201203030104.GF1375014@carbon.DHCP.thefacebook.com>
 <CAHbLzkoUNuKHT_4w8QaWCQA3xs2vTW4Xii26a5vpVqxrDVSX_Q@mail.gmail.com>
 <20201203200820.GC1571588@carbon.DHCP.thefacebook.com>
 <CAHbLzkrbd+gBUngiRa3OJhO3q_Z7x3w6+jkX2CkXG0Zm=jufQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkrbd+gBUngiRa3OJhO3q_Z7x3w6+jkX2CkXG0Zm=jufQA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 03, 2020 at 02:25:20PM -0800, Yang Shi wrote:
> On Thu, Dec 3, 2020 at 12:09 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Wed, Dec 02, 2020 at 08:59:40PM -0800, Yang Shi wrote:
> > > On Wed, Dec 2, 2020 at 7:01 PM Roman Gushchin <guro@fb.com> wrote:
> > > >
> > > > On Wed, Dec 02, 2020 at 10:27:20AM -0800, Yang Shi wrote:
> > > > > Currently registered shrinker is indicated by non-NULL shrinker->nr_deferred.
> > > > > This approach is fine with nr_deferred atthe shrinker level, but the following
> > > > > patches will move MEMCG_AWARE shrinkers' nr_deferred to memcg level, so their
> > > > > shrinker->nr_deferred would always be NULL.  This would prevent the shrinkers
> > > > > from unregistering correctly.
> > > > >
> > > > > Introduce a new "state" field to indicate if shrinker is registered or not.
> > > > > We could use the highest bit of flags, but it may be a little bit complicated to
> > > > > extract that bit and the flags is accessed frequently by vmscan (every time shrinker
> > > > > is called).  So add a new field in "struct shrinker", we may waster a little bit
> > > > > memory, but it should be very few since there should be not too many registered
> > > > > shrinkers on a normal system.
> > > > >
> > > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > > > ---
> > > > >  include/linux/shrinker.h |  4 ++++
> > > > >  mm/vmscan.c              | 13 +++++++++----
> > > > >  2 files changed, 13 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> > > > > index 0f80123650e2..0bb5be88e41d 100644
> > > > > --- a/include/linux/shrinker.h
> > > > > +++ b/include/linux/shrinker.h
> > > > > @@ -35,6 +35,9 @@ struct shrink_control {
> > > > >
> > > > >  #define SHRINK_STOP (~0UL)
> > > > >  #define SHRINK_EMPTY (~0UL - 1)
> > > > > +
> > > > > +#define SHRINKER_REGISTERED  0x1
> > > > > +
> > > > >  /*
> > > > >   * A callback you can register to apply pressure to ageable caches.
> > > > >   *
> > > > > @@ -66,6 +69,7 @@ struct shrinker {
> > > > >       long batch;     /* reclaim batch size, 0 = default */
> > > > >       int seeks;      /* seeks to recreate an obj */
> > > > >       unsigned flags;
> > > > > +     unsigned state;
> > > >
> > > > Hm, can't it be another flag? It seems like we have a plenty of free bits.
> > >
> > > I thought about this too. But I was not convinced by myself that
> > > messing flags with state is a good practice. We may add more flags in
> > > the future, so we may end up having something like:
> > >
> > > flag
> > > flag
> > > flag
> > > state
> > > flag
> > > flag
> > > ...
> > >
> > > Maybe we could use the highest bit for state?
> >
> > Or just
> > state
> > flag
> > flag
> > flag
> > flag
> > flag
> > ...
> >
> > ?
> 
> It is fine too. We should not add more states in foreseeable future.

It's always possible to shuffle things around for cleanup later on,
too. We don't have to provide binary compatibility for existing flags,
and changing a couple of adjacent bits isn't a big deal to keep things
neat. Or am I missing something?
