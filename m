Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3D72115637
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 18:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfLFRLj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 12:11:39 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42350 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfLFRLj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 12:11:39 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so6400498otd.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2019 09:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jD0+Lu/50umCcnFk47baEBnRzer/9Wr3R9ZTFDVWkyo=;
        b=BtnQMvEbwtt6/VLxRAoWXkpfefD3gvNVveWwFIJ55OWOS4sCdvULYIKLAAkPQ38NUQ
         VSuDsqRZFzSJjfwQrNCfJzPZ62NIdVWvCXTynbU8nKxDGJfCvMJ+2yH5YwDwxaNCtQb0
         vTkiHzOWn+n5Bcu7n7lYX8QMuS97lWhR9SPmFVwP0lKo+bs8nvgpRSrlUoa3FPbJvRIW
         ykxfTtJYA3V5WqjWRJ4xznqgTPEP2j9SIo3DHyN4AjhJjcKbQtVyORXp1JlkNAl/Mt36
         at7IPpKDE2UV+UCesHN7YzVUdIuaDZVqTf8//UOw6emtqxahLvhaFcXbno6Pb4z7HEc5
         Hing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jD0+Lu/50umCcnFk47baEBnRzer/9Wr3R9ZTFDVWkyo=;
        b=ijgpIgQLbvqqOLClLVoskEp07YgTlxpbeHdJ1fdDHaN6Ft8ZXyB7dXYJ5bXyGSYq44
         DMkU8adJXzgDyX1lVqNMJ4qkd1sFRrixhESvc4/4TwBF8XpqjTz7+CFiIOZjAwko7ALn
         e80Ub8NTVx+H5n9vlK2NyLFxTGS/Xt5rZjiLMXwJBX9X3CojD3qAqPaUZbAUigxJ5aqn
         ddxBi6FVx66WYv1tbl9mxnGi/7dkDQ51Nii7lmS/vbh7gZydT0eZnLOOB1Q+0AMjS4+v
         HfwqlhDNCsNNDZEfKONvDcZngQYRkAlorVCjp1tQtLWdkwCXAMTqzX2pjZR12Cf0A4GV
         5JYQ==
X-Gm-Message-State: APjAAAVdQjqoyq282Rd6JREazEXzojGi7XoOO/cYgGERSlVNVjdY9IVs
        CG6JHnsW88NNV/5jidfXwOlMyep6CpB4SpnfX+9zOg==
X-Google-Smtp-Source: APXvYqxrRvzqID3gKuXZMGxfhtP1lPTktAwM4vu1LXlhqcCXWhlKJvZjVzGRTN55vA+hR8OvP8EWCvSLQ8pzb/W32Ak=
X-Received: by 2002:a05:6830:10d5:: with SMTP id z21mr12202292oto.30.1575652297469;
 Fri, 06 Dec 2019 09:11:37 -0800 (PST)
MIME-Version: 1.0
References: <20191129214541.3110-1-ptikhomirov@virtuozzo.com>
 <4e2d959a-0b0e-30aa-59b4-8e37728e9793@virtuozzo.com> <20191206020953.GS2695@dread.disaster.area>
In-Reply-To: <20191206020953.GS2695@dread.disaster.area>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 6 Dec 2019 09:11:25 -0800
Message-ID: <CALvZod4YrnLLbaqTrZR92Y45rd4G+UzcqrkwAptJGJ2Kc8i6Og@mail.gmail.com>
Subject: Re: [PATCH] mm: fix hanging shrinker management on long do_shrink_slab
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 5, 2019 at 6:10 PM Dave Chinner <david@fromorbit.com> wrote:
>
> [please cc me on future shrinker infrastructure modifications]
>
> On Mon, Dec 02, 2019 at 07:36:03PM +0300, Andrey Ryabinin wrote:
> >
> > On 11/30/19 12:45 AM, Pavel Tikhomirov wrote:
> > > We have a problem that shrinker_rwsem can be held for a long time for
> > > read in shrink_slab, at the same time any process which is trying to
> > > manage shrinkers hangs.
> > >
> > > The shrinker_rwsem is taken in shrink_slab while traversing shrinker_list.
> > > It tries to shrink something on nfs (hard) but nfs server is dead at
> > > these moment already and rpc will never succeed. Generally any shrinker
> > > can take significant time to do_shrink_slab, so it's a bad idea to hold
> > > the list lock here.
>
> registering/unregistering a shrinker is not a performance critical
> task.

Yes, not performance critical but it can cause isolation issues.

> If a shrinker is blocking for a long time, then we need to
> work to fix the shrinker implementation because blocking is a much
> bigger problem than just register/unregister.
>

Yes, we should be fixing the implementations of all shrinkers and yes
it is bigger issue but we can also fix register/unregister isolation
issue in parallel. Fixing all shrinkers would a tedious and long task
and we should not block fixing isolation issue on it.

> > > The idea of the patch is to inc a refcount to the chosen shrinker so it
> > > won't disappear and release shrinker_rwsem while we are in
> > > do_shrink_slab, after that we will reacquire shrinker_rwsem, dec
> > > the refcount and continue the traversal.
>
> This is going to cause a *lot* of traffic on the shrinker rwsem.
> It's already a pretty hot lock on large machines under memory
> pressure (think thousands of tasks all doing direct reclaim across
> hundreds of CPUs), and so changing them to cycle the rwsem on every
> shrinker that will only make this worse. Esepcially when we consider
> that there may be hundreds to thousands of registered shrinker
> instances on large machines.
>
> As an example of how frequent cycling of a global lock in shrinker
> instances causes issues, we used to take references to superblock
> shrinker count invocations to guarantee existence. This was found to
> be a scalability limitation when lots of near-empty superblocks were
> present in a system (see commit d23da150a37c ("fs/superblock: avoid
> locking counting inodes and dentries before reclaiming them")).
>
> This alleviated the problem for a while, but soon we had problems
> with just taking a reference to the superblock in the callbacks that
> did actual work. Hence we changed it to just take a per-superblock
> rwsem to get rid of the global sb_lock spinlock in this path. See
> commit eb6ef3df4faa ("trylock_super(): replacement for
> grab_super_passive()". Now we don't have a scalability problem.
>
> IOWs, we already know that cycling a global rwsem on every
> individual shrinker invocation is going to cause noticable
> scalability problems. Hence I don't think that this sort of "cycle
> the global rwsem faster to reduce [un]register latency" solution is
> going to fly because of the runtime performance regressions it will
> introduce....
>

I agree with your scalability concern (though others would argue to
first demonstrate the issue before adding more sophisticated scalable
code). Most memory reclaim code is written without the performance or
scalability concern, maybe we should switch our thinking.

> > I don't think this patch solves the problem, it only fixes one minor symptom of it.
> > The actual problem here the reclaim hang in the nfs.
>
> The nfs client is waiting on the NFS server to respond. It may
> actually be that the server has hung, not the client...
>
> > It means that any process, including kswapd, may go into nfs inode reclaim and stuck there.
>
> *nod*
>
> > I think this should be handled on nfs/vfs level by making  inode eviction during reclaim more asynchronous.
>
> That's what we are trying to do with similar blocking based issues
> in XFS inode reclaim. It's not simple, though, because these days
> memory reclaim is like a bowl full of spaghetti covered with a
> delicious sauce of non-obvious heuristics and broken
> functionality....
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
