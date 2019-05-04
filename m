Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76F19136F0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2019 03:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfEDBnn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 21:43:43 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56216 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726700AbfEDBnn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 21:43:43 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x441h8x6003372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 May 2019 21:43:09 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C7F31420024; Fri,  3 May 2019 21:43:07 -0400 (EDT)
Date:   Fri, 3 May 2019 21:43:07 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Vijay Chidambaram <vijay@cs.utexas.edu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
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
Message-ID: <20190504014307.GA4058@mit.edu>
References: <CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com>
 <CAOQ4uxgEicLTA4LtV2fpvx7okEEa=FtbYE7Qa_=JeVEGXz40kw@mail.gmail.com>
 <CAHWVdUXS+e71QNFAyhFUY4W7o3mzVCb=8UrRZAN=v9bv7j6ssA@mail.gmail.com>
 <CAOQ4uxjNWLvh7EmizA7PjmViG5nPMsvB2UbHW6-hhbZiLadQTA@mail.gmail.com>
 <20190503023043.GB23724@mit.edu>
 <CAHWVdUV115x8spvAd3p-6iDRE--yZULbF6DDc+Hapt2s+pJgbA@mail.gmail.com>
 <20190503094543.GD23724@mit.edu>
 <CAHWVdUWrKigH8g-Jhi404y+XvuhXAx4b+PBW8_hLF4110etSLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHWVdUWrKigH8g-Jhi404y+XvuhXAx4b+PBW8_hLF4110etSLg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 03, 2019 at 07:17:54PM -0500, Vijay Chidambaram wrote:
> 
> I think there might be a mis-understanding about the example
> (reproduced below) and about SOMC. The relationship that matters is
> not whether X happens before Y. The relationship between X and Y is
> that they are in the same directory, so fsync(new file X) implies
> fsync(X's parent directory) which contains Y.  In the example, X is
> A/foo and Y is A/bar. For truly un-related files such as A/foo and
> B/bar, SOMC does indeed allow fsync(A/foo) to not persist B/bar.

When you say "X and Y are in the same directory", how does this apply
in the face of hard links?  Remember, file X might be in a 100
different directories.  Does that mean if changes to file X is visible
after a crash, all files Y in any of X's 100 containing directories
that were modified before X must have their changes be visible after
the crash?

I suspect that the SOMC as articulated by Dave does make such global
guarantees.  Certainly without Park and Shin's incremental fsync,
unrelated files will have the property that if A/foo is modified after
B/bar, and B/bar's metadata changes are visible after a crash, A/foo's
metadata will also be visible.  This is true for ext4, and xfs.

Even if we ignore the hard link problem, and assume that it only
applies for files foo and bar with st_nlinks == 1, the crash
consistency guarantees you've described will *still* rule out Park and
Shin's increment fsync.  So depending on whether ext4 has fast fsync's
enabled, we might or might not have behavior consistency with your
proposed crash consistency rules.

But at this point, even if we promulgate these "guarantees" in a
kernel documentation file, applications won't be able to depend on
them.  If they do, they will be unreliable depending on which file
system they use; so they won't be particularly useful for application
authors care about portability.  (Or worse, for users who are under
the delusion that the application authors care about portability, and
who will be subject to data corruption after a crash.)  Do we *really*
want to be promulgating these semantics to application authors?

Finally, I'll note that generic/342 is much more specific, and your
proposed crash consistency rule is more general.

# Test that if we rename a file, create a new file that has the old name of the
# other file and is a child of the same parent directory, fsync the new inode,
# power fail and mount the filesystem, we do not lose the first file and that
# file has the name it was renamed to.

> touch A/foo
> echo “hello” >  A/foo
> sync
> mv A/foo A/bar
> echo “world” > A/foo
> fsync A/foo
> CRASH

Sure, that's one that fast commit will honor.

But what about:

echo "world" > A/foo
echo "hello" > A/bar
chmod 755 A/bar
sync
chmod 750 A/bar
echo "new world" >> A/foo
fsync A/foo
CRASH

.... will your crash consistency rules guarantee that the permissions
change for A/bar is visible after the fsync of A/foo?

Or if A/foo and A/bar exists, and we do:

echo "world" > A/foo
echo "hello" > A/bar
sync
mv A/bar A/quux
echo "new world" >> A/foo
fsync A/foo
CRASH

... is the rename of A/bar and A/quux guaranteed to be visible after
the crash?

With Park and Shin's incremental fsync journal, the two cases I've
described below would *not* have such guarantees.  Standard ext4 today
would in fact have these guarantees.  But I would consider this an
accident of the implementation, and *not* a promise that I would want
to make for all time, precisely because it forbids us from making
innovations that might improve performance.

Even if I didn't have an engineer working on implementing Park and
Shin's proposal, what worries me is if I did make this guarantee, it
would tie my hands from making this optimization in the future --- and
I can't necessarily forsee all possible optimizations we might want to
make in the future.

So the question I'm trying to ask is how many applications will
actually benefit from "documenting current behavior" and effectively
turning this into a promise for all time?  Ultimately this is a
tradeoff.  Sure, this might enable applications to do things that are
more aggressive than what Posix guarantees; but it also ties the hands
of file system engineers.

This is why I'd much rather do this via new system calls; say, maybe
something like fsync_with_barrier(fd).  This can degrade to fsync(fd)
if necessary, but it allows the application to explicitly request
certain semantics, as opposed to encouraging applications to *assume*
that certain magic side effects will be there --- and which might not
be true for all file systems, or for all time.

We still need to very carefully define what the semantics of
fsync_with_barrier(fd) would be --- especially whether
fsync_with_barrier(fd) provides local (within the same directory) or
global barrier guarantees, and if it's local, how are files with
multiple "parent directories" interact with the guarantees.  But at
least this way it's an explicit declaration of what the application
wants, and not an implicit one.

Cheers,

						- Ted
