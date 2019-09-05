Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2EDAABCA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 21:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbfIETPW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 15:15:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfIETPW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:15:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6CEDA89AC7;
        Thu,  5 Sep 2019 19:15:21 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04CD819C77;
        Thu,  5 Sep 2019 19:15:15 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 87682220292; Thu,  5 Sep 2019 15:15:15 -0400 (EDT)
Date:   Thu, 5 Sep 2019 15:15:15 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v4 15/16] virtio-fs: add virtiofs filesystem
Message-ID: <20190905191515.GA11702@redhat.com>
References: <20190903113640.7984-1-mszeredi@redhat.com>
 <20190903114203.8278-10-mszeredi@redhat.com>
 <20190903092222-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903092222-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 05 Sep 2019 19:15:21 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 09:55:49AM -0400, Michael S. Tsirkin wrote:
[..]
> What's with all of the TODOs? Some of these are really scary,
> looks like they need to be figured out before this is merged.

Hi Michael,

One of the issue I noticed is races w.r.t device removal and super
block initialization. I am about to post a set of patches which
take care of these races and also get rid of some of the scary
TODOs. Other TODOs like suspend/restore, multiqueue support etc
are improvements which we can do over a period of time.

[..]
> > +/* Per-virtqueue state */
> > +struct virtio_fs_vq {
> > +	spinlock_t lock;
> > +	struct virtqueue *vq;     /* protected by ->lock */
> > +	struct work_struct done_work;
> > +	struct list_head queued_reqs;
> > +	struct delayed_work dispatch_work;
> > +	struct fuse_dev *fud;
> > +	bool connected;
> > +	long in_flight;
> > +	char name[24];
> 
> I'd keep names somewhere separate as they are not used on data path.

Ok, this sounds like a nice to have. Will take care of this once base
patch gets merged.

[..]
> > +struct virtio_fs_forget {
> > +	struct fuse_in_header ih;
> > +	struct fuse_forget_in arg;
> 
> These structures are all native endian.
> 
> Passing them to host will make cross-endian setups painful to support,
> and hardware implementations impossible.
> 
> How about converting everything to LE?

So looks like endianness issue is now resolved (going by the other
emails). So I will not worry about it.

[..]
> > +/* Add a new instance to the list or return -EEXIST if tag name exists*/
> > +static int virtio_fs_add_instance(struct virtio_fs *fs)
> > +{
> > +	struct virtio_fs *fs2;
> > +	bool duplicate = false;
> > +
> > +	mutex_lock(&virtio_fs_mutex);
> > +
> > +	list_for_each_entry(fs2, &virtio_fs_instances, list) {
> > +		if (strcmp(fs->tag, fs2->tag) == 0)
> > +			duplicate = true;
> > +	}
> > +
> > +	if (!duplicate)
> > +		list_add_tail(&fs->list, &virtio_fs_instances);
> 
> 
> This is O(N^2) as it's presumably called for each istance.
> Doesn't scale - please switch to a tree or such.

This is O(N) and not O(N^2) right? Addition of device is O(N), search
during mount is O(N).

This is not a frequent event at all and number of virtiofs instances
per guest are expected to be fairly small (say less than 10). So I 
really don't think there is any value in converting this into a tree
(instead of a list).

[..]
> > +static void virtio_fs_free_devs(struct virtio_fs *fs)
> > +{
> > +	unsigned int i;
> > +
> > +	/* TODO lock */
> 
> Doesn't inspire confidence, does it?

Agreed. Getting rid of this in set of fixes I am about to post.

> 
> > +
> > +	for (i = 0; i < fs->nvqs; i++) {
> > +		struct virtio_fs_vq *fsvq = &fs->vqs[i];
> > +
> > +		if (!fsvq->fud)
> > +			continue;
> > +
> > +		flush_work(&fsvq->done_work);
> > +		flush_delayed_work(&fsvq->dispatch_work);
> > +
> > +		/* TODO need to quiesce/end_requests/decrement dev_count */
> 
> Indeed. Won't this crash if we don't?

Took care of this as well.

[..]
> > +static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
> > +{
> > +	struct virtio_fs_forget *forget;
> > +	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
> > +						 dispatch_work.work);
> > +	struct virtqueue *vq = fsvq->vq;
> > +	struct scatterlist sg;
> > +	struct scatterlist *sgs[] = {&sg};
> > +	bool notify;
> > +	int ret;
> > +
> > +	pr_debug("virtio-fs: worker %s called.\n", __func__);
> > +	while (1) {
> > +		spin_lock(&fsvq->lock);
> > +		forget = list_first_entry_or_null(&fsvq->queued_reqs,
> > +					struct virtio_fs_forget, list);
> > +		if (!forget) {
> > +			spin_unlock(&fsvq->lock);
> > +			return;
> > +		}
> > +
> > +		list_del(&forget->list);
> > +		if (!fsvq->connected) {
> > +			spin_unlock(&fsvq->lock);
> > +			kfree(forget);
> > +			continue;
> > +		}
> > +
> > +		sg_init_one(&sg, forget, sizeof(*forget));
> 
> This passes to host a structure including "struct list_head list";
> 
> Not a good idea.

Ok, host does not have to see "struct list_head list". Its needed for
guest. Will look into getting rid of this.

> 
> 
> > +
> > +		/* Enqueue the request */
> > +		dev_dbg(&vq->vdev->dev, "%s\n", __func__);
> > +		ret = virtqueue_add_sgs(vq, sgs, 1, 0, forget, GFP_ATOMIC);
> 
> 
> This is easier as add_outbuf.

Will look into it.

> 
> Also - why GFP_ATOMIC?

Hmm..., may be it can be GFP_KERNEL. I don't see atomic context here. Will
look into it.

> 
> > +		if (ret < 0) {
> > +			if (ret == -ENOMEM || ret == -ENOSPC) {
> > +				pr_debug("virtio-fs: Could not queue FORGET: err=%d. Will try later\n",
> > +					 ret);
> > +				list_add_tail(&forget->list,
> > +						&fsvq->queued_reqs);
> > +				schedule_delayed_work(&fsvq->dispatch_work,
> > +						msecs_to_jiffies(1));
> 
> Can't we we requeue after some buffers get consumed?

That's what dispatch work is doing. It tries to requeue the request after
a while.

[..]
> > +static int virtio_fs_probe(struct virtio_device *vdev)
> > +{
> > +	struct virtio_fs *fs;
> > +	int ret;
> > +
> > +	fs = devm_kzalloc(&vdev->dev, sizeof(*fs), GFP_KERNEL);
> > +	if (!fs)
> > +		return -ENOMEM;
> > +	vdev->priv = fs;
> > +
> > +	ret = virtio_fs_read_tag(vdev, fs);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	ret = virtio_fs_setup_vqs(vdev, fs);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	/* TODO vq affinity */
> > +	/* TODO populate notifications vq */
> 
> what's notifications vq?

It has not been implemented yet. At some point of time we want to have
a notion of notification queue so that host can send notifications to
guest. Will get rid of this comment for now.

[..]
> > +#ifdef CONFIG_PM_SLEEP
> > +static int virtio_fs_freeze(struct virtio_device *vdev)
> > +{
> > +	return 0; /* TODO */
> > +}
> > +
> > +static int virtio_fs_restore(struct virtio_device *vdev)
> > +{
> > +	return 0; /* TODO */
> > +}
> 
> Is this really a good idea? I'd rather it was implemented,
> but if not possible at all disabling PM seems better than just
> keep going.

I agree. Will look into disabling it.

> 
> > +#endif /* CONFIG_PM_SLEEP */
> > +
> > +const static struct virtio_device_id id_table[] = {
> > +	{ VIRTIO_ID_FS, VIRTIO_DEV_ANY_ID },
> > +	{},
> > +};
> > +
> > +const static unsigned int feature_table[] = {};
> > +
> > +static struct virtio_driver virtio_fs_driver = {
> > +	.driver.name		= KBUILD_MODNAME,
> > +	.driver.owner		= THIS_MODULE,
> > +	.id_table		= id_table,
> > +	.feature_table		= feature_table,
> > +	.feature_table_size	= ARRAY_SIZE(feature_table),
> > +	/* TODO validate config_get != NULL */
> 
> Why?

Don't know. Stefan, do you remember why did you put this comment? If not,
I will get rid of it.

> 
> > +	.probe			= virtio_fs_probe,
> > +	.remove			= virtio_fs_remove,
> > +#ifdef CONFIG_PM_SLEEP
> > +	.freeze			= virtio_fs_freeze,
> > +	.restore		= virtio_fs_restore,
> > +#endif
> > +};
> > +
> > +static void virtio_fs_wake_forget_and_unlock(struct fuse_iqueue *fiq)
> > +__releases(fiq->waitq.lock)
> > +{
> > +	struct fuse_forget_link *link;
> > +	struct virtio_fs_forget *forget;
> > +	struct scatterlist sg;
> > +	struct scatterlist *sgs[] = {&sg};
> > +	struct virtio_fs *fs;
> > +	struct virtqueue *vq;
> > +	struct virtio_fs_vq *fsvq;
> > +	bool notify;
> > +	u64 unique;
> > +	int ret;
> > +
> > +	link = fuse_dequeue_forget(fiq, 1, NULL);
> > +	unique = fuse_get_unique(fiq);
> > +
> > +	fs = fiq->priv;
> > +	fsvq = &fs->vqs[VQ_HIPRIO];
> > +	spin_unlock(&fiq->waitq.lock);
> > +
> > +	/* Allocate a buffer for the request */
> > +	forget = kmalloc(sizeof(*forget), GFP_NOFS | __GFP_NOFAIL);
> > +
> > +	forget->ih = (struct fuse_in_header){
> > +		.opcode = FUSE_FORGET,
> > +		.nodeid = link->forget_one.nodeid,
> > +		.unique = unique,
> > +		.len = sizeof(*forget),
> > +	};
> > +	forget->arg = (struct fuse_forget_in){
> > +		.nlookup = link->forget_one.nlookup,
> > +	};
> > +
> > +	sg_init_one(&sg, forget, sizeof(*forget));
> > +
> > +	/* Enqueue the request */
> > +	vq = fsvq->vq;
> > +	dev_dbg(&vq->vdev->dev, "%s\n", __func__);
> > +	spin_lock(&fsvq->lock);
> > +
> > +	ret = virtqueue_add_sgs(vq, sgs, 1, 0, forget, GFP_ATOMIC);
> > +	if (ret < 0) {
> > +		if (ret == -ENOMEM || ret == -ENOSPC) {
> > +			pr_debug("virtio-fs: Could not queue FORGET: err=%d. Will try later.\n",
> > +				 ret);
> > +			list_add_tail(&forget->list, &fsvq->queued_reqs);
> > +			schedule_delayed_work(&fsvq->dispatch_work,
> > +					msecs_to_jiffies(1));
> > +		} else {
> > +			pr_debug("virtio-fs: Could not queue FORGET: err=%d. Dropping it.\n",
> > +				 ret);
> > +			kfree(forget);
> > +		}
> > +		spin_unlock(&fsvq->lock);
> > +		goto out;
> > +	}
> 
> 
> code duplicated from virtio_fs_hiprio_dispatch_work

Will look into reusing the code.

> 
> > +
> > +	fsvq->in_flight++;
> > +	notify = virtqueue_kick_prepare(vq);
> > +
> > +	spin_unlock(&fsvq->lock);
> > +
> > +	if (notify)
> > +		virtqueue_notify(vq);
> > +out:
> > +	kfree(link);
> > +}
> > +
> > +static void virtio_fs_wake_interrupt_and_unlock(struct fuse_iqueue *fiq)
> > +__releases(fiq->waitq.lock)
> > +{
> > +	/* TODO */
> 
> what's needed?

We have not implemented this interrupt thing. It interrupts the existing
pending requests. Its not a must to have.

[..]
> > +static int virtio_fs_enqueue_req(struct virtqueue *vq, struct fuse_req *req)
> > +{
> > +	/* requests need at least 4 elements */
> > +	struct scatterlist *stack_sgs[6];
> > +	struct scatterlist stack_sg[ARRAY_SIZE(stack_sgs)];
> > +	struct scatterlist **sgs = stack_sgs;
> > +	struct scatterlist *sg = stack_sg;
> > +	struct virtio_fs_vq *fsvq;
> > +	unsigned int argbuf_used = 0;
> > +	unsigned int out_sgs = 0;
> > +	unsigned int in_sgs = 0;
> > +	unsigned int total_sgs;
> > +	unsigned int i;
> > +	int ret;
> > +	bool notify;
> > +
> > +	/* Does the sglist fit on the stack? */
> > +	total_sgs = sg_count_fuse_req(req);
> > +	if (total_sgs > ARRAY_SIZE(stack_sgs)) {
> > +		sgs = kmalloc_array(total_sgs, sizeof(sgs[0]), GFP_ATOMIC);
> > +		sg = kmalloc_array(total_sgs, sizeof(sg[0]), GFP_ATOMIC);
> > +		if (!sgs || !sg) {
> > +			ret = -ENOMEM;
> > +			goto out;
> > +		}
> > +	}
> > +
> > +	/* Use a bounce buffer since stack args cannot be mapped */
> > +	ret = copy_args_to_argbuf(req);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	/* Request elements */
> > +	sg_init_one(&sg[out_sgs++], &req->in.h, sizeof(req->in.h));
> > +	out_sgs += sg_init_fuse_args(&sg[out_sgs], req,
> > +				     (struct fuse_arg *)req->in.args,
> > +				     req->in.numargs, req->in.argpages,
> > +				     req->argbuf, &argbuf_used);
> > +
> > +	/* Reply elements */
> > +	if (test_bit(FR_ISREPLY, &req->flags)) {
> > +		sg_init_one(&sg[out_sgs + in_sgs++],
> > +			    &req->out.h, sizeof(req->out.h));
> > +		in_sgs += sg_init_fuse_args(&sg[out_sgs + in_sgs], req,
> > +					    req->out.args, req->out.numargs,
> > +					    req->out.argpages,
> > +					    req->argbuf + argbuf_used, NULL);
> > +	}
> > +
> > +	WARN_ON(out_sgs + in_sgs != total_sgs);
> > +
> > +	for (i = 0; i < total_sgs; i++)
> > +		sgs[i] = &sg[i];
> > +
> > +	fsvq = vq_to_fsvq(vq);
> > +	spin_lock(&fsvq->lock);
> > +
> > +	ret = virtqueue_add_sgs(vq, sgs, out_sgs, in_sgs, req, GFP_ATOMIC);
> > +	if (ret < 0) {
> > +		/* TODO handle full virtqueue */
> 
> Indeed. What prevents this?

So for forget requests (VQ_HIPRIO), I already handled this by retrying 
submitting the request with the help of a worker.

For regular requests (VQ_REQUESTS), I have never run into virt queue
being full so far. That's why never worried about it.

So nothing prevents this. But we have not noticed it yet. So its a TODO
item. It will be nice to retry if virtuqueue gets full (instead of
returning error to caller).

[..]
> > +static void virtio_fs_wake_pending_and_unlock(struct fuse_iqueue *fiq)
> > +__releases(fiq->waitq.lock)
> > +{
> > +	unsigned int queue_id = VQ_REQUEST; /* TODO multiqueue */
> > +	struct virtio_fs *fs;
> > +	struct fuse_conn *fc;
> > +	struct fuse_req *req;
> > +	struct fuse_pqueue *fpq;
> > +	int ret;
> > +
> > +	WARN_ON(list_empty(&fiq->pending));
> > +	req = list_last_entry(&fiq->pending, struct fuse_req, list);
> > +	clear_bit(FR_PENDING, &req->flags);
> > +	list_del_init(&req->list);
> > +	WARN_ON(!list_empty(&fiq->pending));
> > +	spin_unlock(&fiq->waitq.lock);
> > +
> > +	fs = fiq->priv;
> > +	fc = fs->vqs[queue_id].fud->fc;
> > +
> > +	dev_dbg(&fs->vqs[queue_id].vq->vdev->dev,
> > +		"%s: opcode %u unique %#llx nodeid %#llx in.len %u out.len %u\n",
> > +		__func__, req->in.h.opcode, req->in.h.unique, req->in.h.nodeid,
> > +		req->in.h.len, fuse_len_args(req->out.numargs, req->out.args));
> > +
> > +	fpq = &fs->vqs[queue_id].fud->pq;
> > +	spin_lock(&fpq->lock);
> > +	if (!fpq->connected) {
> > +		spin_unlock(&fpq->lock);
> > +		req->out.h.error = -ENODEV;
> > +		pr_err("virtio-fs: %s disconnected\n", __func__);
> > +		fuse_request_end(fc, req);
> > +		return;
> > +	}
> > +	list_add_tail(&req->list, fpq->processing);
> > +	spin_unlock(&fpq->lock);
> > +	set_bit(FR_SENT, &req->flags);
> > +	/* matches barrier in request_wait_answer() */
> > +	smp_mb__after_atomic();
> > +	/* TODO check for FR_INTERRUPTED? */
> 
> 
> ?

hmm... we don't support FR_INTERRUPTED. Stefan, do you remember why
this TODO is here. If not, I will get rid of it.

> 
> > +
> > +retry:
> > +	ret = virtio_fs_enqueue_req(fs->vqs[queue_id].vq, req);
> > +	if (ret < 0) {
> > +		if (ret == -ENOMEM || ret == -ENOSPC) {
> > +			/* Virtqueue full. Retry submission */
> > +			usleep_range(20, 30);
> 
> again, why not respond to completion?

Using usleep() was a quick fix. Will look into using completion in second
round of cleanup. In first round I am taking care of more scary TODOs
which deal with races w.r.t device removal.

> 
> > +			goto retry;
> > +		}
> > +		req->out.h.error = ret;
> > +		pr_err("virtio-fs: virtio_fs_enqueue_req() failed %d\n", ret);
> > +		fuse_request_end(fc, req);
> > +		return;
> > +	}
> > +}
> > +
> > +static void virtio_fs_flush_hiprio_queue(struct virtio_fs_vq *fsvq)
> > +{
> > +	struct virtio_fs_forget *forget;
> > +
> > +	WARN_ON(fsvq->in_flight < 0);
> > +
> > +	/* Go through pending forget requests and free them */
> > +	spin_lock(&fsvq->lock);
> > +	while (1) {
> > +		forget = list_first_entry_or_null(&fsvq->queued_reqs,
> > +					struct virtio_fs_forget, list);
> > +		if (!forget)
> > +			break;
> > +		list_del(&forget->list);
> > +		kfree(forget);
> > +	}
> > +
> > +	spin_unlock(&fsvq->lock);
> > +
> > +	/* Wait for in flight requests to finish.*/
> > +	while (1) {
> > +		spin_lock(&fsvq->lock);
> > +		if (!fsvq->in_flight) {
> > +			spin_unlock(&fsvq->lock);
> > +			break;
> > +		}
> > +		spin_unlock(&fsvq->lock);
> > +		usleep_range(1000, 2000);
> 
> Same thing here. Can we use e.g. a completion and not usleep?

Second round cleanup.

> 
> > +	}
> > +}
> > +
> > +const static struct fuse_iqueue_ops virtio_fs_fiq_ops = {
> > +	.wake_forget_and_unlock		= virtio_fs_wake_forget_and_unlock,
> > +	.wake_interrupt_and_unlock	= virtio_fs_wake_interrupt_and_unlock,
> > +	.wake_pending_and_unlock	= virtio_fs_wake_pending_and_unlock,
> > +};
> > +
> > +static int virtio_fs_fill_super(struct super_block *sb)
> > +{
> > +	struct fuse_conn *fc = get_fuse_conn_super(sb);
> > +	struct virtio_fs *fs = fc->iq.priv;
> > +	unsigned int i;
> > +	int err;
> > +	struct fuse_req *init_req;
> > +	struct fuse_fs_context ctx = {
> > +		.rootmode = S_IFDIR,
> > +		.default_permissions = 1,
> > +		.allow_other = 1,
> > +		.max_read = UINT_MAX,
> > +		.blksize = 512,
> > +		.destroy = true,
> > +		.no_control = true,
> > +		.no_force_umount = true,
> > +	};
> > +
> > +	/* TODO lock */
> 
> what does this refer to?

Took care of in first round of cleanup.

> 
> > +	if (fs->vqs[VQ_REQUEST].fud) {
> > +		pr_err("virtio-fs: device already in use\n");
> > +		err = -EBUSY;
> > +		goto err;
> > +	}
> > +
> > +	err = -ENOMEM;
> > +	/* Allocate fuse_dev for hiprio and notification queues */
> > +	for (i = 0; i < VQ_REQUEST; i++) {
> > +		struct virtio_fs_vq *fsvq = &fs->vqs[i];
> > +
> > +		fsvq->fud = fuse_dev_alloc();
> > +		if (!fsvq->fud)
> > +			goto err_free_fuse_devs;
> > +	}
> > +
> > +	init_req = fuse_request_alloc(0);
> > +	if (!init_req)
> > +		goto err_free_fuse_devs;
> > +	__set_bit(FR_BACKGROUND, &init_req->flags);
> > +
> > +	ctx.fudptr = (void **)&fs->vqs[VQ_REQUEST].fud;
> > +	err = fuse_fill_super_common(sb, &ctx);
> > +	if (err < 0)
> > +		goto err_free_init_req;
> > +
> > +	fc = fs->vqs[VQ_REQUEST].fud->fc;
> > +
> > +	/* TODO take fuse_mutex around this loop? */
> 
> Don't we need to figure this kind of thing out before this
> code lands upstream?

I think we don't need this TODO. fuse_connection object and associated
super block are still being formed. And my cleanup has taken care of
the additional locking.

Thanks
Vivek
