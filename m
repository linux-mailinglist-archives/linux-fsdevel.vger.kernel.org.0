Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCB0331148
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 15:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbhCHOzG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 09:55:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:48514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhCHOyp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:54:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D45BA650E6;
        Mon,  8 Mar 2021 14:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615215284;
        bh=X0lo3Qat103XhQ7n/pn8ZYoJZykAVsMGsMiUCcu70Gg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=spN/4KqC5tfWitVZ0K4hQKMgdT5PR7dE0yZ4vY3o/eTBu+ZJKHDmjX0GRAjR56shy
         sIBrrKwmWso/Ujqm3NAFRWP+nMmivkGG+eTEaF+1qPy62alkQ281yTtyuaE2EZauCs
         tWtbEHqaDqapcSrOg0sJ9PshTRbx7bGKEiAV1bwTvO/w0mPFLyZ00S6o6Gqg78SUBL
         URzO0Fblz7kem2JXTK+9UHraUjl+yXtrT3PxudL2JE9SMAP01qJ9UmTc97H6LNhdD/
         4yFZkn2E6Q4SttLFGWFWtbonCNKjX2Pp1YIXufEG0eOy3EObsGcLTgKM2IEGPq3yq2
         YeYAJirKmLHMg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9C23B35239E1; Mon,  8 Mar 2021 06:54:44 -0800 (PST)
Date:   Mon, 8 Mar 2021 06:54:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Yang Shi <shy828301@gmail.com>, Roman Gushchin <guro@fb.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v8 PATCH 05/13] mm: vmscan: use kvfree_rcu instead of call_rcu
Message-ID: <20210308145444.GN2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210217001322.2226796-1-shy828301@gmail.com>
 <20210217001322.2226796-6-shy828301@gmail.com>
 <CALvZod75fge=B9LNg_sxbCiwDZjjtn8A9Q2HzU_R6rcg551o6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod75fge=B9LNg_sxbCiwDZjjtn8A9Q2HzU_R6rcg551o6Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 07, 2021 at 10:13:04PM -0800, Shakeel Butt wrote:
> On Tue, Feb 16, 2021 at 4:13 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > Using kvfree_rcu() to free the old shrinker_maps instead of call_rcu().
> > We don't have to define a dedicated callback for call_rcu() anymore.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/vmscan.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 2e753c2516fa..c2a309acd86b 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -192,11 +192,6 @@ static inline int shrinker_map_size(int nr_items)
> >         return (DIV_ROUND_UP(nr_items, BITS_PER_LONG) * sizeof(unsigned long));
> >  }
> >
> > -static void free_shrinker_map_rcu(struct rcu_head *head)
> > -{
> > -       kvfree(container_of(head, struct memcg_shrinker_map, rcu));
> > -}
> > -
> >  static int expand_one_shrinker_map(struct mem_cgroup *memcg,
> >                                    int size, int old_size)
> >  {
> > @@ -219,7 +214,7 @@ static int expand_one_shrinker_map(struct mem_cgroup *memcg,
> >                 memset((void *)new->map + old_size, 0, size - old_size);
> >
> >                 rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
> > -               call_rcu(&old->rcu, free_shrinker_map_rcu);
> > +               kvfree_rcu(old);
> 
> Please use kvfree_rcu(old, rcu) instead of kvfree_rcu(old). The single
> param can call synchronize_rcu().

Especially given that you already have the ->rcu field that the
two-argument form requires.

The reason for using the single-argument form is when you have lots of
little data structures, such that getting rid of that rcu_head structure
is valuable enough to be worth the occasional call to synchronize_rcu().
However, please note that this call to synchronize_rcu() happens only
under OOM conditions.

							Thanx, Paul
