Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086DA308072
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 22:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhA1VXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 16:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhA1VXR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 16:23:17 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28831C061573;
        Thu, 28 Jan 2021 13:22:37 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id g1so8299013edu.4;
        Thu, 28 Jan 2021 13:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iky+DugOhX1hDNU3AWl/82OLUGd7e4uUQOiW57Oek80=;
        b=USzLlpmi1mBOqEu9XY81zRzzf+qzbqJv194UHN5m5M+QpQ0uKDo+sBGdT0gQy8jNMK
         o5vc0IP99E2JOhGR/e8aBVRdzRET0CJa3NQIZok5SKcuNYvr/kLx1FYUpMbeg6yDBcsy
         8XC6N3guc2KshmE+DF/+3hfJJiEEULacyTThIoOb7FN1IdoSOGmo4CiN3SUkPyyYGFb2
         z4J5ZSG+5kra4ru8YMsy9SKz+2IML0VPlOhMFdNI0PgJndwmxFVqX+UMu7b+lXNy7+Px
         dh0Ujyy65MmDvQrtN4rHwAYIIGz3vHAn6uJEJuhCFLi7Czc3nv3D2NCszIewnk1vxBHJ
         y/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iky+DugOhX1hDNU3AWl/82OLUGd7e4uUQOiW57Oek80=;
        b=XRKxhTWieu0gspZFMq0NiKneqj0tUpoMAV9THr9fNjeJ0Y5u4ehQJU3gJVzCu+mAmj
         FxBSflY4PDxzdv5TcZiU57BFvYP2LILudjwQUp2Fhwxlzl+r0C2/CMB8nvMF8+ITmYvt
         3BDJdGerEpVDMhaEPzvACMqlCiuXSCDOSp2uO0abQGrrFQfSre/VJfpZn2UcE1xc+FtJ
         tcVwi++ygvcKZ4yET3UxRHDNwQZEwoMCifwiwx0/XPMpOIMi+HyFaGBYT62n6Sna1PgP
         cFVPWdWH9Rbq0Y3AMSJyLsuys90uFyEMuFnmE7xv0luAbuDXxbBfjGunnxF0u3Xqq9SV
         LK+Q==
X-Gm-Message-State: AOAM531il807MsZp3VsJnx8U9AYHoRAsnUGeRQGsHPbTNcHo66rfDpTi
        w3YcStDPmJ37qo92F04Atq+Id5bWOq2RaiwYKUA=
X-Google-Smtp-Source: ABdhPJwbu0bZDCE0LMnecgpA/vbNy1VOG2Gthhi97YaSV3LvX82i39z8aXTCyggUdueGOuBBwISGHCnSt9U8RpOtrVY=
X-Received: by 2002:a05:6402:312e:: with SMTP id dd14mr1801362edb.366.1611868955853;
 Thu, 28 Jan 2021 13:22:35 -0800 (PST)
MIME-Version: 1.0
References: <20210127233345.339910-1-shy828301@gmail.com> <20210127233345.339910-5-shy828301@gmail.com>
 <255b9236-3e0b-f6f6-4a72-5e69351a979a@suse.cz>
In-Reply-To: <255b9236-3e0b-f6f6-4a72-5e69351a979a@suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 28 Jan 2021 13:22:23 -0800
Message-ID: <CAHbLzkrN2aW03TUrC3sOANS7YV6+KMisDtsXDH2W42-1tOJziw@mail.gmail.com>
Subject: Re: [v5 PATCH 04/11] mm: vmscan: remove memcg_shrinker_map_size
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

On Thu, Jan 28, 2021 at 8:53 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 1/28/21 12:33 AM, Yang Shi wrote:
> > Both memcg_shrinker_map_size and shrinker_nr_max is maintained, but actually the
> > map size can be calculated via shrinker_nr_max, so it seems unnecessary to keep both.
> > Remove memcg_shrinker_map_size since shrinker_nr_max is also used by iterating the
> > bit map.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/vmscan.c | 18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index d3f3701dfcd2..847369c19775 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -185,8 +185,7 @@ static LIST_HEAD(shrinker_list);
> >  static DECLARE_RWSEM(shrinker_rwsem);
> >
> >  #ifdef CONFIG_MEMCG
> > -
> > -static int memcg_shrinker_map_size;
> > +static int shrinker_nr_max;
> >
> >  static void free_shrinker_map_rcu(struct rcu_head *head)
> >  {
> > @@ -248,7 +247,7 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
> >               return 0;
> >
> >       down_write(&shrinker_rwsem);
> > -     size = memcg_shrinker_map_size;
> > +     size = (shrinker_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long);
> >       for_each_node(nid) {
> >               map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
> >               if (!map) {
> > @@ -266,12 +265,13 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
> >  static int expand_shrinker_maps(int new_id)
> >  {
> >       int size, old_size, ret = 0;
> > +     int new_nr_max = new_id + 1;
> >       struct mem_cgroup *memcg;
> >
> > -     size = DIV_ROUND_UP(new_id + 1, BITS_PER_LONG) * sizeof(unsigned long);
> > -     old_size = memcg_shrinker_map_size;
> > +     size = (new_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long);
> > +     old_size = (shrinker_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long);
>
> What's wrong with using DIV_ROUND_UP() here?

I don't think there is anything wrong with DIV_ROUND_UP. Should be
just different taste and result in shorter statement.

>
> >       if (size <= old_size)
> > -             return 0;
> > +             goto out;
>
> Can this even happen? Seems to me it can't, so just remove this?

Yes, it can. The maps use unsigned long value for bitmap, so any
shrinker ID < 31 would fall into the same unsigned long, so we may see
size <= old_size, but we need increase shrinker_nr_max since
expand_shrinker_maps() is called iff id >= shrinker_nr_max.

>
> >
> >       if (!root_mem_cgroup)
> >               goto out;
> > @@ -286,9 +286,10 @@ static int expand_shrinker_maps(int new_id)
> >                       goto out;
> >               }
> >       } while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
> > +
> >  out:
> >       if (!ret)
> > -             memcg_shrinker_map_size = size;
> > +             shrinker_nr_max = new_nr_max;
> >
> >       return ret;
> >  }
> > @@ -321,7 +322,6 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
> >  #define SHRINKER_REGISTERING ((struct shrinker *)~0UL)
> >
> >  static DEFINE_IDR(shrinker_idr);
> > -static int shrinker_nr_max;
> >
> >  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> >  {
> > @@ -338,8 +338,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> >                       idr_remove(&shrinker_idr, id);
> >                       goto unlock;
> >               }
> > -
> > -             shrinker_nr_max = id + 1;
> >       }
> >       shrinker->id = id;
> >       ret = 0;
> >
>
