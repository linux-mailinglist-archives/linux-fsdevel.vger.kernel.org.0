Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6CB1C605
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 11:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfENJ1F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 05:27:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfENJ1F (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 05:27:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E269A87624;
        Tue, 14 May 2019 09:27:03 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8660360166;
        Tue, 14 May 2019 09:27:03 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id CEC2D41F3C;
        Tue, 14 May 2019 09:27:02 +0000 (UTC)
Date:   Tue, 14 May 2019 05:27:02 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
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
        aarcange@redhat.com, david@fromorbit.com, cohuck@redhat.com,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        pbonzini@redhat.com, kilobyte@angband.pl,
        yuval shaia <yuval.shaia@oracle.com>, jstaron@google.com
Message-ID: <752392764.28554139.1557826022323.JavaMail.zimbra@redhat.com>
In-Reply-To: <f2ea35a6-ec98-447c-44fe-0cb3ab309340@redhat.com>
References: <20190510155202.14737-1-pagupta@redhat.com> <20190510155202.14737-3-pagupta@redhat.com> <f2ea35a6-ec98-447c-44fe-0cb3ab309340@redhat.com>
Subject: Re: [PATCH v8 2/6] virtio-pmem: Add virtio pmem driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.16.148, 10.4.195.18]
Thread-Topic: virtio-pmem: Add virtio pmem driver
Thread-Index: xYWChsuo0mqv2Tff4hSAYzNT4Gs45Q==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 14 May 2019 09:27:04 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi David,

Thank you for the review.

> On 10.05.19 17:51, Pankaj Gupta wrote:
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
> > ---
> >  drivers/nvdimm/Makefile          |   1 +
> >  drivers/nvdimm/nd_virtio.c       | 129 +++++++++++++++++++++++++++++++
> >  drivers/nvdimm/virtio_pmem.c     | 117 ++++++++++++++++++++++++++++
> >  drivers/virtio/Kconfig           |  10 +++
> >  include/linux/virtio_pmem.h      |  60 ++++++++++++++
> >  include/uapi/linux/virtio_ids.h  |   1 +
> >  include/uapi/linux/virtio_pmem.h |  10 +++
> >  7 files changed, 328 insertions(+)
> >  create mode 100644 drivers/nvdimm/nd_virtio.c
> >  create mode 100644 drivers/nvdimm/virtio_pmem.c
> >  create mode 100644 include/linux/virtio_pmem.h
> >  create mode 100644 include/uapi/linux/virtio_pmem.h
> > 
> > diff --git a/drivers/nvdimm/Makefile b/drivers/nvdimm/Makefile
> > index 6f2a088afad6..cefe233e0b52 100644
> > --- a/drivers/nvdimm/Makefile
> > +++ b/drivers/nvdimm/Makefile
> > @@ -5,6 +5,7 @@ obj-$(CONFIG_ND_BTT) += nd_btt.o
> >  obj-$(CONFIG_ND_BLK) += nd_blk.o
> >  obj-$(CONFIG_X86_PMEM_LEGACY) += nd_e820.o
> >  obj-$(CONFIG_OF_PMEM) += of_pmem.o
> > +obj-$(CONFIG_VIRTIO_PMEM) += virtio_pmem.o nd_virtio.o
> >  
> >  nd_pmem-y := pmem.o
> >  
> > diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> > new file mode 100644
> > index 000000000000..ed7ddcc5a62c
> > --- /dev/null
> > +++ b/drivers/nvdimm/nd_virtio.c
> > @@ -0,0 +1,129 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * virtio_pmem.c: Virtio pmem Driver
> > + *
> > + * Discovers persistent memory range information
> > + * from host and provides a virtio based flushing
> > + * interface.
> > + */
> > +#include <linux/virtio_pmem.h>
> > +#include "nd.h"
> > +
> > + /* The interrupt handler */
> > +void host_ack(struct virtqueue *vq)
> > +{
> > +	unsigned int len;
> > +	unsigned long flags;
> > +	struct virtio_pmem_request *req, *req_buf;
> > +	struct virtio_pmem *vpmem = vq->vdev->priv;
> 
> Nit: use reverse Christmas tree layout :)

o.k

> 
> > +
> > +	spin_lock_irqsave(&vpmem->pmem_lock, flags);
> > +	while ((req = virtqueue_get_buf(vq, &len)) != NULL) {
> > +		req->done = true;
> > +		wake_up(&req->host_acked);
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
> > +
> > + /* The request submission function */
> > +int virtio_pmem_flush(struct nd_region *nd_region)
> > +{
> > +	int err, err1;
> > +	unsigned long flags;
> > +	struct scatterlist *sgs[2], sg, ret;
> > +	struct virtio_device *vdev = nd_region->provider_data;
> > +	struct virtio_pmem *vpmem = vdev->priv;
> > +	struct virtio_pmem_request *req;
> 
> Nit: use reverse Christmas tree layout :)

o.k

> 
> > +
> > +	might_sleep();
> > +	req = kmalloc(sizeof(*req), GFP_KERNEL);
> > +	if (!req)
> > +		return -ENOMEM;
> > +
> > +	req->done = false;
> > +	strcpy(req->name, "FLUSH");
> > +	init_waitqueue_head(&req->host_acked);
> > +	init_waitqueue_head(&req->wq_buf);
> > +	INIT_LIST_HEAD(&req->list);
> > +	sg_init_one(&sg, req->name, strlen(req->name));
> > +	sgs[0] = &sg;
> > +	sg_init_one(&ret, &req->ret, sizeof(req->ret));
> > +	sgs[1] = &ret;
> > +
> > +	spin_lock_irqsave(&vpmem->pmem_lock, flags);
> > +	 /*
> > +	  * If virtqueue_add_sgs returns -ENOSPC then req_vq virtual
> > +	  * queue does not have free descriptor. We add the request
> > +	  * to req_list and wait for host_ack to wake us up when free
> > +	  * slots are available.
> > +	  */
> > +	while ((err = virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req,
> > +					GFP_ATOMIC)) == -ENOSPC) {
> > +
> > +		dev_err(&vdev->dev, "failed to send command to virtio pmem"\
> > +			"device, no free slots in the virtqueue\n");
> > +		req->wq_buf_avail = false;
> > +		list_add_tail(&req->list, &vpmem->req_list);
> > +		spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> > +
> > +		/* When host has read buffer, this completes via host_ack */
> 
> "A host repsonse results in "host_ack" getting called" ... ?

o.k

> 
> > +		wait_event(req->wq_buf, req->wq_buf_avail);
> > +		spin_lock_irqsave(&vpmem->pmem_lock, flags);
> > +	}
> > +	err1 = virtqueue_kick(vpmem->req_vq);
> > +	spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> > +
> > +	/*
> > +	 * virtqueue_add_sgs failed with error different than -ENOSPC, we can't
> > +	 * do anything about that.
> > +	 */
> > +	if (err || !err1) {
> > +		dev_info(&vdev->dev, "failed to send command to virtio pmem device\n");
> > +		err = -EIO;
> > +		goto ret;
> 
> Avoid the goto. Just move the following statements into an "else" case.

o.k

> 
> > +	}
> > +
> > +	/* When host has read buffer, this completes via host_ack */
> 
> "A host repsonse results in "host_ack" getting called" ... ?
> 
> > +	wait_event(req->host_acked, req->done);
> > +	err = req->ret;
> > +ret:
> > +	kfree(req);
> > +	return err;
> > +};
> > +
> > +/* The asynchronous flush callback function */
> > +int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
> > +{
> > +	int rc = 0;
> > +
> > +	/* Create child bio for asynchronous flush and chain with
> > +	 * parent bio. Otherwise directly call nd_region flush.
> > +	 */
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
> 
> return 0;
> 
> Then, drop the "else" case and "int rc" and do directly
> 
> if (virtio_pmem_flush(nd_region))
> 	return -EIO;

and another 'return 0' here :)

I don't like return from multiple places instead I prefer
single exit point from function.

> 
> > +	} else {
> > +
> > +			rc = -EIO;
> > +	}
> > +
> > +	return rc;
> > +};
> > +EXPORT_SYMBOL_GPL(async_pmem_flush);
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> > new file mode 100644
> > index 000000000000..cfc6381c4e5d
> > --- /dev/null
> > +++ b/drivers/nvdimm/virtio_pmem.c
> > @@ -0,0 +1,117 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * virtio_pmem.c: Virtio pmem Driver
> > + *
> > + * Discovers persistent memory range information
> > + * from host and registers the virtual pmem device
> > + * with libnvdimm core.
> > + */
> > +#include <linux/virtio_pmem.h>
> > +#include "nd.h"
> > +
> > +static struct virtio_device_id id_table[] = {
> > +	{ VIRTIO_ID_PMEM, VIRTIO_DEV_ANY_ID },
> > +	{ 0 },
> > +};
> > +
> > + /* Initialize virt queue */
> > +static int init_vq(struct virtio_pmem *vpmem)
> > +{
> > +	/* single vq */
> > +	vpmem->req_vq = virtio_find_single_vq(vpmem->vdev,
> > +				host_ack, "flush_queue");
> 
> Nit: Wrong indentation of parameters.

o.k

> 
> > +	if (IS_ERR(vpmem->req_vq))
> > +		return PTR_ERR(vpmem->req_vq);
> > +
> > +	spin_lock_init(&vpmem->pmem_lock);
> > +	INIT_LIST_HEAD(&vpmem->req_list);
> 
> I would initialize the locks in the virtio_pmem_probe() directly,
> earlier (directly after allocating vpmem).

Since the lock is to protect the vq so logically I put it in 'init_vq'
which is eventually called by probe.
 
> 
> > +
> > +	return 0;
> > +};
> > +
> > +static int virtio_pmem_probe(struct virtio_device *vdev)
> > +{
> > +	int err = 0;
> > +	struct resource res;
> > +	struct virtio_pmem *vpmem;
> > +	struct nd_region_desc ndr_desc = {};
> > +	int nid = dev_to_node(&vdev->dev);
> > +	struct nd_region *nd_region;
> 
> Nit: use reverse Christmas tree layout :)

Done.

> 
> > +
> > +	if (!vdev->config->get) {
> > +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > +			__func__);
> > +		return -EINVAL;
> > +	}
> > +
> > +	vpmem = devm_kzalloc(&vdev->dev, sizeof(*vpmem), GFP_KERNEL);
> > +	if (!vpmem) {
> > +		err = -ENOMEM;
> > +		goto out_err;
> > +	}
> > +
> > +	vpmem->vdev = vdev;
> > +	vdev->priv = vpmem;
> > +	err = init_vq(vpmem);
> > +	if (err)
> > +		goto out_err;
> > +
> > +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> > +			start, &vpmem->start);
> > +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> > +			size, &vpmem->size);
> > +
> > +	res.start = vpmem->start;
> > +	res.end   = vpmem->start + vpmem->size-1;
> > +	vpmem->nd_desc.provider_name = "virtio-pmem";
> > +	vpmem->nd_desc.module = THIS_MODULE;
> > +
> > +	vpmem->nvdimm_bus = nvdimm_bus_register(&vdev->dev,
> > +						&vpmem->nd_desc);
> > +	if (!vpmem->nvdimm_bus)
> > +		goto out_vq;
> > +
> > +	dev_set_drvdata(&vdev->dev, vpmem->nvdimm_bus);
> > +
> > +	ndr_desc.res = &res;
> > +	ndr_desc.numa_node = nid;
> > +	ndr_desc.flush = async_pmem_flush;
> > +	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> > +	set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
> > +	nd_region = nvdimm_pmem_region_create(vpmem->nvdimm_bus, &ndr_desc);
> > +
> 
> I'd drop this empty line.

hmm.

> 
> > +	if (!nd_region)
> > +		goto out_nd;
> > +	nd_region->provider_data = dev_to_virtio(nd_region->dev.parent->parent);
> 
> Does it make sense to move some parts into separate functions for
> readability? E.g., virtio_pmem_init_nvdimm_bus()

I think this function only has initialization and don't have any complex logic.

> 
> > +	return 0;
> > +out_nd:
> > +	err = -ENXIO;
> 
> I'd always initialize "err" along with the goto statement for
> readability, especially because ...
> 
> > +	nvdimm_bus_unregister(vpmem->nvdimm_bus);
> > +out_vq:
> 
> ... you don't initialize err in this case. Err is here 0 if I am not wrong.

Right. Changed.

> 
> > +	vdev->config->del_vqs(vdev);
> > +out_err:
> > +	dev_err(&vdev->dev, "failed to register virtio pmem memory\n");
> 
> Should we try to give more meaning full messages? I can think of
> scenarios like "memory region is not properly aligned" or "out of memory".

o.k

> 
> > +	return err;
> > +}
> > +
> > +static void virtio_pmem_remove(struct virtio_device *vdev)
> > +{
> > +	struct nvdimm_bus *nvdimm_bus = dev_get_drvdata(&vdev->dev);
> > +
> 
> Is the nd_region implicitly cleaned up?

yes. it will be.

> 
> You are not freeing "vdev->priv".

vdev->priv is vpmem which is allocated using devm API.
> 
> > +	nvdimm_bus_unregister(nvdimm_bus);
> > +	vdev->config->del_vqs(vdev);
> > +	vdev->config->reset(vdev);
> > +}
> > +
> > +static struct virtio_driver virtio_pmem_driver = {
> > +	.driver.name		= KBUILD_MODNAME,
> > +	.driver.owner		= THIS_MODULE,
> > +	.id_table		= id_table,
> > +	.probe			= virtio_pmem_probe,
> > +	.remove			= virtio_pmem_remove,
> > +};
> > +
> > +module_virtio_driver(virtio_pmem_driver);
> > +MODULE_DEVICE_TABLE(virtio, id_table);
> > +MODULE_DESCRIPTION("Virtio pmem driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > index 35897649c24f..9f634a2ed638 100644
> > --- a/drivers/virtio/Kconfig
> > +++ b/drivers/virtio/Kconfig
> > @@ -42,6 +42,16 @@ config VIRTIO_PCI_LEGACY
> >  
> >  	  If unsure, say Y.
> >  
> > +config VIRTIO_PMEM
> > +	tristate "Support for virtio pmem driver"
> > +	depends on VIRTIO
> > +	depends on LIBNVDIMM
> > +	help
> > +	This driver provides support for virtio based flushing interface
> > +	for persistent memory range.
> 
> "This driver provides access to virtio-pmem devices, storage devices
> that are mapped into the physical address space - similar to NVDIMMs -
> with a virtio-based flushing interface." ... ?

looks better. Incorporated.

Thanks,
Pankaj
> 
> > +
> > +	If unsure, say M.
> > +
> 
> 
> --
> 
> Thanks,
> 
> David / dhildenb
> 
