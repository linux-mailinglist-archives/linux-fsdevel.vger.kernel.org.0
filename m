Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8FD375BF0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 21:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhEFTrI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 15:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhEFTrI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 15:47:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26392C061574;
        Thu,  6 May 2021 12:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v8nUrKHIOf/xBkkvxKzROgJf3R7JMgZROTDDpidrAP4=; b=UInkFEPxf/4afmSMFO005x2rlZ
        B38n+XPLFiEmlDIk+s7Tdal8G3W77R4P5YmhyvGASPCPIO0cfH/IpgJ9fphC7CA6LAVeE9kl+uNec
        lAqYXqgaiG6psFLnZjuBh4nodG19c3I1I3sx7JzxKReUDtgjN3IIafzcsoYj//G/Jn5vVPaKSd1Mh
        lflOFl6Kt2qB/FZRjZigambfyFQ77FxPfL5DN2BicjFSzMff69+E51lVgHqb6QCBJ1ibHLo5uHyB8
        69C25817SgK3ttyIalbXpOMwB21231jVtNs/4pibmWzIobw/ZYVBbUJz/xwdWwJPOQH9d56qDnWPG
        +Q/nZ/kw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lejwM-002AMf-8x; Thu, 06 May 2021 19:45:46 +0000
Date:   Thu, 6 May 2021 20:45:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Brian Foster <bfoster@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] xfs: kick extra large ioends to completion
 workqueue
Message-ID: <20210506194542.GG388843@casper.infradead.org>
References: <20201002153357.56409-3-bfoster@redhat.com>
 <20201005152102.15797-1-bfoster@redhat.com>
 <20201006035537.GD49524@magnolia>
 <20201006140720.GQ20115@casper.infradead.org>
 <20210506193406.GE8582@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506193406.GE8582@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 06, 2021 at 12:34:06PM -0700, Darrick J. Wong wrote:
> On Tue, Oct 06, 2020 at 03:07:20PM +0100, Matthew Wilcox wrote:
> > On Mon, Oct 05, 2020 at 08:55:37PM -0700, Darrick J. Wong wrote:
> > > On Mon, Oct 05, 2020 at 11:21:02AM -0400, Brian Foster wrote:
> > > > We've had reports of soft lockup warnings in the iomap ioend
> > > > completion path due to very large bios and/or bio chains. Divert any
> > > > ioends with 256k or more pages to process to the workqueue so
> > > > completion occurs in non-atomic context and can reschedule to avoid
> > > > soft lockup warnings.
> > > 
> > > Hmmmm... is there any way we can just make end_page_writeback faster?
> > 
> > There are ways to make it faster.  I don't know if they're a "just"
> > solution ...
> > 
> > 1. We can use THPs.  That will reduce the number of pages being operated
> > on.  I hear somebody might have a patch set for that.  Incidentally,
> > this patch set will clash with the THP patchset, so one of us is going to
> > have to rebase on the other's work.  Not a complaint, just acknowledging
> > that some coordination will be needed for the 5.11 merge window.
> 
> How far off is this, anyway?  I assume it's in line behind the folio
> series?

Right.  The folio series found all kinds of fun places where the
accounting was wrong (eg accounting for an N-page I/O as a single page),
so the THP work is all renamed folio now.  The folio patchset I posted
yesterday [1] is _most_ of what is necessary from an XFS point of view.
There's probably another three dozen mm patches to actually enable
multi-page folios after that, and a lot more patches to optimise the
mm/vfs for multi-page folios, but your side of things is almost all
published and reviewable.

[1] https://lore.kernel.org/linux-fsdevel/20210505150628.111735-1-willy@infradead.org/

> > 2. We could create end_writeback_pages(struct pagevec *pvec) which
> > calls a new test_clear_writeback_pages(pvec).  That could amortise
> > taking the memcg lock and finding the lruvec and taking the mapping
> > lock -- assuming these pages are sufficiently virtually contiguous.
> > It can definitely amortise all the statistics updates.
> 
> /me kinda wonders if THPs arent the better solution for people who want
> to run large ios.

Yes, definitely.  It does rather depend on their usage patterns,
but if they're working on a file-contiguous chunk of memory, this
can help a lot.

> > 3. We can make wake_up_page(page, PG_writeback); more efficient.  If
> > you can produce this situation on demand, I had a patch for that which
> > languished due to lack of interest.
> 
> I can (well, someone can) so I'll talk to you internally about their
> seeekret reproducer.

Fantastic.  If it's something that needs to get backported to a
stable-ABI kernel ... this isn't going to be a viable solution.
