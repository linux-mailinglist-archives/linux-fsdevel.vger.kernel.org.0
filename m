Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3CF308BBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 18:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhA2Rhy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 12:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbhA2Rfu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:35:50 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5D5C06121D;
        Fri, 29 Jan 2021 09:34:07 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a10so14171749ejg.10;
        Fri, 29 Jan 2021 09:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7AbfFtW9wjNzPs2gb41cdBCub4AmtYQa567TAt7+eSk=;
        b=fW09b7DjNMdUBdGrzUnBPYnJQoxcpvZfhOdZRUUN8LVpRoqTFls+GYUVapTLD50Ncj
         8klaOvFrq0xq8j7jHwtdPzDmqVoVJATwx/yrpDzOQxyrDXRWFEQMvmWmhW8/qXqHpChT
         LCLb4Qx0CQ6qmGhQVqNcM+4ZrhKKQA8lRRrZIDr0bzanBZ0axODSaFJUJS44Rw/WSf6O
         TjPk+oAl+wltEU3xuMxf0sBPTLRNpas/EGXBRPEIjc/DBpUiTrdD1mOz8dSGxfqC/9W7
         D81UFARhYPvHQ+vHpqRt2ZxS1cSAS5/W6vlEYyAjJ78GO50Be3NWej4lYhF0CNZ+idEp
         IyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7AbfFtW9wjNzPs2gb41cdBCub4AmtYQa567TAt7+eSk=;
        b=O4z6p3bBgMJaa2oP8qi4PhlUWcHeEZb90NV5MryVMwz8SUDJvmMnPnYieDH8w+vcqH
         NSAIrhHni+xwQJUtqCcb+UEGRlzFGhndVM6ae18vDhpD3pNMLGRz5SrZtCTbQSIkWL7R
         MV7j+cX2G/q4a9W7tG4u4J6pwnaVwNHSyfMnsd/NCDFrHvqliH5Ks6qJ34GKQpNsEs7d
         q0N6pTb7l+NxqOGb4blB1KJfKoo/2klBUkPj+fOio5t+d6EIr3K0z2vcBi50bvY7azEQ
         ppvsGy55EKPJi6jGEIszB/K3kik8aNLzZjuhxl3M0xBmmc9+LGCwX7yELvL3QSVa5S33
         HrTw==
X-Gm-Message-State: AOAM532nhGOxsXjrNb+uBS1B50RQZbGJVbLDDv8tIcz5XEHyI1rPHka8
        PXBHOLuXdG5ZldgAq8xVP2ReUt76hfqPEQXfjeU=
X-Google-Smtp-Source: ABdhPJzYUJW1OR8R+UztcPHrZXughbTxpfWpXdcqwJUSnF2pkMIirzRuTWc1h4+yC9UeHD+OMQUVIa6MP+ZB1tC1wjs=
X-Received: by 2002:a17:906:3945:: with SMTP id g5mr5881621eje.514.1611941646057;
 Fri, 29 Jan 2021 09:34:06 -0800 (PST)
MIME-Version: 1.0
References: <20210127233345.339910-1-shy828301@gmail.com> <20210127233345.339910-9-shy828301@gmail.com>
 <f205b9b8-5fdd-1c76-25ed-d96ed608c14c@suse.cz>
In-Reply-To: <f205b9b8-5fdd-1c76-25ed-d96ed608c14c@suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 29 Jan 2021 09:33:54 -0800
Message-ID: <CAHbLzkq-U3PO+V0a0BRkcT2xd3A7U5Gz_5n7ff8gRcFHTaw3yg@mail.gmail.com>
Subject: Re: [v5 PATCH 08/11] mm: vmscan: use per memcg nr_deferred of shrinker
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
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

On Fri, Jan 29, 2021 at 7:13 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 1/28/21 12:33 AM, Yang Shi wrote:
> > Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
> > will be used in the following cases:
> >     1. Non memcg aware shrinkers
> >     2. !CONFIG_MEMCG
> >     3. memcg is disabled by boot parameter
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/vmscan.c | 87 ++++++++++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 73 insertions(+), 14 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 20be0db291fe..e1f8960f5cf6 100644
>
> ...
>
> > @@ -653,14 +717,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >               next_deferred = 0;
> >       /*
> >        * move the unused scan count back into the shrinker in a
> > -      * manner that handles concurrent updates. If we exhausted the
> > -      * scan, there is no need to do an update.
> > +      * manner that handles concurrent updates.
> >        */
> > -     if (next_deferred > 0)
> > -             new_nr = atomic_long_add_return(next_deferred,
> > -                                             &shrinker->nr_deferred[nid]);
> > -     else
> > -             new_nr = atomic_long_read(&shrinker->nr_deferred[nid]);
>
> Why not keep this write avoidance if next_deferred == 0 in the new helper?

Because IMHO the write avoidance may not make too much difference
since nr_deferred was updated for the most cases per my tracing
result. So I thought this would make the code more clean.

>
> > +     new_nr = set_nr_deferred(next_deferred, shrinker, shrinkctl);
> >
> >       trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
> >       return freed;
> >
>
