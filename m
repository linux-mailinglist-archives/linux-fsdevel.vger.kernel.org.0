Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30AB250E43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 03:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgHYBd4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 21:33:56 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:59131 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725838AbgHYBd4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 21:33:56 -0400
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id D5B366AD1D6;
        Tue, 25 Aug 2020 11:33:52 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kANqR-0005wh-1B; Tue, 25 Aug 2020 11:33:51 +1000
Date:   Tue, 25 Aug 2020 11:33:51 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] iomap: Convert iomap_write_end types
Message-ID: <20200825013351.GK12131@dread.disaster.area>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-9-willy@infradead.org>
 <20200825001223.GH12131@dread.disaster.area>
 <20200825010605.GJ17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825010605.GJ17456@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LPwYv6e9 c=1 sm=1 tr=0 cx=a_idp_d
        a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=7-415B0cAAAA:8
        a=lR8mz5mIW4tkD5AzabkA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 25, 2020 at 02:06:05AM +0100, Matthew Wilcox wrote:
> On Tue, Aug 25, 2020 at 10:12:23AM +1000, Dave Chinner wrote:
> > > -static int
> > > -__iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
> > > -		unsigned copied, struct page *page)
> > > +static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
> > > +		size_t copied, struct page *page)
> > >  {
> > 
> > Please leave the function declarations formatted the same way as
> > they currently are. They are done that way intentionally so it is
> > easy to grep for function definitions. Not to mention is't much
> > easier to read than when the function name is commingled into the
> > multiline paramener list like...
> 
> I understand that's true for XFS, but it's not true throughout the
> rest of the kernel. 

What other code does is irrelevant. I'm trying to maintain and
improve the consistency of the format used for the fs/iomap code.

> This file isn't even consistent:
> 
> buffered-io.c:static inline struct iomap_page *to_iomap_page(struct page *page)
> buffered-io.c:static inline bool iomap_block_needs_zeroing(struct inode
> buffered-io.c:static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
> buffered-io.c:static void iomap_writepage_end_bio(struct bio *bio)
> buffered-io.c:static int __init iomap_init(void)
> 
> (i just grepped for ^static so there're other functions not covered by this)

5 functions that have that format, compared to 45 that do have the
formatting I asked you to retain. It think it's pretty clear which
way consistency lies here...

> The other fs/iomap/ files are equally inconsistent.

Inconsistency always occurs when multiple people modify the same
code. Often that's simply because reviewers haven't noticed the
inconsistency - it's certainly not intentional.

Saying "No, I'm going to make the code less consistent because it's
already slightly inconsistent" is, IMO, not a valid response to a
review request to conform to the existing code layout in that file,
especially if it improves the consistency of the code being
modified. That's really not negotiable....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
