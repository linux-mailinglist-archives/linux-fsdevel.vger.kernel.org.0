Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46577BCED5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Oct 2023 16:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344865AbjJHOHb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Oct 2023 10:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344827AbjJHOHa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Oct 2023 10:07:30 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6C799;
        Sun,  8 Oct 2023 07:07:29 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c60f1a2652so27607555ad.0;
        Sun, 08 Oct 2023 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696774049; x=1697378849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MCzYakcpTcETitAtIw4d5gEkmbg6TBgqI55HTypQAD4=;
        b=Nf+Wzb7yb3EYGmeYyFAoa7jYkh+HDGLnG6dtx5tdVcxdMiokLzDN54snDBnToW5qEr
         KeNZy/ZpbqzrywRgqQiEGqD65GjUX0tHQPqycvNLYbYukkl+Y2G0k+EG8Y3rymfkwl5g
         ZTdasvq83COtEa5ZqJK32H2RGRkC3CsSdWWD2tP/JZQUssAkHULBouqkjZEB07ekWvVY
         OwwkenAwx2KOxRi8lo1tgDRNnGxflJDDqBmNt1Nnd+yw0qlEIpj6xUHxS2AVWnKMrpd2
         l26jcDKZ81DW/iyN4hyG9XtdsOaxQ0UtO/NbaRxP1pcO+JQMt9bJRZYqjPkjk9QqVhpj
         Xpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696774049; x=1697378849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCzYakcpTcETitAtIw4d5gEkmbg6TBgqI55HTypQAD4=;
        b=HOPjeRh7EDI3s370TQLsNx+R1TUmC7pg1Up2KS4DpA1Xazqcc/Cmc4MEESBAwnfmsh
         20w7u4nFtrSelxu1sqCkubkhzxs2UBrkBSFLz4vdLXvS7SBplIiB5y5kmADivmaFvhIJ
         QwICXClYXSf3sElmaAD7ADNABRy7Kj9mKfDNwHO0oJmyicZigJ3OYVOlkOhVOAJmy38Y
         z1IcMBJ0rozMfOeOSHkOkkftOMzklKwssST1zdG/JU/wFg1TNguH5Y6aZP17SFL24F1P
         V8dAaOwEC50YOCp6/jfs9Ginh4b2avh0lHN904KNs9qKRRWFUxycr3ZMtMcfGF0F8X40
         BH2A==
X-Gm-Message-State: AOJu0YxYufdFLToJPnbEFTMmpr1SmU+IaOQL6vgWACypOdNk6q/zuqyP
        Ie9xnCQLfSL9RXDTVCQR/SQ=
X-Google-Smtp-Source: AGHT+IEuG5Dq8Oms/y2PngPTgvKQircr+FmzMSKiNRi0dDe4aZQk5y2v/Jz2z7VHMmWqJWr8HQT27A==
X-Received: by 2002:a17:902:d4c5:b0:1c5:6f4d:d6dd with SMTP id o5-20020a170902d4c500b001c56f4dd6ddmr15240247plg.24.1696774049170;
        Sun, 08 Oct 2023 07:07:29 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902740600b001bc18e579aesm7479450pll.101.2023.10.08.07.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 07:07:28 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 6CCB981B12C1; Sun,  8 Oct 2023 21:07:05 +0700 (WIB)
Date:   Sun, 8 Oct 2023 21:07:04 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     dianlujitao@gmail.com, Matthew Wilcox <willy@infradead.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: Fwd: kernel bug when performing heavy IO operations
Message-ID: <ZSK3iAX0LASTiczY@debian.me>
References: <f847bc14-8f53-0547-9082-bb3d1df9ae96@gmail.com>
 <ZOrG5698LPKTp5xM@casper.infradead.org>
 <7d8b4679-5cd5-4ba1-9996-1a239f7cb1c5@gmail.com>
 <ZOs5j93aAmZhrA/G@casper.infradead.org>
 <b290c417-de1b-4af8-9f5e-133abb79580d@gmail.com>
 <ZRPXlfGFWiCNZ6sh@casper.infradead.org>
 <162d90ab-e538-402e-90f1-304183bf6e76@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p6UxYEauVSIXOnHn"
Content-Disposition: inline
In-Reply-To: <162d90ab-e538-402e-90f1-304183bf6e76@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--p6UxYEauVSIXOnHn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 08, 2023 at 09:35:58PM +0800, dianlujitao@gmail.com wrote:
> The problem does not occur with 6.1.56 lts kernel, not that old as you
> expected.
>=20

Please don't top-post; reply inline with appropriate context instead.

OK, now please find the culprit by bisection (see
Documentation/admin-guide/bug-bisect.rst in the kernel sources for how).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--p6UxYEauVSIXOnHn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZSK3gwAKCRD2uYlJVVFO
o1UMAQCDIIiOIKgA0D91V27q0wwqHdlmfdne/CpU3JUhZIyFuwD/WwEttZpHXT8F
UWjLIkh7OrKNK4II7/zCyx61ii5llwk=
=Ru5o
-----END PGP SIGNATURE-----

--p6UxYEauVSIXOnHn--
