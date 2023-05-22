Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3AC70C440
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 19:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjEVR2z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 13:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjEVR2y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 13:28:54 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060F5F4;
        Mon, 22 May 2023 10:28:53 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f122ff663eso6902377e87.2;
        Mon, 22 May 2023 10:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684776531; x=1687368531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pukkaqqiRiZz50YRhtJKgZ/y5FxYLgqqZ4VW0SrMtC8=;
        b=aPnzLGC2TGkiwtHumljX+JClUdLb2E9e0YezYUKkJNtW+4FHNfczYdbiQQ5A14K4Tl
         +D6+Dw/sQ5oQYuOfIxQRDjp9udHzeM7LdPSkpRKjUYIQZmeCk9MOIqg65D4rLy8IJH89
         bl3MK+U16rq+X5vQEMcjUBLkPTbv5uY9oiflQmqsgObPxvGTCNdnbD0dKIFP7wjesFsw
         3EBfLchz9kPPqqgy8zmUJwzYO7IxxRgRTdCsGY2MQrUdRa6h67WofBNxNzUT1fXfHbLo
         +qxRglJljE7CZrnIIK5Elz+jcKiOoTfJoQhwj1qYEkmiawcaUcGIXBcQ39FNJELI6HE2
         R//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684776531; x=1687368531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pukkaqqiRiZz50YRhtJKgZ/y5FxYLgqqZ4VW0SrMtC8=;
        b=CWSSBgW38MvWCck3JAfBKzoZBczup6M6+p3EkrOK4cczWs5x7NdsIa009MvAJpRAx1
         RmPDIll31aOEe/+piJidCRCetpvsN4uScUiNdXkWfZZssOb+qKJy9EceUPcybcoNHgob
         9ER2SSx17MMDORHs7MNr+DDhe74xYwKnhpGtWGTaTly9wE8Z7uMxw2kxQZF0c1bKZKRt
         n9akcHaePV712jvQfbV7LrLHOT+O+zK1x66FCRVWIQi+cTdGQLgmH4IFq2kX80zDG4BZ
         v+fzg4cNU8am/DQSfhrjok96BLzIbIt5TUadAdiIrxDT3dgXuK9hx8TEUKDMjGnF3o37
         FnUg==
X-Gm-Message-State: AC+VfDzZEwCWouEO9Nc1klnYGUuhPCBxijzbnA89jEJtPwJD63IO39ol
        bdwyZkGjKmQvupf3q/bP02CyJZk5EQlzlF2BZlE=
X-Google-Smtp-Source: ACHHUZ7YO9NKrN28rBECys+beHWL+Vy+TVxAJVexpCn9PSnMHkxb9GHTjUEXOPqY5iST+ieSJlRGBdG8FDWoqp61CqY=
X-Received: by 2002:a19:ad02:0:b0:4f1:3eca:76a0 with SMTP id
 t2-20020a19ad02000000b004f13eca76a0mr2728643lfc.66.1684776530560; Mon, 22 May
 2023 10:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <2811951.1684766430@warthog.procyon.org.uk>
In-Reply-To: <2811951.1684766430@warthog.procyon.org.uk>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Mon, 22 May 2023 22:58:39 +0530
Message-ID: <CANT5p=pNFpEj0p+njYw3sVdq9CKgsTdh29Gj6iYDOsMN0ocj1Q@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix cifs_limit_bvec_subset() to correctly check the
 maxmimum size
To:     David Howells <dhowells@redhat.com>
Cc:     Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <smfrench@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Paulo Alcantara <pc@manguebit.com>,
        Tom Talpey <tom@talpey.com>, Jeff Layton <jlayton@kernel.org>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 8:22=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Fix cifs_limit_bvec_subset() so that it limits the span to the maximum
> specified and won't return with a size greater than max_size.
>
> Fixes: d08089f649a0 ("cifs: Change the I/O paths to use an iterator rathe=
r than a page list")
> Reported-by: Shyam Prasad N <sprasad@microsoft.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <smfrench@gmail.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: Tom Talpey <tom@talpey.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/cifs/file.c |    1 +
>  1 file changed, 1 insertion(+)
>
>
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index ba7f2e09d6c8..4778614cfccf 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -3353,6 +3353,7 @@ static size_t cifs_limit_bvec_subset(const struct i=
ov_iter *iter, size_t max_siz
>         while (n && ix < nbv) {
>                 len =3D min3(n, bvecs[ix].bv_len - skip, max_size);
>                 span +=3D len;
> +               max_size -=3D len;

Shouldn't this decrement happen below, after the span has been
compared with max_size?

>                 nsegs++;
>                 ix++;
>                 if (span >=3D max_size || nsegs >=3D max_segs)
>


--=20
Regards,
Shyam
