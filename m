Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707F845E06D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 19:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237938AbhKYSOm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 13:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbhKYSMk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 13:12:40 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5DAC06137D;
        Thu, 25 Nov 2021 10:02:22 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x15so28739659edv.1;
        Thu, 25 Nov 2021 10:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJ+SaV/eDM4q53VkttaI0dp2MED2ax+NU0/r940A7o4=;
        b=Qu8819WrY12xyyyyok1zR9A+YMBN8poogIQOKBPMIa/UTfYyJq4TAA6lpI0Z/W2Us5
         xy0zcqi2ewUo9XrOBFoyk+zFVjZ+9/olz7NE9ULXIvn1qdSuKbwRtTjDI4tfmpxutwwA
         ZcY/uZzK8kk870L6/J4NPVFtlZgLQqcxHb+8XORolmSOVKJIJ5/4m9E8eQfjuAYz2fj9
         YtzCwUZRI4w9LlgNVW+4YF0XKYT6y9uIsefi9wKJH7FfHNnc7UOqzjGr236lkwrnTAQf
         UoK2SIdONgUoCQsfQAgwgku9wGcCqE5oST8Q8AyZXHiLyQWzNCYgUPj7wHeFbIGetYIf
         N1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJ+SaV/eDM4q53VkttaI0dp2MED2ax+NU0/r940A7o4=;
        b=a7bAkexy2yKxSl27Gagnp9kFCGHF+Q0wB9wXGYJ/LpCPg31onuy4RV2S6aEtWO9q9Y
         0EolfGCYl6OR4SaHaJ81YBGOBCwL+aZ+17KLQ0oOyI5oEmdhmxZpmJguc4lZelCrSPDZ
         MlEPv5TFgoGk71dvDZGDkx9PKxC7UPwYxr7Miols0FpOgT7HmQ0oKOX/LaYLZvoscdwo
         MaQ7pi3gEvwjjjxS22lgrVTyTw2A6BLQEddMP6OV4WoWVBBVhpr8brTiAQ+DekmHkAtk
         9tq9YHVnp9awRrb2vGKgc5f/KO7YFtm7zgWG3YkUDdg2mPXp4/hS1MeXoAZ1dUj02iEE
         JnIw==
X-Gm-Message-State: AOAM530Sb4XLpL9OpGJ8IlxcQ/Xy802tm3VONZkXO2MS9aeucXHMzIt8
        OCR75QiZu1YWYNuQSofuEGdB1udYhsCkoLGfRcQ=
X-Google-Smtp-Source: ABdhPJzdU3cWnsA12BQIupjc5eX0+2HubATbsuDvAdmDgOFkpDSZnb5YKJBtAXnUxTV2x/1FiK/ontL5OC8P89AvEp0=
X-Received: by 2002:a50:d883:: with SMTP id p3mr40853791edj.94.1637863340496;
 Thu, 25 Nov 2021 10:02:20 -0800 (PST)
MIME-Version: 1.0
References: <20211122153233.9924-1-mhocko@kernel.org> <20211122153233.9924-3-mhocko@kernel.org>
 <YZ06nna7RirAI+vJ@pc638.lan> <20211123170238.f0f780ddb800f1316397f97c@linux-foundation.org>
 <YZ6cfoQah8Wo1eSZ@pc638.lan> <YZ9Nb2XA/OGWL1zz@dhcp22.suse.cz>
In-Reply-To: <YZ9Nb2XA/OGWL1zz@dhcp22.suse.cz>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Thu, 25 Nov 2021 19:02:09 +0100
Message-ID: <CA+KHdyUFjqdhkZdTH=4k=ZQdKWs8MauN1NjXXwDH6J=YDuFOPA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 25, 2021 at 9:46 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 24-11-21 21:11:42, Uladzislau Rezki wrote:
> > On Tue, Nov 23, 2021 at 05:02:38PM -0800, Andrew Morton wrote:
> > > On Tue, 23 Nov 2021 20:01:50 +0100 Uladzislau Rezki <urezki@gmail.com> wrote:
> > >
> > > > On Mon, Nov 22, 2021 at 04:32:31PM +0100, Michal Hocko wrote:
> > > > > From: Michal Hocko <mhocko@suse.com>
> > > > >
> > > > > Dave Chinner has mentioned that some of the xfs code would benefit from
> > > > > kvmalloc support for __GFP_NOFAIL because they have allocations that
> > > > > cannot fail and they do not fit into a single page.
> > >
> > > Perhaps we should tell xfs "no, do it internally".  Because this is a
> > > rather nasty-looking thing - do we want to encourage other callsites to
> > > start using it?
> > >
> > > > > The large part of the vmalloc implementation already complies with the
> > > > > given gfp flags so there is no work for those to be done. The area
> > > > > and page table allocations are an exception to that. Implement a retry
> > > > > loop for those.
> > > > >
> > > > > Add a short sleep before retrying. 1 jiffy is a completely random
> > > > > timeout. Ideally the retry would wait for an explicit event - e.g.
> > > > > a change to the vmalloc space change if the failure was caused by
> > > > > the space fragmentation or depletion. But there are multiple different
> > > > > reasons to retry and this could become much more complex. Keep the retry
> > > > > simple for now and just sleep to prevent from hogging CPUs.
> > > > >
> > >
> > > Yes, the horse has already bolted.  But we didn't want that horse anyway ;)
> > >
> > > I added GFP_NOFAIL back in the mesozoic era because quite a lot of
> > > sites were doing open-coded try-forever loops.  I thought "hey, they
> > > shouldn't be doing that in the first place, but let's at least
> > > centralize the concept to reduce code size, code duplication and so
> > > it's something we can now grep for".  But longer term, all GFP_NOFAIL
> > > sites should be reworked to no longer need to do the retry-forever
> > > thing.  In retrospect, this bright idea of mine seems to have added
> > > license for more sites to use retry-forever.  Sigh.
> > >
> > > > > +               if (nofail) {
> > > > > +                       schedule_timeout_uninterruptible(1);
> > > > > +                       goto again;
> > > > > +               }
> > >
> > > The idea behind congestion_wait() is to prevent us from having to
> > > hard-wire delays like this.  congestion_wait(1) would sleep for up to
> > > one millisecond, but will return earlier if reclaim events happened
> > > which make it likely that the caller can now proceed with the
> > > allocation event, successfully.
> > >
> > > However it turns out that congestion_wait() was quietly broken at the
> > > block level some time ago.  We could perhaps resurrect the concept at
> > > another level - say by releasing congestion_wait() callers if an amount
> > > of memory newly becomes allocatable.  This obviously asks for inclusion
> > > of zone/node/etc info from the congestion_wait() caller.  But that's
> > > just an optimization - if the newly-available memory isn't useful to
> > > the congestion_wait() caller, they just fail the allocation attempts
> > > and wait again.
> > >
> > > > well that is sad...
> > > > I have raised two concerns in our previous discussion about this change,
> > >
> > > Can you please reiterate those concerns here?
> > >
> > 1. I proposed to repeat(if fails) in one solid place, i.e. get rid of
> > duplication and spreading the logic across several places. This is about
> > simplification.
>
> I am all for simplifications. But the presented simplification lead to 2) and ...
>
> > 2. Second one is about to do an unwinding and release everything what we
> > have just accumulated in terms of memory consumption. The failure might
> > occur, if so a condition we are in is a low memory one or high memory
> > pressure. In this case, since we are about to sleep some milliseconds
> > in order to repeat later, IMHO it makes sense to release memory:
> >
> > - to prevent killing apps or possible OOM;
> > - we can end up looping quite a lot of time or even forever if users do
> >   nasty things with vmalloc API and __GFP_NOFAIL flag.
>
> ... this is where we disagree and I have tried to explain why. The primary
> memory to allocate are pages to back the vmalloc area. Failing to
> allocate few page tables - which btw. do not fail as they are order-0 -
> and result into the whole and much more expensive work to allocate the
> former is really wasteful. You've had a concern about OOM killer
> invocation while retrying the page table allocation but you should
> realize that page table allocations might already invoke OOM killer so that
> is absolutely nothing new.
>
We are in a slow path and this is a corner case, it means we will
timeout for many
milliseconds, for example for CONFIG_HZ_100 it is 10 milliseconds. I would agree
with you if it was requesting some memory and repeating in a tight loop because
of any time constraint and workloads sensitive to latency.

Is it sensitive to any workload? If so, we definitely can not go with
any delay there.

As for OOM, right you are. But it also can be that we are the source
who triggers it,
directly or indirectly. Unwinding and cleaning is a maximum what we
actually can do
here staying fair to OOM.

Therefore i root for simplification and OOM related concerns :) But
maybe there will
be other opinions.

Thanks!

--
Uladzislau Rezki
