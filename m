Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEFE2D144D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 16:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgLGPDm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 10:03:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:55558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbgLGPDm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:03:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607353375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W9xHKa0FHxvAY5lMXiXo+4bSevtfetGYjc7M1Qiyftw=;
        b=FnFflSv8rzalFIyNLjcUy7ngp2i44jvG1FEWcNn7jC3d+hDQcfKh0lVVHNeI/o/sZimsvr
        eQVcvH5Q2lMWef8fp3aSgRVYGaswMY1kVzgXWO9EkGp22XgMfXXXNYFu5+yGa0hrv2PcsY
        CmZGpPtTTlzg4iTd4Ch1sfoHjrMfHck=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8F742ACBD;
        Mon,  7 Dec 2020 15:02:55 +0000 (UTC)
Date:   Mon, 7 Dec 2020 16:02:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
        Roman Gushchin <guro@fb.com>, Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com,
        Suren Baghdasaryan <surenb@google.com>, avagin@openvz.org,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [External] Re: [RESEND PATCH v2 00/12] Convert all vmstat
 counters to pages or bytes
Message-ID: <20201207150254.GL25569@dhcp22.suse.cz>
References: <20201206101451.14706-1-songmuchun@bytedance.com>
 <20201207130018.GJ25569@dhcp22.suse.cz>
 <CAMZfGtWSEKWqR4f+23xt+jVF-NLSTVQ0L0V3xfZsQzV7aeebhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtWSEKWqR4f+23xt+jVF-NLSTVQ0L0V3xfZsQzV7aeebhw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 07-12-20 22:52:30, Muchun Song wrote:
> On Mon, Dec 7, 2020 at 9:00 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Sun 06-12-20 18:14:39, Muchun Song wrote:
> > > Hi,
> > >
> > > This patch series is aimed to convert all THP vmstat counters to pages
> > > and some KiB vmstat counters to bytes.
> > >
> > > The unit of some vmstat counters are pages, some are bytes, some are
> > > HPAGE_PMD_NR, and some are KiB. When we want to expose these vmstat
> > > counters to the userspace, we have to know the unit of the vmstat counters
> > > is which one. It makes the code complex. Because there are too many choices,
> > > the probability of making a mistake will be greater.
> > >
> > > For example, the below is some bug fix:
> > >   - 7de2e9f195b9 ("mm: memcontrol: correct the NR_ANON_THPS counter of hierarchical memcg")
> > >   - not committed(it is the first commit in this series) ("mm: memcontrol: fix NR_ANON_THPS account")
> > >
> > > This patch series can make the code simple (161 insertions(+), 187 deletions(-)).
> > > And make the unit of the vmstat counters are either pages or bytes. Fewer choices
> > > means lower probability of making mistakes :).
> > >
> > > This was inspired by Johannes and Roman. Thanks to them.
> >
> > It would be really great if you could summarize the current and after
> > the patch state so that exceptions are clear and easier to review. The
> 
> Agree. Will do in the next version. Thanks.
> 
> 
> > existing situation is rather convoluted but we have at least units part
> > of the name so it is not too hard to notice that. Reducing exeptions
> > sounds nice but I am not really sure it is such an improvement it is
> > worth a lot of code churn. Especially when it comes to KB vs B. Counting
> 
> There are two vmstat counters (NR_KERNEL_STACK_KB and
> NR_KERNEL_SCS_KB) whose units are KB. If we do this, all
> vmstat counter units are either pages or bytes in the end. When
> we expose those counters to userspace, it can be easy. You can
> reference to:
> 
>     [RESEND PATCH v2 11/12] mm: memcontrol: make the slab calculation consistent
> 
> From this point of view, I think that it is worth doing this. Right?

Well, unless I am missing something, we have two counters in bytes, two
in kB, both clearly distinguishable by the B/KB suffix. Changing KB to B
will certainly reduce the different classes of units, no question about
that, but I am not really sure this is worth all the code churn. Maybe
others will think otherwise.

As I've said the THP accounting change makes more sense to me because it
allows future changes which are already undergoing so there is more
merit in those.
-- 
Michal Hocko
SUSE Labs
