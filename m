Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33031414056
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 06:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhIVEPY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 00:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhIVEPY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 00:15:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E144C61131;
        Wed, 22 Sep 2021 04:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632284035;
        bh=8D1IagfIKZeKbgZvrNFVsValHcrqDaHRd1Ma/26N9ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EtPhBWn41/0ih90TiHFm4j+Xd743V8njMjzEngPPd3WAdmt305OyTGs4VJRQTe9hG
         b8rkay02SczcNowdnMj/lBr7JtzNO1RewwMPMFcR9pyCWU80s0zniAsyXfxbkfnrbF
         0O+gyIO3aBlG5JiT0ET9JmkIgbfKw+c9M4brc9jsy7L65V+BeOC2fXqR7Cyxa+vr56
         H4/tDCkEE2eqhGw7cPIiRUsVBb1YN6HkQz7koY1nsBalzlyCe5pGZAaDm9t4NJHQt9
         9HcNKjEeVngs0MQHZN9oRx/h+guvmibU9rMsEwWnRIH/FWu+OpkcVEzMp7c69j7BkN
         1igj5DGbzNqoQ==
Date:   Tue, 21 Sep 2021 21:13:54 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/5] vfs: add a zero-initialization mode to fallocate
Message-ID: <20210922041354.GE570615@magnolia>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
 <163192866125.417973.7293598039998376121.stgit@magnolia>
 <20210921004431.GO1756565@dread.disaster.area>
 <YUmYbxW70Ub2ytOc@infradead.org>
 <CAPcyv4jF1UNW5rdXX3q2hfDcvzGLSnk=1a0C0i7_UjdivuG+pQ@mail.gmail.com>
 <20210922023801.GD570615@magnolia>
 <20210922035907.GR1756565@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922035907.GR1756565@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 01:59:07PM +1000, Dave Chinner wrote:
> On Tue, Sep 21, 2021 at 07:38:01PM -0700, Darrick J. Wong wrote:
> > On Tue, Sep 21, 2021 at 07:16:26PM -0700, Dan Williams wrote:
> > > On Tue, Sep 21, 2021 at 1:32 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > >
> > > > On Tue, Sep 21, 2021 at 10:44:31AM +1000, Dave Chinner wrote:
> > > > > I think this wants to be a behavioural modifier for existing
> > > > > operations rather than an operation unto itself. i.e. similar to how
> > > > > KEEP_SIZE modifies ALLOC behaviour but doesn't fundamentally alter
> > > > > the guarantees ALLOC provides userspace.
> > > > >
> > > > > In this case, the change of behaviour over ZERO_RANGE is that we
> > > > > want physical zeros to be written instead of the filesystem
> > > > > optimising away the physical zeros by manipulating the layout
> > > > > of the file.
> > > >
> > > > Yes.
> > > >
> > > > > Then we have and API that looks like:
> > > > >
> > > > >       ALLOC           - allocate space efficiently
> > > > >       ALLOC | INIT    - allocate space by writing zeros to it
> > > > >       ZERO            - zero data and preallocate space efficiently
> > > > >       ZERO | INIT     - zero range by writing zeros to it
> > > > >
> > > > > Which seems to cater for all the cases I know of where physically
> > > > > writing zeros instead of allocating unwritten extents is the
> > > > > preferred behaviour of fallocate()....
> > > >
> > > > Agreed.  I'm not sure INIT is really the right name, but I can't come
> > > > up with a better idea offhand.
> > > 
> > > FUA? As in, this is a forced-unit-access zeroing all the way to media
> > > bypassing any mechanisms to emulate zero-filled payloads on future
> > > reads.
> 
> Yes, that's the semantic we want, but FUA already defines specific
> data integrity behaviour in the storage stack w.r.t. volatile
> caches.
> 
> Also, FUA is associated with devices - it's low level storage jargon
> and so is not really appropriate to call a user interface operation
> FUA where users have no idea what a "unit" or "access" actually
> means.
> 
> Hence we should not overload this name with some other operation
> that does not have (and should not have) explicit data integrity
> requirements. That will just cause confusion for everyone.
> 
> > FALLOC_FL_ZERO_EXISTING, because you want to zero the storage that
> > already exists at that file range?
> 
> IMO that doesn't work as a behavioural modifier for ALLOC because
> the ALLOC semantics are explicitly "don't touch existing user
> data"...

Well since you can't preallocate /and/ zerorange at the same time...

/* For FALLOC_FL_ZERO_RANGE, write zeroes to pre-existing mapped storage. */
#define FALLOC_FL_ZERO_EXISTING		(0x80)

/* For preallocation, allocate written extents and set the contents to
 * zeroes. */
#define FALLOC_FL_ALLOC_WRITE_ZEROES	(0x80)

--D

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
