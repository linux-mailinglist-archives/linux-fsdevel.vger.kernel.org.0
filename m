Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCDD796E34
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 02:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238207AbjIGArC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 20:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245036AbjIGArA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 20:47:00 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97B81BCD
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 17:46:22 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bf11b1c7d0so11243035ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Sep 2023 17:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694047582; x=1694652382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=57AXZJo8Jb4yjf847g3y+DgEAO9Dl3SA1ttEwigOllQ=;
        b=mBAfxVVCfYawe3EMbMuLzq6nw94lY4CRPM1RiVqAqyzUm90TpjXmllVVesxpslrF44
         H8xNCNw/wv0fuJr7kopdFfpZRhYQvL0nZsxCuPYU3HlyKSJm7sWjkUip3v4obO7nQmSm
         qv2CQYuCym2X/ihs1qPLWCMzmkirhG44ExqOwRjk3bLUCRlBUryvPEv1FcrWmcEcfqCx
         7QuGKSvAwUyhrPXHAdWKGDkA13ZzWQuzKU2cVeEZy7gA96NpVF4Et1FXMsMOfyUu3y87
         pDDn7JT67u/Sio5GWGQX4j40pD9VXk3/HFt0JBkhsduhtNuvBClp+jE9QG8gHrwQaNvk
         Z2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694047582; x=1694652382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57AXZJo8Jb4yjf847g3y+DgEAO9Dl3SA1ttEwigOllQ=;
        b=THWVY7mk8wd4sYjR+6XD8FAclGaLpa/XAwAMvaebwKr0D3fpkAHHX8XFTQP3Cgc+GJ
         3O8fbeIJImRq+6FKH3T4CtQ9HaxFwe2Y3zdPcJjy0UQ8wulT0WNju0YhJac6dLBea/YM
         VlE0E44NNhU6CO3u2CD9R24mfK4t+U3EkSQHR+HkRdePVqUlmD/qC7ctc8IXtTq99Zm4
         TQOIK6k1zTBUIkk/zy3RXuB/MuaU5996/v72io12XI8faruVAg+EUUacgMQkabameLz5
         /OpDNkk3OmE6hylqMfn74+yjO6p9v2P/KGDCqmCeGWa+xFGyXV3st37tAm/5c9O5YeY0
         9ZqQ==
X-Gm-Message-State: AOJu0YwvqkO8Z1E7w4g062QpCrY6G7jFy+xlbxtBrz2jscv5pldTrs/Z
        cmVDz1sq3a0lqTe5PW9D1Zx7qKBJ+wQ=
X-Google-Smtp-Source: AGHT+IGEshBV6LanzKkBw8uAV7S2uZK+tdl1sD5PiG2+b+JzII9K8RkucdgWdnRLDs6fkkw53Ayklg==
X-Received: by 2002:a17:902:da91:b0:1bd:f69e:a407 with SMTP id j17-20020a170902da9100b001bdf69ea407mr1884708plx.8.1694047582161;
        Wed, 06 Sep 2023 17:46:22 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001bd62419744sm11582778pld.147.2023.09.06.17.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 17:46:21 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id AD5FD8CEA49C; Thu,  7 Sep 2023 07:46:18 +0700 (WIB)
Date:   Thu, 7 Sep 2023 07:46:17 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZPkdWd8Ihq7D7gjN@debian.me>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <ZPe0bSW10Gj7rvAW@dread.disaster.area>
 <ZPe4aqbEuQ7xxJnj@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4qbvKeCXYr1773C4"
Content-Disposition: inline
In-Reply-To: <ZPe4aqbEuQ7xxJnj@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--4qbvKeCXYr1773C4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[disclaimer: I'm no expert here, just my opinion]

On Wed, Sep 06, 2023 at 12:23:22AM +0100, Matthew Wilcox wrote:
> I really feel we're between a rock and a hard place with our unmaintained
> filesystems.  They have users who care passionately, but not the ability
> to maintain them.

In OTW: these fses are in limbo state, which induces another question:
how to get users of these into developers (and possibly maintainers)
to get out of this unfortunate situation? Do we have to keep
deprecated APIs they use indefinitely for the sake of servicing them without
any transition plan to replacement APIs? Do akpm have to step in for that to
happen?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--4qbvKeCXYr1773C4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZPkdUQAKCRD2uYlJVVFO
o/wyAQCltgShWt21XAnulgTA3k24PPQGghH2nW9zWxcXoTqJ2gD/aoeg4+SBzTiU
vVUsoqmLmR/ddK9ZveVTugdKEhXIxwA=
=M0u8
-----END PGP SIGNATURE-----

--4qbvKeCXYr1773C4--
