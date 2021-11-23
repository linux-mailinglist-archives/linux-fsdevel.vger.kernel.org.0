Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0B645AF52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 23:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhKWWsI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 17:48:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:50328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhKWWsH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 17:48:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D4E860E08;
        Tue, 23 Nov 2021 22:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637707498;
        bh=apee34MXKI+LZjgjf9uzsMo1wUjeOISK1i1Uo6DdTg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ENzZxhXwYuVRuQIRKLdFd2E1f+ow9lwphDIY/ejAFt7lChbgoit3FL+53tzQYp8MT
         ZYY/DVkeuQ7ZNBGtJLjDkJKl18zTypUnBPNWm8hwtAULj74FKHIU7yp40+2709t68r
         Weqv8xQPhO9B52JpWGOrxFKE4q4FHQgNr2BbJ+zYrDdg0nBWT8Ktft2GTzlYn7f6Tt
         t5m8WMAmWwCLvUc87Qv4UG0hcxjU1W0tFbt1992fi6Z8yeyfRp+dqs+NoWbyrRF1Vs
         OQO3zacQqlAhQMFMGNU5hpGwCeU1RhBh+9ihPD+PNK+6p8lLJ/i/bQs9U+2bd/WfNs
         Yh7HNRZ9qKpPQ==
Date:   Tue, 23 Nov 2021 14:44:57 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 17/29] fsdax: factor out a dax_memzero helper
Message-ID: <20211123224457.GL266024@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-18-hch@lst.de>
 <CAPcyv4imPgBEbhDCQpDwCQUTxOQy=RT9ZkAueBQdPKXOLNmrAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4imPgBEbhDCQpDwCQUTxOQy=RT9ZkAueBQdPKXOLNmrAQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 01:22:13PM -0800, Dan Williams wrote:
> On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Factor out a helper for the "manual" zeroing of a DAX range to clean
> > up dax_iomap_zero a lot.
> >
> 
> Small / optional fixup below:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/dax.c | 36 +++++++++++++++++++-----------------
> >  1 file changed, 19 insertions(+), 17 deletions(-)
> >
> > diff --git a/fs/dax.c b/fs/dax.c
> > index d7a923d152240..dc9ebeff850ab 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -1121,34 +1121,36 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
> >  }
> >  #endif /* CONFIG_FS_DAX_PMD */
> >
> > +static int dax_memzero(struct dax_device *dax_dev, pgoff_t pgoff,
> > +               unsigned int offset, size_t size)
> > +{
> > +       void *kaddr;
> > +       long rc;
> > +
> > +       rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
> > +       if (rc >= 0) {
> 
> Technically this should be "> 0" because dax_direct_access() returns
> nr_available_pages @pgoff, but this isn't broken because
> dax_direct_access() converts the "zero pages available" case into
> -ERANGE.

Agreed.  With that fixed,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
> > +               memset(kaddr + offset, 0, size);
> > +               dax_flush(dax_dev, kaddr + offset, size);
> > +       }
> > +       return rc;
> > +}
> > +
> >  s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
> >  {
> >         pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
> >         long rc, id;
> > -       void *kaddr;
> > -       bool page_aligned = false;
> >         unsigned offset = offset_in_page(pos);
> >         unsigned size = min_t(u64, PAGE_SIZE - offset, length);
> >
> > -       if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
> > -               page_aligned = true;
> > -
> >         id = dax_read_lock();
> > -
> > -       if (page_aligned)
> > +       if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
> >                 rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
> >         else
> > -               rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
> > -       if (rc < 0) {
> > -               dax_read_unlock(id);
> > -               return rc;
> > -       }
> > -
> > -       if (!page_aligned) {
> > -               memset(kaddr + offset, 0, size);
> > -               dax_flush(iomap->dax_dev, kaddr + offset, size);
> > -       }
> > +               rc = dax_memzero(iomap->dax_dev, pgoff, offset, size);
> >         dax_read_unlock(id);
> > +
> > +       if (rc < 0)
> > +               return rc;
> >         return size;
> >  }
> >
> > --
> > 2.30.2
> >
