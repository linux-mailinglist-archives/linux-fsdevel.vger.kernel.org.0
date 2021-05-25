Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C23B38FAE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 08:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhEYGal (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 02:30:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23720 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230509AbhEYGaj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 02:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621924150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xmg+jKMuyj8kCoSvApnyzVNUBfF8MHu5WWzJfFH3+RY=;
        b=SLvGcKT4tlb2IyR6P+36mZ4Iz6aoZnCBuuLqfi/7OVKUHkMpzuxgJaJ4OGmonCTD1PWP4B
        jhEkGqAoE3PXQCVziBUGJxcR1FShaXz8KC3h9P5hySvWn0RtihweQ+eckT7ENAQOFg7R+p
        jvwrZc04QKK6kxE7MoZ2zLdh8xMcYkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-yOExd4ABPSafQwy7v9rgDw-1; Tue, 25 May 2021 02:29:08 -0400
X-MC-Unique: yOExd4ABPSafQwy7v9rgDw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DAC21007477;
        Tue, 25 May 2021 06:29:07 +0000 (UTC)
Received: from T590 (ovpn-13-203.pek2.redhat.com [10.72.13.203])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D26DE60855;
        Tue, 25 May 2021 06:28:59 +0000 (UTC)
Date:   Tue, 25 May 2021 14:28:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>, Brian Foster <bfoster@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: iomap: writeback ioend/bio allocation deadlock risk
Message-ID: <YKyZJiY7GySlIsZ7@T590>
References: <YKcouuVR/y/L4T58@T590>
 <20210521071727.GA11473@lst.de>
 <YKdhuUZBtKMxDpsr@T590>
 <20210521073547.GA11955@lst.de>
 <YKdwtzp+WWQ3krhI@T590>
 <20210521083635.GA15311@lst.de>
 <YKd1VS5gkzQRn+7x@T590>
 <20210524235538.GI2817@dread.disaster.area>
 <YKyDCw430gD6pTBC@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKyDCw430gD6pTBC@T590>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 12:54:35PM +0800, Ming Lei wrote:
> On Tue, May 25, 2021 at 09:55:38AM +1000, Dave Chinner wrote:
> > On Fri, May 21, 2021 at 04:54:45PM +0800, Ming Lei wrote:
> > > On Fri, May 21, 2021 at 10:36:35AM +0200, Christoph Hellwig wrote:
> > > > On Fri, May 21, 2021 at 04:35:03PM +0800, Ming Lei wrote:
> > > > > Just wondering why the ioend isn't submitted out after it becomes full?
> > > > 
> > > > block layer plugging?  Although failing bio allocations will kick that,
> > > > so that is not a deadlock risk.
> > > 
> > > These ioends are just added to one list stored on local stack variable(submit_list),
> > > how can block layer plugging observe & submit them out?
> > 
> > We ignore that, as the commit histoy says:
> > 
> > commit e10de3723c53378e7cf441529f563c316fdc0dd3
> > Author: Dave Chinner <dchinner@redhat.com>
> > Date:   Mon Feb 15 17:23:12 2016 +1100
> > 
> >     xfs: don't chain ioends during writepage submission
> > 
> >     Currently we can build a long ioend chain during ->writepages that
> >     gets attached to the writepage context. IO submission only then
> >     occurs when we finish all the writepage processing. This means we
> >     can have many ioends allocated and pending, and this violates the
> >     mempool guarantees that we need to give about forwards progress.
> >     i.e. we really should only have one ioend being built at a time,
> >     otherwise we may drain the mempool trying to allocate a new ioend
> >     and that blocks submission, completion and freeing of ioends that
> >     are already in progress.
> > 
> >     To prevent this situation from happening, we need to submit ioends
> >     for IO as soon as they are ready for dispatch rather than queuing
> >     them for later submission. This means the ioends have bios built
> >     immediately and they get queued on any plug that is current active.
> >     Hence if we schedule away from writeback, the ioends that have been
> >     built will make forwards progress due to the plug flushing on
> >     context switch. This will also prevent context switches from
> >     creating unnecessary IO submission latency.
> > 
> >     We can't completely avoid having nested IO allocation - when we have
> >     a block size smaller than a page size, we still need to hold the
> >     ioend submission until after we have marked the current page dirty.
> >     Hence we may need multiple ioends to be held while the current page
> >     is completely mapped and made ready for IO dispatch. We cannot avoid
> >     this problem - the current code already has this ioend chaining
> >     within a page so we can mostly ignore that it occurs.
> > 
> >     Signed-off-by: Dave Chinner <dchinner@redhat.com>
> >     Reviewed-by: Christoph Hellwig <hch@lst.de>
> >     Signed-off-by: Dave Chinner <david@fromorbit.com>
> > 
> > IOWs, this nesting for block size < page size has been out there
> > for many years now and we've yet to have anyone report that
> > writeback deadlocks have occurred.
> > 
> > There's a mistake in that commit message - we can't submit the
> > ioends on a page until we've marked the page as under writeback, not
> > dirty. That's because we cannot have ioends completing on a a page
> > that isn't under writeback because calling end_page_writeback() on
> > it when it isn't under writeback will BUG(). Hence we have to build
> > all the submission state before we mark the page as under writeback
> > and perform the submission(s) to avoid completion racing with
> > submission.
> > 
> > Hence we can't actually avoid nesting ioend allocation here within a
> > single page - the constraints of page cache writeback require it.
> > Hence the construction of the iomap_ioend_bioset uses a pool size of:
> > 
> > 	4 * (PAGE_SIZE / SECTOR_SIZE)
> > 
> > So that we always have enough ioends cached in the mempool to
> > guarantee forwards progress of writeback of any single page under
> > writeback.
> 
> OK, looks it is just for subpage IO, so there isn't such issue
> in case of multiple ioends.

Thinking of further, this way is still fragile, suppose there are 8
contexts in which writeback is working on at the same time, and each
needs to allocate 6 ioends, so all contexts may not move on when
allocating its 6th ioend.

> 
> > 
> > But that is a completely separate problem to this:
> > 
> > > Chained bios have been submitted already, but all can't be completed/freed
> > > until the whole ioend is done, that submission won't make forward progress.
> > 
> > This is a problem caused by having unbound contiguous ioend sizes,
> > not a problem caused by chaining bios. We can throw 256 pages into
> > a bio, so when we are doing huge contiguous IOs, we can map a
> > lot of sequential dirty pages into a contiguous extent into a very
> > long bio chain. But if we cap the max ioend size to, say, 4096
> > pages, then we've effectively capped the number of bios that can be
> > nested by such a writeback chain.
> 
> If the 4096 pages are not continuous, there may be 4096/256=16 bios
> allocated for single ioend, and one is allocated from iomap_ioend_bioset,
> another 15 is allocated by bio_alloc() from fs_bio_set which just
> reserves 2 bios.
> 
> > 
> > I was about to point you at the patchset that fixes this, but you've
> > already found it and are claiming that this nesting is an unfixable
> > problem. Capping the size of the ioend also bounds the depth of the
> > allocation nesting that will occur, and that fixes the whole nseting
> > deadlock problem: If the mempool reserves are deeper than than the
> > maximum chain nesting that can occur, then there is no deadlock.
> > 
> > However, this points out what the real problem here is: that bio
> > allocation is designed to deadlock when nesting bio allocation rather
> > than fail. Hence at the iomap level we've go no way of knowing that
> > we should terminate and submit the current bio chain and start a new
> > ioend+bio chain because we will hang before there's any indication
> > that a deadlock could occur.
> 
> Most of reservation is small, such as fs_bio_set, so bio_alloc_bioset()
> documents that 'never allocate more than 1 bio at a time'. Actually
> iomap_chain_bio() does allocate a new one, then submits the old one.
> 'fs_bio_set' reserves two bios, so the order(alloc before submit) is fine,

It may not be fine when more than one context is involved in writeback.

Thanks,
Ming

