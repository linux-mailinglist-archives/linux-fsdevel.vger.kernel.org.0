Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DED495975
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 06:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348594AbiAUF2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 00:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348537AbiAUF2p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 00:28:45 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF82C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jan 2022 21:28:45 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id g81so24346102ybg.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jan 2022 21:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oLfplAHSJpoJoro49dxV+IqhVZCDx28Jwklvx67FrF8=;
        b=nYs10YR6ocJHBHrLUw73ps3g3PLSvZRhMinzM7yDV+hDZbTjOND8oCKxMyT7zy/s6G
         tMcswUlEq+K9VtnMpJY8Xe3qmK/c1WZ9QqmGTojYfVkIdyJLSktRljR0K344YxrVYsho
         MGaOplQaamQhQjtxmTuX0r5hMqG+z7HJAKD/xjQcVsT+9Rt98UEiiqDM96vc1p4plXhh
         s+y4/thwlfHz5n1UEfgYRc+Ya43KcxPrf6NoyTTXhWIhs8F1sdwuJWe3djxrPQXheYmt
         hNhNIxcu/lF+d/J/Mw7B90xjkN4AdX9GUzOTS4wopMsCv309Ogv7RLpi322UUxcI4Bhf
         XRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oLfplAHSJpoJoro49dxV+IqhVZCDx28Jwklvx67FrF8=;
        b=UDjVeYodA+B8HHPW5k8M4Z0QyYrumprCSMHEmzw/ZG4zCLXvPwsmW6yEl7K34mkahS
         FwvDOaQMCv6Zbpx/aeUiRTBwI/iyPx+i42g0E/BZVsqCTanVM7G3TFwq0T8xoU3REDyR
         d49MYKfuvhglzhPXSz+bpw93PZgSY8EMkEBLQ23Re+kX5QG9piZU791MOaG1lTzb3b5s
         WXswftLx9DGsOlVR1cZYes7afZsUC3BEY/7VF198mpPprtAgiK1ivKYJyZzOM3azmjc3
         JB5reomM5+vLj+VH4npxS6+RuqYQ1Z+qJQ9cYG3S8j6CLwChJDOQT6vqVGeMYB7AC12s
         DjvQ==
X-Gm-Message-State: AOAM531CRwNJ2g+Usq6NAqYMcyGMUxz4m98qv2QY8oqznDjmqvrvnEux
        I+FvwkiScIF33L7eUQ/9jwLf7vAK13l8vpYnzCizbw==
X-Google-Smtp-Source: ABdhPJw4xKwty2ZweVj6NPuQV3OZbnRuxyMndGlPkKNDC99atTPudj3h6vdLwZZaESLpVyhSeONa9YZMWMdxCxOzFiM=
X-Received: by 2002:a25:6186:: with SMTP id v128mr3977526ybb.485.1642742924405;
 Thu, 20 Jan 2022 21:28:44 -0800 (PST)
MIME-Version: 1.0
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-11-songmuchun@bytedance.com> <20220106110051.GA470@blackbody.suse.cz>
 <CAMZfGtXZA+rLMUw5yLSW=eUncT0BjH++Dpi1EzKwXvV9zwqF1w@mail.gmail.com>
 <20220113133213.GA28468@blackbody.suse.cz> <CAMZfGtWJeov9XD_MEkDJwTK5b73OKPYxJBQi=D5-NSyNSSKLCw@mail.gmail.com>
 <20220119093311.GD15686@blackbody.suse.cz>
In-Reply-To: <20220119093311.GD15686@blackbody.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 21 Jan 2022 13:28:05 +0800
Message-ID: <CAMZfGtV4mxn0pqna0BsNAP4eLA7UD-gOJ2XCPU2O0C7VcUJa0g@mail.gmail.com>
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

On Wed, Jan 19, 2022 at 5:33 PM Michal Koutn=C3=BD <mkoutny@suse.com> wrote=
:
>
> On Tue, Jan 18, 2022 at 08:05:44PM +0800, Muchun Song <songmuchun@bytedan=
ce.com> wrote:
> > I have thought about this. It's a little different to rely on objcg
> > reparenting since the user can get memcg from objcg and
> > then does not realize the memcg has reparented.
>
> When you pointed that out, I'm now also wondering how
> memcg_list_lru_alloc() would be synchronized against
> reparenting/renumbering of kmemcg_ids. What I suspect is that newly
> allocated mlru may be stored into the xarray with a stale kmemcg_id.

The synchronization is based on the lock of list_lru->lock.
memcg_list_lru_free() will help us do housekeeping.

>
> > Maybe holding css_set_lock can do that. I do not think this
> > is a good choice.
>
> I agree, it doesn't sound well.
>
> > Do you have any thoughts about this?
>
> Thoughts / questions of what I don't undestand well:
> - Why do you allocate mlrus for all ancestors in memcg_list_lru_alloc()?

It's because we need to be reparenting.

>   - It'd be sufficient to allocate just for the current memcg.
>   - Possibly allocate ancestors upon reparenting (to simplify the
>     allocation from slab_pre_alloc_hook itself).

I agree it is nice to only allocate for current memcg, but
reparenting cannot handle failure of memory allocation.

>
> - What is the per-kmemcg_id lookup good for?
>   - I observe most calls of list_lru_from_memcg_idx() come from callers
>     that know memcg (or even objcg).
>   - The non-specific use case seems list_lru_walk_node() working with
>     per-node and not per-memcg projection.
>     - Consequently that is only used over all nodes anyway
>       (list_lru_walk().
>   - The idea behind this question is -- attach the list_lrus to
>     obj_cgroup (and decommission the kmemcg_id completely).
>     (Not necessarily part of this series but independent approach.)
>

I have some questions about this thought.
We would attach more than one list_lrus to obj_cgroup,
right? How to arrange those list_lrus, array or linked-list?

Thanks.
