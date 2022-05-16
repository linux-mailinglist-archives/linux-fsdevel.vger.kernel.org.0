Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B58527FFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 10:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbiEPIof (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 04:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241936AbiEPInr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 04:43:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4CBA101E9
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 01:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652690581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+CMhPjx229BSeU6biSdu7XswPsuMB6Gw5lWT8w7j+tg=;
        b=iGSRaEDl+iK/S91kTMB1VQbdogNB4pE8YPWitlyePMR8NOY35LAxw0zM9FlVqxpBApu53J
        ON1SDl9cwXh5hg5AjxOwSOYfsr+GvCBje+S/z4gbdvJI+ROo9R2ue25vkkKmWkwvuoAxr+
        J7ZrPlZ4BOFlFSAW6KcKT2/luU5jZsQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-jEPD_YrKOzaKM3pgasYa1w-1; Mon, 16 May 2022 04:43:00 -0400
X-MC-Unique: jEPD_YrKOzaKM3pgasYa1w-1
Received: by mail-lj1-f197.google.com with SMTP id x16-20020a2e9c90000000b002509c7b56ebso3382294lji.14
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 01:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+CMhPjx229BSeU6biSdu7XswPsuMB6Gw5lWT8w7j+tg=;
        b=SL/FaUMtrZM5HFQSZ0JswdlNME78DRGkYMuXvEDCWRhig8WlxbKkjD4LiWU9BTGjud
         E5NwMfZwWdtnbsNxYdm79reqTShKtcMfG303bhdKO8K8Xv3xrkgrLzJETb1qJLJvoLlG
         mtQxsyq6L9+g95jAVxa5eIugYx1xOWJnSY5CBEmQb3VqQOxbOWfDU0vD2ds+1boxBEgc
         p6Y1ayz39tCN+tjFV5H1AXL3MtrpbmlxMsBUQYlYq3PbbaD2i9krNpTaThskbIyAJrw9
         HoNybi+PFi491WSQ1pTlwdWi6W02wU7bNx9xUK351rUyDHaADO2Cq742w7Jcoe/xV7nk
         ZIcA==
X-Gm-Message-State: AOAM533QWhYXxFF+AJg2Uiz/1Rfn1wB96apAFwbiU7YBAXCTIZPE5TR8
        qnGveeBKnL6lxbcFuWMhZxPNaaXeLWxjc7ozRebww0eP61AO1MDUIjfwTHZya+B151+ulHDXsP3
        fUJuUXx8Kdlz1iNm+4NP4x2HG0nnaqMW8zQvoywjvYw==
X-Received: by 2002:a2e:bd85:0:b0:250:9bf2:8e27 with SMTP id o5-20020a2ebd85000000b002509bf28e27mr10710376ljq.177.1652690578916;
        Mon, 16 May 2022 01:42:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy727SO4WCcR6vHEMVqLSp9Kdp0sac8YfqAuENjFgiJ/AwaNBpK3T5bbmEwuw7yElkdydOyp18SBSNnzViAArY=
X-Received: by 2002:a2e:bd85:0:b0:250:9bf2:8e27 with SMTP id
 o5-20020a2ebd85000000b002509bf28e27mr10710364ljq.177.1652690578716; Mon, 16
 May 2022 01:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220511154503.28365-1-cgxu519@mykernel.net> <YnvbhmRUxPxWU2S3@casper.infradead.org>
 <YnwIDpkIBem+MeeC@gmail.com> <YnwuEt2Xm1iPjW7S@zeniv-ca.linux.org.uk>
 <YoBzzxlYHYXEP3qj@zeniv-ca.linux.org.uk> <02ba82ea-727f-1432-226e-ab2eb37d5c29@redhat.com>
 <20220516035338-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220516035338-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 16 May 2022 16:42:47 +0800
Message-ID: <CACGkMEuV64aB33dGr+JLNyE-KACSrkCMG03yxfzCmnBQURsujA@mail.gmail.com>
Subject: Re: [BUG] double fget() in vhost/net (was Re: [PATCH] vfs: move
 fdput() to right place in ksys_sync_file_range())
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 16, 2022 at 3:54 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, May 16, 2022 at 12:17:56PM +0800, Jason Wang wrote:
> >
> > =E5=9C=A8 2022/5/15 11:30, Al Viro =E5=86=99=E9=81=93:
> > > [tun/tap and vhost folks Cc'd]
> > >
> > > here's another piece of code assuming that repeated fget() will yield=
 the
> > > same opened file: in vhost_net_set_backend() we have
> > >
> > >          sock =3D get_socket(fd);
> > >          if (IS_ERR(sock)) {
> > >                  r =3D PTR_ERR(sock);
> > >                  goto err_vq;
> > >          }
> > >
> > >          /* start polling new socket */
> > >          oldsock =3D vhost_vq_get_backend(vq);
> > >          if (sock !=3D oldsock) {
> > > ...
> > >                  vhost_vq_set_backend(vq, sock);
> > > ...
> > >                  if (index =3D=3D VHOST_NET_VQ_RX)
> > >                          nvq->rx_ring =3D get_tap_ptr_ring(fd);
> > >
> > > with
> > > static struct socket *get_socket(int fd)
> > > {
> > >          struct socket *sock;
> > >
> > >          /* special case to disable backend */
> > >          if (fd =3D=3D -1)
> > >                  return NULL;
> > >          sock =3D get_raw_socket(fd);
> > >          if (!IS_ERR(sock))
> > >                  return sock;
> > >          sock =3D get_tap_socket(fd);
> > >          if (!IS_ERR(sock))
> > >                  return sock;
> > >          return ERR_PTR(-ENOTSOCK);
> > > }
> > > and
> > > static struct ptr_ring *get_tap_ptr_ring(int fd)
> > > {
> > >          struct ptr_ring *ring;
> > >          struct file *file =3D fget(fd);
> > >
> > >          if (!file)
> > >                  return NULL;
> > >          ring =3D tun_get_tx_ring(file);
> > >          if (!IS_ERR(ring))
> > >                  goto out;
> > >          ring =3D tap_get_ptr_ring(file);
> > >          if (!IS_ERR(ring))
> > >                  goto out;
> > >          ring =3D NULL;
> > > out:
> > >          fput(file);
> > >          return ring;
> > > }
> > >
> > > Again, there is no promise that fd will resolve to the same thing for
> > > lookups in get_socket() and in get_tap_ptr_ring().  I'm not familiar
> > > enough with the guts of drivers/vhost to tell how easy it is to turn
> > > into attack, but it looks like trouble.  If nothing else, the pointer
> > > returned by tun_get_tx_ring() is not guaranteed to be pinned down by
> > > anything - the reference to sock will _usually_ suffice, but that
> > > doesn't help any if we get a different socket on that second fget().
> > >
> > > One possible way to fix it would be the patch below; objections?
> > >
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > ---
> > > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > > index 792ab5f23647..86ea7695241e 100644
> > > --- a/drivers/vhost/net.c
> > > +++ b/drivers/vhost/net.c
> > > @@ -1450,13 +1450,9 @@ static struct socket *get_raw_socket(int fd)
> > >     return ERR_PTR(r);
> > >   }
> > > -static struct ptr_ring *get_tap_ptr_ring(int fd)
> > > +static struct ptr_ring *get_tap_ptr_ring(struct file *file)
> > >   {
> > >     struct ptr_ring *ring;
> > > -   struct file *file =3D fget(fd);
> > > -
> > > -   if (!file)
> > > -           return NULL;
> > >     ring =3D tun_get_tx_ring(file);
> > >     if (!IS_ERR(ring))
> > >             goto out;
> > > @@ -1465,7 +1461,6 @@ static struct ptr_ring *get_tap_ptr_ring(int fd=
)
> > >             goto out;
> > >     ring =3D NULL;
> > >   out:
> > > -   fput(file);
> > >     return ring;
> > >   }
> > > @@ -1553,7 +1548,7 @@ static long vhost_net_set_backend(struct vhost_=
net *n, unsigned index, int fd)
> > >             if (r)
> > >                     goto err_used;
> > >             if (index =3D=3D VHOST_NET_VQ_RX)
> > > -                   nvq->rx_ring =3D get_tap_ptr_ring(fd);
> > > +                   nvq->rx_ring =3D get_tap_ptr_ring(sock->file);
> >
> >
> > sock could be NULL if we want to stop the vhost-net.
>
> Can you cook up a correct patch then please?

Sent.

Thanks

>
> > Other looks fine.
> >
> > Thanks
> >
> >
> > >             oldubufs =3D nvq->ubufs;
> > >             nvq->ubufs =3D ubufs;
> > >
>

