Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66537240729
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 16:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgHJOF2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 10:05:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37400 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726894AbgHJOF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597068324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ye/STDc8dVw5OUpY6piPnmPc1y/hoA9IwVw3n1eaj/I=;
        b=Z2lOopw+CpdAAx9JPrNsfwgqjGGgHNSeCHg2ufWoemR7mkVtBQpPM+yu4aTNC0BoTHn7ry
        7eci9IQwSo79XBwy1pszagau6+wwgEcE/0mjKkmOHoGH//X18z661apWc9n3jkwtY7pqJs
        55CqjQynRVaGdwxnRzyueCurSrm+KFg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-pK5bjmB5OkGXtYPWfXs99Q-1; Mon, 10 Aug 2020 10:05:22 -0400
X-MC-Unique: pK5bjmB5OkGXtYPWfXs99Q-1
Received: by mail-wr1-f70.google.com with SMTP id r29so4271247wrr.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 07:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ye/STDc8dVw5OUpY6piPnmPc1y/hoA9IwVw3n1eaj/I=;
        b=a+5kmtoy5G7d1S0k/v/Rok5exP632mb3TDB7TbM/udDhmoRjKZusL/uUE7d7DXNOVk
         4I39XMSIjaLsNwVSRX1DKebnDDDHrbbvW/VKsuNo4HG5PXR+gB8tQSDrttVU7Dh3JXQD
         uN+8RjUczIvDBB0g+VeAnBkb2yIFhMSP+MEe2YQpMorWQssJ2vu6JgZs259P9rA1WUu7
         BK7a4P0a1m2kv4CESo447Le5KZZ+jqhVxp2xcpNX06QhTl9tOGhm2KgSBwgEzlQR3zC2
         tspx/8j0FXH/BUQBfRg8hm2/N+uFDysw2kc0a1gJf6YBxZfMJQHPp2zGV53am3Ox52jt
         BO6A==
X-Gm-Message-State: AOAM533AzvMpxmst3GVRAXCvTKZCSmR+epGbPHaFhmNf8+tRmR2Rva3N
        WdtD1G0D4SjJ7TINyStGwCuEYWg/rHYSO5+A2mZWpAJx38tXZKIaL88XKFRM9mV/bUNxDHRNOJV
        edfJFOkuVhc2qL9bzxHKDRgMzjA==
X-Received: by 2002:a1c:c1:: with SMTP id 184mr27136040wma.105.1597068321559;
        Mon, 10 Aug 2020 07:05:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzorEFqs/XOV7ysqCmHgKLQs9ZocL0F0fNY630G3930foEbfx5F1jUlfhfk8b3zLOAFgTSQyg==
X-Received: by 2002:a1c:c1:: with SMTP id 184mr27136011wma.105.1597068321319;
        Mon, 10 Aug 2020 07:05:21 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
        by smtp.gmail.com with ESMTPSA id r3sm21185627wro.1.2020.08.10.07.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 07:05:20 -0700 (PDT)
Date:   Mon, 10 Aug 2020 10:05:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kbuild test robot <lkp@intel.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v2 04/20] virtio: Implement get_shm_region for PCI
 transport
Message-ID: <20200810100327-mutt-send-email-mst@kernel.org>
References: <20200807195526.426056-1-vgoyal@redhat.com>
 <20200807195526.426056-5-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807195526.426056-5-vgoyal@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 07, 2020 at 03:55:10PM -0400, Vivek Goyal wrote:
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> 
> On PCI the shm regions are found using capability entries;
> find a region by searching for the capability.
> 
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: kbuild test robot <lkp@intel.com>
> Cc: kvm@vger.kernel.org
> Cc: "Michael S. Tsirkin" <mst@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  drivers/virtio/virtio_pci_modern.c | 96 ++++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_pci.h    | 11 +++-
>  2 files changed, 106 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index db93cedd262f..3fc0cd848fe9 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -444,6 +444,100 @@ static void del_vq(struct virtio_pci_vq_info *info)
>  	vring_del_virtqueue(vq);
>  }
>  
> +static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
> +				   u8 *bar, u64 *offset, u64 *len)
> +{
> +	int pos;
> +
> +	for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR); pos > 0;
> +	     pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
> +		u8 type, cap_len, id;
> +		u32 tmp32;
> +		u64 res_offset, res_length;
> +
> +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> +							 cfg_type), &type);
> +		if (type != VIRTIO_PCI_CAP_SHARED_MEMORY_CFG)
> +			continue;
> +
> +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> +							 cap_len), &cap_len);
> +		if (cap_len != sizeof(struct virtio_pci_cap64)) {
> +			printk(KERN_ERR "%s: shm cap with bad size offset: %d"
> +			       "size: %d\n", __func__, pos, cap_len);
> +			continue;
> +		}
> +
> +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> +                                                         id), &id);
> +		if (id != required_id)
> +			continue;
> +
> +		/* Type, and ID match, looks good */
> +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> +							 bar), bar);
> +
> +		/* Read the lower 32bit of length and offset */
> +		pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap,
> +							  offset), &tmp32);
> +		res_offset = tmp32;
> +		pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap,
> +							  length), &tmp32);
> +		res_length = tmp32;
> +
> +		/* and now the top half */
> +		pci_read_config_dword(dev,
> +				      pos + offsetof(struct virtio_pci_cap64,
> +                                                     offset_hi), &tmp32);
> +		res_offset |= ((u64)tmp32) << 32;
> +		pci_read_config_dword(dev,
> +				      pos + offsetof(struct virtio_pci_cap64,
> +                                                     length_hi), &tmp32);
> +		res_length |= ((u64)tmp32) << 32;
> +
> +		*offset = res_offset;
> +		*len = res_length;
> +
> +		return pos;
> +	}
> +	return 0;
> +}
> +
> +static bool vp_get_shm_region(struct virtio_device *vdev,
> +			      struct virtio_shm_region *region, u8 id)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	struct pci_dev *pci_dev = vp_dev->pci_dev;
> +	u8 bar;
> +	u64 offset, len;
> +	phys_addr_t phys_addr;
> +	size_t bar_len;
> +
> +	if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len)) {
> +		return false;
> +	}
> +
> +	phys_addr = pci_resource_start(pci_dev, bar);
> +	bar_len = pci_resource_len(pci_dev, bar);
> +
> +	if ((offset + len) < offset) {
> +		dev_err(&pci_dev->dev, "%s: cap offset+len overflow detected\n",
> +			__func__);
> +		return false;
> +	}
> +
> +	if (offset + len > bar_len) {
> +		dev_err(&pci_dev->dev, "%s: bar shorter than cap offset+len\n",
> +			__func__);
> +		return false;
> +	}

Maybe move this to a common header so the checks can be reused by
other transports? Can be a patch on top.

> +
> +	region->len = len;
> +	region->addr = (u64) phys_addr + offset;
> +
> +	return true;
> +}
> +
>  static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>  	.get		= NULL,
>  	.set		= NULL,
> @@ -458,6 +552,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>  	.bus_name	= vp_bus_name,
>  	.set_vq_affinity = vp_set_vq_affinity,
>  	.get_vq_affinity = vp_get_vq_affinity,
> +	.get_shm_region  = vp_get_shm_region,
>  };
>  
>  static const struct virtio_config_ops virtio_pci_config_ops = {
> @@ -474,6 +569,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>  	.bus_name	= vp_bus_name,
>  	.set_vq_affinity = vp_set_vq_affinity,
>  	.get_vq_affinity = vp_get_vq_affinity,
> +	.get_shm_region  = vp_get_shm_region,
>  };
>  
>  /**
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index 90007a1abcab..fe9f43680a1d 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -113,6 +113,8 @@
>  #define VIRTIO_PCI_CAP_DEVICE_CFG	4
>  /* PCI configuration access */
>  #define VIRTIO_PCI_CAP_PCI_CFG		5
> +/* Additional shared memory capability */
> +#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
>  
>  /* This is the PCI capability header: */
>  struct virtio_pci_cap {
> @@ -121,11 +123,18 @@ struct virtio_pci_cap {
>  	__u8 cap_len;		/* Generic PCI field: capability length */
>  	__u8 cfg_type;		/* Identifies the structure. */
>  	__u8 bar;		/* Where to find it. */
> -	__u8 padding[3];	/* Pad to full dword. */
> +	__u8 id;		/* Multiple capabilities of the same type */
> +	__u8 padding[2];	/* Pad to full dword. */
>  	__le32 offset;		/* Offset within bar. */
>  	__le32 length;		/* Length of the structure, in bytes. */
>  };
>  
> +struct virtio_pci_cap64 {
> +       struct virtio_pci_cap cap;
> +       __le32 offset_hi;             /* Most sig 32 bits of offset */
> +       __le32 length_hi;             /* Most sig 32 bits of length */
> +};
> +
>  struct virtio_pci_notify_cap {
>  	struct virtio_pci_cap cap;
>  	__le32 notify_off_multiplier;	/* Multiplier for queue_notify_off. */
> -- 
> 2.25.4
> 

