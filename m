Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2C6F5A215
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 19:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfF1RQ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 13:16:27 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46554 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfF1RQ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:16:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id h21so7068575qtn.13;
        Fri, 28 Jun 2019 10:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X/aiZ9J+dd4UJLcrpdr3hoLcNRw4Si2ePjPQfQ4q8YM=;
        b=ahnblyStPij2rtGufd7uEL9kTluJbQDHGS1iKvW73t2ebo3vRNn8FTuQKgazM07J6O
         +wXSCQjEJyVN+Z3gV5TMXtCb4Y0BIUZC4KxjAK9eozvCWn7wRcEL7pPsnDG3O9sFCOtj
         7mtNmpZC6VCXYGNzMz40aPZe0km5xgpLwl3cJ2tu5+2EK3h7m9alVYStSrdTVHqHMtp8
         JjPRmJwPCsm/WT2+xKeeXM+QzweX3GmM5GeVUw98UEEx+NBdcny3Wqp02cGUnsp03S2w
         3znGOn57MuwAlyVtWFo05byzrDA0uYw0CMUTrbFQ7ORqxyJYHci8YsBH/OSm/emVhCjd
         KvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/aiZ9J+dd4UJLcrpdr3hoLcNRw4Si2ePjPQfQ4q8YM=;
        b=A67boiHsH77haAJxP85NCS/+oeF3zPs6EK8GlFkwMxDYtI1xLLaXPaL0HwfcM5c/ec
         mrFIOf0GEiTirdNQTvkykMBoMRIJ77HkcDTaaqO2lmFAOxwi75sTft0lVSgJrE5InXAE
         vXIEIZRqX6CQG1K2guSgeApaCBllgy8hT7yb9krXV1fH8XvluLtTGUizwu/TRi5gwNir
         C7Fk59MIifYf7QUZ4YAIPA8vo5ngaKwqDyt1Re/lkfoIpwn/lMLmDm/3bOeNaAWW4VER
         EsTV3jYhil70N67MXSQvL5xHejhZ1vr5M0Hh5Y5lZiyogdQY5UhoxQvR04WEoAOzz4hX
         O6oA==
X-Gm-Message-State: APjAAAUa6ifSla2KplYVzm3HdNYHBAGaU2RWLK08ttpCXV7tsrj8aTd1
        GsEOOm7bqpNffRj3m6lpQjVxJzE6z1tbuMgaFbg=
X-Google-Smtp-Source: APXvYqzeD7ol/qvSpnvEU83iiMeuVww8kn8c1trrLyIBjpx7kD3KA1jNvtOoaae97XqoObXYba1r6IpVH1Cd2BuViC4=
X-Received: by 2002:aed:36c5:: with SMTP id f63mr9236038qtb.239.1561742186465;
 Fri, 28 Jun 2019 10:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190624174219.25513-1-longman@redhat.com> <20190624174219.25513-3-longman@redhat.com>
 <20190626201900.GC24698@tower.DHCP.thefacebook.com> <063752b2-4f1a-d198-36e7-3e642d4fcf19@redhat.com>
 <20190627212419.GA25233@tower.DHCP.thefacebook.com> <0100016b9eb7685e-0a5ab625-abb4-4e79-ab86-07744b1e4c3a-000000@email.amazonses.com>
In-Reply-To: <0100016b9eb7685e-0a5ab625-abb4-4e79-ab86-07744b1e4c3a-000000@email.amazonses.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 28 Jun 2019 10:16:13 -0700
Message-ID: <CAHbLzkr+EJWgAQ9VhAdeTtMx+11=AX=mVVEvC-0UihROf2J+PA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm, slab: Extend vm/drop_caches to shrink kmem slabs
To:     Christopher Lameter <cl@linux.com>
Cc:     Roman Gushchin <guro@fb.com>, Waiman Long <longman@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 28, 2019 at 8:32 AM Christopher Lameter <cl@linux.com> wrote:
>
> On Thu, 27 Jun 2019, Roman Gushchin wrote:
>
> > so that objects belonging to different memory cgroups can share the same page
> > and kmem_caches.
> >
> > It's a fairly big change though.
>
> Could this be done at another level? Put a cgoup pointer into the
> corresponding structures and then go back to just a single kmen_cache for
> the system as a whole? You can still account them per cgroup and there
> will be no cleanup problem anymore. You could scan through a slab cache
> to remove the objects of a certain cgroup and then the fragmentation
> problem that cgroups create here will be handled by the slab allocators in
> the traditional way. The duplication of the kmem_cache was not designed
> into the allocators but bolted on later.

I'm afraid this may bring in another problem for memcg page reclaim.
When shrinking the slabs, the shrinker may end up scanning a very long
list to find out the slabs for a specific memcg. Particularly for the
count operation, it may have to scan the list from the beginning all
the way down to the end. It may take unbounded time.

When I worked on THP deferred split shrinker problem, I used to do
like this, but it turns out it may take milliseconds to count the
objects on the list, but it may just need reclaim a few of them.

>
