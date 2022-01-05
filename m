Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5308748581A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 19:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242856AbiAESXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 13:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242851AbiAESXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:23:19 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749D9C061212
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jan 2022 10:23:19 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 200so36205317pgg.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jan 2022 10:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O3txqHljQl/GCNxyCJxfFojCjkO470bmaKiTOmC1xSE=;
        b=iDaMKn+q7SGqX3ujdNUGLIq8rR9uST+ZG/7EUkKHkYITiY/9guw1ZRXf3Ht59Dz2kA
         IljULJEO3i+pPOzOnZXhD3vALfxADxcPKVZqVKrO/pzmcxvaa37+fRTER/WdpRu2YXiH
         XqA6bprq+O3qlgt6rpbnONeUrs2A5iUPw0Rr1Oy1rrK9MTDAm9TcPBdRKFW5yS4YufWJ
         Npd4V2aXugQPk341QkO2dH7kuWmID7i5orec/rVIGU1QPRTl8oafYAQgyLhqEOk1JFG/
         fpy6WAxwAtIUhlSp+IGClZEoLSmXUYQNHBB+0UeoK9tpNTY6HPYa/lBmoGxCn8zwKVzT
         bdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O3txqHljQl/GCNxyCJxfFojCjkO470bmaKiTOmC1xSE=;
        b=dbyimM/UEBWCh+t2KWdwpnmbD2mOxonLmVni8J+LavWI2YkT1WSBFRj3/7cNEpJsC7
         BbsunaCZ+Sweh8a8pn9eqh59dqdgL8vOMfEFpBHy4PTlodcLSJ0nsevKjRJ0pj9+5DI/
         w+fmzK2cydKdgVHnAApNId/+Z5X77AlNFpiyRKymMGkpLdg4hKB/bJJeTJBaFFPCxM+n
         Y+Ni1jSUd6Vmg8tSpgAKKY9rFp4iscsMDejagVjBv5GVlpULMWxaGVT6G/7T1EBca0Gu
         njzCkSwHpEQVT/+KOPRpRbwmqB/heHDsfcIl6SdCPlmtdaSqXqF0ORd1RGU6sx9GJGdk
         k/2A==
X-Gm-Message-State: AOAM531nfmlSEplCkpBjV74/F6HBTMvaWlpk3OJi/5pRzGosd/YgDOJ9
        mvv88A5snSrDtmFniKNjg00OxTdAS3/ZrwpCcVN6UQ==
X-Google-Smtp-Source: ABdhPJxoBP/aT1AEtcGz3BudjHksIAmWp/YqSFrZQveftZYxEW3pAAMJ+2H/kJ2DcT1CwoBX6W8azzzA4zy/f9WM0+k=
X-Received: by 2002:a63:710f:: with SMTP id m15mr18291969pgc.40.1641406998932;
 Wed, 05 Jan 2022 10:23:18 -0800 (PST)
MIME-Version: 1.0
References: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
 <20211226143439.3985960-3-ruansy.fnst@fujitsu.com> <20220105181230.GC398655@magnolia>
In-Reply-To: <20220105181230.GC398655@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 5 Jan 2022 10:23:08 -0800
Message-ID: <CAPcyv4iTaneUgdBPnqcvLr4Y_nAxQp31ZdUNkSRPsQ=9CpMWHg@mail.gmail.com>
Subject: Re: [PATCH v9 02/10] dax: Introduce holder for dax_device
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        david <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 5, 2022 at 10:12 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Sun, Dec 26, 2021 at 10:34:31PM +0800, Shiyang Ruan wrote:
> > To easily track filesystem from a pmem device, we introduce a holder for
> > dax_device structure, and also its operation.  This holder is used to
> > remember who is using this dax_device:
> >  - When it is the backend of a filesystem, the holder will be the
> >    instance of this filesystem.
> >  - When this pmem device is one of the targets in a mapped device, the
> >    holder will be this mapped device.  In this case, the mapped device
> >    has its own dax_device and it will follow the first rule.  So that we
> >    can finally track to the filesystem we needed.
> >
> > The holder and holder_ops will be set when filesystem is being mounted,
> > or an target device is being activated.
> >
> > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > ---
> >  drivers/dax/super.c | 62 +++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/dax.h | 29 +++++++++++++++++++++
> >  2 files changed, 91 insertions(+)
> >
> > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > index c46f56e33d40..94c51f2ee133 100644
> > --- a/drivers/dax/super.c
> > +++ b/drivers/dax/super.c
> > @@ -20,15 +20,20 @@
> >   * @inode: core vfs
> >   * @cdev: optional character interface for "device dax"
> >   * @private: dax driver private data
> > + * @holder_data: holder of a dax_device: could be filesystem or mapped device
> >   * @flags: state and boolean properties
> > + * @ops: operations for dax_device
> > + * @holder_ops: operations for the inner holder
> >   */
> >  struct dax_device {
> >       struct inode inode;
> >       struct cdev cdev;
> >       void *private;
> >       struct percpu_rw_semaphore rwsem;
> > +     void *holder_data;
> >       unsigned long flags;
> >       const struct dax_operations *ops;
> > +     const struct dax_holder_operations *holder_ops;
> >  };
> >
> >  static dev_t dax_devt;
> > @@ -192,6 +197,29 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
> >  }
> >  EXPORT_SYMBOL_GPL(dax_zero_page_range);
> >
> > +int dax_holder_notify_failure(struct dax_device *dax_dev, u64 off,
> > +                           u64 len, int mf_flags)
> > +{
> > +     int rc;
> > +
> > +     dax_read_lock(dax_dev);
> > +     if (!dax_alive(dax_dev)) {
> > +             rc = -ENXIO;
> > +             goto out;
> > +     }
> > +
> > +     if (!dax_dev->holder_ops) {
> > +             rc = -EOPNOTSUPP;
> > +             goto out;
> > +     }
> > +
> > +     rc = dax_dev->holder_ops->notify_failure(dax_dev, off, len, mf_flags);
> > +out:
> > +     dax_read_unlock(dax_dev);
> > +     return rc;
> > +}
> > +EXPORT_SYMBOL_GPL(dax_holder_notify_failure);
> > +
> >  #ifdef CONFIG_ARCH_HAS_PMEM_API
> >  void arch_wb_cache_pmem(void *addr, size_t size);
> >  void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
> > @@ -254,6 +282,10 @@ void kill_dax(struct dax_device *dax_dev)
> >               return;
> >       dax_write_lock(dax_dev);
> >       clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
> > +
> > +     /* clear holder data */
> > +     dax_dev->holder_ops = NULL;
> > +     dax_dev->holder_data = NULL;
> >       dax_write_unlock(dax_dev);
> >  }
> >  EXPORT_SYMBOL_GPL(kill_dax);
> > @@ -401,6 +433,36 @@ void put_dax(struct dax_device *dax_dev)
> >  }
> >  EXPORT_SYMBOL_GPL(put_dax);
> >
> > +void dax_register_holder(struct dax_device *dax_dev, void *holder,
> > +             const struct dax_holder_operations *ops)
> > +{
> > +     if (!dax_alive(dax_dev))
> > +             return;
> > +
> > +     dax_dev->holder_data = holder;
> > +     dax_dev->holder_ops = ops;
>
> Shouldn't this return an error code if the dax device is dead or if
> someone already registered a holder?  I'm pretty sure XFS should not
> bind to a dax device if someone else already registered for it...

Agree, yes.

>
> ...unless you want to use a notifier chain for failure events so that
> there can be multiple consumers of dax failure events?

No, I would hope not. It should be 1:1 holders to dax-devices. Similar
ownership semantics like bd_prepare_to_claim().
