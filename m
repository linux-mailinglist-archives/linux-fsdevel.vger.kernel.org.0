Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 319D5AB5B7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 12:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390878AbfIFKWP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 06:22:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42318 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387862AbfIFKWP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:22:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1DD2C102B4AB;
        Fri,  6 Sep 2019 10:22:14 +0000 (UTC)
Received: from localhost (ovpn-117-208.ams2.redhat.com [10.36.117.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAC811001956;
        Fri,  6 Sep 2019 10:22:10 +0000 (UTC)
Date:   Fri, 6 Sep 2019 11:22:09 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v4 15/16] virtio-fs: add virtiofs filesystem
Message-ID: <20190906102209.GD5900@stefanha-x1.localdomain>
References: <20190903113640.7984-1-mszeredi@redhat.com>
 <20190903114203.8278-10-mszeredi@redhat.com>
 <20190903092222-mutt-send-email-mst@kernel.org>
 <20190905191515.GA11702@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VMt1DrMGOVs3KQwf"
Content-Disposition: inline
In-Reply-To: <20190905191515.GA11702@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Fri, 06 Sep 2019 10:22:14 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:15:15PM -0400, Vivek Goyal wrote:
> On Tue, Sep 03, 2019 at 09:55:49AM -0400, Michael S. Tsirkin wrote:
> [..]
> > What's with all of the TODOs? Some of these are really scary,
> > looks like they need to be figured out before this is merged.
>=20
> Hi Michael,
>=20
> One of the issue I noticed is races w.r.t device removal and super
> block initialization. I am about to post a set of patches which
> take care of these races and also get rid of some of the scary
> TODOs. Other TODOs like suspend/restore, multiqueue support etc
> are improvements which we can do over a period of time.
>=20
> [..]
> > > +/* Per-virtqueue state */
> > > +struct virtio_fs_vq {
> > > +	spinlock_t lock;
> > > +	struct virtqueue *vq;     /* protected by ->lock */
> > > +	struct work_struct done_work;
> > > +	struct list_head queued_reqs;
> > > +	struct delayed_work dispatch_work;
> > > +	struct fuse_dev *fud;
> > > +	bool connected;
> > > +	long in_flight;
> > > +	char name[24];
> >=20
> > I'd keep names somewhere separate as they are not used on data path.
>=20
> Ok, this sounds like a nice to have. Will take care of this once base
> patch gets merged.
>=20
> [..]
> > > +struct virtio_fs_forget {
> > > +	struct fuse_in_header ih;
> > > +	struct fuse_forget_in arg;
> >=20
> > These structures are all native endian.
> >=20
> > Passing them to host will make cross-endian setups painful to support,
> > and hardware implementations impossible.
> >=20
> > How about converting everything to LE?
>=20
> So looks like endianness issue is now resolved (going by the other
> emails). So I will not worry about it.
>=20
> [..]
> > > +/* Add a new instance to the list or return -EEXIST if tag name exis=
ts*/
> > > +static int virtio_fs_add_instance(struct virtio_fs *fs)
> > > +{
> > > +	struct virtio_fs *fs2;
> > > +	bool duplicate =3D false;
> > > +
> > > +	mutex_lock(&virtio_fs_mutex);
> > > +
> > > +	list_for_each_entry(fs2, &virtio_fs_instances, list) {
> > > +		if (strcmp(fs->tag, fs2->tag) =3D=3D 0)
> > > +			duplicate =3D true;
> > > +	}
> > > +
> > > +	if (!duplicate)
> > > +		list_add_tail(&fs->list, &virtio_fs_instances);
> >=20
> >=20
> > This is O(N^2) as it's presumably called for each istance.
> > Doesn't scale - please switch to a tree or such.
>=20
> This is O(N) and not O(N^2) right? Addition of device is O(N), search
> during mount is O(N).
>=20
> This is not a frequent event at all and number of virtiofs instances
> per guest are expected to be fairly small (say less than 10). So I=20
> really don't think there is any value in converting this into a tree
> (instead of a list).
>=20
> [..]
> > > +static void virtio_fs_free_devs(struct virtio_fs *fs)
> > > +{
> > > +	unsigned int i;
> > > +
> > > +	/* TODO lock */
> >=20
> > Doesn't inspire confidence, does it?
>=20
> Agreed. Getting rid of this in set of fixes I am about to post.
>=20
> >=20
> > > +
> > > +	for (i =3D 0; i < fs->nvqs; i++) {
> > > +		struct virtio_fs_vq *fsvq =3D &fs->vqs[i];
> > > +
> > > +		if (!fsvq->fud)
> > > +			continue;
> > > +
> > > +		flush_work(&fsvq->done_work);
> > > +		flush_delayed_work(&fsvq->dispatch_work);
> > > +
> > > +		/* TODO need to quiesce/end_requests/decrement dev_count */
> >=20
> > Indeed. Won't this crash if we don't?
>=20
> Took care of this as well.
>=20
> [..]
> > > +static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
> > > +{
> > > +	struct virtio_fs_forget *forget;
> > > +	struct virtio_fs_vq *fsvq =3D container_of(work, struct virtio_fs_v=
q,
> > > +						 dispatch_work.work);
> > > +	struct virtqueue *vq =3D fsvq->vq;
> > > +	struct scatterlist sg;
> > > +	struct scatterlist *sgs[] =3D {&sg};
> > > +	bool notify;
> > > +	int ret;
> > > +
> > > +	pr_debug("virtio-fs: worker %s called.\n", __func__);
> > > +	while (1) {
> > > +		spin_lock(&fsvq->lock);
> > > +		forget =3D list_first_entry_or_null(&fsvq->queued_reqs,
> > > +					struct virtio_fs_forget, list);
> > > +		if (!forget) {
> > > +			spin_unlock(&fsvq->lock);
> > > +			return;
> > > +		}
> > > +
> > > +		list_del(&forget->list);
> > > +		if (!fsvq->connected) {
> > > +			spin_unlock(&fsvq->lock);
> > > +			kfree(forget);
> > > +			continue;
> > > +		}
> > > +
> > > +		sg_init_one(&sg, forget, sizeof(*forget));
> >=20
> > This passes to host a structure including "struct list_head list";
> >=20
> > Not a good idea.
>=20
> Ok, host does not have to see "struct list_head list". Its needed for
> guest. Will look into getting rid of this.
>=20
> >=20
> >=20
> > > +
> > > +		/* Enqueue the request */
> > > +		dev_dbg(&vq->vdev->dev, "%s\n", __func__);
> > > +		ret =3D virtqueue_add_sgs(vq, sgs, 1, 0, forget, GFP_ATOMIC);
> >=20
> >=20
> > This is easier as add_outbuf.
>=20
> Will look into it.
>=20
> >=20
> > Also - why GFP_ATOMIC?
>=20
> Hmm..., may be it can be GFP_KERNEL. I don't see atomic context here. Will
> look into it.
>=20
> >=20
> > > +		if (ret < 0) {
> > > +			if (ret =3D=3D -ENOMEM || ret =3D=3D -ENOSPC) {
> > > +				pr_debug("virtio-fs: Could not queue FORGET: err=3D%d. Will try =
later\n",
> > > +					 ret);
> > > +				list_add_tail(&forget->list,
> > > +						&fsvq->queued_reqs);
> > > +				schedule_delayed_work(&fsvq->dispatch_work,
> > > +						msecs_to_jiffies(1));
> >=20
> > Can't we we requeue after some buffers get consumed?
>=20
> That's what dispatch work is doing. It tries to requeue the request after
> a while.
>=20
> [..]
> > > +static int virtio_fs_probe(struct virtio_device *vdev)
> > > +{
> > > +	struct virtio_fs *fs;
> > > +	int ret;
> > > +
> > > +	fs =3D devm_kzalloc(&vdev->dev, sizeof(*fs), GFP_KERNEL);
> > > +	if (!fs)
> > > +		return -ENOMEM;
> > > +	vdev->priv =3D fs;
> > > +
> > > +	ret =3D virtio_fs_read_tag(vdev, fs);
> > > +	if (ret < 0)
> > > +		goto out;
> > > +
> > > +	ret =3D virtio_fs_setup_vqs(vdev, fs);
> > > +	if (ret < 0)
> > > +		goto out;
> > > +
> > > +	/* TODO vq affinity */
> > > +	/* TODO populate notifications vq */
> >=20
> > what's notifications vq?
>=20
> It has not been implemented yet. At some point of time we want to have
> a notion of notification queue so that host can send notifications to
> guest. Will get rid of this comment for now.
>=20
> [..]
> > > +#ifdef CONFIG_PM_SLEEP
> > > +static int virtio_fs_freeze(struct virtio_device *vdev)
> > > +{
> > > +	return 0; /* TODO */
> > > +}
> > > +
> > > +static int virtio_fs_restore(struct virtio_device *vdev)
> > > +{
> > > +	return 0; /* TODO */
> > > +}
> >=20
> > Is this really a good idea? I'd rather it was implemented,
> > but if not possible at all disabling PM seems better than just
> > keep going.
>=20
> I agree. Will look into disabling it.
>=20
> >=20
> > > +#endif /* CONFIG_PM_SLEEP */
> > > +
> > > +const static struct virtio_device_id id_table[] =3D {
> > > +	{ VIRTIO_ID_FS, VIRTIO_DEV_ANY_ID },
> > > +	{},
> > > +};
> > > +
> > > +const static unsigned int feature_table[] =3D {};
> > > +
> > > +static struct virtio_driver virtio_fs_driver =3D {
> > > +	.driver.name		=3D KBUILD_MODNAME,
> > > +	.driver.owner		=3D THIS_MODULE,
> > > +	.id_table		=3D id_table,
> > > +	.feature_table		=3D feature_table,
> > > +	.feature_table_size	=3D ARRAY_SIZE(feature_table),
> > > +	/* TODO validate config_get !=3D NULL */
> >=20
> > Why?
>=20
> Don't know. Stefan, do you remember why did you put this comment? If not,
> I will get rid of it.

This comment can be removed.

> > > +static void virtio_fs_wake_pending_and_unlock(struct fuse_iqueue *fi=
q)
> > > +__releases(fiq->waitq.lock)
> > > +{
> > > +	unsigned int queue_id =3D VQ_REQUEST; /* TODO multiqueue */
> > > +	struct virtio_fs *fs;
> > > +	struct fuse_conn *fc;
> > > +	struct fuse_req *req;
> > > +	struct fuse_pqueue *fpq;
> > > +	int ret;
> > > +
> > > +	WARN_ON(list_empty(&fiq->pending));
> > > +	req =3D list_last_entry(&fiq->pending, struct fuse_req, list);
> > > +	clear_bit(FR_PENDING, &req->flags);
> > > +	list_del_init(&req->list);
> > > +	WARN_ON(!list_empty(&fiq->pending));
> > > +	spin_unlock(&fiq->waitq.lock);
> > > +
> > > +	fs =3D fiq->priv;
> > > +	fc =3D fs->vqs[queue_id].fud->fc;
> > > +
> > > +	dev_dbg(&fs->vqs[queue_id].vq->vdev->dev,
> > > +		"%s: opcode %u unique %#llx nodeid %#llx in.len %u out.len %u\n",
> > > +		__func__, req->in.h.opcode, req->in.h.unique, req->in.h.nodeid,
> > > +		req->in.h.len, fuse_len_args(req->out.numargs, req->out.args));
> > > +
> > > +	fpq =3D &fs->vqs[queue_id].fud->pq;
> > > +	spin_lock(&fpq->lock);
> > > +	if (!fpq->connected) {
> > > +		spin_unlock(&fpq->lock);
> > > +		req->out.h.error =3D -ENODEV;
> > > +		pr_err("virtio-fs: %s disconnected\n", __func__);
> > > +		fuse_request_end(fc, req);
> > > +		return;
> > > +	}
> > > +	list_add_tail(&req->list, fpq->processing);
> > > +	spin_unlock(&fpq->lock);
> > > +	set_bit(FR_SENT, &req->flags);
> > > +	/* matches barrier in request_wait_answer() */
> > > +	smp_mb__after_atomic();
> > > +	/* TODO check for FR_INTERRUPTED? */
> >=20
> >=20
> > ?
>=20
> hmm... we don't support FR_INTERRUPTED. Stefan, do you remember why
> this TODO is here. If not, I will get rid of it.

We don't support FUSE_INTERRUPT yet.  The purpose of this comment is
that when we do support FUSE_INTERRUPT we'll need to follow
fuse_dev_do_read() in queuing a FUSE_INTERRUPT here.

Stefan

--VMt1DrMGOVs3KQwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yM1EACgkQnKSrs4Gr
c8hVQQf/Uwo26CAKqfvzN070MQoMPtVIFIpNylbv0zudk/4c1SuMn+I7sqyQGPJl
6TPci4teWxQRtOo8kcsK27stsz/f5fXfP256weA4MOwyzx5A2fIRhppga6v/Z5Ae
nWLk1t/SXLf3UnDtgTiB+ghDpJr9YkgJG0Xch+dDGu2sQ6lW1MqLggp6snileVFr
BS5D6g4xdh5sEn8kjKIaKm3HdBtCBRtTwmX6nw8WkJzyQ6k9T1YPBu3GO78E7sEn
BsxfigoCOZWzgYfWf7hwOjbdzeenSQO+As7Pn3Tg5n7uG+aT2zRefLX2GpRxSo+7
BMAVywXjogiowTyzTydiQMSOSa3GNA==
=69sY
-----END PGP SIGNATURE-----

--VMt1DrMGOVs3KQwf--
