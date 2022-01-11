Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994CA48A62C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 04:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245262AbiAKDTp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 22:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346862AbiAKDTm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:19:42 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC80FC06175D
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jan 2022 19:19:41 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id p187so1058885ybc.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jan 2022 19:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5EBf9IiwrsGpNW9Obfjl+AtKxYOGgprHkSqzFWQENdI=;
        b=dc1lbQBKRWe5Q0/AtI77wPv/JJIVAuu74aEoXrpslvIEHtREn97kHGjxA39TizH+Bg
         6n5A8oeZbZURuegDPdJ9wlP4V44PWU3m5ZCSurSGAwHBepBocZkve4mqJWEEXCv57wLl
         FrwlOeJVEsmwP6MoyeO/qRsAzsDoE7D90Zl7zAvmnB1Vt+sHNnaVB2jxznVenQW8ZokG
         jOjJBJIKZ4UDK1R1ou4vqzWv5R0Z3LKw5ft6/dtrTPyckj2Ikj/5WbbyM82fEvktvfl2
         D9QV/7rIcPs8XIqVOe6fr8Xn3RqMGBio/EqH8we82eVwPh4ddMkrpE13UUFsv7Qq2vzE
         cVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5EBf9IiwrsGpNW9Obfjl+AtKxYOGgprHkSqzFWQENdI=;
        b=cKJGxHzJiUqrPgW5AEqRmi1tAyXwYG72AxnEh3iJNZzhRlBgOKQ5D4Pxn+0Rh7f2JK
         35vjY5iAOvXNexDZzrueYzlMxkvQOPCJG0j+tF493mbgyPQpqpALApTcU8VmC3swx7ph
         HbD6o4hLJYPPfD6a1AzlgwbS5OrhcS/FYouw9c7IglyU2IVz5xDHmnaVt5FPhdYJs1Cb
         Naou7/Fh/inhJL9TRdpdgjkBwPRUwK8gUrXjI2GJfdH4A9kZSj/0woURrxDT5RQM0DdW
         1vqpwVTpor7B7snFkUBAlmbk78Sl2r21wAFvWrzeAb4eyaM25da88taSYNBnsJ8p8ukS
         i4Sw==
X-Gm-Message-State: AOAM533s0EgMuVwX9dhBFdSvvIMsKHi3XV8q0dMlsusVLKo8lIx0IK7u
        Cr0pUZFMFZpD+rDGPndoiqdMtVsgRpKfEaNixqzxWA==
X-Google-Smtp-Source: ABdhPJwVDZnN4qKaKZWU5xT65Jon7AIpUB45deglJ5jO2u724/5prxvNeb77GYV6EXBDZAeFqdTMs9sq4E9WfYe3S+k=
X-Received: by 2002:a25:af4b:: with SMTP id c11mr3660515ybj.49.1641871180863;
 Mon, 10 Jan 2022 19:19:40 -0800 (PST)
MIME-Version: 1.0
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-2-songmuchun@bytedance.com> <YdeDym9IUghnagrK@carbon.dhcp.thefacebook.com>
 <CAMZfGtV2G=R9nTuSYGAeqv+RkJsCVVACc3h47OeWA7n3mWbqsA@mail.gmail.com> <Ydx+BWQp18hjdO32@carbon.dhcp.thefacebook.com>
In-Reply-To: <Ydx+BWQp18hjdO32@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 11 Jan 2022 11:19:04 +0800
Message-ID: <CAMZfGtVDjtG2D3Ri4WROD5F1cSeA+V+t1W+TXmOQzJoJdPg+kQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/16] mm: list_lru: optimize memory consumption of
 arrays of per cgroup lists
To:     Roman Gushchin <guro@fb.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>, Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org,
        Kari Argillander <kari.argillander@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 11, 2022 at 2:42 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Sun, Jan 09, 2022 at 12:49:56PM +0800, Muchun Song wrote:
> > On Fri, Jan 7, 2022 at 8:05 AM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Mon, Dec 20, 2021 at 04:56:34PM +0800, Muchun Song wrote:
> > > > The list_lru uses an array (list_lru_memcg->lru) to store pointers
> > > > which point to the list_lru_one. And the array is per memcg per node.
> > > > Therefore, the size of the arrays will be 10K * number_of_node * 8 (
> > > > a pointer size on 64 bits system) when we run 10k containers in the
> > > > system. The memory consumption of the arrays becomes significant. The
> > > > more numa node, the more memory it consumes.
> > > >
> > > > I have done a simple test, which creates 10K memcg and mount point
> > > > each in a two-node system. The memory consumption of the list_lru
> > > > will be 24464MB. After converting the array from per memcg per node
> > > > to per memcg, the memory consumption is going to be 21957MB. It is
> > > > reduces by 2.5GB. In our AMD servers with 8 numa nodes in those
> > > > sysuem, the memory consumption could be more significant. The savings
> > > > come from the list_lru_one heads, that it also simplifies the
> > > > alloc/dealloc path.
> > > >
> > > > The new scheme looks like the following.
> > > >
> > > >   +----------+   mlrus   +----------------+   mlru   +----------------------+
> > > >   | list_lru +---------->| list_lru_memcg +--------->|  list_lru_per_memcg  |
> > > >   +----------+           +----------------+          +----------------------+
> > > >                                                      |  list_lru_per_memcg  |
> > > >                                                      +----------------------+
> > > >                                                      |          ...         |
> > > >                           +--------------+   node    +----------------------+
> > > >                           | list_lru_one |<----------+  list_lru_per_memcg  |
> > > >                           +--------------+           +----------------------+
> > > >                           | list_lru_one |
> > > >                           +--------------+
> > > >                           |      ...     |
> > > >                           +--------------+
> > > >                           | list_lru_one |
> > > >                           +--------------+
> > > >
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > >
> > > As much as I like the code changes (there is indeed a significant simplification!),
> > > I don't like the commit message and title, because I wasn't able to understand
> > > what the patch is doing and some parts look simply questionable. Overall it
> > > sounds like you reduce the number of list_lru_one structures, which is not true.
> > >
> > > How about something like this?
> > >
> > > --
> > > mm: list_lru: transpose the array of per-node per-memcg lru lists
> > >
> > > The current scheme of maintaining per-node per-memcg lru lists looks like:
> > >   struct list_lru {
> > >     struct list_lru_node *node;           (for each node)
> > >       struct list_lru_memcg *memcg_lrus;
> > >         struct list_lru_one *lru[];       (for each memcg)
> > >   }
> > >
> > > By effectively transposing the two-dimension array of list_lru_one's structures
> > > (per-node per-memcg => per-memcg per-node) it's possible to save some memory
> > > and simplify alloc/dealloc paths. The new scheme looks like:
> > >   struct list_lru {
> > >     struct list_lru_memcg *mlrus;
> > >       struct list_lru_per_memcg *mlru[];  (for each memcg)
> > >         struct list_lru_one node[0];      (for each node)
> > >   }
> > >
> > > Memory savings are coming from having fewer list_lru_memcg structures, which
> > > contain an extra struct rcu_head to handle the destruction process.
> >
> > My bad English. Actually, the saving is coming from not only 'struct rcu_head'
> > but also some pointer arrays used to store the pointer to 'struct list_lru_one'.
> > The array is per node and its size is 8 (a pointer) * num_memcgs.
>
> Nice! Please, add this to the commit log.

Will do.

>
> > So the total
> > size of the arrays is  8 * num_nodes * memcg_nr_cache_ids. After this patch,
> > the size becomes 8 * memcg_nr_cache_ids. So the saving is
> >
> >    8 * (num_nodes - 1) * memcg_nr_cache_ids.
> >
> > > --
> > >
> > > But what worries me is that memory savings numbers you posted don't do up.
> > > In theory we can save
> > > 16 (size of struct rcu_head) * 10000 (number of cgroups) * 2 (number of numa nodes) = 320k
> > > per slab cache. Did you have a ton of mount points? Otherwise I don't understand
> > > where these 2.5Gb are coming from.
> >
> > memcg_nr_cache_ids is 12286 when creating 10k memcgs. So the saving
> > of arrays of one list_lru is 8 * 1 (number of numa nodes - 1) * 12286 = 96k.
> > There will be 2 * 10k list_lru when mounting 10k points. So the total
> > saving is 96k * 2 * 10k = 1920 M.
>
> So, there are 10k cgroups _and_ 10k mountpoints. Please, make it obvious from
> the commit log. Most users don't have that many mount points (and likely cgroups),
> so they shouldn't expect Gb's in savings.

I'll add those infos into the commit log.

>
> Thanks!
>
> PS I hope to review the rest of the patchset till the end of this week.

Thanks Roman.
