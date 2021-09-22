Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EBF413F87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 04:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhIVCjb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 22:39:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229644AbhIVCjb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 22:39:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 070E261184;
        Wed, 22 Sep 2021 02:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632278282;
        bh=o0xTvVAAlxGYjHg2mWOMUzL4Sh++CYYDs0N2OMgy4tY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=opSjAt7DT3ngxcwKBLYz9jVBe/5KNdVAMgd4otBh142Fjx5K8LjUDfRFt6r39n6PT
         nT4UnE5MF4ydmKIWOVTIyJbXX3bebYWVj6jz34iY1/qCa6ufuPf7Tm2VIpcYSPQwot
         HRZWxgbKWDPR5Lisp155N0pqGU/kJ5CWUZijDF39Kw1fGsbAclpoddBCQXnfcTetgc
         Y0QP6Kg8Ld3YqFSxlxyzyl4I9MDEuhmaHnZpImSqjzb4eSpxNTE0EKmSt4PAE/f6Fe
         1+r8fqu8wEiyOlSXRy6IZJZQvTgB2IyeDZIC9qaQtMcGvOP+zUk4YKLg1waQsS3AC7
         KAR3gLOzGVS5A==
Date:   Tue, 21 Sep 2021 19:38:01 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jane Chu <jane.chu@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/5] vfs: add a zero-initialization mode to fallocate
Message-ID: <20210922023801.GD570615@magnolia>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
 <163192866125.417973.7293598039998376121.stgit@magnolia>
 <20210921004431.GO1756565@dread.disaster.area>
 <YUmYbxW70Ub2ytOc@infradead.org>
 <CAPcyv4jF1UNW5rdXX3q2hfDcvzGLSnk=1a0C0i7_UjdivuG+pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jF1UNW5rdXX3q2hfDcvzGLSnk=1a0C0i7_UjdivuG+pQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 07:16:26PM -0700, Dan Williams wrote:
> On Tue, Sep 21, 2021 at 1:32 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, Sep 21, 2021 at 10:44:31AM +1000, Dave Chinner wrote:
> > > I think this wants to be a behavioural modifier for existing
> > > operations rather than an operation unto itself. i.e. similar to how
> > > KEEP_SIZE modifies ALLOC behaviour but doesn't fundamentally alter
> > > the guarantees ALLOC provides userspace.
> > >
> > > In this case, the change of behaviour over ZERO_RANGE is that we
> > > want physical zeros to be written instead of the filesystem
> > > optimising away the physical zeros by manipulating the layout
> > > of the file.
> >
> > Yes.
> >
> > > Then we have and API that looks like:
> > >
> > >       ALLOC           - allocate space efficiently
> > >       ALLOC | INIT    - allocate space by writing zeros to it
> > >       ZERO            - zero data and preallocate space efficiently
> > >       ZERO | INIT     - zero range by writing zeros to it
> > >
> > > Which seems to cater for all the cases I know of where physically
> > > writing zeros instead of allocating unwritten extents is the
> > > preferred behaviour of fallocate()....
> >
> > Agreed.  I'm not sure INIT is really the right name, but I can't come
> > up with a better idea offhand.
> 
> FUA? As in, this is a forced-unit-access zeroing all the way to media
> bypassing any mechanisms to emulate zero-filled payloads on future
> reads.

FALLOC_FL_ZERO_EXISTING, because you want to zero the storage that
already exists at that file range?

--D
