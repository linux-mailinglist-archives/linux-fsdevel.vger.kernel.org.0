Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B6079E0EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 09:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbjIMHhy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 03:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjIMHhx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:37:53 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8113C1729;
        Wed, 13 Sep 2023 00:37:49 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bf55a81eeaso45603615ad.0;
        Wed, 13 Sep 2023 00:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694590669; x=1695195469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jmJN9dyFxG0ZDa5DUc653tNGEVo7z94noVDJ6MnTyRc=;
        b=R3FoEAXc7B0UfN97a0G1ynfJstGAcrgP4KTjDD6WABCKpDm+y2jx/bIcg+D5iykYNU
         F1v1Gu/zXMAmrO5gtXbvQNzjHJeZ5+JFKYwweqZFZH0htn0hn28uS6aaBTHD3qAWlepN
         8ikFG6QVn8x0RmlV3Q8QUoo0U1XqzRIZ0dcc1kdadJiYeCVTy4QTlzGHeRaKH1XlEhY7
         kf3KNRLNyHlxjS7Dr84SAUvwiDA7n7sfRsMQLABIHeHTiJFAJeQkXD/OCtDpGP9JoFqb
         n4fzEWJ/XWhA/MyShq9PLqC3jPFeS0Z0tg5faFeHyDP4Ql2nzBYffxgrrdHHA8iN52ap
         AZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694590669; x=1695195469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmJN9dyFxG0ZDa5DUc653tNGEVo7z94noVDJ6MnTyRc=;
        b=pabAndoN0J2n6bQ1+iCeK6qYtMnGaGk6tebsIqo8PYiBwLnsZPROe6Qe/87n4k23yN
         Yo4ypWgE1KTDexcsIitpvmkvsfAOAe9VTYRTsm0iz9xiRSNtzOWscNa5EnjJDTd3xYI8
         mPYwSNTcuYDXbCi47e07WOiw6tfBwOejIgepVXO3wlyn/mXCkORE3ltSoYiUjeNcKF6l
         VqLkcwn+gYkiW0yKwzwSS6i3Dmpw0WvAbgO82mSR/Djn+aXRNMnDrjYNcs8+dSTr+LgW
         jeVTUWV+d2lvgHnPjqfJWTj62xjFq2I9hFIQAijVeI4nx358OVhJMCUu4A6CKIRFQBi2
         /YqA==
X-Gm-Message-State: AOJu0Yw+ZWwoSdYjh9qLiapzm6++dhfFFtOM521y6XwkM2J17F0fq9kC
        PAgpgYt2ZM+VYYqWO1z4vRk=
X-Google-Smtp-Source: AGHT+IG8v5u1glfIsOlMbXwpIzlNTqHACo4fi2tLfh/TxG/xGwlW2tjOWqfB5SssmaJC5IzWRPLeyg==
X-Received: by 2002:a17:902:efd3:b0:1bf:148b:58ff with SMTP id ja19-20020a170902efd300b001bf148b58ffmr1696100plb.69.1694590668864;
        Wed, 13 Sep 2023 00:37:48 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902eccf00b001bf044dc1a6sm9757434plh.39.2023.09.13.00.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:37:48 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 688EF821F321; Wed, 13 Sep 2023 14:37:46 +0700 (WIB)
Date:   Wed, 13 Sep 2023 14:37:46 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "Teng Wang" <wangteng13@nudt.edu.cn>, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, edumazet@google.com,
        netdev@vger.kernel.org
Subject: Re: Bug: rcu detected stall in sys_nanosleep
Message-ID: <ZQFmyp-cK_ensG_u@debian.me>
References: <13067197.3b9a.18a8d519137.Coremail.wangteng13@nudt.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w0Zxr0zYupWMykcF"
Content-Disposition: inline
In-Reply-To: <13067197.3b9a.18a8d519137.Coremail.wangteng13@nudt.edu.cn>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--w0Zxr0zYupWMykcF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 02:54:07PM +0800, Teng Wang wrote:
> Dear All,
> This bug was found in linux Kernel v6.2.10
>=20
> Syzkaller hit 'INFO: rcu detected stall in sys_nanosleep' bug.

v6.2.y has been EOLed, please reproduce with current mainline (v6.6-rc1).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--w0Zxr0zYupWMykcF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQFmyQAKCRD2uYlJVVFO
oxxNAP9UwsejSNGrmCcyQae/pmO3CSLTtZiG0xFJEQJPUFd3YwD/TH1bP+L3ieT6
TIgoi5A6pzQUqQ8ipI+J5prYDl2xGAw=
=j/Yh
-----END PGP SIGNATURE-----

--w0Zxr0zYupWMykcF--
