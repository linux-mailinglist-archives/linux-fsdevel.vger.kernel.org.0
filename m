Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C301D41552D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 03:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238816AbhIWBnt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 21:43:49 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:41624 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238792AbhIWBns (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 21:43:48 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 502E7882FA3;
        Thu, 23 Sep 2021 11:42:10 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mTDkX-00Fcma-RT; Thu, 23 Sep 2021 11:42:09 +1000
Date:   Thu, 23 Sep 2021 11:42:09 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/5] vfs: add a zero-initialization mode to fallocate
Message-ID: <20210923014209.GW1756565@dread.disaster.area>
References: <163192866125.417973.7293598039998376121.stgit@magnolia>
 <20210921004431.GO1756565@dread.disaster.area>
 <YUmYbxW70Ub2ytOc@infradead.org>
 <CAPcyv4jF1UNW5rdXX3q2hfDcvzGLSnk=1a0C0i7_UjdivuG+pQ@mail.gmail.com>
 <20210922023801.GD570615@magnolia>
 <20210922035907.GR1756565@dread.disaster.area>
 <20210922041354.GE570615@magnolia>
 <20210922054931.GT1756565@dread.disaster.area>
 <20210922212725.GN570615@magnolia>
 <20210923000255.GO570615@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923000255.GO570615@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=WjIn9byAL2JteWmGqe4A:9 a=CjuIK1q_8ugA:10 a=igBNqPyMv6gA:10
        a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 05:02:55PM -0700, Darrick J. Wong wrote:
> On Wed, Sep 22, 2021 at 02:27:25PM -0700, Darrick J. Wong wrote:
> > On Wed, Sep 22, 2021 at 03:49:31PM +1000, Dave Chinner wrote:
> > > On Tue, Sep 21, 2021 at 09:13:54PM -0700, Darrick J. Wong wrote:
> > > > On Wed, Sep 22, 2021 at 01:59:07PM +1000, Dave Chinner wrote:
> > > > > On Tue, Sep 21, 2021 at 07:38:01PM -0700, Darrick J. Wong wrote:
> > > > > > On Tue, Sep 21, 2021 at 07:16:26PM -0700, Dan Williams wrote:
> > > > > > > On Tue, Sep 21, 2021 at 1:32 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > > > > > >
> > > > > > > > On Tue, Sep 21, 2021 at 10:44:31AM +1000, Dave Chinner wrote:
> > > > > > > > > I think this wants to be a behavioural modifier for existing
> > > > > > > > > operations rather than an operation unto itself. i.e. similar to how
> > > > > > > > > KEEP_SIZE modifies ALLOC behaviour but doesn't fundamentally alter
> > > > > > > > > the guarantees ALLOC provides userspace.
> > > > > > > > >
> > > > > > > > > In this case, the change of behaviour over ZERO_RANGE is that we
> > > > > > > > > want physical zeros to be written instead of the filesystem
> > > > > > > > > optimising away the physical zeros by manipulating the layout
> > > > > > > > > of the file.
> > > > > > > >
> > > > > > > > Yes.
> > > > > > > >
> > > > > > > > > Then we have and API that looks like:
> > > > > > > > >
> > > > > > > > >       ALLOC           - allocate space efficiently
> > > > > > > > >       ALLOC | INIT    - allocate space by writing zeros to it
> > > > > > > > >       ZERO            - zero data and preallocate space efficiently
> > > > > > > > >       ZERO | INIT     - zero range by writing zeros to it
> > > > > > > > >
> > > > > > > > > Which seems to cater for all the cases I know of where physically
> > > > > > > > > writing zeros instead of allocating unwritten extents is the
> > > > > > > > > preferred behaviour of fallocate()....
> > > > > > > >
> > > > > > > > Agreed.  I'm not sure INIT is really the right name, but I can't come
> > > > > > > > up with a better idea offhand.
> > > > > > > 
> > > > > > > FUA? As in, this is a forced-unit-access zeroing all the way to media
> > > > > > > bypassing any mechanisms to emulate zero-filled payloads on future
> > > > > > > reads.
> > > > > 
> > > > > Yes, that's the semantic we want, but FUA already defines specific
> > > > > data integrity behaviour in the storage stack w.r.t. volatile
> > > > > caches.
> > > > > 
> > > > > Also, FUA is associated with devices - it's low level storage jargon
> > > > > and so is not really appropriate to call a user interface operation
> > > > > FUA where users have no idea what a "unit" or "access" actually
> > > > > means.
> > > > > 
> > > > > Hence we should not overload this name with some other operation
> > > > > that does not have (and should not have) explicit data integrity
> > > > > requirements. That will just cause confusion for everyone.
> > > > > 
> > > > > > FALLOC_FL_ZERO_EXISTING, because you want to zero the storage that
> > > > > > already exists at that file range?
> > > > > 
> > > > > IMO that doesn't work as a behavioural modifier for ALLOC because
> > > > > the ALLOC semantics are explicitly "don't touch existing user
> > > > > data"...
> > > > 
> > > > Well since you can't preallocate /and/ zerorange at the same time...
> > > > 
> > > > /* For FALLOC_FL_ZERO_RANGE, write zeroes to pre-existing mapped storage. */
> > > > #define FALLOC_FL_ZERO_EXISTING		(0x80)
> > > 
> > > Except we also want the newly allocated regions (i.e. where holes
> > > were) in that range being zeroed to have zeroes written to them as
> > > well, yes? Otherwise we end up with a combination of unwritten
> > > extents and physical zeroes, and you can't use
> > > ZERORANGE|EXISTING as a replacement for PUNCH + ALLOC|INIT
> 
> Ooookay.  This is drifting further from the original problem of wanting
> to write a buffer of zeroes to an already-mapped extent.

Yup, that's because fallocate() is a multiplexed set of generic
operations. Adding one-off functionality for a specific use case
ends up breaking down the problem into how it maps as a generic
operation to the rest of the functionality that fallocate()
provides.

Please don't get frustrated here - the discussion needs to be had as
to why fallocate() is the wrong place to be managing *storage
hardware state* - the API and scope creep once the operation is
broken down to a generic behaviour demonstrate this clearly.

> What if part of the region is shared?  If the goal is to make a read
> return zeroes, then the shared extent must be punched, right?  Should
> the new region be preallocated?

[....]

These are implementation details once the API has been defined.

And, yes, I agree, it's nuts that just adding "DAX clear poison"
effectively degenerates into "rewrite the entire fallocate()
implementation in XFS", but that's what adding "write physical
zeroes rather than minimising IO overhead" semantics to generic
fallocate() operations results in.

Fundamentally, fallocate() is not for managing storage hardware
state. It's for optimising away bulk data operations by replacing
them with fast filesystem metadata manipulations and/or hardware
acceleration of the bulk data operation.

So, given that for clearing pmem hardware poison, we already know
it requires writing zeros to the poisoned range and where
in the file that we need to write zeroes to. So what exactly is the
problem with doing this:

	iov.iov_base = zero_buf;
	iov.iov_len = zero_len;
	pwritev2(fd, &iov, 1, zero_offset, RWF_SYNC | RWF_CLEAR_HWERRORS);

Where RWF_CLEAR_HWERRORS tells the low level hardware IO code to
clear error states before performing the write of the user data
provided?

The API doesn't get much simpler or explict, and the
RWF_CLEAR_HWERRORS flag is trivial to propagate all the way down
into the DAX IO code where it can be performed appropriately before
performing the write of the new user data into that range. And it's
way simpler than plumbing this sort of things into fallocate().


We need an API that provides a one-off, single data write semantic
to be defined and implemented to manage pmem hardware state. We
already have that in pwritev2().

Hence this discussion leads me to conclude that fallocate() simply
isn't the right interface to clear storage hardware poison state and
it's much simpler for everyone - kernel and userspace - to provide a
pwritev2(RWF_CLEAR_HWERROR) flag to directly instruct the IO path to
clear hardware error state before issuing this user write to the
hardware.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
