Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4743E34499C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 16:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhCVPsA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 11:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52123 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230299AbhCVPrv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616428070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kF05X3XUjORG7bqce6qEvZk7r7MroqA/dhygkFI8iGg=;
        b=LqBZStzmGFbhydbAXSnuhoTMLTHUDz5dK4gM/Qm1s7G2EAVf8gXKNQ9DgoOtViOx/juWIA
        NdKLJv0XbJeyk7u6UHESHgdg9OjXFxNAtA8TF30P2fMmCi/LrKrqe+tkqwm2/FsAyvSPhQ
        V0wlfTfVdNrcA4tfdahl+7wXhGdYVtY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-QYnxL-zNOQmSnNKMTqai6Q-1; Mon, 22 Mar 2021 11:47:48 -0400
X-MC-Unique: QYnxL-zNOQmSnNKMTqai6Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A541110866A9;
        Mon, 22 Mar 2021 15:47:46 +0000 (UTC)
Received: from localhost (ovpn-114-89.ams2.redhat.com [10.36.114.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CEDF10023AB;
        Mon, 22 Mar 2021 15:47:39 +0000 (UTC)
Date:   Mon, 22 Mar 2021 15:47:37 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Connor Kuehl <ckuehl@redhat.com>
Cc:     virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, vgoyal@redhat.com,
        miklos@szeredi.hu, jasowang@redhat.com, mst@redhat.com
Subject: Re: [PATCH 2/3] virtiofs: split requests that exceed virtqueue size
Message-ID: <YFi8GYrRG/ks2BBz@stefanha-x1.localdomain>
References: <20210318135223.1342795-1-ckuehl@redhat.com>
 <20210318135223.1342795-3-ckuehl@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EBlwIFYriryzFVKW"
Content-Disposition: inline
In-Reply-To: <20210318135223.1342795-3-ckuehl@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--EBlwIFYriryzFVKW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 18, 2021 at 08:52:22AM -0500, Connor Kuehl wrote:
> If an incoming FUSE request can't fit on the virtqueue, the request is
> placed onto a workqueue so a worker can try to resubmit it later where
> there will (hopefully) be space for it next time.
>=20
> This is fine for requests that aren't larger than a virtqueue's maximum
> capacity. However, if a request's size exceeds the maximum capacity of
> the virtqueue (even if the virtqueue is empty), it will be doomed to a
> life of being placed on the workqueue, removed, discovered it won't fit,
> and placed on the workqueue yet again.
>=20
> Furthermore, from section 2.6.5.3.1 (Driver Requirements: Indirect
> Descriptors) of the virtio spec:
>=20
>   "A driver MUST NOT create a descriptor chain longer than the Queue
>   Size of the device."
>=20
> To fix this, limit the number of pages FUSE will use for an overall
> request. This way, each request can realistically fit on the virtqueue
> when it is decomposed into a scattergather list and avoid violating
> section 2.6.5.3.1 of the virtio spec.
>=20
> Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
> ---
>  fs/fuse/fuse_i.h    |  5 +++++
>  fs/fuse/inode.c     |  7 +++++++
>  fs/fuse/virtio_fs.c | 14 ++++++++++++++
>  3 files changed, 26 insertions(+)

Nice that FUSE already has max_pages :-).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--EBlwIFYriryzFVKW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmBYvBkACgkQnKSrs4Gr
c8gL7Qf+MIRWqCCYkNEZwL6tftu8+lg4QxBigZvpmryZKX9xCLbLzcTZuUzPQC6I
HiFj77t2jUhUbSv9edImKSWoSYad0kT0bCsWnwghojx+ta5lIXveKMwv4qHCkF9J
CsnZqKYSW+9gCyjC/mCLLl1lHKSoSHJsDSVuJQ7gwlGg1n1Bv5IKE4ZX2+hlXGY3
FWtCTz17sqzrlCIceUnG5jN10TcXqsXSDEH3oOV6ZSWl8HTXWFyJjcRWau4u9S2R
iIZJEcByDMVqWWCHWVySksdompYzM9xFbXLebPE5Rnn9BaK5m/BdISHbS1R5dZaU
LPExG+DiEtEx/j/imqIq7YtJlXxA5g==
=KXHl
-----END PGP SIGNATURE-----

--EBlwIFYriryzFVKW--

