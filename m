Return-Path: <linux-fsdevel+bounces-10945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE1084F514
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 13:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECB0EB22FB3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047D631758;
	Fri,  9 Feb 2024 12:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAHW9tdV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA30931A82
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707480945; cv=none; b=MWIx/sALygISskjGli42h3ITvPKRIZSiUORSTWD4wQDXoCSlooBC3DNjzmPO1RCVu3yphNHJKEHnV1wxvCBqEbzGSKD5fsQND0QQvtNo9ikQ8NeGyrX7LeomfLXxp7tgZsz8oGw4Na1YSMSPPfacsR56sYwu48gMunXOW79Yrvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707480945; c=relaxed/simple;
	bh=e79MOPaRbllW9/C4S/Z+oXRmRTxBzW+Gz2JxEgu7tyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6AuJ8BiLTRB6reJj2LJ1cO/KVg7pCcLVJ+iCdphe/QN+ULFIJjucVefQijSbYjFkV0E0nQNwzXdZY8Y6KKovcEQXKHhZ4YoOjNilz7sywHzjfkNoS1O4nwxwwhMCaqLrfmfbM6iqroHWcY/X9wrAVxuAT0DQtBR1bkSD+C/7z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAHW9tdV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707480938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GN80HCnPEnqEWtK9KmJd4ZzgmyniZlrwmVQxfEJJizc=;
	b=cAHW9tdVmo3dYG7UwQgUEdPPDo+4etB/hv8biKL6znJZKyXbdY73VOXgBGvdV5q9D8L8KN
	Y3L5cGno743E1J3uy1TpS9nv6Zs/yZK3Op4y1sm+Dq8erWv6nKxpX1jorQ287Fan+Tx7kY
	TvVYnVW9d/8pFinNS2UJCwG8Rg5ugKc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-lZEwhNVRM4i8EXIBka_5iQ-1; Fri,
 09 Feb 2024 07:15:35 -0500
X-MC-Unique: lZEwhNVRM4i8EXIBka_5iQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01B9E3C0ED55;
	Fri,  9 Feb 2024 12:15:35 +0000 (UTC)
Received: from localhost (unknown [10.39.193.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5BA3E400D29B;
	Fri,  9 Feb 2024 12:15:34 +0000 (UTC)
Date: Fri, 9 Feb 2024 07:15:32 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-fsdevel@vger.kernel.org, Alyssa Ross <hi@alyssa.is>,
	gmaglione@redhat.com, virtio-fs@lists.linux.dev, vgoyal@redhat.com,
	mzxreary@0pointer.de, miklos@szeredi.hu
Subject: Re: [PATCH v2 3/3] virtiofs: emit uevents on filesystem events
Message-ID: <20240209121532.GC748645@fedora>
References: <20240208193212.731978-1-stefanha@redhat.com>
 <20240208193212.731978-4-stefanha@redhat.com>
 <2024020943-hedge-majority-ef34@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/FiZpmtG6bhB391g"
Content-Disposition: inline
In-Reply-To: <2024020943-hedge-majority-ef34@gregkh>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


--/FiZpmtG6bhB391g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 10:39:04AM +0000, Greg KH wrote:
> On Thu, Feb 08, 2024 at 02:32:11PM -0500, Stefan Hajnoczi wrote:
> > Alyssa Ross <hi@alyssa.is> requested that virtiofs notifies userspace
> > when filesytems become available. This can be used to detect when a
> > filesystem with a given tag is hotplugged, for example. uevents allow
> > userspace to detect changes without resorting to polling.
> >=20
> > The tag is included as a uevent property so it's easy for userspace to
> > identify the filesystem in question even when the sysfs directory goes
> > away during removal.
> >=20
> > Here are example uevents:
> >=20
> >   # udevadm monitor -k -p
> >=20
> >   KERNEL[111.113221] add      /fs/virtiofs/2 (virtiofs)
> >   ACTION=3Dadd
> >   DEVPATH=3D/fs/virtiofs/2
> >   SUBSYSTEM=3Dvirtiofs
> >   TAG=3Dtest
> >=20
> >   KERNEL[165.527167] remove   /fs/virtiofs/2 (virtiofs)
> >   ACTION=3Dremove
> >   DEVPATH=3D/fs/virtiofs/2
> >   SUBSYSTEM=3Dvirtiofs
> >   TAG=3Dtest
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  fs/fuse/virtio_fs.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >=20
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index 28e96b7cde00..18a8f531e5d4 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -270,6 +270,17 @@ static void virtio_fs_start_all_queues(struct virt=
io_fs *fs)
> >  	}
> >  }
> > =20
> > +static void virtio_fs_uevent(struct virtio_fs *fs, enum kobject_action=
 action)
> > +{
> > +	char tag_str[sizeof("TAG=3D") +
> > +		     sizeof_field(struct virtio_fs_config, tag) + 1];
> > +	char *envp[] =3D {tag_str, NULL};
> > +
> > +	snprintf(tag_str, sizeof(tag_str), "TAG=3D%s", fs->tag);
> > +
> > +	kobject_uevent_env(&fs->kobj, action, envp);
> > +}
> > +
> >  /* Add a new instance to the list or return -EEXIST if tag name exists=
*/
> >  static int virtio_fs_add_instance(struct virtio_device *vdev,
> >  				  struct virtio_fs *fs)
> > @@ -309,6 +320,8 @@ static int virtio_fs_add_instance(struct virtio_dev=
ice *vdev,
> > =20
> >  	mutex_unlock(&virtio_fs_mutex);
> > =20
> > +	virtio_fs_uevent(fs, KOBJ_ADD);
>=20
> Why do you have to explicitly ask for the event?  Doesn't sysfs trigger
> this for you automatically?  Set the kset uevent callback for this,
> right?

I haven't found a way to get an implicit KOBJ_ADD uevent. device_add()
and other kset_uevent_ops users emit KOBJ_ADD manually too. Grepping for
KOBJ_ADD in fs/sysfs/ and lib/ doesn't produce any useful results
either.

It is possible to eliminate the explicit KOBJ_REMOVE though because
kobject_del() already calls it. I will fix that and switch to
kset_uevent_ops->uevent().

Thanks,
Stefan

--/FiZpmtG6bhB391g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXGF2QACgkQnKSrs4Gr
c8g1UAf/S5yE/egI+P0Q+DB28udaKIV1yPl+kl01D1ZlZUnqvrS72ocK+8XVdUX/
Kk/x/LQTRqMfMrmvsEBv6prGpp7PSSSKS2/s2oD4eEWBiK7QJSrjhzxtRPdU4OGk
6LuxD3p95LIaBXqMF88Hwwi17MNNz+3QqtJhQMC3Kpx2D97AEOYNuFHmlifl/X8G
zNbbTLVFKcUEt4AxsTvga6jzabrrlwrk56pZfN0GG/JXjWg+BsXMhYI3N5fbz/OY
jNtuO9vVN60RZHwjWZtK1dTIChVxU2z0v9a1nLOk02TsihWNl4xTa78TuKp7QNz4
r6iP0npz3i4ShN1iMSQ9Bi8iLJPeeA==
=+kc1
-----END PGP SIGNATURE-----

--/FiZpmtG6bhB391g--


