Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A303D5278B7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 May 2022 18:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbiEOQO7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 May 2022 12:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiEOQO6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 May 2022 12:14:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60999DEF1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 May 2022 09:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652631295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZHCbrv8X4Zn3SHqMsUHWOUnyTCb3eO5VuCPZtPP2NLk=;
        b=EPouBrD/dN+3gL17R4BBgiDZwwVBDqOLZH1dfKkUe+nwA+RWcnaxL/hX4EZ9JBc+8C0Zex
        wSqZ0MsIOoNd8WBByu6AZlCarQRB4Sd0oZcK+uMhnnSruBiAYwrumFE7izdMNHxIGovjDV
        fsaEpnznl8ePeQTfRy9ydPEBOZbmujc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-07aIcmVDOPuR0gkuYMIjog-1; Sun, 15 May 2022 12:14:54 -0400
X-MC-Unique: 07aIcmVDOPuR0gkuYMIjog-1
Received: by mail-wm1-f72.google.com with SMTP id v124-20020a1cac82000000b003948b870a8dso9020707wme.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 May 2022 09:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZHCbrv8X4Zn3SHqMsUHWOUnyTCb3eO5VuCPZtPP2NLk=;
        b=5mmO9OpOq9Ggqvh/GU5Wkv5wvYvaams2SVeEy9g6pLDtEaSElnXGuAkhx6viFMtNt+
         SRKXjRcunR5jn3TFES0/VLEvTYNMSR0ZLmOdGh974wQ/CKqF42oQRVbj65Pds4wXOXLs
         YXjOwPnZl+BccFAzEBPOF1w+9cX4Le0SR+Q12MLPKp1uBR5Ees6tACfNoWtodghDjIqW
         5BMwAd3aulG/cDZWU0htdt8+blqwVKbYLeE1+NXMUtghZ1GcobK5O9gd+gD2FPVkIIGm
         WKlDC/2L2Vy14lobXzGHBab8sdmBUG3u0hxAf44Djn/1rr7hOu0Y2wu7Hv8qcZx/9RnS
         ZpOg==
X-Gm-Message-State: AOAM531mVJFRlhJDw4d/1KRyhhNuB8N0GCMTEfYN8ITvR+xv/3QHzuBG
        NcE0BUA9RtCUPjhxo1VRPBHE9zvT/SIzrqaPLaN+GNqVsVioWlVGWS821UxMNvbbtzHPrlnRM+x
        ry7J0aUSuXFm+Ce28P15eC1A3RA==
X-Received: by 2002:a5d:6da4:0:b0:20c:6d76:cc54 with SMTP id u4-20020a5d6da4000000b0020c6d76cc54mr10791006wrs.317.1652631293202;
        Sun, 15 May 2022 09:14:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxzWFlE2O3317L1pCqcWYjMbUPTjGV2tm24fDmcpBbvgOWh4tUvPS8YH+q/jOBhpdMg5a+xg==
X-Received: by 2002:a5d:6da4:0:b0:20c:6d76:cc54 with SMTP id u4-20020a5d6da4000000b0020c6d76cc54mr10790994wrs.317.1652631292923;
        Sun, 15 May 2022 09:14:52 -0700 (PDT)
Received: from redhat.com ([2.55.141.66])
        by smtp.gmail.com with ESMTPSA id n36-20020a05600c502400b003942a244ebfsm7974671wmr.4.2022.05.15.09.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 09:14:52 -0700 (PDT)
Date:   Sun, 15 May 2022 12:14:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [BUG] double fget() in vhost/net (was Re: [PATCH] vfs: move
 fdput() to right place in ksys_sync_file_range())
Message-ID: <20220515121035-mutt-send-email-mst@kernel.org>
References: <20220511154503.28365-1-cgxu519@mykernel.net>
 <YnvbhmRUxPxWU2S3@casper.infradead.org>
 <YnwIDpkIBem+MeeC@gmail.com>
 <YnwuEt2Xm1iPjW7S@zeniv-ca.linux.org.uk>
 <YoBzzxlYHYXEP3qj@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoBzzxlYHYXEP3qj@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 15, 2022 at 03:30:23AM +0000, Al Viro wrote:
> [tun/tap and vhost folks Cc'd]
> 
> here's another piece of code assuming that repeated fget() will yield the
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

Suspect you are right, didn't test yet. Jason?

> ---
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 792ab5f23647..86ea7695241e 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1450,13 +1450,9 @@ static struct socket *get_raw_socket(int fd)
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
> @@ -1465,7 +1461,6 @@ static struct ptr_ring *get_tap_ptr_ring(int fd)
>  		goto out;
>  	ring = NULL;
>  out:
> -	fput(file);
>  	return ring;
>  }
>  
> @@ -1553,7 +1548,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
>  		if (r)
>  			goto err_used;
>  		if (index == VHOST_NET_VQ_RX)
> -			nvq->rx_ring = get_tap_ptr_ring(fd);
> +			nvq->rx_ring = get_tap_ptr_ring(sock->file);
>  
>  		oldubufs = nvq->ubufs;
>  		nvq->ubufs = ubufs;

