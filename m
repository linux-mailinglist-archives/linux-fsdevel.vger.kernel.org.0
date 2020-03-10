Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0813817F59F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 12:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCJLEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 07:04:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42050 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726186AbgCJLEv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583838289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CzkrWAmBf2oqqeq6nmGCN0dfk2xPizcnlNYu+9BCd+8=;
        b=PP5E/+PkioTc8RkTnpxo8OKUHmFqbD9MKC+G8oRqlz0dDw9T20BpeqDdG3NGZFNmXcfG9N
        LkiAb5WpjI2lLS8C5TyhXsSRFIv6i5qawstvcXCV0grm9T79lVPvCzM2LZa508XUWo9kBU
        S/0aQRVNxuJ6NmFhYDpsFvZ4y6RpTJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389--FRRzkK1NtS5nisEDRQ31g-1; Tue, 10 Mar 2020 07:04:45 -0400
X-MC-Unique: -FRRzkK1NtS5nisEDRQ31g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AB9218B5FAA;
        Tue, 10 Mar 2020 11:04:44 +0000 (UTC)
Received: from localhost (unknown [10.36.118.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B404B5C28E;
        Tue, 10 Mar 2020 11:04:38 +0000 (UTC)
Date:   Tue, 10 Mar 2020 11:04:37 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        dgilbert@redhat.com, mst@redhat.com,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 04/20] virtio: Implement get_shm_region for PCI transport
Message-ID: <20200310110437.GI140737@stefanha-x1.localdomain>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-5-vgoyal@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200304165845.3081-5-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zgY/UHCnsaNnNXRx"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--zgY/UHCnsaNnNXRx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2020 at 11:58:29AM -0500, Vivek Goyal wrote:
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_p=
ci_modern.c
> index 7abcc50838b8..52f179411015 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -443,6 +443,111 @@ static void del_vq(struct virtio_pci_vq_info *info)
>  =09vring_del_virtqueue(vq);
>  }
> =20
> +static int virtio_pci_find_shm_cap(struct pci_dev *dev,
> +                                   u8 required_id,
> +                                   u8 *bar, u64 *offset, u64 *len)
> +{
> +=09int pos;
> +
> +        for (pos =3D pci_find_capability(dev, PCI_CAP_ID_VNDR);

Please fix the mixed tabs vs space indentation in this patch.

> +static bool vp_get_shm_region(struct virtio_device *vdev,
> +=09=09=09      struct virtio_shm_region *region, u8 id)
> +{
> +=09struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
> +=09struct pci_dev *pci_dev =3D vp_dev->pci_dev;
> +=09u8 bar;
> +=09u64 offset, len;
> +=09phys_addr_t phys_addr;
> +=09size_t bar_len;
> +=09int ret;
> +
> +=09if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len)) {
> +=09=09return false;
> +=09}
> +
> +=09ret =3D pci_request_region(pci_dev, bar, "virtio-pci-shm");
> +=09if (ret < 0) {
> +=09=09dev_err(&pci_dev->dev, "%s: failed to request BAR\n",
> +=09=09=09__func__);
> +=09=09return false;
> +=09}
> +
> +=09phys_addr =3D pci_resource_start(pci_dev, bar);
> +=09bar_len =3D pci_resource_len(pci_dev, bar);
> +
> +        if (offset + len > bar_len) {
> +                dev_err(&pci_dev->dev,
> +                        "%s: bar shorter than cap offset+len\n",
> +                        __func__);
> +                return false;
> +        }
> +
> +=09region->len =3D len;
> +=09region->addr =3D (u64) phys_addr + offset;
> +
> +=09return true;
> +}

Missing pci_release_region()?

--zgY/UHCnsaNnNXRx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5ndEUACgkQnKSrs4Gr
c8jLYwf/exeUl3WphEdcCDBZB1FzUfCmswGzkwrT92YXIdpwgJZrl688mmhjXloi
GJqsnE3BX20JSmDOw3KlRiByhAEaz2HwKpdjT62Xq3CBRMLDemAymoDsGtjlanVK
fdmw17AJzX01wpcPW2ek87jGaHwygYHt4GFrE9NH+TiB7WVU0EfXmaF1fbVREkT1
VGzPZqY0xpWl3g12g9P0BCrftqa0PyLG29aHHG5NFs7kbTNaej5NcBOUjxEvk9jB
3mS+w/vUz7cdZPyj0BxxVjNN6udpyi83i4QdTzgLKilwD9x1VhvtnVVJiOdXOdvm
h4bns2UcpEqEvyaSsVzo3jlYx+OeRw==
=74o7
-----END PGP SIGNATURE-----

--zgY/UHCnsaNnNXRx--

