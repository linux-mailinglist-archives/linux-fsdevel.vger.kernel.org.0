Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5782D70FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 08:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393290AbgLKHet (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 02:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbgLKHe0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 02:34:26 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A62C0613CF;
        Thu, 10 Dec 2020 23:33:46 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id 2so7886228ilg.9;
        Thu, 10 Dec 2020 23:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v5HpxdPWwk62UINvDZk+rcjGzodsUyDT59+6kcdYqLY=;
        b=UuSx1zwxSFyQ3GOKZPndz1Tc7V8nFIvuFUBR8XbCXonEXa/XEZK873OgDWO1WKAxQk
         xcg3++SlORlx+0DWHNTCHFq7Zuo11PQaeHDOZTYDn22vZ19NluY2W2a2Fbc5MU99I/pJ
         nM4pak6ZupQAvqGpu9xvLkaJqRUeKvpnOG6r6JS3lhf26yhelnGnVSmwUOjZ/pT3mZb3
         pMypx52dKsij5h0z0Dc+dVnx67o8UjCJgjNnnMfS5xy5CeK+9oeThog2DL0PUNXAjOzf
         6VsG2mXexTC0hH+p9cdUbtr0/oGltOyvtPfvG1kTEpXIOG8SFRiO6oMCvDGWMw5eDLtq
         d9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v5HpxdPWwk62UINvDZk+rcjGzodsUyDT59+6kcdYqLY=;
        b=tILw+FABgeNyXQ/CHRBaXd4TBM+yEoi0Hyz3hRU1IDmkK4YJzDoK+gPcgqUI6DyO2I
         UONREtOeqwftSzP8t8+j+yB0GQ4etr34gBBeQ7+wZAOzYEjHUvN7iJpFKThoVY4wJlsp
         14j/h7avmMcOdoFeMaBYhZIXho+GXAU1s2k9rH5aFRm3PS4Qt11IHFDkUuoaHKKvf/Xc
         Blh7Daek9sDjlxK8eo7qwKTgWpovJxfIminQx2kXKaVnbrku9HcFiAh0g7n2MNppOI/z
         w9nouI0fyGMjFRGwiqNSJKSjqizPcEYaV8n9JYyIUr2tHUkil2hks+1ESAxjy4h4hU/y
         nbFw==
X-Gm-Message-State: AOAM532HFpuRNBH9aV08Xgk8qvhf0QH8vMn1B5T1vThgkF6wo7ZS5DQ2
        gxrv/uUNf3CkXa1ozgHFoEeHsJiS33qnlC0QeL8=
X-Google-Smtp-Source: ABdhPJw7MbJqRtZnDVadtFjF/7vY4pbLtnDux/WDt8xuFRiA2d0CeZYC+4LK6GKUgZn1jy6fENahVXkzfUGmG9BDxx8=
X-Received: by 2002:a92:c112:: with SMTP id p18mr14707710ile.89.1607672025843;
 Thu, 10 Dec 2020 23:33:45 -0800 (PST)
MIME-Version: 1.0
References: <20201211041954.79543-1-songmuchun@bytedance.com> <20201211041954.79543-2-songmuchun@bytedance.com>
In-Reply-To: <20201211041954.79543-2-songmuchun@bytedance.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Fri, 11 Dec 2020 08:33:34 +0100
Message-ID: <CAM9Jb+gc-xqPNP0jsuRV5xczBh31rM=cgL46SxxAYSohe8RvwQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] mm: memcontrol: fix NR_ANON_THPS accounting in
 charge moving
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, adobriyan@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, vdavydov.dev@gmail.com,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>, guro@fb.com,
        Sami Tolvanen <samitolvanen@google.com>, feng.tang@intel.com,
        neilb@suse.de, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        cgroups@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> The unit of NR_ANON_THPS is HPAGE_PMD_NR already. So it should inc/dec
> by one rather than nr_pages.
>
> Fixes: 468c398233da ("mm: memcontrol: switch to native NR_ANON_THPS counter")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/memcontrol.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b80328f52fb4..8818bf64d6fe 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5653,10 +5653,8 @@ static int mem_cgroup_move_account(struct page *page,
>                         __mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
>                         __mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
>                         if (PageTransHuge(page)) {
> -                               __mod_lruvec_state(from_vec, NR_ANON_THPS,
> -                                                  -nr_pages);
> -                               __mod_lruvec_state(to_vec, NR_ANON_THPS,
> -                                                  nr_pages);
> +                               __dec_lruvec_state(from_vec, NR_ANON_THPS);
> +                               __inc_lruvec_state(to_vec, NR_ANON_THPS);
>                         }
>
>                 }

Acked-by: Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
