Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B040869E139
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 14:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjBUNWE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 08:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjBUNWC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:22:02 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343074690;
        Tue, 21 Feb 2023 05:22:02 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id z20-20020a17090a8b9400b002372d7f823eso940844pjn.4;
        Tue, 21 Feb 2023 05:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p0sBpfD+fMmPnVnPch2QdSuXJMJivtGWcw3I09DCcOE=;
        b=BUDJba8V9cChpw+Ak6JmNeAofV77+kMF+y/G4gtOI3DniOtyxlZA0x8RcZtQ+8TwO7
         bWf4OMoD/KV8sP6VllHBZ4/1ORkdJQ7GxWDybTHwXMDi9ektFDru5lXDI/S/b2IwN2Pn
         WN/vFx1xuET+BornGXCzGfE1NFHuF9p1MtC//rXRFFiH9O2W3YNHAjbixF3aE4+XIbq7
         AOCRY9z64lL6DuZnDpHOtXvpdSqdoTSk0msLZhkNP7Z/GABZjiwNnBwuTOFaHdIiGShI
         SYHnaZDOxBQjuxvQaYLWWS4R3crrue4OfUK18FN8zaenQTQS5rgA0VQOVCGaRx3LMpus
         c44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0sBpfD+fMmPnVnPch2QdSuXJMJivtGWcw3I09DCcOE=;
        b=YoJkyBByhsnAGypyRrS7PKcwr4L9GC3qZIWwlJH3YqqkgmjoRw9sgPOUTpxRwe6CE5
         9wnl8eC4QInQsdaLY0BniTVAQi4Mt1+4p5glqC7WvVvo2y3koEcKenZ/fmnNg9sJTybw
         ilbiKdKWA5VZpbjIGqsqQuytuW9LlyQAepl68cLoNKiNibOpoZTGMYosCge4ld2vJQ0/
         jw3sexXBBNukfjrL/qyPC6kDj0qGvvxJxAmvhpnbiBbU6H3nD8c5ms0t8x2+Fzzv6HK8
         z3f5l5D3EuJavbYrZ59oHRImpIyHsTywaTMqk1sSvVaCAWqy03x+pVUUikZnxAIkI0OE
         wb6g==
X-Gm-Message-State: AO0yUKW0pM/orbqJSqdI70ZHJuIGtpgkIYWtNTbGd6iCQ/zNycJ6nT6w
        Vw7Z03HKxpyD1OrV9wWB08I=
X-Google-Smtp-Source: AK7set+PzaRfeoV1EYRY0Z5pMH6zGWK99RtM80NqLIYc82JjBdn3qZzqkvidrmjlAoYin30I0CQcXg==
X-Received: by 2002:a17:90b:1e05:b0:236:42a:305f with SMTP id pg5-20020a17090b1e0500b00236042a305fmr5467334pjb.14.1676985721577;
        Tue, 21 Feb 2023 05:22:01 -0800 (PST)
Received: from debian.me (subs02-180-214-232-75.three.co.id. [180.214.232.75])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090acb0400b00234a2f6d9c0sm2997872pjt.57.2023.02.21.05.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 05:22:00 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 6EA001041A9; Tue, 21 Feb 2023 20:21:58 +0700 (WIB)
Date:   Tue, 21 Feb 2023 20:21:58 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "Hok Chun NG (Ben)" <me@benbenng.net>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
Subject: Re: [PATCH] Update documentation of vfs_tmpfile
Message-ID: <Y/TFdmhvrLu1h8Kl@debian.me>
References: <20230221035528.10529-1-me@benbenng.net>
 <01000186721d17f8-ab0c64f0-a6ae-4e43-99a3-a44e6dba95b6-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mKswOPah30bndfqb"
Content-Disposition: inline
In-Reply-To: <01000186721d17f8-ab0c64f0-a6ae-4e43-99a3-a44e6dba95b6-000000@email.amazonses.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--mKswOPah30bndfqb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2023 at 03:55:54AM +0000, Hok Chun NG (Ben) wrote:
> On function vfs_tmpfile, documentation is updated according to function s=
ignature update.
>=20
> Description for 'dentry' and 'open_flag' removed.
> Description for 'parentpath' and 'file' added.

What commit did vfs_tmpfile() change its signature?

For the patch description, I'd like to write "Commit <commit> changes
function signature for vfs_tmpfile(). Catch the function documentation
up with the change."

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--mKswOPah30bndfqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY/TFdgAKCRD2uYlJVVFO
ozc+AP4qUryIRntb+PPfmHBHxIGHdFmL4mE8hrxgGJvCNhauOAD+OxUq3BQxvr0U
xpegJVKuqhB/WsmYHyOl+IWOpvg1QQg=
=6K3R
-----END PGP SIGNATURE-----

--mKswOPah30bndfqb--
