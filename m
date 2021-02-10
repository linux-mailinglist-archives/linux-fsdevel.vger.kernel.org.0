Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC9F315CA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 02:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbhBJByM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 20:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbhBJBxQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 20:53:16 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31702C06174A;
        Tue,  9 Feb 2021 17:52:36 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id hs11so1168020ejc.1;
        Tue, 09 Feb 2021 17:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Y0hH4puqhVgD9YBJOu4kwdN95fkrF9cI64f+jI4TuI=;
        b=ZhFfu6fsO73uBpsqktPX6WQp9JLruC/kjVGMUNjZ8/k/51ZGMy2VIHKXk7uEyfVnxh
         IkH89bJZKTEieB09hSxu2LTNv3b02z/fxV9AglkncOF4uiySmKGOSGN+rRzNI5boce+Z
         Ll5ao3/eMEI6GI9IE+nofQM9UHtQYAdkvuQo1T0ECcFcqw15cE+f7a6uRAB6utNW0utA
         dbk/dKsEgxvLbMCMZYEUy8g33tFKXhWCmQ2fvzMVz5cupS7+Ca46ikTXy8IAgXsNcWof
         xL8BpE4uZdLZ7cvm9r92W6Aa+yBtjkJxuTCj1zLbMl41T/cgcVP9M/82j7PwmbeLkr4v
         El9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Y0hH4puqhVgD9YBJOu4kwdN95fkrF9cI64f+jI4TuI=;
        b=g+7zr1qZP1ZQx1LAspO+G7LvlB01DdXgx81LlNYgYzRX4yiCygAf8cqd2I+yAvDE/1
         HYlomqTljZMpw9iMWXldV5X9cTGTKvIDILU21H5OFI2OB8OOHKt3kuAJwA2I/gf9veWf
         jU62S8bryXcCS45CMtXnaUwYpmjKbANnxgHz74+5zf2rkHCIxr0JDWKC4zuhV+jIYBIS
         +5Tjy17iEPOvyLVP3O62dmSKyvlVlK7ChxRR3/WAxEHEWBIRlxNi7fiq3pVBVyP1jd/N
         J697bMrurUXqCQ6ZtGvWt8rOGShVSAaWpiBkju5cU92LDrEq4u9g0UyojahZsCS+IDpA
         mVcw==
X-Gm-Message-State: AOAM533jr2SRABCkIVaItHcpgGxYX78ZX6ePspBhft8Gy+ty+xTKkcWe
        4fyHYvChnxzHwaUtXf6TPHqRqgssSi8zBtNYEqg=
X-Google-Smtp-Source: ABdhPJzcLiBGc4YPhx9MdE321/TkRLGewWu8NTRYQyAc3lHaeqGjJf9dolDyIG4S39SrILg3xEX8gRuGkNc7Fwq5H9k=
X-Received: by 2002:a17:906:eca5:: with SMTP id qh5mr556226ejb.161.1612921955003;
 Tue, 09 Feb 2021 17:52:35 -0800 (PST)
MIME-Version: 1.0
References: <20210209174646.1310591-1-shy828301@gmail.com> <20210209174646.1310591-10-shy828301@gmail.com>
 <20210210012726.GO524633@carbon.DHCP.thefacebook.com>
In-Reply-To: <20210210012726.GO524633@carbon.DHCP.thefacebook.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 9 Feb 2021 17:52:23 -0800
Message-ID: <CAHbLzkoKV6_w_KBp+cajvpxG2p8jN-es03C0ktk4tLdvULJwhg@mail.gmail.com>
Subject: Re: [v7 PATCH 09/12] mm: vmscan: use per memcg nr_deferred of shrinker
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

On Tue, Feb 9, 2021 at 5:27 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Feb 09, 2021 at 09:46:43AM -0800, Yang Shi wrote:
> > Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
> > will be used in the following cases:
> >     1. Non memcg aware shrinkers
> >     2. !CONFIG_MEMCG
> >     3. memcg is disabled by boot parameter
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/vmscan.c | 78 ++++++++++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 66 insertions(+), 12 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index d4b030a0b2a9..748aa6e90f83 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -368,6 +368,24 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
> >       up_write(&shrinker_rwsem);
> >  }
> >
> > +static long count_nr_deferred_memcg(int nid, struct shrinker *shrinker,
> > +                                 struct mem_cgroup *memcg)
>
> "Count" is not associated with xchg() semantics in my head, but I don't know
> what's the better version. Maybe steal or pop?

It is used to retrieve the nr_deferred value. I don't think "steal" or
"pop" helps understand. Actually "count" is borrowed from
count_objects() method of shrinker.

>
> Otherwise the patch looks good to me.
>
> Thanks!
