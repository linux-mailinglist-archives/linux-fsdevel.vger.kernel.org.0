Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6F2240721
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 16:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgHJOCx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 10:02:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39027 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726771AbgHJOCp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597068164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zm9UN2ybwkEfJlU9ZzUNqxOkLJ5miUSnR65cKiA6LKQ=;
        b=XIqkoXUpavf+nNHKVVVIdBLUAhkAJNN7Pd+aqY9uXOKv0HVIjnr0kKFG7fIWQxuVAOf/rw
        ygtFfRLl8v7lQSUJoKw/6FUIBloWTRLPRbf8sV4UwumRRlBHLZqIFXx+pisVnlLGudK8u/
        +cRJZXgk29rl3nOD45UL6DmEMr7CdYc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-ygBUY6CgOqy0wcHWhT2tPw-1; Mon, 10 Aug 2020 10:02:35 -0400
X-MC-Unique: ygBUY6CgOqy0wcHWhT2tPw-1
Received: by mail-wr1-f71.google.com with SMTP id w7so4247038wre.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 07:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zm9UN2ybwkEfJlU9ZzUNqxOkLJ5miUSnR65cKiA6LKQ=;
        b=sYUsZQNhhqAEJfcAcDEKARGPqp7bLXVlpOvRZK76Ew4c+drYJB+V8jZJGsI+QD5Uxs
         vzktE8F0JC5qH6jTql2cVQxTfG8D4I5qHPPGmAl0kz7bXGfCk6Fy6CeVdxk9cKiL4Ppg
         9E1Pp/9RArkIbM6ZcnDcR/2XiKSLarFADta6PMjBlVaHwQCRoBZxJFKdGrxLZFNoVqmQ
         HFpUkYUMLjE2mpqcJfz7FllykR3F9qEfdRg3D7LcJWhdQ1FPJPSGJAyd7W3GZbtUvpiS
         q83ZdszI7g/oLVoG8gkPCGjhZjWQ9XwRArjeRecIctaD9NggUpyUAByfkwqn2B7oQz5n
         RAqQ==
X-Gm-Message-State: AOAM531H8uyILWQXV9yXyiv36ASCXiB8st4954H1VO72mDg7d3vMZiAu
        Bp5sBs1w8qe0stlL7oxAEqz3SMurt4qm/ZfilgLXg1xe+9ilgL06V8p9oxYnaSb93TG1E1wvher
        62dcIT1nqvLFRqe/l1JNO+F3UpQ==
X-Received: by 2002:a5d:5445:: with SMTP id w5mr26606309wrv.342.1597068153922;
        Mon, 10 Aug 2020 07:02:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZKDjbvxQpugjVT7WWVCyaGFDHI2C6roKb2nSqD1rm2kdDhSV2saxy4uo2FJ6CRvCgIJPxpg==
X-Received: by 2002:a5d:5445:: with SMTP id w5mr26606286wrv.342.1597068153685;
        Mon, 10 Aug 2020 07:02:33 -0700 (PDT)
Received: from redhat.com (bzq-109-67-41-16.red.bezeqint.net. [109.67.41.16])
        by smtp.gmail.com with ESMTPSA id z12sm21145712wrp.20.2020.08.10.07.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 07:02:33 -0700 (PDT)
Date:   Mon, 10 Aug 2020 10:02:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH v2 03/20] virtio: Add get_shm_region method
Message-ID: <20200810100208-mutt-send-email-mst@kernel.org>
References: <20200807195526.426056-1-vgoyal@redhat.com>
 <20200807195526.426056-4-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807195526.426056-4-vgoyal@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 07, 2020 at 03:55:09PM -0400, Vivek Goyal wrote:
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> 
> Virtio defines 'shared memory regions' that provide a continuously
> shared region between the host and guest.
> 
> Provide a method to find a particular region on a device.
> 
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: "Michael S. Tsirkin" <mst@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/linux/virtio_config.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index bb4cc4910750..c859f000a751 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -10,6 +10,11 @@
>  
>  struct irq_affinity;
>  
> +struct virtio_shm_region {
> +       u64 addr;
> +       u64 len;
> +};
> +
>  /**
>   * virtio_config_ops - operations for configuring a virtio device
>   * Note: Do not assume that a transport implements all of the operations
> @@ -65,6 +70,7 @@ struct irq_affinity;
>   *      the caller can then copy.
>   * @set_vq_affinity: set the affinity for a virtqueue (optional).
>   * @get_vq_affinity: get the affinity for a virtqueue (optional).
> + * @get_shm_region: get a shared memory region based on the index.
>   */
>  typedef void vq_callback_t(struct virtqueue *);
>  struct virtio_config_ops {
> @@ -88,6 +94,8 @@ struct virtio_config_ops {
>  			       const struct cpumask *cpu_mask);
>  	const struct cpumask *(*get_vq_affinity)(struct virtio_device *vdev,
>  			int index);
> +	bool (*get_shm_region)(struct virtio_device *vdev,
> +			       struct virtio_shm_region *region, u8 id);
>  };
>  
>  /* If driver didn't advertise the feature, it will never appear. */
> @@ -250,6 +258,15 @@ int virtqueue_set_affinity(struct virtqueue *vq, const struct cpumask *cpu_mask)
>  	return 0;
>  }
>  
> +static inline
> +bool virtio_get_shm_region(struct virtio_device *vdev,
> +                         struct virtio_shm_region *region, u8 id)
> +{
> +	if (!vdev->config->get_shm_region)
> +		return false;
> +	return vdev->config->get_shm_region(vdev, region, id);
> +}
> +
>  static inline bool virtio_is_little_endian(struct virtio_device *vdev)
>  {
>  	return virtio_has_feature(vdev, VIRTIO_F_VERSION_1) ||
> -- 
> 2.25.4
> 

