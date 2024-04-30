Return-Path: <linux-fsdevel+bounces-18516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5388BA09C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 20:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC247284245
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 18:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799F2174EC0;
	Thu,  2 May 2024 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dx4nmPVs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA8A155350
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2024 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714675016; cv=none; b=tfA4ttLClkNneBDVnQ7gsNMGGTDeTrUoH/0wyhOJrTXhckTxJLPqrpWGJRtPoy1rHV9Hp0dzKWNB63nRPADSnxAJRY5PNBdRcaIRl4wdllb0xNAtaDdAWFp+xvnF10dMrfPW9yGXdvw+MD6mAK8AtUjTsCWBh8ZLS8SwwtzO/Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714675016; c=relaxed/simple;
	bh=7Jd/t1MEsBsVEgIH158ofhEmzGWC7oqjDoODmpFPUho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEAOr5Msr6Y5Tl5KLxHTR14Fmb0OLV3aDJbatjn4MtGL6PjRjCVwjZPdk58hwa9Mcpa0DsX/FycRquSnwB6iBBLyFBV1qmcJVkPQMWPKoWuOgyX0eRpitEtMGWQl5nj5kZsxf5RCYwvqVtt+pK+2N10+tVJBwBLogJgRic88uAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dx4nmPVs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714675014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7FViROe7005qAqOFVqWkh4VqrrCB+mh6PAICd45Tu2g=;
	b=Dx4nmPVsP/R7xb+qV7kJ/qc0npNW41xUz3BE78giJe8ytE9wDQMboYQuQvmzLulA8ykntZ
	wx+QZfipEhMOM6upUcIQRfYoAo6iAFr+16yD6CnkNz0LDRDRmTKm/X5OPlHCXuq4Ne172D
	dsQ14PUn4WAk4IYTqU9m9VaCeTsCX70=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-ESlNRw_iMuCLu4fIYGGiJg-1; Thu,
 02 May 2024 14:36:52 -0400
X-MC-Unique: ESlNRw_iMuCLu4fIYGGiJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55498385A1A9
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2024 18:36:52 +0000 (UTC)
Received: from localhost (unknown [10.39.192.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D728D200A3BB;
	Thu,  2 May 2024 18:36:51 +0000 (UTC)
Date: Tue, 30 Apr 2024 13:34:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
	vgoyal@redhat.com
Subject: Re: [PATCH] virtiofs: include a newline in sysfs tag
Message-ID: <20240430173431.GA390186@fedora.redhat.com>
References: <20240425104400.30222-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wvl5yveNVqwvREv/"
Content-Disposition: inline
In-Reply-To: <20240425104400.30222-1-bfoster@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4


--wvl5yveNVqwvREv/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 06:44:00AM -0400, Brian Foster wrote:
> The internal tag string doesn't contain a newline. Append one when
> emitting the tag via sysfs.
>=20
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>=20
> Hi all,
>=20
> I just noticed this and it seemed a little odd to me compared to typical
> sysfs output, but maybe it was intentional..? Easy enough to send a
> patch either way.. thoughts?

Hi Brian,
Orthogonal to the newline issue, sysfs_emit(buf, "%s", fs->tag) is
needed to prevent format string injection. Please mention this in the
commit description. I'm afraid I introduced that bug, sorry!

Regarding newline, I'm concerned that adding a newline might break
existing programs. Unless there is a concrete need to have the newline,
I would keep things as they are.

Stefan

>=20
> Brian
>=20
>  fs/fuse/virtio_fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 322af827a232..bb3e941b9503 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -170,7 +170,7 @@ static ssize_t tag_show(struct kobject *kobj,
>  {
>  	struct virtio_fs *fs =3D container_of(kobj, struct virtio_fs, kobj);
> =20
> -	return sysfs_emit(buf, fs->tag);
> +	return sysfs_emit(buf, "%s\n", fs->tag);
>  }
> =20
>  static struct kobj_attribute virtio_fs_tag_attr =3D __ATTR_RO(tag);
> --=20
> 2.44.0
>=20

--wvl5yveNVqwvREv/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmYxK6cACgkQnKSrs4Gr
c8igmgf/Ypvi1sLEQZaVTpKEXtqzY06Q4ShegKyAzSv6X2pWdsEHHaA1f5o53ig4
0AKZeo3N5Ihwx64t85Z+hG2AFxdFGiSaXe9NFJOe9ERKNenMl3RLC/xprTF7J+NP
v6e2w0805h3f3YnWz3Ih21sJyptcWaKzpb18VsYaM4msPMJY9WXO6ky1UAkgXT04
GP/voOj0aZjQ5zvcsTV7CLQcD8e65vEqHl1ccngwr9rizTKBBQUjJUmv+SCWxVk6
XItfa5SPAf+V4JJLoTQrAracSGTpBEFigp7eczD/DDgpchCATqBubLAVsXX9mRVL
EeQb6DeDOuvt+jnITV/phRqVJ4I+lg==
=Ftg7
-----END PGP SIGNATURE-----

--wvl5yveNVqwvREv/--


