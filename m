Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E4E204635
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 02:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732291AbgFWAwX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 20:52:23 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:35737 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731750AbgFWAwX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:52:23 -0400
Received: from dread.disaster.area (pa49-180-124-177.pa.nsw.optusnet.com.au [49.180.124.177])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 45CB65AF5E4;
        Tue, 23 Jun 2020 10:52:18 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jnXAg-0001Y7-9C; Tue, 23 Jun 2020 10:52:18 +1000
Date:   Tue, 23 Jun 2020 10:52:18 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Bypass filesystems for reading cached pages
Message-ID: <20200623005218.GF2040@dread.disaster.area>
References: <20200619155036.GZ8681@bombadil.infradead.org>
 <20200622003215.GC2040@dread.disaster.area>
 <CAHc6FU4b_z+vhjVPmaU46VhqoD+Y7jLN3=BRDZPrS2v=_pVpfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU4b_z+vhjVPmaU46VhqoD+Y7jLN3=BRDZPrS2v=_pVpfw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=kj9zAlcOel0A:10 a=nTHF0DUjJn0A:10 a=7-415B0cAAAA:8
        a=8G3SpTuCT5XHdoEvo0oA:9 a=P48SZZe_48vTZzb1:21 a=B4xsomyZ1zPHdLA9:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 22, 2020 at 04:35:05PM +0200, Andreas Gruenbacher wrote:
> On Mon, Jun 22, 2020 at 2:32 AM Dave Chinner <david@fromorbit.com> wrote:
> > On Fri, Jun 19, 2020 at 08:50:36AM -0700, Matthew Wilcox wrote:
> > >
> > > This patch lifts the IOCB_CACHED idea expressed by Andreas to the VFS.
> > > The advantage of this patch is that we can avoid taking any filesystem
> > > lock, as long as the pages being accessed are in the cache (and we don't
> > > need to readahead any pages into the cache).  We also avoid an indirect
> > > function call in these cases.
> >
> > What does this micro-optimisation actually gain us except for more
> > complexity in the IO path?
> >
> > i.e. if a filesystem lock has such massive overhead that it slows
> > down the cached readahead path in production workloads, then that's
> > something the filesystem needs to address, not unconditionally
> > bypass the filesystem before the IO gets anywhere near it.
> 
> I'm fine with not moving that functionality into the VFS. The problem
> I have in gfs2 is that taking glocks is really expensive. Part of that
> overhead is accidental, but we definitely won't be able to fix it in
> the short term. So something like the IOCB_CACHED flag that prevents
> generic_file_read_iter from issuing readahead I/O would save the day
> for us. Does that idea stand a chance?

I have no problem with a "NOREADAHEAD" flag being passed to
generic_file_read_iter(). It's not a "already cached" flag though,
it's a "don't start any IO" directive, just like the NOWAIT flag is
a "don't block on locks or IO in progress" directive and not an
"already cached" flag. Readahead is something we should be doing,
unless a filesystem has a very good reason not to, such as the gfs2
locking case here...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
