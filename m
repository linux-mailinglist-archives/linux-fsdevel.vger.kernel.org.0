Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8591057BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 18:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKURAb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 12:00:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32254 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726293AbfKURAa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574355628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Honbl4Zku5a5XsQymvDZvAXgJz3hAEThX385Nai6VrU=;
        b=SSMuFE9mekjIZ9VLSP3vwXCi3pLW4A2bQvNYxjMLjzDcb+0qRtfqSefE5NIXKUaUYFHSNb
        yLEFo6a0iAj7DO69wc1fBjReLURrXenxz5JRZ51tYX0wIDYSVnbfGq/A//OTlbftB4GtBN
        u09Gyy8tlkhBbGazxPb1rz8xZWprhdM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-8s09F0nEN2aECugKf6hkMQ-1; Thu, 21 Nov 2019 12:00:25 -0500
X-MC-Unique: 8s09F0nEN2aECugKf6hkMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BDB518B5F6D;
        Thu, 21 Nov 2019 17:00:24 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80E0C1823F;
        Thu, 21 Nov 2019 17:00:21 +0000 (UTC)
Date:   Thu, 21 Nov 2019 17:00:20 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dgilbert@redhat.com,
        miklos@szeredi.hu
Subject: Re: [PATCH 4/4] virtiofs: Support blocking posix locks
 (fcntl(F_SETLKW))
Message-ID: <20191121170020.GE445244@stefanha-x1.localdomain>
References: <20191115205705.2046-1-vgoyal@redhat.com>
 <20191115205705.2046-5-vgoyal@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191115205705.2046-5-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="84ND8YJRMFlzkrP4"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--84ND8YJRMFlzkrP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2019 at 03:57:05PM -0500, Vivek Goyal wrote:
> As of now we don't support blocking variant of posix locks and daemon ret=
urns
> -EOPNOTSUPP. Reason being that it can lead to deadlocks. Virtqueue size i=
s
> limited and it is possible we fill virtqueue with all the requests of
> fcntl(F_SETLKW) and wait for reply. And later a subsequent unlock request
> can't make progress because virtqueue is full. And that means F_SETLKW ca=
n't
> make progress and we are deadlocked.
>=20
> Use notification queue to solve this problem. After submitting lock reque=
st
> device will send a reply asking requester to wait. Once lock is available=
,
> requester will get a notification saying locking is available. That way
> we don't keep the request virtueue busy while we are waiting for lock
> and further unlock requests can make progress.
>=20
> When we get a reply in response to lock request, we need a way to know if
> we need to wait for notification or not. I have overloaded the
> fuse_out_header->error field. If value is ->error is 1, that's a signal
> to caller to wait for lock notification.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c       | 78 ++++++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/fuse.h |  7 ++++
>  2 files changed, 84 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 21d8d9d7d317..8aa9fc996556 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -35,6 +35,7 @@ struct virtio_fs_vq {
>  =09struct work_struct done_work;
>  =09struct list_head queued_reqs;
>  =09struct list_head end_reqs;=09/* End these requests */
> +=09struct list_head wait_reqs;=09/* requests waiting for notification */
>  =09struct virtio_fs_notify_node *notify_nodes;
>  =09struct list_head notify_reqs;=09/* List for queuing notify requests *=
/
>  =09struct delayed_work dispatch_work;
> @@ -85,7 +86,6 @@ struct virtio_fs_notify_node {
> =20
>  static int virtio_fs_enqueue_all_notify(struct virtio_fs_vq *fsvq);
> =20
> -
>  static inline struct virtio_fs_vq *vq_to_fsvq(struct virtqueue *vq)
>  {
>  =09struct virtio_fs *fs =3D vq->vdev->priv;
> @@ -513,13 +513,75 @@ static int virtio_fs_enqueue_all_notify(struct virt=
io_fs_vq *fsvq)
>  =09return 0;
>  }
> =20
> +static int notify_complete_waiting_req(struct virtio_fs *vfs,
> +=09=09=09=09       struct fuse_notify_lock_out *out_args)
> +{
> +=09struct virtio_fs_vq *fsvq =3D &vfs->vqs[VQ_REQUEST];
> +=09struct fuse_req *req, *next;
> +=09bool found =3D false;
> +=09struct fuse_conn *fc =3D fsvq->fud->fc;
> +
> +=09/* Find waiting request with the unique number and end it */
> +=09spin_lock(&fsvq->lock);
> +=09=09list_for_each_entry_safe(req, next, &fsvq->wait_reqs, list) {
> +=09=09=09if (req->in.h.unique =3D=3D out_args->id) {
> +=09=09=09=09list_del_init(&req->list);
> +=09=09=09=09clear_bit(FR_SENT, &req->flags);
> +=09=09=09=09/* Transfer error code from notify */
> +=09=09=09=09req->out.h.error =3D out_args->error;
> +=09=09=09=09found =3D true;
> +=09=09=09=09break;
> +=09=09=09}
> +=09=09}
> +=09spin_unlock(&fsvq->lock);
> +
> +=09/*
> +=09 * TODO: It is possible that some re-ordering happens in notify
> +=09 * comes before request is complete. Deal with it.
> +=09 */
> +=09if (found) {
> +=09=09fuse_request_end(fc, req);
> +=09=09spin_lock(&fsvq->lock);
> +=09=09dec_in_flight_req(fsvq);
> +=09=09spin_unlock(&fsvq->lock);
> +=09} else
> +=09=09pr_debug("virtio-fs: Did not find waiting request with"
> +=09=09       " unique=3D0x%llx\n", out_args->id);
> +
> +=09return 0;
> +}
> +
> +static int virtio_fs_handle_notify(struct virtio_fs *vfs,
> +=09=09=09=09   struct virtio_fs_notify *notify)
> +{
> +=09int ret =3D 0;
> +=09struct fuse_out_header *oh =3D &notify->out_hdr;
> +=09struct fuse_notify_lock_out *lo;
> +
> +=09/*
> +=09 * For notifications, oh.unique is 0 and oh->error contains code
> +=09 * for which notification as arrived.
> +=09 */
> +=09switch(oh->error) {
> +=09case FUSE_NOTIFY_LOCK:
> +=09=09lo =3D (struct fuse_notify_lock_out *) &notify->outarg;
> +=09=09notify_complete_waiting_req(vfs, lo);
> +=09=09break;
> +=09default:
> +=09=09printk("virtio-fs: Unexpected notification %d\n", oh->error);
> +=09}
> +=09return ret;
> +}

Is this specific to virtio or can be it handled in common code?

> +
>  static void virtio_fs_notify_done_work(struct work_struct *work)
>  {
>  =09struct virtio_fs_vq *fsvq =3D container_of(work, struct virtio_fs_vq,
>  =09=09=09=09=09=09 done_work);
>  =09struct virtqueue *vq =3D fsvq->vq;
> +=09struct virtio_fs *vfs =3D vq->vdev->priv;
>  =09LIST_HEAD(reqs);
>  =09struct virtio_fs_notify_node *notify, *next;
> +=09struct fuse_out_header *oh;
> =20
>  =09spin_lock(&fsvq->lock);
>  =09do {
> @@ -535,6 +597,10 @@ static void virtio_fs_notify_done_work(struct work_s=
truct *work)
> =20
>  =09/* Process notify */
>  =09list_for_each_entry_safe(notify, next, &reqs, list) {
> +=09=09oh =3D &notify->notify.out_hdr;
> +=09=09WARN_ON(oh->unique);
> +=09=09/* Handle notification */
> +=09=09virtio_fs_handle_notify(vfs, &notify->notify);
>  =09=09spin_lock(&fsvq->lock);
>  =09=09dec_in_flight_req(fsvq);
>  =09=09list_del_init(&notify->list);
> @@ -656,6 +722,15 @@ static void virtio_fs_requests_done_work(struct work=
_struct *work)
>  =09=09 * TODO verify that server properly follows FUSE protocol
>  =09=09 * (oh.uniq, oh.len)
>  =09=09 */
> +=09=09if (req->out.h.error =3D=3D 1) {
> +=09=09=09/* Wait for notification to complete request */
> +=09=09=09list_del_init(&req->list);
> +=09=09=09spin_lock(&fsvq->lock);
> +=09=09=09list_add_tail(&req->list, &fsvq->wait_reqs);
> +=09=09=09spin_unlock(&fsvq->lock);
> +=09=09=09continue;
> +=09=09}
> +
>  =09=09args =3D req->args;
>  =09=09copy_args_from_argbuf(args, req);
> =20
> @@ -705,6 +780,7 @@ static int virtio_fs_init_vq(struct virtio_fs *fs, st=
ruct virtio_fs_vq *fsvq,
>  =09strncpy(fsvq->name, name, VQ_NAME_LEN);
>  =09spin_lock_init(&fsvq->lock);
>  =09INIT_LIST_HEAD(&fsvq->queued_reqs);
> +=09INIT_LIST_HEAD(&fsvq->wait_reqs);
>  =09INIT_LIST_HEAD(&fsvq->end_reqs);
>  =09INIT_LIST_HEAD(&fsvq->notify_reqs);
>  =09init_completion(&fsvq->in_flight_zero);
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 373cada89815..45f0c4efec8e 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -481,6 +481,7 @@ enum fuse_notify_code {
>  =09FUSE_NOTIFY_STORE =3D 4,
>  =09FUSE_NOTIFY_RETRIEVE =3D 5,
>  =09FUSE_NOTIFY_DELETE =3D 6,
> +=09FUSE_NOTIFY_LOCK =3D 7,
>  =09FUSE_NOTIFY_CODE_MAX,
>  };
> =20
> @@ -868,6 +869,12 @@ struct fuse_notify_retrieve_in {
>  =09uint64_t=09dummy4;
>  };
> =20
> +struct fuse_notify_lock_out {
> +=09uint64_t=09id;

Please call this field "unique" or "lock_unique" so it's clear this
identifier is the fuse_header_in->unique value of the lock request.

> +=09int32_t=09=09error;
> +=09int32_t=09=09padding;
> +};
> +
>  /* Device ioctls: */
>  #define FUSE_DEV_IOC_CLONE=09_IOR(229, 0, uint32_t)
> =20
> --=20
> 2.20.1
>=20

--84ND8YJRMFlzkrP4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3WwqQACgkQnKSrs4Gr
c8iDKgf+IaJQsBOeNmRpYFt/cBxDafpZUfqjpUomAe+/hVdOSaKdBNsJBtNNHCAJ
IMiXvZtUYMGZVWBBNbdWrEXsqmEc8suV9E2XZZ/PpDkw1TQjXUnvU6lyG3G14ZZn
Qqh/mo3BXS/sK6ep0pPxy3otbSZ19IWjAqWuA4IjKfPzz0idFYEk6YAGtTT3l4+C
/26hVeQYoj9AfshE1Jcp5XCY3QtDvaP9BbSe0S7rDLxBfaHYwLYetX5RYgSOKdBJ
+RTNgW5EBhAKKAntD6LzxJ6pPHpyiZSomaAj9N05MH4cHkAmIVwtqyq0fNYVQa7c
vdVv9PY8ZR0vqgSUZBWM+ZkXZnzhEQ==
=Ks93
-----END PGP SIGNATURE-----

--84ND8YJRMFlzkrP4--

