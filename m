Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B37A183EB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 04:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfEIC6w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 22:58:52 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:38169 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbfEIC6w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 22:58:52 -0400
Received: from dread.disaster.area (pa49-181-171-240.pa.nsw.optusnet.com.au [49.181.171.240])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 353423DF5D9;
        Thu,  9 May 2019 12:58:46 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hOZGf-0007Ai-QZ; Thu, 09 May 2019 12:58:45 +1000
Date:   Thu, 9 May 2019 12:58:45 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Vijay Chidambaram <vijay@cs.utexas.edu>,
        lsf-pc@lists.linux-foundation.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Filipe Manana <fdmanana@suse.com>, Chris Mason <clm@fb.com>,
        lwn@lwn.net
Subject: Re: [TOPIC] Extending the filesystem crash recovery guaranties
 contract
Message-ID: <20190509025845.GV1454@dread.disaster.area>
References: <CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com>
 <CAOQ4uxgEicLTA4LtV2fpvx7okEEa=FtbYE7Qa_=JeVEGXz40kw@mail.gmail.com>
 <CAHWVdUXS+e71QNFAyhFUY4W7o3mzVCb=8UrRZAN=v9bv7j6ssA@mail.gmail.com>
 <CAOQ4uxjNWLvh7EmizA7PjmViG5nPMsvB2UbHW6-hhbZiLadQTA@mail.gmail.com>
 <20190503023043.GB23724@mit.edu>
 <20190509014327.GT1454@dread.disaster.area>
 <20190509022013.GC7031@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509022013.GC7031@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=LhzQONXuMOhFZtk4TmSJIw==:117 a=LhzQONXuMOhFZtk4TmSJIw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=E5NmQfObTbMA:10
        a=7-415B0cAAAA:8 a=tDqAV39GApQQyVYY6TYA:9 a=ewgTJeqJKZNr03W6:21
        a=PedosMUFXuKrzh4H:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 08, 2019 at 10:20:13PM -0400, Theodore Ts'o wrote:
> On Thu, May 09, 2019 at 11:43:27AM +1000, Dave Chinner wrote:
> > 
> > .... the whole point of SOMC is that allows filesystems to avoid
> > dragging external metadata into fsync() operations /unless/ there's
> > a user visible ordering dependency that must be maintained between
> > objects.  If all you are doing is stabilising file data in a stable
> > file/directory, then independent, incremental journaling of the
> > fsync operations on that file fit the SOMC model just fine.
> 
> Well, that's not what Vijay's crash consistency guarantees state.  It
> guarantees quite a bit more than what you've written above.  Which is
> my concern.

SOMC does not defining crash consistency rules - it defines change
dependecies and how ordering and atomicity impact the dependency
graph. How other people have interpreted that is out of my control.

> It came up as suggested alternative during Ric Wheeler's "Async all
> the things" session.  The problem he was trying to address was
> programs (perhaps userspace file servers) who need to fsync a large
> number of files at the same time.  The problem with his suggested
> solution (which we have for AIO and io_uring already) of having the
> program issue a large number of asynchronous fsync's and then waiting
> for them all, is that the back-end interface is a work queue, so there
> is a lot of effective serialization that takes place.

We got linear scaling out to device bandwidth and/or IOPS limits
with bulk fsync benchmarks on XFS with that simple workqueue
implementation.

If there's problems, then I'd suggest that people should be
reporting bugs to the developers of the AIO_FSYNC code (i.e.
Christoph and myself) or providing patches to improve it so these
problems go away.

A new syscall with essentially the same user interface doesn't
guarantee that these implementation problems will be solved.


> > > The semantics would be that when the
> > > fsync2() successfully returns, all of the guarantees of fsync() or
> > > fdatasync() requested by the list of file descriptors and flags would
> > > be satisfied.  This would allow file systems to more optimally fsync a
> > > batch of files, for example by implementing data integrity writebacks
> > > for all of the files, followed by a single journal commit to guarantee
> > > persistence for all of the metadata changes.
> > 
> > What happens when you get writeback errors on only some of the fds?
> > How do you report the failures and what do you do with the journal
> > commit on partial success?
> 
> Well, one approach would be to pass back the errors in the structure.
> Say something like this:
> 
>      int fsync2(int len, struct fsync_req[]);
> 
>      struct fsync_req {
>           int	fd;        /* IN */
> 	  int	flags;	   /* IN */
> 	  int	retval;    /* OUT */
>      };

So it's essentially identical to the AIO_FSYNC interface, except
that it is synchronous.

> As far as what do you do with the journal commit on partial success,
> this are no atomic, "all or nothing" guarantees with this interface.
> It is implementation specific whether there would be one or more file
> system commits necessary before fsync2 returned.

IOWs, same guarantees as AIO_FSYNC.

> > Of course, this ignores the elephant in the room: applications can
> > /already do this/ using AIO_FSYNC and have individual error status
> > for each fd. Not to mention that filesystems already batch
> > concurrent fsync journal commits into a single operation. I'm not
> > seeing the point of a new syscall to do this right now....
> 
> But it doesn't work very well, because the implementation uses a
> workqueue.

Then fix the fucking implementation!

Sheesh! Did LSFMM include a free lobotomy for participants, or
something?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
