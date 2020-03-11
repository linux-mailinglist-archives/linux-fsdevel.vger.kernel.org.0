Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32D87182249
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 20:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731132AbgCKT3z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 15:29:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56492 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730913AbgCKT3y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583954993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X8sydDPk2Nziuyx/YyOIFR5RvqNJQK0GeXPzyVTGcAM=;
        b=PqklOML1r21tLxCRAYFWqsx4RP4+DX3gMP0oRZyMDTTwLI0Cd7ldn5tT2da72h90vxQxNJ
        +xy50p/DUVVQpQUfjJLQztFoRgR81VEiuvB3g1wqHUG1+f5VqSFp+rmxLC435MzQQvafyY
        T8FvPC9BMTYz1R+TU6C6lpREErAK3S0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-OS115hD8P9auQI74FymxuA-1; Wed, 11 Mar 2020 15:29:50 -0400
X-MC-Unique: OS115hD8P9auQI74FymxuA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EB1A800D48;
        Wed, 11 Mar 2020 19:29:48 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E32660BF1;
        Wed, 11 Mar 2020 19:29:40 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id DB87522021D; Wed, 11 Mar 2020 15:29:39 -0400 (EDT)
Date:   Wed, 11 Mar 2020 15:29:39 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        dgilbert@redhat.com, mst@redhat.com,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 04/20] virtio: Implement get_shm_region for PCI transport
Message-ID: <20200311192939.GD83257@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-5-vgoyal@redhat.com>
 <20200310110437.GI140737@stefanha-x1.localdomain>
 <20200310181936.GC38440@redhat.com>
 <20200311173405.GI281087@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311173405.GI281087@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 11, 2020 at 05:34:05PM +0000, Stefan Hajnoczi wrote:
> On Tue, Mar 10, 2020 at 02:19:36PM -0400, Vivek Goyal wrote:
> > On Tue, Mar 10, 2020 at 11:04:37AM +0000, Stefan Hajnoczi wrote:
> > > On Wed, Mar 04, 2020 at 11:58:29AM -0500, Vivek Goyal wrote:
> > > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > > > index 7abcc50838b8..52f179411015 100644
> > > > --- a/drivers/virtio/virtio_pci_modern.c
> > > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > > @@ -443,6 +443,111 @@ static void del_vq(struct virtio_pci_vq_info *info)
> > > >  	vring_del_virtqueue(vq);
> > > >  }
> > > >  
> > > > +static int virtio_pci_find_shm_cap(struct pci_dev *dev,
> > > > +                                   u8 required_id,
> > > > +                                   u8 *bar, u64 *offset, u64 *len)
> > > > +{
> > > > +	int pos;
> > > > +
> > > > +        for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
> > > 
> > > Please fix the mixed tabs vs space indentation in this patch.
> > 
> > Will do. There are plenty of these in this patch.
> > 
> > > 
> > > > +static bool vp_get_shm_region(struct virtio_device *vdev,
> > > > +			      struct virtio_shm_region *region, u8 id)
> > > > +{
> > > > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > +	struct pci_dev *pci_dev = vp_dev->pci_dev;
> > > > +	u8 bar;
> > > > +	u64 offset, len;
> > > > +	phys_addr_t phys_addr;
> > > > +	size_t bar_len;
> > > > +	int ret;
> > > > +
> > > > +	if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len)) {
> > > > +		return false;
> > > > +	}
> > > > +
> > > > +	ret = pci_request_region(pci_dev, bar, "virtio-pci-shm");
> > > > +	if (ret < 0) {
> > > > +		dev_err(&pci_dev->dev, "%s: failed to request BAR\n",
> > > > +			__func__);
> > > > +		return false;
> > > > +	}
> > > > +
> > > > +	phys_addr = pci_resource_start(pci_dev, bar);
> > > > +	bar_len = pci_resource_len(pci_dev, bar);
> > > > +
> > > > +        if (offset + len > bar_len) {
> > > > +                dev_err(&pci_dev->dev,
> > > > +                        "%s: bar shorter than cap offset+len\n",
> > > > +                        __func__);
> > > > +                return false;
> > > > +        }
> > > > +
> > > > +	region->len = len;
> > > > +	region->addr = (u64) phys_addr + offset;
> > > > +
> > > > +	return true;
> > > > +}
> > > 
> > > Missing pci_release_region()?
> > 
> > Good catch. We don't have a mechanism to call pci_relese_region() and 
> > virtio-mmio device's ->get_shm_region() implementation does not even
> > seem to reserve the resources.
> > 
> > So how about we leave this resource reservation to the caller.
> > ->get_shm_region() just returns the addr/len pair of requested resource.
> > 
> > Something like this patch.
> > 
> > ---
> >  drivers/virtio/virtio_pci_modern.c |    8 --------
> >  fs/fuse/virtio_fs.c                |   13 ++++++++++---
> >  2 files changed, 10 insertions(+), 11 deletions(-)
> > 
> > Index: redhat-linux/fs/fuse/virtio_fs.c
> > ===================================================================
> > --- redhat-linux.orig/fs/fuse/virtio_fs.c	2020-03-10 09:13:34.624565666 -0400
> > +++ redhat-linux/fs/fuse/virtio_fs.c	2020-03-10 14:11:10.970284651 -0400
> > @@ -763,11 +763,18 @@ static int virtio_fs_setup_dax(struct vi
> >  	if (!have_cache) {
> >  		dev_notice(&vdev->dev, "%s: No cache capability\n", __func__);
> >  		return 0;
> > -	} else {
> > -		dev_notice(&vdev->dev, "Cache len: 0x%llx @ 0x%llx\n",
> > -			   cache_reg.len, cache_reg.addr);
> >  	}
> >  
> > +	if (!devm_request_mem_region(&vdev->dev, cache_reg.addr, cache_reg.len,
> > +				     dev_name(&vdev->dev))) {
> > +		dev_warn(&vdev->dev, "could not reserve region addr=0x%llx"
> > +			 " len=0x%llx\n", cache_reg.addr, cache_reg.len);
> > +		return -EBUSY;
> > +        }
> > +
> > +	dev_notice(&vdev->dev, "Cache len: 0x%llx @ 0x%llx\n", cache_reg.len,
> > +		   cache_reg.addr);
> > +
> >  	pgmap = devm_kzalloc(&vdev->dev, sizeof(*pgmap), GFP_KERNEL);
> >  	if (!pgmap)
> >  		return -ENOMEM;
> > Index: redhat-linux/drivers/virtio/virtio_pci_modern.c
> > ===================================================================
> > --- redhat-linux.orig/drivers/virtio/virtio_pci_modern.c	2020-03-10 08:51:36.886565666 -0400
> > +++ redhat-linux/drivers/virtio/virtio_pci_modern.c	2020-03-10 13:43:15.168753543 -0400
> > @@ -511,19 +511,11 @@ static bool vp_get_shm_region(struct vir
> >  	u64 offset, len;
> >  	phys_addr_t phys_addr;
> >  	size_t bar_len;
> > -	int ret;
> >  
> >  	if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len)) {
> >  		return false;
> >  	}
> >  
> > -	ret = pci_request_region(pci_dev, bar, "virtio-pci-shm");
> > -	if (ret < 0) {
> > -		dev_err(&pci_dev->dev, "%s: failed to request BAR\n",
> > -			__func__);
> > -		return false;
> > -	}
> > -
> >  	phys_addr = pci_resource_start(pci_dev, bar);
> >  	bar_len = pci_resource_len(pci_dev, bar);
> 
> Do pci_resource_start()/pci_resource_len() work on a BAR where
> pci_request_region() hasn't been called yet?  (I haven't checked the
> code, sorry...)

It should. Infact, pci_request_region() itself is calling
pci_resource_start() and pci_resource_len().

> 
> Assuming yes, then my next question is whether devm_request_mem_region()
> works in both the VIRTIO PCI and MMIO cases?

It should work on MMIO case as well. This basically works on /proc/iomem
resource tree to reserve resources. So as long as MMIO memory range
has been registered by driver in /proc/iomem, it will work.

> 
> If yes, then this looks like a solution, though the need for
> devm_request_mem_region() should be explained in the vp_get_shm_region()
> doc comments so that callers remember to make that call.  Or maybe it
> can be included in vp_get_shm_region().

How about adding a line in include/linux/virtio_config.h right below the
@get_shm_region descrition which says.

"This does not reserve the resources and caller is expected to call
 devm_request_mem_region() or similar to reserve resources."

Vivek

