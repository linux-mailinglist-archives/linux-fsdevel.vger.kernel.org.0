Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85685212B43
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 19:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgGBRaa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 13:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgGBRa3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 13:30:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63413C08C5C1;
        Thu,  2 Jul 2020 10:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lMEXGkg9/1lKgDiiMTcrjkxDHT1PVSiTcXNRYHyvJiM=; b=nR1VN3uWw+bi70Q8kmATNOE5xc
        RIzIGoeaBwT8SyB4q4B6QocuAW3sKI5wdTS/6q9ENDIfzAXAp/A4MyWAYb44Tn/bAQQ2SUjR9NUG/
        1O7bDHuTp+b7UgXiYwainOhDFiy4FUrnPNclJ8Y+60riDfL6nXD+yRa4rlN3QcEnaY8tPyBxOMEuH
        w1/G0LU8A+lSq/adOGCPix7P/ATW+gSefXiYU75DrOIeieGJnS5svifbdXCbZgFO5izeIwSPvX8/Y
        G1EfSOa3KYcsHJdG+vBnQIcmbSYQ/HRkeEbQgQbpm0LE/xCzh2SOdOFIitjiRvQ70Ll+VN702Uted
        bYYbbIIA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jr32Y-0003zn-Cl; Thu, 02 Jul 2020 17:30:26 +0000
Date:   Thu, 2 Jul 2020 18:30:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Bypass filesystems for reading cached pages
Message-ID: <20200702173026.GA25523@casper.infradead.org>
References: <20200619155036.GZ8681@bombadil.infradead.org>
 <20200622003215.GC2040@dread.disaster.area>
 <CAHc6FU4b_z+vhjVPmaU46VhqoD+Y7jLN3=BRDZPrS2v=_pVpfw@mail.gmail.com>
 <20200622181338.GA21350@casper.infradead.org>
 <CAHc6FU7R2vMZ9+aXLsQ+ubECbfrBTR+yh03b_T++PRxd479vsQ@mail.gmail.com>
 <CAHc6FU5jZfz3Kv-Aa6MWbELhTscSp5eEAXTWBoVysrQg6f1moA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU5jZfz3Kv-Aa6MWbELhTscSp5eEAXTWBoVysrQg6f1moA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 02, 2020 at 05:16:43PM +0200, Andreas Gruenbacher wrote:
> On Wed, Jun 24, 2020 at 2:35 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > On Mon, Jun 22, 2020 at 8:13 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > On Mon, Jun 22, 2020 at 04:35:05PM +0200, Andreas Gruenbacher wrote:
> > > > I'm fine with not moving that functionality into the VFS. The problem
> > > > I have in gfs2 is that taking glocks is really expensive. Part of that
> > > > overhead is accidental, but we definitely won't be able to fix it in
> > > > the short term. So something like the IOCB_CACHED flag that prevents
> > > > generic_file_read_iter from issuing readahead I/O would save the day
> > > > for us. Does that idea stand a chance?
> > >
> > > For the short-term fix, is switching to a trylock in gfs2_readahead()
> > > acceptable?
> >
> > Well, it's the only thing we can do for now, right?
> 
> It turns out that gfs2 can still deadlock with a trylock in
> gfs2_readahead, just differently: in this instance, gfs2_glock_nq will
> call inode_dio_wait. When there is pending direct I/O, we'll end up
> waiting for iomap_dio_complete, which will call
> invalidate_inode_pages2_range, which will try to lock the pages
> already locked for gfs2_readahead.

That seems like a bug in trylock.  If I trylock something I'm not
expecting it to wait; i'm expecting it to fail because it would have to wait.
ie something like this:

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index c84887769b5a..97ca8f5ed22b 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -470,7 +470,10 @@ static int inode_go_lock(struct gfs2_holder *gh)
                        return error;
        }
 
-       if (gh->gh_state != LM_ST_DEFERRED)
+       if (gh->gh_flags & LM_FLAG_TRY) {
+               if (atomic_read(&ip->i_inode.i_dio_count))
+                       return -EWOULDBLOCK;
+       } else if (gh->gh_state != LM_ST_DEFERRED)
                inode_dio_wait(&ip->i_inode);
 
        if ((ip->i_diskflags & GFS2_DIF_TRUNC_IN_PROG) &&

... but probably not exactly that because I didn't try to figure out the
calling conventions or whether I should set some state in the gfs2_holder.

> This late in the 5.8 release cycle, I'd like to propose converting
> gfs2 back to use mpage_readpages. This requires reinstating
> mpage_readpages, but it's otherwise relatively trivial.
> We can then introduce an IOCB_CACHED or equivalent flag, fix the
> locking order in gfs2, convert gfs2 to mpage_readahead, and finally
> remove mage_readpages in 5.9.

I would rather not do that.
