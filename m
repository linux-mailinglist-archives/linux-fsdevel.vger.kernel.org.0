Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7179E2DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 10:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbfH0Ijy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 04:39:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbfH0Ijy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:39:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5160F18C4272;
        Tue, 27 Aug 2019 08:39:54 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EED1E60923;
        Tue, 27 Aug 2019 08:39:45 +0000 (UTC)
Date:   Tue, 27 Aug 2019 10:39:43 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH 05/19] virtio: Implement get_shm_region for MMIO
 transport
Message-ID: <20190827103943.4c6c9342.cohuck@redhat.com>
In-Reply-To: <20190821175720.25901-6-vgoyal@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
        <20190821175720.25901-6-vgoyal@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Tue, 27 Aug 2019 08:39:54 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 21 Aug 2019 13:57:06 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> 
> On MMIO a new set of registers is defined for finding SHM
> regions.  Add their definitions and use them to find the region.
> 
> Cc: kvm@vger.kernel.org
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> ---
>  drivers/virtio/virtio_mmio.c     | 32 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_mmio.h | 11 +++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index e09edb5c5e06..5c07985c8cb8 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -500,6 +500,37 @@ static const char *vm_bus_name(struct virtio_device *vdev)
>  	return vm_dev->pdev->name;
>  }
>  
> +static bool vm_get_shm_region(struct virtio_device *vdev,
> +			      struct virtio_shm_region *region, u8 id)
> +{
> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +	u64 len, addr;
> +
> +	/* Select the region we're interested in */
> +	writel(id, vm_dev->base + VIRTIO_MMIO_SHM_SEL);
> +
> +	/* Read the region size */
> +	len = (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_LEN_LOW);
> +	len |= (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_LEN_HIGH) << 32;
> +
> +	region->len = len;
> +
> +	/* Check if region length is -1. If that's the case, the shared memory
> +	 * region does not exist and there is no need to proceed further.
> +	 */
> +	if (len == ~(u64)0) {
> +		return false;
> +	}

I think the curly braces should be dropped here.

> +
> +	/* Read the region base address */
> +	addr = (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_BASE_LOW);
> +	addr |= (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_BASE_HIGH) << 32;
> +
> +	region->addr = addr;
> +
> +	return true;
> +}
> +
>  static const struct virtio_config_ops virtio_mmio_config_ops = {
>  	.get		= vm_get,
>  	.set		= vm_set,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
