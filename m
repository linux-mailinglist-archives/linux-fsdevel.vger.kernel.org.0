Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F0426CB71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 22:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgIPU1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 16:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20063 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726918AbgIPRYS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600277043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=irct7vujmUcquC13qEKTnUPmLuMwT+Z6y4QXkSflZzU=;
        b=ZChbVoB5j6p72xegVAXq3u7pwcKXJoB8yBgbh0IqH3Pu+8CVIe5nOz/BIrsiXSsMfHSi7G
        L9/kgP2koFrPozTOSMPYprWxF15BJ9OiIqzPmv7me5gpWcLIm/yf2cG1rzFFtcQe8zZkRn
        Wu78h8WDJFLVQ9dzLf6duhyO+YIEnUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-jlX2KyA8M66w8alSwSddJw-1; Wed, 16 Sep 2020 09:07:19 -0400
X-MC-Unique: jlX2KyA8M66w8alSwSddJw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88894AD682;
        Wed, 16 Sep 2020 13:07:17 +0000 (UTC)
Received: from bfoster (ovpn-113-130.rdu2.redhat.com [10.10.113.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 51D5519728;
        Wed, 16 Sep 2020 13:07:16 +0000 (UTC)
Date:   Wed, 16 Sep 2020 09:07:14 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        minlei@redhat.com
Subject: Re: [PATCH] iomap: Fix the write_count in iomap_add_to_ioend().
Message-ID: <20200916130714.GA1681377@bfoster>
References: <20200821044533.BBFD1A405F@d06av23.portsmouth.uk.ibm.com>
 <20200821215358.GG7941@dread.disaster.area>
 <20200822131312.GA17997@infradead.org>
 <20200824142823.GA295033@bfoster>
 <20200824150417.GA12258@infradead.org>
 <20200824154841.GB295033@bfoster>
 <20200825004203.GJ12131@dread.disaster.area>
 <20200825144917.GA321765@bfoster>
 <20200916001242.GE7955@magnolia>
 <20200916084510.GA30815@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916084510.GA30815@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 09:45:10AM +0100, Christoph Hellwig wrote:
> On Tue, Sep 15, 2020 at 05:12:42PM -0700, Darrick J. Wong wrote:
> > On Tue, Aug 25, 2020 at 10:49:17AM -0400, Brian Foster wrote:
> > > cc Ming
> > > 
> > > On Tue, Aug 25, 2020 at 10:42:03AM +1000, Dave Chinner wrote:
> > > > On Mon, Aug 24, 2020 at 11:48:41AM -0400, Brian Foster wrote:
> > > > > On Mon, Aug 24, 2020 at 04:04:17PM +0100, Christoph Hellwig wrote:
> > > > > > On Mon, Aug 24, 2020 at 10:28:23AM -0400, Brian Foster wrote:
> > > > > > > Do I understand the current code (__bio_try_merge_page() ->
> > > > > > > page_is_mergeable()) correctly in that we're checking for physical page
> > > > > > > contiguity and not necessarily requiring a new bio_vec per physical
> > > > > > > page?
> > > > > > 
> > > > > > 
> > > > > > Yes.
> > > > > > 
> > > > > 
> > > > > Ok. I also realize now that this occurs on a kernel without commit
> > > > > 07173c3ec276 ("block: enable multipage bvecs"). That is probably a
> > > > > contributing factor, but it's not clear to me whether it's feasible to
> > > > > backport whatever supporting infrastructure is required for that
> > > > > mechanism to work (I suspect not).
> > > > > 
> > > > > > > With regard to Dave's earlier point around seeing excessively sized bio
> > > > > > > chains.. If I set up a large memory box with high dirty mem ratios and
> > > > > > > do contiguous buffered overwrites over a 32GB range followed by fsync, I
> > > > > > > can see upwards of 1GB per bio and thus chains on the order of 32+ bios
> > > > > > > for the entire write. If I play games with how the buffered overwrite is
> > > > > > > submitted (i.e., in reverse) however, then I can occasionally reproduce
> > > > > > > a ~32GB chain of ~32k bios, which I think is what leads to problems in
> > > > > > > I/O completion on some systems. Granted, I don't reproduce soft lockup
> > > > > > > issues on my system with that behavior, so perhaps there's more to that
> > > > > > > particular issue.
> > > > > > > 
> > > > > > > Regardless, it seems reasonable to me to at least have a conservative
> > > > > > > limit on the length of an ioend bio chain. Would anybody object to
> > > > > > > iomap_ioend growing a chain counter and perhaps forcing into a new ioend
> > > > > > > if we chain something like more than 1k bios at once?
> > > > > > 
> > > > > > So what exactly is the problem of processing a long chain in the
> > > > > > workqueue vs multiple small chains?  Maybe we need a cond_resched()
> > > > > > here and there, but I don't see how we'd substantially change behavior.
> > > > > > 
> > > > > 
> > > > > The immediate problem is a watchdog lockup detection in bio completion:
> > > > > 
> > > > >   NMI watchdog: Watchdog detected hard LOCKUP on cpu 25
> > > > > 
> > > > > This effectively lands at the following segment of iomap_finish_ioend():
> > > > > 
> > > > > 		...
> > > > >                /* walk each page on bio, ending page IO on them */
> > > > >                 bio_for_each_segment_all(bv, bio, iter_all)
> > > > >                         iomap_finish_page_writeback(inode, bv->bv_page, error);
> > > > > 
> > > > > I suppose we could add a cond_resched(), but is that safe directly
> > > > > inside of a ->bi_end_io() handler? Another option could be to dump large
> > > > > chains into the completion workqueue, but we may still need to track the
> > > > > length to do that. Thoughts?
> > > > 
> > > > We have ioend completion merging that will run the compeltion once
> > > > for all the pending ioend completions on that inode. IOWs, we do not
> > > > need to build huge chains at submission time to batch up completions
> > > > efficiently. However, huge bio chains at submission time do cause
> > > > issues with writeback fairness, pinning GBs of ram as unreclaimable
> > > > for seconds because they are queued for completion while we are
> > > > still submitting the bio chain and submission is being throttled by
> > > > the block layer writeback throttle, etc. Not to mention the latency
> > > > of stable pages in a situation like this - a mmap() write fault
> > > > could stall for many seconds waiting for a huge bio chain to finish
> > > > submission and run completion processing even when the IO for the
> > > > given page we faulted on was completed before the page fault
> > > > occurred...
> > > > 
> > > > Hence I think we really do need to cap the length of the bio
> > > > chains here so that we start completing and ending page writeback on
> > > > large writeback ranges long before the writeback code finishes
> > > > submitting the range it was asked to write back.
> > > > 
> > > 
> > > Ming pointed out separately that limiting the bio chain itself might not
> > > be enough because with multipage bvecs, we can effectively capture the
> > > same number of pages in much fewer bios. Given that, what do you think
> > > about something like the patch below to limit ioend size? This
> > > effectively limits the number of pages per ioend regardless of whether
> > > in-core state results in a small chain of dense bios or a large chain of
> > > smaller bios, without requiring any new explicit page count tracking.
> > > 
> > > Brian
> > 
> > Dave was asking on IRC if I was going to pull this patch in.  I'm unsure
> > of its status (other than it hasn't been sent as a proper [PATCH]) so I
> > wonder, is this necessary, and if so, can it be cleaned up and
> > submitted?
> 

I was waiting on some feedback from a few different angles before
posting a proper patch..

> Maybe it is lost somewhere, but what is the point of this patch?
> What does the magic number try to represent?
> 

Dave described the main purpose earlier in this thread [1]. The initial
motivation is that we've had downstream reports of soft lockup problems
in writeback bio completion down in the bio -> bvec loop of
iomap_finish_ioend() that has to finish writeback on each individual
page of insanely large bios and/or chains. We've also had an upstream
reports of a similar problem on linux-xfs [2].

The magic number itself was just pulled out of a hat. I picked it
because it seemed conservative enough to still allow large contiguous
bios (1GB w/ 4k pages) while hopefully preventing I/O completion
problems, but was hoping for some feedback on that bit if the general
approach was acceptable. I was also waiting for some feedback on either
of the two users who reported the problem but I don't think I've heard
back on that yet...

Brian

[1] https://lore.kernel.org/linux-fsdevel/20200821215358.GG7941@dread.disaster.area/
[2] https://lore.kernel.org/linux-xfs/alpine.LRH.2.02.2008311513150.7870@file01.intranet.prod.int.rdu2.redhat.com/

