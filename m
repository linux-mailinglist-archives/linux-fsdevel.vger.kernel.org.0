Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B5F415460
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 02:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238590AbhIWAE0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 20:04:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230414AbhIWAE0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 20:04:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F52161040;
        Thu, 23 Sep 2021 00:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632355375;
        bh=Q5q55uzYbOYX5edySLxCvRz2fFYYJx6Y5Pae3Gu8YB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rNxJ4w/1zVSMcwwR3VITjv9z0pWLYmhJkHG0Ou5Mj+cHthYkdwQ6B9bg0AitV/2Wm
         kdYG/GmSyERoEd3id1QffMcHb3uvK4FaYLBdettu3Wdi9Wk5iZNu+qX1lBcNQP/8zI
         HX/UrSkwHQw1FUBZWhsFAkr6+RfiNedxuFomOHwjN++T0YbDS/6miWTz1o6wlXaghs
         r4SNb2rqLovB8bnFg2q7EpONjHvOKaBhzGjjPFlZxUnjj5YEaUN+PleqCKTIqHQp9U
         bYCr+EK95rBzPJDnBkoYfP7O0OCI3sPEHWqFY2J6oOZwJvScKfIfTCbPh7CMkASeOm
         +dgFyZpQGOKbQ==
Date:   Wed, 22 Sep 2021 17:02:55 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/5] vfs: add a zero-initialization mode to fallocate
Message-ID: <20210923000255.GO570615@magnolia>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
 <163192866125.417973.7293598039998376121.stgit@magnolia>
 <20210921004431.GO1756565@dread.disaster.area>
 <YUmYbxW70Ub2ytOc@infradead.org>
 <CAPcyv4jF1UNW5rdXX3q2hfDcvzGLSnk=1a0C0i7_UjdivuG+pQ@mail.gmail.com>
 <20210922023801.GD570615@magnolia>
 <20210922035907.GR1756565@dread.disaster.area>
 <20210922041354.GE570615@magnolia>
 <20210922054931.GT1756565@dread.disaster.area>
 <20210922212725.GN570615@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922212725.GN570615@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 02:27:25PM -0700, Darrick J. Wong wrote:
> On Wed, Sep 22, 2021 at 03:49:31PM +1000, Dave Chinner wrote:
> > On Tue, Sep 21, 2021 at 09:13:54PM -0700, Darrick J. Wong wrote:
> > > On Wed, Sep 22, 2021 at 01:59:07PM +1000, Dave Chinner wrote:
> > > > On Tue, Sep 21, 2021 at 07:38:01PM -0700, Darrick J. Wong wrote:
> > > > > On Tue, Sep 21, 2021 at 07:16:26PM -0700, Dan Williams wrote:
> > > > > > On Tue, Sep 21, 2021 at 1:32 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > > > > >
> > > > > > > On Tue, Sep 21, 2021 at 10:44:31AM +1000, Dave Chinner wrote:
> > > > > > > > I think this wants to be a behavioural modifier for existing
> > > > > > > > operations rather than an operation unto itself. i.e. similar to how
> > > > > > > > KEEP_SIZE modifies ALLOC behaviour but doesn't fundamentally alter
> > > > > > > > the guarantees ALLOC provides userspace.
> > > > > > > >
> > > > > > > > In this case, the change of behaviour over ZERO_RANGE is that we
> > > > > > > > want physical zeros to be written instead of the filesystem
> > > > > > > > optimising away the physical zeros by manipulating the layout
> > > > > > > > of the file.
> > > > > > >
> > > > > > > Yes.
> > > > > > >
> > > > > > > > Then we have and API that looks like:
> > > > > > > >
> > > > > > > >       ALLOC           - allocate space efficiently
> > > > > > > >       ALLOC | INIT    - allocate space by writing zeros to it
> > > > > > > >       ZERO            - zero data and preallocate space efficiently
> > > > > > > >       ZERO | INIT     - zero range by writing zeros to it
> > > > > > > >
> > > > > > > > Which seems to cater for all the cases I know of where physically
> > > > > > > > writing zeros instead of allocating unwritten extents is the
> > > > > > > > preferred behaviour of fallocate()....
> > > > > > >
> > > > > > > Agreed.  I'm not sure INIT is really the right name, but I can't come
> > > > > > > up with a better idea offhand.
> > > > > > 
> > > > > > FUA? As in, this is a forced-unit-access zeroing all the way to media
> > > > > > bypassing any mechanisms to emulate zero-filled payloads on future
> > > > > > reads.
> > > > 
> > > > Yes, that's the semantic we want, but FUA already defines specific
> > > > data integrity behaviour in the storage stack w.r.t. volatile
> > > > caches.
> > > > 
> > > > Also, FUA is associated with devices - it's low level storage jargon
> > > > and so is not really appropriate to call a user interface operation
> > > > FUA where users have no idea what a "unit" or "access" actually
> > > > means.
> > > > 
> > > > Hence we should not overload this name with some other operation
> > > > that does not have (and should not have) explicit data integrity
> > > > requirements. That will just cause confusion for everyone.
> > > > 
> > > > > FALLOC_FL_ZERO_EXISTING, because you want to zero the storage that
> > > > > already exists at that file range?
> > > > 
> > > > IMO that doesn't work as a behavioural modifier for ALLOC because
> > > > the ALLOC semantics are explicitly "don't touch existing user
> > > > data"...
> > > 
> > > Well since you can't preallocate /and/ zerorange at the same time...
> > > 
> > > /* For FALLOC_FL_ZERO_RANGE, write zeroes to pre-existing mapped storage. */
> > > #define FALLOC_FL_ZERO_EXISTING		(0x80)
> > 
> > Except we also want the newly allocated regions (i.e. where holes
> > were) in that range being zeroed to have zeroes written to them as
> > well, yes? Otherwise we end up with a combination of unwritten
> > extents and physical zeroes, and you can't use
> > ZERORANGE|EXISTING as a replacement for PUNCH + ALLOC|INIT

Ooookay.  This is drifting further from the original problem of wanting
to write a buffer of zeroes to an already-mapped extent.

What if part of the region is shared?  If the goal is to make a read
return zeroes, then the shared extent must be punched, right?  Should
the new region be preallocated?

What if part of the region is unwritten?  Should zeroing convert that to
written at the same time?  This isn't required to solve the problem, but
"force the filesystem to write zeroes" implies that's required.  Should
preallocation start converting unwritten extents too?

What if part of the region is sparse?  Preallocation should allocate a
written extent, but that wasn't the problem I was focusing on.  Should
zeroing preallocate a written extent?  This also isn't required to solve
my problem, but this extension of the API definition implies this too.

What if part of the region is delalloc?  Should preallocation allocate a
written extent here too?  Should zeroing?

For ALLOC|INITDATA, I think it suffices to map new written extents into
holes with BMAPI_ZERO and do no more work than that.

For ZERO|INITDATA, I /think/ I can solve all of the above by writing
zeroes to the page cache and then switching to regular preallocation to
fill the holes.

--D

> > 
> > /*
> >  * For preallocation and zeroing operations, force the filesystem to
> >  * write zeroes rather than use unwritten extents to indicate the
> >  * range contains zeroes.
> >  *
> >  * For filesystems that support unwritten extents, this trades off
> >  * slow fallocate performance for faster first write performance as
> >  * unwritten extent conversion on the first write to each block in
> >  * the range is not needed.
> >  *
> >  * Care is required when using FALLOC_FL_ALLOC_INIT_DATA as it will
> >  * be much slower overall for large ranges and/or slow storage
> >  * compared to using unwritten extents.
> >  */
> > #define FALLOC_FL_ALLOC_INIT_DATA	(1 << 7)
> 
> I prefer FALLOC_FL_ZEROINIT_DATA here, because in the ZERO|INIT case
> we're not allocating any new space, merely rewriting existing storage.
> I also want to expand the description slightly:
> 
> /*
>  * For preallocation, force the filesystem to write zeroes rather than
>  * use unwritten extents to indicate the range contains zeroes.  For
>  * zeroing operations, force the filesystem to write zeroes to existing
>  * written extents.
> 
> --D
> 
> > 
> > Cheers,
> > 
> > Dave.
> > 
> > -- 
> > Dave Chinner
> > david@fromorbit.com
