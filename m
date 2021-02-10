Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D116316B90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 17:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhBJQor (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 11:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbhBJQmp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:42:45 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C6EC061756;
        Wed, 10 Feb 2021 08:42:05 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id f14so5326425ejc.8;
        Wed, 10 Feb 2021 08:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T3OGEUXVqBRMwtyZ0DTJOgmQoVRlEeHXk2pk+BRLLdU=;
        b=C6Dx+MpK4ZH+K2OxhilGb6z2GKpk0g2spNRQB5t3Do2XcKfVSbnvfBy//ndjIP/4hS
         Bi2Xvj/A5pcPCojyCGdZyRGGH4UmRScvGmPxvwL5CzhI0PGJe7cJ536jp0bRQGHe+3mc
         gXXHxuICSaNgGSQ8mXgUbGeyaw7jftTR6VTrAiGx5muzzDDwy1J1Ce3FJCJxJ3F/0oGd
         BVX6GYuWNE9Fx3558QBeyq0WvyqCXKVpPBvpDJ7yDA6Uea9L3Fe6melbC6WNWa/inYWr
         sReykCoOe7cMpcOD6gGEjEk3FxsApcBgQ+t5YkfGkh6s6KEvvXZqymjpLxMwZ65y7oPl
         v18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T3OGEUXVqBRMwtyZ0DTJOgmQoVRlEeHXk2pk+BRLLdU=;
        b=T46qwPIo9Lkg9jyf/n+0OTB3Xwm8k8AA8DSobV2KzRsZJ5xD9U6t1yX17gTNDSbs7p
         6KM4ZkHL+2C0+M454CFz8EXqXHoUZ5yVkPRDBxcN+BPYhtL9/wLmJLwnj/7NhAAqUoA5
         wyDzg7bWxqbLFyqL76te0FXkbjlppXn9QoMjRjPhouKx0TeZRDa1oh6v/xe4EmGXVN/f
         0yR1845b6JAyDFEfEMNI9LKOJdIvubmXJ5UdWw3IS8IqGMeegUn5AMSpPkakEjxmuo9+
         xeksOpjrVkA4WWpQvCbFmww6XK2NPqaScIq3xvK2GskYRECqaCkMNQGBq7JUHeQuQECi
         GmHw==
X-Gm-Message-State: AOAM530IIdFwK3+4M5h42P8HXQPVqIpx722ta34I6oHK6nUEWQSsJ9h/
        4eMEzjHcuJapi6gLxhMxj1cIiKCl7PcJqpvSou2fTCzEQg4=
X-Google-Smtp-Source: ABdhPJxbZqIFBvHIHDqRAaYc66wR00X+57Ot3XMwL6jhGMUV979fKuVbb+4Hakv7nixS9LL3OyEKmJg3d7wjBZdxock=
X-Received: by 2002:a17:906:eca5:: with SMTP id qh5mr3673714ejb.161.1612975324366;
 Wed, 10 Feb 2021 08:42:04 -0800 (PST)
MIME-Version: 1.0
References: <20210209174646.1310591-1-shy828301@gmail.com> <20210209174646.1310591-10-shy828301@gmail.com>
 <20210210012726.GO524633@carbon.DHCP.thefacebook.com> <CAHbLzkoKV6_w_KBp+cajvpxG2p8jN-es03C0ktk4tLdvULJwhg@mail.gmail.com>
 <1d751688-12a9-a5c3-2d9a-c4b9e65c7492@virtuozzo.com>
In-Reply-To: <1d751688-12a9-a5c3-2d9a-c4b9e65c7492@virtuozzo.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 10 Feb 2021 08:41:52 -0800
Message-ID: <CAHbLzkof4TL3cehgubYU-oAu_6x3ODnzDoOUyQDdn4xG0ts_-A@mail.gmail.com>
Subject: Re: [v7 PATCH 09/12] mm: vmscan: use per memcg nr_deferred of shrinker
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
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

On Wed, Feb 10, 2021 at 6:37 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 10.02.2021 04:52, Yang Shi wrote:
> > On Tue, Feb 9, 2021 at 5:27 PM Roman Gushchin <guro@fb.com> wrote:
> >>
> >> On Tue, Feb 09, 2021 at 09:46:43AM -0800, Yang Shi wrote:
> >>> Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
> >>> will be used in the following cases:
> >>>     1. Non memcg aware shrinkers
> >>>     2. !CONFIG_MEMCG
> >>>     3. memcg is disabled by boot parameter
> >>>
> >>> Signed-off-by: Yang Shi <shy828301@gmail.com>
> >>> ---
> >>>  mm/vmscan.c | 78 ++++++++++++++++++++++++++++++++++++++++++++---------
> >>>  1 file changed, 66 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >>> index d4b030a0b2a9..748aa6e90f83 100644
> >>> --- a/mm/vmscan.c
> >>> +++ b/mm/vmscan.c
> >>> @@ -368,6 +368,24 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
> >>>       up_write(&shrinker_rwsem);
> >>>  }
> >>>
> >>> +static long count_nr_deferred_memcg(int nid, struct shrinker *shrinker,
> >>> +                                 struct mem_cgroup *memcg)
> >>
> >> "Count" is not associated with xchg() semantics in my head, but I don't know
> >> what's the better version. Maybe steal or pop?
> >
> > It is used to retrieve the nr_deferred value. I don't think "steal" or
> > "pop" helps understand. Actually "count" is borrowed from
> > count_objects() method of shrinker.
>
> I'd also voted for another name.
>
> xchg_nr_deferred() or steal/pop sound better for me.

OK, I do have a hard time to understand steal/pop, but xchg sounds
more self-explained to me.

>
