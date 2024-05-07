Return-Path: <linux-fsdevel+bounces-18904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D228BE4EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 15:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845221C21F34
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 13:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FCA165FB7;
	Tue,  7 May 2024 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csCA39ST"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B3615E5C1
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090065; cv=none; b=Rcjg+/yYJ2NKj8ZA5JuM8xkBRVnOJiK8aj7VU7ePygh8w3tWWqjSjn41HzQStgWNB8MOq3gGkbmbfs0Zmc+6KJglPCMMkOEdHaZkJcVdNtbqE9MBtLltxUhoJucP7H5EOlJ8Xx/NNg0JTYTbV/VhPg15I81aYlJpv4ro1W4OCHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090065; c=relaxed/simple;
	bh=ERW5q7wnngZEdZKlqzXvkDU6yQ2Wbilvd1EmCCUY1Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feRBMgcCojd5m+Jaz84BBGPbQ6hK/WHXzVvAhjtjVIi+z+roBP+SL7cbpqENhbySGtWyfo+badTlDBZnQ6nPByv31PCFVYVyG3Stn2B6tg0nqwPHci/xk2ttrhDtXcSykC4UeX8lIadSGiCi3tBES/CxCnbp0eQZ5+XSYk2dZJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=csCA39ST; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715090063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sv9p74SCFBlXhAt6IfoxgP71zbImKxKcycl4SsrCyCw=;
	b=csCA39STdHsKT06I/IEQv4mW731Srewtm2AkPKwaPHYEzFlNNirJe6nORww8eqBANKiaFH
	61IklHxTcOfzgYgf4WcKY38aYBagNrn5yfWs2GVAfNt+xNvHfgBRciRpo+sWJFQR075FiE
	wiFxPXkjBxTv+d5iezPp/wGZfSpfuHM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-xaoAMLx6OL2sbI5BQMvi2Q-1; Tue,
 07 May 2024 09:54:21 -0400
X-MC-Unique: xaoAMLx6OL2sbI5BQMvi2Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 155D13C0DF67
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 13:54:21 +0000 (UTC)
Received: from localhost (unknown [10.39.192.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8CCC040C6EB7;
	Tue,  7 May 2024 13:54:20 +0000 (UTC)
Date: Tue, 7 May 2024 09:54:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: mszeredi@redhat.com
Cc: linux-fsdevel@vger.kernel.org, vgoyal@redhat.com, bfoster@redhat.com
Subject: Re: [PATCH v2] virtiofs: use string format specifier for sysfs tag
Message-ID: <20240507135419.GB105913@fedora.redhat.com>
References: <20240506185713.58678-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ajChN7AjkvtlthX4"
Content-Disposition: inline
In-Reply-To: <20240506185713.58678-1-bfoster@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


--ajChN7AjkvtlthX4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024 at 02:57:13PM -0400, Brian Foster wrote:
> The existing emit call is a vector for format string injection. Use
> the string format specifier to avoid this problem.
>=20
> Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>=20
> v2:
> - Drop newline.
> v1: https://lore.kernel.org/linux-fsdevel/20240425104400.30222-1-bfoster@=
redhat.com/
>=20
>  fs/fuse/virtio_fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 322af827a232..d5cb300367ed 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -170,7 +170,7 @@ static ssize_t tag_show(struct kobject *kobj,
>  {
>  	struct virtio_fs *fs =3D container_of(kobj, struct virtio_fs, kobj);
> =20
> -	return sysfs_emit(buf, fs->tag);
> +	return sysfs_emit(buf, "%s", fs->tag);
>  }

Miklos: Would it be possible to change the format string to "%s\n" (with
a newline) in this patch and merged for v6.9?

v6.9 will be the first kernel release with this new sysfs attr and I'd
like to get the formatting right. Once a kernel is released I would
rather not change the sysfs attr's format to avoid breaking userspace,
hence the urgency.

Thank you,
Stefan

--ajChN7AjkvtlthX4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmY6MosACgkQnKSrs4Gr
c8iocwgAn50+5bE6fNltEElg1i1C4WSgkMLH8TZtnX4W0q5LZQrHLVp1enO/pHH1
lYCPFIbcoBc2RqJuthXIt0kz5LxTKd6XroMtYPGWpsi1AiBLqeDGBlbXujM0N6zk
GlDJmFf1Pycw95mvhLooDwDnkaFrann8nY7r5VMNB+ykqDCoij7vngGaNC7h9ZEg
bPblJasXzmfFCWhwRSxaOan9ry6Fcn0/dqwLKX+QIjDtI0Ckmdv6+AS3NWTJpQzJ
ASPB9H/HC6V/ZYwu2I+34tt2EEOCsJqvRGSF80sdO0YP+lAXw4XBrDqSenzhzZbf
vH0gth9686pmyO2nkYm/HD4+IVBSkA==
=EfGO
-----END PGP SIGNATURE-----

--ajChN7AjkvtlthX4--


