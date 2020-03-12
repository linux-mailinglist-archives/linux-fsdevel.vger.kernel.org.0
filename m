Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D51183CAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 23:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCLWjU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 18:39:20 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:53705 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726620AbgCLWjU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 18:39:20 -0400
Received: from dread.disaster.area (pa49-195-202-68.pa.nsw.optusnet.com.au [49.195.202.68])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 5C5E13A451F;
        Fri, 13 Mar 2020 09:39:14 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jCWTx-00050P-3Y; Fri, 13 Mar 2020 09:39:13 +1100
Date:   Fri, 13 Mar 2020 09:39:13 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Linux Filesystem Development List 
        <linux-fsdevel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] writeback: avoid double-writing the inode on a lazytime
 expiration
Message-ID: <20200312223913.GL10776@dread.disaster.area>
References: <20200306004555.GB225345@gmail.com>
 <20200307020043.60118-1-tytso@mit.edu>
 <20200311032009.GC46757@gmail.com>
 <20200311125749.GA7159@mit.edu>
 <20200312000716.GY10737@dread.disaster.area>
 <20200312143445.GA19160@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312143445.GA19160@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=mqTaRPt+QsUAtUurwE173Q==:117 a=mqTaRPt+QsUAtUurwE173Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=SS2py6AdgQ4A:10
        a=7-415B0cAAAA:8 a=Q8GS4823LYj-8jRK8AkA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 12, 2020 at 07:34:45AM -0700, Christoph Hellwig wrote:
> On Thu, Mar 12, 2020 at 11:07:17AM +1100, Dave Chinner wrote:
> > > That's true, but when the timestamps were originally modified,
> > > dirty_inode() will be called with flag == I_DIRTY_TIME, which will
> > > *not* be a no-op; which is to say, XFS will force the timestamps to be
> > > updated on disk when the timestamps are first dirtied, because it
> > > doesn't support I_DIRTY_TIME.
> > 
> > We log the initial timestamp change, and then ignore timestamp
> > updates until the dirty time expires and the inode is set
> > I_DIRTY_SYNC via __mark_inode_dirty_sync(). IOWs, on expiry, we have
> > time stamps that may be 24 hours out of date in memory, and they
> > still need to be flushed to the journal.
> > 
> > However, your change does not mark the inode dirtying on expiry
> > anymore, so...
> > 
> > > So I think we're fine.
> > 
> > ... we're not fine. This breaks XFS and any other filesystem that
> > relies on a I_DIRTY_SYNC notification to handle dirty time expiry
> > correctly.
> 
> I haven't seen the original mail this replies to,

The original problem was calling mark_inode_dirty_sync() on expiry
during inode writeback was causing the inode to be put back on the
dirty inode list and so ext4 was flushing it twice - once on expiry
and once 5 seconds later on the next background writeback pass.

This is a problem that XFS does not have because it does not
implement ->write_inode...

> but if we could
> get the lazytime expirty by some other means (e.g. an explicit
> callback), XFS could opt out of all the VFS inode tracking again,
> which would simplify a few things.

Yes, that would definitely make things simpler for XFS, and it would
also solve the problem that the generic lazytime expiry code has....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
