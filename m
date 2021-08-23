Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287FF3F45EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 09:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbhHWHpy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 03:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbhHWHpy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 03:45:54 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D14C061756
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 00:45:11 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id l10so2474903ilh.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 00:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IlaNENSlWA7O36ThQC1swNGBkoYWjvx5SXQg/rTQMmI=;
        b=v/xf3p30Lok05NM5hFl5e4TCzreiVTbA7dm0nJz7Bf/rS+4kdz0RU6rdoBpuE/Bshr
         W2cwC5Rqg/vXWKdF3VDojkslVRYUpIIV1qOXJTZX6k9PFSBoGRovz6xeO18fgCyEcYvS
         hCv1Jon8C9lNgxDZ9meHG0kI+gMNr3M2A8yONcgxn/hUFoqTirFa2ZhbYcM8YyalIe9x
         khb9sMBSITynIRl1l+Ano9dtDdqXz0TaKK+4P02tlu6/bBFepF8x97BN24XkLkmCbvZ3
         QhrCp8ZUtmoLx/J0Y0tfnF8VtnQ8CkBgf2iVDfJnkPLnMfd/gQ2HaUkLgJubWjp+ggZe
         qzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IlaNENSlWA7O36ThQC1swNGBkoYWjvx5SXQg/rTQMmI=;
        b=me/CsV8+SGCCEA/7aoRKHN7SU7ugx/wQ3Ec9DRnu2H9Pa/vqExUbSj6dOMKmaLW36+
         BDvLzJ2NIuaxh5lzam2+nhyddzfdmOKjM9XIJd8gKqxodTIAlt4D8ZlcGm7UCG7U97PP
         GIFPFkALSh7QFoiyl5EK+G67R4DaBsywgaucn1b6ka/QBxRmeLMxLVJPTpYemeiqP7Uk
         fbM52GNGi3tIJb5iBUX7bXnwHTRtulHgOPICsYuqvSL+V9fA30hk2iWobQTKr8ggxQv8
         avI2pVKVqtIO79PO3Gf6HeVkYmSgTAhTaMCb7kRtThOxD6CWqrU1tXHtga7NNa9X/SmH
         vpFQ==
X-Gm-Message-State: AOAM533PX/W6L+gkhs+75YzRq8yu5Gecw52T/tpQPbZntn7qqSU9ytBf
        mEsgHNEcadNJRvOPOYNvq7B6mwfmTA1qnPBx/vsa
X-Google-Smtp-Source: ABdhPJypCdtizHYoxZDBKevH2qzGpkSgui7qYBLxMbmXcESyZsC9N17OihZaUrjlMnAjFtHM+k3anHAL8J48FceAkUo=
X-Received: by 2002:a92:7b0c:: with SMTP id w12mr22446677ilc.307.1629704711346;
 Mon, 23 Aug 2021 00:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210818120642.165-1-xieyongji@bytedance.com> <20210818120642.165-5-xieyongji@bytedance.com>
 <4470fdac-89fb-1216-78d7-6335c3bfeb22@redhat.com>
In-Reply-To: <4470fdac-89fb-1216-78d7-6335c3bfeb22@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 23 Aug 2021 15:44:59 +0800
Message-ID: <CACycT3sjeWhUmHSAeniSnMO6Jus_d1p3eO--y0qc9FYP_cDMzQ@mail.gmail.com>
Subject: Re: [PATCH v11 04/12] vdpa: Add reset callback in vdpa_config_ops
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
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
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, joro@8bytes.org,
        Greg KH <gregkh@linuxfoundation.org>,
        He Zhe <zhe.he@windriver.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Joe Perches <joe@perches.com>,
        Robin Murphy <robin.murphy@arm.com>, songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 23, 2021 at 2:31 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2021/8/18 =E4=B8=8B=E5=8D=888:06, Xie Yongji =E5=86=99=E9=81=93=
:
> > This adds a new callback to support device specific reset
> > behavior. The vdpa bus driver will call the reset function
> > instead of setting status to zero during resetting if device
> > driver supports the new callback.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >   drivers/vhost/vdpa.c |  9 +++++++--
> >   include/linux/vdpa.h | 11 ++++++++++-
> >   2 files changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index b07aa161f7ad..b1c91b4db0ba 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -157,7 +157,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa=
 *v, u8 __user *statusp)
> >       struct vdpa_device *vdpa =3D v->vdpa;
> >       const struct vdpa_config_ops *ops =3D vdpa->config;
> >       u8 status, status_old;
> > -     int nvqs =3D v->nvqs;
> > +     int ret, nvqs =3D v->nvqs;
> >       u16 i;
> >
> >       if (copy_from_user(&status, statusp, sizeof(status)))
> > @@ -172,7 +172,12 @@ static long vhost_vdpa_set_status(struct vhost_vdp=
a *v, u8 __user *statusp)
> >       if (status !=3D 0 && (ops->get_status(vdpa) & ~status) !=3D 0)
> >               return -EINVAL;
> >
> > -     ops->set_status(vdpa, status);
> > +     if (status =3D=3D 0 && ops->reset) {
> > +             ret =3D ops->reset(vdpa);
> > +             if (ret)
> > +                     return ret;
> > +     } else
> > +             ops->set_status(vdpa, status);
> >
> >       if ((status & VIRTIO_CONFIG_S_DRIVER_OK) && !(status_old & VIRTIO=
_CONFIG_S_DRIVER_OK))
> >               for (i =3D 0; i < nvqs; i++)
> > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > index 8a645f8f4476..af7ea5ad795f 100644
> > --- a/include/linux/vdpa.h
> > +++ b/include/linux/vdpa.h
> > @@ -196,6 +196,9 @@ struct vdpa_iova_range {
> >    *                          @vdev: vdpa device
> >    *                          Returns the iova range supported by
> >    *                          the device.
> > + * @reset:                   Reset device (optional)
> > + *                           @vdev: vdpa device
> > + *                           Returns integer: success (0) or error (< =
0)
>
>
> It looks to me we'd better make this mandatory. This help to reduce the
> confusion for the parent driver.
>

OK, will do it in next version.

Thanks,
Yongji
