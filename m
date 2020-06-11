Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2B21F69B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 16:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgFKONi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 10:13:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:43320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgFKONh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:13:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E9093B016;
        Thu, 11 Jun 2020 14:13:39 +0000 (UTC)
Date:   Thu, 11 Jun 2020 09:13:33 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     darrick.wong@oracle.com, linux-btrfs@vger.kernel.org,
        fdmanana@gmail.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/3] Transient errors in Direct I/O
Message-ID: <20200611141333.odbshenpn2zndn3a@fiona>
References: <20200605204838.10765-1-rgoldwyn@suse.de>
 <20200610025900.GA2005@dread.disaster.area>
 <20200610050510.GL2040@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610050510.GL2040@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15:05 10/06, Dave Chinner wrote:
> On Wed, Jun 10, 2020 at 12:59:00PM +1000, Dave Chinner wrote:
> > [ Please cc the XFS list on XFS and iomap infrastructure changes.]
> > 
> > On Fri, Jun 05, 2020 at 03:48:35PM -0500, Goldwyn Rodrigues wrote:
> > > In current scenarios, for XFS, it would mean that a page invalidation
> > > would end up being a writeback error. So, if iomap returns zero, fall
> > > back to biffered I/O. XFS has never supported fallback to buffered I/O.
> > > I hope it is not "never will" ;)
> > 
> > I wouldn't say "never", but we are not going to change XFS behaviour
> > because btrfs has a page invalidation vs DIO bug in it...
> 
> Let me point out a specific "oh shit, I didn't think of that" sort
> of problem that your blind fallback to buffered IO causes. Do this
> via direct IO:
> 
> 	pwritev2(RWF_NOWAIT)
> 
> now have it fail invalidation in the direct IO path and fallback to
> buffered write. What does buffered write do with it?
> 
> 
> 	if (iocb->ki_flags & IOCB_NOWAIT)
> 		return -EOPNOTSUPP;
> 
> Yup, userspace gets a completely spurious and bogus -EOPNOTSUPP
> error to pwritev2() because some 3rd party is accessing the same
> file via mmap or buffered IO.
> 

Oh shit, I didn't think about that!

I think adding a flag to iomap_dio_rw() to return in case of page
invalidation failure is the best option for now.

-- 
Goldwyn
