Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 698D4183B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 04:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfEICUn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 22:20:43 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49965 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725842AbfEICUn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 22:20:43 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x492KEDn029318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 May 2019 22:20:15 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 06FB1420024; Wed,  8 May 2019 22:20:14 -0400 (EDT)
Date:   Wed, 8 May 2019 22:20:13 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dave Chinner <david@fromorbit.com>
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
Message-ID: <20190509022013.GC7031@mit.edu>
References: <CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com>
 <CAOQ4uxgEicLTA4LtV2fpvx7okEEa=FtbYE7Qa_=JeVEGXz40kw@mail.gmail.com>
 <CAHWVdUXS+e71QNFAyhFUY4W7o3mzVCb=8UrRZAN=v9bv7j6ssA@mail.gmail.com>
 <CAOQ4uxjNWLvh7EmizA7PjmViG5nPMsvB2UbHW6-hhbZiLadQTA@mail.gmail.com>
 <20190503023043.GB23724@mit.edu>
 <20190509014327.GT1454@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509014327.GT1454@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 09, 2019 at 11:43:27AM +1000, Dave Chinner wrote:
> 
> .... the whole point of SOMC is that allows filesystems to avoid
> dragging external metadata into fsync() operations /unless/ there's
> a user visible ordering dependency that must be maintained between
> objects.  If all you are doing is stabilising file data in a stable
> file/directory, then independent, incremental journaling of the
> fsync operations on that file fit the SOMC model just fine.

Well, that's not what Vijay's crash consistency guarantees state.  It
guarantees quite a bit more than what you've written above.  Which is
my concern.

> > P.P.S.  One of the other discussions that did happen during the main
> > LSF/MM File system session, and for which there was general agreement
> > across a number of major file system maintainers, was a fsync2()
> > system call which would take a list of file descriptors (and flags)
> > that should be fsync'ed.
> 
> Hmmmm, that wasn't on the agenda, and nobody has documented it as
> yet.

It came up as suggested alternative during Ric Wheeler's "Async all
the things" session.  The problem he was trying to address was
programs (perhaps userspace file servers) who need to fsync a large
number of files at the same time.  The problem with his suggested
solution (which we have for AIO and io_uring already) of having the
program issue a large number of asynchronous fsync's and then waiting
for them all, is that the back-end interface is a work queue, so there
is a lot of effective serialization that takes place.

> > The semantics would be that when the
> > fsync2() successfully returns, all of the guarantees of fsync() or
> > fdatasync() requested by the list of file descriptors and flags would
> > be satisfied.  This would allow file systems to more optimally fsync a
> > batch of files, for example by implementing data integrity writebacks
> > for all of the files, followed by a single journal commit to guarantee
> > persistence for all of the metadata changes.
> 
> What happens when you get writeback errors on only some of the fds?
> How do you report the failures and what do you do with the journal
> commit on partial success?

Well, one approach would be to pass back the errors in the structure.
Say something like this:

     int fsync2(int len, struct fsync_req[]);

     struct fsync_req {
          int	fd;        /* IN */
	  int	flags;	   /* IN */
	  int	retval;    /* OUT */
     };

As far as what do you do with the journal commit on partial success,
this are no atomic, "all or nothing" guarantees with this interface.
It is implementation specific whether there would be one or more file
system commits necessary before fsync2 returned.

> Of course, this ignores the elephant in the room: applications can
> /already do this/ using AIO_FSYNC and have individual error status
> for each fd. Not to mention that filesystems already batch
> concurrent fsync journal commits into a single operation. I'm not
> seeing the point of a new syscall to do this right now....

But it doesn't work very well, because the implementation uses a
workqueue.  Sure, you could create N worker threads for N fd's that
you want to fsync, and then file system can batch the fsync requests.
But wouldn't be so much simpler to give a list of fd's that should be
fsync'ed to the file system?  That way you don't have to do lots of
work to split up the work so they can be submitted in parallel, only
to have the file system batch up all of the requests being issued from
all of those kernel threads.

So yes, it's identical to the interfaces we already have.  Just like
select(2), poll(2) and epoll(2) are functionality identical...

     	  	     	    	   	 - Ted
