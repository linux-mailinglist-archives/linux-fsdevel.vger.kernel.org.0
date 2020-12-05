Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0902CFDBE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Dec 2020 19:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgLESnU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Dec 2020 13:43:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:51172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgLEQzu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Dec 2020 11:55:50 -0500
Date:   Sat, 5 Dec 2020 17:33:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607185923;
        bh=Ne5s4xen1CUUAHvQS1v4vcWj2XVNt6JGtidkDM7djHY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=FnUNvAwTW6sVbi2KtbN+cqqgEiKU8P8I+1J8g1MZcUaTv1rjY5qOelo6lwCnkP6y/
         ZHkz434hzxWWgnQlKaDfOHbUBCHk88WZnIR7psaQFpupDgLFi3jTcX1qwhoCDCDWY4
         GokzWHchJC4F2/txE+WjQ/8mphYvjDyjzB7Hu6DQ=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     rafael@kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
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
Subject: Re: [External] Re: [PATCH 5/9] mm: memcontrol: convert NR_FILE_THPS
 account to pages
Message-ID: <X8u2TavrUAnnhq+M@kroah.com>
References: <20201205130224.81607-1-songmuchun@bytedance.com>
 <20201205130224.81607-6-songmuchun@bytedance.com>
 <X8uU6ODzteuBY9pf@kroah.com>
 <CAMZfGtWjumNV4hu-Qv8Z+WoS-EmyhvQd1qsaoS1quvQCyczT=g@mail.gmail.com>
 <X8uoITGcfvZ/EA74@kroah.com>
 <CAMZfGtWmoPjuxfwYFUACRBCBgk3q77Sfv0kE2ysoX-9LJ8s2Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtWmoPjuxfwYFUACRBCBgk3q77Sfv0kE2ysoX-9LJ8s2Zw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 05, 2020 at 11:39:24PM +0800, Muchun Song wrote:
> On Sat, Dec 5, 2020 at 11:32 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Dec 05, 2020 at 11:29:26PM +0800, Muchun Song wrote:
> > > On Sat, Dec 5, 2020 at 10:09 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Sat, Dec 05, 2020 at 09:02:20PM +0800, Muchun Song wrote:
> > > > > Converrt NR_FILE_THPS account to pages.
> > > > >
> > > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > > ---
> > > > >  drivers/base/node.c | 3 +--
> > > > >  fs/proc/meminfo.c   | 2 +-
> > > > >  mm/filemap.c        | 2 +-
> > > > >  mm/huge_memory.c    | 3 ++-
> > > > >  mm/khugepaged.c     | 2 +-
> > > > >  mm/memcontrol.c     | 5 ++---
> > > > >  6 files changed, 8 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > > > > index 05c369e93e16..f6a9521bbcf8 100644
> > > > > --- a/drivers/base/node.c
> > > > > +++ b/drivers/base/node.c
> > > > > @@ -466,8 +466,7 @@ static ssize_t node_read_meminfo(struct device *dev,
> > > > >                                   HPAGE_PMD_NR),
> > > > >                            nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
> > > > >                                   HPAGE_PMD_NR),
> > > > > -                          nid, K(node_page_state(pgdat, NR_FILE_THPS) *
> > > > > -                                 HPAGE_PMD_NR),
> > > > > +                          nid, K(node_page_state(pgdat, NR_FILE_THPS)),
> > > >
> > > > Again, is this changing a user-visable value?
> > > >
> > >
> > > Of course not.
> > >
> > > In the previous, the NR_FILE_THPS account is like below:
> > >
> > >     __mod_lruvec_page_state(page, NR_FILE_THPS, 1);
> > >
> > > With this patch, it is:
> > >
> > >     __mod_lruvec_page_state(page, NR_FILE_THPS, HPAGE_PMD_NR);
> > >
> > > So the result is not changed from the view of user space.
> >
> > So you "broke" it on the previous patch and "fixed" it on this one?  Why
> > not just do it all in one patch?
> 
> Sorry for the confusion. I mean that the "previous" is without all of this patch
> series. So this series is aimed to convert the unit of all different THP vmstat
> counters from HPAGE_PMD_NR to pages. Thanks.

I'm sorry, I still do not understand.  It looks to me that you are
changing the number printed to userspace here.  Where is the
corrisponding change that changed the units for this function?  Is it in
this patch?  If so, sorry, I did not see that at all...

thanks,

greg k-h
