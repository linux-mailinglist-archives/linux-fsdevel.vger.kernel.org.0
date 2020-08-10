Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D122406F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 15:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgHJNrZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 09:47:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20021 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726582AbgHJNrY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 09:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597067243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z8HxGZRX0ri3hL7o0UjLbQAuAiwO1V2HqhDwK8CAsEc=;
        b=ItWuB8pPNi0nxCVULljQkIlIeACHv7HM5byelrZmuCeZ9y/eoCqanYwvV77jVDK1UZ9Anm
        /XY9UTjC4Jcw4RjK1qXRd4IEnp9+LS/O0l11ATZqd/SS3v7FTScG8kl9IJwVluC7zEpySf
        adkNg59/X8aX/qIyEtWhIYxoliKfklg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-0DSijqLUMh2cqASImrVfCA-1; Mon, 10 Aug 2020 09:47:21 -0400
X-MC-Unique: 0DSijqLUMh2cqASImrVfCA-1
Received: by mail-wm1-f72.google.com with SMTP id g72so2807724wme.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 06:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z8HxGZRX0ri3hL7o0UjLbQAuAiwO1V2HqhDwK8CAsEc=;
        b=PGpggSk8/yEvBZ3SL0zQAy8OCm9G9gEtdoiK1hVo77dB9cPGRAJdo5T1yYAdlvGajG
         +9L9hJwXPHZlCpqbHAbAto3p8i+FBRbcDKR4vAEu53e0UM8+rjAG/s1uKDJW8sIDFrIL
         lZ+ax+8NCDVnVkkoFPFEUsYR/6wK+ic6Df7R0C/Kb9+aO/ITEzi3eiTqNGGN4+5mio8w
         w/PbEDf6JLJaPQxigEbldt7ihOdtvDT0TyC0EUO7PYWqUjcPJOONyondlEXMPTetHurd
         qaqcYSCfcN1jvolpqnAP96Ele2U8+tLXdAf3/Js/ZmYQj7z6gEVCxE2X+qt/4RKtrWvP
         W8/A==
X-Gm-Message-State: AOAM532Wo05eDYRcg7OmPSI3WZkbvHYAuw/x+zDK+MB/BZvdc4idh+E6
        GY7LbflwHLR3GRFMBYtjYALHZjB1hSLffBq29AEcrhyPCiDNtOFdEhlFVvXGvpVhp+5SYyJKLMd
        n88LWjwuxucaD+oIybVNi/rPKOA==
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr25773831wmb.150.1597067239974;
        Mon, 10 Aug 2020 06:47:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiKr4k+daNBgpJsJdAPnBhBio+aWOVADeV99EvpK7df75SgAQYK1b8ZOE3OtN5IXqUpVc1HA==
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr25773815wmb.150.1597067239779;
        Mon, 10 Aug 2020 06:47:19 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id g188sm24329476wma.5.2020.08.10.06.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 06:47:18 -0700 (PDT)
Date:   Mon, 10 Aug 2020 09:47:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH v2 03/20] virtio: Add get_shm_region method
Message-ID: <20200810094548-mutt-send-email-mst@kernel.org>
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

I'm not sure why doesn't b4 pick up reset of this
patchset. where can I find it?


IIUC all this is 5.10 material, right?


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

