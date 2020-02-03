Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A28711512A9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 00:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgBCXCQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 18:02:16 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:46218 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726872AbgBCXCP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 18:02:15 -0500
Received: from dread.disaster.area (pa49-181-161-120.pa.nsw.optusnet.com.au [49.181.161.120])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 77ADE3A2A22;
        Tue,  4 Feb 2020 10:02:10 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iykjJ-0006Rf-AX; Tue, 04 Feb 2020 10:02:09 +1100
Date:   Tue, 4 Feb 2020 10:02:09 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: RFC: hold i_rwsem until aio completes
Message-ID: <20200203230209.GC20628@dread.disaster.area>
References: <20200114161225.309792-1-hch@lst.de>
 <20200118092838.GB9407@dread.disaster.area>
 <20200203174641.GA20035@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203174641.GA20035@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=SkgQWeG3jiSQFIjTo4+liA==:117 a=SkgQWeG3jiSQFIjTo4+liA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=7-415B0cAAAA:8 a=4rX9TS273XGzNsaKJp0A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 03, 2020 at 06:46:41PM +0100, Christoph Hellwig wrote:
> On Sat, Jan 18, 2020 at 08:28:38PM +1100, Dave Chinner wrote:
> > I think it's pretty gross, actually. It  makes the same mistake made
> > with locking in the old direct IO code - it encodes specific lock
> > operations via flags into random locations in the DIO path. This is
> > a very slippery slope, and IMO it is an layering violation to encode
> > specific filesystem locking smeantics into a layer that is supposed
> > to be generic and completely filesystem agnostic. i.e.  this
> > mechanism breaks if a filesystem moves to a different type of lock
> > (e.g. range locks), and history teaches us that we'll end up making
> > a horrible, unmaintainable mess to support different locking
> > mechanisms and contexts.
> > 
> > I think that we should be moving to a model where the filesystem
> > provides an unlock method in the iomap operations structure, and if
> > the method is present in iomap_dio_complete() it gets called for the
> > filesystem to unlock the inode at the appropriate point. This also
> > allows the filesystem to provide a different method for read or
> > write unlock, depending on what type of lock it held at submission.
> > This gets rid of the need for the iomap code to know what type of
> > lock the caller holds, too.
> 
> I'd rather avoid yet another method.  But I think with a little
> tweaking we can move the unlock into the ->end_io method.

That would work, too :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
