Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7D81C654
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 11:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfENJrY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 05:47:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfENJrY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 05:47:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D76F308427C;
        Tue, 14 May 2019 09:47:23 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CA275D6A6;
        Tue, 14 May 2019 09:47:23 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id BDAEA18089CC;
        Tue, 14 May 2019 09:47:22 +0000 (UTC)
Date:   Tue, 14 May 2019 05:47:22 -0400 (EDT)
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
Message-ID: <712871093.28555872.1557827242385.JavaMail.zimbra@redhat.com>
In-Reply-To: <86298c2c-cc7c-5b97-0f11-335d7da8c450@redhat.com>
References: <20190510155202.14737-1-pagupta@redhat.com> <20190510155202.14737-3-pagupta@redhat.com> <f2ea35a6-ec98-447c-44fe-0cb3ab309340@redhat.com> <752392764.28554139.1557826022323.JavaMail.zimbra@redhat.com> <86298c2c-cc7c-5b97-0f11-335d7da8c450@redhat.com>
Subject: Re: [PATCH v8 2/6] virtio-pmem: Add virtio pmem driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.16.148, 10.4.195.13]
Thread-Topic: virtio-pmem: Add virtio pmem driver
Thread-Index: 8wNBImudyN2CQ1nMcWyCrDq+wnVDqg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 14 May 2019 09:47:23 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> 
> >>
> >>> +	}
> >>> +
> >>> +	/* When host has read buffer, this completes via host_ack */
> >>
> >> "A host repsonse results in "host_ack" getting called" ... ?
> >>
> >>> +	wait_event(req->host_acked, req->done);
> >>> +	err = req->ret;
> >>> +ret:
> >>> +	kfree(req);
> >>> +	return err;
> >>> +};
> >>> +
> >>> +/* The asynchronous flush callback function */
> >>> +int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
> >>> +{
> >>> +	int rc = 0;
> >>> +
> >>> +	/* Create child bio for asynchronous flush and chain with
> >>> +	 * parent bio. Otherwise directly call nd_region flush.
> >>> +	 */
> >>> +	if (bio && bio->bi_iter.bi_sector != -1) {
> >>> +		struct bio *child = bio_alloc(GFP_ATOMIC, 0);
> >>> +
> >>> +		if (!child)
> >>> +			return -ENOMEM;
> >>> +		bio_copy_dev(child, bio);
> >>> +		child->bi_opf = REQ_PREFLUSH;
> >>> +		child->bi_iter.bi_sector = -1;
> >>> +		bio_chain(child, bio);
> >>> +		submit_bio(child);
> >>
> >> return 0;
> >>
> >> Then, drop the "else" case and "int rc" and do directly
> >>
> >> if (virtio_pmem_flush(nd_region))
> >> 	return -EIO;
> > 
> > and another 'return 0' here :)
> > 
> > I don't like return from multiple places instead I prefer
> > single exit point from function.
> 
> Makes this function more complicated than necessary. I agree when there
> are locks involved.

o.k. I will change as you suggest :)

> 
> >  
> >>
> >>> +
> >>> +	return 0;
> >>> +};
> >>> +
> >>> +static int virtio_pmem_probe(struct virtio_device *vdev)
> >>> +{
> >>> +	int err = 0;
> >>> +	struct resource res;
> >>> +	struct virtio_pmem *vpmem;
> >>> +	struct nd_region_desc ndr_desc = {};
> >>> +	int nid = dev_to_node(&vdev->dev);
> >>> +	struct nd_region *nd_region;
> >>
> >> Nit: use reverse Christmas tree layout :)
> > 
> > Done.
> > 
> >>
> >>> +
> >>> +	if (!vdev->config->get) {
> >>> +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> >>> +			__func__);
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	vpmem = devm_kzalloc(&vdev->dev, sizeof(*vpmem), GFP_KERNEL);
> >>> +	if (!vpmem) {
> >>> +		err = -ENOMEM;
> >>> +		goto out_err;
> >>> +	}
> >>> +
> >>> +	vpmem->vdev = vdev;
> >>> +	vdev->priv = vpmem;
> >>> +	err = init_vq(vpmem);
> >>> +	if (err)
> >>> +		goto out_err;
> >>> +
> >>> +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> >>> +			start, &vpmem->start);
> >>> +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> >>> +			size, &vpmem->size);
> >>> +
> >>> +	res.start = vpmem->start;
> >>> +	res.end   = vpmem->start + vpmem->size-1;
> >>> +	vpmem->nd_desc.provider_name = "virtio-pmem";
> >>> +	vpmem->nd_desc.module = THIS_MODULE;
> >>> +
> >>> +	vpmem->nvdimm_bus = nvdimm_bus_register(&vdev->dev,
> >>> +						&vpmem->nd_desc);
> >>> +	if (!vpmem->nvdimm_bus)
> >>> +		goto out_vq;
> >>> +
> >>> +	dev_set_drvdata(&vdev->dev, vpmem->nvdimm_bus);
> >>> +
> >>> +	ndr_desc.res = &res;
> >>> +	ndr_desc.numa_node = nid;
> >>> +	ndr_desc.flush = async_pmem_flush;
> >>> +	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> >>> +	set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
> >>> +	nd_region = nvdimm_pmem_region_create(vpmem->nvdimm_bus, &ndr_desc);
> >>> +
> >>
> >> I'd drop this empty line.
> > 
> > hmm.
> > 
> 
> The common pattern after allocating something, immediately check for it
> in the next line (like you do throughout this patch ;) )

Right. But rare times when I see space will beauty the code I tend to
add it. Maybe I should not :)

> 
> ...
> >> You are not freeing "vdev->priv".
> > 
> > vdev->priv is vpmem which is allocated using devm API.
> 
> I'm confused. Looking at drivers/virtio/virtio_balloon.c:
> 
> static void virtballoon_remove(struct virtio_device *vdev)
> {
> 	struct virtio_balloon *vb = vdev->priv;
> 
> 	...
> 
> 	kfree(vb);
> }
> 
> I think you should do the same here, vdev->priv is allocated in
> virtio_pmem_probe.
> 
> But maybe I am missing something important here :)

Because virtio_balloon use "kzalloc" for allocation and needs to be freed. 
But virtio pmem uses "devm_kzalloc" which takes care of automatically deleting 
the device memory when associated device is detached.

Thanks,
Pankaj
> 
> >>
> >>> +	nvdimm_bus_unregister(nvdimm_bus);
> >>> +	vdev->config->del_vqs(vdev);
> >>> +	vdev->config->reset(vdev);
> >>> +}
> >>> +
> 
> --
> 
> Thanks,
> 
> David / dhildenb
> 
