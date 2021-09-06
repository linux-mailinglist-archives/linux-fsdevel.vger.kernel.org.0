Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80AE40176F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 10:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240441AbhIFICM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Sep 2021 04:02:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35449 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240414AbhIFICK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Sep 2021 04:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630915265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NO6GFqxRcZJwYtn+Qe2gbxSZz+UC4dbKjNIIRf72XCk=;
        b=Ov0bj2YFrCarQhs7xKGTfaB0tUGXFmw1VVU1PVc3aGQTR0ptVdy40bw0urTlXwI9XYwtHZ
        XJsyJKBmTEBnTrMNngx2rQDnVsflhpHFhb5qcPdYK9IR4UVq51fqo0YeEDnnjtWAtE8ZhR
        YeyzDB24/+ZacaxxZPl7ejJEMlIVCuk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-Uz5SrClfMFmZ4rvZMOfkrg-1; Mon, 06 Sep 2021 04:01:03 -0400
X-MC-Unique: Uz5SrClfMFmZ4rvZMOfkrg-1
Received: by mail-wr1-f72.google.com with SMTP id i16-20020adfded0000000b001572ebd528eso944281wrn.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Sep 2021 01:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NO6GFqxRcZJwYtn+Qe2gbxSZz+UC4dbKjNIIRf72XCk=;
        b=Ex9ucn2K/1nJ4bq7O2F2/n8F6zB5esrKvW9xGkp0f2vnGrnE/03tS8eA/d2OxsPOnG
         7HvUjyNXeK9f4x0lQVMnVNYROMHoGj04IFDdEDZWdO46eQzAPBQy2FossP2ovR/wsu3Y
         PDmTATVYnz1uL9GBsMPGUnfhGwf7i3dlTG7faZvsQOD6lQAWOizqVVJK6smR+ORp+gck
         yZuOhdwymxaQ2fmxeRAuGUzIcQlPpVmrOWHsbX83Be8ZIz9T3RRCHGcC9W1QwDDW2Oyi
         74VuBlETRl+5McrJBX9aO19HCxd7iXmll7vE7z0TtSdQWf1JHZb1zazyrURGmgnTiTPO
         0pmQ==
X-Gm-Message-State: AOAM5327YfUw43dbm/trYehjwiIQFiKtSgLAIy9CM6NT1vTF60IQ32Et
        bQ0ANG8yu8Ca2BPkVbn5GiXuAdBc/ur5l6ydCI8dvg8z+nWK85cD79g84WrgmDMjA0Ki0fsjGw9
        hRLN+urVd4aWaJL1/UnR4Q5AaYw==
X-Received: by 2002:a1c:4d10:: with SMTP id o16mr10145333wmh.60.1630915262573;
        Mon, 06 Sep 2021 01:01:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyD0Y0QTVxlVRT+q0YtcHDYNCzcA75tKV0/AOdp2DwxYwSQKzP8ML7fq7xzKLKNz0GctS8Quw==
X-Received: by 2002:a1c:4d10:: with SMTP id o16mr10145288wmh.60.1630915262309;
        Mon, 06 Sep 2021 01:01:02 -0700 (PDT)
Received: from redhat.com ([2.55.131.183])
        by smtp.gmail.com with ESMTPSA id e3sm6259897wrc.11.2021.09.06.01.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 01:01:01 -0700 (PDT)
Date:   Mon, 6 Sep 2021 04:00:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian.brauner@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, joro@8bytes.org,
        Greg KH <gregkh@linuxfoundation.org>,
        He Zhe <zhe.he@windriver.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Joe Perches <joe@perches.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>, songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 05/13] vdpa: Add reset callback in vdpa_config_ops
Message-ID: <20210906035338-mutt-send-email-mst@kernel.org>
References: <20210831103634.33-1-xieyongji@bytedance.com>
 <20210831103634.33-6-xieyongji@bytedance.com>
 <20210906015524-mutt-send-email-mst@kernel.org>
 <CACycT3v4ZVnh7DGe_RtAOx4Vvau0km=HWyCM=KzKhD+ahYKafQ@mail.gmail.com>
 <20210906023131-mutt-send-email-mst@kernel.org>
 <CACycT3ssC1bhNzY9Pk=LPvKjMrFFavTfCKTJtR2XEiVYqDxT1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACycT3ssC1bhNzY9Pk=LPvKjMrFFavTfCKTJtR2XEiVYqDxT1Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 06, 2021 at 03:06:44PM +0800, Yongji Xie wrote:
> On Mon, Sep 6, 2021 at 2:37 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Sep 06, 2021 at 02:09:25PM +0800, Yongji Xie wrote:
> > > On Mon, Sep 6, 2021 at 1:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Aug 31, 2021 at 06:36:26PM +0800, Xie Yongji wrote:
> > > > > This adds a new callback to support device specific reset
> > > > > behavior. The vdpa bus driver will call the reset function
> > > > > instead of setting status to zero during resetting.
> > > > >
> > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > >
> > > >
> > > > This does gloss over a significant change though:
> > > >
> > > >
> > > > > ---
> > > > > @@ -348,12 +352,12 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
> > > > >       return vdev->dma_dev;
> > > > >  }
> > > > >
> > > > > -static inline void vdpa_reset(struct vdpa_device *vdev)
> > > > > +static inline int vdpa_reset(struct vdpa_device *vdev)
> > > > >  {
> > > > >       const struct vdpa_config_ops *ops = vdev->config;
> > > > >
> > > > >       vdev->features_valid = false;
> > > > > -     ops->set_status(vdev, 0);
> > > > > +     return ops->reset(vdev);
> > > > >  }
> > > > >
> > > > >  static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
> > > >
> > > >
> > > > Unfortunately this breaks virtio_vdpa:
> > > >
> > > >
> > > > static void virtio_vdpa_reset(struct virtio_device *vdev)
> > > > {
> > > >         struct vdpa_device *vdpa = vd_get_vdpa(vdev);
> > > >
> > > >         vdpa_reset(vdpa);
> > > > }
> > > >
> > > >
> > > > and there's no easy way to fix this, kernel can't recover
> > > > from a reset failure e.g. during driver unbind.
> > > >
> > >
> > > Yes, but it should be safe with the protection of software IOTLB even
> > > if the reset() fails during driver unbind.
> > >
> > > Thanks,
> > > Yongji
> >
> > Hmm. I don't see it.
> > What exactly will happen? What prevents device from poking at
> > memory after reset? Note that dma unmap in e.g. del_vqs happens
> > too late.
> 
> But I didn't see any problems with touching the memory for virtqueues.

Drivers make the assumption that after reset returns no new
buffers will be consumed. For example a bunch of drivers
call virtqueue_detach_unused_buf.
I can't say whether block makes this assumption anywhere.
Needs careful auditing.

> The memory should not be freed after dma unmap?

But unmap does not happen until after the reset.


> And the memory for the bounce buffer should also be safe to be
> accessed by userspace in this case.
> 
> > And what about e.g. interrupts?
> > E.g. we have this:
> >
> >         /* Virtqueues are stopped, nothing can use vblk->vdev anymore. */
> >         vblk->vdev = NULL;
> >
> > and this is no longer true at this point.
> >
> 
> You're right. But I didn't see where the interrupt handler will use
> the vblk->vdev.

static void virtblk_done(struct virtqueue *vq)
{
        struct virtio_blk *vblk = vq->vdev->priv;

vq->vdev is the same as vblk->vdev.


> So it seems to be not too late to fix it:
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c
> b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 5c25ff6483ad..ea41a7389a26 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -665,13 +665,13 @@ static void vduse_vdpa_set_config(struct
> vdpa_device *vdpa, unsigned int offset,
>  static int vduse_vdpa_reset(struct vdpa_device *vdpa)
>  {
>         struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +       int ret;
> 
> -       if (vduse_dev_set_status(dev, 0))
> -               return -EIO;
> +       ret = vduse_dev_set_status(dev, 0);
> 
>         vduse_dev_reset(dev);
> 
> -       return 0;
> +       return ret;
>  }
> 
>  static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)
> 
> Thanks,
> Yongji

Needs some comments to explain why it's done like this.

BTW device is generally wedged at this point right?
E.g. if reset during initialization fails, userspace
will still get the reset at some later point and be
confused ...

-- 
MST

