Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A9E2CD3D6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 11:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388817AbgLCKh3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 05:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387840AbgLCKh2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:37:28 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C08C061A4D;
        Thu,  3 Dec 2020 02:36:48 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id r17so1414818ilo.11;
        Thu, 03 Dec 2020 02:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=72F4Oqs3uIZR2eL33HVP9YTx+wl1uEHEUtfPbPSzE8Y=;
        b=Kxu2WnD2UkI206kxowyiCJvpo+Jl8+sTAnwqlgOO4tX5fM2VSMdv/ryA1M3Ilj+TJR
         1L1ibLRFEQfh9JNuHmrFZwwWOIDigwvfmptm7jEltH0Nm4v4ecVE5oBID3c6HDqCBcGL
         vFLDJu0PbOe3oRBZGE0DaVt2sD7iFSZ46r+0JsNv5eqhBbjbybX3DyAwRU3hJllzZOxF
         Z7lQWsnPJgFyVXlqvaNHnjPQXEp+arO4oBP/xq40WkxAAfoAqhynQi4JdgFEJEmVHmUp
         lnuhBLsI60mzNt0/gFohPdCfDFj4UG5GyXg1YK68GarIYnVKY/CAAaBn2q44Ua7mFq5X
         AhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=72F4Oqs3uIZR2eL33HVP9YTx+wl1uEHEUtfPbPSzE8Y=;
        b=rRBY54m0Qt2/zoYJemVS83zZQmHHpMFblHH0OqddRGOBytbmzCsruWktRPLkQEPdcE
         0xjVKPp4Qnu947Vk24oq+OQyJrUa8COk9aYLm8ViusMNsW76xunhwXemss77UtudjttM
         a73+kpF3Kg2i/Ke/TbhibeLWCJIoqplirjC5mFVLUYseB1yLhOCueRZOPqoOupmKYozW
         hFog76T53jfB3pPioWNY0qHu0T45EA3autP7qT3QDHYfmHHKUUyg0BjSRVJ7nWrxupdb
         byYGq/7CIQWrG5TPUvvY0YpTADc20Y1eDk/x0E1QdIGLuHM1aH584r0Vy3bPzyFzm4I4
         zMwA==
X-Gm-Message-State: AOAM532m9TZL/JTh6jAeztp+0VgpMq3AVerQr+62m8MbIEdSopE67BPc
        BpbKjvaxR1kfdHkettU9iGeB8GHwJwM3HAx9sVGrfoAtRGQ=
X-Google-Smtp-Source: ABdhPJxldYFt8VB/Fb6j2OJaqocIup4wl0aecxSWvfz9Ylh3Q+3SfIpc+uclNn3wPkknk3HxH2nbdHsWLOIp5p56KbM=
X-Received: by 2002:a05:6e02:14ce:: with SMTP id o14mr2463823ilk.9.1606991807424;
 Thu, 03 Dec 2020 02:36:47 -0800 (PST)
MIME-Version: 1.0
References: <20201202092720.41522-1-sargun@sargun.me> <20201202150747.GB147783@redhat.com>
 <f2fc7d688417a1da3d94e819afed6bab404da51f.camel@redhat.com>
 <20201202172906.GE147783@redhat.com> <20201202184936.GA17139@ircssh-2.c.rugged-nimbus-611.internal>
In-Reply-To: <20201202184936.GA17139@ircssh-2.c.rugged-nimbus-611.internal>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 3 Dec 2020 12:36:36 +0200
Message-ID: <CAOQ4uxjVvh3b=V=saA96i4U2E=tZWBxH_JJL-HcrfTomSx-hFA@mail.gmail.com>
Subject: Re: [PATCH] overlay: Implement volatile-specific fsync error behaviour
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > > How did you finally end up testing the error case. Want to simualate
> > > > error aritificially and test it.
> > > >
>
> I used the blockdev error injection layer. It only works with ext2, because
> ext4 (and other filesystems) will error and go into readonly.
>
> dd if=/dev/zero of=/tmp/loop bs=1M count=100
> losetup /dev/loop8 /tmp/loop
> mkfs.ext2 /dev/loop8
> mount -o errors=continue /dev/loop8 /mnt/loop/
> mkdir -p /mnt/loop/{upperdir,workdir}
> mount -t overlay -o volatile,index=off,lowerdir=/root/lowerdir,upperdir=/mnt/loop/upperdir,workdir=/mnt/loop/workdir none /mnt/foo/
> echo 1 > /sys/block/loop8/make-it-fail
> echo 100 > /sys/kernel/debug/fail_make_request/probability
> echo 1 > /sys/kernel/debug/fail_make_request/times
> dd if=/dev/zero of=/mnt/foo/zero bs=1M count=1
> sync
>
> I tried to get XFS tests working, but I was unable to get a simpler repro than
> above. This is also easy enough to do with a simple kernel module. Maybe it'd be
> neat to be able to inject in errseq increments via the fault injection API one
> day? I have no idea what the VFS's approach here is.
>

Here you go. A simple xfstest:

https://github.com/amir73il/xfstests/commits/ovl-volatile

It passes with check -overlay on xfs/ext4 and it fails if you uncomment
the -o volatile mount option

Just move it to the tests/overlay/ tests and add syncfs (I wasn't sure
about how to do that).

Thanks,
Amir.
