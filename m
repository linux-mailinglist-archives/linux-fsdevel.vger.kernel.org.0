Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8CC492560
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 13:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241274AbiARMH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 07:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiARMH3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 07:07:29 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D575BC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jan 2022 04:07:28 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id o80so3294475yba.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jan 2022 04:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OC5quY8+bzQ7YwLxGQW1P7Vgcog//q1EsjQWuTsPZiA=;
        b=c3af9NXfUtTV/ISsfNREopmBIAf8fT4PPP17qdILfbQoqvb1yfMa+D0XLlYT6JoNjU
         ePaLArNrWW5zLYdpo1aCAVvBM7NZdg3qoad2pIpBpn+dKX2qpHWbIzeTo/ZWGlUzG9m6
         hdWzHLZgMHYc+km3yxBo/4gsymQJh83zgMLiF405qZowaqIxM7BnTJJFnGp2/q35ZIA6
         maVqxHfZSqMXQDeOLAlQCpQMgLny1kM6wpQgjMqc1MgA20REMRU1Kyb60DSCWB1/YGt0
         nmM29RNua0k7xFUkauKHhL0GFjcs9AX976BwT6xrQiJmMLPjBfkMK40ffRMoWetReJqm
         /lFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OC5quY8+bzQ7YwLxGQW1P7Vgcog//q1EsjQWuTsPZiA=;
        b=wkmZfRsCAnTmP6a9e60wtI4ceA1x2I6RyNFsrD/sr8TqD828CJNRwWUk25ytKeRHsq
         RCojCySFHK8uHWX8KTu6MP/f663wwhEjB90EKVpfovjX38E8vNpZdp9SNDPW5SHhP/hf
         KKHhvOArk9RNd7KBM5tDCXe+allSkUe92Ie5FtkCz3oONxed+AlZAbYnpetUssOkXC5b
         GYx7aP1tTumEbJWwqHg0ysMZbvE4uoBcPZA2RLnnkQrqa0oDQ61pgSF8pqqzSmEhb6Dr
         8VXzzwvZzWm8NfUDD5wVYFifeQL33ADX894a8m9XPf7VvpzI3uc0WTAhuyIejJIt3un7
         GovQ==
X-Gm-Message-State: AOAM533ksgjtB/MTiFxbPqwSnXf/tlOZ+ITJ6YZDkZzElL62QblJPkLD
        3+oZ0umKMhPLWoXVIDymxW6uO5j3YTYLwxmGQd20lw==
X-Google-Smtp-Source: ABdhPJxNFvL/SkKU6juzzW+raWlteR7gaAX3pdOhU7lWwwCB3tPpMz6t5NIUds1vo4+A7k0YLFoYLeZ3JS1yM7GxpMg=
X-Received: by 2002:a25:8806:: with SMTP id c6mr31085871ybl.199.1642507648082;
 Tue, 18 Jan 2022 04:07:28 -0800 (PST)
MIME-Version: 1.0
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-11-songmuchun@bytedance.com> <20220106110051.GA470@blackbody.suse.cz>
 <CAMZfGtXZA+rLMUw5yLSW=eUncT0BjH++Dpi1EzKwXvV9zwqF1w@mail.gmail.com> <20220113133213.GA28468@blackbody.suse.cz>
In-Reply-To: <20220113133213.GA28468@blackbody.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 18 Jan 2022 20:05:44 +0800
Message-ID: <CAMZfGtWJeov9XD_MEkDJwTK5b73OKPYxJBQi=D5-NSyNSSKLCw@mail.gmail.com>
Subject: Re: [PATCH v5 10/16] mm: list_lru: allocate list_lru_one only when needed
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        Alex Shi <alexs@kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 13, 2022 at 9:32 PM Michal Koutn=C3=BD <mkoutny@suse.com> wrote=
:
>
> On Wed, Jan 12, 2022 at 09:22:36PM +0800, Muchun Song <songmuchun@bytedan=
ce.com> wrote:
> >   root(-1) -> A(0) -> B(1) -> C(2)
> >
> > CPU0:                                   CPU1:
> > memcg_list_lru_alloc(C)
> >                                         memcg_drain_all_list_lrus(C)
> >                                         memcg_drain_all_list_lrus(B)
> >                                         // Now C and B are offline. The
> >                                         // kmemcg_id becomes the follow=
ing if
> >                                         // we do not the kmemcg_id of i=
ts
> >                                         // descendants in
> >                                         // memcg_drain_all_list_lrus().
> >                                         //
> >                                         // root(-1) -> A(0) -> B(0) -> =
C(1)
> >
> >   for (i =3D 0; memcg; memcg =3D parent_mem_cgroup(memcg), i++) {
> >       // allocate struct list_lru_per_memcg for memcg C
> >       table[i].mlru =3D memcg_init_list_lru_one(gfp);
> >   }
> >
> >   spin_lock_irqsave(&lru->lock, flags);
> >   while (i--) {
> >       // here index =3D 1
> >       int index =3D table[i].memcg->kmemcg_id;
> >
> >       struct list_lru_per_memcg *mlru =3D table[i].mlru;
> >       if (index < 0 || rcu_dereference_protected(mlrus->mlru[index], tr=
ue))
> >           kfree(mlru);
> >       else
> >           // mlrus->mlru[index] will be assigned a new value regardless
> >           // memcg C is already offline.
> >           rcu_assign_pointer(mlrus->mlru[index], mlru);
> >   }
> >   spin_unlock_irqrestore(&lru->lock, flags);
> >
>
> > So changing ->kmemcg_id of all its descendants can prevent
> > memcg_list_lru_alloc() from allocating list lrus for the offlined
> > cgroup after memcg_list_lru_free() calling.
>
> Thanks for the illustrative example. I can see how this can be a problem
> in a general call of memcg_list_lru_alloc(C).
>
> However, the code, as I understand it, resolves the memcg to which lru
> allocation should be associated via get_mem_cgroup_from_objcg() and
> memcg_reparent_list_lrus(C) comes after memcg_reparent_objcgs(C, B),
> i.e. the allocation would target B (or even A if after
> memcg_reparent_objcgs(B, A))?
>
> It seems to me like "wasting" the existing objcg reparenting mechanism.
> Or what do you think could be a problem relying on it?
>

I have thought about this. It's a little different to rely on objcg
reparenting since the user can get memcg from objcg and
then does not realize the memcg has reparented. Although it
can check memcg->objcg to know whether the memcg is
reparented, it should also prevent this memcg from being
reparented throughout memcg_list_lru_alloc(). Maybe
holding css_set_lock can do that. I do not think this
is a good choice. Do you have any thoughts about this?

Thanks.
