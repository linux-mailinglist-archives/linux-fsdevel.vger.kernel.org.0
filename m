Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104AF2DC6EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 20:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387649AbgLPTOz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 14:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387642AbgLPTOz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 14:14:55 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30DBC061794
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 11:14:14 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id n26so34329861eju.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 11:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kJdy/dOR9V46q0AbC51RyI23sFiXHdcdGuaklpPobwU=;
        b=0lAw7t13nLxr1ny6LXtR1IBAc4rNcqsaQo3xMm4MHD9lCZdqL4hceZfDyGgiY8ND7b
         XDe8hkNPTNuK2Tz56WC4vT2IxuUfcKu2JLy6od+zoHtDbFZIk+xX8e8YIol1L/qXmi0m
         zCwDfnbUqOyaRgIuFoDs5fw1QrOZrW8chGBsOzAqjVCT6EbkGq/5QqdpMurHXdjM8AZh
         m5HyE1/qUdapTymn7q6+Z4nuliu5MSRk+7XL/VjgiG0U5Uedi3vpCxNXdnTzweA7Ndos
         dcaNz126Mc2fnQqtPap4lhREKfB81dOqKYiD0lJnUHmXKeq405rtUY2gIxFuM0qjqZ1+
         RjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kJdy/dOR9V46q0AbC51RyI23sFiXHdcdGuaklpPobwU=;
        b=FAzpkLX+K82mvtmB3rRuJ9AbDknH0D5f4nQ84j7qhwvdmmNtGVivyrI+Cgs/1AhYCO
         Ic3ylH5fXCoi//SVoO6HY5zbYCui1NSzBp0TjUp+/2QJ9roFfrD4AdDGf7rC+B4SKx8S
         9WFcjzM9iaxTs2rYinAHM7OSX9eHVy9ZcqniYCVjHG89A7PayN5tjIVl1hpZlxurMBTB
         bwjooQ0LXzQPDVRjRDiT1UNiFjoeLEzBlhlhuQYQdk2YLaKgGDg2Iq5mwwv4CTtqzfYq
         XfkgpNqtKvZNF7KgrGNRP3nVTVcvTS4vdge+DskFColhf8ph4nOELMNeTWUHt23t8U/Q
         scPg==
X-Gm-Message-State: AOAM530C29cLmmG3O2SY+WbDzL/62Dy6MJNt2yoKoe7sbvNq/EjI0pIq
        Lb3BDTcac143NmOnEUkDaYECMA==
X-Google-Smtp-Source: ABdhPJycSk75MWJHCe0AnW7/3JQ1eHQe1/8muJdp4gzVftVivy1vURG1p9xLRJvzg3cX+ic/Aqa03A==
X-Received: by 2002:a17:906:7a46:: with SMTP id i6mr31113453ejo.257.1608146053504;
        Wed, 16 Dec 2020 11:14:13 -0800 (PST)
Received: from localhost (p4fdabc80.dip0.t-ipconnect.de. [79.218.188.128])
        by smtp.gmail.com with ESMTPSA id j23sm8253756edv.45.2020.12.16.11.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 11:14:12 -0800 (PST)
Date:   Wed, 16 Dec 2020 20:12:04 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Yang Shi <shy828301@gmail.com>, guro@fb.com, ktkhai@virtuozzo.com,
        shakeelb@google.com, mhocko@suse.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 2/9] mm: memcontrol: use shrinker_rwsem to protect
 shrinker_maps allocation
Message-ID: <20201216191204.GA395124@cmpxchg.org>
References: <20201214223722.232537-1-shy828301@gmail.com>
 <20201214223722.232537-3-shy828301@gmail.com>
 <20201215020957.GK3913616@dread.disaster.area>
 <20201215135348.GC379720@cmpxchg.org>
 <20201215215938.GQ3913616@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215215938.GQ3913616@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 16, 2020 at 08:59:38AM +1100, Dave Chinner wrote:
> On Tue, Dec 15, 2020 at 02:53:48PM +0100, Johannes Weiner wrote:
> > On Tue, Dec 15, 2020 at 01:09:57PM +1100, Dave Chinner wrote:
> > > On Mon, Dec 14, 2020 at 02:37:15PM -0800, Yang Shi wrote:
> > > > Since memcg_shrinker_map_size just can be changd under holding shrinker_rwsem
> > > > exclusively, the read side can be protected by holding read lock, so it sounds
> > > > superfluous to have a dedicated mutex.
> > > 
> > > I'm not sure this is a good idea. This couples the shrinker
> > > infrastructure to internal details of how cgroups are initialised
> > > and managed. Sure, certain operations might be done in certain
> > > shrinker lock contexts, but that doesn't mean we should share global
> > > locks across otherwise independent subsystems....
> > 
> > They're not independent subsystems. Most of the memory controller is
> > an extension of core VM operations that is fairly difficult to
> > understand outside the context of those operations. Then there are a
> > limited number of entry points from the cgroup interface. We used to
> > have our own locks for core VM structures (private page lock e.g.) to
> > coordinate VM and cgroup, and that was mostly unintelligble.
> 
> Yes, but OTOH you can CONFIG_MEMCG=n and the shrinker infrastructure
> and shrinkers all still functions correctly.  Ergo, the shrinker
> infrastructure is independent of memcgs. Yes, it may have functions
> to iterate and manipulate memcgs, but it is not dependent on memcgs
> existing for correct behaviour and functionality.

Okay, but now do it the other way round and explain the memcg bits in
a world where shrinkers don't exist ;-)

Anyway, we seem to be mostly in agreement below.

> > We have since established that those two components coordinate with
> > native VM locking and lifetime management. If you need to lock the
> > page, you lock the page - instead of having all VM paths that already
> > hold the page lock acquire a nested lock to exclude one cgroup path.
> > 
> > In this case, we have auxiliary shrinker data, subject to shrinker
> > lifetime and exclusion rules. It's much easier to understand that
> > cgroup creation needs a stable shrinker list (shrinker_rwsem) to
> > manage this data, than having an aliased lock that is private to the
> > memcg callbacks and obscures this real interdependency.
> 
> Ok, so the way to do this is to move all the stuff that needs to be
> done under a "subsystem global" lock to the one file, not turn a
> static lock into a globally visible lock and spray it around random
> source files.

Sure, that works as well.

> The shrinker map should be generic functionality for all shrinker
> invocations because even a non-memcg machine can have thousands of
> registered shrinkers that are mostly idle all the time.

Agreed.

> IOWs, I think the shrinker map management is not really memcg
> specific - it's just allocation and assignment of a structure, and
> the only memcg bit is the map is being stored in a memcg structure.
> Therefore, if we are looking towards tighter integration then we
> should acutally move the map management to the shrinker code, not
> split the shrinker infrastructure management across different files.
> There's already a heap of code in vmscan.c under #ifdef
> CONFIG_MEMCG, like the prealloc_shrinker() code path:
> 
> prealloc_shrinker()				vmscan.c
>   if (MEMCG_AWARE)				vmscan.c
>     prealloc_memcg_shrinker			vmscan.c
> #ifdef CONFIG_MEMCG				vmscan.c
>       down_write(shrinker_rwsem)		vmscan.c
>       if (id > shrinker_id_max)			vmscan.c
> 	memcg_expand_shrinker_maps		memcontrol.c
> 	  for_each_memcg			memcontrol.c
> 	    reallocate shrinker map		memcontrol.c
> 	    replace shrinker map		memcontrol.c
> 	shrinker_id_max = id			vmscan.c
>       down_write(shrinker_rwsem)		vmscan.c
> #endif
> 
> And, really, there's very little code in memcg_expand_shrinker_maps()
> here - the only memcg part is the memcg iteration loop, and we
> already have them in vmscan.c (e.g. shrink_node_memcgs(),
> age_active_anon(), drop_slab_node()) so there's precedence for
> moving this memcg iteration for shrinker map management all into
> vmscan.c.
>
> Doing so would formalise the shrinker maps as first class shrinker
> infrastructure rather than being tacked on to the side of the memcg
> infrastructure. At this point it makes total sense to serialise map
> manipulations under the shrinker_rwsem.

Yes, that's a great idea.

> That is, for the medium term, I think  we should be getting rid of
> the "legacy" non-memcg shrinker path and everything runs under
> memcgs.  With this patchset moving all the deferred counts to be
> memcg aware, the only reason for keeping the non-memcg path around
> goes away.  If sc->memcg is null, then after this patch set we can
> simply use the root memcg and just use it's per-node accounting
> rather than having a separate construct for non-memcg aware per-node
> accounting.
> 
> Hence if SHRINKER_MEMCG_AWARE is set, it simply means we should run
> the shrinker if sc->memcg is set.  There is no difference in setup
> of shrinkers, the duplicate non-memcg/memcg paths go away, and a
> heap of code drops out of the shrinker infrastructure. It becomes
> much simpler overall.

Agreed as well.

> It also means we have a path for further integrating memcg aware
> shrinkers into the shrinker infrastructure because we can always
> rely on the shrinker infrastructure being memcg aware. And with that
> in mind, I think we should probably also be moving the shrinker code
> out of vmscan.c into it's own file as it's really completely
> separate infrastructure from the vast majority of page reclaim
> infrastructure in vmscan.c...

Right again.

> That's the view I'm looking at this patchset from. Not just as a
> standalone bug fix, but also from the perspective of what the
> architectural change implies and the directions for tighter
> integration it opens up for us.

Makes sense, but I'm not sure it's getting in the way of that: a
generalized first-class map would be managed under the shrinker_rwsem,
so ditching the private lock is good progress. The widened lock scope
(temporarily, and still mm/) is easy to reverse later on.

That said, moving the map handling code from memcontrol.c to vmscan.c
in preparation, and/or even reworking the shrinker around the concept
of a memcg, indeed are great ideas.

I'd support patches doing that.
