Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BC81EEE45
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 01:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgFDXa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 19:30:57 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:48317 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725920AbgFDXa5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 19:30:57 -0400
Received: from dread.disaster.area (pa49-180-124-177.pa.nsw.optusnet.com.au [49.180.124.177])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id A45A6108319;
        Fri,  5 Jun 2020 09:30:54 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jgzK1-0001Pa-Ln; Fri, 05 Jun 2020 09:30:53 +1000
Date:   Fri, 5 Jun 2020 09:30:53 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: Handle I/O errors gracefully in page_mkwrite
Message-ID: <20200604233053.GW2040@dread.disaster.area>
References: <20200604202340.29170-1-willy@infradead.org>
 <20200604225726.GU2040@dread.disaster.area>
 <20200604230519.GW19604@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604230519.GW19604@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=kj9zAlcOel0A:10 a=nTHF0DUjJn0A:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=jINDFZZm4DkczEFURbYA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 04, 2020 at 04:05:19PM -0700, Matthew Wilcox wrote:
> On Fri, Jun 05, 2020 at 08:57:26AM +1000, Dave Chinner wrote:
> > On Thu, Jun 04, 2020 at 01:23:40PM -0700, Matthew Wilcox wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > 
> > > Test generic/019 often results in:
> > > 
> > > WARNING: at fs/iomap/buffered-io.c:1069 iomap_page_mkwrite_actor+0x57/0x70
> > > 
> > > Since this can happen due to a storage error, we should not WARN for it.
> > > Just return -EIO, which will be converted to a SIGBUS for the hapless
> > > task attempting to write to the page that we can't read.
> > 
> > Why didn't the "read" part of the fault which had the EIO error fail
> > the page fault? i.e. why are we waiting until deep inside the write
> > fault path to error out on a failed page read?
> 
> I have a hypothesis that I don't know how to verify.
> 
> First the task does a load from the page and we put a read-only PTE in
> the page tables.  Then it writes to the page using write().  The page
> gets written back, but hits an error in iomap_writepage_map()
> which calls ClearPageUptodate().  Then the task with it mapped attempts
> to store to it.

Sure, but that's not really what I was asking: why isn't this
!uptodate state caught before the page fault code calls
->page_mkwrite? The page fault code has a reference to the page,
after all, and in a couple of paths it even has the page locked.

What I'm trying to understand is why this needs to be fixed inside
->page_mkwrite, because AFAICT if we have to fix this in the iomap
code, we have the same "we got handed a bad page by the page fault"
problem in every single ->page_mkwrite implementation....

> I haven't dug through what generic/019 does, so I don't know how plausible
> this is.

# Run fsstress and fio(dio/aio and mmap) and simulate disk failure
# check filesystem consistency at the end.

I don't think it is mixing buffered writes and mmap writes on the
same file via fio. Maybe fsstress is triggering that, but the
fsstress workload is single threaded so, again, I'm not sure it will
do this.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
