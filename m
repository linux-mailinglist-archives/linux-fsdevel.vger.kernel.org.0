Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF1D33083A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 07:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbhCHGkk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 01:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhCHGkZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 01:40:25 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51966C06174A
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 Mar 2021 22:40:24 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id t9so14634708ljt.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Mar 2021 22:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hAOQAdW2gJleMVEvY9uVkWH8JBAiFCjWdKg9XMUoT3c=;
        b=LwefvH06zFhM9HjOdO0twZV744eF72MK8lLPc7E2DGRrfwVsJRVG2ebpuHJqNHtc6a
         pbROrFakeP4zE4UEoaxv0lNoMR+gVqBhsKqxCVPrRwIltPi0TZxBpgHCvXZA8ZT5pLc6
         J8QlQ7H1W+upe7SpGJkCRyhwLS0feyNuuhTzaZ+fepKO2BdKWLJPioJk06lCJkKoSinh
         iEFypeVFO4BE4mMwQ0OdQdsASlMcxXUsCfw0hKmJO6tng189ROuV0RNZEBta6MB9UUAb
         J9V391tCLQeKe6GT58MOC6EoQ1lKaPS7U5mcuWAmfxKKtvj6VvSeHLsmmuLW0iu0G+gE
         SyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAOQAdW2gJleMVEvY9uVkWH8JBAiFCjWdKg9XMUoT3c=;
        b=je/5kHNgl/Bx4zFGvYWCqhgLsfRJzk1no9IXAz1nyStTKAXv5P2poAwozmks+nTAlC
         YTJTuSWQweLkn7OjutdTkJcpT39MeXa4NGhdxnFRZHrRhyEPsH+nH6DfTQLdF2O8WYW5
         2tLNlIY3IYBSMAx6siBv13VS3bQc29kCPyVkG8shxfpmW5bXbmL69eOes/v+J+8uKmHk
         rt1eVX96E7NrtDbi2zbgL6V8qdUZclxH48G/ZMqi+2vC8R7XzlnmIMbpv+EgRqF4n/PG
         pW0cWiWJGzjpR2foU4Y97631Yjb0M+z3vOvtia4nGMIJOJ09XigU0lwqtAtsizuEHE10
         M5CQ==
X-Gm-Message-State: AOAM533kwS6ltrclP1cRKS6jBAL7Brl5WEL3UoTc/zupYuad2C9LHYly
        T6Pt6AqcjQy6JAe+DvoCFpRJlPYl8LyK9pUMlG3TXA==
X-Google-Smtp-Source: ABdhPJx2MwNnM9KxheS2vwBmxXnWYjXdOmwiKsgw5szW6RqYJwuEICOKBs2B6gY68hWVvo3tWilSSwMB9dCsoZOnxGY=
X-Received: by 2002:a2e:8084:: with SMTP id i4mr9630706ljg.122.1615185622519;
 Sun, 07 Mar 2021 22:40:22 -0800 (PST)
MIME-Version: 1.0
References: <20210217001322.2226796-1-shy828301@gmail.com> <20210217001322.2226796-4-shy828301@gmail.com>
In-Reply-To: <20210217001322.2226796-4-shy828301@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 7 Mar 2021 22:40:08 -0800
Message-ID: <CALvZod7Z6A=qFHOy2BODiTcK-fz=Yid5-LhbzofQBa8aemt1Lw@mail.gmail.com>
Subject: Re: [v8 PATCH 03/13] mm: vmscan: use shrinker_rwsem to protect
 shrinker_maps allocation
To:     Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 4:13 PM Yang Shi <shy828301@gmail.com> wrote:
>
> Since memcg_shrinker_map_size just can be changed under holding shrinker_rwsem
> exclusively, the read side can be protected by holding read lock, so it sounds
> superfluous to have a dedicated mutex.
>
> Kirill Tkhai suggested use write lock since:
>
>   * We want the assignment to shrinker_maps is visible for shrink_slab_memcg().
>   * The rcu_dereference_protected() dereferrencing in shrink_slab_memcg(), but
>     in case of we use READ lock in alloc_shrinker_maps(), the dereferrencing
>     is not actually protected.
>   * READ lock makes alloc_shrinker_info() racy against memory allocation fail.
>     alloc_shrinker_info()->free_shrinker_info() may free memory right after
>     shrink_slab_memcg() dereferenced it. You may say
>     shrink_slab_memcg()->mem_cgroup_online() protects us from it? Yes, sure,
>     but this is not the thing we want to remember in the future, since this
>     spreads modularity.
>
> And a test with heavy paging workload didn't show write lock makes things worse.
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
