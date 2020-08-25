Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051052510BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 06:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgHYE1S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 00:27:18 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:51151 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbgHYE1Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:27:16 -0400
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 349066AC401;
        Tue, 25 Aug 2020 14:27:12 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kAQYB-0006L5-Ky; Tue, 25 Aug 2020 14:27:11 +1000
Date:   Tue, 25 Aug 2020 14:27:11 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] iomap: Change calling convention for zeroing
Message-ID: <20200825042711.GL12131@dread.disaster.area>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-10-willy@infradead.org>
 <20200825002735.GI12131@dread.disaster.area>
 <20200825032603.GL17456@casper.infradead.org>
 <E47B2C68-43F2-496F-AA91-A83EB3D91F28@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E47B2C68-43F2-496F-AA91-A83EB3D91F28@dilger.ca>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QKgWuTDL c=1 sm=1 tr=0 cx=a_idp_d
        a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=Avm1FSHoLamJ-oWrJvIA:9 a=fEKI0cE5RSuP_qZy:21 a=LEqab9mPDQQxAqv4:21
        a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 24, 2020 at 09:35:59PM -0600, Andreas Dilger wrote:
> On Aug 24, 2020, at 9:26 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > 
> > On Tue, Aug 25, 2020 at 10:27:35AM +1000, Dave Chinner wrote:
> >>> 	do {
> >>> -		unsigned offset, bytes;
> >>> -
> >>> -		offset = offset_in_page(pos);
> >>> -		bytes = min_t(loff_t, PAGE_SIZE - offset, count);
> >>> +		loff_t bytes;
> >>> 
> >>> 		if (IS_DAX(inode))
> >>> -			status = dax_iomap_zero(pos, offset, bytes, iomap);
> >>> +			bytes = dax_iomap_zero(pos, length, iomap);
> >> 
> >> Hmmm. everything is loff_t here, but the callers are defining length
> >> as u64, not loff_t. Is there a potential sign conversion problem
> >> here? (sure 64 bit is way beyond anything we'll pass here, but...)
> > 
> > I've gone back and forth on the correct type for 'length' a few times.
> > size_t is too small (not for zeroing, but for seek()).  An unsigned type
> > seems right -- a length can't be negative, and we don't want to give
> > the impression that it can.  But the return value from these functions
> > definitely needs to be signed so we can represent an error.  So a u64
> > length with an loff_t return type feels like the best solution.  And
> > the upper layers have to promise not to pass in a length that's more
> > than 2^63-1.
> 
> The problem with allowing a u64 as the length is that it leads to the
> possibility of an argument value that cannot be returned.  Checking
> length < 0 is not worse than checking length > 0x7ffffffffffffff,
> and has the benefit of consistency with the other argument types and
> signs...

I think the problem here is that we have no guaranteed 64 bit size
type. when that was the case with off_t, we created loff_t to always
represent a 64 bit offset value. However, we never created one for
the count/size that is passed alongside loff_t in many places - it
was said that "syscalls are limited to 32 bit sizes" and
"size_t is 64 bit on 64 bit platforms" and so on and so we still
don't have a clean way to pass 64 bit sizes through the IO path.

We've been living with this shitty situation for a long time now, so
perhaps it's time for us to define lsize_t for 64 bit lengths and
start using that everywhere that needs a 64 bit clean path
through the code, regardless of whether the arch is 32 or 64 bit...

Thoughts?

-Dave.

-- 
Dave Chinner
david@fromorbit.com
