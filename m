Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9D141AC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 05:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436954AbfFLDfP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 23:35:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436559AbfFLDfO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 23:35:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F4D5300B916;
        Wed, 12 Jun 2019 03:34:57 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E8D87E57B;
        Wed, 12 Jun 2019 03:34:55 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 768FC1806B18;
        Wed, 12 Jun 2019 03:34:50 +0000 (UTC)
Date:   Tue, 11 Jun 2019 23:34:50 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     dm-devel@redhat.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org,
        qemu-devel@nongnu.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        dan j williams <dan.j.williams@intel.com>,
        zwisler@kernel.org, vishal l verma <vishal.l.verma@intel.com>,
        dave jiang <dave.jiang@intel.com>, mst@redhat.com,
        jasowang@redhat.com, willy@infradead.org, rjw@rjwysocki.net,
        hch@infradead.org, lenb@kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger kernel <adilger.kernel@dilger.ca>,
        darrick wong <darrick.wong@oracle.com>, lcapitulino@redhat.com,
        kwolf@redhat.com, imammedo@redhat.com, jmoyer@redhat.com,
        nilal@redhat.com, riel@surriel.com, stefanha@redhat.com,
        aarcange@redhat.com, david@redhat.com, david@fromorbit.com,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        pbonzini@redhat.com, yuval shaia <yuval.shaia@oracle.com>,
        kilobyte@angband.pl, jstaron@google.com, rdunlap@infradead.org,
        snitzer@redhat.com
Message-ID: <1003601865.34513553.1560310490030.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190611190209.0b25033e.cohuck@redhat.com>
References: <20190611163802.25352-1-pagupta@redhat.com> <20190611163802.25352-3-pagupta@redhat.com> <20190611190209.0b25033e.cohuck@redhat.com>
Subject: Re: [PATCH v12 2/7] virtio-pmem: Add virtio pmem driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.70, 10.4.195.19]
Thread-Topic: virtio-pmem: Add virtio pmem driver
Thread-Index: xouy0wKH9tDSBlfe8WrSfeKKI3BR8Q==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 12 Jun 2019 03:35:14 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Cornelia,

> On Tue, 11 Jun 2019 22:07:57 +0530
> Pankaj Gupta <pagupta@redhat.com> wrote:
> 
> > This patch adds virtio-pmem driver for KVM guest.
> > 
> > Guest reads the persistent memory range information from
> > Qemu over VIRTIO and registers it on nvdimm_bus. It also
> > creates a nd_region object with the persistent memory
> > range information so that existing 'nvdimm/pmem' driver
> > can reserve this into system memory map. This way
> > 'virtio-pmem' driver uses existing functionality of pmem
> > driver to register persistent memory compatible for DAX
> > capable filesystems.
> > 
> > This also provides function to perform guest flush over
> > VIRTIO from 'pmem' driver when userspace performs flush
> > on DAX memory range.
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > Acked-by: Jakub Staron <jstaron@google.com>
> > Tested-by: Jakub Staron <jstaron@google.com>
> > ---
> >  drivers/nvdimm/Makefile          |   1 +
> >  drivers/nvdimm/nd_virtio.c       | 124 +++++++++++++++++++++++++++++++
> >  drivers/nvdimm/virtio_pmem.c     | 122 ++++++++++++++++++++++++++++++
> >  drivers/nvdimm/virtio_pmem.h     |  55 ++++++++++++++
> >  drivers/virtio/Kconfig           |  11 +++
> >  include/uapi/linux/virtio_ids.h  |   1 +
> >  include/uapi/linux/virtio_pmem.h |  35 +++++++++
> >  7 files changed, 349 insertions(+)
> >  create mode 100644 drivers/nvdimm/nd_virtio.c
> >  create mode 100644 drivers/nvdimm/virtio_pmem.c
> >  create mode 100644 drivers/nvdimm/virtio_pmem.h
> >  create mode 100644 include/uapi/linux/virtio_pmem.h
> 
> Sorry about being late to the party; this one has been sitting in my
> 'to review' queue for far too long :(
> 
> (...)
> 
> > diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> > new file mode 100644
> > index 000000000000..efc535723517
> > --- /dev/null
> > +++ b/drivers/nvdimm/nd_virtio.c
> > @@ -0,0 +1,124 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * virtio_pmem.c: Virtio pmem Driver
> > + *
> > + * Discovers persistent memory range information
> > + * from host and provides a virtio based flushing
> > + * interface.
> > + */
> > +#include "virtio_pmem.h"
> > +#include "nd.h"
> > +
> > + /* The interrupt handler */
> > +void host_ack(struct virtqueue *vq)
> > +{
> > +	struct virtio_pmem *vpmem = vq->vdev->priv;
> > +	struct virtio_pmem_request *req_data, *req_buf;
> > +	unsigned long flags;
> > +	unsigned int len;
> > +
> > +	spin_lock_irqsave(&vpmem->pmem_lock, flags);
> > +	while ((req_data = virtqueue_get_buf(vq, &len)) != NULL) {
> > +		req_data->done = true;
> > +		wake_up(&req_data->host_acked);
> > +
> > +		if (!list_empty(&vpmem->req_list)) {
> > +			req_buf = list_first_entry(&vpmem->req_list,
> > +					struct virtio_pmem_request, list);
> > +			req_buf->wq_buf_avail = true;
> > +			wake_up(&req_buf->wq_buf);
> > +			list_del(&req_buf->list);
> > +		}
> > +	}
> > +	spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> > +}
> > +EXPORT_SYMBOL_GPL(host_ack);
> 
> Nit: 'host_ack' looks a bit generic for an exported function... would
> 'virtio_pmem_host_ack' maybe be better?

Yes, this looks better. Changed.

> 
> > +
> > + /* The request submission function */
> > +int virtio_pmem_flush(struct nd_region *nd_region)
> 
> I don't see an EXPORT_SYMBOL_GPL() for this function... should it get
> one, or should it be made static?

Made static. Leftover from last refactor of 'asyc_pmem_flush'.

> 
> > +{
> > +	struct virtio_device *vdev = nd_region->provider_data;
> > +	struct virtio_pmem *vpmem  = vdev->priv;
> > +	struct virtio_pmem_request *req_data;
> > +	struct scatterlist *sgs[2], sg, ret;
> > +	unsigned long flags;
> > +	int err, err1;
> > +
> > +	might_sleep();
> > +	req_data = kmalloc(sizeof(*req_data), GFP_KERNEL);
> > +	if (!req_data)
> > +		return -ENOMEM;
> > +
> > +	req_data->done = false;
> > +	init_waitqueue_head(&req_data->host_acked);
> > +	init_waitqueue_head(&req_data->wq_buf);
> > +	INIT_LIST_HEAD(&req_data->list);
> > +	req_data->req.type = cpu_to_virtio32(vdev, VIRTIO_PMEM_REQ_TYPE_FLUSH);
> > +	sg_init_one(&sg, &req_data->req, sizeof(req_data->req));
> > +	sgs[0] = &sg;
> > +	sg_init_one(&ret, &req_data->resp.ret, sizeof(req_data->resp));
> > +	sgs[1] = &ret;
> > +
> > +	spin_lock_irqsave(&vpmem->pmem_lock, flags);
> > +	 /*
> > +	  * If virtqueue_add_sgs returns -ENOSPC then req_vq virtual
> > +	  * queue does not have free descriptor. We add the request
> > +	  * to req_list and wait for host_ack to wake us up when free
> > +	  * slots are available.
> > +	  */
> > +	while ((err = virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req_data,
> > +					GFP_ATOMIC)) == -ENOSPC) {
> > +
> > +		dev_err(&vdev->dev, "failed to send command to virtio pmem device, no
> > free slots in the virtqueue\n");
> 
> Hm... by the comment above I would have thought that this is not really
> an error, but rather a temporary condition? Maybe downgrade this to
> dev_info()?

o.k.

> 
> > +		req_data->wq_buf_avail = false;
> > +		list_add_tail(&req_data->list, &vpmem->req_list);
> > +		spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> > +
> > +		/* A host response results in "host_ack" getting called */
> > +		wait_event(req_data->wq_buf, req_data->wq_buf_avail);
> > +		spin_lock_irqsave(&vpmem->pmem_lock, flags);
> > +	}
> > +	err1 = virtqueue_kick(vpmem->req_vq);
> > +	spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> > +	/*
> > +	 * virtqueue_add_sgs failed with error different than -ENOSPC, we can't
> > +	 * do anything about that.
> > +	 */
> 
> Does it make sense to kick if you couldn't add at all?

When we could not add because of -ENOSPC we are waiting and when buffer is added
then only we do a kick. For any other error which might be a rare occurrence, I think
kick is harmless here and keeps the code clean?

> 
> > +	if (err || !err1) {
> > +		dev_info(&vdev->dev, "failed to send command to virtio pmem device\n");
> 
> If this is dev_info, I think the error above really should be dev_info
> as well (and maybe also log the error value)?

o.k. 

> 
> > +		err = -EIO;
> > +	} else {
> > +		/* A host repsonse results in "host_ack" getting called */
> > +		wait_event(req_data->host_acked, req_data->done);
> > +		err = virtio32_to_cpu(vdev, req_data->resp.ret);
> > +	}
> > +
> > +	kfree(req_data);
> > +	return err;
> > +};
> > +
> > +/* The asynchronous flush callback function */
> > +int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
> > +{
> > +	/* Create child bio for asynchronous flush and chain with
> > +	 * parent bio. Otherwise directly call nd_region flush.
> > +	 */
> 
> Nit: The comment should start with an otherwise empty /* line.

yes.

> 
> > +	if (bio && bio->bi_iter.bi_sector != -1) {
> > +		struct bio *child = bio_alloc(GFP_ATOMIC, 0);
> > +
> > +		if (!child)
> > +			return -ENOMEM;
> > +		bio_copy_dev(child, bio);
> > +		child->bi_opf = REQ_PREFLUSH;
> > +		child->bi_iter.bi_sector = -1;
> > +		bio_chain(child, bio);
> > +		submit_bio(child);
> > +		return 0;
> > +	}
> > +	if (virtio_pmem_flush(nd_region))
> > +		return -EIO;
> > +
> > +	return 0;
> > +};
> > +EXPORT_SYMBOL_GPL(async_pmem_flush);
> > +MODULE_LICENSE("GPL");
> 
> (...)
> 
> I have only some more minor comments; on the whole, this looks good to
> me.

Sure, Thank you. Attaching below on top changes on current patch2 based on
your suggestions. Let me know if these are okay and then will send official
v13 to for upstream merging.

Thanks,
Pankaj

===============

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index efc535723517..5b8d2367da0b 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -10,7 +10,7 @@
 #include "nd.h"
 
  /* The interrupt handler */
-void host_ack(struct virtqueue *vq)
+void virtio_pmem_host_ack(struct virtqueue *vq)
 {
        struct virtio_pmem *vpmem = vq->vdev->priv;
        struct virtio_pmem_request *req_data, *req_buf;
@@ -32,10 +32,10 @@ void host_ack(struct virtqueue *vq)
        }
        spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
 }
-EXPORT_SYMBOL_GPL(host_ack);
+EXPORT_SYMBOL_GPL(virtio_pmem_host_ack);
 
  /* The request submission function */
-int virtio_pmem_flush(struct nd_region *nd_region)
+static int virtio_pmem_flush(struct nd_region *nd_region)
 {
        struct virtio_device *vdev = nd_region->provider_data;
        struct virtio_pmem *vpmem  = vdev->priv;
@@ -69,7 +69,7 @@ int virtio_pmem_flush(struct nd_region *nd_region)
        while ((err = virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req_data,
                                        GFP_ATOMIC)) == -ENOSPC) {
 
-               dev_err(&vdev->dev, "failed to send command to virtio pmem device, no free slots in the virtqueue\n");
+               dev_info(&vdev->dev, "failed to send command to virtio pmem device, no free slots in the virtqueue\n");
                req_data->wq_buf_avail = false;
                list_add_tail(&req_data->list, &vpmem->req_list);
                spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
@@ -90,7 +90,8 @@ int virtio_pmem_flush(struct nd_region *nd_region)
        } else {
                /* A host repsonse results in "host_ack" getting called */
                wait_event(req_data->host_acked, req_data->done);
-               err = virtio32_to_cpu(vdev, req_data->resp.ret);
+               if ((err = virtio32_to_cpu(vdev, req_data->resp.ret)))
+                       err = -EIO;
        }
 
        kfree(req_data);
@@ -100,7 +101,8 @@ int virtio_pmem_flush(struct nd_region *nd_region)
 /* The asynchronous flush callback function */
 int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
 {
-       /* Create child bio for asynchronous flush and chain with
+       /*
+        * Create child bio for asynchronous flush and chain with
         * parent bio. Otherwise directly call nd_region flush.
         */
        if (bio && bio->bi_iter.bi_sector != -1) {
diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
index b60ebd8cd2fd..5e3d07b47e0c 100644
--- a/drivers/nvdimm/virtio_pmem.c
+++ b/drivers/nvdimm/virtio_pmem.c
@@ -19,7 +19,7 @@ static int init_vq(struct virtio_pmem *vpmem)
 {
        /* single vq */
        vpmem->req_vq = virtio_find_single_vq(vpmem->vdev,
-                                               host_ack, "flush_queue");
+                                       virtio_pmem_host_ack, "flush_queue");
        if (IS_ERR(vpmem->req_vq))
                return PTR_ERR(vpmem->req_vq);
 
diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
index 6e47521be158..998efbc7660c 100644
--- a/drivers/nvdimm/virtio_pmem.h
+++ b/drivers/nvdimm/virtio_pmem.h
@@ -50,6 +50,6 @@ struct virtio_pmem {
        uint64_t size;
 };
 
-void host_ack(struct virtqueue *vq);
+void virtio_pmem_host_ack(struct virtqueue *vq);
 int async_pmem_flush(struct nd_region *nd_region, struct bio *bio);
 #endif
