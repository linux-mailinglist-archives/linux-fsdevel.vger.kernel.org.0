Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FFB72B526
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 03:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjFLBlv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 21:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjFLBlt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 21:41:49 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E80C7;
        Sun, 11 Jun 2023 18:41:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6537d2a8c20so3025284b3a.2;
        Sun, 11 Jun 2023 18:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686534107; x=1689126107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yopFSgNdaN//0wszcig4teNnA065e5aIyJpZ3l6KI2Y=;
        b=DqASSGU8054Ojl4Rp41Eu/AmjYA9jTSyaEJ0cT4Ok9haxIh7MnmOLTwG9MBAEI8LPl
         FKGFpjsxHXwnExkVBlW5jrYbY1nZqzFZnDQxVk2Mq1G2B1D1Iz5/ycZl92w921k6aNBI
         nlR3oS+J1LhledE6iR2o6PWPq3zPjFK/qL/iGluaDWpJdqyRvDWI1tD7QRtcVWVYXlgw
         ERPqU8XoDjjFIVqIyhWizvwdlyzIMmId3RwgXncXMZ02L8OpyReC9xryVc8H6eW98Azc
         nrIYr1yFfeSrDGJbt4HM3vAZ4Jte68RK47V/GK3oFmdQcqqf8qqV5z4yQkNHUmAJAOML
         EO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686534107; x=1689126107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yopFSgNdaN//0wszcig4teNnA065e5aIyJpZ3l6KI2Y=;
        b=MC+zpvDZ4oSqAJUNxN0NjOcQSKGTn259ilXtqvLc1fxpLY61EuS/jQzv91aGjpLYTf
         IWPcf7yladti8qLm6Fu1Bt3AOs/CFw/15y9quEQuPlted8pMganXUUTihKzo8YUakTOW
         F3fR+b4AjEyxgLwH0YDEsu/V9j1EmIAzNsMDYk9vhDTZJ3Eh4cmSN6vPlI5LSrxd8Mzg
         dRDPqVEZ4+RNsd0ayp+9RhGu9DNSHeJvmL8TIWZrxSL0Z4y7T72xXk0gDIJF7ZWtuhFq
         ttKAMrWwxYcVcsbFg7zaLV7EdUUooR1SSHQL/4+LIrb25EUTGaFpOingWQpj+z4cjIOy
         mlpQ==
X-Gm-Message-State: AC+VfDxE5u3+njANwR4YVMmIHYSFxO3rWcrswc0gtl74aqvQOoR/y4+h
        hlZ0d+cXCHfrjQ51/xbDD7o=
X-Google-Smtp-Source: ACHHUZ6F08vBBoX4T/x09Do29EIHP3a1t6uCNlx2RFx9MU/8OcrMmTEmgkGCtC7CKgkw3zbk3GyT/w==
X-Received: by 2002:a05:6a20:8f04:b0:110:9b0b:71ab with SMTP id b4-20020a056a208f0400b001109b0b71abmr10344083pzk.40.1686534107283;
        Sun, 11 Jun 2023 18:41:47 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-80.three.co.id. [180.214.232.80])
        by smtp.gmail.com with ESMTPSA id z17-20020a631911000000b00548fb73874asm4790988pgl.37.2023.06.11.18.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 18:41:46 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 211C2106B23; Mon, 12 Jun 2023 08:41:43 +0700 (WIB)
Date:   Mon, 12 Jun 2023 08:41:42 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Shaomin Deng <dengshaomin@cdjrlc.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mao Zhu <zhumao001@208suo.com>
Subject: Re: [PATCH] fs: Fix comment typo
Message-ID: <ZIZ31kVtPmaYBqa0@debian.me>
References: <20230611123314.5282-1-dengshaomin@cdjrlc.com>
 <ZIXEHHvkJVlmE_c4@debian.me>
 <87edmhok1h.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FGXs17wAABqF2OWs"
Content-Disposition: inline
In-Reply-To: <87edmhok1h.fsf@meer.lwn.net>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--FGXs17wAABqF2OWs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 11, 2023 at 01:50:34PM -0600, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>=20
> > On Sun, Jun 11, 2023 at 08:33:14AM -0400, Shaomin Deng wrote:
> >> From: Mao Zhu <zhumao001@208suo.com>
> >>=20
> >> Delete duplicated word in comment.
> >
> > On what function?
>=20
> Bagas, do I *really* have to ask you, yet again, to stop nitpicking our
> contributors into the ground?  It appears I do.  So:
>=20
> Bagas, *stop* this.  It's a typo patch removing an extraneous word.  The
> changelog is fine.  We absolutely do not need you playing changelog cop
> and harassing contributors over this kind of thing.

OK, thanks for reminding me again.

At the time of reviewing, I had bad feeling that @cdjrlc.com people will
ignore review comments (I betted due to mail setup problem that prevents
them from properly repling to mailing lists, which is unfortunate). I
was nitpicking because the diff context doesn't look clear to me (what
function name?).

>=20
> >> Signed-off-by: Mao Zhu <zhumao001@208suo.com>
> >
> > You're carrying someone else's patch, so besides SoB from original
> > author, you need to also have your own SoB.
>=20
> This, instead, is a valid problem that needs to be fixed.

OK.

Sorry for my inconvenience.

--=20
An old man doll... just what I always wanted! - Clara

--FGXs17wAABqF2OWs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZIZ31gAKCRD2uYlJVVFO
oxQkAQD/hoO/EDmJSjuflzqFnpSdkF1t/o215NOR4w7GAu2RUwD/TkrHHm+FiR4L
J5tKq3R8DIFZrBrP4yfaUIkP3SMwuQk=
=tNfU
-----END PGP SIGNATURE-----

--FGXs17wAABqF2OWs--
