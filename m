Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE7C527FFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 10:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbiEPIo5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 04:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241911AbiEPIoj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 04:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93438F5A1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 01:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652690666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sIh/SA6Lh64JUzXDkOFTJ2gpJyP3Qx/KaUYhX+otn9k=;
        b=hOMitaAJh+pjpEL0/UVbNK1eAbyEJ67uxU70dpdHnMFHujW8se3Icf417F5N65fRNU4TPB
        mCUi6/cS7zmY9BlEVd2T+qXIby+uXT3BfpfN14FEz9HXYFOqUIdwmHSvrBzus5PbF9c+SL
        ttM+J/dfgc4Sav7l/bBqndUw+8PX5q4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-qRBgVyijPsarCCejX1lAIQ-1; Mon, 16 May 2022 04:44:25 -0400
X-MC-Unique: qRBgVyijPsarCCejX1lAIQ-1
Received: by mail-wm1-f71.google.com with SMTP id k35-20020a05600c1ca300b003946a9764baso10026212wms.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 01:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sIh/SA6Lh64JUzXDkOFTJ2gpJyP3Qx/KaUYhX+otn9k=;
        b=E1shZqzRpgspxDUe0eE7BpZcKqj4v8sPswdKXZOZuyh0POU0el8YxeXtKEJX5L2AAn
         HZPlB4XEDockNgfSrPLEbRDrdFGwybCRw5TYSKBK4qE50an21SG3A5jwmRW8gg+Qv3r6
         nFmEivWHf8VeXv7SIr7XAzOYix6QPxA8Nv0l5RTm+aw90GRLERSImoyv/PIqJKYHfCeo
         ZHSL7Fu7C/lTd44IdofWvEdJSMSKiWQ6pU24qCieQdk/gCK+DqydusY2UzY1YHqp15p3
         rD5YMGW2ewdsXyxaVT+R7ckZZ7OmYatPFcKlUPaVRMlTl7+z5WkenuWSf7GhdMBpCaeW
         eQ6A==
X-Gm-Message-State: AOAM531kCChhzROhd0D8aw1yk2rc6FlEhlSPWN72Qsf/9LiCAA0WTUK8
        lN24NMqUZPam0CZdeCPU2xvoVTGGwrD1ewckm27MGk4viZEQRTEsDc3eg6CZfFWkFknaIY4081N
        Eyj0eS0A1aqyyzF4+GrVPl9FEUA==
X-Received: by 2002:adf:d1e7:0:b0:20c:61a7:de2a with SMTP id g7-20020adfd1e7000000b0020c61a7de2amr13269784wrd.332.1652690663749;
        Mon, 16 May 2022 01:44:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbBG8LK3Kh/lhJrrOS7oQF11zBcMwtWlGcaXVik8WHSHfaxvjP441ee8zh05lWN6MkOd+W8g==
X-Received: by 2002:adf:d1e7:0:b0:20c:61a7:de2a with SMTP id g7-20020adfd1e7000000b0020c61a7de2amr13269770wrd.332.1652690663494;
        Mon, 16 May 2022 01:44:23 -0700 (PDT)
Received: from redhat.com ([2.55.141.66])
        by smtp.gmail.com with ESMTPSA id d3-20020a1c7303000000b003942a244ee6sm9682633wmb.43.2022.05.16.01.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 01:44:23 -0700 (PDT)
Date:   Mon, 16 May 2022 04:44:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     viro@zeniv.linux.org.uk, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ebiggers@kernel.org, davem@davemloft.net
Subject: Re: [PATCH] vhost_net: fix double fget()
Message-ID: <20220516044400-mutt-send-email-mst@kernel.org>
References: <20220516084213.26854-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516084213.26854-1-jasowang@redhat.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 16, 2022 at 04:42:13PM +0800, Jason Wang wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Here's another piece of code assuming that repeated fget() will yield the
> same opened file: in vhost_net_set_backend() we have
> 
>         sock = get_socket(fd);
>         if (IS_ERR(sock)) {
>                 r = PTR_ERR(sock);
>                 goto err_vq;
>         }
> 
>         /* start polling new socket */
>         oldsock = vhost_vq_get_backend(vq);
>         if (sock != oldsock) {
> ...
>                 vhost_vq_set_backend(vq, sock);
> ...
>                 if (index == VHOST_NET_VQ_RX)
>                         nvq->rx_ring = get_tap_ptr_ring(fd);
> 
> with
> static struct socket *get_socket(int fd)
> {
>         struct socket *sock;
> 
>         /* special case to disable backend */
>         if (fd == -1)
>                 return NULL;
>         sock = get_raw_socket(fd);
>         if (!IS_ERR(sock))
>                 return sock;
>         sock = get_tap_socket(fd);
>         if (!IS_ERR(sock))
>                 return sock;
>         return ERR_PTR(-ENOTSOCK);
> }
> and
> static struct ptr_ring *get_tap_ptr_ring(int fd)
> {
>         struct ptr_ring *ring;
>         struct file *file = fget(fd);
> 
>         if (!file)
>                 return NULL;
>         ring = tun_get_tx_ring(file);
>         if (!IS_ERR(ring))
>                 goto out;
>         ring = tap_get_ptr_ring(file);
>         if (!IS_ERR(ring))
>                 goto out;
>         ring = NULL;
> out:
>         fput(file);
>         return ring;
> }
> 
> Again, there is no promise that fd will resolve to the same thing for
> lookups in get_socket() and in get_tap_ptr_ring().  I'm not familiar
> enough with the guts of drivers/vhost to tell how easy it is to turn
> into attack, but it looks like trouble.  If nothing else, the pointer
> returned by tun_get_tx_ring() is not guaranteed to be pinned down by
> anything - the reference to sock will _usually_ suffice, but that
> doesn't help any if we get a different socket on that second fget().
> 
> One possible way to fix it would be the patch below; objections?
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

and this is stable material I guess.

> ---
>  drivers/vhost/net.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 28ef323882fb..0bd7d91de792 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1449,13 +1449,9 @@ static struct socket *get_raw_socket(int fd)
>  	return ERR_PTR(r);
>  }
>  
> -static struct ptr_ring *get_tap_ptr_ring(int fd)
> +static struct ptr_ring *get_tap_ptr_ring(struct file *file)
>  {
>  	struct ptr_ring *ring;
> -	struct file *file = fget(fd);
> -
> -	if (!file)
> -		return NULL;
>  	ring = tun_get_tx_ring(file);
>  	if (!IS_ERR(ring))
>  		goto out;
> @@ -1464,7 +1460,6 @@ static struct ptr_ring *get_tap_ptr_ring(int fd)
>  		goto out;
>  	ring = NULL;
>  out:
> -	fput(file);
>  	return ring;
>  }
>  
> @@ -1551,8 +1546,12 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
>  		r = vhost_net_enable_vq(n, vq);
>  		if (r)
>  			goto err_used;
> -		if (index == VHOST_NET_VQ_RX)
> -			nvq->rx_ring = get_tap_ptr_ring(fd);
> +		if (index == VHOST_NET_VQ_RX) {
> +			if (sock)
> +				nvq->rx_ring = get_tap_ptr_ring(sock->file);
> +			else
> +				nvq->rx_ring = NULL;
> +		}
>  
>  		oldubufs = nvq->ubufs;
>  		nvq->ubufs = ubufs;
> -- 
> 2.25.1

