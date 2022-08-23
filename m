Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62ED759EFAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 01:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiHWXZo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 19:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiHWXZn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 19:25:43 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7FEF6C758;
        Tue, 23 Aug 2022 16:25:41 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-4-169.pa.nsw.optusnet.com.au [49.195.4.169])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 7E4BF10E8BB3;
        Wed, 24 Aug 2022 09:25:38 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oQdH7-00Gk4y-2O; Wed, 24 Aug 2022 09:25:37 +1000
Date:   Wed, 24 Aug 2022 09:25:37 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: [PATCH] iversion: update comments with info about atime updates
Message-ID: <20220823232537.GP3600936@dread.disaster.area>
References: <20220822133309.86005-1-jlayton@kernel.org>
 <ceb8f09a4cb2de67f40604d03ee0c475feb3130a.camel@linux.ibm.com>
 <f17b9d627703bee2a7b531a051461671648a9dbd.camel@kernel.org>
 <18827b350fbf6719733fda814255ec20d6dcf00f.camel@linux.ibm.com>
 <4cc84440d954c022d0235bf407a60da66a6ccc39.camel@kernel.org>
 <20220822233231.GJ3600936@dread.disaster.area>
 <6cbcb33d33613f50dd5e485ecbf6ce7e305f3d6f.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cbcb33d33613f50dd5e485ecbf6ce7e305f3d6f.camel@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=630561f4
        a=FOdsZBbW/tHyAhIVFJ0pRA==:117 a=FOdsZBbW/tHyAhIVFJ0pRA==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=uZvujYp8AAAA:8 a=7-415B0cAAAA:8
        a=Jyd9joZ7I2SB2ChvZHUA:9 a=CjuIK1q_8ugA:10 a=SLzB8X_8jTLwj6mN0q5r:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 23, 2022 at 07:21:36AM -0400, Jeff Layton wrote:
> On Tue, 2022-08-23 at 09:32 +1000, Dave Chinner wrote:
> > On Mon, Aug 22, 2022 at 02:22:20PM -0400, Jeff Layton wrote:
> > > diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> > > index 3bfebde5a1a6..524abd372100 100644
> > > --- a/include/linux/iversion.h
> > > +++ b/include/linux/iversion.h
> > > @@ -9,8 +9,8 @@
> > >   * ---------------------------
> > >   * The change attribute (i_version) is mandated by NFSv4 and is mostly for
> > >   * knfsd, but is also used for other purposes (e.g. IMA). The i_version must
> > > - * appear different to observers if there was a change to the inode's data or
> > > - * metadata since it was last queried.
> > > + * appear different to observers if there was an explicit change to the inode's
> > > + * data or metadata since it was last queried.
> > >   *
> > >   * Observers see the i_version as a 64-bit number that never decreases. If it
> > >   * remains the same since it was last checked, then nothing has changed in the
> > > @@ -18,6 +18,13 @@
> > >   * anything about the nature or magnitude of the changes from the value, only
> > >   * that the inode has changed in some fashion.
> > >   *
> > > + * Note that atime updates due to reads or similar activity do not represent
> > 
> > What does "or similar activity" mean?
> > 
> 
> Some examples:
> 
> - readdir() in a directory
> - readlink() on symlink
> - mmap reads
> 
> ...basically, things that access data without materially changing it.

What happens if we have buffered dirty data in the page cache, and a
DIO read is done at that location?

This doesn't materially change data, but it forces writeback of the
cached data, and that means XFS will bump iversion because of the
data writeback changing inode metadata.

i can think of several scenarios where a pure data access operation
that does not materially change user data but will cause an iversion
change because those access operations imply some level of data
persistence.

> > In case you didn't realise, XFS can bump iversion 500+ times for a
> > single 1MB write() on a 4kB block size filesytem, and only one of
> > them is initial write() system call that copies the data into the
> > page cache. The other 500+ are all the extent allocation and
> > manipulation transactions that we might run when persisting the data
> > to disk tens of seconds later. This is how iversion on XFS has
> > behaved for the past decade.
> > 
> 
> Bumping the change count multiple times internally for a single change
> is not a problem. From the comments in iversion.h:
> 
>  * Observers see the i_version as a 64-bit number that never decreases. If it
>  * remains the same since it was last checked, then nothing has changed in the
>  * inode. If it's different then something has changed. Observers cannot infer
>  * anything about the nature or magnitude of the changes from the value, only
>  * that the inode has changed in some fashion.
> 
> Bumping it once or multiple times still conforms to how we have this
> defined.

Sure, it conforms to this piece of the specification. But the
temporal aspect of the filesystem bumping iversion due to background
operations most definitely conflicts with the new definition of
iversion only changing when operations that change c/mtime are
performed.

i.e.  if we're to take the "iversion changes only when c/mtime is
changed" definition at face value, then the filesystem is not free
to modify iversion when it modifies metadata during background
writeback. It's not free to bump iversion during fsync(). i.e. it's
not free to bump iversion on any operation that implies data
writeback is necessary.

That makes the existing XFS di_changecount implementation
incompatible with the newly redefined iversion semantics being
pushed and wanting to be exposed to userspace. If the filesystem
implementation can't meet the specification of the change attribute
being exposed to userspace then we *must not expose that information
to userspace*.

This restriction does not prevent us from using our existing
iversion implementation for NFS and IMA because the worst that
happens is users occasionally have to refetch information from the
server as has already been occurring for the past decade or so.
Indeed, there's an argument to be made that the periodic IMA
revalidation that relatime + iversion causes for the data at rest in
the page cache is actually a good security practice and not a
behaviour that we should be trying to optimise away.

All I want from this process is a *solid definition* of what
iversion is supposed to represent and what will be exposed to
userspace and the ability for the filesystem to decide itself
whether to expose it's persistent change counter to userspace. Us
filesystem developers can take it from there to provide a change
attribute that conforms to the contract we form with userspace by
exposing this information to statx().

> > Either way we chose, one of these options are the only way that we
> > will end up with a consistent implementation of a change counter
> > across all the filesystems. And, quite frankly, that's exactly is
> > needed if we are going to present this information to userspace
> > forever more.
> > 
> 
> I agree that we need a real definition of what changes should be
> represented in this value. My intent was to add that to the statx
> manpage once we had gotten a little further along, but it won't hurt to
> hash that out first.

How have so many experienced engineers forgotten basic engineering
processes they were taught as an undergrad? i.e. that requirements
and specification come first, then the implementation is derived
from the specification?

And why do they keep "forgetting" this over and over again?

> I do not intend to exhaustively list all possible activities that should
> and shouldn't update the i_version. It's as difficult to put together a
> comprehensive list of what activities should and shouldn't change the
> i_version as it is to list what activities should and shouldn't cause
> the mtime/ctime/atime to change. The list is also going to constantly
> change as our interfaces change.

If this change attribute is not going to specified in a way that
userspace cannot rely on it's behaviour not changing in incompatible
ways, then it should not be exposed to userspace at all. Both
userspace and the filesystems need an unambiguous definition so that
userspace applications can rely on the behaviour that the kernel
and filesystems guarantee will be provided.

> What may be best is to just define this value in terms of how timestamps
> get updated, since POSIX already specifies that. Section 4.9 in the
> POSIX spec discusses file time updates:
> 
>     https://pubs.opengroup.org/onlinepubs/9699919799/
> 
> It says:
> 
> "Each function or utility in POSIX.1-2017 that reads or writes data
> (even if the data does not change) or performs an operation to change
> file status (even if the file status does not change) indicates which of
> the appropriate timestamps shall be marked for update."
> 
> So, we can refer to that and simply say:
> 
> "If the function updates the mtime or ctime on the inode, then the
> i_version should be incremented. If only the atime is being updated,
> then the i_version should not be incremented. The exception to this rule
> is explicit atime updates via utimes() or similar mechanism, which
> should result in the i_version being incremented."

I'd almost be fine with that definition for iversion being exposed
to userspace, but it doesn't say anything about metadata changes
that don't change c/mtime. i.e. this needs to define iversion as
"_Only_ operations that modify user data and/or c/mtime on the inode
should increment the change attribute", not leave it ambiguous as to
whether other operations can bump the change attribute or not.

Of course, this new iversion deinition is most definitely
incompatible with the existing specification of the XFS persistent
change attribute.....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
