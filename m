Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C929F715D3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 13:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjE3LaR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 07:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjE3LaL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 07:30:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D2FD9
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 04:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685446166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NpOBAS8Bi4kBG+sylQuaVNwQB72hawQBUTtbh7SjPqA=;
        b=B/sTW0SE7F6H36fs6qw9rv1x+lZq9zkDir32hC1uRG2yBv/N0OFHnQSbmprDZ8VPwMnmWc
        ThWsajj81IH3FMBovJIZk3e8G1BWFoqXGd4lEVpEtBIC8e/Xw+miirHc8cQwXz0lwpfc5Z
        dlUB3EWDh58aPD0oQBZpc638Rjtx+FI=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-gKI41GxzOBGV0OYRxV1diA-1; Tue, 30 May 2023 07:29:25 -0400
X-MC-Unique: gKI41GxzOBGV0OYRxV1diA-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4572f83f5e3so826598e0c.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 04:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685446164; x=1688038164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpOBAS8Bi4kBG+sylQuaVNwQB72hawQBUTtbh7SjPqA=;
        b=B6OLi2RxFKxlD3AIeSgEkl2NZE7dxGk4VEN9QQ6qdpmGdIThU3+DlMjAedk0bON8yt
         kMkHUOctlnVRfhfqemG2vl8w1BoIs+F2z+WR+zQV6bMIDr3ZJedl2XMXwzIN/pJw2H1P
         VM/tegX62/YK1E7RDMiIr2Qr1gJShTLnEjpCYcvKPfeebtdMI5tD7OrMNS/0iZZqEAmC
         eyBtJn3IhGxM2X7hq0aklpzwX1r2QYYh9iVmnuiNvKprye5beT2/wEZB+UkCtT1IvQBp
         LjmgwuyWwfOXl2h0X+QtRIklJN09POnf1CP7ajgApxEIYYk4zKHZQFzTZCI8Gk6Yp3E1
         MCBA==
X-Gm-Message-State: AC+VfDzGq3ciYhHqdALJAVMAoIVtvMXyqAod9R0I0zS+XFCeGusNrcAk
        AwOqRL6QUoSwN0lZxXQsVuAnMDzBiBS3vpDBriG8XbXLQG2FiYvST382tKj8WgciJvlv+6sgv//
        x71OxksnyeCecCb9LETpb89iTX7WF5nG+VfW2Whbrww==
X-Received: by 2002:a1f:4b45:0:b0:44f:cc32:1585 with SMTP id y66-20020a1f4b45000000b0044fcc321585mr396092vka.16.1685446164688;
        Tue, 30 May 2023 04:29:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ60g8d6uIJQJ6uxHej74jlrBVrcHx9EcH35VqVEe7Tezem4ctVekj51qYF9EFj7YKA4koNTixi+3DAOC1La86o=
X-Received: by 2002:a1f:4b45:0:b0:44f:cc32:1585 with SMTP id
 y66-20020a1f4b45000000b0044fcc321585mr396070vka.16.1685446164430; Tue, 30 May
 2023 04:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230522104536epcas5p23dd8108dd267ec588e5c36e8f9eb9fe8@epcas5p2.samsung.com>
 <20230522104146.2856-1-nj.shetty@samsung.com> <20230522104146.2856-3-nj.shetty@samsung.com>
In-Reply-To: <20230522104146.2856-3-nj.shetty@samsung.com>
From:   Maurizio Lombardi <mlombard@redhat.com>
Date:   Tue, 30 May 2023 13:29:12 +0200
Message-ID: <CAFL455nMtKbDt1HeN6D2WPB2JjOYq2z1=RagmmuhmQ33eL2Bfw@mail.gmail.com>
Subject: Re: [PATCH v11 2/9] block: Add copy offload support infrastructure
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, bvanassche@acm.org,
        hare@suse.de, ming.lei@redhat.com, dlemoal@kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
        gost.dev@samsung.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

po 22. 5. 2023 v 13:17 odes=C3=ADlatel Nitesh Shetty <nj.shetty@samsung.com=
> napsal:
>
> +static int __blkdev_copy_offload(struct block_device *bdev_in, loff_t po=
s_in,
> +               struct block_device *bdev_out, loff_t pos_out, size_t len=
,
> +               cio_iodone_t endio, void *private, gfp_t gfp_mask)
> +{
> +       struct cio *cio;
> +       struct copy_ctx *ctx;
> +       struct bio *read_bio, *write_bio;
> +       struct page *token;
> +       sector_t copy_len;
> +       sector_t rem, max_copy_len;
> +
> +       cio =3D kzalloc(sizeof(struct cio), GFP_KERNEL);
> +       if (!cio)
> +               return -ENOMEM;
> +       atomic_set(&cio->refcount, 0);
> +       cio->waiter =3D current;
> +       cio->endio =3D endio;
> +       cio->private =3D private;
> +
> +       max_copy_len =3D min(bdev_max_copy_sectors(bdev_in),
> +                       bdev_max_copy_sectors(bdev_out)) << SECTOR_SHIFT;
> +
> +       cio->pos_in =3D pos_in;
> +       cio->pos_out =3D pos_out;
> +       /* If there is a error, comp_len will be set to least successfull=
y
> +        * completed copied length
> +        */
> +       cio->comp_len =3D len;
> +       for (rem =3D len; rem > 0; rem -=3D copy_len) {
> +               copy_len =3D min(rem, max_copy_len);
> +
> +               token =3D alloc_page(gfp_mask);
> +               if (unlikely(!token))
> +                       goto err_token;

[...]

> +err_token:
> +       cio->comp_len =3D min_t(sector_t, cio->comp_len, (len - rem));
> +       if (!atomic_read(&cio->refcount))
> +               return -ENOMEM;
> +       /* Wait for submitted IOs to complete */
> +       return blkdev_copy_wait_completion(cio);
> +}

Suppose the first call to "token =3D alloc_page()" fails (and
cio->refcount =3D=3D 0), isn't "cio" going to be leaked here?

Maurizio

