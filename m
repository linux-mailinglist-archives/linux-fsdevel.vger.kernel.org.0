Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973B970E213
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 18:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbjEWQbM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 12:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjEWQbL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 12:31:11 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1AAE0;
        Tue, 23 May 2023 09:31:09 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f3b9e54338so105520e87.0;
        Tue, 23 May 2023 09:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684859467; x=1687451467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGIwkL0PP8YODaMN3n8QoDck+WHcXF208Kv/zXnG360=;
        b=JkG507OsWCRuHvJbGgL3PIM7CSsl4ixF0HV9tX0MjNaGMutXtl59HlMQaTi9L7TVQ0
         0uW5whc6Uncb8VJ+UytyUZbpe/ZrZ3n4yHGip0vcVYlfn5mkQM+H82cO3oE+WS1fuH2J
         oaq2OGqrAie+QFQjcmc9z4OWzi14fnSehly/q2rQNbdPfj8nayCLWNSjfLxxdoV35R+L
         BnvJsWmdrtHggw6phVHjTp2Oo0uHezCb4JHR6tVPP1140j+7jh6s7uBxhkSEmk8LAM2V
         5PBvZJ6VcUJCqWo5DVJikkLqEBWPrZv4no9B+IMbTKoYW8CpWHMUMy35U/2VqdDvbeBi
         DH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684859467; x=1687451467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGIwkL0PP8YODaMN3n8QoDck+WHcXF208Kv/zXnG360=;
        b=WrbwhKyOMhVAnhzvAGaIIiBBf4QpiW+u1uaT0L1uh+EKiUknptVK1hzJ0iOhv06DDf
         d7BkCECsp2pR9VrCRCN7uAW+E6zeFoPXRIZOB+CO7leT2bYCgS1pHo+zFoxMXzHjCuj3
         nJABLOjXKYx8UXrSk1EbzCno5a6DpWwqdTPG11B5wO89XuHXPPNkgGgBrO2j2RIbfS7n
         Dt8w/9QE6dxzDInVHE+VovmUYb6g1x6gSzOxW9Cr7+JNtcasEoGK2sX2A3bgWaHdm6pe
         mZoqoFlc+zVKJ/Tq5YCo0/dH9tNhsIfoVseW/2sFVMjBBWJT6ltZXPIzDdD8M6hLA5l0
         80eg==
X-Gm-Message-State: AC+VfDx1roCHeLrLKknDbZHDC06mn0JgmFuGAH/s8QNj3L4Ev3OeQFdE
        kA4Sz5+5bZSnGsHShMD07Ur4YIQ+eSZZsBxlq/w=
X-Google-Smtp-Source: ACHHUZ6XxYMjRPfT3xIGKngiLHoL5Ye98dFpjpDe+w98eFwhLgs2qTWaYrwILtPbNJvWKXFze81PctmbI6VCnaDdZOU=
X-Received: by 2002:a05:6512:15e:b0:4f0:e2:c709 with SMTP id
 m30-20020a056512015e00b004f000e2c709mr4868396lfo.17.1684859467103; Tue, 23
 May 2023 09:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <2989165.1684846121@warthog.procyon.org.uk>
In-Reply-To: <2989165.1684846121@warthog.procyon.org.uk>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Tue, 23 May 2023 22:00:55 +0530
Message-ID: <CANT5p=r7usL_YOBxRoiVCrZpZr2+-FLjs1Jg_T6R5==HJQ0epg@mail.gmail.com>
Subject: Re: [PATCH v2] cifs: Fix cifs_limit_bvec_subset() to correctly check
 the maxmimum size
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

On Tue, May 23, 2023 at 6:24=E2=80=AFPM David Howells <dhowells@redhat.com>=
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
>  fs/cifs/file.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index ba7f2e09d6c8..df88b8c04d03 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -3353,9 +3353,10 @@ static size_t cifs_limit_bvec_subset(const struct =
iov_iter *iter, size_t max_siz
>         while (n && ix < nbv) {
>                 len =3D min3(n, bvecs[ix].bv_len - skip, max_size);
>                 span +=3D len;
> +               max_size -=3D len;
>                 nsegs++;
>                 ix++;
> -               if (span >=3D max_size || nsegs >=3D max_segs)
> +               if (max_size =3D=3D 0 || nsegs >=3D max_segs)
>                         break;
>                 skip =3D 0;
>                 n -=3D len;
>

Looks good to me.

--=20
Regards,
Shyam
