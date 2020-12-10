Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F132D6ACB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 23:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405154AbgLJWa1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 17:30:27 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34384 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405082AbgLJWV1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 17:21:27 -0500
Received: by mail-ed1-f66.google.com with SMTP id dk8so7277092edb.1;
        Thu, 10 Dec 2020 14:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mehdCErR0yhsbjduWQoy07Nba1zedRECDietLN/feuw=;
        b=vH37f4c4uUnV9Lj134aNl+bMtR+Z16rKS3qiQpYSYV8wounD/s646Yp7jfkbi34PD0
         T/TUAnKDsD/maaoFwDIP2gw42w390vdr4cRsX5m5EWGrw6w4go8dfJW+54wB4sKeKMdB
         J50SUk9LykObnY0IqNdzt0epf9o7MlB7nI/Qnnu1qweP1woJULmga0XKmxAP47FximoF
         68bhuW01qTVxo5WCTe4YBt+p55BgEH1vju3fUnWPCpqGPHaVoVqclXU+rwv4GYCE9fKE
         pxTq1UdecXQqDpXHasxWX24Mkpzd4kIuVAmP4+S4r8jZzVZOX1qcCojyrZqBzP4fnJcJ
         K7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mehdCErR0yhsbjduWQoy07Nba1zedRECDietLN/feuw=;
        b=q4RJJUf6Y9BMOiDPBULglvw4i3g6ygDL58//bMoIhaaKj2pNXGwL9ro/gJEYOWYlNI
         8VLiSLtik5C2gFPGTSJGCJ3u7Rg06JBengI5PpQEOeMEGSptQ0HvPaNDdmMBT2vDMEx+
         QjU2Raz6Od+e8mdJGaG/hvf+kMnfjlt3iNoNpM6cwayQU7HP159x/7ChXgbLCecJ2V4e
         TpPSBQP+XfngqpFe/+zIBEe6pc4NjQP1WDXOqJgM3eQWdWK5KORaNh8kM7KlwghCDx+m
         pXOpoMm6YAojeREAy/4Qtb45hWPI+8PGZ0b99cvR8ExaK408vrysykoZW0OnqdD0X2cO
         J6lw==
X-Gm-Message-State: AOAM532+kIQnGQaajqRJawod4wuW+UTO8+OpdupbS9NT+FcLRAIhhFSP
        jZ7uP6VLGPosJsO16ZK/xTBueeo5BLbr0SpSFwIFXxa44as=
X-Google-Smtp-Source: ABdhPJwPvbcgp24AbDog3/LDvwOSMb9RWGw4IainYjFFWWVMewc9GhkVfUbSqtIQxX15N4ulroWGzz9o9gAeP2UdsHY=
X-Received: by 2002:a17:906:cd06:: with SMTP id oz6mr8414384ejb.25.1607637557953;
 Thu, 10 Dec 2020 13:59:17 -0800 (PST)
MIME-Version: 1.0
References: <20201202182725.265020-1-shy828301@gmail.com> <20201202182725.265020-6-shy828301@gmail.com>
 <20201210153356.GE264602@cmpxchg.org>
In-Reply-To: <20201210153356.GE264602@cmpxchg.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 10 Dec 2020 13:59:06 -0800
Message-ID: <CAHbLzkouqvT7DNto=SYkoy28g7Tq7abyEjzwYcFGXzSrUx36FQ@mail.gmail.com>
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

On Thu, Dec 10, 2020 at 7:36 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Dec 02, 2020 at 10:27:21AM -0800, Yang Shi wrote:
> > @@ -504,6 +577,34 @@ int memcg_expand_shrinker_maps(int new_id)
> >       return ret;
> >  }
> >
> > +int memcg_expand_shrinker_deferred(int new_id)
> > +{
> > +     int size, old_size, ret = 0;
> > +     struct mem_cgroup *memcg;
> > +
> > +     size = (new_id + 1) * sizeof(atomic_long_t);
> > +     old_size = memcg_shrinker_deferred_size;
> > +     if (size <= old_size)
> > +             return 0;
> > +
> > +     mutex_lock(&memcg_shrinker_mutex);
>
> The locking is somewhat confusing. I was wondering why we first read
> memcg_shrinker_deferred_size "locklessly", then change it while
> holding the &memcg_shrinker_mutex.

The concurrent shrinkers registration may have race. But, they should
get different IDs, so it seems not matter.

I agree it is a little bit confusing and not that straightforward, it
does owe some comments in the code.

>
> memcg_shrinker_deferred_size only changes under shrinker_rwsem(write),
> correct? This should be documented in a comment, IMO.
>
> memcg_shrinker_mutex looks superfluous then. The memcg allocation path
> is the read-side of memcg_shrinker_deferred_size, and so simply needs
> to take shrinker_rwsem(read) to lock out shrinker (de)registration.
>
> Also, isn't memcg_shrinker_deferred_size just shrinker_nr_max? And
> memcg_expand_shrinker_deferred() is only called when size >= old_size
> in the first place (because id >= shrinker_nr_max)?
