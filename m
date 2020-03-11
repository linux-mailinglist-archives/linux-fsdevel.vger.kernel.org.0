Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62FA0181F8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 18:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbgCKRe1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 13:34:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34102 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730375AbgCKRe0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583948065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YxDI+gJiBUTsbW70/4a/jRnjqZbO21J+vKCSG+NYW2I=;
        b=NUCvqXwLJ9fTmm5DEWFYrYpUXxU/WQiPH5zlNU80HnWwtaNQ1v3VuCFV0kOKrii24wK3za
        ZFM07EDfEOFUFq2RzdM4L3yuH+hMcIdEic+DV1kfqVclxSDoXhBE+0NQ1DkIBRzNDSCUog
        zJactrCngUjT3u5rSeq49ELrcyJBxyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-x_M0gZcdMA-ImuOio__G3Q-1; Wed, 11 Mar 2020 13:34:20 -0400
X-MC-Unique: x_M0gZcdMA-ImuOio__G3Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB2B2107ACC4;
        Wed, 11 Mar 2020 17:34:18 +0000 (UTC)
Received: from localhost (unknown [10.36.118.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0554D60FC2;
        Wed, 11 Mar 2020 17:34:06 +0000 (UTC)
Date:   Wed, 11 Mar 2020 17:34:05 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        dgilbert@redhat.com, mst@redhat.com,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 04/20] virtio: Implement get_shm_region for PCI transport
Message-ID: <20200311173405.GI281087@stefanha-x1.localdomain>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-5-vgoyal@redhat.com>
 <20200310110437.GI140737@stefanha-x1.localdomain>
 <20200310181936.GC38440@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200310181936.GC38440@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TKDEsImF70pdVIl+"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--TKDEsImF70pdVIl+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2020 at 02:19:36PM -0400, Vivek Goyal wrote:
> On Tue, Mar 10, 2020 at 11:04:37AM +0000, Stefan Hajnoczi wrote:
> > On Wed, Mar 04, 2020 at 11:58:29AM -0500, Vivek Goyal wrote:
> > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virt=
io_pci_modern.c
> > > index 7abcc50838b8..52f179411015 100644
> > > --- a/drivers/virtio/virtio_pci_modern.c
> > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > @@ -443,6 +443,111 @@ static void del_vq(struct virtio_pci_vq_info *i=
nfo)
> > >  =09vring_del_virtqueue(vq);
> > >  }
> > > =20
> > > +static int virtio_pci_find_shm_cap(struct pci_dev *dev,
> > > +                                   u8 required_id,
> > > +                                   u8 *bar, u64 *offset, u64 *len)
> > > +{
> > > +=09int pos;
> > > +
> > > +        for (pos =3D pci_find_capability(dev, PCI_CAP_ID_VNDR);
> >=20
> > Please fix the mixed tabs vs space indentation in this patch.
>=20
> Will do. There are plenty of these in this patch.
>=20
> >=20
> > > +static bool vp_get_shm_region(struct virtio_device *vdev,
> > > +=09=09=09      struct virtio_shm_region *region, u8 id)
> > > +{
> > > +=09struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
> > > +=09struct pci_dev *pci_dev =3D vp_dev->pci_dev;
> > > +=09u8 bar;
> > > +=09u64 offset, len;
> > > +=09phys_addr_t phys_addr;
> > > +=09size_t bar_len;
> > > +=09int ret;
> > > +
> > > +=09if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len)) {
> > > +=09=09return false;
> > > +=09}
> > > +
> > > +=09ret =3D pci_request_region(pci_dev, bar, "virtio-pci-shm");
> > > +=09if (ret < 0) {
> > > +=09=09dev_err(&pci_dev->dev, "%s: failed to request BAR\n",
> > > +=09=09=09__func__);
> > > +=09=09return false;
> > > +=09}
> > > +
> > > +=09phys_addr =3D pci_resource_start(pci_dev, bar);
> > > +=09bar_len =3D pci_resource_len(pci_dev, bar);
> > > +
> > > +        if (offset + len > bar_len) {
> > > +                dev_err(&pci_dev->dev,
> > > +                        "%s: bar shorter than cap offset+len\n",
> > > +                        __func__);
> > > +                return false;
> > > +        }
> > > +
> > > +=09region->len =3D len;
> > > +=09region->addr =3D (u64) phys_addr + offset;
> > > +
> > > +=09return true;
> > > +}
> >=20
> > Missing pci_release_region()?
>=20
> Good catch. We don't have a mechanism to call pci_relese_region() and=20
> virtio-mmio device's ->get_shm_region() implementation does not even
> seem to reserve the resources.
>=20
> So how about we leave this resource reservation to the caller.
> ->get_shm_region() just returns the addr/len pair of requested resource.
>=20
> Something like this patch.
>=20
> ---
>  drivers/virtio/virtio_pci_modern.c |    8 --------
>  fs/fuse/virtio_fs.c                |   13 ++++++++++---
>  2 files changed, 10 insertions(+), 11 deletions(-)
>=20
> Index: redhat-linux/fs/fuse/virtio_fs.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- redhat-linux.orig/fs/fuse/virtio_fs.c=092020-03-10 09:13:34.624565666=
 -0400
> +++ redhat-linux/fs/fuse/virtio_fs.c=092020-03-10 14:11:10.970284651 -040=
0
> @@ -763,11 +763,18 @@ static int virtio_fs_setup_dax(struct vi
>  =09if (!have_cache) {
>  =09=09dev_notice(&vdev->dev, "%s: No cache capability\n", __func__);
>  =09=09return 0;
> -=09} else {
> -=09=09dev_notice(&vdev->dev, "Cache len: 0x%llx @ 0x%llx\n",
> -=09=09=09   cache_reg.len, cache_reg.addr);
>  =09}
> =20
> +=09if (!devm_request_mem_region(&vdev->dev, cache_reg.addr, cache_reg.le=
n,
> +=09=09=09=09     dev_name(&vdev->dev))) {
> +=09=09dev_warn(&vdev->dev, "could not reserve region addr=3D0x%llx"
> +=09=09=09 " len=3D0x%llx\n", cache_reg.addr, cache_reg.len);
> +=09=09return -EBUSY;
> +        }
> +
> +=09dev_notice(&vdev->dev, "Cache len: 0x%llx @ 0x%llx\n", cache_reg.len,
> +=09=09   cache_reg.addr);
> +
>  =09pgmap =3D devm_kzalloc(&vdev->dev, sizeof(*pgmap), GFP_KERNEL);
>  =09if (!pgmap)
>  =09=09return -ENOMEM;
> Index: redhat-linux/drivers/virtio/virtio_pci_modern.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- redhat-linux.orig/drivers/virtio/virtio_pci_modern.c=092020-03-10 08:=
51:36.886565666 -0400
> +++ redhat-linux/drivers/virtio/virtio_pci_modern.c=092020-03-10 13:43:15=
.168753543 -0400
> @@ -511,19 +511,11 @@ static bool vp_get_shm_region(struct vir
>  =09u64 offset, len;
>  =09phys_addr_t phys_addr;
>  =09size_t bar_len;
> -=09int ret;
> =20
>  =09if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len)) {
>  =09=09return false;
>  =09}
> =20
> -=09ret =3D pci_request_region(pci_dev, bar, "virtio-pci-shm");
> -=09if (ret < 0) {
> -=09=09dev_err(&pci_dev->dev, "%s: failed to request BAR\n",
> -=09=09=09__func__);
> -=09=09return false;
> -=09}
> -
>  =09phys_addr =3D pci_resource_start(pci_dev, bar);
>  =09bar_len =3D pci_resource_len(pci_dev, bar);

Do pci_resource_start()/pci_resource_len() work on a BAR where
pci_request_region() hasn't been called yet?  (I haven't checked the
code, sorry...)

Assuming yes, then my next question is whether devm_request_mem_region()
works in both the VIRTIO PCI and MMIO cases?

If yes, then this looks like a solution, though the need for
devm_request_mem_region() should be explained in the vp_get_shm_region()
doc comments so that callers remember to make that call.  Or maybe it
can be included in vp_get_shm_region().

Stefan

--TKDEsImF70pdVIl+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5pIQ0ACgkQnKSrs4Gr
c8hRcwgAllE7XHaHgyhW//Kd35rBaIMwficvtTMl5oYcfsKBVGTrjWnaAYzbseXT
s/UX6DzqH/qO3skX5n9rq5tlVwW1POLhLYSjtXB0GFeC/utVMyQKrcdlYUAYeHFF
bROTGHuMNT0b3YbZiiHbA08BWfcuTOfhtzEwUPajlf+D8LvY11d1lyDGXb2GxcRI
vIx5hpsok29/NpOn2KgYcUSTZ1f8jk7mHnMscCRjvp9o8WJVCt7nIT2tJYYRuOKE
+VCiza9iW/P8w+PrwdQj1lraakETWKPmDXQPjCz5BUyyDrqDJr7RMDY+KdPrll0l
kDFkAzr2D64PwzwaXaM3sNXecZXK4w==
=pAoo
-----END PGP SIGNATURE-----

--TKDEsImF70pdVIl+--

