Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188BE578A46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 21:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbiGRTEG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 15:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGRTEF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:04:05 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072A2BE08
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 12:04:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ez10so22987370ejc.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 12:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JVQkrHrxRPCr+Ny6+I5UlfzO4AFjF6Jn/5OvpVMOOxQ=;
        b=QKXxX5CURyVIGNN6i4XmcpMLtnldrmvr5YjWQGZHgGPon+K+ndKqHH83of1l5r1ZT6
         dmyeXAa2EmL+UCMg1f78d2DdXlMV7XDtVC2UM8kMa07bP1CxJJbnB7wmppZWvG0hQ3Cg
         UG4P6ONn51+TpC2C1wOCDbc+yCwrhNVuEW0a1Mkx0fmWkwj8WNlZQfk72ZOuhMbhABjF
         otPkaoZ1qk87xQMvhnSk3Zr5R1JjIV43IxWw0JYE37yDwy+XLFfmm/RQOHuLhlE8Ibce
         U15ZOdH+w2XKnCmm5l6NxQm11Vl6bUClyekWHILQBAMX+XoPnzAL4v7wkeuimJpUhiuF
         NRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JVQkrHrxRPCr+Ny6+I5UlfzO4AFjF6Jn/5OvpVMOOxQ=;
        b=Y6iH9LGuTGxjc+/4nerpB9KMGsR+Kj65wUSZfojMaxx76yQN2LMJ0wZpF+Ouvf22OE
         S/BaVFRmFFgizkI2kVEMje1A2KVOJ2ewYnxj7hKwjmBfRLzjVenK1gjvIcyZRZYRKJqw
         UYqSXoVpio+tcq7VUDkdCqyowLqzMyjf1x4rUP1EBFmN7MstYuPaCzU1UqFRGPYe24ej
         FuvOJp0tnFB3wxxJE8riZzbHkqKSY2ZG1p80ceCpWL2+VYzwccTLR+3QcMImcrpYLpxy
         5SKUvS2zK6Zd5mhJgrF5VZlr7q4H8rxi0JTR839AHZq7QoFEqqismMF1hZrq5dYd1Y8l
         xIHQ==
X-Gm-Message-State: AJIora+Xj0uZ87Y1vVMSyA7/UsTG2BiV5XZxojMUisuKbbd8cf0Ks9Te
        E+yiKneufxL69KM0yunaPyaxnw==
X-Google-Smtp-Source: AGRyM1uhpvTfV3iUPA04+PrxIHqKrVNfEC5+/WcT3cTJ6gdWOA6GHQ5RbM9juCSW9jT5HRVCF+lWoA==
X-Received: by 2002:a17:907:9809:b0:72f:817:d433 with SMTP id ji9-20020a170907980900b0072f0817d433mr14202383ejc.483.1658171042458;
        Mon, 18 Jul 2022 12:04:02 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id n8-20020a170906378800b00705976bcd01sm5765658ejc.206.2022.07.18.12.04.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2022 12:04:01 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH] [REGRESSION] ovl: Handle ENOSYS when fileattr support is
 missing in lower/upper fs
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <CAHk-=wjg+xyBwMpQwLx_QWPY7Qf8gUOVek8rXdQccukDyVmE+w@mail.gmail.com>
Date:   Mon, 18 Jul 2022 21:04:00 +0200
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EE5E5841-3561-4530-8813-95C16A36D94A@kohlschutter.com>
References: <4B9D76D5-C794-4A49-A76F-3D4C10385EE0@kohlschutter.com>
 <CAJfpegs1Kta-HcikDGFt4=fa_LDttCeRmffKhUjWLr=DxzXg-A@mail.gmail.com>
 <83A29F9C-1A91-4753-953A-0C98E8A9832C@kohlschutter.com>
 <CAJfpegv5W0CycWCc2-kcn4=UVqk1hP7KrvBpzXHwW-Nmkjx8zA@mail.gmail.com>
 <FFA26FD1-60EF-457E-B914-E1978CCC7B57@kohlschutter.com>
 <CAJfpeguDAJpLMABsomBFQ=w6Li0=sBW0bFyALv4EJrAmR2BkpQ@mail.gmail.com>
 <A31096BA-C128-4D0B-B27D-C34560844ED0@kohlschutter.com>
 <CAJfpegvBSCQwkCv=5LJDx1LRCN_ztTh9VMvrTbCyt0zf7W2trw@mail.gmail.com>
 <CAHk-=wjg+xyBwMpQwLx_QWPY7Qf8gUOVek8rXdQccukDyVmE+w@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 18.07.2022 um 20:29 schrieb Linus Torvalds =
<torvalds@linux-foundation.org>:
>=20
> On Mon, Jul 18, 2022 at 6:13 AM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>>=20
>> Correct.  The question is whether any application would break in this
>> case.  I think not, but you are free to prove otherwise.
>=20
> Most often, an error is "just an error", and most applications usually
> won't care.
>=20
> There are exceptions: some errors are very much "do something special"
> (eg EAGAIN or EINTR _are_ often separately tested for and often mean
> "just retry"). And permission error handling is often different from
> EINVAL etc.
>=20
> And ENOSYS can easily be such an error - people probing whether they
> are running on a new kernel that supports a new system call or not.
>=20
> And yeah, some of our ioctl's are odd, and we have a lot of drivers
> (and driver infrastructure) that basically does "this device does not
> support this ioctl, so return ENOSYS".
>=20
> I don't think that's the right thing to do, but I think it's
> understandable. The traditional error for "this device does not
> support this ioctl" is ENOTTY, which sounds so crazy to non-tty people
> that I understand why people have used ENOSYS instead.
>=20
> It's sad that it's called "ENOTTY" and some (at least historical)
> strerror() implementations will indeed return "Not a tty". Never mind
> that modern ones will say "inappropriate ioctl for device" - even when
> the string has been updated, the error number isn't called
> EINAPPROPRAITEDEVICE.
>=20
> But it is what it is, and so I think ENOTTY is understandably not used
> in many situations just because it's such a senseless historical name.
>=20
> And so if people don't use ENOSYS, they use EINVAL.
>=20
> I *suspect* no application cares: partly because ioctl error numbers
> are so random anyway, but also very much if this is a "without
> overlayfs it does X, with overlayfs it does Y".
>=20
> The sanest thing to do is likely to make ovl match what a non-ovl
> setup would do in the same situation (_either_ of the overlaid
> filesystems - there might be multiple cases).
>=20
> But I'm missing the original report. It sounds like there was a
> regression and we already have a case of "changing the error number
> broke something". If so, that regression should be fixed.
>=20
> In general, I'm perfectly happy with people fixing error numbers and
> changing them.
>=20
> The only thing I require is that if those cleanups and fixes are
> reported to break something, people quickly revert (and preferably add
> a big comment about "Use *this* error number, because while this
> *other* error number would make sense, application XyZ expects AbC"..)
>=20
>             Linus

Thanks for clarifying, Linus!

The regression in question caused overlayfs to erroneously return ENOSYS =
when one lower filesystem (e.g., davfs2) returned this upon checking =
extended attributes (there were two relevant submissions triggering this =
somewhere around 5.15, 5.16)

My original patch: =
https://lore.kernel.org/lkml/4B9D76D5-C794-4A49-A76F-3D4C10385EE0@kohlschu=
tter.com/T/

This was supposed to augment the following commit:
=
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3D5b0a414d06c3ed2097e32ef7944a4abb644b89bd

There, checking for the exact error code indeed matters, because it is =
supposed to swallow all conditions marking "no fileattr support" but =
doesn't catch fuse's ENOSYS.

You see similar code checking for ENOSYS appearing in other places, like =
util-linux, for example
here =
https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=3D=
f6385a6adeea6be255d68016977c5dd5eaab05da
and there's of course EOPNOTSUPP as well, as in here =
https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=3D=
7b8fda2e8e7b1752cba1fab01d7f569b5d87e661

Best,
Christian

