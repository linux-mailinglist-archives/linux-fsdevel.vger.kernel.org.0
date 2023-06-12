Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C6D72B542
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 04:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjFLCAs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 22:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbjFLCAq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 22:00:46 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F201BF;
        Sun, 11 Jun 2023 19:00:45 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6532671ccc7so4232477b3a.2;
        Sun, 11 Jun 2023 19:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686535244; x=1689127244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rMMyGlB6DTER8HUf+6U5MgmEHa5nppERFwyKAgdHeek=;
        b=Zt49WLNGPM6W/KPmFYUxXA+DOprAbT9lTPcO88q9cdLlXau2gOm1dWOiHKXi6KyatL
         UHCWQ8IuznvdI8/j7cLOJ5fPzjf3DrbD81i/WpfJ+AmRB2KhkT2SpWL1idzWJKOw1Sxl
         6Y/kV1gPDx5yIVWbAAHi0Bl+ZwqiFg0pSqJLYgP7n2x106LFD8m0l0su9cxsz+XeSPYs
         +evSdqVEy3nCtz+q2q/b685BWma08yJ438WpGS0/Vpvm05D38Q8wpk4DCr/Q3O9NdWeI
         e0t3ATUkfshQm/xlmis8BFRi/4t/vSnzy61BUiRt5/647JkfIJQ9TsE9LGBqDlbebFl6
         iwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686535244; x=1689127244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMMyGlB6DTER8HUf+6U5MgmEHa5nppERFwyKAgdHeek=;
        b=Osq/gz816bSPpkYVAwXzIwYuAdixzKCwJVIri8YkDqhRmnYyb9Cf5BbXYEzrGYS/wp
         a9IojEQwKOKMB1reNLUofrAoKFgeJ5NVEaVL+eO87TGVDs/hItxQyhyEDT91foRgGXOn
         bdf8jMOvMla93KxJ7HDU4IgypQO3o6dp0lDNAlv7j7QtxjyTZrRc5uGIqiQlFuJJ6idR
         HTTem13ataDjIHfcZWIvkcc67qMIPYFSd1QsYl2oerM3F2oliB8gjBBoQKwlMBSbwM00
         /0geHWghcy3b1ZAt7hT90U39BxsjxO8nL8D0qwkDw5QZ6vcUCLIEMU0zoe9C7nGAs1CD
         126A==
X-Gm-Message-State: AC+VfDx1MmExG6tajjnlwNjKyMMFQyxpMY2rZSMupqXAul0+safXf/JN
        XFTP3YpsBbfG0qlVti4MQSc=
X-Google-Smtp-Source: ACHHUZ5BS/aU+hPOtHFvxwKCb8OOdvb23msp0xPk0TTSsANHKqdfjnFqTLDLXZ6xiwG+SusYLe0Smg==
X-Received: by 2002:a05:6a21:789a:b0:100:60f3:2975 with SMTP id bf26-20020a056a21789a00b0010060f32975mr10127361pzc.4.1686535244555;
        Sun, 11 Jun 2023 19:00:44 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-80.three.co.id. [180.214.232.80])
        by smtp.gmail.com with ESMTPSA id x4-20020a634844000000b0051f14839bf3sm6385009pgk.34.2023.06.11.19.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 19:00:44 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 8A563106B23; Mon, 12 Jun 2023 09:00:41 +0700 (WIB)
Date:   Mon, 12 Jun 2023 09:00:41 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mao Zhu <zhumao001@208suo.com>
Subject: Re: [PATCH] fs: Fix comment typo
Message-ID: <ZIZ8SdyHxRfYbW29@debian.me>
References: <20230611123314.5282-1-dengshaomin@cdjrlc.com>
 <ZIXEHHvkJVlmE_c4@debian.me>
 <87edmhok1h.fsf@meer.lwn.net>
 <ZIYpetKYwTH7TBWv@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2ZRHe8z2Qu5WXbqz"
Content-Disposition: inline
In-Reply-To: <ZIYpetKYwTH7TBWv@casper.infradead.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--2ZRHe8z2Qu5WXbqz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 11, 2023 at 09:07:22PM +0100, Matthew Wilcox wrote:
> On Sun, Jun 11, 2023 at 01:50:34PM -0600, Jonathan Corbet wrote:
> > Bagas Sanjaya <bagasdotme@gmail.com> writes:
> >=20
> > > On Sun, Jun 11, 2023 at 08:33:14AM -0400, Shaomin Deng wrote:
> > >> From: Mao Zhu <zhumao001@208suo.com>
> > >>=20
> > >> Delete duplicated word in comment.
> > >
> > > On what function?
> >=20
> > Bagas, do I *really* have to ask you, yet again, to stop nitpicking our
> > contributors into the ground?  It appears I do.  So:
> >=20
> > Bagas, *stop* this.  It's a typo patch removing an extraneous word.  The
> > changelog is fine.  We absolutely do not need you playing changelog cop
> > and harassing contributors over this kind of thing.
>=20
> Amen.
>=20

Amen too. Hope I can learn from this.

> > >> Signed-off-by: Mao Zhu <zhumao001@208suo.com>
> > >
> > > You're carrying someone else's patch, so besides SoB from original
> > > author, you need to also have your own SoB.
> >=20
> > This, instead, is a valid problem that needs to be fixed.
>=20
> I mean ... yes, technically, it does.  But it's a change that deletes
> a word in a comment.  Honestly, I'd take the patch without any kind of
> sign-off.  It doesn't create any copyright claim, which is the purpose
> of the DCO.

What? Relaxed SoB requirement for trivial patches like this? I thought
that SoB rules also apply to these patches.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--2ZRHe8z2Qu5WXbqz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZIZ8RQAKCRD2uYlJVVFO
o1zvAQCQ98p9qU2R3aLZRvDv6MD8yOzQ7x5XJW5uDhSv5YM5MAEA/e67NTI9e2dJ
BFLR3CDsS11ktuToHi9nnaqXTKvSGAM=
=eR7l
-----END PGP SIGNATURE-----

--2ZRHe8z2Qu5WXbqz--
