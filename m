Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B8257830C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 15:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbiGRND7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 09:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbiGRND6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:03:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00F52623
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 06:03:56 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m16so15138092edb.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 06:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zM3JzhRssik7POz7o5zHEQmq3nlUbfeSo9DWVPrJQK0=;
        b=uyNTCGd5YUjRh25MM8MbjG2pfHd13DW9QxeLHwxPdMr/HplpVZnizhjdh/UcRb6tBB
         fCUS2xYCqMnKffsyN9BJAVAtVbr0FHNTDXh3MN1iUUIxO+4PWQzLGO+xuzHr+n8ucgVw
         l/xOxeJ9yuI8bUIPGD+weacTDu7ZBXxmPyyLqXglJEiaAw30JHtpgT2rs48ex4eqBXZz
         6f3lFWK50iQfYcPT7KeLfknMMuMWeVFqDd3UIIBkhTS/uK30mDX28V7wjxGctX7CL7fY
         tjew/FkcwCaTXMZwnau7VLfG8lkLAZaM3/znyOtX363b/HY2ggAG/e1o2SIqbrh7G2tM
         m6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zM3JzhRssik7POz7o5zHEQmq3nlUbfeSo9DWVPrJQK0=;
        b=vWzi5yYieZLNXKJf/YGbE8LXadBsleAaNT0UYi6H/uwvSPGT2C3+1OQnzwFwyAhws5
         +H+8UdeFURTFVeANaa5cSN+lGOSaDZ3+wpX4r/9JGppojvke1EfDYkMTV49kBIqroKZn
         wuz9JGVwc11tfx24LNQ1MbqMYPISGNwgWhmhqpG0gdxh09kORMrqA1qfTpA/jAhue8St
         sdr+ceiS2uQAKEUQe9aMNr44MQmjMUeqqfMXYm96ypgo1caaXxLfLi60TGgvxMknaCbZ
         TU4hoXKxtPYnT5pDIosZFgcXJekCKlEG2i3dtt1Obk05wuW4ldghuqBZvFSjd0FpBulH
         UyGw==
X-Gm-Message-State: AJIora+i4knsulXYzoUyi7hkQlZu3NFaI1Kgb84Qj4U0trsH52zChO5l
        mC+T1wfHBoumuapmeXzJVcDMSw==
X-Google-Smtp-Source: AGRyM1sGi7hDRHgbtbQ1r4bhDDCZKOUJkCZ0vIKaczfxZ3PORpdqu17Jsa5awBE4iVj+SejJfaQlNw==
X-Received: by 2002:a05:6402:12d8:b0:43a:6a70:9039 with SMTP id k24-20020a05640212d800b0043a6a709039mr37051772edx.379.1658149435052;
        Mon, 18 Jul 2022 06:03:55 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id g21-20020a1709061e1500b00722f8d02928sm5555089ejj.174.2022.07.18.06.03.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2022 06:03:54 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH] [REGRESSION] ovl: Handle ENOSYS when fileattr support is
 missing in lower/upper fs
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <CAJfpeguDAJpLMABsomBFQ=w6Li0=sBW0bFyALv4EJrAmR2BkpQ@mail.gmail.com>
Date:   Mon, 18 Jul 2022 15:03:52 +0200
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A31096BA-C128-4D0B-B27D-C34560844ED0@kohlschutter.com>
References: <4B9D76D5-C794-4A49-A76F-3D4C10385EE0@kohlschutter.com>
 <CAJfpegs1Kta-HcikDGFt4=fa_LDttCeRmffKhUjWLr=DxzXg-A@mail.gmail.com>
 <83A29F9C-1A91-4753-953A-0C98E8A9832C@kohlschutter.com>
 <CAJfpegv5W0CycWCc2-kcn4=UVqk1hP7KrvBpzXHwW-Nmkjx8zA@mail.gmail.com>
 <FFA26FD1-60EF-457E-B914-E1978CCC7B57@kohlschutter.com>
 <CAJfpeguDAJpLMABsomBFQ=w6Li0=sBW0bFyALv4EJrAmR2BkpQ@mail.gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, torvalds@linux-foundation.org
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 18.07.2022 um 14:21 schrieb Miklos Szeredi <miklos@szeredi.hu>:
>=20
> On Mon, 18 Jul 2022 at 12:56, Christian Kohlsch=C3=BCtter
> <christian@kohlschutter.com> wrote:
>=20
>> However, users of fuse that have no business with overlayfs suddenly =
see their ioctl return ENOTTY instead of ENOSYS.
>=20
> And returning ENOTTY is the correct behavior.  See this comment in
> <asm-generic/errrno.h>:
>=20
> /*
> * This error code is special: arch syscall entry code will return
> * -ENOSYS if users try to call a syscall that doesn't exist.  To keep
> * failures of syscalls that really do exist distinguishable from
> * failures due to attempts to use a nonexistent syscall, syscall
> * implementations should refrain from returning -ENOSYS.
> */
> #define ENOSYS 38 /* Invalid system call number */
>=20
> Thanks,
> Miklos

That ship is sailed since ENOSYS was returned to user-space for the =
first time.

It reminds me a bit of Linus' "we do not break userspace" email from =
2012 [1, 2], where Linus wrote:
> Applications *do* care about error return values. There's no way in
> hell you can willy-nilly just change them. And if you do change them,
> and applications break, there is no way in hell you can then blame the
> application.

(Adding Linus for clarification whether his statement is still true in =
2022, and marking subject with regression tag for visibility.)

As far as I, a fuse user, understand, fuse uses ENOSYS as a specific =
marker to indicate permanent failure:

=46rom libfuse =
https://libfuse.github.io/doxygen/structfuse__lowlevel__ops.html:
> If this request is answered with an error code of ENOSYS, this is =
treated as a permanent failure with error code EOPNOTSUPP, i.e. all =
future getxattr() requests will fail with EOPNOTSUPP without being send =
to the filesystem process.

(also see  https://man.openbsd.org/fuse_new.3)


Again, in summary:
1. I believe the fix should be in ovl, because ovl caused the =
regression.
2. Fixing in fuse would not be sufficient because other lower =
filesystems that also return ENOSYS remain affected (a cursory search =
indicates ecryptfs also returns ENOSYS).
3. Fixing in fuse would break user-space. We do not break userspace.

Cheers,
Christian



[1] https://lkml.org/lkml/2012/12/23/75
[2] https://lkml.org/lkml/2012/12/23/99=
