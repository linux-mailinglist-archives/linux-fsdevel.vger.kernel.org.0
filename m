Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E07B703F81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 23:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244744AbjEOVTg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 17:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbjEOVTe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 17:19:34 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03728D2D5
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 14:19:33 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bdd7b229cso24003903a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 14:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684185571; x=1686777571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCAGJRSZlOdbZk8TJO2+IV5B/w81wFfW9jtMkWpTH+M=;
        b=Fvz8x0dNvAfi6vn1MsWVsrIVhI0JC8Py8rU64fVV7c1WYzdrPJSFY/nJ5/ha/SBSdW
         O9Qrv+J04LkWY26V+6ISj9fbwtnonPqRY48vi74RSHlcYaXNOdDEzZhPQlpxhzKkIUJ0
         9wiJslfn6dHpTu8YNli6Te99vlovWTdFmnEfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684185571; x=1686777571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCAGJRSZlOdbZk8TJO2+IV5B/w81wFfW9jtMkWpTH+M=;
        b=VVDL8q4GxmVEY3/XnMD7I/jSTla4ITOQdI9z0XIUayuvin64SqRVTqiYosQHky416E
         32BGPLq2XUh/NH+0PFM9V17iJkzWrE+plUaBlqzJhFYLsr31PX/aJ32IkbveUC53GQ9B
         WOqQRwIsKBgDUknOALnBcaaxf62N2W87vYTzHIY2c9qP8lhF/vFMkBLaVNTWJj8nS/6M
         KR7RUDuKPvDQB+q6GgZHNaUThLJ3K+LWWwANSZgXWDd2gzaVBABmIF3YD/EGd8XOcAU7
         KD/ty1OL0pj9hM4rLtMW3YEYfM2jKtpDnGgYzd0KgTRl+4UByye271z7JYcFbiuFS/lq
         9AAw==
X-Gm-Message-State: AC+VfDw+g8m0SW6sRYRFVvWrtqlpf8NoPsVqHxtbSrPKqYEUKMbeColn
        GQVu3ETeGkI8JpmOLNR8ET1j5RD2BiDE89cDc/yuiw==
X-Google-Smtp-Source: ACHHUZ4NVNi7naSU30mEHscyRmFftvi4fhFnmiYSDcSrg9y4ApnJuNxOMdtq7yH9l565H4qJkeCcSkHBc3YRcSzTMNU=
X-Received: by 2002:a17:907:9485:b0:96a:b12d:2fdf with SMTP id
 dm5-20020a170907948500b0096ab12d2fdfmr10487913ejc.12.1684185571480; Mon, 15
 May 2023 14:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230420004850.297045-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-1-sarthakkukreti@chromium.org> <20230506062909.74601-5-sarthakkukreti@chromium.org>
 <ZF54OH8hZTTko4c3@redhat.com>
In-Reply-To: <ZF54OH8hZTTko4c3@redhat.com>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Mon, 15 May 2023 14:19:20 -0700
Message-ID: <CAG9=OMMj+xNNNFR6JJbsbzjb=9oVScg+BYdAq68hBRzw3q81ZA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] dm-thin: Add REQ_OP_PROVISION support
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 12, 2023 at 10:32=E2=80=AFAM Mike Snitzer <snitzer@kernel.org> =
wrote:
>
> On Sat, May 06 2023 at  2:29P -0400,
> Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:
>
> > dm-thinpool uses the provision request to provision
> > blocks for a dm-thin device. dm-thinpool currently does not
> > pass through REQ_OP_PROVISION to underlying devices.
> >
> > For shared blocks, provision requests will break sharing and copy the
> > contents of the entire block. Additionally, if 'skip_block_zeroing'
> > is not set, dm-thin will opt to zero out the entire range as a part
> > of provisioning.
> >
> > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > ---
> >  drivers/md/dm-thin.c | 70 +++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 66 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> > index 2b13c949bd72..3f94f53ac956 100644
> > --- a/drivers/md/dm-thin.c
> > +++ b/drivers/md/dm-thin.c
> ...
> > @@ -4114,6 +4171,8 @@ static void pool_io_hints(struct dm_target *ti, s=
truct queue_limits *limits)
> >        * The pool uses the same discard limits as the underlying data
> >        * device.  DM core has already set this up.
> >        */
> > +
> > +     limits->max_provision_sectors =3D pool->sectors_per_block;
>
> Just noticed that setting limits->max_provision_sectors needs to move
> above pool_io_hints code that sets up discards -- otherwise the early
> return from if (!pt->adjusted_pf.discard_enabled) will cause setting
> max_provision_sectors to be skipped.
>
> Here is a roll up of the fixes that need to be folded into this patch:
>
Ah right, thanks for pointing that out! I'll fold this into v7.

Best
Sarthak

> diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> index 3f94f53ac956..90c8e36cb327 100644
> --- a/drivers/md/dm-thin.c
> +++ b/drivers/md/dm-thin.c
> @@ -4151,6 +4151,8 @@ static void pool_io_hints(struct dm_target *ti, str=
uct queue_limits *limits)
>                 blk_limits_io_opt(limits, pool->sectors_per_block << SECT=
OR_SHIFT);
>         }
>
> +       limits->max_provision_sectors =3D pool->sectors_per_block;
> +
>         /*
>          * pt->adjusted_pf is a staging area for the actual features to u=
se.
>          * They get transferred to the live pool in bind_control_target()
> @@ -4171,8 +4173,6 @@ static void pool_io_hints(struct dm_target *ti, str=
uct queue_limits *limits)
>          * The pool uses the same discard limits as the underlying data
>          * device.  DM core has already set this up.
>          */
> -
> -       limits->max_provision_sectors =3D pool->sectors_per_block;
>  }
>
>  static struct target_type pool_target =3D {
> @@ -4349,6 +4349,7 @@ static int thin_ctr(struct dm_target *ti, unsigned =
int argc, char **argv)
>
>         ti->num_provision_bios =3D 1;
>         ti->provision_supported =3D true;
> +       ti->max_provision_granularity =3D true;
>
>         mutex_unlock(&dm_thin_pool_table.mutex);
>
