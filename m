Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFD4352470
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 02:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbhDBAWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 20:22:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:32942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236376AbhDBAWG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:22:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E31061132;
        Fri,  2 Apr 2021 00:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617322926;
        bh=cDkw8X6MzrvLYfxgSuMfhlLFUoD4Mr5br6gQaN2xqVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ozNjoOgc8jWAN/Fx70HDVKOfRgMtCif2nlFtzZuZz6BwBUnY3KkoaeU0mWqsZweMB
         0K2V8of+kK/BFzpYG5+0ymM2ZMO2bV5EwsGIwyybD8gfj2x7l9dK0G6d6c42rosrW3
         10vrUPkRWffz3UpX6ZJTMaDydc7wEsVFy5soDV0CvV3CTycnoPy6FIQgvUNJZylOrc
         Yy9RskkfbLuUNF1/BRceU4LkrTSx4LYX1qDr2DcfUHgI/r4pMHgezXzZQVp9hsxlqx
         3e36imwBL7X/sJcvQ4F2uKlDlYTwRtjrjX5qnbEGHl2HoSUZVm+XIFNgnEIKYtSSwV
         ermLvt8uflP6w==
Date:   Thu, 1 Apr 2021 17:22:06 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCHSET RFC v3 00/18] xfs: atomic file updates
Message-ID: <20210402002206.GF4090233@magnolia>
References: <161723932606.3149451.12366114306150243052.stgit@magnolia>
 <CAOQ4uxhPzTK=DvUxTGV0KXnqWNsumjm1UbSiFgXbdogbzyd29w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhPzTK=DvUxTGV0KXnqWNsumjm1UbSiFgXbdogbzyd29w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 06:56:20AM +0300, Amir Goldstein wrote:
> On Thu, Apr 1, 2021 at 4:14 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > Hi all,
> >
> > This series creates a new FIEXCHANGE_RANGE system call to exchange
> > ranges of bytes between two files atomically.  This new functionality
> > enables data storage programs to stage and commit file updates such that
> > reader programs will see either the old contents or the new contents in
> > their entirety, with no chance of torn writes.  A successful call
> > completion guarantees that the new contents will be seen even if the
> > system fails.
> >
> > User programs will be able to update files atomically by opening an
> > O_TMPFILE, reflinking the source file to it, making whatever updates
> > they want to make, and exchange the relevant ranges of the temp file
> > with the original file.  If the updates are aligned with the file block
> > size, a new (since v2) flag provides for exchanging only the written
> > areas.  Callers can arrange for the update to be rejected if the
> > original file has been changed.
> >
> > The intent behind this new userspace functionality is to enable atomic
> > rewrites of arbitrary parts of individual files.  For years, application
> > programmers wanting to ensure the atomicity of a file update had to
> > write the changes to a new file in the same directory, fsync the new
> > file, rename the new file on top of the old filename, and then fsync the
> > directory.  People get it wrong all the time, and $fs hacks abound.
> > Here is the proposed manual page:
> >
> 
> I like the idea of modernizing FIEXCHANGE_RANGE very much and
> I think that the improved implementation and new(?) flags will be very
> useful just the way you designed them, but maybe something to consider...
> 
> Taking a step back and ignoring the existing xfs ioctl, all the use cases
> that you listed actually want MOVE_RANGE not exchange range.
> No listed use case does anything with the old data except dump it in the
> trash bin. Right?

The three listed in the manpage don't do anything with the blocks.

However, there is usecase #4: online filesystem repair, where we want to
be able to construct a new metadata file/directory/xattr tree, exchange
the new contents with the old, and still have the old contents attached
to the file so that we can (very carefully) tear down the internal
buffer caches and other.  For /that/ use case, we require truncation to
be a separate step.

> I do realize that implementing atomic extent exchange was easier back
> when that ioctl was implemented for xfs and ext4 and I realize that
> deferring inode unlink was much simpler to implement than deferred
> extent freeing, but seeing how punch hole and dedupe range already
> need to deal with freeing target inode extents, it is not obvious to me that
> atomic freeing the target inode extents instead of exchange is a bad idea
> (given the appropriate opt-in flags).
> 
> Is there a good reason for keeping the "freeing old blocks with unlink"
> strategy the only option?

Making userspace take the extra step of deciding what to do with the
tempfile (and when!) after the operation reduces the amount of work that
has to be done in the hot path, since we know that the only work we need
to do is switch the mappings (and the reverse mappings).

If this became a move operation where we drop the file2 blocks, it would
be necessary to traverse the refcount btree to see if the blocks are
shared, update the refcount btree, and possibly update the free space
btrees as well.  The current design permits us to skip all that, which
is all the more useful if the operation is synchronous.

Consider also that inactivation of inodes will soon become a background
operation in XFS, which means that userspace soon won't even have to
wait for that part.

--D

> 
> Thanks,
> Amir.
