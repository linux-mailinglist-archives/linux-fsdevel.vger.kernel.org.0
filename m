Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C32918060B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 19:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgCJSTt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 14:19:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27302 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726414AbgCJSTt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583864388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uG8IW8F1ik89QcwueTgT7AHnM1mDO66s69ntPDpnl4s=;
        b=ZfafQFSJLhX+9tidrId0WsL3+G8Kr5daypTyVTwyzunVb5a0RV9/Aw/sSDuprMIyaS3S1K
        7eYiA2vKdeL9KcDI9X2eib5wFeB/0pwsfwyJs/CmxKC8gD2S+SV8hqvGLmkMWLcEYy1rt2
        e38mbZSu+RCCmp+bc8udA/DRZiuJbJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-qCnev14MMHGNwVmv-MTKbw-1; Tue, 10 Mar 2020 14:19:46 -0400
X-MC-Unique: qCnev14MMHGNwVmv-MTKbw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75CB618B5FA2;
        Tue, 10 Mar 2020 18:19:45 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 34B678F358;
        Tue, 10 Mar 2020 18:19:37 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id AE75422021D; Tue, 10 Mar 2020 14:19:36 -0400 (EDT)
Date:   Tue, 10 Mar 2020 14:19:36 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        dgilbert@redhat.com, mst@redhat.com,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 04/20] virtio: Implement get_shm_region for PCI transport
Message-ID: <20200310181936.GC38440@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-5-vgoyal@redhat.com>
 <20200310110437.GI140737@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310110437.GI140737@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 10, 2020 at 11:04:37AM +0000, Stefan Hajnoczi wrote:
> On Wed, Mar 04, 2020 at 11:58:29AM -0500, Vivek Goyal wrote:
> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > index 7abcc50838b8..52f179411015 100644
> > --- a/drivers/virtio/virtio_pci_modern.c
> > +++ b/drivers/virtio/virtio_pci_modern.c
> > @@ -443,6 +443,111 @@ static void del_vq(struct virtio_pci_vq_info *info)
> >  	vring_del_virtqueue(vq);
> >  }
> >  
> > +static int virtio_pci_find_shm_cap(struct pci_dev *dev,
> > +                                   u8 required_id,
> > +                                   u8 *bar, u64 *offset, u64 *len)
> > +{
> > +	int pos;
> > +
> > +        for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
> 
> Please fix the mixed tabs vs space indentation in this patch.

Will do. There are plenty of these in this patch.

> 
> > +static bool vp_get_shm_region(struct virtio_device *vdev,
> > +			      struct virtio_shm_region *region, u8 id)
> > +{
> > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > +	struct pci_dev *pci_dev = vp_dev->pci_dev;
> > +	u8 bar;
> > +	u64 offset, len;
> > +	phys_addr_t phys_addr;
> > +	size_t bar_len;
> > +	int ret;
> > +
> > +	if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len)) {
> > +		return false;
> > +	}
> > +
> > +	ret = pci_request_region(pci_dev, bar, "virtio-pci-shm");
> > +	if (ret < 0) {
> > +		dev_err(&pci_dev->dev, "%s: failed to request BAR\n",
> > +			__func__);
> > +		return false;
> > +	}
> > +
> > +	phys_addr = pci_resource_start(pci_dev, bar);
> > +	bar_len = pci_resource_len(pci_dev, bar);
> > +
> > +        if (offset + len > bar_len) {
> > +                dev_err(&pci_dev->dev,
> > +                        "%s: bar shorter than cap offset+len\n",
> > +                        __func__);
> > +                return false;
> > +        }
> > +
> > +	region->len = len;
> > +	region->addr = (u64) phys_addr + offset;
> > +
> > +	return true;
> > +}
> 
> Missing pci_release_region()?

Good catch. We don't have a mechanism to call pci_relese_region() and 
virtio-mmio device's ->get_shm_region() implementation does not even
seem to reserve the resources.

So how about we leave this resource reservation to the caller.
->get_shm_region() just returns the addr/len pair of requested resource.

Something like this patch.

---
 drivers/virtio/virtio_pci_modern.c |    8 --------
 fs/fuse/virtio_fs.c                |   13 ++++++++++---
 2 files changed, 10 insertions(+), 11 deletions(-)

Index: redhat-linux/fs/fuse/virtio_fs.c
===================================================================
--- redhat-linux.orig/fs/fuse/virtio_fs.c	2020-03-10 09:13:34.624565666 -0400
+++ redhat-linux/fs/fuse/virtio_fs.c	2020-03-10 14:11:10.970284651 -0400
@@ -763,11 +763,18 @@ static int virtio_fs_setup_dax(struct vi
 	if (!have_cache) {
 		dev_notice(&vdev->dev, "%s: No cache capability\n", __func__);
 		return 0;
-	} else {
-		dev_notice(&vdev->dev, "Cache len: 0x%llx @ 0x%llx\n",
-			   cache_reg.len, cache_reg.addr);
 	}
 
+	if (!devm_request_mem_region(&vdev->dev, cache_reg.addr, cache_reg.len,
+				     dev_name(&vdev->dev))) {
+		dev_warn(&vdev->dev, "could not reserve region addr=0x%llx"
+			 " len=0x%llx\n", cache_reg.addr, cache_reg.len);
+		return -EBUSY;
+        }
+
+	dev_notice(&vdev->dev, "Cache len: 0x%llx @ 0x%llx\n", cache_reg.len,
+		   cache_reg.addr);
+
 	pgmap = devm_kzalloc(&vdev->dev, sizeof(*pgmap), GFP_KERNEL);
 	if (!pgmap)
 		return -ENOMEM;
Index: redhat-linux/drivers/virtio/virtio_pci_modern.c
===================================================================
--- redhat-linux.orig/drivers/virtio/virtio_pci_modern.c	2020-03-10 08:51:36.886565666 -0400
+++ redhat-linux/drivers/virtio/virtio_pci_modern.c	2020-03-10 13:43:15.168753543 -0400
@@ -511,19 +511,11 @@ static bool vp_get_shm_region(struct vir
 	u64 offset, len;
 	phys_addr_t phys_addr;
 	size_t bar_len;
-	int ret;
 
 	if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len)) {
 		return false;
 	}
 
-	ret = pci_request_region(pci_dev, bar, "virtio-pci-shm");
-	if (ret < 0) {
-		dev_err(&pci_dev->dev, "%s: failed to request BAR\n",
-			__func__);
-		return false;
-	}
-
 	phys_addr = pci_resource_start(pci_dev, bar);
 	bar_len = pci_resource_len(pci_dev, bar);
 

