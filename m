Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B074154C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 02:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbhIWApi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 20:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238678AbhIWApi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 20:45:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 439AF6103C;
        Thu, 23 Sep 2021 00:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632357847;
        bh=6AaMuTtJrmX5EWIwWH2nBQWt/Z5pFdF9Cej8r6bkXbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iNiWjuRUGONYgBRunffKHJxcQlH0vN8qFmIL7RjFv4mA3saud7MJx09X8Iy8MomAG
         Edif1uw6du4NZ0e9J5jtAMSHihZ1hS3CGllVIh4c9mlqNdhA4FLkvYKe9oBUJwV6NK
         nMwSAU5iCRRukzutO8bLP8SqijyuZE+/z7gZWbIXDi4c56XYLCuzXqNF9VIITSaezK
         k5Vf2AJHRotNzeVogWnOkK3CmHJjAP4ar7p9Sd3VYqB4CKBBkrzh0XGB6BN609Nifg
         Drm7AW9UTg74k2/C8G+R9xBEew4yo7V+2oq+bxqlF60dUNEtRiejnsXv+FYJjNThh2
         im0cfuxznL47g==
Date:   Wed, 22 Sep 2021 17:44:06 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/5] vfs: add a zero-initialization mode to fallocate
Message-ID: <20210923004406.GP570615@magnolia>
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
> 
> What if part of the region is shared?  If the goal is to make a read
> return zeroes, then the shared extent must be punched, right?  Should
> the new region be preallocated?
> 
> What if part of the region is unwritten?  Should zeroing convert that to
> written at the same time?  This isn't required to solve the problem, but
> "force the filesystem to write zeroes" implies that's required.  Should
> preallocation start converting unwritten extents too?
> 
> What if part of the region is sparse?  Preallocation should allocate a
> written extent, but that wasn't the problem I was focusing on.  Should
> zeroing preallocate a written extent?  This also isn't required to solve
> my problem, but this extension of the API definition implies this too.
> 
> What if part of the region is delalloc?  Should preallocation allocate a
> written extent here too?  Should zeroing?
> 
> For ALLOC|INITDATA, I think it suffices to map new written extents into
> holes with BMAPI_ZERO and do no more work than that.
> 
> For ZERO|INITDATA, I /think/ I can solve all of the above by writing
> zeroes to the page cache and then switching to regular preallocation to
> fill the holes.

No, because that will flood the page cache with zeroed pages, which will
blow out the cache and is only marginally better than pwrite, which has
already been denied.  That's right, that's why we wanted all these
fancier functions anywayh.

Ok so first we flush the page cache, then we walk the extent map to
unmap the shared extents and convert the unwritten extents to written
extents.  Then we can use blkdev_issue_zerooout and dax_zero_page_range
to convert the written etents to ...

That's too many times through the file mappings.

First flush the page cache, then loop through the mappings via
xfs_bmapi_read.  If the mapping is sparse, replace it with a
written/zeroed extent.  If the extent is unwritten, convert it to a
written/zeroed extent.  If the mapping is a shared, punch it and replace
it with a written/zeroed extent.  If the mapping is written, go call the
fancy functions directly, no iomappings needed or required.

And now I have to go do the smae for ext4, since we have no shared code
anymore.  Crazylevel now approaching 130%...

--D

> 
> --D
> 
> > > 
> > > /*
> > >  * For preallocation and zeroing operations, force the filesystem to
> > >  * write zeroes rather than use unwritten extents to indicate the
> > >  * range contains zeroes.
> > >  *
> > >  * For filesystems that support unwritten extents, this trades off
> > >  * slow fallocate performance for faster first write performance as
> > >  * unwritten extent conversion on the first write to each block in
> > >  * the range is not needed.
> > >  *
> > >  * Care is required when using FALLOC_FL_ALLOC_INIT_DATA as it will
> > >  * be much slower overall for large ranges and/or slow storage
> > >  * compared to using unwritten extents.
> > >  */
> > > #define FALLOC_FL_ALLOC_INIT_DATA	(1 << 7)
> > 
> > I prefer FALLOC_FL_ZEROINIT_DATA here, because in the ZERO|INIT case
> > we're not allocating any new space, merely rewriting existing storage.
> > I also want to expand the description slightly:
> > 
> > /*
> >  * For preallocation, force the filesystem to write zeroes rather than
> >  * use unwritten extents to indicate the range contains zeroes.  For
> >  * zeroing operations, force the filesystem to write zeroes to existing
> >  * written extents.
> > 
> > --D
> > 
> > > 
> > > Cheers,
> > > 
> > > Dave.
> > > 
> > > -- 
> > > Dave Chinner
> > > david@fromorbit.com
