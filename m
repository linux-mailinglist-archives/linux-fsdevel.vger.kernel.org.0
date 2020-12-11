Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0533E2D7F4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 20:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbgLKTVO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 14:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgLKTVN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 14:21:13 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFCFC0613CF;
        Fri, 11 Dec 2020 11:20:32 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id q8so12125735ljc.12;
        Fri, 11 Dec 2020 11:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lEGfJXljVJQVDFGapn/ihQVDl58e1Lo7WB4ovbMgJhY=;
        b=SJCqMVKN8LJ4lYCYfW9l2jF51GJox8OeV9lqspXx0jlpBDkFxzp0eJHgWUvtYm4G+Q
         u2mBuDV/1nQVNfDLD8+eZoCHrf4arG+GW8TWMtlEfKVuEEa5PZjPs2fBUI8UM5tSZHrc
         E3PHBxMc9xeRDnJToUAerqephAG77XYIZ9rurTpYczP3kXCIXamBj0FFcvbpOcky3MC2
         TOW/pQM/+Rd9X8CquN/a9gxJgJvbJNfyZRMjMEwiS31g72kux4ih7BJSk1BqB4179aGC
         Na911b4MKhH+xNkUgUCN7D8q1I7u2oDsRunI/FEzwpPcHsjKx4ZUavqa7totLIDR0Yv/
         zpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lEGfJXljVJQVDFGapn/ihQVDl58e1Lo7WB4ovbMgJhY=;
        b=TbkmErTR+q8aVXEGRRG+CC7NbhwPGTw0BmTYQrIUUpy9ZJ4xUt9A88pAc6FY/3MUmK
         KyCk7qFEC/nTl24YTfWtM940X7z0UU7gN086vXj53tg09QWuaxWI/QT4Fk+x8ING8B+f
         IGpYzw0rBn/Id3wyJmmPsqO/SvlstKJ6igtCNMIp/eHrEqp3e8sromk4jpXT5VOVsJYq
         5Yh9saKJyowy0oMEEtrVkXAOy9iSDxrpwmTImkqT4kSzZZMyykwqVrpJtMFneCdOXO3E
         jjGmFgGrWnCQXvoypvmCugICcUNN5Lb2kBiGS5lVgbl63sQijYeBu54nDO3kFPRTm1p0
         A42Q==
X-Gm-Message-State: AOAM5321cUqzG1wtR8DbyvUT/51yqHzgKR1ryhAXCy/VRKbDIfYQYG45
        vsUEEyqhdaw0G0qgJuHRc2cogywdHmX3Qz0M1X+svVnrixE=
X-Google-Smtp-Source: ABdhPJzb/hWU3/g5CvkMNDfdOVM5h2DtE0XxPTPg3z3CmqHPjeXluN9CzNtbBMmLlm6CDuybBz5q1d20bQsC+rOaltA=
X-Received: by 2002:a2e:874c:: with SMTP id q12mr5431858ljj.424.1607714431449;
 Fri, 11 Dec 2020 11:20:31 -0800 (PST)
MIME-Version: 1.0
References: <20201202182725.265020-1-shy828301@gmail.com> <20201202182725.265020-3-shy828301@gmail.com>
 <550518d6-fd50-72be-7c84-71153b470cfd@hisilicon.com>
In-Reply-To: <550518d6-fd50-72be-7c84-71153b470cfd@hisilicon.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 11 Dec 2020 11:20:19 -0800
Message-ID: <CAHbLzkr16gAYRpLceusLRtJQxx50Wxq1f3fUoGaYHC5-6U1K5g@mail.gmail.com>
Subject: Re: [PATCH 2/9] mm: vmscan: use nid from shrink_control for tracepoint
To:     "Xiaqing (A)" <saberlily.xia@hisilicon.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liu Yi <daniel.liuyi@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 2, 2020 at 7:13 PM Xiaqing (A) <saberlily.xia@hisilicon.com> wr=
ote:
>
>
>
> On 2020/12/3 2:27, Yang Shi wrote:
> > The tracepoint's nid should show what node the shrink happens on, the s=
tart tracepoint
> > uses nid from shrinkctl, but the nid might be set to 0 before end trace=
point if the
> > shrinker is not NUMA aware, so the traceing log may show the shrink hap=
pens on one
> > node but end up on the other node.  It seems confusing.  And the follow=
ing patch
> > will remove using nid directly in do_shrink_slab(), this patch also hel=
ps cleanup
> > the code.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >   mm/vmscan.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 7d6186a07daf..457ce04eebf2 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -533,7 +533,7 @@ static unsigned long do_shrink_slab(struct shrink_c=
ontrol *shrinkctl,
> >       new_nr =3D atomic_long_add_return(next_deferred,
> >                                       &shrinker->nr_deferred[nid]);
> >
> > -     trace_mm_shrink_slab_end(shrinker, nid, freed, nr, new_nr, total_=
scan);
> > +     trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new=
_nr, total_scan);
>
> Hi=EF=BC=8C Yang
>
> When I read this patch, I wondered why you modified it so much until I re=
ad patch6. Could you merge
> this patch into patch6?

Sorry for the late reply. It could be, but I was inclined to think
this is a bug and we might need backport it to stable, so I leave it
as a standalone patch.

>
> Thanks!
>
> >       return freed;
> >   }
> >
>
