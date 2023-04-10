Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578EC6DC341
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Apr 2023 07:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjDJFEk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Apr 2023 01:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJFEj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Apr 2023 01:04:39 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE99C1BEC;
        Sun,  9 Apr 2023 22:04:38 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id c3so4096016pjg.1;
        Sun, 09 Apr 2023 22:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681103078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qQHFYt2aJZKqp/kH+9vd+a1FZT7IPDblBS/9XGkrR1w=;
        b=Si5MedWHjr+8g9JZCHYRxC9v3RfVDQxCbrfrIN38EUh7EKSKsl3Up9693zCR5eSy+w
         bKGrcMA8d7riLHr0an/agE+V9d6xC7WL2IN0GfbjwFKH77GHrS4XXBNCKNAQAe0Nufa+
         Fj2zJP1Kh7z6i1oAn/1YWmIM1IrzbNEm7BpdeAoqYbm0XkGjb3qM84x9wvY5HJPqOuf5
         5E2rpJBFGm0AMkiZVs1bsF169/OzUHo3U75T5UEC2Rab8z94XuuwZvUveulO4AAoYQv1
         usHlt7hGaEsgRFP7Fxr1IPVFdF+tu8TK9uLYNw5vagxXQGNb1RXVwfvsM/AxuFq1L6Sa
         vFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681103078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQHFYt2aJZKqp/kH+9vd+a1FZT7IPDblBS/9XGkrR1w=;
        b=OkYS26ce4NnGONmXTl3MRq+nbPSlp5pmpeSaVNRwww+lsA7IF9Ib8r7oR2rfE2nuEY
         z/g+GLyTdATBf1I9DG46weJ++csgfAxPqlANgLpd1htuFg3Km/pqTNQmryGs2M2aIJxB
         Fky99N56oFqRNJgWYOi/hFYPyrCwc0bW2fZ9dVXyq0r4k+VfyKKJvaOj5Z79xPX1Yjn0
         jhn+izGHLBpJZbLiBeQ6JJ/b3TpKYcTBYhChPUANdVSEkKH3cur74GAZ5zP1MZhuON4J
         QmBU6qFW/RQxuXfkoccM+P4mHUtKV9NEP1Gaqq/XWH6GGhqJCqC/qBK+QpvNPGUtHzxJ
         8nKw==
X-Gm-Message-State: AAQBX9eeVBEjtrgDMeCJcBNOc8G70iLnX++jcpqigMgeirDWV+yUxyC0
        qNYlpeduXALMevwJeVebJJk=
X-Google-Smtp-Source: AKy350aqJFtgeEV56uyaqKYdnoTGInPGu7JKsAgBHcNhoXyLYfiKqDuJ5njdcx9S3d+LCEjVH96vtA==
X-Received: by 2002:a17:90a:3e0e:b0:240:daf9:7ab6 with SMTP id j14-20020a17090a3e0e00b00240daf97ab6mr11091088pjc.40.1681103078146;
        Sun, 09 Apr 2023 22:04:38 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-34.three.co.id. [116.206.28.34])
        by smtp.gmail.com with ESMTPSA id e9-20020a17090ab38900b00246b5a609d2sm538755pjr.27.2023.04.09.22.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 22:04:37 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id F16361067EC; Mon, 10 Apr 2023 12:04:34 +0700 (WIB)
Date:   Mon, 10 Apr 2023 12:04:34 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org,
        kch@nvidia.com, martin.petersen@oracle.com, vkoul@kernel.org,
        ming.lei@redhat.com, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 01/11] documentation: Block Device Filtering Mechanism
Message-ID: <ZDOY4tWY9wjPDb/c@debian.me>
References: <20230404140835.25166-1-sergei.shtepa@veeam.com>
 <20230404140835.25166-2-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1Bs8S2dr+BfN9DpP"
Content-Disposition: inline
In-Reply-To: <20230404140835.25166-2-sergei.shtepa@veeam.com>
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--1Bs8S2dr+BfN9DpP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 04, 2023 at 04:08:25PM +0200, Sergei Shtepa wrote:
> +The filter can be implemented as a loadable module. In this case, module
> +unloading is blocked while the filter is attached to at least one of the=
 block
> +devices.
"In this case, the filter module cannot be unloaded while the filter ..."

The rest is LGTM, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--1Bs8S2dr+BfN9DpP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZDOY4gAKCRD2uYlJVVFO
o+vlAQCwAG7Fr5efYIrir6aoE5yXCLebFDick6uY5l6vXN8Q5AEAnBkZUpUAf0tA
2Egg2ys5Nzy4P5sPVXhgqsA4Kr3L+w4=
=OoWa
-----END PGP SIGNATURE-----

--1Bs8S2dr+BfN9DpP--
