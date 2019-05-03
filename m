Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7251912650
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 04:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfECCbM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 22:31:12 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59817 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726022AbfECCbM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 22:31:12 -0400
Received: from callcc.thunk.org (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x432Uh5F012819
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 May 2019 22:30:46 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 49FDD420024; Thu,  2 May 2019 22:30:43 -0400 (EDT)
Date:   Thu, 2 May 2019 22:30:43 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Vijay Chidambaram <vijay@cs.utexas.edu>,
        lsf-pc@lists.linux-foundation.org,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Filipe Manana <fdmanana@suse.com>, Chris Mason <clm@fb.com>,
        lwn@lwn.net
Subject: Re: [TOPIC] Extending the filesystem crash recovery guaranties
 contract
Message-ID: <20190503023043.GB23724@mit.edu>
References: <CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com>
 <CAOQ4uxgEicLTA4LtV2fpvx7okEEa=FtbYE7Qa_=JeVEGXz40kw@mail.gmail.com>
 <CAHWVdUXS+e71QNFAyhFUY4W7o3mzVCb=8UrRZAN=v9bv7j6ssA@mail.gmail.com>
 <CAOQ4uxjNWLvh7EmizA7PjmViG5nPMsvB2UbHW6-hhbZiLadQTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjNWLvh7EmizA7PjmViG5nPMsvB2UbHW6-hhbZiLadQTA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 02, 2019 at 01:39:47PM -0400, Amir Goldstein wrote:
> > The expectation is that applications will use this, and then rename
> > the O_TMPFILE file over the original file. Is this correct? If so, is
> > there also an implied barrier between O_TMPFILE metadata and the
> > rename?

In the case of O_TMPFILE, the file can be brought into the namespace
using something like:

linkat(AT_FDCWD, "/proc/self/fd/42", AT_FDCWD, pathname, AT_SYMLINK_FOLLOW);

it's not using rename.

To be clear, this discussion happened in the hallway, and it's not
clear it had full support by everyone.  After our discussion, some of
us came up with an example where forcing a call to
filemap_write_and_wait() before the linkat(2) might *not* be the right
thing.  Suppose some browser wanted to wait until a file was fully(
downloaded before letting it appear in the directory --- but what was
being downloaded was a 4 GiB DVD image (say, a distribution's install
media).  If the download was done using O_TMPFILE followed by
linkat(2), that might be a case where forcing the data blocks to disk
before allowing the linkat(2) to proceed might not be what the
application or the user would want.

So it might be that we will need to add a linkat flag to indicate that
we want the kernel to call filemap_write_and_wait() before making the
metadata changes in linkat(2).

> For replacing an existing file with another the same could be
> achieved with renameat2(AT_FDCWD, tempname, AT_FDCWD, newname,
> RENAME_ATOMIC). There is no need to create the tempname
> file using O_TMPFILE in that case, but if you do, the RENAME_ATOMIC
> flag would be redundant.
> 
> RENAME_ATOMIC flag is needed because directories and non regular
> files cannot be created using O_TMPFILE.

I think there's much less consensus about this.  Again, most of this
happened in a hallway conversation.

> > Where does this land us on the discussion about documenting
> > file-system crash-recovery guarantees? Has that been deemed not
> > necessary?
> 
> Can't say for sure.
> Some filesystem maintainers hold on to the opinion that they do
> NOT wish to have a document describing existing behavior of specific
> filesystems, which is large parts of the document that your group posted.
> 
> They would rather that only the guaranties of the APIs are documented
> and those should already be documented in man pages anyway - if they
> are not, man pages could be improved.
> 
> I am not saying there is no room for a document that elaborates on those
> guaranties. I personally think that could be useful and certainly think that
> your group's work for adding xfstest coverage for API guaranties is useful.

Again, here is my concern.  If we promise that ext4 will always obey
Dave Chinner's SOMC model, it would forever rule out Daejun Park and
Dongkun Shin's "iJournaling: Fine-grained journaling for improving the
latency of fsync system call"[1] published in Usenix ATC 2017.

[1] https://www.usenix.org/system/files/conference/atc17/atc17-park.pdf

That's because this provides a fast fsync() using an incremental
journal.  This fast fsync would cause the metadata associated with the
inode being fsync'ed to be persisted after the crash --- ahead of
metadata changes to other, potentially completely unrelated files,
which would *not* be persisted after the crash.  Fine grained
journalling would provide all of the guarantee all of the POSIX, and
for applications that only care about the single file being fsync'ed
-- they would be happy.  BUT, it violates the proposed crash
consistency guarantees.

So if the crash consistency guarantees forbids future innovations
where applications might *want* a fast fsync() that doesn't drag
unrelated inodes into the persistence guarantees, is that really what
we want?  Do we want to forever rule out various academic
investigations such as Park and Shin's because "it violates the crash
consistency recovery model"?  Especially if some applications don't
*need* the crash consistency model?

						- Ted

P.S.  I feel especially strong about this because I'm working with an
engineer currently trying to implement a simplified version of Park
and Shin's proposal...  So this is not a hypothetical concern of mine.
I'd much rather not invalidate all of this engineer's work to date,
especially since there is a published paper demonstrating that for
some workloads (such as sqlite), this approach can be a big win.

P.P.S.  One of the other discussions that did happen during the main
LSF/MM File system session, and for which there was general agreement
across a number of major file system maintainers, was a fsync2()
system call which would take a list of file descriptors (and flags)
that should be fsync'ed.  The semantics would be that when the
fsync2() successfully returns, all of the guarantees of fsync() or
fdatasync() requested by the list of file descriptors and flags would
be satisfied.  This would allow file systems to more optimally fsync a
batch of files, for example by implementing data integrity writebacks
for all of the files, followed by a single journal commit to guarantee
persistence for all of the metadata changes.
