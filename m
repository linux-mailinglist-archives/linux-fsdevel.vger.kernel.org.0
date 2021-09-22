Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11177414040
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 05:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhIVEAk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 00:00:40 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:57947 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229495AbhIVEAk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 00:00:40 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id E9EA882B8F7;
        Wed, 22 Sep 2021 13:59:08 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mStPX-00FHVg-Lw; Wed, 22 Sep 2021 13:59:07 +1000
Date:   Wed, 22 Sep 2021 13:59:07 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/5] vfs: add a zero-initialization mode to fallocate
Message-ID: <20210922035907.GR1756565@dread.disaster.area>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
 <163192866125.417973.7293598039998376121.stgit@magnolia>
 <20210921004431.GO1756565@dread.disaster.area>
 <YUmYbxW70Ub2ytOc@infradead.org>
 <CAPcyv4jF1UNW5rdXX3q2hfDcvzGLSnk=1a0C0i7_UjdivuG+pQ@mail.gmail.com>
 <20210922023801.GD570615@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922023801.GD570615@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=xmlU4e8TyVmWEsWLSGMA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 07:38:01PM -0700, Darrick J. Wong wrote:
> On Tue, Sep 21, 2021 at 07:16:26PM -0700, Dan Williams wrote:
> > On Tue, Sep 21, 2021 at 1:32 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Tue, Sep 21, 2021 at 10:44:31AM +1000, Dave Chinner wrote:
> > > > I think this wants to be a behavioural modifier for existing
> > > > operations rather than an operation unto itself. i.e. similar to how
> > > > KEEP_SIZE modifies ALLOC behaviour but doesn't fundamentally alter
> > > > the guarantees ALLOC provides userspace.
> > > >
> > > > In this case, the change of behaviour over ZERO_RANGE is that we
> > > > want physical zeros to be written instead of the filesystem
> > > > optimising away the physical zeros by manipulating the layout
> > > > of the file.
> > >
> > > Yes.
> > >
> > > > Then we have and API that looks like:
> > > >
> > > >       ALLOC           - allocate space efficiently
> > > >       ALLOC | INIT    - allocate space by writing zeros to it
> > > >       ZERO            - zero data and preallocate space efficiently
> > > >       ZERO | INIT     - zero range by writing zeros to it
> > > >
> > > > Which seems to cater for all the cases I know of where physically
> > > > writing zeros instead of allocating unwritten extents is the
> > > > preferred behaviour of fallocate()....
> > >
> > > Agreed.  I'm not sure INIT is really the right name, but I can't come
> > > up with a better idea offhand.
> > 
> > FUA? As in, this is a forced-unit-access zeroing all the way to media
> > bypassing any mechanisms to emulate zero-filled payloads on future
> > reads.

Yes, that's the semantic we want, but FUA already defines specific
data integrity behaviour in the storage stack w.r.t. volatile
caches.

Also, FUA is associated with devices - it's low level storage jargon
and so is not really appropriate to call a user interface operation
FUA where users have no idea what a "unit" or "access" actually
means.

Hence we should not overload this name with some other operation
that does not have (and should not have) explicit data integrity
requirements. That will just cause confusion for everyone.

> FALLOC_FL_ZERO_EXISTING, because you want to zero the storage that
> already exists at that file range?

IMO that doesn't work as a behavioural modifier for ALLOC because
the ALLOC semantics are explicitly "don't touch existing user
data"...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
