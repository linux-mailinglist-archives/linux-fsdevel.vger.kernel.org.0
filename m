Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525F141A12A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 23:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbhI0VJd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 17:09:33 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:41697 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236743AbhI0VJb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:09:31 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 86368106BC8;
        Tue, 28 Sep 2021 07:07:51 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mUxqo-00HRym-VE; Tue, 28 Sep 2021 07:07:50 +1000
Date:   Tue, 28 Sep 2021 07:07:50 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jane Chu <jane.chu@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/5] vfs: add a zero-initialization mode to fallocate
Message-ID: <20210927210750.GH1756565@dread.disaster.area>
References: <20210922054931.GT1756565@dread.disaster.area>
 <20210922212725.GN570615@magnolia>
 <20210923000255.GO570615@magnolia>
 <20210923014209.GW1756565@dread.disaster.area>
 <CAPcyv4j77cWASW1Qp=J8poVRi8+kDQbBsLZb0HY+dzeNa=ozNg@mail.gmail.com>
 <CAPcyv4in7WRw1_e5iiQOnoZ9QjQWhjj+J7HoDf3ObweUvADasg@mail.gmail.com>
 <20210923225433.GX1756565@dread.disaster.area>
 <CAPcyv4jsU1ZBY0MNKf9CCCFaR4qcwUCRmZHstPpF02pefKnDtg@mail.gmail.com>
 <09ed3c3c-391b-bf91-2456-d7f7ca5ab2fb@oracle.com>
 <20210924013516.GB570577@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924013516.GB570577@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=epq8cqlX c=1 sm=1 tr=0 ts=615232a8
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=7-415B0cAAAA:8 a=QyXUC8HyAAAA:8
        a=ZdkKxCtHSC7M8R2DOccA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 06:35:16PM -0700, Darrick J. Wong wrote:
> On Thu, Sep 23, 2021 at 06:21:19PM -0700, Jane Chu wrote:
> > 
> > On 9/23/2021 6:18 PM, Dan Williams wrote:
> > > On Thu, Sep 23, 2021 at 3:54 PM Dave Chinner <david@fromorbit.com> wrote:
> > > > 
> > > > On Wed, Sep 22, 2021 at 10:42:11PM -0700, Dan Williams wrote:
> > > > > On Wed, Sep 22, 2021 at 7:43 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > > > > > 
> > > > > > On Wed, Sep 22, 2021 at 6:42 PM Dave Chinner <david@fromorbit.com> wrote:
> > > > > > [..]
> > > > > > > Hence this discussion leads me to conclude that fallocate() simply
> > > > > > > isn't the right interface to clear storage hardware poison state and
> > > > > > > it's much simpler for everyone - kernel and userspace - to provide a
> > > > > > > pwritev2(RWF_CLEAR_HWERROR) flag to directly instruct the IO path to
> > > > > > > clear hardware error state before issuing this user write to the
> > > > > > > hardware.
> > > > > > 
> > > > > > That flag would slot in nicely in dax_iomap_iter() as the gate for
> > > > > > whether dax_direct_access() should allow mapping over error ranges,
> > > > > > and then as a flag to dax_copy_from_iter() to indicate that it should
> > > > > > compare the incoming write to known poison and clear it before
> > > > > > proceeding.
> > > > > > 
> > > > > > I like the distinction, because there's a chance the application did
> > > > > > not know that the page had experienced data loss and might want the
> > > > > > error behavior. The other service the driver could offer with this
> > > > > > flag is to do a precise check of the incoming write to make sure it
> > > > > > overlaps known poison and then repair the entire page. Repairing whole
> > > > > > pages makes for a cleaner implementation of the code that tries to
> > > > > > keep poison out of the CPU speculation path, {set,clear}_mce_nospec().
> > > > > 
> > > > > This flag could also be useful for preadv2() as there is currently no
> > > > > way to read the good data in a PMEM page with poison via DAX. So the
> > > > > flag would tell dax_direct_access() to again proceed in the face of
> > > > > errors, but then the driver's dax_copy_to_iter() operation could
> > > > > either read up to the precise byte offset of the error in the page, or
> > > > > autoreplace error data with zero's to try to maximize data recovery.
> > > > 
> > > > Yes, it could. I like the idea - say RWF_IGNORE_HWERROR - to read
> > > > everything that can be read from the bad range because it's the
> > > > other half of the problem RWF_RESET_HWERROR is trying to address.
> > > > That is, the operation we want to perform on a range with an error
> > > > state is -data recovery-, not "reinitialisation". Data recovery
> > > > requires two steps:
> > > > 
> > > > - "try to recover the data from the bad storage"; and
> > > > - "reinitialise the data and clear the error state"
> > > > 
> > > > These naturally map to read() and write() operations, not
> > > > fallocate(). With RWF flags they become explicit data recovery
> > > > operations, unlike fallocate() which needs to imply that "writing
> > > > zeroes" == "reset hardware error state". While that reset method
> > > > may be true for a specific pmem hardware implementation it is not a
> > > > requirement for all storage hardware. It's most definitely not a
> > > > requirement for future storage hardware, either.
> > > > 
> > > > It also means that applications have no choice in what data they can
> > > > use to reinitialise the damaged range with because fallocate() only
> > > > supports writing zeroes. If we've recovered data via a read() as you
> > > > suggest we could, then we can rebuild the data from other redundant
> > > > information and immediately write that back to the storage, hence
> > > > repairing the fault.
> > > > 
> > > > That, in turn, allows the filesystem to turn the RWF_RESET_HWERROR
> > > > write into an exclusive operation and hence allow the
> > > > reinitialisation with the recovered/repaired state to run atomically
> > > > w.r.t. all other filesystem operations.  i.e. the reset write
> > > > completes the recovery operation instead of requiring separate
> > > > "reset" and "write recovered data into zeroed range" steps that
> > > > cannot be executed atomically by userspace...
> > > 
> > > /me nods
> > > 
> > > Jane, want to take a run at patches for this ^^^?
> > > 
> > 
> > Sure, I'll give it a try.
> > 
> > Thank you all for the discussions!
> 
> Cool, thank you!

I'd like to propose a slight modification to the API: a single RWF
flag called RWF_RECOVER_DATA. On read, this means the storage tries
to read all the data it can from the range, and for the parts it
can't read data from (cachelines, sectors, whatever) it returns as
zeroes.

On write, this means the errors over the range get cleared and the
user data provided gets written over the top of whatever was there.
Filesystems should perform this as an exclusive operation to that
range of the file.

That way we only need one IOCB_RECOVERY flag, and for communicating
with lower storage layers (e.g. dm/md raid and/or hardware) only one
REQ_RECOVERY flag is needed in the bio.

Thoughts?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
