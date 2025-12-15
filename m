Return-Path: <linux-fsdevel+bounces-71347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A898DCBE6E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 15:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 717D0300217B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 14:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD3D34C80D;
	Mon, 15 Dec 2025 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6G+RgzD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA6C3469F2
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765809137; cv=none; b=Il33ifRcyn2V4viXqtYpuhBs7e4RdRRjxy0X2/KthyftM4alDVrTsUYLDViOM93OY8fSRDll05vWAmubPPQqQzbapVm1Jhp6YeiD/EQOA8t03exN+tNl4vXjtiAoBvZzJiJ7zfVPe5D8+XAUBqpaME41K8RYgkpf4/xdYHwryc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765809137; c=relaxed/simple;
	bh=VLk0i/NYaHQVpTmIt0fcgx5av6WUcfbyBsjOtROhLjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtxmhZ98tbqf516X/FJfk4QOmHYjj3J90ugfkm5u0IG/+HWmxG2VXXxcJ8DVYdG+bIFSl/wFNDtz6ScWP2N9Q6MHteWbovyu8h7GnX9LGXSVDz1TUlBYGKo1tIYC/IVCV4OWrHYI7DbYZgW9PFYCIM90EPgqJ4qGqDoS1xzAj1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L6G+RgzD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765809134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XQmtRJhrvldzP3zRFFCgw8Z+zWn0PLlT0InwVYiSlxo=;
	b=L6G+RgzDvkNH2odEZ/0aBxo2Im7oneL3Z7AZOSGlF2Vd766vi2WmC95EEwwfVtUwIbN+eo
	OaOOePLqqPVoipEhVNbIYNOpHJ2swnd2MWLav4EySRXHVDqjjRDJAenzhgSEl9Y5T99Jko
	6V0EVn8b7aXWkAe/aeGzbE8L4FMx9uI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-1_u3H66XO0O8C7r6ltSNxw-1; Mon,
 15 Dec 2025 09:32:11 -0500
X-MC-Unique: 1_u3H66XO0O8C7r6ltSNxw-1
X-Mimecast-MFC-AGG-ID: 1_u3H66XO0O8C7r6ltSNxw_1765809129
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74CCE1800621;
	Mon, 15 Dec 2025 14:32:09 +0000 (UTC)
Received: from localhost (unknown [10.2.16.117])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 64F341955F21;
	Mon, 15 Dec 2025 14:32:08 +0000 (UTC)
Date: Mon, 15 Dec 2025 09:32:07 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Qianchang Zhao <pioooooooooip@gmail.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhitong Liu <liuzhitong1993@gmail.com>, stable@vger.kernel.org,
	Alok Tiwari <alok.a.tiwari@oracle.com>
Subject: Re: [PATCH] virtiofs: fix NULL dereference in
 virtio_fs_add_queues_sysfs()
Message-ID: <20251215143207.GC19970@fedora>
References: <20251213012829.685605-1-pioooooooooip@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LOuCmyU5AYYXeXj4"
Content-Disposition: inline
In-Reply-To: <20251213012829.685605-1-pioooooooooip@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


--LOuCmyU5AYYXeXj4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 13, 2025 at 10:28:29AM +0900, Qianchang Zhao wrote:
> virtio_fs_add_queues_sysfs() creates per-queue sysfs kobjects via
> kobject_create_and_add(). The current code checks the wrong variable
> after the allocation:
>=20
> - kobject_create_and_add() may return NULL on failure.
> - The code incorrectly checks fs->mqs_kobj (the parent kobject), which is
>   expected to be non-NULL at this point.
> - If kobject_create_and_add() fails, fsvq->kobj is NULL but the code can
>   still call sysfs_create_group(fsvq->kobj, ...), leading to a NULL point=
er
>   dereference and kernel panic (DoS).
>=20
> Fix by validating fsvq->kobj immediately after kobject_create_and_add()
> and aborting on failure, so sysfs_create_group() is never called with a
> NULL kobject.
>=20
> Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
> Reported-by: Zhitong Liu <liuzhitong1993@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
> ---
>  fs/fuse/virtio_fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This issue was fixed in October. It no longer exists in mainline Linux:

  commit c014021253d77cd89b2d8788ce522283d83fbd40
  Author: Alok Tiwari <alok.a.tiwari@oracle.com>
  Date:   Mon Oct 27 03:46:47 2025 -0700
 =20
      virtio-fs: fix incorrect check for fsvq->kobj

> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 6bc7c97b0..b2f6486fe 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -373,7 +373,7 @@ static int virtio_fs_add_queues_sysfs(struct virtio_f=
s *fs)
> =20
>  		sprintf(buff, "%d", i);
>  		fsvq->kobj =3D kobject_create_and_add(buff, fs->mqs_kobj);
> -		if (!fs->mqs_kobj) {
> +		if (!fsvq->kobj) {
>  			ret =3D -ENOMEM;
>  			goto out_del;
>  		}
> --=20
> 2.34.1
>=20

--LOuCmyU5AYYXeXj4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmlAG+cACgkQnKSrs4Gr
c8jOXgf+IJyYgDN+7FhPHBih2tiL96tciiQtS5FpAjegchA4Y4qFMEc7Sg0BoxKm
Ply8O4IRDPzTQMxUR9d77OeAPZxOD1feZpIbFB4Euv7Nd/FwdxW4wg8hqVDMXuU0
IHvhRnHnynGVlxWiQh0j5cUDhbAUSnFBVA816W6t1bz+3zz4kllgKMWWxNAn/5md
i4IHV8/ZPydLLUzSAQ7Ys2wwdPsp671IBD5hPG5KRSikaHTcJ030/TklV7tYUpdH
gwEvFrhMEh4ffSyFPE6lkizpgF02PCBzzWpD5hN0CMEtVK7qqyn/EMAGTisB3BwY
HkSkvQN20oBh5Hlfe9KgtvXndEhg3g==
=MWEv
-----END PGP SIGNATURE-----

--LOuCmyU5AYYXeXj4--


