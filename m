Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDCA26CB79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 11:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389497AbfGRJE2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 05:04:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbfGRJE2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:04:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4492D3179157;
        Thu, 18 Jul 2019 09:04:27 +0000 (UTC)
Received: from gondolin (dhcp-192-232.str.redhat.com [10.33.192.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48FA760C70;
        Thu, 18 Jul 2019 09:04:20 +0000 (UTC)
Date:   Thu, 18 Jul 2019 11:04:17 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-nvdimm@lists.01.org, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, swhiteho@redhat.com,
        Sebastian Ott <sebott@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Collin Walling <walling@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 18/30] virtio_fs, dax: Set up virtio_fs dax_device
Message-ID: <20190718110417.561f6475.cohuck@redhat.com>
In-Reply-To: <20190717192725.25c3d146.pasic@linux.ibm.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
        <20190515192715.18000-19-vgoyal@redhat.com>
        <20190717192725.25c3d146.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 18 Jul 2019 09:04:27 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 17 Jul 2019 19:27:25 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 15 May 2019 15:27:03 -0400
> Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> > 
> > Setup a dax device.
> > 
> > Use the shm capability to find the cache entry and map it.
> > 
> > The DAX window is accessed by the fs/dax.c infrastructure and must have
> > struct pages (at least on x86).  Use devm_memremap_pages() to map the
> > DAX window PCI BAR and allocate struct page.
> >  
> 
> Sorry for being this late. I don't see any more recent version so I will
> comment here.

[Yeah, this one has been sitting in my to-review queue far too long as
well :(]

> 
> I'm trying to figure out how is this supposed to work on s390. My concern
> is, that on s390 PCI memory needs to be accessed by special
> instructions. This is taken care of by the stuff defined in
> arch/s390/include/asm/io.h. E.g. we 'override' __raw_writew so it uses
> the appropriate s390 instruction. However if the code does not use the
> linux abstractions for accessing PCI memory, but assumes it can be
> accessed like RAM, we have a problem.
> 
> Looking at this patch, it seems to me, that we might end up with exactly
> the case described. For example AFAICT copy_to_iter() (3) resolves to
> the function in lib/iov_iter.c which does not seem to cater for s390
> oddities.

What about the new pci instructions recently introduced? Not sure how
they differ from the old ones (which are currently the only ones
supported in QEMU...), but I'm pretty sure they are supposed to solve
an issue :)

> 
> I didn't have the time to investigate this properly, and since virtio-fs
> is virtual, we may be able to get around what is otherwise a
> limitation on s390. My understanding of these areas is admittedly
> shallow, and since I'm not sure I'll have much more time to
> invest in the near future I decided to raise concern.
> 
> Any opinions?

Let me point to the thread starting at
https://marc.info/?l=linux-s390&m=155048406205221&w=2 as well. That
memory region stuff is still unsolved for ccw, and I'm not sure if we
need to do something for zpci as well.

Does s390 work with DAX at all? ISTR that DAX evolved from XIP, so I
thought it did?

> 
> [CCing some s390 people who are probably more knowledgeable than my on
> these matters.]
> 
> Regards,
> Halil
> 
> 
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
> > ---  
> 
> [..]
>   
> > +/* Map a window offset to a page frame number.  The window offset will have
> > + * been produced by .iomap_begin(), which maps a file offset to a window
> > + * offset.
> > + */
> > +static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
> > +				    long nr_pages, void **kaddr, pfn_t *pfn)
> > +{
> > +	struct virtio_fs *fs = dax_get_private(dax_dev);
> > +	phys_addr_t offset = PFN_PHYS(pgoff);
> > +	size_t max_nr_pages = fs->window_len/PAGE_SIZE - pgoff;
> > +
> > +	if (kaddr)
> > +		*kaddr = fs->window_kaddr + offset;  
> 
> (2) Here we use fs->window_kaddr, basically directing the access to the
> virtio shared memory region.
> 
> > +	if (pfn)
> > +		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset,
> > +					PFN_DEV | PFN_MAP);
> > +	return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
> > +}
> > +
> > +static size_t virtio_fs_copy_from_iter(struct dax_device *dax_dev,
> > +				       pgoff_t pgoff, void *addr,
> > +				       size_t bytes, struct iov_iter *i)
> > +{
> > +	return copy_from_iter(addr, bytes, i);
> > +}
> > +
> > +static size_t virtio_fs_copy_to_iter(struct dax_device *dax_dev,
> > +				       pgoff_t pgoff, void *addr,
> > +				       size_t bytes, struct iov_iter *i)
> > +{
> > +	return copy_to_iter(addr, bytes, i);  
> 
> (3) And this should be the access to it. Which does not seem to use.
> 
> > +}
> > +
> > +static const struct dax_operations virtio_fs_dax_ops = {
> > +	.direct_access = virtio_fs_direct_access,
> > +	.copy_from_iter = virtio_fs_copy_from_iter,
> > +	.copy_to_iter = virtio_fs_copy_to_iter,
> > +};
> > +
> > +static void virtio_fs_percpu_release(struct percpu_ref *ref)
> > +{
> > +	struct virtio_fs_memremap_info *mi =
> > +		container_of(ref, struct virtio_fs_memremap_info, ref);
> > +
> > +	complete(&mi->completion);
> > +}
> > +
> > +static void virtio_fs_percpu_exit(void *data)
> > +{
> > +	struct virtio_fs_memremap_info *mi = data;
> > +
> > +	wait_for_completion(&mi->completion);
> > +	percpu_ref_exit(&mi->ref);
> > +}
> > +
> > +static void virtio_fs_percpu_kill(struct percpu_ref *ref)
> > +{
> > +	percpu_ref_kill(ref);
> > +}
> > +
> > +static void virtio_fs_cleanup_dax(void *data)
> > +{
> > +	struct virtio_fs *fs = data;
> > +
> > +	kill_dax(fs->dax_dev);
> > +	put_dax(fs->dax_dev);
> > +}
> > +
> > +static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
> > +{
> > +	struct virtio_shm_region cache_reg;
> > +	struct virtio_fs_memremap_info *mi;
> > +	struct dev_pagemap *pgmap;
> > +	bool have_cache;
> > +	int ret;
> > +
> > +	if (!IS_ENABLED(CONFIG_DAX_DRIVER))
> > +		return 0;
> > +
> > +	/* Get cache region */
> > +	have_cache = virtio_get_shm_region(vdev,
> > +					   &cache_reg,
> > +					   (u8)VIRTIO_FS_SHMCAP_ID_CACHE);
> > +	if (!have_cache) {
> > +		dev_err(&vdev->dev, "%s: No cache capability\n", __func__);
> > +		return -ENXIO;
> > +	} else {
> > +		dev_notice(&vdev->dev, "Cache len: 0x%llx @ 0x%llx\n",
> > +			   cache_reg.len, cache_reg.addr);
> > +	}
> > +
> > +	mi = devm_kzalloc(&vdev->dev, sizeof(*mi), GFP_KERNEL);
> > +	if (!mi)
> > +		return -ENOMEM;
> > +
> > +	init_completion(&mi->completion);
> > +	ret = percpu_ref_init(&mi->ref, virtio_fs_percpu_release, 0,
> > +			      GFP_KERNEL);
> > +	if (ret < 0) {
> > +		dev_err(&vdev->dev, "%s: percpu_ref_init failed (%d)\n",
> > +			__func__, ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = devm_add_action(&vdev->dev, virtio_fs_percpu_exit, mi);
> > +	if (ret < 0) {
> > +		percpu_ref_exit(&mi->ref);
> > +		return ret;
> > +	}
> > +
> > +	pgmap = &mi->pgmap;
> > +	pgmap->altmap_valid = false;
> > +	pgmap->ref = &mi->ref;
> > +	pgmap->kill = virtio_fs_percpu_kill;
> > +	pgmap->type = MEMORY_DEVICE_FS_DAX;
> > +
> > +	/* Ideally we would directly use the PCI BAR resource but
> > +	 * devm_memremap_pages() wants its own copy in pgmap.  So
> > +	 * initialize a struct resource from scratch (only the start
> > +	 * and end fields will be used).
> > +	 */
> > +	pgmap->res = (struct resource){
> > +		.name = "virtio-fs dax window",
> > +		.start = (phys_addr_t) cache_reg.addr,
> > +		.end = (phys_addr_t) cache_reg.addr + cache_reg.len - 1,
> > +	};
> > +
> > +	fs->window_kaddr = devm_memremap_pages(&vdev->dev, pgmap);  
> 
> (1) Here we assign fs->window_kaddr basically from the virtio shm region.
> 
> > +	if (IS_ERR(fs->window_kaddr))
> > +		return PTR_ERR(fs->window_kaddr);
> > +
> > +	fs->window_phys_addr = (phys_addr_t) cache_reg.addr;
> > +	fs->window_len = (phys_addr_t) cache_reg.len;
> > +
> > +	dev_dbg(&vdev->dev, "%s: window kaddr 0x%px phys_addr 0x%llx"
> > +		" len 0x%llx\n", __func__, fs->window_kaddr, cache_reg.addr,
> > +		cache_reg.len);
> > +
> > +	fs->dax_dev = alloc_dax(fs, NULL, &virtio_fs_dax_ops);
> > +	if (!fs->dax_dev)
> > +		return -ENOMEM;
> > +
> > +	return devm_add_action_or_reset(&vdev->dev, virtio_fs_cleanup_dax, fs);
> > +}
> > +  
> 
> [..]
> 

