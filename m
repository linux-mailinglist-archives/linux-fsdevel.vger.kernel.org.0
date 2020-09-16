Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1DD26BF9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 10:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgIPIp3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 04:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIPIp0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:45:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABD7C06174A;
        Wed, 16 Sep 2020 01:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RwS3rW8B+ViP4YJxJK0d4LsKrqUL+lbB0Q2Eor68chU=; b=iJxcOZA45Nc6D2m+4Ydi8g6iJE
        EIzSywwIr1olZ0MonhuBswR4j28Emdvcj3jqhxn4trt4bZiPuz6hRsxDQp+fF7u4Vad9mYlIrmHUy
        9C/pTn05QR6nzpYSwGfgoXkM7jKEaxnMo7nTmVAqT1m+8uiBBgURlasPg0kQvKSJZC7F9NAmZ7+xC
        ZRw7rcabO84VdXXNwGH8BS+iwALMldc9Bviz0KNZe146/g6y81I3eldK7E1C9Rwr9CeozfvuEh1We
        mIYRhjxWmfLoboJQrS7XaqwDFCpHSVjEqo4e34iVo4XUVW+KAwXAtewUPHgnak02iqj3iRtJgU0Nu
        rqrQfD3A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIT3u-000883-2t; Wed, 16 Sep 2020 08:45:10 +0000
Date:   Wed, 16 Sep 2020 09:45:10 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Brian Foster <bfoster@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        minlei@redhat.com
Subject: Re: [PATCH] iomap: Fix the write_count in iomap_add_to_ioend().
Message-ID: <20200916084510.GA30815@infradead.org>
References: <20200820231140.GE7941@dread.disaster.area>
 <20200821044533.BBFD1A405F@d06av23.portsmouth.uk.ibm.com>
 <20200821215358.GG7941@dread.disaster.area>
 <20200822131312.GA17997@infradead.org>
 <20200824142823.GA295033@bfoster>
 <20200824150417.GA12258@infradead.org>
 <20200824154841.GB295033@bfoster>
 <20200825004203.GJ12131@dread.disaster.area>
 <20200825144917.GA321765@bfoster>
 <20200916001242.GE7955@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916001242.GE7955@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 05:12:42PM -0700, Darrick J. Wong wrote:
> On Tue, Aug 25, 2020 at 10:49:17AM -0400, Brian Foster wrote:
> > cc Ming
> > 
> > On Tue, Aug 25, 2020 at 10:42:03AM +1000, Dave Chinner wrote:
> > > On Mon, Aug 24, 2020 at 11:48:41AM -0400, Brian Foster wrote:
> > > > On Mon, Aug 24, 2020 at 04:04:17PM +0100, Christoph Hellwig wrote:
> > > > > On Mon, Aug 24, 2020 at 10:28:23AM -0400, Brian Foster wrote:
> > > > > > Do I understand the current code (__bio_try_merge_page() ->
> > > > > > page_is_mergeable()) correctly in that we're checking for physical page
> > > > > > contiguity and not necessarily requiring a new bio_vec per physical
> > > > > > page?
> > > > > 
> > > > > 
> > > > > Yes.
> > > > > 
> > > > 
> > > > Ok. I also realize now that this occurs on a kernel without commit
> > > > 07173c3ec276 ("block: enable multipage bvecs"). That is probably a
> > > > contributing factor, but it's not clear to me whether it's feasible to
> > > > backport whatever supporting infrastructure is required for that
> > > > mechanism to work (I suspect not).
> > > > 
> > > > > > With regard to Dave's earlier point around seeing excessively sized bio
> > > > > > chains.. If I set up a large memory box with high dirty mem ratios and
> > > > > > do contiguous buffered overwrites over a 32GB range followed by fsync, I
> > > > > > can see upwards of 1GB per bio and thus chains on the order of 32+ bios
> > > > > > for the entire write. If I play games with how the buffered overwrite is
> > > > > > submitted (i.e., in reverse) however, then I can occasionally reproduce
> > > > > > a ~32GB chain of ~32k bios, which I think is what leads to problems in
> > > > > > I/O completion on some systems. Granted, I don't reproduce soft lockup
> > > > > > issues on my system with that behavior, so perhaps there's more to that
> > > > > > particular issue.
> > > > > > 
> > > > > > Regardless, it seems reasonable to me to at least have a conservative
> > > > > > limit on the length of an ioend bio chain. Would anybody object to
> > > > > > iomap_ioend growing a chain counter and perhaps forcing into a new ioend
> > > > > > if we chain something like more than 1k bios at once?
> > > > > 
> > > > > So what exactly is the problem of processing a long chain in the
> > > > > workqueue vs multiple small chains?  Maybe we need a cond_resched()
> > > > > here and there, but I don't see how we'd substantially change behavior.
> > > > > 
> > > > 
> > > > The immediate problem is a watchdog lockup detection in bio completion:
> > > > 
> > > >   NMI watchdog: Watchdog detected hard LOCKUP on cpu 25
> > > > 
> > > > This effectively lands at the following segment of iomap_finish_ioend():
> > > > 
> > > > 		...
> > > >                /* walk each page on bio, ending page IO on them */
> > > >                 bio_for_each_segment_all(bv, bio, iter_all)
> > > >                         iomap_finish_page_writeback(inode, bv->bv_page, error);
> > > > 
> > > > I suppose we could add a cond_resched(), but is that safe directly
> > > > inside of a ->bi_end_io() handler? Another option could be to dump large
> > > > chains into the completion workqueue, but we may still need to track the
> > > > length to do that. Thoughts?
> > > 
> > > We have ioend completion merging that will run the compeltion once
> > > for all the pending ioend completions on that inode. IOWs, we do not
> > > need to build huge chains at submission time to batch up completions
> > > efficiently. However, huge bio chains at submission time do cause
> > > issues with writeback fairness, pinning GBs of ram as unreclaimable
> > > for seconds because they are queued for completion while we are
> > > still submitting the bio chain and submission is being throttled by
> > > the block layer writeback throttle, etc. Not to mention the latency
> > > of stable pages in a situation like this - a mmap() write fault
> > > could stall for many seconds waiting for a huge bio chain to finish
> > > submission and run completion processing even when the IO for the
> > > given page we faulted on was completed before the page fault
> > > occurred...
> > > 
> > > Hence I think we really do need to cap the length of the bio
> > > chains here so that we start completing and ending page writeback on
> > > large writeback ranges long before the writeback code finishes
> > > submitting the range it was asked to write back.
> > > 
> > 
> > Ming pointed out separately that limiting the bio chain itself might not
> > be enough because with multipage bvecs, we can effectively capture the
> > same number of pages in much fewer bios. Given that, what do you think
> > about something like the patch below to limit ioend size? This
> > effectively limits the number of pages per ioend regardless of whether
> > in-core state results in a small chain of dense bios or a large chain of
> > smaller bios, without requiring any new explicit page count tracking.
> > 
> > Brian
> 
> Dave was asking on IRC if I was going to pull this patch in.  I'm unsure
> of its status (other than it hasn't been sent as a proper [PATCH]) so I
> wonder, is this necessary, and if so, can it be cleaned up and
> submitted?

Maybe it is lost somewhere, but what is the point of this patch?
What does the magic number try to represent?
