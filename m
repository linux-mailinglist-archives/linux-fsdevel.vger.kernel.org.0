Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AC0599D2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 15:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349486AbiHSNwA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 09:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349489AbiHSNv4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:51:56 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DA8FF8C7;
        Fri, 19 Aug 2022 06:51:53 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id c39so5775965edf.0;
        Fri, 19 Aug 2022 06:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ExRVfq7Dqj4MRK0AfAWWfcL/ahJ1VdZq0IJIIIIDJpY=;
        b=HJ18yJjQh/UZhfSSatfDFg6Ntdr5PHrz2aXfk8Sp6j86nRlSaHK9f7iQq+BOlUhOOW
         azcSIXdLYJ8GTT7DTL92fKm5JudxRLgDwoy/KOvzAW/unOj5W2gh/4sMD+py07zZId+G
         llvAxOQjtgDYwOrqTwptPq3MjvF97fhH/zvLV5dKpyUulA//fxZ3Yv5fiuft7puUvHOU
         FS1obv218MGt8bDWbYU7CaEcm6Iz1fNRHFuEwi8gnGvJygpF/6x/8xTOAbNmQ7JsM8lV
         Vl6nMSOD/SHwxbKyF4O2VWRn3HAs4TbmxHvO24czQWWSFw8NM8BHm58N9dpRUZ/SVjLP
         uZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ExRVfq7Dqj4MRK0AfAWWfcL/ahJ1VdZq0IJIIIIDJpY=;
        b=jpG2oCiDkD9EOo4WFjT0lw2tZ5jPsD+XVr2mLP4R6UqT/bcVJacT01sI3tlMSntJjB
         vzvy0zAKg5NWdH7B81sjcrlHn/4HlQnohm98q25j6BnrQMVEE4FeBML5PXxLmA+aOgaT
         KWN5aVvXhH0aV0i0q11S+5YpG9ItAtEb5n4NHdLjpsOe+SV+enFFrc7I1JCT7Cwci4+p
         WZSrxTKtKZqZjrkBfIumG2kzcJvIIpp0iSTHRzdxzi6swmHkrWg/+sg2oEjcger4Fiku
         20dpyhdIxCVJ3ie4Ejx0PSMgbo+D5vvtceD2mrNMuIbAVvxFOdUyjTzyQwIUhIq/0ncz
         AL9w==
X-Gm-Message-State: ACgBeo0VNGsqiCwNhj9bjj1NnDJZ4ncmlCdz4y2nyPSgbDtYp3GXeuxP
        3DVJetv0mTXZhQodkwd6ND8W8xPMrpo=
X-Google-Smtp-Source: AA6agR7Qpl3jSwXli1tMFajU9lcJN/pG5JLh1/Lf7iXV3COBC6r11zEme5Yb06eR75yx0uLPgtmZEw==
X-Received: by 2002:aa7:dc13:0:b0:443:3f15:8440 with SMTP id b19-20020aa7dc13000000b004433f158440mr5991305edu.274.1660917111163;
        Fri, 19 Aug 2022 06:51:51 -0700 (PDT)
Received: from opensuse.localnet (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id a9-20020a17090640c900b0072637b9c8c0sm2327610ejk.219.2022.08.19.06.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 06:51:49 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     linux-fscrypt@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] fs-verity: use kmap_local_page() instead of kmap()
Date:   Fri, 19 Aug 2022 09:50:37 +0200
Message-ID: <44912540.fMDQidcC6G@opensuse>
In-Reply-To: <20220818224010.43778-1-ebiggers@kernel.org>
References: <20220818224010.43778-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On venerd=C3=AC 19 agosto 2022 00:40:10 CEST Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
>=20
> Convert the use of kmap() to its recommended replacement
> kmap_local_page().  This avoids the overhead of doing a non-local
> mapping, which is unnecessary in this case.
>=20
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/verity/read_metadata.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

It looks good to me...

Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks,

=46abio

> diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
> index 6ee849dc7bc183..2aefc5565152ad 100644
> --- a/fs/verity/read_metadata.c
> +++ b/fs/verity/read_metadata.c
> @@ -53,14 +53,14 @@ static int fsverity_read_merkle_tree(struct inode=20
*inode,
>  			break;
>  		}
>=20
> -		virt =3D kmap(page);
> +		virt =3D kmap_local_page(page);
>  		if (copy_to_user(buf, virt + offs_in_page, bytes_to_copy))=20
{
> -			kunmap(page);
> +			kunmap_local(virt);
>  			put_page(page);
>  			err =3D -EFAULT;
>  			break;
>  		}
> -		kunmap(page);
> +		kunmap_local(virt);
>  		put_page(page);
>=20
>  		retval +=3D bytes_to_copy;
>=20
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> prerequisite-patch-id: 188e114bdf3546eb18e7984b70be8a7c773acec3
> --
> 2.37.1




