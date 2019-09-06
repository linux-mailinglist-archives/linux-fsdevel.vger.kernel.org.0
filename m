Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E47E3AB7A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 14:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391477AbfIFMDM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 08:03:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389504AbfIFMDL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:03:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7EC002F30C1;
        Fri,  6 Sep 2019 12:03:11 +0000 (UTC)
Received: from localhost (ovpn-117-208.ams2.redhat.com [10.36.117.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB1B05D784;
        Fri,  6 Sep 2019 12:03:10 +0000 (UTC)
Date:   Fri, 6 Sep 2019 13:03:09 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 15/18] virtiofs: Make virtio_fs object refcounted
Message-ID: <20190906120309.GW5900@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-16-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fCmRXBY78W5odcVA"
Content-Disposition: inline
In-Reply-To: <20190905194859.16219-16-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 06 Sep 2019 12:03:11 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--fCmRXBY78W5odcVA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:48:56PM -0400, Vivek Goyal wrote:
> This object is used both by fuse_connection as well virt device. So make
> this object reference counted and that makes it easy to define life cycle
> of the object.
>=20
> Now deivce can be removed while filesystem is still mounted. This will
> cleanup all the virtqueues but virtio_fs object will still be around and
> will be cleaned when filesystem is unmounted and sb/fc drops its referenc=
e.
>=20
> Removing a device also stops all virt queues and any new reuqest gets
> error -ENOTCONN. All existing in flight requests are drained before
> ->remove returns.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 52 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 43 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 01bbf2c0e144..29ec2f5bbbe2 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -37,6 +37,7 @@ struct virtio_fs_vq {
> =20
>  /* A virtio-fs device instance */
>  struct virtio_fs {
> +	struct kref refcount;
>  	struct list_head list;    /* on virtio_fs_instances */
>  	char *tag;
>  	struct virtio_fs_vq *vqs;
> @@ -63,6 +64,27 @@ static inline struct fuse_pqueue *vq_to_fpq(struct vir=
tqueue *vq)
>  	return &vq_to_fsvq(vq)->fud->pq;
>  }
> =20
> +static void release_virtiofs_obj(struct kref *ref)
> +{
> +	struct virtio_fs *vfs =3D container_of(ref, struct virtio_fs, refcount);
> +
> +	kfree(vfs->vqs);
> +	kfree(vfs);
> +}
> +
> +static void virtiofs_put(struct virtio_fs *fs)

Why do the two function names above contain "virtiofs" instead
of "virtio_fs"?  I'm not sure if this is intentional and is supposed to
mean something, but it's confusing.

> +{
> +	mutex_lock(&virtio_fs_mutex);
> +	kref_put(&fs->refcount, release_virtiofs_obj);
> +	mutex_unlock(&virtio_fs_mutex);
> +}
> +
> +static void virtio_fs_put(struct fuse_iqueue *fiq)

Minor issue: this function name is confusingly similar to
virtiofs_put().  Please rename to virtio_fs_fiq_put().

--fCmRXBY78W5odcVA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1ySv0ACgkQnKSrs4Gr
c8gi5QgAiBUMFExTxgTgb6RrUfkYvhvR0YjuN8ik/lgPSvOOVMtT6LMM77ysQauR
LdWnlChQQCMbdamE0Z1RjdPlj461cs3RjPH7QHZtimEOeYBUQegMuOx2aPcLj55u
LCaJauSLzpxYlNKcEFKlmrfaVNAoFRFcFMsAUt5qekoK1mhtcFQ1TYwXyJdqObUY
sYK5tPk2nJvMkeRHr84V8fpI0WiyQU+6okJnEfNUYmx+p1qn7VjIPsGq+Yz4MLF8
baWiJFLjWRFvW6STaaams5Yx4VI3jNtUI7qvikpuOkYWzwQfvv6qbH/RDYk5j5d1
/yxvM1H6W/rDyI1qYOi1etkBab+HEg==
=p10d
-----END PGP SIGNATURE-----

--fCmRXBY78W5odcVA--
