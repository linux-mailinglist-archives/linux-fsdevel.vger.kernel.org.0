Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBF42DDC94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 02:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732203AbgLRBK3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 20:10:29 -0500
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:60594 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730792AbgLRBK3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 20:10:29 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id B51871B00B3;
        Fri, 18 Dec 2020 12:09:44 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kq4Gu-0055zP-E0; Fri, 18 Dec 2020 12:09:28 +1100
Date:   Fri, 18 Dec 2020 12:09:28 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v2 PATCH 7/9] mm: vmscan: don't need allocate
 shrinker->nr_deferred for memcg aware shrinkers
Message-ID: <20201218010928.GB1199812@dread.disaster.area>
References: <20201214223722.232537-1-shy828301@gmail.com>
 <20201214223722.232537-8-shy828301@gmail.com>
 <20201215030528.GN3913616@dread.disaster.area>
 <CAHbLzkoOcTuidghuR_pLsE4RX_6DiwXW+k2EQRJxrB6BDqhvBA@mail.gmail.com>
 <CAHbLzkoWco5gq8tuxbTsfpTF3GPUQLn9uNUTy1nUNwKGVPonmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkoWco5gq8tuxbTsfpTF3GPUQLn9uNUTy1nUNwKGVPonmg@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=pGLkceISAAAA:8 a=7-415B0cAAAA:8
        a=KvEUY9y020M9keOLPwQA:9 a=CjuIK1q_8ugA:10 a=-RoEEKskQ1sA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 04:56:48PM -0800, Yang Shi wrote:
> On Tue, Dec 15, 2020 at 3:07 PM Yang Shi <shy828301@gmail.com> wrote:
> > > This guarantees that only the shrinker instances taht have a
> > > correctly set up memcg attached to them will have the
> > > SHRINKER_MEMCG_AWARE flag set. Hence in all the rest of the shrinker
> > > code, we only ever need to check for SHRINKER_MEMCG_AWARE to
> > > determine what we should do....
> >
> > Thanks. I see your point. We could move the memcg specific details
> > into prealloc_memcg_shrinker().
> >
> > It seems we have to acquire shrinker_rwsem before we check and modify
> > SHIRNKER_MEMCG_AWARE bit if we may clear it.
> 
> Hi Dave,
> 
> Is it possible that shrinker register races with shrinker unregister?
> It seems impossible to me by a quick visual code inspection. But I'm
> not a VFS expert so I'm not quite sure.

Uh, if you have a shrinker racing to register and unregister, you've
got a major bug in your object initialisation/teardown code. i.e.
calling reagister/unregister at the same time for the same shrinker
is a bug, pure and simple.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
