Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49148ADCD0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 18:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731903AbfIIQMZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 12:12:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53945 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbfIIQMZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 12:12:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7FFF785545;
        Mon,  9 Sep 2019 16:12:25 +0000 (UTC)
Received: from localhost (ovpn-117-107.ams2.redhat.com [10.36.117.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 099BF10013D9;
        Mon,  9 Sep 2019 16:12:19 +0000 (UTC)
Date:   Mon, 9 Sep 2019 18:12:15 +0200
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 15/18] virtiofs: Make virtio_fs object refcounted
Message-ID: <20190909161215.GE20875@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-16-vgoyal@redhat.com>
 <20190906120309.GW5900@stefanha-x1.localdomain>
 <20190906135032.GD22083@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sfyO1m2EN8ZOtJL6"
Content-Disposition: inline
In-Reply-To: <20190906135032.GD22083@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 09 Sep 2019 16:12:25 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--sfyO1m2EN8ZOtJL6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 06, 2019 at 09:50:32AM -0400, Vivek Goyal wrote:
> On Fri, Sep 06, 2019 at 01:03:09PM +0100, Stefan Hajnoczi wrote:
> > On Thu, Sep 05, 2019 at 03:48:56PM -0400, Vivek Goyal wrote:
> > > This object is used both by fuse_connection as well virt device. So m=
ake
> > > this object reference counted and that makes it easy to define life c=
ycle
> > > of the object.
> > >=20
> > > Now deivce can be removed while filesystem is still mounted. This will
> > > cleanup all the virtqueues but virtio_fs object will still be around =
and
> > > will be cleaned when filesystem is unmounted and sb/fc drops its refe=
rence.
> > >=20
> > > Removing a device also stops all virt queues and any new reuqest gets
> > > error -ENOTCONN. All existing in flight requests are drained before
> > > ->remove returns.
> > >=20
> > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > ---
> > >  fs/fuse/virtio_fs.c | 52 +++++++++++++++++++++++++++++++++++++------=
--
> > >  1 file changed, 43 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > > index 01bbf2c0e144..29ec2f5bbbe2 100644
> > > --- a/fs/fuse/virtio_fs.c
> > > +++ b/fs/fuse/virtio_fs.c
> > > @@ -37,6 +37,7 @@ struct virtio_fs_vq {
> > > =20
> > >  /* A virtio-fs device instance */
> > >  struct virtio_fs {
> > > +	struct kref refcount;
> > >  	struct list_head list;    /* on virtio_fs_instances */
> > >  	char *tag;
> > >  	struct virtio_fs_vq *vqs;
> > > @@ -63,6 +64,27 @@ static inline struct fuse_pqueue *vq_to_fpq(struct=
 virtqueue *vq)
> > >  	return &vq_to_fsvq(vq)->fud->pq;
> > >  }
> > > =20
> > > +static void release_virtiofs_obj(struct kref *ref)
> > > +{
> > > +	struct virtio_fs *vfs =3D container_of(ref, struct virtio_fs, refco=
unt);
> > > +
> > > +	kfree(vfs->vqs);
> > > +	kfree(vfs);
> > > +}
> > > +
> > > +static void virtiofs_put(struct virtio_fs *fs)
> >=20
> > Why do the two function names above contain "virtiofs" instead
> > of "virtio_fs"?  I'm not sure if this is intentional and is supposed to
> > mean something, but it's confusing.
> >=20
> > > +{
> > > +	mutex_lock(&virtio_fs_mutex);
> > > +	kref_put(&fs->refcount, release_virtiofs_obj);
> > > +	mutex_unlock(&virtio_fs_mutex);
> > > +}
> > > +
> > > +static void virtio_fs_put(struct fuse_iqueue *fiq)
> >=20
> > Minor issue: this function name is confusingly similar to
> > virtiofs_put().  Please rename to virtio_fs_fiq_put().
>=20
> Fixed with ->release semantics. Replaced "virtiofs" with "virtio_fs".
>=20
>=20
> Subject: virtiofs: Make virtio_fs object refcounted
>=20
> This object is used both by fuse_connection as well virt device. So make
> this object reference counted and that makes it easy to define life cycle
> of the object.=20
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
>  fs/fuse/virtio_fs.c |   52 +++++++++++++++++++++++++++++++++++++++++++--=
-------
>  1 file changed, 43 insertions(+), 9 deletions(-)
>=20
> Index: rhvgoyal-linux-fuse/fs/fuse/virtio_fs.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- rhvgoyal-linux-fuse.orig/fs/fuse/virtio_fs.c	2019-09-06 09:24:21.1772=
45246 -0400
> +++ rhvgoyal-linux-fuse/fs/fuse/virtio_fs.c	2019-09-06 09:40:53.309245246=
 -0400
> @@ -37,6 +37,7 @@ struct virtio_fs_vq {
> =20
>  /* A virtio-fs device instance */
>  struct virtio_fs {
> +	struct kref refcount;
>  	struct list_head list;    /* on virtio_fs_instances */
>  	char *tag;
>  	struct virtio_fs_vq *vqs;
> @@ -63,6 +64,27 @@ static inline struct fuse_pqueue *vq_to_
>  	return &vq_to_fsvq(vq)->fud->pq;
>  }
> =20
> +static void release_virtio_fs_obj(struct kref *ref)
> +{
> +	struct virtio_fs *vfs =3D container_of(ref, struct virtio_fs, refcount);
> +
> +	kfree(vfs->vqs);
> +	kfree(vfs);
> +}
> +
> +static void virtio_fs_put(struct virtio_fs *fs)
> +{
> +	mutex_lock(&virtio_fs_mutex);
> +	kref_put(&fs->refcount, release_virtio_fs_obj);
> +	mutex_unlock(&virtio_fs_mutex);
> +}
> +
> +static void virtio_fs_fiq_release(struct fuse_iqueue *fiq)
> +{
> +	struct virtio_fs *vfs =3D fiq->priv;
> +	virtio_fs_put(vfs);
> +}
> +
>  static void virtio_fs_drain_queue(struct virtio_fs_vq *fsvq)
>  {
>  	WARN_ON(fsvq->in_flight < 0);
> @@ -156,8 +178,10 @@ static struct virtio_fs *virtio_fs_find_
>  	mutex_lock(&virtio_fs_mutex);
> =20
>  	list_for_each_entry(fs, &virtio_fs_instances, list) {
> -		if (strcmp(fs->tag, tag) =3D=3D 0)
> +		if (strcmp(fs->tag, tag) =3D=3D 0) {
> +			kref_get(&fs->refcount);
>  			goto found;
> +		}
>  	}
> =20
>  	fs =3D NULL; /* not found */
> @@ -519,6 +543,7 @@ static int virtio_fs_probe(struct virtio
>  	fs =3D kzalloc(sizeof(*fs), GFP_KERNEL);
>  	if (!fs)
>  		return -ENOMEM;
> +	kref_init(&fs->refcount);
>  	vdev->priv =3D fs;
> =20
>  	ret =3D virtio_fs_read_tag(vdev, fs);
> @@ -570,18 +595,18 @@ static void virtio_fs_remove(struct virt
>  {
>  	struct virtio_fs *fs =3D vdev->priv;
> =20
> +	mutex_lock(&virtio_fs_mutex);
> +	list_del_init(&fs->list);
> +	mutex_unlock(&virtio_fs_mutex);
> +
>  	virtio_fs_stop_all_queues(fs);
>  	virtio_fs_drain_all_queues(fs);
>  	vdev->config->reset(vdev);
>  	virtio_fs_cleanup_vqs(vdev, fs);
> =20
> -	mutex_lock(&virtio_fs_mutex);
> -	list_del(&fs->list);
> -	mutex_unlock(&virtio_fs_mutex);
> -
>  	vdev->priv =3D NULL;
> -	kfree(fs->vqs);
> -	kfree(fs);
> +	/* Put device reference on virtio_fs object */
> +	virtio_fs_put(fs);
>  }
> =20
>  #ifdef CONFIG_PM_SLEEP
> @@ -932,6 +957,7 @@ const static struct fuse_iqueue_ops virt
>  	.wake_forget_and_unlock		=3D virtio_fs_wake_forget_and_unlock,
>  	.wake_interrupt_and_unlock	=3D virtio_fs_wake_interrupt_and_unlock,
>  	.wake_pending_and_unlock	=3D virtio_fs_wake_pending_and_unlock,
> +	.release			=3D virtio_fs_fiq_release,
>  };
> =20
>  static int virtio_fs_fill_super(struct super_block *sb)
> @@ -1026,7 +1052,9 @@ static void virtio_kill_sb(struct super_
>  	fuse_kill_sb_anon(sb);
> =20
>  	/* fuse_kill_sb_anon() must have sent destroy. Stop all queues
> -	 * and drain one more time and free fuse devices.
> +	 * and drain one more time and free fuse devices. Freeing fuse
> +	 * devices will drop their reference on fuse_conn and that in
> +	 * turn will drop its reference on virtio_fs object.
>  	 */
>  	virtio_fs_stop_all_queues(vfs);
>  	virtio_fs_drain_all_queues(vfs);
> @@ -1060,6 +1088,10 @@ static int virtio_fs_get_tree(struct fs_
>  	struct fuse_conn *fc;
>  	int err;
> =20
> +	/* This gets a reference on virtio_fs object. This ptr gets installed
> +	 * in fc->iq->priv. Once fuse_conn is going away, it calls ->put()
> +	 * to drop the reference to this object.
> +	 */
>  	fs =3D virtio_fs_find_instance(fsc->source);
>  	if (!fs) {
>  		pr_info("virtio-fs: tag <%s> not found\n", fsc->source);
> @@ -1067,8 +1099,10 @@ static int virtio_fs_get_tree(struct fs_
>  	}
> =20
>  	fc =3D kzalloc(sizeof(struct fuse_conn), GFP_KERNEL);
> -	if (!fc)
> +	if (!fc) {
> +		virtio_fs_put(fs);
>  		return -ENOMEM;
> +	}
> =20
>  	fuse_conn_init(fc, get_user_ns(current_user_ns()), &virtio_fs_fiq_ops,
>  		       fs);

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--sfyO1m2EN8ZOtJL6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl12ed4ACgkQnKSrs4Gr
c8g8bQf2MSE24P3X0lOlkfT51NkrycUeWtqd+Pygw0RLRPWij16Yd/rTy/BB0hIw
WHkiOJ1GDa4IYJf/U5j6+w4zVFZE3qm/I8HOe5AqfvGpYeAn6AOWva6znzR7qV/u
gDt88TZo10+IWzmp5H2+qEAcFbn0Cnn3q0d04Ut3WQrSqwkeWQIB4eBZknHpbSw+
kKzITF6iA0H+vqsfBmNnmws2BQ0wL0Erf6+JlfnyVRPSHnbzFauSd2m9Jj0UEqev
qoPFoMa8oweGYAv6TVuN0CgI8/vvm61KIA9AlSPA4mXtoUs7gMSIE/bb1yk06hEw
S+L+/ftks94cfb+mRg56fGzyJMsJ
=21aq
-----END PGP SIGNATURE-----

--sfyO1m2EN8ZOtJL6--
