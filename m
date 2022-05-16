Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDD2527C9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 06:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiEPESK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 00:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiEPESH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 00:18:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CE4FF5A4
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 May 2022 21:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652674685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XVQ894Yxk0MgvBHDMeCDi4oPwvoDIiCNjFnCj01+X38=;
        b=KVYIHWy7TUjlI/U+6q9GhaJq9bm1UMOqQO0etdU/S6oJh905RefSB2Itpfu1k6k8Ka7Uks
        Aav/hTEFwtw7bE2nMko5JMUTFWuhkpSBuNmH3F/9t9mf8pGgiLdBDNajJsfuTFauabN/9m
        m3AQyWIgm3YMETgNvbJ/xUYmnwKcjz8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-eJdSIZAtO2yqYfFNYG9zNw-1; Mon, 16 May 2022 00:18:03 -0400
X-MC-Unique: eJdSIZAtO2yqYfFNYG9zNw-1
Received: by mail-pg1-f198.google.com with SMTP id l72-20020a63914b000000b003c1ac4355f5so6845832pge.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 May 2022 21:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XVQ894Yxk0MgvBHDMeCDi4oPwvoDIiCNjFnCj01+X38=;
        b=WHcOqYJkT9hi/5NR4I5J9lCbN+uypfZfOn/49LZFTjqCjLP4KJhkS4e9l370dkO/tZ
         4EaGDhXZoVXhbMVFX5XnQbFK+B+qhRGTakFaWAx3JnrkPwnVn4nvMqXaMBOuVXnq+aNf
         m+jT/SjnTgU/k1fcOa/3QtKV8tpLZznOWxUYrdOsB8+ITgtC5NO+5xrhzso2mChrPAhl
         KMi5tjozq4xikmfoSXqogyHyXq9FDEY44lpHhGeqxRcTUiGT4W+MGZepzMN92G313iPd
         yauKx6WUTJWwUizHKQjEH/UYy2vRM0CFsMk0/HJfDsQFVUrCkJHKITFJcBBOaExFQOQx
         QT4A==
X-Gm-Message-State: AOAM531H4dPIRBogHG86wd4Y5q7ajVs/nsyikXCg6OdTDjCz7hu438Yn
        0rrbNvdlMd1c3asbfMoLWOlozRfC3HQZxpqSRFfmU+1IVJnmNvYb2Do0hzimcByNPE/T+ivRHKo
        8CD2zfc5aPXcw44FwURvPXrrWyA==
X-Received: by 2002:a63:5824:0:b0:3db:65eb:8e2f with SMTP id m36-20020a635824000000b003db65eb8e2fmr13825307pgb.349.1652674681834;
        Sun, 15 May 2022 21:18:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuLI2WuZ1IqPULmTOs7UGgJ0839TpIlx0UUJ/EtbBB5+55zZuyiOZu3pjtQuZ+4uFq848zkw==
X-Received: by 2002:a63:5824:0:b0:3db:65eb:8e2f with SMTP id m36-20020a635824000000b003db65eb8e2fmr13825296pgb.349.1652674681538;
        Sun, 15 May 2022 21:18:01 -0700 (PDT)
Received: from [10.72.13.125] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i184-20020a62c1c1000000b0050dc7628168sm5776319pfg.66.2022.05.15.21.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 21:18:00 -0700 (PDT)
Message-ID: <02ba82ea-727f-1432-226e-ab2eb37d5c29@redhat.com>
Date:   Mon, 16 May 2022 12:17:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [BUG] double fget() in vhost/net (was Re: [PATCH] vfs: move
 fdput() to right place in ksys_sync_file_range())
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20220511154503.28365-1-cgxu519@mykernel.net>
 <YnvbhmRUxPxWU2S3@casper.infradead.org> <YnwIDpkIBem+MeeC@gmail.com>
 <YnwuEt2Xm1iPjW7S@zeniv-ca.linux.org.uk>
 <YoBzzxlYHYXEP3qj@zeniv-ca.linux.org.uk>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <YoBzzxlYHYXEP3qj@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2022/5/15 11:30, Al Viro 写道:
> [tun/tap and vhost folks Cc'd]
>
> here's another piece of code assuming that repeated fget() will yield the
> same opened file: in vhost_net_set_backend() we have
>
>          sock = get_socket(fd);
>          if (IS_ERR(sock)) {
>                  r = PTR_ERR(sock);
>                  goto err_vq;
>          }
>
>          /* start polling new socket */
>          oldsock = vhost_vq_get_backend(vq);
>          if (sock != oldsock) {
> ...
>                  vhost_vq_set_backend(vq, sock);
> ...
>                  if (index == VHOST_NET_VQ_RX)
>                          nvq->rx_ring = get_tap_ptr_ring(fd);
>
> with
> static struct socket *get_socket(int fd)
> {
>          struct socket *sock;
>
>          /* special case to disable backend */
>          if (fd == -1)
>                  return NULL;
>          sock = get_raw_socket(fd);
>          if (!IS_ERR(sock))
>                  return sock;
>          sock = get_tap_socket(fd);
>          if (!IS_ERR(sock))
>                  return sock;
>          return ERR_PTR(-ENOTSOCK);
> }
> and
> static struct ptr_ring *get_tap_ptr_ring(int fd)
> {
>          struct ptr_ring *ring;
>          struct file *file = fget(fd);
>
>          if (!file)
>                  return NULL;
>          ring = tun_get_tx_ring(file);
>          if (!IS_ERR(ring))
>                  goto out;
>          ring = tap_get_ptr_ring(file);
>          if (!IS_ERR(ring))
>                  goto out;
>          ring = NULL;
> out:
>          fput(file);
>          return ring;
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
> ---
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 792ab5f23647..86ea7695241e 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1450,13 +1450,9 @@ static struct socket *get_raw_socket(int fd)
>   	return ERR_PTR(r);
>   }
>   
> -static struct ptr_ring *get_tap_ptr_ring(int fd)
> +static struct ptr_ring *get_tap_ptr_ring(struct file *file)
>   {
>   	struct ptr_ring *ring;
> -	struct file *file = fget(fd);
> -
> -	if (!file)
> -		return NULL;
>   	ring = tun_get_tx_ring(file);
>   	if (!IS_ERR(ring))
>   		goto out;
> @@ -1465,7 +1461,6 @@ static struct ptr_ring *get_tap_ptr_ring(int fd)
>   		goto out;
>   	ring = NULL;
>   out:
> -	fput(file);
>   	return ring;
>   }
>   
> @@ -1553,7 +1548,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
>   		if (r)
>   			goto err_used;
>   		if (index == VHOST_NET_VQ_RX)
> -			nvq->rx_ring = get_tap_ptr_ring(fd);
> +			nvq->rx_ring = get_tap_ptr_ring(sock->file);


sock could be NULL if we want to stop the vhost-net.

Other looks fine.

Thanks


>   
>   		oldubufs = nvq->ubufs;
>   		nvq->ubufs = ubufs;
>

