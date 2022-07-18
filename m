Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499A857854D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 16:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbiGROZd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 10:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbiGROZb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:25:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F50026FC
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 07:25:30 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ss3so21500611ejc.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 07:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b6t/+N1+W4VgPAXHp/M2TXDSX6kb6MT08vG4t3aPV7Y=;
        b=hYqn7R98IMdzc6HipEjUlR51NKcNaoBacjkT3TcxcxIuRdjAYzqdTrAGx0rFsnqUSI
         TpsrZra4NWPfmdWwtUK1aDzL22O+cymCz6OvXo4T8Cp/D5ai3DOi+/t3GMnjpUKqZL62
         j0HDmQc9IrLr1T2+YJreGR7BCgpandjjF8U+qRG5AlRFnzk385HkT2K0GyuPxDEMDPe4
         bbBf4EOHNRy6rMmtvs9btboFHvlTYQK778xevsYj2hY4UiRyFUpIFX1wHOf0fCPQO1qE
         fDmLydJk0lZl+80aSxdi2cIB61U3e33zYpCNr2LoKYBx408ckXRPDXZn/m33w0xsdyMY
         YMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b6t/+N1+W4VgPAXHp/M2TXDSX6kb6MT08vG4t3aPV7Y=;
        b=IzXAPpY4c56KSIhe3gKZ2VdNJqKdgT8RIjqumUu+4eEklLIGsUrEKNCDlf2h2TXWw2
         MBOAoxBuRCq2xcm9PZii/KFHRpKkLCfQ8yOOt+fInYSr5RbRxdJdsOM3i/qP7aL9JocQ
         BuXanI1W86lKEqnKMm/X16N1mxI+/vf2mFOB4xOgR7TyE1gDZqertmkbpLxv3Zuk2ic+
         nFOuuisbj3IDCg4OwhylSUae9UgSF5VvsyqjyZtvlDi9i2OcKgDfole46xIsDbzWEacD
         rf4yH1YzCI3QgnP5D6AI8Oa0vrBl1CQOPaBa+SJnM7O7SjAUtGxUV13b019UjeHx0r1+
         sLuA==
X-Gm-Message-State: AJIora96PPR8TtW++TvJH2TUUj4nOVCvmqtiAmuejPEACKJnNLfuswiE
        ydrjMYHP/0OAtb/0dl9f3iSnrA==
X-Google-Smtp-Source: AGRyM1s3YCiSLu6Q+lwm6jJZnCAwBaMfFoNhVeKfCxoPL6URn0nvMrdPHNss2DkgRYaK39HWt1g24w==
X-Received: by 2002:a17:906:5d08:b0:6ff:8ed:db63 with SMTP id g8-20020a1709065d0800b006ff08eddb63mr26256399ejt.408.1658154328599;
        Mon, 18 Jul 2022 07:25:28 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id eg52-20020a05640228b400b0043a6fde6e7bsm8533243edb.19.2022.07.18.07.25.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2022 07:25:28 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH] [REGRESSION] ovl: Handle ENOSYS when fileattr support is
 missing in lower/upper fs
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <CAJfpegvBSCQwkCv=5LJDx1LRCN_ztTh9VMvrTbCyt0zf7W2trw@mail.gmail.com>
Date:   Mon, 18 Jul 2022 16:25:26 +0200
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0B8DA307-7E1F-4534-B864-BC2632740C89@kohlschutter.com>
References: <4B9D76D5-C794-4A49-A76F-3D4C10385EE0@kohlschutter.com>
 <CAJfpegs1Kta-HcikDGFt4=fa_LDttCeRmffKhUjWLr=DxzXg-A@mail.gmail.com>
 <83A29F9C-1A91-4753-953A-0C98E8A9832C@kohlschutter.com>
 <CAJfpegv5W0CycWCc2-kcn4=UVqk1hP7KrvBpzXHwW-Nmkjx8zA@mail.gmail.com>
 <FFA26FD1-60EF-457E-B914-E1978CCC7B57@kohlschutter.com>
 <CAJfpeguDAJpLMABsomBFQ=w6Li0=sBW0bFyALv4EJrAmR2BkpQ@mail.gmail.com>
 <A31096BA-C128-4D0B-B27D-C34560844ED0@kohlschutter.com>
 <CAJfpegvBSCQwkCv=5LJDx1LRCN_ztTh9VMvrTbCyt0zf7W2trw@mail.gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Am 18.07.2022 um 15:13 schrieb Miklos Szeredi <miklos@szeredi.hu>:
>=20
> On Mon, 18 Jul 2022 at 15:03, Christian Kohlsch=C3=BCtter
> <christian@kohlschutter.com> wrote:
>>=20
>> Am 18.07.2022 um 14:21 schrieb Miklos Szeredi <miklos@szeredi.hu>:
>>>=20
>>> On Mon, 18 Jul 2022 at 12:56, Christian Kohlsch=C3=BCtter
>>> <christian@kohlschutter.com> wrote:
>>>=20
>>>> However, users of fuse that have no business with overlayfs =
suddenly see their ioctl return ENOTTY instead of ENOSYS.
>>>=20
>>> And returning ENOTTY is the correct behavior.  See this comment in
>>> <asm-generic/errrno.h>:
>>>=20
>>> /*
>>> * This error code is special: arch syscall entry code will return
>>> * -ENOSYS if users try to call a syscall that doesn't exist.  To =
keep
>>> * failures of syscalls that really do exist distinguishable from
>>> * failures due to attempts to use a nonexistent syscall, syscall
>>> * implementations should refrain from returning -ENOSYS.
>>> */
>>> #define ENOSYS 38 /* Invalid system call number */
>>>=20
>>> Thanks,
>>> Miklos
>>=20
>> That ship is sailed since ENOSYS was returned to user-space for the =
first time.
>>=20
>> It reminds me a bit of Linus' "we do not break userspace" email from =
2012 [1, 2], where Linus wrote:
>>> Applications *do* care about error return values. There's no way in
>>> hell you can willy-nilly just change them. And if you do change =
them,
>>> and applications break, there is no way in hell you can then blame =
the
>>> application.
>=20
> Correct.  The question is whether any application would break in this
> case.  I think not, but you are free to prove otherwise.
>=20
> Thanks,
> Miklos

I'm not going to do that since I expect any answer I give would not =
change your position here. All I know is there is a non-zero chance such =
programs exist.

If you're willing to go ahead with the fuse change you proposed, I see =
no purpose in debating with you further since you're the kernel =
maintainer of both file systems.
That change "fixes" the problem that I had seen in my setup; I do not =
know the extent of side effects, but I expect some could surface =
eventually.

Once you're done fixing fuse, please also talk to the folks over at =
https://github.com/trapexit/mergerfs who explicitly return ENOSYS upon =
request. Who knows, maybe someone is audacious enough to try mergerfs as =
a lower filesystem for overlay?

Alas, I think this a clash between the philosophies of writing robust =
code versus writing against a personal interpretation of some =
specification.
You refer to "asm-generic/errno.h" as the specification and rationale =
for treating ENOSYS as sacrosanct. Note that the comment says "should =
refrain from", it doesn't say "must not", and that's why we're in this =
mess.

It therefore wouldn't hurt to be lenient when a lower filesystem returns =
an error code known to refer to "unsupported operation", and that's what =
my original patch to ovl does.

I thought this approach would resonate with you, since you must have =
been following the same logic when you added the special-case check for =
"EINVAL" as an exception for ntfs-3g in the commit that most likely =
triggered the regression ("ovl: fix filattr copy-up failure") 9 months =
ago.

I honestly wonder why you're risking further breakage, having introduced =
that regression only recently.

So long,
Christian

