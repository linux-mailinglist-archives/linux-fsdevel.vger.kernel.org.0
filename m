Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0EED12B23
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 11:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfECJ72 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 05:59:28 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52638 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725777AbfECJ72 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 05:59:28 -0400
Received: from callcc.thunk.org (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x439wkQA013933
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 May 2019 05:58:48 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4D119420024; Fri,  3 May 2019 05:58:46 -0400 (EDT)
Date:   Fri, 3 May 2019 05:58:46 -0400
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
Message-ID: <20190503095846.GE23724@mit.edu>
References: <CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com>
 <CAOQ4uxgEicLTA4LtV2fpvx7okEEa=FtbYE7Qa_=JeVEGXz40kw@mail.gmail.com>
 <CAHWVdUXS+e71QNFAyhFUY4W7o3mzVCb=8UrRZAN=v9bv7j6ssA@mail.gmail.com>
 <CAOQ4uxjNWLvh7EmizA7PjmViG5nPMsvB2UbHW6-hhbZiLadQTA@mail.gmail.com>
 <20190503023043.GB23724@mit.edu>
 <CAOQ4uxjM+ivnn-oU482GmRqOF6bYY5j89NdyHnfH++f49qB4yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjM+ivnn-oU482GmRqOF6bYY5j89NdyHnfH++f49qB4yw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 03, 2019 at 12:16:32AM -0400, Amir Goldstein wrote:
> OK. we can leave that one for later.
> Although I am not sure what the concern is.
> If we are able to agree  and document a LINK_ATOMIC flag,
> what would be the down side of documenting a RENAME_ATOMIC
> flag with same semantics? After all, as I said, this is what many users
> already expect when renaming a temp file (as ext4 heuristics prove).

The problem is if the "temp file" has been hardlinked to 1000
different directories, does the rename() have to guarantee that we
have to make sure that the changes to all 1000 directories have been
persisted to disk?  And all of the parent directories of those 1000
directories have also *all* been persisted to disk, all the way up to
the root?

With the O_TMPFILE linkat case, we know that inode hasn't been
hard-linked to any other directory, and mercifully directories have
only one parent directory, so we only have to check one set of
directory inodes all the way up to the root having been persisted.

But.... I can already imagine someone complaining that if due to bind
mounts and 1000 mount namespaces, there is some *other* directory
pathname which could be used to reach said "tmpfile", we have to
guarantee that all parent directories which could be used to reach
said "tmpfile" even if they span a dozen different file systems,
*also* have to be persisted due to sloppy drafting of what the
atomicity rules might happen to be.

If we are only guaranteeing the persistence of the containing
directories of the source and destination files, that's pretty easy.
But then the consistency rules need to *explicitly* state this.  Some
of the handwaving definitions of what would be guaranteed.... scare
me.

						- Ted

P.S.  If we were going to do this, we'd probably want to simply define
a flag to be AT_FSYNC, using the strict POSIX definition of fsync,
which is to say, as a result of the linkat or renameat, the file in
question, and its associated metadata, are guaranteed to be persisted
to disk.  No other guarantees about any other inode's metadata
regardless of when they might be made, would be guaranteed.

If people really want "global barrier" semantics, then perhaps it
would be better to simply define a barrierfs(2) system call that works
like syncfs(2) --- it applies to the whole file system, and guarantees
that all changes made after barrierfs(2) will be visible if any
changes made *after* barrierfs(2) are visible.  Amir, you used "global
ordering" a few times; if you really need that, let's define a new
system call which guarantees that.  Maybe some of the research
proposals for exotic changes to SSD semantics, etc., would allow
barrierfs(2) semantics to be something that we could implement more
efficiently than syncfs(2).  But let's make this be explicit, as
opposed to some magic guarantee that falls out as a side effect of the
fsync(2) system call to a single inode.
