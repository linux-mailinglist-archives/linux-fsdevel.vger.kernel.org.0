Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509F072B1E8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 14:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbjFKMzI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 08:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjFKMzG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 08:55:06 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115F61B8;
        Sun, 11 Jun 2023 05:55:02 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-528cdc9576cso1601444a12.0;
        Sun, 11 Jun 2023 05:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686488101; x=1689080101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qoVZW2bivguqn6AKKTwEgxPn9HvFkbakdebxI4R8tV4=;
        b=gtmQflKPxdDbDPdvpsPwyeaf5S7ll6Ms/7Rpg3IA4lmv5WCLvxp+WxyAuUzKwDizPV
         mLbCP6F05cPnee6XuCaoH/JnOxJ2U93Cirghre/EaTSvusqdkyX7cVjzyW/mCl9jsPf4
         lU8TFD4rOT0LIpWVfgcuMUOrS8ZdJ1B8qtzO9o25g41Pk2vATLfn0erGTVrFwVoldqA+
         XaR2XPmF4375dukxhHVYFeN0gXdoCyMai2GPo9WKhTP4pu0HlDHRBvZXaEn8AiCxRW8t
         j3GUp/i3tsgG61SVlx1aXXZ5evrE1T2t7qxP3MQ0VwETzH7z9v4NUiKltgLxZtpIORFh
         i7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686488101; x=1689080101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoVZW2bivguqn6AKKTwEgxPn9HvFkbakdebxI4R8tV4=;
        b=JX0oomnAiQeoWQUhDr3iIEEDm9aMbDtF8rAPSJH/RRM7nr1iUNXtT0MMazscf1DtT0
         4GKdztBTgeZZapOCUcjhFscz0b0fhgtZx60izTmIFVqvdcaU9eqx6eASqv27+bLZHyha
         xeLc3JtIUOo8chwD71ZGJzYv6lDJH8NYkMwKan8r0jxmRtdu9zB4xWwCZU2lj4CWZdP9
         jBghLTDN7pd50hnS8n7QT919LBeu0+410loMrdWPmbJzZFbqbddwuT+QQnxaT7cCLRKa
         ICPHryOYwJbfCaxHSE+BYANx58idpJj4T/pCEMzF0U7tanUKNRp04WB5eyFh6Iv6Wd/u
         xC6w==
X-Gm-Message-State: AC+VfDwAcSuFHC+rNRRQPUMnxgNelqS+zvoW8B60zhc2uO5f5zUt+TNh
        qukk+jcr9j7mY6hr1ZOojhU=
X-Google-Smtp-Source: ACHHUZ6r7U3mGgGJzSzAU+viZ5EAmnneQo/rSzsl1VQoHb5SWVmusE97aqBxjpoWwUdtvrHR67NIfA==
X-Received: by 2002:a17:90a:617:b0:256:dbfb:9b5e with SMTP id j23-20020a17090a061700b00256dbfb9b5emr5669642pjj.29.1686488101339;
        Sun, 11 Jun 2023 05:55:01 -0700 (PDT)
Received: from debian.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id ms18-20020a17090b235200b0025bbe90d3cbsm1910806pjb.44.2023.06.11.05.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 05:55:00 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id F0AD8106A3A; Sun, 11 Jun 2023 19:54:52 +0700 (WIB)
Date:   Sun, 11 Jun 2023 19:54:52 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Shaomin Deng <dengshaomin@cdjrlc.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mao Zhu <zhumao001@208suo.com>
Subject: Re: [PATCH] fs: Fix comment typo
Message-ID: <ZIXEHHvkJVlmE_c4@debian.me>
References: <20230611123314.5282-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+O3zIJTHyNTqGyBt"
Content-Disposition: inline
In-Reply-To: <20230611123314.5282-1-dengshaomin@cdjrlc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--+O3zIJTHyNTqGyBt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 11, 2023 at 08:33:14AM -0400, Shaomin Deng wrote:
> From: Mao Zhu <zhumao001@208suo.com>
>=20
> Delete duplicated word in comment.

On what function?

>=20
> Signed-off-by: Mao Zhu <zhumao001@208suo.com>

You're carrying someone else's patch, so besides SoB from original
author, you need to also have your own SoB.

> ---
>  include/linux/fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index df6c1817906f..aa870b77cc2b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2675,7 +2675,7 @@ extern void evict_inodes(struct super_block *sb);
>  void dump_mapping(const struct address_space *);
> =20
>  /*
> - * Userspace may rely on the the inode number being non-zero. For exampl=
e, glibc
> + * Userspace may rely on the inode number being non-zero. For example, g=
libc
>   * simply ignores files with zero i_ino in unlink() and other places.
>   *
>   * As an additional complication, if userspace was compiled with

I don't see the function name in above diff (dump_mapping() isn't the
function I mean). Regardless, the fix LGTM.

@cdjrlc.com developers: I'm really, really fed up with you ignoring
review comments. It seems like you have issues on your mail setup. Fix
your mailer! Until then, I just say NAK.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--+O3zIJTHyNTqGyBt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZIXEGQAKCRD2uYlJVVFO
o7seAP9+215GHU5WZCA77cMwS1Iq2tmRXpMWMURenHy1HQmDPgD+I183rge40np6
c189kL3vpaibaUYDbla/LnSryNu4oA0=
=KrJv
-----END PGP SIGNATURE-----

--+O3zIJTHyNTqGyBt--
