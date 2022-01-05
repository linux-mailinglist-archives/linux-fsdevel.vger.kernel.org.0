Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8571E4858BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 19:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243233AbiAES4b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 13:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiAES4a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:56:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F5CC061245;
        Wed,  5 Jan 2022 10:56:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3696B81D4B;
        Wed,  5 Jan 2022 18:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B731BC36AE9;
        Wed,  5 Jan 2022 18:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641408986;
        bh=+lhyYYxqhQchytTaVh6hDELurF3goq+jLcvvULmiIlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XZbLpxDlBq1i+sdR5C+JXmOXrZQDt509Snvl2pRnME2BgzJZvC539B1OPK3ItGSkw
         CspEBWGKU4XmYzROgUQ/8qcubbGL2OErqgri6uqYSxiTCthl5NIoYISGvWb3IISmOt
         voz/2QGL3A5SqEoHoRuJLyPmDcTQZ+NPWcBvs6Muh9/2+dmYltZ/6tGF4eJvK3mN8y
         m+IofBjX1CWt85LcPooOao7ITOgSlnGVZFZQdqpwgy9LeBKUgadlAn5rbloxIr1Pbq
         tgt1hyMK5v2obweLjJeTgcXznf6Zv7HNborIF6nqAaIUEUiZ8+GRq7DJS/WKRbkc8l
         +FpQSZuIMTq1w==
Date:   Wed, 5 Jan 2022 10:56:26 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        david <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH v9 02/10] dax: Introduce holder for dax_device
Message-ID: <20220105185626.GE398655@magnolia>
References: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
 <20211226143439.3985960-3-ruansy.fnst@fujitsu.com>
 <20220105181230.GC398655@magnolia>
 <CAPcyv4iTaneUgdBPnqcvLr4Y_nAxQp31ZdUNkSRPsQ=9CpMWHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iTaneUgdBPnqcvLr4Y_nAxQp31ZdUNkSRPsQ=9CpMWHg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 05, 2022 at 10:23:08AM -0800, Dan Williams wrote:
> On Wed, Jan 5, 2022 at 10:12 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Sun, Dec 26, 2021 at 10:34:31PM +0800, Shiyang Ruan wrote:
> > > To easily track filesystem from a pmem device, we introduce a holder for
> > > dax_device structure, and also its operation.  This holder is used to
> > > remember who is using this dax_device:
> > >  - When it is the backend of a filesystem, the holder will be the
> > >    instance of this filesystem.
> > >  - When this pmem device is one of the targets in a mapped device, the
> > >    holder will be this mapped device.  In this case, the mapped device
> > >    has its own dax_device and it will follow the first rule.  So that we
> > >    can finally track to the filesystem we needed.
> > >
> > > The holder and holder_ops will be set when filesystem is being mounted,
> > > or an target device is being activated.
> > >
> > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > ---
> > >  drivers/dax/super.c | 62 +++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/dax.h | 29 +++++++++++++++++++++
> > >  2 files changed, 91 insertions(+)
> > >
> > > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > > index c46f56e33d40..94c51f2ee133 100644
> > > --- a/drivers/dax/super.c
> > > +++ b/drivers/dax/super.c
> > > @@ -20,15 +20,20 @@
> > >   * @inode: core vfs
> > >   * @cdev: optional character interface for "device dax"
> > >   * @private: dax driver private data
> > > + * @holder_data: holder of a dax_device: could be filesystem or mapped device
> > >   * @flags: state and boolean properties
> > > + * @ops: operations for dax_device
> > > + * @holder_ops: operations for the inner holder
> > >   */
> > >  struct dax_device {
> > >       struct inode inode;
> > >       struct cdev cdev;
> > >       void *private;
> > >       struct percpu_rw_semaphore rwsem;
> > > +     void *holder_data;
> > >       unsigned long flags;
> > >       const struct dax_operations *ops;
> > > +     const struct dax_holder_operations *holder_ops;
> > >  };
> > >
> > >  static dev_t dax_devt;
> > > @@ -192,6 +197,29 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
> > >  }
> > >  EXPORT_SYMBOL_GPL(dax_zero_page_range);
> > >
> > > +int dax_holder_notify_failure(struct dax_device *dax_dev, u64 off,
> > > +                           u64 len, int mf_flags)
> > > +{
> > > +     int rc;
> > > +
> > > +     dax_read_lock(dax_dev);
> > > +     if (!dax_alive(dax_dev)) {
> > > +             rc = -ENXIO;
> > > +             goto out;
> > > +     }
> > > +
> > > +     if (!dax_dev->holder_ops) {
> > > +             rc = -EOPNOTSUPP;
> > > +             goto out;
> > > +     }
> > > +
> > > +     rc = dax_dev->holder_ops->notify_failure(dax_dev, off, len, mf_flags);
> > > +out:
> > > +     dax_read_unlock(dax_dev);
> > > +     return rc;
> > > +}
> > > +EXPORT_SYMBOL_GPL(dax_holder_notify_failure);
> > > +
> > >  #ifdef CONFIG_ARCH_HAS_PMEM_API
> > >  void arch_wb_cache_pmem(void *addr, size_t size);
> > >  void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
> > > @@ -254,6 +282,10 @@ void kill_dax(struct dax_device *dax_dev)
> > >               return;
> > >       dax_write_lock(dax_dev);
> > >       clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
> > > +
> > > +     /* clear holder data */
> > > +     dax_dev->holder_ops = NULL;
> > > +     dax_dev->holder_data = NULL;
> > >       dax_write_unlock(dax_dev);
> > >  }
> > >  EXPORT_SYMBOL_GPL(kill_dax);
> > > @@ -401,6 +433,36 @@ void put_dax(struct dax_device *dax_dev)
> > >  }
> > >  EXPORT_SYMBOL_GPL(put_dax);
> > >
> > > +void dax_register_holder(struct dax_device *dax_dev, void *holder,
> > > +             const struct dax_holder_operations *ops)
> > > +{
> > > +     if (!dax_alive(dax_dev))
> > > +             return;
> > > +
> > > +     dax_dev->holder_data = holder;
> > > +     dax_dev->holder_ops = ops;
> >
> > Shouldn't this return an error code if the dax device is dead or if
> > someone already registered a holder?  I'm pretty sure XFS should not
> > bind to a dax device if someone else already registered for it...
> 
> Agree, yes.
> 
> >
> > ...unless you want to use a notifier chain for failure events so that
> > there can be multiple consumers of dax failure events?
> 
> No, I would hope not. It should be 1:1 holders to dax-devices. Similar
> ownership semantics like bd_prepare_to_claim().

Does each partition on a pmem device still have its own dax_device?

--D
