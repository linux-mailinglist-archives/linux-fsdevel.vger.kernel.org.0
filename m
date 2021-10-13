Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E3A42C524
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 17:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbhJMPtN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 11:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbhJMPsO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 11:48:14 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20A4C061765
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Oct 2021 08:46:10 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id t184so1975160pfd.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Oct 2021 08:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5P0ocxXM0vPODGkh8na4Mfy39/EYyFv4GMRrvhNNOUo=;
        b=gfAizaxTiwRe31oPHuSEfCuoU3UyNzjvSGFjRtR0+20ybGnOJHR2SNvIUYXuMY2xpD
         gjbOwicFvptk+HxbA9gztDS/NFb/B9PCmms4ywTb+W6ZfybGlSGnqIF9BrEyW3lnzugF
         1xOsRizGgXSxqW3rE2o7H3pOyE6LnVUrXJS6JM8CS2LKu70yomZ+jIXvV9GC/9hEoAdh
         pZgLdZj46NdkkNldf1y6Zal4VF0OHZO5HByoWBC8S5+MsG5/UJx0h6V+EfRdjNyAV2md
         QHEhpyLmWUQN/xdLKYedMbdiT11toyum2MbaAnr8R6GfEwVc/Pi4akUF4ElQql0esd+K
         tzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5P0ocxXM0vPODGkh8na4Mfy39/EYyFv4GMRrvhNNOUo=;
        b=RzLCyefBPUHtkLy2AqciiFIq/lvkM4HinF8Qf3G7ipZmVQ7MF043rzDizc/FPS3J/P
         HjwuJtvGo/JCfHW+3W2ZWKVqcO8/q6QIm8qEUCI9OezYDsrTjVrI7aAj2v0JoQDtvCyO
         lMC2dHWUX2N4XShqPFGRyccuww30G4zZpSROdYpfPzOQMHDe7ZguLxpfg7Ku8UEQ5Urf
         NInZPVxLuh2YoyrHHxskZJhepVQcHpneJDZ9GNewP/oW2wnLjW6e8LVoJOz3zE0V3gth
         QB+TKBokWtNSEG65n6u2y7CPv/sIdkGviIaPQYmqtPqbg+eZ0LtwrUJ5ePtMONoGYIex
         Rrxw==
X-Gm-Message-State: AOAM532Issbqf3Z3qycJxBRmq1Z2K7tXYVlGgqInZzn6Sh8EpuVBnp3X
        Cc4sIhqQttmbIdII3RgvFyLU2A==
X-Google-Smtp-Source: ABdhPJxOS97EPwZsGm56NgXmycC48sC/ZWo8Q8DTT9IZBXIVEcdfskLSNijWrQkjT1bVWFJiZLyKew==
X-Received: by 2002:aa7:949c:0:b0:44c:a0df:2c7f with SMTP id z28-20020aa7949c000000b0044ca0df2c7fmr128668pfk.34.1634139970091;
        Wed, 13 Oct 2021 08:46:10 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id x27sm2452841pfo.90.2021.10.13.08.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 08:46:09 -0700 (PDT)
Date:   Wed, 13 Oct 2021 09:46:04 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gonglei <arei.gonglei@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jie Deng <jie.deng@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Anton Yakovlev <anton.yakovlev@opensynergy.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-um@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-i2c@vger.kernel.org, iommu@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-remoteproc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, kvm@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH RFC] virtio: wrap config->reset calls
Message-ID: <20211013154604.GB4135908@p14s>
References: <20211013105226.20225-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013105226.20225-1-mst@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 13, 2021 at 06:55:31AM -0400, Michael S. Tsirkin wrote:
> This will enable cleanups down the road.
> The idea is to disable cbs, then add "flush_queued_cbs" callback
> as a parameter, this way drivers can flush any work
> queued after callbacks have been disabled.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/um/drivers/virt-pci.c                 | 2 +-
>  drivers/block/virtio_blk.c                 | 4 ++--
>  drivers/bluetooth/virtio_bt.c              | 2 +-
>  drivers/char/hw_random/virtio-rng.c        | 2 +-
>  drivers/char/virtio_console.c              | 4 ++--
>  drivers/crypto/virtio/virtio_crypto_core.c | 8 ++++----
>  drivers/firmware/arm_scmi/virtio.c         | 2 +-
>  drivers/gpio/gpio-virtio.c                 | 2 +-
>  drivers/gpu/drm/virtio/virtgpu_kms.c       | 2 +-
>  drivers/i2c/busses/i2c-virtio.c            | 2 +-
>  drivers/iommu/virtio-iommu.c               | 2 +-
>  drivers/net/caif/caif_virtio.c             | 2 +-
>  drivers/net/virtio_net.c                   | 4 ++--
>  drivers/net/wireless/mac80211_hwsim.c      | 2 +-
>  drivers/nvdimm/virtio_pmem.c               | 2 +-
>  drivers/rpmsg/virtio_rpmsg_bus.c           | 2 +-
>  drivers/scsi/virtio_scsi.c                 | 2 +-
>  drivers/virtio/virtio.c                    | 5 +++++
>  drivers/virtio/virtio_balloon.c            | 2 +-
>  drivers/virtio/virtio_input.c              | 2 +-
>  drivers/virtio/virtio_mem.c                | 2 +-
>  fs/fuse/virtio_fs.c                        | 4 ++--
>  include/linux/virtio.h                     | 1 +
>  net/9p/trans_virtio.c                      | 2 +-
>  net/vmw_vsock/virtio_transport.c           | 4 ++--
>  sound/virtio/virtio_card.c                 | 4 ++--
>  26 files changed, 39 insertions(+), 33 deletions(-)
> 
>  static struct virtio_driver virtio_pmem_driver = {
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 8e49a3bacfc7..6a11952822df 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -1015,7 +1015,7 @@ static void rpmsg_remove(struct virtio_device *vdev)
>  	size_t total_buf_space = vrp->num_bufs * vrp->buf_size;
>  	int ret;
>  
> -	vdev->config->reset(vdev);
> +	virtio_reset_device(vdev);
> 

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  	ret = device_for_each_child(&vdev->dev, NULL, rpmsg_remove_device);
>  	if (ret)
