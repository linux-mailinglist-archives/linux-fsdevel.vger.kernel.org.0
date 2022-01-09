Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9594887A9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jan 2022 05:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiAIEue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jan 2022 23:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiAIEue (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jan 2022 23:50:34 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85A1C061401
        for <linux-fsdevel@vger.kernel.org>; Sat,  8 Jan 2022 20:50:33 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id g81so1793748ybg.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Jan 2022 20:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sTZpxUej1WV035yAJtohiVvLExaKbKUenCSLiOyFQAA=;
        b=aqRON71E4TpjVhVCmbsvwLBooQ5QVh+ZtuwD7CWK2QhGySXMwcaxQ/m/0djGwFwgov
         A2tlufrTFIFL4g1bi+jMWgGDRzuMcsLH9iXozDUjBqa+wBI2xhlJXR7xoBV8oBkfdmgm
         TVPPwrdvVCgcHHlQCrWf+RpmZnlPhZX23GLnAzxpubduArd/PB4qaNnO9w2ymktAMbru
         BJjTOL7M8a2OKMOhsC+Xxp8TVVIYLIEAnhesXP9IPrPwu9nDM8v5KIk93F9vJ4WnUD3r
         5kkDrCy1CrG9lBPP+qg0nUyOVRhTkRzfHFH75IF12oERYbixYM8C1KGKqRuq2EFn2smm
         DVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sTZpxUej1WV035yAJtohiVvLExaKbKUenCSLiOyFQAA=;
        b=vcvOQP/iY/Pltkk8XlQoWp+9YZ/mXVguUT29Z8p7gqyv7OXeJbmNK2HNA2EZqTRfJs
         rGbob2Mv0yZoazyI45yl644sk1KtNiL7oMPYVk00W3vNGc8d4KuiX/+E/t8HeiagRrJI
         c0SZ7RPsvIYASGX4gSyqomjje/uFY1Sk3j/s/lb3wYASP4etv0Ea5zdYxz8Jdj2IfuXE
         qQO2hZIdEdPoM/BPDb0kkcv4BqcE4Q/L3ClZcXVPBZOsPJfqgIAMv78k0mg8q2+t8LFv
         mtyNTlZZ9G48cefahgldOtNhP9DJTFxB9kCG0U0LThtoB786e+go7SSF6oTPiCk0LDSm
         zxfA==
X-Gm-Message-State: AOAM530TL8betM99eK7J4JDU6yD8pE/9ci+Nb+UliNYLvoLnhw/8830L
        KBF3j2M1ISqtWgtflxoej8KbMCL+K3iq139rQwDo7w==
X-Google-Smtp-Source: ABdhPJyI2p9fJXUmNrwKfQpdp0yuDuQ3zFxLKcu1BudZqfd3OH5/4mKyOocVNopKghFkw/D4n0prPwhmuzIwcp7yHAE=
X-Received: by 2002:a25:b97:: with SMTP id 145mr80561142ybl.132.1641703832755;
 Sat, 08 Jan 2022 20:50:32 -0800 (PST)
MIME-Version: 1.0
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-2-songmuchun@bytedance.com> <YdeDym9IUghnagrK@carbon.dhcp.thefacebook.com>
In-Reply-To: <YdeDym9IUghnagrK@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sun, 9 Jan 2022 12:49:56 +0800
Message-ID: <CAMZfGtV2G=R9nTuSYGAeqv+RkJsCVVACc3h47OeWA7n3mWbqsA@mail.gmail.com>
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

On Fri, Jan 7, 2022 at 8:05 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Mon, Dec 20, 2021 at 04:56:34PM +0800, Muchun Song wrote:
> > The list_lru uses an array (list_lru_memcg->lru) to store pointers
> > which point to the list_lru_one. And the array is per memcg per node.
> > Therefore, the size of the arrays will be 10K * number_of_node * 8 (
> > a pointer size on 64 bits system) when we run 10k containers in the
> > system. The memory consumption of the arrays becomes significant. The
> > more numa node, the more memory it consumes.
> >
> > I have done a simple test, which creates 10K memcg and mount point
> > each in a two-node system. The memory consumption of the list_lru
> > will be 24464MB. After converting the array from per memcg per node
> > to per memcg, the memory consumption is going to be 21957MB. It is
> > reduces by 2.5GB. In our AMD servers with 8 numa nodes in those
> > sysuem, the memory consumption could be more significant. The savings
> > come from the list_lru_one heads, that it also simplifies the
> > alloc/dealloc path.
> >
> > The new scheme looks like the following.
> >
> >   +----------+   mlrus   +----------------+   mlru   +----------------------+
> >   | list_lru +---------->| list_lru_memcg +--------->|  list_lru_per_memcg  |
> >   +----------+           +----------------+          +----------------------+
> >                                                      |  list_lru_per_memcg  |
> >                                                      +----------------------+
> >                                                      |          ...         |
> >                           +--------------+   node    +----------------------+
> >                           | list_lru_one |<----------+  list_lru_per_memcg  |
> >                           +--------------+           +----------------------+
> >                           | list_lru_one |
> >                           +--------------+
> >                           |      ...     |
> >                           +--------------+
> >                           | list_lru_one |
> >                           +--------------+
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> As much as I like the code changes (there is indeed a significant simplification!),
> I don't like the commit message and title, because I wasn't able to understand
> what the patch is doing and some parts look simply questionable. Overall it
> sounds like you reduce the number of list_lru_one structures, which is not true.
>
> How about something like this?
>
> --
> mm: list_lru: transpose the array of per-node per-memcg lru lists
>
> The current scheme of maintaining per-node per-memcg lru lists looks like:
>   struct list_lru {
>     struct list_lru_node *node;           (for each node)
>       struct list_lru_memcg *memcg_lrus;
>         struct list_lru_one *lru[];       (for each memcg)
>   }
>
> By effectively transposing the two-dimension array of list_lru_one's structures
> (per-node per-memcg => per-memcg per-node) it's possible to save some memory
> and simplify alloc/dealloc paths. The new scheme looks like:
>   struct list_lru {
>     struct list_lru_memcg *mlrus;
>       struct list_lru_per_memcg *mlru[];  (for each memcg)
>         struct list_lru_one node[0];      (for each node)
>   }
>
> Memory savings are coming from having fewer list_lru_memcg structures, which
> contain an extra struct rcu_head to handle the destruction process.

My bad English. Actually, the saving is coming from not only 'struct rcu_head'
but also some pointer arrays used to store the pointer to 'struct list_lru_one'.
The array is per node and its size is 8 (a pointer) * num_memcgs. So the total
size of the arrays is  8 * num_nodes * memcg_nr_cache_ids. After this patch,
the size becomes 8 * memcg_nr_cache_ids. So the saving is

   8 * (num_nodes - 1) * memcg_nr_cache_ids.

> --
>
> But what worries me is that memory savings numbers you posted don't do up.
> In theory we can save
> 16 (size of struct rcu_head) * 10000 (number of cgroups) * 2 (number of numa nodes) = 320k
> per slab cache. Did you have a ton of mount points? Otherwise I don't understand
> where these 2.5Gb are coming from.

memcg_nr_cache_ids is 12286 when creating 10k memcgs. So the saving
of arrays of one list_lru is 8 * 1 (number of numa nodes - 1) * 12286 = 96k.
There will be 2 * 10k list_lru when mounting 10k points. So the total
saving is 96k * 2 * 10k = 1920 M.

Thanks Roman.
