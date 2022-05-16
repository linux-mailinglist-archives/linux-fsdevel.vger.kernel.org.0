Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B215B527EE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 09:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241326AbiEPHyj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 03:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241341AbiEPHyh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 03:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B6F929807
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 00:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652687675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zr4Gb/T2hEa56In8vsRjebKo7ccFueJ8igE4qO+Ud1Y=;
        b=K6XdD6ULhnUgWgSzQrYAH5CxO7GYq36+XW+DUpPiPCkWTMBBbi6jSmoRSgT1F3dB+dFWYq
        G7nNitzwtAMk/xfo7ou4EpqbPQJ3O6ly6Sf5e5GBJTH2gNPCqjq+pAU8/3bzMeMI7JVRrx
        z6mkArAmxdiERfNWyrYNf1+sP7NolV0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-QMYJaZzqN1yeHR9lhKjwRA-1; Mon, 16 May 2022 03:54:33 -0400
X-MC-Unique: QMYJaZzqN1yeHR9lhKjwRA-1
Received: by mail-wr1-f72.google.com with SMTP id l7-20020adfa387000000b0020acc61dbaeso3689910wrb.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 00:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Zr4Gb/T2hEa56In8vsRjebKo7ccFueJ8igE4qO+Ud1Y=;
        b=69qQju4nSoeWcGxbAqHU9Cba5e03vbWJgi9bXBZetMrokAfrxQLF65x+MKyMv7prUN
         W0O3MClrKeKEKrbk1rzPyM7Pzbf4lacNIn/ZHt9M+qht8hmGRmwChMsa+Org526qkvSz
         aZLBPDgwGs3Xi2a11wIxxAJPgJp+1OAD7Mj4qDApsVdMx4FVmetWrdDjY64AFVKD98AU
         VY7RoQMQf57NBSR3UxlP8YcaJlMpXT66tUHwMHCnw0uqSO404TBmJCz13sJyb8H3xX0Q
         CpCcdaB1X7LUdu9H1TkXhBTj2iZQFoswGNaaCi94tTLxwoNYMzaRB9jIdaQ5M80mLX6r
         2blQ==
X-Gm-Message-State: AOAM532xgoHogyzsYH6+KUCsBBWM0vfqUcRk7blRH7w38zFX1QXMK0RN
        PHMFV/phf2N/Lz8ULtQoGk2h11VZr+2CvtF2uz3wFkDtWNaAh+SBY/S+MVqYlLOzD09qm1EAJxs
        AUPKJ7Dv9zKYeS1CBXoZFcWe+7Q==
X-Received: by 2002:a1c:4e0b:0:b0:393:fd8f:e340 with SMTP id g11-20020a1c4e0b000000b00393fd8fe340mr25377890wmh.136.1652687672084;
        Mon, 16 May 2022 00:54:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdk+O1sRtkJM9M1i8nPm7z9k8sA3vCSvHv8Ltk9ilWnuX2wjQe5x1H2lzikdAWBek0MIogZw==
X-Received: by 2002:a1c:4e0b:0:b0:393:fd8f:e340 with SMTP id g11-20020a1c4e0b000000b00393fd8fe340mr25377871wmh.136.1652687671787;
        Mon, 16 May 2022 00:54:31 -0700 (PDT)
Received: from redhat.com ([2.55.141.66])
        by smtp.gmail.com with ESMTPSA id c12-20020adfc04c000000b0020c5253d8d8sm10679086wrf.36.2022.05.16.00.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 00:54:31 -0700 (PDT)
Date:   Mon, 16 May 2022 03:54:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [BUG] double fget() in vhost/net (was Re: [PATCH] vfs: move
 fdput() to right place in ksys_sync_file_range())
Message-ID: <20220516035338-mutt-send-email-mst@kernel.org>
References: <20220511154503.28365-1-cgxu519@mykernel.net>
 <YnvbhmRUxPxWU2S3@casper.infradead.org>
 <YnwIDpkIBem+MeeC@gmail.com>
 <YnwuEt2Xm1iPjW7S@zeniv-ca.linux.org.uk>
 <YoBzzxlYHYXEP3qj@zeniv-ca.linux.org.uk>
 <02ba82ea-727f-1432-226e-ab2eb37d5c29@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02ba82ea-727f-1432-226e-ab2eb37d5c29@redhat.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 16, 2022 at 12:17:56PM +0800, Jason Wang wrote:
> 
> 在 2022/5/15 11:30, Al Viro 写道:
> > [tun/tap and vhost folks Cc'd]
> > 
> > here's another piece of code assuming that repeated fget() will yield the
> > same opened file: in vhost_net_set_backend() we have
> > 
> >          sock = get_socket(fd);
> >          if (IS_ERR(sock)) {
> >                  r = PTR_ERR(sock);
> >                  goto err_vq;
> >          }
> > 
> >          /* start polling new socket */
> >          oldsock = vhost_vq_get_backend(vq);
> >          if (sock != oldsock) {
> > ...
> >                  vhost_vq_set_backend(vq, sock);
> > ...
> >                  if (index == VHOST_NET_VQ_RX)
> >                          nvq->rx_ring = get_tap_ptr_ring(fd);
> > 
> > with
> > static struct socket *get_socket(int fd)
> > {
> >          struct socket *sock;
> > 
> >          /* special case to disable backend */
> >          if (fd == -1)
> >                  return NULL;
> >          sock = get_raw_socket(fd);
> >          if (!IS_ERR(sock))
> >                  return sock;
> >          sock = get_tap_socket(fd);
> >          if (!IS_ERR(sock))
> >                  return sock;
> >          return ERR_PTR(-ENOTSOCK);
> > }
> > and
> > static struct ptr_ring *get_tap_ptr_ring(int fd)
> > {
> >          struct ptr_ring *ring;
> >          struct file *file = fget(fd);
> > 
> >          if (!file)
> >                  return NULL;
> >          ring = tun_get_tx_ring(file);
> >          if (!IS_ERR(ring))
> >                  goto out;
> >          ring = tap_get_ptr_ring(file);
> >          if (!IS_ERR(ring))
> >                  goto out;
> >          ring = NULL;
> > out:
> >          fput(file);
> >          return ring;
> > }
> > 
> > Again, there is no promise that fd will resolve to the same thing for
> > lookups in get_socket() and in get_tap_ptr_ring().  I'm not familiar
> > enough with the guts of drivers/vhost to tell how easy it is to turn
> > into attack, but it looks like trouble.  If nothing else, the pointer
> > returned by tun_get_tx_ring() is not guaranteed to be pinned down by
> > anything - the reference to sock will _usually_ suffice, but that
> > doesn't help any if we get a different socket on that second fget().
> > 
> > One possible way to fix it would be the patch below; objections?
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index 792ab5f23647..86ea7695241e 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -1450,13 +1450,9 @@ static struct socket *get_raw_socket(int fd)
> >   	return ERR_PTR(r);
> >   }
> > -static struct ptr_ring *get_tap_ptr_ring(int fd)
> > +static struct ptr_ring *get_tap_ptr_ring(struct file *file)
> >   {
> >   	struct ptr_ring *ring;
> > -	struct file *file = fget(fd);
> > -
> > -	if (!file)
> > -		return NULL;
> >   	ring = tun_get_tx_ring(file);
> >   	if (!IS_ERR(ring))
> >   		goto out;
> > @@ -1465,7 +1461,6 @@ static struct ptr_ring *get_tap_ptr_ring(int fd)
> >   		goto out;
> >   	ring = NULL;
> >   out:
> > -	fput(file);
> >   	return ring;
> >   }
> > @@ -1553,7 +1548,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
> >   		if (r)
> >   			goto err_used;
> >   		if (index == VHOST_NET_VQ_RX)
> > -			nvq->rx_ring = get_tap_ptr_ring(fd);
> > +			nvq->rx_ring = get_tap_ptr_ring(sock->file);
> 
> 
> sock could be NULL if we want to stop the vhost-net.

Can you cook up a correct patch then please?

> Other looks fine.
> 
> Thanks
> 
> 
> >   		oldubufs = nvq->ubufs;
> >   		nvq->ubufs = ubufs;
> > 

