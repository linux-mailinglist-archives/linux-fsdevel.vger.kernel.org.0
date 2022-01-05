Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA2C485BC8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 23:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245128AbiAEWra (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 17:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiAEWr3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:47:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE40AC061245;
        Wed,  5 Jan 2022 14:47:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58B2461893;
        Wed,  5 Jan 2022 22:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB84BC36AE9;
        Wed,  5 Jan 2022 22:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641422847;
        bh=glZrEk8ggRtouJ5oR15cj7aPQIDczPe47sUNaQdinC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JFFMfejQ3ftcyE/Nw8jDlZzlJxzO6tuF/QUglmOB7IdiYVKNBFL6kRHfiOIO8fTzj
         IGSYrjxeTtEOYQvTxbZ5mcu55CZtQR/tgK8yriNCiCpImJjY0t8en86pSd5X7SpxBc
         EDWVcFT/LeXM0yXuB2U+wuJdLi/66Xd3svQffDmTJ7kG4wrz8he0OEnie/WzpSxnAs
         EpT6amK/dJ5uvHJNbX1gL7u5/hTZR8XvvC/2TAn6q2HVLjITinoMbXdsvfUVaHpSNf
         H9O1uvANNivESMCaMYpMtQXYCf5aJ5Pub2qxz+pXgpAXcsvsiji5MFD6diNA6dGJXM
         fxTKUTf9yUt6Q==
Date:   Wed, 5 Jan 2022 14:47:27 -0800
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
Message-ID: <20220105224727.GG398655@magnolia>
References: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
 <20211226143439.3985960-3-ruansy.fnst@fujitsu.com>
 <20220105181230.GC398655@magnolia>
 <CAPcyv4iTaneUgdBPnqcvLr4Y_nAxQp31ZdUNkSRPsQ=9CpMWHg@mail.gmail.com>
 <20220105185626.GE398655@magnolia>
 <CAPcyv4h3M9f1-C5e9kHTfPaRYR_zN4gzQWgR+ZyhNmG_SL-u+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h3M9f1-C5e9kHTfPaRYR_zN4gzQWgR+ZyhNmG_SL-u+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 05, 2022 at 11:20:12AM -0800, Dan Williams wrote:
> On Wed, Jan 5, 2022 at 10:56 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Jan 05, 2022 at 10:23:08AM -0800, Dan Williams wrote:
> > > On Wed, Jan 5, 2022 at 10:12 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > On Sun, Dec 26, 2021 at 10:34:31PM +0800, Shiyang Ruan wrote:
> > > > > To easily track filesystem from a pmem device, we introduce a holder for
> > > > > dax_device structure, and also its operation.  This holder is used to
> > > > > remember who is using this dax_device:
> > > > >  - When it is the backend of a filesystem, the holder will be the
> > > > >    instance of this filesystem.
> > > > >  - When this pmem device is one of the targets in a mapped device, the
> > > > >    holder will be this mapped device.  In this case, the mapped device
> > > > >    has its own dax_device and it will follow the first rule.  So that we
> > > > >    can finally track to the filesystem we needed.
> > > > >
> > > > > The holder and holder_ops will be set when filesystem is being mounted,
> > > > > or an target device is being activated.
> > > > >
> > > > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > > > ---
> > > > >  drivers/dax/super.c | 62 +++++++++++++++++++++++++++++++++++++++++++++
> > > > >  include/linux/dax.h | 29 +++++++++++++++++++++
> > > > >  2 files changed, 91 insertions(+)
> > > > >
> > > > > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > > > > index c46f56e33d40..94c51f2ee133 100644
> > > > > --- a/drivers/dax/super.c
> > > > > +++ b/drivers/dax/super.c
> > > > > @@ -20,15 +20,20 @@
> > > > >   * @inode: core vfs
> > > > >   * @cdev: optional character interface for "device dax"
> > > > >   * @private: dax driver private data
> > > > > + * @holder_data: holder of a dax_device: could be filesystem or mapped device
> > > > >   * @flags: state and boolean properties
> > > > > + * @ops: operations for dax_device
> > > > > + * @holder_ops: operations for the inner holder
> > > > >   */
> > > > >  struct dax_device {
> > > > >       struct inode inode;
> > > > >       struct cdev cdev;
> > > > >       void *private;
> > > > >       struct percpu_rw_semaphore rwsem;
> > > > > +     void *holder_data;
> > > > >       unsigned long flags;
> > > > >       const struct dax_operations *ops;
> > > > > +     const struct dax_holder_operations *holder_ops;
> > > > >  };
> > > > >
> > > > >  static dev_t dax_devt;
> > > > > @@ -192,6 +197,29 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(dax_zero_page_range);
> > > > >
> > > > > +int dax_holder_notify_failure(struct dax_device *dax_dev, u64 off,
> > > > > +                           u64 len, int mf_flags)
> > > > > +{
> > > > > +     int rc;
> > > > > +
> > > > > +     dax_read_lock(dax_dev);
> > > > > +     if (!dax_alive(dax_dev)) {
> > > > > +             rc = -ENXIO;
> > > > > +             goto out;
> > > > > +     }
> > > > > +
> > > > > +     if (!dax_dev->holder_ops) {
> > > > > +             rc = -EOPNOTSUPP;
> > > > > +             goto out;
> > > > > +     }
> > > > > +
> > > > > +     rc = dax_dev->holder_ops->notify_failure(dax_dev, off, len, mf_flags);
> > > > > +out:
> > > > > +     dax_read_unlock(dax_dev);
> > > > > +     return rc;
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(dax_holder_notify_failure);
> > > > > +
> > > > >  #ifdef CONFIG_ARCH_HAS_PMEM_API
> > > > >  void arch_wb_cache_pmem(void *addr, size_t size);
> > > > >  void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
> > > > > @@ -254,6 +282,10 @@ void kill_dax(struct dax_device *dax_dev)
> > > > >               return;
> > > > >       dax_write_lock(dax_dev);
> > > > >       clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
> > > > > +
> > > > > +     /* clear holder data */
> > > > > +     dax_dev->holder_ops = NULL;
> > > > > +     dax_dev->holder_data = NULL;
> > > > >       dax_write_unlock(dax_dev);
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(kill_dax);
> > > > > @@ -401,6 +433,36 @@ void put_dax(struct dax_device *dax_dev)
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(put_dax);
> > > > >
> > > > > +void dax_register_holder(struct dax_device *dax_dev, void *holder,
> > > > > +             const struct dax_holder_operations *ops)
> > > > > +{
> > > > > +     if (!dax_alive(dax_dev))
> > > > > +             return;
> > > > > +
> > > > > +     dax_dev->holder_data = holder;
> > > > > +     dax_dev->holder_ops = ops;
> > > >
> > > > Shouldn't this return an error code if the dax device is dead or if
> > > > someone already registered a holder?  I'm pretty sure XFS should not
> > > > bind to a dax device if someone else already registered for it...
> > >
> > > Agree, yes.
> > >
> > > >
> > > > ...unless you want to use a notifier chain for failure events so that
> > > > there can be multiple consumers of dax failure events?
> > >
> > > No, I would hope not. It should be 1:1 holders to dax-devices. Similar
> > > ownership semantics like bd_prepare_to_claim().
> >
> > Does each partition on a pmem device still have its own dax_device?
> 
> No, it never did...
> 
> Just as before, each dax-device is still associated with a gendisk /
> whole-block_device. The recent change is that instead of needing that
> partition-block_device plumbed to convert a relative block number to
> its absolute whole-block_device offset the filesystem now handles that
> at iomap_begin() time. See:
> 
>                 if (mapping_flags & IOMAP_DAX)
>                         iomap->addr += target->bt_dax_part_off;
> 
> ...in xfs_bmbt_to_iomap() (in -next). I.e. bdev_dax_pgoff() is gone
> with the lead-in reworks.

OH.  Crap, Dan's right:

XFS (pmem0p1): ddev dax = 0xffff88800304ed00 bdev = 0xffff8880480d6180
XFS (pmem0p2): ddev dax = 0xffff88800304ed00 bdev = 0xffff8880480d4380

Unless you're planning to remove partition support too, this patch needs
to be reworked so that multiple filesystems in separate partitions can
each call dax_register_holder to receive memory_failure notifications
for their partition.

/methinks this sharing is all a little scary...

--D
