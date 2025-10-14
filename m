Return-Path: <linux-fsdevel+bounces-64242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE94BDF24B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 16:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346CB188469F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 14:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFC12882A9;
	Wed, 15 Oct 2025 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2YFXYCO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE2624A06D
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539475; cv=none; b=T38VQryRqaOQrHhHIIERmKjSoncn2DZAZ843aiiCHkctePd1pWhmAdmApMJM9pVqKl0GpK5ii+KzIVtTdrw8/mvqmANUvkLe80TyyuCBqVhA3oTtSskSUA4yUE2ZqiEGpWmo93KkR+GBtAeyvl0NtFFMXh3xJFlN91xcsqO32Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539475; c=relaxed/simple;
	bh=vc0kxp4/cNB2+oGfFzBH/L9N46crZ9/uEdD4mitLxKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUSGpIrepD/7Zd+vm3TkWTTxvrljW4P2XiJ+NEporukNN+we9aInIwyxlU3rAr+YLmWnVHJhuLAKsv+Dgm4Fk4kl5Ou2J6rshu9w2huBfQe3M2MIW2t4X570p0FxQb8hU8pAzEhov8mmdQTT2sqH0ziE+L9GSiem49+PeMMbEMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W2YFXYCO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760539471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lY06pAnHCQQGigMV6SOpreP4ZC54DrBtH2Fqo3eA8fs=;
	b=W2YFXYCOILYyJuM40Cib++Oe5szvpLC0T7080FhmZF14fPBq/FGSqe48mz5sOYodlUZ6uW
	8wDULZ3dWbXNMFSt1SzVYRNz8ZbmIp8heXLJlmHlvNqE3OVH9h8VluS/ttgwM5ycm0k7pC
	fBTpCnLSt7s7pnHQW80qUViWVOasY+o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-wOZbOjvnMJWrdpUuQQnq7A-1; Wed,
 15 Oct 2025 10:44:28 -0400
X-MC-Unique: wOZbOjvnMJWrdpUuQQnq7A-1
X-Mimecast-MFC-AGG-ID: wOZbOjvnMJWrdpUuQQnq7A_1760539467
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CED1B1802D02;
	Wed, 15 Oct 2025 14:44:22 +0000 (UTC)
Received: from localhost (unknown [10.2.16.91])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E6AB19560AD;
	Wed, 15 Oct 2025 14:44:21 +0000 (UTC)
Date: Tue, 14 Oct 2025 14:53:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Wei Gong <gongwei833x@gmail.com>
Cc: vgoyal@redhat.com, miklos@szeredi.hu, virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, Wei Gong <gongwei09@baidu.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtiofs: remove max_pages_limit in indirect descriptor
 mode
Message-ID: <20251014185356.GB18850@fedora>
References: <20251011033018.75985-1-gongwei833x@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KLkkf4S3uuImuLNm"
Content-Disposition: inline
In-Reply-To: <20251011033018.75985-1-gongwei833x@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


--KLkkf4S3uuImuLNm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 11:30:18AM +0800, Wei Gong wrote:
> From: Wei Gong <gongwei09@baidu.com>
>=20
> Currently, indirect descriptor mode unnecessarily restricts the maximum
> IO size based on virtqueue vringsize. However, the indirect descriptor
> mechanism inherently supports larger IO operations by chaining descriptor=
s.
>=20
> This patch removes the artificial constraint, allowing indirect descriptor
> mode to utilize its full potential without being limited by vringsize.
> The maximum supported descriptors per IO is now determined by the indirect
> descriptor capability rather than the virtqueue size.
>=20
> Signed-off-by: Wei Gong <gongwei09@baidu.com>
> ---
>  fs/fuse/virtio_fs.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 76c8fd0bfc75..c0d5db7d7504 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -12,6 +12,7 @@
>  #include <linux/memremap.h>
>  #include <linux/module.h>
>  #include <linux/virtio.h>
> +#include <linux/virtio_ring.h>
>  #include <linux/virtio_fs.h>
>  #include <linux/delay.h>
>  #include <linux/fs_context.h>
> @@ -1701,9 +1702,11 @@ static int virtio_fs_get_tree(struct fs_context *f=
sc)
>  	fc->sync_fs =3D true;
>  	fc->use_pages_for_kvec_io =3D true;
> =20
> -	/* Tell FUSE to split requests that exceed the virtqueue's size */
> -	fc->max_pages_limit =3D min_t(unsigned int, fc->max_pages_limit,
> -				    virtqueue_size - FUSE_HEADER_OVERHEAD);
> +	if (!virtio_has_feature(fs->vqs[VQ_REQUEST].vq->vdev, VIRTIO_RING_F_IND=
IRECT_DESC)) {
> +		/* Tell FUSE to split requests that exceed the virtqueue's size */
> +		fc->max_pages_limit =3D min_t(unsigned int, fc->max_pages_limit,
> +						virtqueue_size - FUSE_HEADER_OVERHEAD);
> +	}

The VIRTIO 1.3 specification defines the maximum descriptor chain length
as follows
(https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.htm=
l#x1-9200019):

  The number of descriptors in the table is defined by the queue size for t=
his virtqueue: this is the maximum possible descriptor chain length.

The driver requirements for indirect descriptors say
(https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.htm=
l#x1-9200019):

  A driver MUST NOT create a descriptor chain longer than allowed by the de=
vice.

My interpretation is that this patch violates the specification because
it allows descriptor chains that exceed the maximum possible descriptor
chain length.

Device implementations are not required to enforce this limit, so you
may not see issues when testing. Nevertheless, this patch has the
potential to break other device implementations though that work fine
today, so it doesn't seem safe to merge this patch in its current form.

I have CCed Michael Tsirkin in case he has thoughts. It would be nice to
boost performance by allowing longer I/O requests, but the driver must
comply with the VIRTIO specification.

Thanks,
Stefan

--KLkkf4S3uuImuLNm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjunEQACgkQnKSrs4Gr
c8gY4AgAwYxD8aWhcoZfM+pzPo0gCmNWuRts/Zo+DIFcpLzmcxAshn0nfg//UbVy
tvoYZpLl1lZHClyTJnIjP4S/IC7BVbKmsSz8i6GqqwV5LEPi8YvWhymRCrJystCd
g3PqCjbLWMNCraPqbCQd6rJVYUcMN2EFGVRuCzxjiCxb1oTZ9XlS8Py/zFBFIotB
MfH5twFvkiytRn7spAhSaimouS5vHtVXfFAIR9TNP6YHJBLKros2TiT/h1jFBu1i
tGr7yVwSuVpj/bcGD6aBCODRRD0CZXeBZrOxFWJVHGxLeWuzr5xffyNfHWTJMWRa
brUn11uX+2DzCyhtu1nDf5wISCZWyw==
=wtH5
-----END PGP SIGNATURE-----

--KLkkf4S3uuImuLNm--


