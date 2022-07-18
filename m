Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDE8578842
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 19:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbiGRRXc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 13:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiGRRX0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:23:26 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DD022BD3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 10:23:23 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t3so16310455edd.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 10:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MAzbnCgjnmjGdJLTmbDYeaZT5j7tzpua2sYTo2S3JIs=;
        b=ghvlzDLFD/7thDNRuiKzgDe/7LH9RUzr2nJ4LWTn7/fxiCEt+xIAlCvSCnhQilCyR+
         iaIF9BHdU2G+XCFE3ZtO2ZLrJjcxSDrPfpCBzb0HhI1aDacoXi9ft7Lxe1PlQGrOzFgU
         O3yIzBIWLmEwOsOqBQnDx6yvr4Xzzid/3/jYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MAzbnCgjnmjGdJLTmbDYeaZT5j7tzpua2sYTo2S3JIs=;
        b=2YGoUQVZpzZDKa4t0C5syLf/6xIyU62lX8qpFlfjei8WqxZrBUFLTg1u6y8K36Z5KI
         a1ohxwZTZvKn7nWwsGDw9dFuzFMQHMW4dYIaUFdkLLR5uGCpumIand8aOoSUEYHbjU5d
         2+qex8Ml6fVblv73e3t6BjzoB3LQbdkWfYNgELDRkVs95Tc5vYj4qy2EIVICulqKkm4I
         mmvH1OsEphCnPCpngA4YmHe4duJiv4Mk35W6FDAIS7esbYDj7uAqmQBN1fOnFmXOq96W
         nIPoxYoMfl2TGpdhyvyY64GYe6yMvv2ruy7Y+w9PStxFYpgq7gW/xk6AV9yC7UsR5x9X
         pK+g==
X-Gm-Message-State: AJIora/ZQUEMI9/YY5Gq0b3oTHgVP0fYSIXdl82G1nrSXYaf2vzL4sD0
        GZKgZq43op2Jd8qE4BNco2HW1S8hsoFgCAZuadjKRQ==
X-Google-Smtp-Source: AGRyM1t5heBaBFikkxY3Q00aCdQvYmdcxn6Sx2J9LFDH3DkhXSP+kj5YqJYP+w+XhiDApUNtBD7mcOznLG4ulTg3ST4=
X-Received: by 2002:a05:6402:2b8d:b0:43a:5410:a9fc with SMTP id
 fj13-20020a0564022b8d00b0043a5410a9fcmr39033797edb.99.1658165002192; Mon, 18
 Jul 2022 10:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <4B9D76D5-C794-4A49-A76F-3D4C10385EE0@kohlschutter.com>
 <CAJfpegs1Kta-HcikDGFt4=fa_LDttCeRmffKhUjWLr=DxzXg-A@mail.gmail.com>
 <83A29F9C-1A91-4753-953A-0C98E8A9832C@kohlschutter.com> <CAJfpegv5W0CycWCc2-kcn4=UVqk1hP7KrvBpzXHwW-Nmkjx8zA@mail.gmail.com>
 <FFA26FD1-60EF-457E-B914-E1978CCC7B57@kohlschutter.com> <CAJfpeguDAJpLMABsomBFQ=w6Li0=sBW0bFyALv4EJrAmR2BkpQ@mail.gmail.com>
 <A31096BA-C128-4D0B-B27D-C34560844ED0@kohlschutter.com> <CAJfpegvBSCQwkCv=5LJDx1LRCN_ztTh9VMvrTbCyt0zf7W2trw@mail.gmail.com>
 <0B8DA307-7E1F-4534-B864-BC2632740C89@kohlschutter.com>
In-Reply-To: <0B8DA307-7E1F-4534-B864-BC2632740C89@kohlschutter.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 Jul 2022 19:23:11 +0200
Message-ID: <CAJfpegvaUyCUkucNwP0P419hC8v78PEM25pW5mBho94HRCgO3Q@mail.gmail.com>
Subject: Re: [PATCH] [REGRESSION] ovl: Handle ENOSYS when fileattr support is
 missing in lower/upper fs
To:     =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 18 Jul 2022 at 16:25, Christian Kohlsch=C3=BCtter
<christian@kohlschutter.com> wrote:
>
> > Am 18.07.2022 um 15:13 schrieb Miklos Szeredi <miklos@szeredi.hu>:

> > Correct.  The question is whether any application would break in this
> > case.  I think not, but you are free to prove otherwise.
> >
> > Thanks,
> > Miklos
>
> I'm not going to do that since I expect any answer I give would not chang=
e your position here. All I know is there is a non-zero chance such program=
s exist.

If you (or anyone) gave a real life example of an application relying
on e.g. ioctl(..., FS_IOC_SETFLAGS) returning ENOSYS, then I would
have no choice but to revert this change.

However I think that's highly unlikely given that such an application
would only have been tested on fuse filesystems and also given that
very few (if any) fuse filesystems support these ioctls in the first
place.

Thanks,
Miklos
