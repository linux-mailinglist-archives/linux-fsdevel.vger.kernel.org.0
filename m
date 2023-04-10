Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EDB6DC339
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Apr 2023 07:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjDJFBM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Apr 2023 01:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJFBL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Apr 2023 01:01:11 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2F93C14;
        Sun,  9 Apr 2023 22:01:09 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2467761d1f4so163374a91.2;
        Sun, 09 Apr 2023 22:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681102869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zsSfEZyj+6Q8d8N54pdQLmL7plXalSHeWulTtzchzEU=;
        b=UNggAa+REmV/mVKgHZrHAhMKAXCg62u4RtbQyigD2xDLlxxzc+mLUZaZ2LSOhO18wH
         ZCb2LWqCgMZF6YIC5uh6ycS5HclDDolef1sLQ67RkOfHhT/xy8LENTizW9auqEWDClzV
         M95euQYdqsKZcvtHSQcLO/3s3izKkHsRNCbBoDYoVOpp7rCGy86gXgRHGnlXy6st/aY4
         pqON9DeYoSqYdQZ0WuRRtgyqxh+5bOWFTNUGTZz00BS09v3QLovne9UAWlh0VE6XKn89
         v0E1Z9sxgysK/59rH7oOddVKtqBrN8Ts/6D4TI2mOxXO1PhHvYMsewRmEW6spGq0VUeC
         MBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681102869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsSfEZyj+6Q8d8N54pdQLmL7plXalSHeWulTtzchzEU=;
        b=AVvvE/QEXcXD7NzJI1u4T7SqrG2mb1VHx+U0zHPFxY7h1webW76GPudVBWhGKuKOsA
         2PRlgfCcl44t3TrxqI+rCR3/HF+20upEGjJHpRGEaFdCh+chAl5URbOgoaLCFAc0Z47a
         2rGnHRk3wNtkMDwZ9dnIzs0UELD6XoQbC6/ZVDCgZZ6Ge1Yx7WFQsRFleJnn8+XviQaZ
         LZ4HcqFa44xvuOe9xeHdyRRphMId/9HNg56fTqv+PFkyucqrs2D9Br2aPXwTrguKkwDa
         8yGmRf1ScozbuBtAjrXGBSnKC1rdyqoJFSIZwI6K8ZAL6xxnD8yW2+2WEg3xiMVC3QEJ
         iURQ==
X-Gm-Message-State: AAQBX9dV95Nbtgrwer2anRJj3IPcmjqErLkWX0pz6gL59STkcZpMEKfK
        CwqeHhyPKQLMHpXuFsvsYmU=
X-Google-Smtp-Source: AKy350Y1RaWC/2Sf5V2Te3MVI4yRXS+LLPRO3v85S9xjoGMlEJgqiYjq7FsgLcnvrdGOY6A1wC0XAw==
X-Received: by 2002:a62:1bd4:0:b0:625:efa4:4c01 with SMTP id b203-20020a621bd4000000b00625efa44c01mr9899878pfb.3.1681102868660;
        Sun, 09 Apr 2023 22:01:08 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-34.three.co.id. [116.206.28.34])
        by smtp.gmail.com with ESMTPSA id s5-20020aa78d45000000b00625037cf695sm3391162pfe.86.2023.04.09.22.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 22:01:08 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 16D161067EC; Mon, 10 Apr 2023 12:01:03 +0700 (WIB)
Date:   Mon, 10 Apr 2023 12:01:03 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org,
        kch@nvidia.com, martin.petersen@oracle.com, vkoul@kernel.org,
        ming.lei@redhat.com, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 03/11] documentation: Block Devices Snapshots Module
Message-ID: <ZDOYD9eehrz9wQBZ@debian.me>
References: <20230404140835.25166-1-sergei.shtepa@veeam.com>
 <20230404140835.25166-4-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3sJxY84NpHVtSyPq"
Content-Disposition: inline
In-Reply-To: <20230404140835.25166-4-sergei.shtepa@veeam.com>
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


--3sJxY84NpHVtSyPq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 04, 2023 at 04:08:27PM +0200, Sergei Shtepa wrote:
> +The main properties that a backup tool should have are:
> +
> +- Simplicity and versatility of use
> +- Reliability
> +- Minimal consumption of system resources during backup
> +- Minimal time required for recovery or replication of the entire system
> +
> +Therefore, the features of the blksnap module are:
"Taking above properties into account, blksnap module features:"

> +The change tracker allows to determine which blocks were changed during =
the
> +time between the last snapshot created and any of the previous snapshots.
> +Having a map of changes, it is enough to copy only the changed blocks, a=
nd
"With a map of changes, ..."

> +3. ``blkfilter_ctl_blksnap_cbtdirty`` mark blocks as changed in the chan=
ge
                                         marks

> +The blksnap [#userspace_tools]_ console tool allows to control the module
> +from the command line. The tool contains detailed built-in help. To get
> +the list of commands, enter the ``blksnap --help`` command. The ``blksnap
> +<command name> --help`` command allows to get detailed information about=
 the
"To get list of commands with usage description, see ``blksnap --help``."

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--3sJxY84NpHVtSyPq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZDOYCwAKCRD2uYlJVVFO
owIAAQCShKPGI3iVP2p11Jwxc8bI7plcI7SwlEpil85rz3HhEQD/fQEb1kgmjR1S
yYd0nwhnho3eR9QaNG8wgBxpYwu3jQ0=
=PoLi
-----END PGP SIGNATURE-----

--3sJxY84NpHVtSyPq--
