Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AA4750D2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 17:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjGLPyZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 11:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjGLPyV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:54:21 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0660F1BD4
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 08:54:19 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b6ff1a637bso115686471fa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 08:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1689177257; x=1691769257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEr1zRynxHNwickntlrvpl2Y4hu0Auhj5iPbkdvumTw=;
        b=iNQRvirxtZvgsZL7mpUkZfJBjCf72RQYRA2zBZVjI7QyzvVv9ibdssDnajmpBS7wVU
         5020AKwXsSHRoVgCZlnBhWyIbko/26fM7WuDSlfW8NhEgWQ7wQM+UnRHE8F/EXiS717A
         unmaoTiMBDb/BpjgPTifm0vPjWw/5NVIvT5MVG4smAtBPaoBSIVd3r20RZkA1Ct/h5E1
         Ny2cbSGaIZ5Swqx7oHIPxGuKDuqNY4HbE+viXaAQjgZpXn/iH3OXkFOTL6Hv5DHj/WkF
         9UkkFl1jusUOijErP6uDQrKau2f/GRpR+pWfemKdd9Y6Z66fZ2Ub5cYi9JfCatSI5DHe
         c4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689177257; x=1691769257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEr1zRynxHNwickntlrvpl2Y4hu0Auhj5iPbkdvumTw=;
        b=S3l1tvMXaZgn7zr/14oKARrdAanbnfc2LqIM3cB7uxE2b7NSA++UlIl6Z247cGJ8hN
         K7gzgTFPgvvvZXuAIIllIQ79RL0zB9e3oTSg8MGfhqE/ilhoVJeKNw1Tz8hmOAyiRBq6
         O9g5ftDiJbxVHvfpklJTf1GfbZCabP460VFyyMOAbDxdDewTwfOwk/1qvhAYaNLnVpvD
         r2jz/Qv5gpj6urwGGXFZP7jfQLGMGI/mchSNcq1kmSABpRaNMEHXSC9wUGNaOHyUJSzk
         3J+077SGfSX+Rsjv5H4Gk0JFHdg8mfwVpe05SfyxiQYIn7A7EmaW/NEa9HCW/4ZhBTwf
         Pmqg==
X-Gm-Message-State: ABy/qLYJAlXqNxzW6TfmfcAa9cAIYob8aKxiYYy5xkr5QUUv5bwAC9Bt
        jMqCfHAY7pJGKtsyY/bYZ3rEwruZydwLkG2OKePEyQ==
X-Google-Smtp-Source: APBJJlEsabczpTtCxBdlHiiJme3DJdBqV2h5d8BTykUTfqYXA3ZjFkk3+fAfSEUsyHeSke7YqL1/Ega53Pql3tWo3io=
X-Received: by 2002:a2e:8909:0:b0:2b6:9f5d:e758 with SMTP id
 d9-20020a2e8909000000b002b69f5de758mr18974978lji.9.1689177257278; Wed, 12 Jul
 2023 08:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230629165206.383-1-jack@suse.cz> <20230704122224.16257-7-jack@suse.cz>
In-Reply-To: <20230704122224.16257-7-jack@suse.cz>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Wed, 12 Jul 2023 17:54:06 +0200
Message-ID: <CAJpMwyg-+rKk_2-1bhN5M9pdYiCNusbfe2B+PA1cNOp1uwNJGg@mail.gmail.com>
Subject: Re: [PATCH 07/32] rnbd-srv: Convert to use blkdev_get_handle_by_path()
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Jack Wang <jinpu.wang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 4, 2023 at 2:22=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Convert rnbd-srv to use blkdev_get_handle_by_path() and pass the handle
> around.
>
> CC: Jack Wang <jinpu.wang@ionos.com>
> CC: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
Acked-by: "Md. Haris Iqbal" <haris.iqbal@ionos.com>

Thanks


> ---
>  drivers/block/rnbd/rnbd-srv.c | 28 +++++++++++++++-------------
>  drivers/block/rnbd/rnbd-srv.h |  2 +-
>  2 files changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.=
c
> index c186df0ec641..606db77c1238 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -145,7 +145,7 @@ static int process_rdma(struct rnbd_srv_session *srv_=
sess,
>         priv->sess_dev =3D sess_dev;
>         priv->id =3D id;
>
> -       bio =3D bio_alloc(sess_dev->bdev, 1,
> +       bio =3D bio_alloc(sess_dev->bdev_handle->bdev, 1,
>                         rnbd_to_bio_flags(le32_to_cpu(msg->rw)), GFP_KERN=
EL);
>         if (bio_add_page(bio, virt_to_page(data), datalen,
>                         offset_in_page(data)) !=3D datalen) {
> @@ -219,7 +219,7 @@ void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *=
sess_dev, bool keep_id)
>         rnbd_put_sess_dev(sess_dev);
>         wait_for_completion(&dc); /* wait for inflights to drop to zero *=
/
>
> -       blkdev_put(sess_dev->bdev, NULL);
> +       blkdev_handle_put(sess_dev->bdev_handle);
>         mutex_lock(&sess_dev->dev->lock);
>         list_del(&sess_dev->dev_list);
>         if (!sess_dev->readonly)
> @@ -534,7 +534,7 @@ rnbd_srv_get_or_create_srv_dev(struct block_device *b=
dev,
>  static void rnbd_srv_fill_msg_open_rsp(struct rnbd_msg_open_rsp *rsp,
>                                         struct rnbd_srv_sess_dev *sess_de=
v)
>  {
> -       struct block_device *bdev =3D sess_dev->bdev;
> +       struct block_device *bdev =3D sess_dev->bdev_handle->bdev;
>
>         rsp->hdr.type =3D cpu_to_le16(RNBD_MSG_OPEN_RSP);
>         rsp->device_id =3D cpu_to_le32(sess_dev->device_id);
> @@ -559,7 +559,7 @@ static void rnbd_srv_fill_msg_open_rsp(struct rnbd_ms=
g_open_rsp *rsp,
>  static struct rnbd_srv_sess_dev *
>  rnbd_srv_create_set_sess_dev(struct rnbd_srv_session *srv_sess,
>                               const struct rnbd_msg_open *open_msg,
> -                             struct block_device *bdev, bool readonly,
> +                             struct bdev_handle *handle, bool readonly,
>                               struct rnbd_srv_dev *srv_dev)
>  {
>         struct rnbd_srv_sess_dev *sdev =3D rnbd_sess_dev_alloc(srv_sess);
> @@ -571,7 +571,7 @@ rnbd_srv_create_set_sess_dev(struct rnbd_srv_session =
*srv_sess,
>
>         strscpy(sdev->pathname, open_msg->dev_name, sizeof(sdev->pathname=
));
>
> -       sdev->bdev              =3D bdev;
> +       sdev->bdev_handle       =3D handle;
>         sdev->sess              =3D srv_sess;
>         sdev->dev               =3D srv_dev;
>         sdev->readonly          =3D readonly;
> @@ -676,7 +676,7 @@ static int process_msg_open(struct rnbd_srv_session *=
srv_sess,
>         struct rnbd_srv_dev *srv_dev;
>         struct rnbd_srv_sess_dev *srv_sess_dev;
>         const struct rnbd_msg_open *open_msg =3D msg;
> -       struct block_device *bdev;
> +       struct bdev_handle *bdev_handle;
>         blk_mode_t open_flags =3D BLK_OPEN_READ;
>         char *full_path;
>         struct rnbd_msg_open_rsp *rsp =3D data;
> @@ -714,15 +714,16 @@ static int process_msg_open(struct rnbd_srv_session=
 *srv_sess,
>                 goto reject;
>         }
>
> -       bdev =3D blkdev_get_by_path(full_path, open_flags, NULL, NULL);
> -       if (IS_ERR(bdev)) {
> -               ret =3D PTR_ERR(bdev);
> +       bdev_handle =3D blkdev_get_handle_by_path(full_path, open_flags, =
NULL,
> +                                               NULL);
> +       if (IS_ERR(bdev_handle)) {
> +               ret =3D PTR_ERR(bdev_handle);
>                 pr_err("Opening device '%s' on session %s failed, failed =
to open the block device, err: %d\n",
>                        full_path, srv_sess->sessname, ret);
>                 goto free_path;
>         }
>
> -       srv_dev =3D rnbd_srv_get_or_create_srv_dev(bdev, srv_sess,
> +       srv_dev =3D rnbd_srv_get_or_create_srv_dev(bdev_handle->bdev, srv=
_sess,
>                                                   open_msg->access_mode);
>         if (IS_ERR(srv_dev)) {
>                 pr_err("Opening device '%s' on session %s failed, creatin=
g srv_dev failed, err: %ld\n",
> @@ -731,7 +732,8 @@ static int process_msg_open(struct rnbd_srv_session *=
srv_sess,
>                 goto blkdev_put;
>         }
>
> -       srv_sess_dev =3D rnbd_srv_create_set_sess_dev(srv_sess, open_msg,=
 bdev,
> +       srv_sess_dev =3D rnbd_srv_create_set_sess_dev(srv_sess, open_msg,
> +                               bdev_handle,
>                                 open_msg->access_mode =3D=3D RNBD_ACCESS_=
RO,
>                                 srv_dev);
>         if (IS_ERR(srv_sess_dev)) {
> @@ -747,7 +749,7 @@ static int process_msg_open(struct rnbd_srv_session *=
srv_sess,
>          */
>         mutex_lock(&srv_dev->lock);
>         if (!srv_dev->dev_kobj.state_in_sysfs) {
> -               ret =3D rnbd_srv_create_dev_sysfs(srv_dev, bdev);
> +               ret =3D rnbd_srv_create_dev_sysfs(srv_dev, bdev_handle->b=
dev);
>                 if (ret) {
>                         mutex_unlock(&srv_dev->lock);
>                         rnbd_srv_err(srv_sess_dev,
> @@ -790,7 +792,7 @@ static int process_msg_open(struct rnbd_srv_session *=
srv_sess,
>         }
>         rnbd_put_srv_dev(srv_dev);
>  blkdev_put:
> -       blkdev_put(bdev, NULL);
> +       blkdev_handle_put(bdev_handle);
>  free_path:
>         kfree(full_path);
>  reject:
> diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.=
h
> index 1027656dedb0..343cc682b617 100644
> --- a/drivers/block/rnbd/rnbd-srv.h
> +++ b/drivers/block/rnbd/rnbd-srv.h
> @@ -46,7 +46,7 @@ struct rnbd_srv_dev {
>  struct rnbd_srv_sess_dev {
>         /* Entry inside rnbd_srv_dev struct */
>         struct list_head                dev_list;
> -       struct block_device             *bdev;
> +       struct bdev_handle              *bdev_handle;
>         struct rnbd_srv_session         *sess;
>         struct rnbd_srv_dev             *dev;
>         struct kobject                  kobj;
> --
> 2.35.3
>
