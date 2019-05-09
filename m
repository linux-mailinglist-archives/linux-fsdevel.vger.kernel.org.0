Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70BE618348
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 03:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfEIBnh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 21:43:37 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:36855 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbfEIBnh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 21:43:37 -0400
Received: from dread.disaster.area (pa49-181-171-240.pa.nsw.optusnet.com.au [49.181.171.240])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 74FE514A33F;
        Thu,  9 May 2019 11:43:29 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hOY5n-0006e1-LW; Thu, 09 May 2019 11:43:27 +1000
Date:   Thu, 9 May 2019 11:43:27 +1000
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
Message-ID: <20190509014327.GT1454@dread.disaster.area>
References: <CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com>
 <CAOQ4uxgEicLTA4LtV2fpvx7okEEa=FtbYE7Qa_=JeVEGXz40kw@mail.gmail.com>
 <CAHWVdUXS+e71QNFAyhFUY4W7o3mzVCb=8UrRZAN=v9bv7j6ssA@mail.gmail.com>
 <CAOQ4uxjNWLvh7EmizA7PjmViG5nPMsvB2UbHW6-hhbZiLadQTA@mail.gmail.com>
 <20190503023043.GB23724@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503023043.GB23724@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=LhzQONXuMOhFZtk4TmSJIw==:117 a=LhzQONXuMOhFZtk4TmSJIw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=E5NmQfObTbMA:10
        a=7-415B0cAAAA:8 a=2bvXc-thVNbei5B46cQA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 02, 2019 at 10:30:43PM -0400, Theodore Ts'o wrote:
> On Thu, May 02, 2019 at 01:39:47PM -0400, Amir Goldstein wrote:
> > I am not saying there is no room for a document that elaborates on those
> > guaranties. I personally think that could be useful and certainly think that
> > your group's work for adding xfstest coverage for API guaranties is useful.
> 
> Again, here is my concern.  If we promise that ext4 will always obey
> Dave Chinner's SOMC model, it would forever rule out Daejun Park and
> Dongkun Shin's "iJournaling: Fine-grained journaling for improving the
> latency of fsync system call"[1] published in Usenix ATC 2017.

No, it doesn't rule that out at all.

In a SOMC model, incremental journalling is just fine when there are
no external dependencies on the thing being fsync'd.  If you have
other dependencies (e.g. the file has just be created and so the dir
it dirty, too) then fsync would need to do the whole shebang, but
otherwise....

> So if the crash consistency guarantees forbids future innovations
> where applications might *want* a fast fsync() that doesn't drag
> unrelated inodes into the persistence guarantees,

.... the whole point of SOMC is that allows filesystems to avoid
dragging external metadata into fsync() operations /unless/ there's
a user visible ordering dependency that must be maintained between
objects.  If all you are doing is stabilising file data in a stable
file/directory, then independent, incremental journaling of the
fsync operations on that file fit the SOMC model just fine.

> is that really what
> we want?  Do we want to forever rule out various academic
> investigations such as Park and Shin's because "it violates the crash
> consistency recovery model"?  Especially if some applications don't
> *need* the crash consistency model?

Stop with the silly inflammatory hyperbole already, Ted. It is not
necessary.

> P.P.S.  One of the other discussions that did happen during the main
> LSF/MM File system session, and for which there was general agreement
> across a number of major file system maintainers, was a fsync2()
> system call which would take a list of file descriptors (and flags)
> that should be fsync'ed.

Hmmmm, that wasn't on the agenda, and nobody has documented it as
yet.

> The semantics would be that when the
> fsync2() successfully returns, all of the guarantees of fsync() or
> fdatasync() requested by the list of file descriptors and flags would
> be satisfied.  This would allow file systems to more optimally fsync a
> batch of files, for example by implementing data integrity writebacks
> for all of the files, followed by a single journal commit to guarantee
> persistence for all of the metadata changes.

What happens when you get writeback errors on only some of the fds?
How do you report the failures and what do you do with the journal
commit on partial success?

Of course, this ignores the elephant in the room: applications can
/already do this/ using AIO_FSYNC and have individual error status
for each fd. Not to mention that filesystems already batch
concurrent fsync journal commits into a single operation. I'm not
seeing the point of a new syscall to do this right now....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
