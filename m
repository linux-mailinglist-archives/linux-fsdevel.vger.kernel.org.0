Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C072532A508
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 16:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442267AbhCBLqe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574789AbhCBDuj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 22:50:39 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FDBC06178C
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Mar 2021 19:49:58 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id o188so6293975pfg.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Mar 2021 19:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zR9rZ5Vo7n4Jx4LSiCHtKNBAWL0tmz/mJnFtTbDqbIU=;
        b=v9fAqyuNhDoUw3dtU1vnpYtIU5IhN9QKuc3uYH/Oncb9JTBA0DAi9YtlWkm2stJ90r
         +PRYhf+SGzC8j9uqnJHPm3vCzMPuzAlnRV+vZMvYST7E5TMq44Rfk3kwAWcFcB46Sq41
         vFesKUHLPs83TWyyQCS5dXK5ciQhNVQKs4VGeOCSJchW2M9Dd07uGTBp4LJtvxYatGgm
         sha9dr2oAKShevSBQhU6iX58QJjZVzwmCF0nNJCAcZeNG/9JX/jUobwm9Bc9XIzTh7wD
         oMMjslfibt+eQ+1H+3/V5FkViK5z1Qxnvh3OuG/KKQ6i1oEnosdWfybQ1+34pqH7hfV2
         +ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zR9rZ5Vo7n4Jx4LSiCHtKNBAWL0tmz/mJnFtTbDqbIU=;
        b=hUwlh21S5xE6sh2E9yjSnu0e2jmfpYEuR+7ZkJ0FgV4a3XIqsbawOPqN1iDVDXr9sz
         CfPRkk+0xR6Zsre/hCjtbX1cujnhA097e1v/QjRvHvHhTMwak4yaB9lKDtbLvwdUnedw
         BIk3Cckb8cpIBqblglk+E7d9YCmxTfDZSezXoCEKx5y//4/YxaN13hfk6Dl9gAo0EkfP
         KkNlSIDX2kxTTv2UTONny4rPIxFX8d9CcgnvhosmF1RKghRL+47runfQwoZMHDk2Me8W
         I/pabcsmv9AVV6EbNsWQ+mPLlMuWJ/c5IE5z2M7GMd3x4SFVfPXfvHYyY3HRPwHYIk1J
         xbdA==
X-Gm-Message-State: AOAM531K9kKj8tPKFId4rub0oCWvAsOVe2RA6blxjTWaVSAyRdXWtLYZ
        dIkoEUGVUf7KSRQXBI1edrBtSbOB3KnxHmWAVShaDQ==
X-Google-Smtp-Source: ABdhPJwJdS00GRwevcvlOVHxIsflvCdg261M0N1nQh/iDPP8PMYFMy/+PL0boqZQvRsNKQzFMclQJCc/iXcXQrgJaAk=
X-Received: by 2002:a65:6645:: with SMTP id z5mr16134496pgv.273.1614656997583;
 Mon, 01 Mar 2021 19:49:57 -0800 (PST)
MIME-Version: 1.0
References: <20210301062227.59292-1-songmuchun@bytedance.com>
 <20210301062227.59292-3-songmuchun@bytedance.com> <CALvZod7sysj0+wrzLTXnwn7s_Gf-V2eFPJ6cLcoRmR0LdAFk0Q@mail.gmail.com>
 <YD08A+fEp/4pw10I@cmpxchg.org>
In-Reply-To: <YD08A+fEp/4pw10I@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 2 Mar 2021 11:49:21 +0800
Message-ID: <CAMZfGtWJRS=Cjx5HKt02-pzw7UOn-qhwR21fmDS6fcpntprbCQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 2/5] mm: memcontrol: make page_memcg{_rcu}
 only applicable for non-kmem page
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>, kpsingh@kernel.org,
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
        Chris Down <chris@chrisdown.name>,
        Wei Yang <richard.weiyang@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Oskolkov <posk@google.com>, Jann Horn <jannh@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
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
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 2, 2021 at 3:09 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Muchun, can you please reduce the CC list to mm/memcg folks only for
> the next submission? I think probably 80% of the current recipients
> don't care ;-)

At first, I just used scripts/get_maintainer.pl to get the
CC list. I will reduce the CC list in the next version.
Thanks.

>
> On Mon, Mar 01, 2021 at 10:11:45AM -0800, Shakeel Butt wrote:
> > On Sun, Feb 28, 2021 at 10:25 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > We want to reuse the obj_cgroup APIs to reparent the kmem pages when
> > > the memcg offlined. If we do this, we should store an object cgroup
> > > pointer to page->memcg_data for the kmem pages.
> > >
> > > Finally, page->memcg_data can have 3 different meanings.
> > >
> > >   1) For the slab pages, page->memcg_data points to an object cgroups
> > >      vector.
> > >
> > >   2) For the kmem pages (exclude the slab pages), page->memcg_data
> > >      points to an object cgroup.
> > >
> > >   3) For the user pages (e.g. the LRU pages), page->memcg_data points
> > >      to a memory cgroup.
> > >
> > > Currently we always get the memcg associated with a page via page_memcg
> > > or page_memcg_rcu. page_memcg_check is special, it has to be used in
> > > cases when it's not known if a page has an associated memory cgroup
> > > pointer or an object cgroups vector. Because the page->memcg_data of
> > > the kmem page is not pointing to a memory cgroup in the later patch,
> > > the page_memcg and page_memcg_rcu cannot be applicable for the kmem
> > > pages. In this patch, we introduce page_memcg_kmem to get the memcg
> > > associated with the kmem pages. And make page_memcg and page_memcg_rcu
> > > no longer apply to the kmem pages.
> > >
> > > In the end, there are 4 helpers to get the memcg associated with a
> > > page. The usage is as follows.
> > >
> > >   1) Get the memory cgroup associated with a non-kmem page (e.g. the LRU
> > >      pages).
> > >
> > >      - page_memcg()
> > >      - page_memcg_rcu()
> >
> > Can you rename these to page_memcg_lru[_rcu] to make them explicitly
> > for LRU pages?
>
> The next patch removes page_memcg_kmem() again to replace it with
> page_objcg(). That should (luckily) remove the need for this
> distinction and keep page_memcg() simple and obvious.
>
> It would be better to not introduce page_memcg_kmem() in the first
> place in this patch, IMO.

OK. I will follow your suggestion. Thanks.
