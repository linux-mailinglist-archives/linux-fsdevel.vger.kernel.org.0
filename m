Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471CF3D4950
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 21:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhGXSUw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 14:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhGXSUv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 14:20:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DE8C061575;
        Sat, 24 Jul 2021 12:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rffqCudnrm5JKUoz+KBPg7rjdlISRKU9NYB1v0WUlHU=; b=n7EpiJrDz7Z5vCd41WUY7T1X4n
        i+XgwJgw7Y1juxrVmWtM+bZ6RKZ6dyLH3gY/ohFuLRQZvfNMYskHNzwpBGymX324/noMwjgiMheM1
        1Ac4EVBjZMSglbtp6rBRqyycaf4Q87bgsVyp4elDlK8ezYe66iNX1WwUoebQmzMI4g67kOH3AzP7R
        jfLQi8SCg3TxcmjJXRSmRIdcv8ve3bUTsOmK+aCf3NKu5O4gQ25dTiAnGdXCjorA1wfWOeeZTnHl5
        BVUyJVh4KQcaeMBIRTFMPQdIzyRfaYFBYYyn9TQVsUx3EynKXu6cxo8TOjkVPN0mpH7xUuEwlVMo1
        gK3ucbLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7MtS-00CU8e-Fx; Sat, 24 Jul 2021 19:01:07 +0000
Date:   Sat, 24 Jul 2021 20:01:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andres Freund <andres@anarazel.de>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Larabel <Michael@michaellarabel.com>
Subject: Re: Folios give an 80% performance win
Message-ID: <YPxjbopzwFYJw9hV@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <YPxNkRYMuWmuRnA5@casper.infradead.org>
 <1e48f7edcb6d9a67e8b78823660939007e14bae1.camel@HansenPartnership.com>
 <YPxYdhEirWL0XExY@casper.infradead.org>
 <b12f95c9f817f05e91ecd1aec81316afa1da1e42.camel@HansenPartnership.com>
 <17a9d8bf-cd52-4e6c-9b3e-2fbc1e4592d9@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17a9d8bf-cd52-4e6c-9b3e-2fbc1e4592d9@www.fastmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 24, 2021 at 11:45:26AM -0700, Andres Freund wrote:
> On Sat, Jul 24, 2021, at 11:23, James Bottomley wrote:
> > Well, I cut the previous question deliberately, but if you're going to
> > force me to answer, my experience with storage tells me that one test
> > being 10x different from all the others usually indicates a problem
> > with the benchmark test itself rather than a baseline improvement, so
> > I'd wait for more data.
> 
> I have a similar reaction - the large improvements are for a read/write pgbench benchmark at a scale that fits in memory. That's typically purely bound by the speed at which the WAL can be synced to disk. As far as I recall mariadb also uses buffered IO for WAL (but there was recent work in the area).
> 
> Is there a reason fdatasync() of 16MB files to have got a lot faster? Or a chance that could be broken?
> 
> Some improvement for read-only wouldn't surprise me, particularly if the os/pg weren't configured for explicit huge pages. Pgbench has a uniform distribution so its *very* tlb miss heavy with 4k pages.

It's going to depend substantially on the access pattern.  If the 16MB
file (oof, that's tiny!) was read in in large chunks or even in small
chunks, but consecutively, the folio changes will allocate larger pages
(16k, 64k, 256k, ...).  Theoretically it might get up to 2MB pages and
start using PMDs, but I've never seen that in my testing.

fdatasync() could indeed have got much faster.  If we're writing back a
256kB page as a unit, we're handling 64 times less metadata than writing
back 64x4kB pages.  We'll track 64x less dirty bits.  We'll find only
64 dirty pages per 16MB instead of 4096 dirty pages.

It's always possible I just broke something.  The xfstests aren't
exhaustive, and no regressions doesn't mean no problems.

Can you guide Michael towards parameters for pgbench that might give
an indication of performance on a more realistic workload that doesn't
entirely fit in memory?
