Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989486822BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 04:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjAaDX4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 22:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjAaDXz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 22:23:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4423612F03
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 19:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675135390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ltkBGnwECMJmhbD7vrl7YLMiwdLoKe7LIr5e2nHG3PQ=;
        b=bNackPNdox5dPIIdmUa0xSaQ56Hs5k2u4WpXgd14n+nzidcPmkoO/fkh9FgKSIiAfrzn+K
        YGGFa9MmhiweNPFhKYoVYnOMrxfBUtp6On1E4vGf11XX42LiPELSgyXbwyjFqCrCO8oJOK
        D/m6LyUn9k9LtZYzzcagFineDayAhT8=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-307-wsZtpAxdOymRXiM4ES6TUw-1; Mon, 30 Jan 2023 22:23:08 -0500
X-MC-Unique: wsZtpAxdOymRXiM4ES6TUw-1
Received: by mail-oi1-f198.google.com with SMTP id du3-20020a056808628300b00364c7610c6aso5842147oib.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 19:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ltkBGnwECMJmhbD7vrl7YLMiwdLoKe7LIr5e2nHG3PQ=;
        b=2AmjHIMfD4TREG9dSBQhO48koOiMTMqcWSar7jsYWWoqk4HMxfZxCumPFKx3Pe9r6C
         2HmB/AkJXcbBzumAuO2gnai3nkVpRKEPjuh7t9WmAbCZ+jjl6ruL3h+DEtPwtcZKiv4K
         4qDfQfy862L/KuasxC26JYdI0l4MI1g+MGMH7D7hsYhM5eFQf3t5Bzj2yVb3wq/kn/lo
         Btnz4sToaKZGF3wJBFJ0fatoLRL6v7Q5R6+Pp22UFjNai3ZTi5o7QlxnP2oHpNG0QY6V
         99dZJ83/2VEXk4tUeGtzdxLJA9GECn5N5EGg/y71dk6hFWPCV81B8iiQQ5SdHNHG/8Wd
         IPhA==
X-Gm-Message-State: AO0yUKWGFtzLklS2931Lm1ymipye3FyoYHpGJ88j1+XG6fVIumq8IkBG
        /ZAdjUC64XD85ChvVVHExOa7bHrnossc42tW1PDw2ZIVsCfYcLp1sJr//BbvOQ7I8vEjvDzwWL2
        /rjM1dNYSbBNg/c8gdOteO0JUYxgonfRpj4s3aCvsgA==
X-Received: by 2002:a05:6870:959e:b0:163:9cea:eea7 with SMTP id k30-20020a056870959e00b001639ceaeea7mr567813oao.35.1675135387494;
        Mon, 30 Jan 2023 19:23:07 -0800 (PST)
X-Google-Smtp-Source: AK7set9Hu2HFEDPiDGXCaNnCjpBr1M/3mkKYHDHH6RsQ5EtesD62XsOTK7GEj1aXmBl8gjJeRQSyQJytKuQEUWxkdJU=
X-Received: by 2002:a05:6870:959e:b0:163:9cea:eea7 with SMTP id
 k30-20020a056870959e00b001639ceaeea7mr567795oao.35.1675135387309; Mon, 30 Jan
 2023 19:23:07 -0800 (PST)
MIME-Version: 1.0
References: <20230130092157.1759539-1-hch@lst.de> <20230130092157.1759539-10-hch@lst.de>
 <20230130101747-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230130101747-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 31 Jan 2023 11:22:56 +0800
Message-ID: <CACGkMEuoqJP4S+jz8Tt5K72i-w5qBhuheTiCWaRLxUBfYS_jQg@mail.gmail.com>
Subject: Re: [PATCH 09/23] virtio_blk: use bvec_set_virt to initialize special_vec
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ilya Dryomov <idryomov@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Xiubo Li <xiubli@redhat.com>, Steve French <sfrench@samba.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        devel@lists.orangefs.org, io-uring@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 30, 2023 at 11:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jan 30, 2023 at 10:21:43AM +0100, Christoph Hellwig wrote:
> > Use the bvec_set_virt helper to initialize the special_vec.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
>
> > ---
> >  drivers/block/virtio_blk.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 6a77fa91742880..dc6e9b989910b0 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -170,9 +170,7 @@ static int virtblk_setup_discard_write_zeroes_erase(struct request *req, bool un
> >
> >       WARN_ON_ONCE(n != segments);
> >
> > -     req->special_vec.bv_page = virt_to_page(range);
> > -     req->special_vec.bv_offset = offset_in_page(range);
> > -     req->special_vec.bv_len = sizeof(*range) * segments;
> > +     bvec_set_virt(&req->special_vec, range, sizeof(*range) * segments);
> >       req->rq_flags |= RQF_SPECIAL_PAYLOAD;
> >
> >       return 0;
> > --
> > 2.39.0
>

