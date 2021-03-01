Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC24328D9C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 20:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240542AbhCATOR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 14:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240911AbhCATKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 14:10:54 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3A6C06178C
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Mar 2021 11:09:58 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id l132so16499328qke.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Mar 2021 11:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i+xARtY+5W8Bn1AE04i/Ad5rFPbMh8nDWeTLAZo2lK0=;
        b=Dmi55bD0YEnhSqHee72cnYtTysJPc/UwD5dR9ydldk6GNoQl1/DniyGpHgFg80docR
         e1KdvcdDDqDdYhzqdjbwQC3WwGcI+gVUYGwEy/2ZHD9FDnWf38mhuSNKbYuja0dkYMwc
         Dt1ZWtdL/AKMrYyS1KxGZHqiczC3VM3kJ6R+dzCrcHrTE05NQ5F/8yLtHGymvg1aq6BM
         EXf4Kdm1R/J3x2USifUap32jpSxasFV9xs+YN9M/8OjxeDZd0alUdKogErFvkkhpAax4
         4O0hiOHJwEitkpq+e0RPMg7fyDENlKa7NIV1yli4o3coe+gnJvv16u0eFWOoTS7x0HeU
         rH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i+xARtY+5W8Bn1AE04i/Ad5rFPbMh8nDWeTLAZo2lK0=;
        b=t3ObxxAQQLjmFFJ078PrNSkXgB6RSY0nOm5LqRdp145z3GTj5B3LN3Fe88IEOd9FoC
         tTcwVcgTUniueA3PtFFaM77xT/wtujZA5toewY9USgNxhptB3XqSw8U3YNbKyW37tOXI
         1QrQyN1hsZKGYXuzd1rffy8cycmsoXYTNE/G0bDoW94ZpSMUUWu2NLJbohO85hqWl0x5
         +JWVoFjtzbr4QrqmcA92YI9sZpvQOWf+SpEgr92XR7ZjqxA+2IL4tIG4gd64wfWwQWTn
         WFqA40HKb6Se+h3Ly9SZFd354yC8lGIqOrgENmXJZaO5uoP8Ma/uzQGQb3XBSYnOUBGr
         e/yw==
X-Gm-Message-State: AOAM531ojPsMh6JGf+kTCz7xQdBJRDfY1IZ5rA2AtA4Y4uwXwEspdDsg
        zSu6WrN+cdHW3uYRfxLgu4oDlQ==
X-Google-Smtp-Source: ABdhPJzw9sBKATTH9+l4/FyjFyJ4xvsDXuoyNe+xu6pg1Fsl6HJWxo2SNSKnwbilZI0nWJ3JIsIPhA==
X-Received: by 2002:a37:4a49:: with SMTP id x70mr15969541qka.118.1614625797396;
        Mon, 01 Mar 2021 11:09:57 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:c0b0])
        by smtp.gmail.com with ESMTPSA id 18sm3329057qkr.90.2021.03.01.11.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 11:09:56 -0800 (PST)
Date:   Mon, 1 Mar 2021 14:09:55 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, bristot@redhat.com,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        alexander.h.duyck@linux.intel.com,
        Chris Down <chris@chrisdown.name>,
        Wei Yang <richard.weiyang@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Oskolkov <posk@google.com>, Jann Horn <jannh@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, daniel.vetter@ffwll.ch,
        Waiman Long <longman@redhat.com>,
        Michel Lespinasse <walken@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, krisman@collabora.com,
        esyr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        duanxiongchun@bytedance.com
Subject: Re: [PATCH 2/5] mm: memcontrol: make page_memcg{_rcu} only
 applicable for non-kmem page
Message-ID: <YD08A+fEp/4pw10I@cmpxchg.org>
References: <20210301062227.59292-1-songmuchun@bytedance.com>
 <20210301062227.59292-3-songmuchun@bytedance.com>
 <CALvZod7sysj0+wrzLTXnwn7s_Gf-V2eFPJ6cLcoRmR0LdAFk0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7sysj0+wrzLTXnwn7s_Gf-V2eFPJ6cLcoRmR0LdAFk0Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Muchun, can you please reduce the CC list to mm/memcg folks only for
the next submission? I think probably 80% of the current recipients
don't care ;-)

On Mon, Mar 01, 2021 at 10:11:45AM -0800, Shakeel Butt wrote:
> On Sun, Feb 28, 2021 at 10:25 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > We want to reuse the obj_cgroup APIs to reparent the kmem pages when
> > the memcg offlined. If we do this, we should store an object cgroup
> > pointer to page->memcg_data for the kmem pages.
> >
> > Finally, page->memcg_data can have 3 different meanings.
> >
> >   1) For the slab pages, page->memcg_data points to an object cgroups
> >      vector.
> >
> >   2) For the kmem pages (exclude the slab pages), page->memcg_data
> >      points to an object cgroup.
> >
> >   3) For the user pages (e.g. the LRU pages), page->memcg_data points
> >      to a memory cgroup.
> >
> > Currently we always get the memcg associated with a page via page_memcg
> > or page_memcg_rcu. page_memcg_check is special, it has to be used in
> > cases when it's not known if a page has an associated memory cgroup
> > pointer or an object cgroups vector. Because the page->memcg_data of
> > the kmem page is not pointing to a memory cgroup in the later patch,
> > the page_memcg and page_memcg_rcu cannot be applicable for the kmem
> > pages. In this patch, we introduce page_memcg_kmem to get the memcg
> > associated with the kmem pages. And make page_memcg and page_memcg_rcu
> > no longer apply to the kmem pages.
> >
> > In the end, there are 4 helpers to get the memcg associated with a
> > page. The usage is as follows.
> >
> >   1) Get the memory cgroup associated with a non-kmem page (e.g. the LRU
> >      pages).
> >
> >      - page_memcg()
> >      - page_memcg_rcu()
> 
> Can you rename these to page_memcg_lru[_rcu] to make them explicitly
> for LRU pages?

The next patch removes page_memcg_kmem() again to replace it with
page_objcg(). That should (luckily) remove the need for this
distinction and keep page_memcg() simple and obvious.

It would be better to not introduce page_memcg_kmem() in the first
place in this patch, IMO.
