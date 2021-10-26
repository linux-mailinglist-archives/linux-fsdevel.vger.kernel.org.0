Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A127543ACFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 09:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbhJZHRt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 03:17:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44062 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhJZHRr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 03:17:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 98263218E1;
        Tue, 26 Oct 2021 07:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635232523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/xlS5pWGfijDqH/0h95+7pir2Zol9NoZmsyYQ20M0i8=;
        b=hXcUGn2iG2kIKRbZ829U+xpUOhMCeB411AxbZ/7+oxyPM6TMDH8ozqO7EOE4NeTUJ74RXq
        vb46J+hjJZr7GmUsqoCGPxehY+kS2uljpOBCVmtE6tLDQ4qFJ2KQTW0iZPzAltmpP3zuKR
        XUvVZhcUSugBiKeMOMLDoWhaM8sGqrc=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 64969A3B81;
        Tue, 26 Oct 2021 07:15:23 +0000 (UTC)
Date:   Tue, 26 Oct 2021 09:15:21 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     NeilBrown <neilb@suse.de>
Cc:     linux-mm@kvack.org, Dave Chinner <david@fromorbit.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 4/4] mm: allow !GFP_KERNEL allocations for kvmalloc
Message-ID: <YXerCVllHB9g+JnI@dhcp22.suse.cz>
References: <20211025150223.13621-1-mhocko@kernel.org>
 <20211025150223.13621-5-mhocko@kernel.org>
 <163520487423.16092.18303917539436351482@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163520487423.16092.18303917539436351482@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 26-10-21 10:34:34, Neil Brown wrote:
> On Tue, 26 Oct 2021, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > A support for GFP_NO{FS,IO} and __GFP_NOFAIL has been implemented
> > by previous patches so we can allow the support for kvmalloc. This
> > will allow some external users to simplify or completely remove
> > their helpers.
> > 
> > GFP_NOWAIT semantic hasn't been supported so far but it hasn't been
> > explicitly documented so let's add a note about that.
> > 
> > ceph_kvmalloc is the first helper to be dropped and changed to
> > kvmalloc.
> > 
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  include/linux/ceph/libceph.h |  1 -
> >  mm/util.c                    | 15 ++++-----------
> >  net/ceph/buffer.c            |  4 ++--
> >  net/ceph/ceph_common.c       | 27 ---------------------------
> >  net/ceph/crypto.c            |  2 +-
> >  net/ceph/messenger.c         |  2 +-
> >  net/ceph/messenger_v2.c      |  2 +-
> >  net/ceph/osdmap.c            | 12 ++++++------
> >  8 files changed, 15 insertions(+), 50 deletions(-)
> > 
> > diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> > index 409d8c29bc4f..309acbcb5a8a 100644
> > --- a/include/linux/ceph/libceph.h
> > +++ b/include/linux/ceph/libceph.h
> > @@ -295,7 +295,6 @@ extern bool libceph_compatible(void *data);
> >  
> >  extern const char *ceph_msg_type_name(int type);
> >  extern int ceph_check_fsid(struct ceph_client *client, struct ceph_fsid *fsid);
> > -extern void *ceph_kvmalloc(size_t size, gfp_t flags);
> >  
> >  struct fs_parameter;
> >  struct fc_log;
> > diff --git a/mm/util.c b/mm/util.c
> > index bacabe446906..fdec6b4b1267 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -549,13 +549,10 @@ EXPORT_SYMBOL(vm_mmap);
> >   * Uses kmalloc to get the memory but if the allocation fails then falls back
> >   * to the vmalloc allocator. Use kvfree for freeing the memory.
> >   *
> > - * Reclaim modifiers - __GFP_NORETRY and __GFP_NOFAIL are not supported.
> > + * Reclaim modifiers - __GFP_NORETRY and GFP_NOWAIT are not supported.
> 
> GFP_NOWAIT is not a modifier.  It is a base value that can be modified.
> I think you mean that
>     __GFP_NORETRY is not supported and __GFP_DIRECT_RECLAIM is required

I thought naming the higher level gfp mask would be more helpful here.
Most people do not tend to think in terms of __GFP_DIRECT_RECLAIM but
rather GFP_NOWAIT or GFP_ATOMIC.

> But I really cannot see why either of these statements are true.

The reason is same as why vmalloc do not support neither of them.

> Before your patch, __GFP_NORETRY would have forced use of kmalloc, so
> that would mean it isn't really supported.  But that doesn't happen any more.

__GFP_NORETRY is used internaly by kvmalloc but that doesn't mean it is
supported by the caller. In fact __GFP_NORETRY is used to implement a
higher level logic of the prioritization between kmalloc and vmalloc
fallback because some users would rather see vmalloc fallback even for
smaller allocations which do not really fail otherwise (e.g. < order-4).
-- 
Michal Hocko
SUSE Labs
