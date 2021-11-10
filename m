Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6482D44BE52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 11:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhKJKRC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 05:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbhKJKRB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:17:01 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E66C061764
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 02:14:14 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id v3so3601692uam.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 02:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SqXsWUWLuu2Lv2utTh99gbwZolV4BkldqDlDA1egnC8=;
        b=l7XA1pQhBw6cOkiC1AG35S51Bj0N0dsusjKtYcTDgpRDZsReQAcmomKZqBuMUEsTqh
         LaCts1qPui4kpYnuf956Zb7slJteFX3QcatRbn8INecCe3RCT3umsNZp2Gxa0Rd1RVYr
         k2oC+rvWE3Sh9xTpPTlJ/rLqyRdTyqE/DOWcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SqXsWUWLuu2Lv2utTh99gbwZolV4BkldqDlDA1egnC8=;
        b=ZCRPYscd6Z41hNmHNGTIXH3h3c5r1TrfO+fnI5VI+bG+xd/Kjs66V/2NzS5/GR70Li
         9ejekW77gnpa3rFpAQoIh5qbRiQBB6oJN5xkjYxNsQrkqNQMDolzoP9hFtT0gXZV23xz
         ukzyvsZvoV8ACtvqO43Qo9SgNVTg49tNdAyn/mE4MXWsQXF5An2mcUf6AGC8ObITZpFp
         RSjUDoTt9fKINW7E7zVGMNvsDOpgeMlKAkJnJ2FublJr0juD8PAzXzkiMoH/l7FuBFI9
         ZhCw141ACapS0A1fu6GppcD2BtUzcBW1kDEEmobtcUqt9SAaXjxfd32QR6baPNDIh4SA
         cEsA==
X-Gm-Message-State: AOAM530N0P1pz47AykuLybRJJ+h889iPzU0i1sFW0Csds8vOS+kFu5es
        tEGGqH4BmbUicaRNogo6mn+e8hRAoSHJQACal0o7dnyWiqI=
X-Google-Smtp-Source: ABdhPJzs+k7RupuvFwaut3KFRVC7pzrhqyVRA/QoHQm4vfUN9HYD4Msd+OypbK8+Fs5Z92j/KunCfVp9kTTOc2DoJJw=
X-Received: by 2002:a67:782:: with SMTP id 124mr46509269vsh.24.1636539253815;
 Wed, 10 Nov 2021 02:14:13 -0800 (PST)
MIME-Version: 1.0
References: <CAPm50a+j8UL9g3UwpRsye5e+a=M0Hy7Tf1FdfwOrUUBWMyosNg@mail.gmail.com>
 <CAJfpegtbdz-wzfiKXAaFYoW-Hqw6Wm17hhMgWMqpTCtNXgAnew@mail.gmail.com>
 <CAPm50aKJ4ckQJw=iYDOCqvm=VTYaEcfgNL52dsj+FX8pcVYNmw@mail.gmail.com>
 <CAJfpegt9J75jAXWo=r+EOmextpSze0LFDUV1=TamxNoPchBSUQ@mail.gmail.com>
 <CAPm50aLPuqZoP+eSAGKOo+8DjKFR5akWUhTg=WFp11vLiC=HOA@mail.gmail.com> <CAPm50aLuK8Smy4NzdytUPmGM1vpzokKJdRuwxawUDA4jnJg=Fg@mail.gmail.com>
In-Reply-To: <CAPm50aLuK8Smy4NzdytUPmGM1vpzokKJdRuwxawUDA4jnJg=Fg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 10 Nov 2021 11:14:02 +0100
Message-ID: <CAJfpegs1Ue3-EFYuKfqb0jagfftgHdhDts7C7k+8hUg1eWcung@mail.gmail.com>
Subject: Re: [PATCH] fuse: add a dev ioctl for recovery
To:     Hao Peng <flyingpenghao@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 10 Nov 2021 at 04:43, Hao Peng <flyingpenghao@gmail.com> wrote:
>
> On Wed, Sep 8, 2021 at 5:27 PM Hao Peng <flyingpenghao@gmail.com> wrote:
> >
> > On Wed, Sep 8, 2021 at 5:08 PM Miklos Szeredi <miklos@szeredi.hu> wrote=
:
> > >
> > > On Wed, 8 Sept 2021 at 04:25, Hao Peng <flyingpenghao@gmail.com> wrot=
e:
> > > >
> > > > On Tue, Sep 7, 2021 at 5:34 PM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
> > > > >
> > > > > On Mon, 6 Sept 2021 at 14:36, Hao Peng <flyingpenghao@gmail.com> =
wrote:
> > > > > >
> > > > > > For a simple read-only file system, as long as the connection
> > > > > > is not broken, the recovery of the user-mode read-only file
> > > > > > system can be realized by putting the request of the processing
> > > > > > list back into the pending list.
> > > > >
> > > > > Thanks for the patch.
> > > > >
> > > > > Do you have example userspace code for this?
> > > > >
> > > > Under development. When the fuse user-mode file system process is a=
bnormal,
> > > > the process does not terminate (/dev/fuse will not be closed), ente=
r
> > > > the reset procedure,
> > > > and will not open /dev/fuse again during the reinitialization.
> > > > Of course, this can only solve part of the abnormal problem.
> > >
> > > Yes, that's what I'm mainly worried about.   Replaying the few
> > > currently pending requests is easy, but does that really help in real
> > > situations?
> > >
> > > Much more information is needed about what you are trying to achieve
> > > and how, as well as a working userspace implementation to be able to
> > > judge this patch.
> > >
> > I will provide a simple example in a few days. The effect achieved is t=
hat the
> > user process will not perceive the abnormal restart of the read-only fi=
le system
> > process based on fuse.
> >
> > > Thanks,
> > > Miklos
> Hi=EF=BC=8CI have implemented a small test program to illustrate this new=
 feature.
> After downloading and compiling from
> https://github.com/flying-122/libfuse/tree/flying
> #gcc -o testfile testfile.c -D_GNU_SOURCE
> #./example/passthrough_ll -o debug -s  /mnt3
> #./testfile (on another console)
> #ps aux | grep pass
> #root       34889  0.0  0.0   8848   864 pts/2    S+   13:10   0:00
> ./example/passthrough_ll -o debug -s /mnt3
> #root       34896  0.0  0.0   9880   128 pts/2    S+   13:10   0:00
> ./example/passthrough_ll -o debug -s /mnt3
> #root       34913  0.0  0.0  12112  1060 pts/1    S+   13:10   0:00
> grep --color=3Dauto pass
> // kill child process
> #kill 34896
> You will see that ./testfile continues to execute without noticing the
> abnormal restart of the fuse file system.

This is a very good first example demonstrating the limits of the
recovery.   The only state saved is the actual device file descriptor
and the result of the INIT negotiation.

It works if there are a fixed number of files, e.g. a read only
filesystem, where the files can be enumerated (i.e. a file or
directory can be found  based on a single 64bit index)

Is this your use case?

Are you ever planning to extend this to read-write filesystems?

Thanks,
Miklos
