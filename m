Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A016021365
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 07:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfEQFbp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 01:31:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbfEQFbp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 01:31:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7FAE811DC;
        Fri, 17 May 2019 05:31:43 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FC4660BE5;
        Fri, 17 May 2019 05:31:43 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 7045B1806B10;
        Fri, 17 May 2019 05:31:41 +0000 (UTC)
Date:   Fri, 17 May 2019 01:31:40 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>
Cc:     cohuck@redhat.com, jack@suse.cz, kvm@vger.kernel.org,
        jasowang@redhat.com, david@fromorbit.com, qemu-devel@nongnu.org,
        virtualization@lists.linux-foundation.org,
        adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org,
        aarcange@redhat.com, dave jiang <dave.jiang@intel.com>,
        jstaron@google.com, linux-nvdimm@lists.01.org,
        vishal l verma <vishal.l.verma@intel.com>,
        willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org,
        jmoyer@redhat.com, linux-ext4@vger.kernel.org, lenb@kernel.org,
        kilobyte@angband.pl, riel@surriel.com,
        yuval shaia <yuval.shaia@oracle.com>, stefanha@redhat.com,
        pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>,
        lcapitulino@redhat.com, kwolf@redhat.com, nilal@redhat.com,
        tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        darrick wong <darrick.wong@oracle.com>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, imammedo@redhat.com
Message-ID: <1808083054.29407926.1558071100913.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190516095618-mutt-send-email-mst@kernel.org>
References: <20190514145422.16923-1-pagupta@redhat.com> <20190514145422.16923-3-pagupta@redhat.com> <9f6b1d8e-ef90-7d8b-56da-61a426953ba3@redhat.com> <20190516095618-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v9 2/7] virtio-pmem: Add virtio pmem driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.188, 10.4.195.6]
Thread-Topic: virtio-pmem: Add virtio pmem driver
Thread-Index: FMi3zX+ydzvNE+LRIfWGkFwCXnTU+g==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 17 May 2019 05:31:44 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> 
> On Wed, May 15, 2019 at 10:46:00PM +0200, David Hildenbrand wrote:
> > > +	vpmem->vdev = vdev;
> > > +	vdev->priv = vpmem;
> > > +	err = init_vq(vpmem);
> > > +	if (err) {
> > > +		dev_err(&vdev->dev, "failed to initialize virtio pmem vq's\n");
> > > +		goto out_err;
> > > +	}
> > > +
> > > +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> > > +			start, &vpmem->start);
> > > +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> > > +			size, &vpmem->size);
> > > +
> > > +	res.start = vpmem->start;
> > > +	res.end   = vpmem->start + vpmem->size-1;
> > 
> > nit: " - 1;"
> > 
> > > +	vpmem->nd_desc.provider_name = "virtio-pmem";
> > > +	vpmem->nd_desc.module = THIS_MODULE;
> > > +
> > > +	vpmem->nvdimm_bus = nvdimm_bus_register(&vdev->dev,
> > > +						&vpmem->nd_desc);
> > > +	if (!vpmem->nvdimm_bus) {
> > > +		dev_err(&vdev->dev, "failed to register device with nvdimm_bus\n");
> > > +		err = -ENXIO;
> > > +		goto out_vq;
> > > +	}
> > > +
> > > +	dev_set_drvdata(&vdev->dev, vpmem->nvdimm_bus);
> > > +
> > > +	ndr_desc.res = &res;
> > > +	ndr_desc.numa_node = nid;
> > > +	ndr_desc.flush = async_pmem_flush;
> > > +	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> > > +	set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
> > > +	nd_region = nvdimm_pmem_region_create(vpmem->nvdimm_bus, &ndr_desc);
> > > +	if (!nd_region) {
> > > +		dev_err(&vdev->dev, "failed to create nvdimm region\n");
> > > +		err = -ENXIO;
> > > +		goto out_nd;
> > > +	}
> > > +	nd_region->provider_data =
> > > dev_to_virtio(nd_region->dev.parent->parent);
> > > +	return 0;
> > > +out_nd:
> > > +	nvdimm_bus_unregister(vpmem->nvdimm_bus);
> > > +out_vq:
> > > +	vdev->config->del_vqs(vdev);
> > > +out_err:
> > > +	return err;
> > > +}
> > > +
> > > +static void virtio_pmem_remove(struct virtio_device *vdev)
> > > +{
> > > +	struct nvdimm_bus *nvdimm_bus = dev_get_drvdata(&vdev->dev);
> > > +
> > > +	nvdimm_bus_unregister(nvdimm_bus);
> > > +	vdev->config->del_vqs(vdev);
> > > +	vdev->config->reset(vdev);
> > > +}
> > > +
> > > +static struct virtio_driver virtio_pmem_driver = {
> > > +	.driver.name		= KBUILD_MODNAME,
> > > +	.driver.owner		= THIS_MODULE,
> > > +	.id_table		= id_table,
> > > +	.probe			= virtio_pmem_probe,
> > > +	.remove			= virtio_pmem_remove,
> > > +};
> > > +
> > > +module_virtio_driver(virtio_pmem_driver);
> > > +MODULE_DEVICE_TABLE(virtio, id_table);
> > > +MODULE_DESCRIPTION("Virtio pmem driver");
> > > +MODULE_LICENSE("GPL");
> > > diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
> > > new file mode 100644
> > > index 000000000000..ab1da877575d
> > > --- /dev/null
> > > +++ b/drivers/nvdimm/virtio_pmem.h
> > > @@ -0,0 +1,60 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * virtio_pmem.h: virtio pmem Driver
> > > + *
> > > + * Discovers persistent memory range information
> > > + * from host and provides a virtio based flushing
> > > + * interface.
> > > + **/
> > > +
> > > +#ifndef _LINUX_VIRTIO_PMEM_H
> > > +#define _LINUX_VIRTIO_PMEM_H
> > > +
> > > +#include <linux/virtio_ids.h>
> > > +#include <linux/module.h>
> > > +#include <linux/virtio_config.h>
> > > +#include <uapi/linux/virtio_pmem.h>
> > > +#include <linux/libnvdimm.h>
> > > +#include <linux/spinlock.h>
> > > +
> > > +struct virtio_pmem_request {
> > > +	/* Host return status corresponding to flush request */
> > > +	int ret;
> > > +
> > > +	/* command name*/
> > > +	char name[16];
> > 
> > So ... why are we sending string commands and expect native-endianess
> > integers and don't define a proper request/response structure + request
> > types in include/uapi/linux/virtio_pmem.h like
> 
> passing names could be ok.
> I missed the fact we return a native endian int.
> Pls fix that.

Sure. will fix this.

> 
> 
> > 
> > struct virtio_pmem_resp {
> > 	__virtio32 ret;
> > }
> > 
> > #define VIRTIO_PMEM_REQ_TYPE_FLUSH	1
> > struct virtio_pmem_req {
> > 	__virtio16 type;
> > }
> > 
> > ... and this way we also define a proper endianess format for exchange
> > and keep it extensible
> > 
> > @MST, what's your take on this?
> 
> Extensions can always use feature bits so I don't think
> it's a problem.

That was exactly my thought when I implemented this. Though I am
fine with separate structures for request/response and I made the
change. 

Thank you for all the comments.

Best regards,
Pankaj 
> > 
> > --
> > 
> > Thanks,
> > 
> > David / dhildenb
> 
> 
