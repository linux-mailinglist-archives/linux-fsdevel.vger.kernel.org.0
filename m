Return-Path: <linux-fsdevel+bounces-10936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F93284F4AC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7DE281A63
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7B72E400;
	Fri,  9 Feb 2024 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XomXkdtQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06073FEC
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478419; cv=none; b=XxLAYk8n++wApYBfcJYtB/CgBUKBNLeNSEQoV2K6QawgUS5333KlaF9Oex6J0hEI8mKaC0kwk6GYRcjl7w7grmJvoXsIZLRq9BdEkX/XbYX1vvxkU9OI1ds7gXD5/mGo0GCXNKC73oZejmDtw8ihO/9M5QYbflpWKO/wAJzgpYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478419; c=relaxed/simple;
	bh=gskku9cB1cMp8o4K7vg9hH0jCdjVsxNAnucSHXg19KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfzBl55pXIXBGT2zE+275nPfO+v0IVziCX1WAB/sXQ38+JPvPdlQbSoicDq6OhFBzT3f+m5phLBX2SgKYfjHD3JDs7HQ28zxFAUkO9ZFZMu1W0UUhnS0bvi288nLQxmBAYswwiWeCCov7wLZNg/qaGny44R4psu/h1D5w4FnjIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XomXkdtQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707478412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zx0enADi5XLBrWdavlIwqlu/KPv6Ahk5X3LE1jkjPR8=;
	b=XomXkdtQypEO2e51nzZ02sJ868WWbyKvSMvW+SJCqon1hNdEMPXxmH8eF9Oe2GwLN52hjq
	QsmQKR80QcOzptj0eUdZIgspAqbDMhGDVkBzc2PJaCPS/df2UiER4aTzXZx324XKikD3PL
	s9VG+QuqFuTQc7dQwiZ097RWcuHks+M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-PsFqdLq9Pfu6NnE8SQkr3w-1; Fri,
 09 Feb 2024 06:33:31 -0500
X-MC-Unique: PsFqdLq9Pfu6NnE8SQkr3w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89EAB1C05133;
	Fri,  9 Feb 2024 11:33:30 +0000 (UTC)
Received: from localhost (unknown [10.39.193.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F15391C14B04;
	Fri,  9 Feb 2024 11:33:29 +0000 (UTC)
Date: Fri, 9 Feb 2024 06:33:28 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-fsdevel@vger.kernel.org, Alyssa Ross <hi@alyssa.is>,
	gmaglione@redhat.com, virtio-fs@lists.linux.dev, vgoyal@redhat.com,
	mzxreary@0pointer.de, miklos@szeredi.hu
Subject: Re: [PATCH v2 2/3] virtiofs: export filesystem tags through sysfs
Message-ID: <20240209113328.GB748645@fedora>
References: <20240208193212.731978-1-stefanha@redhat.com>
 <20240208193212.731978-3-stefanha@redhat.com>
 <2024020940-stinking-encrust-3754@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PucRtjx1X61weNtr"
Content-Disposition: inline
In-Reply-To: <2024020940-stinking-encrust-3754@gregkh>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7


--PucRtjx1X61weNtr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 10:36:47AM +0000, Greg KH wrote:
> On Thu, Feb 08, 2024 at 02:32:10PM -0500, Stefan Hajnoczi wrote:
> > The virtiofs filesystem is mounted using a "tag" which is exported by
> > the virtiofs device:
> >=20
> >   # mount -t virtiofs <tag> /mnt
> >=20
> > The virtiofs driver knows about all the available tags but these are
> > currently not exported to user space.
> >=20
> > People have asked for these tags to be exported to user space. Most
> > recently Lennart Poettering has asked for it as he wants to scan the
> > tags and mount virtiofs automatically in certain cases.
> >=20
> > https://gitlab.com/virtio-fs/virtiofsd/-/issues/128
> >=20
> > This patch exports tags at /sys/fs/virtiofs/<N>/tag where N is the id of
> > the virtiofs device. The filesystem tag can be obtained by reading this
> > "tag" file.
> >=20
> > There is also a symlink at /sys/fs/virtiofs/<N>/device that points to
> > the virtiofs device that exports this tag.
> >=20
> > This patch converts the existing struct virtio_fs into a full kobject.
> > It already had a refcount so it's an easy change. The virtio_fs objects
> > can then be exposed in a kset at /sys/fs/virtiofs/. Note that virtio_fs
> > objects may live slightly longer than we wish for them to be exposed to
> > userspace, so kobject_del() is called explicitly when the underlying
> > virtio_device is removed. The virtio_fs object is freed when all
> > references are dropped (e.g. active mounts) but disappears as soon as
> > the virtiofs device is gone.
> >=20
> > Originally-by: Vivek Goyal <vgoyal@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  fs/fuse/virtio_fs.c                         | 113 ++++++++++++++++----
> >  Documentation/ABI/testing/sysfs-fs-virtiofs |  11 ++
> >  2 files changed, 103 insertions(+), 21 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-fs-virtiofs
> >=20
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index de9a38efdf1e..28e96b7cde00 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -31,6 +31,9 @@
> >  static DEFINE_MUTEX(virtio_fs_mutex);
> >  static LIST_HEAD(virtio_fs_instances);
> > =20
> > +/* The /sys/fs/virtio_fs/ kset */
> > +static struct kset *virtio_fs_kset;
> > +
> >  enum {
> >  	VQ_HIPRIO,
> >  	VQ_REQUEST
> > @@ -55,7 +58,7 @@ struct virtio_fs_vq {
> > =20
> >  /* A virtio-fs device instance */
> >  struct virtio_fs {
> > -	struct kref refcount;
> > +	struct kobject kobj;
> >  	struct list_head list;    /* on virtio_fs_instances */
> >  	char *tag;
> >  	struct virtio_fs_vq *vqs;
> > @@ -161,18 +164,43 @@ static inline void dec_in_flight_req(struct virti=
o_fs_vq *fsvq)
> >  		complete(&fsvq->in_flight_zero);
> >  }
> > =20
> > -static void release_virtio_fs_obj(struct kref *ref)
> > +static ssize_t virtio_fs_tag_attr_show(struct kobject *kobj,
> > +		struct kobj_attribute *attr, char *buf)
> >  {
> > -	struct virtio_fs *vfs =3D container_of(ref, struct virtio_fs, refcoun=
t);
> > +	struct virtio_fs *fs =3D container_of(kobj, struct virtio_fs, kobj);
> > +
> > +	return sysfs_emit(buf, fs->tag);
> > +}
> > +
> > +static struct kobj_attribute virtio_fs_tag_attr =3D {
> > +	.attr =3D { .name =3D "tag", .mode=3D 0644 },
> > +	.show =3D virtio_fs_tag_attr_show,
> > +};
>=20
> __ATTR_RO()?
> That way we all know you got the mode setting correct :)
>=20
> Other than that minor thing, looks good, nice job!

Will fix, thanks!

Stefan

--PucRtjx1X61weNtr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXGDYgACgkQnKSrs4Gr
c8h4+Qf9Edn1M+tTRmKlrat4lz1Hu+be4PMIBUkzLziTL8pH6ydmDKXQj3Jtr44t
4yI25aUXKu92G1+VrNNqADYgAkcfOVtjImie3tCUx8QFPEa9des6ZTBoT3wxnXLZ
boL6Hym0rTW6ZoRQPd0ICgnmIuwglumO+zd/2h9hwYfOAGfzxWSNGs23i0apfWCz
GEu9wIAtj89lBzF6EJ/30k+yEILIYOiCGDNYLNL6sLe4nQXJWq2dUcp6yHygkDHv
UZP18zs9uo62Mfr8jTO1QO2Z6EaUiwrikVNEc8IlOjUD2V3cu9ro9itJCH1LabDW
xRNAlOG+KVajHZQeUnW0W5dWrGm+jw==
=ReO/
-----END PGP SIGNATURE-----

--PucRtjx1X61weNtr--


