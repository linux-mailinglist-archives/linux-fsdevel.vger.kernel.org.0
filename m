Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F14B234C12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 22:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgGaUSq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 16:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbgGaUSp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 16:18:45 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFD8C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2020 13:18:45 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id v6so17628382iow.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2020 13:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=B2TF1ffdPSO7uW3sFl++Y0S3B01EUc1/65nVQ0Oovr8=;
        b=AFw9o3XhditiNNNw+LVqDWvJIGg51sRVIHhF2ovYMJaqUieJGjdLhwTGW49u/QdYaz
         iuxBXMVM9SNN3NLkMBm96+OQRkTCiCDwt2dVjSq97t2V/poRIVM6XgAF260fY9PcHRIV
         WQcvKthHnNvPQViZ5fdZiFyu7Oluw6DMq8fsOkvsfCrzw8pGHTxgSIrv6Wiaqj1CcI81
         UWuaNvC8/6/NJZ2Nn7Z61gdiTxU5BMKKHYNUArxB/sRN5sgaI3iE9MWvisRpIvP6tX72
         1qVIEaI1MoUbh4RmvljEUi5lPRZPvTKeWPPIDVSWJWRO2CtFzC6ALp/Wgf+B72wmcZ9T
         NxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=B2TF1ffdPSO7uW3sFl++Y0S3B01EUc1/65nVQ0Oovr8=;
        b=gkIkaNk1Ayx6Kq4MysewyS58Rk/MEdvUrvFJ7HB7dkWpdxcFvRg91uEsX2ulPwrDpl
         V6ZnCChUj0BYVGadM3Iq8aHMq1dB1sH+BbEXU5M/8+NUbC6QGhzXKedM0KP0szvqsgPz
         8LXCi600Vz+VWUpcbJLiDXtO5wFGoTPRh4v0fK6R/MlQNQ8Ilp5QSgvk2argvLMxMkgJ
         CHEiG3ufI/xrjVRl/COo7fAgVv3cHyq5Od+LDoC752etEjR+NplDlymzgVDdE+6Ls94L
         EPPQfYm6Kp7sPefSQP62l7y/w2yGFYH4/zh/PWVDEBVdZywSzFu6tOz5yaOxRWq6Oo6a
         QffQ==
X-Gm-Message-State: AOAM532PXaUfSoAFOHl9lFAOuCs9Z9dBTugKA1Sf7p6qmp+iNuDMA6QJ
        nVWCYZhzVs3lGhCMpICB0Wdv4BHHXgdNuLwGhQt9/wmzSmI=
X-Google-Smtp-Source: ABdhPJwgrDQgcss2Udl7XHMaOk7HbeMGacQG+AfIF9nW3jK6Vr6qoYS4FLvsW1xt/b8gJ1t2QA0M4qTPqzvES5r9PUg=
X-Received: by 2002:a05:6602:2d43:: with SMTP id d3mr3613076iow.39.1596226721794;
 Fri, 31 Jul 2020 13:18:41 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?Q8Opc2FyIERI?= <cesardhg@gmail.com>
Date:   Fri, 31 Jul 2020 13:18:30 -0700
Message-ID: <CAMj1_kTBDmGgSYPhxThFAr7vO4faSuHz8TwjVrPtXpLN0sRBKg@mail.gmail.com>
Subject: Device "minor overflow" behavior differences in register_chrdev_region
 vs alloc_chrdev_region
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I tried my best to be concise. It's my first time reaching out to a
maintainer so if this is not the proper channel for this type of thing
please correct me.

I'm trying to learn about device drivers from
https://lwn.net/Kernel/LDD3/, and  I read that a large-enough
requested minor range might spill over to the next major number when
using register_chrdev_region (chapter 3 page 45)

I decided to verify this claim on a toy module (basic c sample module
and makefile):
https://github.com/cdhg/module-minor-spill

The code requests 2 devices starting from the last available minor,
which overflows by one.
The module will use alloc_chrdev_region or register_chrdev_region
depending on whether 'alloc' was #defined.

register_chrdev_region just works, and I can see two major entries in
/proc/devices for "mydevice" (with the code above, that would be
majors 400 and 401 if available). The unregister code cleanly removes
those two entries as well.

alloc_chrdev_region, however, fails on my recent (5.4) kernel with:
CHRDEV "mydevice" minor range requested (1048575-1048576) is out of
range of maximum range (0-1048575) for a single major

Which led me to this patch from just last year:
https://lore.kernel.org/patchwork/patch/1042784/

If I'm reading this correctly, the patch claims that
register_chrdev_region was already doing such a check, so it would
make sense to add the same check to alloc_chrdev_region via
__register_chrdev_region.

But register_chrdev_region seems to handle this cleanly, as the book
I'm reading suggests. I don't understand why alloc_chrdev_region was
modified to fail then.

I tried on an earlier kernel (4.19) that I believe doesn't have this
patch, and the same call to alloc_chrdev_region succeeded. However, I
did notice only one major appears on /proc/devices and that
unregistering does not seem to make the entry go away. So perhaps that
was already broken in another way?

Are these differences in behavior intentional? It almost seems like
the above patch introduced a bug (or partially fixed an older bug) but
I suppose it's likely that I just misunderstand something. I also
suppose nobody's exercising the overflowing behavior so it's likely
nobody has cared even if it was a real bug. At least the current
behavior fails which seems cleaner than passing and not letting me
unregister later. But register_chrdev_region just works everywhere, so
this felt like a bug. I wasn't able to find any reports about this
either.

Thanks,
-Cesar
