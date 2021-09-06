Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0372401676
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 08:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbhIFGiT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Sep 2021 02:38:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239421AbhIFGiQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Sep 2021 02:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630910232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NwUBcFLW2DErKP8nW3thbj1Bfk3yLnGU+eP2iS4eEBM=;
        b=QYuNd++ezwA7PDK5HSG93hEuQh38D/s6/4PFw1kzIQd2Eyu9DRjrBvwdXSp+OalBFUJLQv
        yRwz9+VERtrL0nmhfDm4FY1hc4UZlVPIiz2ymRme0uQF19lAYxYde2IIl5qilE11BCtqXC
        Ly7hqDqu8Q1udtZb/vOBITSj2XpHJJA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-nbD37_F7M-Sb76hrJyWDqw-1; Mon, 06 Sep 2021 02:37:10 -0400
X-MC-Unique: nbD37_F7M-Sb76hrJyWDqw-1
Received: by mail-wm1-f70.google.com with SMTP id u14-20020a7bcb0e0000b0290248831d46e4so2841599wmj.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Sep 2021 23:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NwUBcFLW2DErKP8nW3thbj1Bfk3yLnGU+eP2iS4eEBM=;
        b=YpC4UNi8aQqpUisDIj9HBZ3iTo1HL3HZYsq9uBP08JlC4I+UliSCtOqylpEB6ZLIb6
         mq093paUa5Uw0hX9zGMDAjRrRqiQBdlPL/b/p227Jesi6rSolOko2fKsZbJPrAyPNwDH
         eRahlqhQFkJIiLv+u22CHR3MfuYYDjfOPRT7k3nCgEOZHW8Ap036nkkD4jXr3GFmbWRA
         os8Szp5Bz2vEwjzGJAr2HrVyJwVGan1WDt7GffLvYg5CuYt+6U195/RJ8i7JEGNGTvJk
         Dh1CfTKvhmOuuIEsQ9MtQTkcWZaxhpLGNlz4BC+4726xnWr/Yr/oaVXIq0nzaKd/FWOy
         X/iA==
X-Gm-Message-State: AOAM530X6LlyQcERaFPapPIhvnA7tMKhgMS1ooPUnCZ8ICps+uwhF8Z2
        fLK2WopDrLCXaAoaAW9+BFPSGavuo/zql3Wz0EN98qT82rjGCeygzmqpQfXEkAzx4J6g8PiPrPt
        qWLo/9PEpyjFmD1S9KaOQwAMD+A==
X-Received: by 2002:a1c:1f8e:: with SMTP id f136mr9990696wmf.132.1630910229774;
        Sun, 05 Sep 2021 23:37:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRCwrPqlTT9EQxN6i2JahNEijC2yzlB8bw+tqErn2HIqi0obsj9A8iduK7E+CvdT1s7MMNSQ==
X-Received: by 2002:a1c:1f8e:: with SMTP id f136mr9990653wmf.132.1630910229544;
        Sun, 05 Sep 2021 23:37:09 -0700 (PDT)
Received: from redhat.com ([2.55.131.183])
        by smtp.gmail.com with ESMTPSA id g1sm8586151wrb.27.2021.09.05.23.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 23:37:08 -0700 (PDT)
Date:   Mon, 6 Sep 2021 02:37:03 -0400
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
Message-ID: <20210906023131-mutt-send-email-mst@kernel.org>
References: <20210831103634.33-1-xieyongji@bytedance.com>
 <20210831103634.33-6-xieyongji@bytedance.com>
 <20210906015524-mutt-send-email-mst@kernel.org>
 <CACycT3v4ZVnh7DGe_RtAOx4Vvau0km=HWyCM=KzKhD+ahYKafQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACycT3v4ZVnh7DGe_RtAOx4Vvau0km=HWyCM=KzKhD+ahYKafQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 06, 2021 at 02:09:25PM +0800, Yongji Xie wrote:
> On Mon, Sep 6, 2021 at 1:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Aug 31, 2021 at 06:36:26PM +0800, Xie Yongji wrote:
> > > This adds a new callback to support device specific reset
> > > behavior. The vdpa bus driver will call the reset function
> > > instead of setting status to zero during resetting.
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> >
> >
> > This does gloss over a significant change though:
> >
> >
> > > ---
> > > @@ -348,12 +352,12 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
> > >       return vdev->dma_dev;
> > >  }
> > >
> > > -static inline void vdpa_reset(struct vdpa_device *vdev)
> > > +static inline int vdpa_reset(struct vdpa_device *vdev)
> > >  {
> > >       const struct vdpa_config_ops *ops = vdev->config;
> > >
> > >       vdev->features_valid = false;
> > > -     ops->set_status(vdev, 0);
> > > +     return ops->reset(vdev);
> > >  }
> > >
> > >  static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
> >
> >
> > Unfortunately this breaks virtio_vdpa:
> >
> >
> > static void virtio_vdpa_reset(struct virtio_device *vdev)
> > {
> >         struct vdpa_device *vdpa = vd_get_vdpa(vdev);
> >
> >         vdpa_reset(vdpa);
> > }
> >
> >
> > and there's no easy way to fix this, kernel can't recover
> > from a reset failure e.g. during driver unbind.
> >
> 
> Yes, but it should be safe with the protection of software IOTLB even
> if the reset() fails during driver unbind.
> 
> Thanks,
> Yongji

Hmm. I don't see it.
What exactly will happen? What prevents device from poking at
memory after reset? Note that dma unmap in e.g. del_vqs happens
too late.  And what about e.g. interrupts?
E.g. we have this:

        /* Virtqueues are stopped, nothing can use vblk->vdev anymore. */
        vblk->vdev = NULL;

and this is no longer true at this point.


-- 
MST

