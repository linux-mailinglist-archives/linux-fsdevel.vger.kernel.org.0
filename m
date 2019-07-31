Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 734D57B687
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 02:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfGaAIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 20:08:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35307 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfGaAIn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 20:08:43 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so132349657ioo.2;
        Tue, 30 Jul 2019 17:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8JheWTgIzFxYJeqUL2EvPnkBwvWfIxP2sSvvMHXbZc4=;
        b=hWYJ5Hswuxo5q6pljdWc5Msm3VQGPE+o0HSCQmzoXmEPpO4Z+T78LSXBhG2RqlKjA5
         uuHQ1vElZ+CI1PYhfIjSjVmxF+yXKi/O93nZMTrtRa0m21fyg2+JGse6k3wFoGXup9lP
         bNxdr5XyabSWOxZ8nS3tsaecozIcnxczcu71Ko1/opKV8LhMDy/bdSgSXTlDA6nVnGe/
         WJDgjLIInCFxEFkHKUpjj3ok4lp9ISYt3dlugX7qNuFCQQ4EvmiL+mkFCY/ZEY+MfL+y
         CacADCQ3DvEVeKzsAjzKyhLQ216WFCimRRRaOv5irGoCAMZUXg8xpKt9CYWu6jV/L5OK
         Iadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8JheWTgIzFxYJeqUL2EvPnkBwvWfIxP2sSvvMHXbZc4=;
        b=YPMXIndRAYkPai/IeGW/4ViNay9s5d6hU17PzNTvrp07FPSTH7GSz841HqLCl6La47
         ITTJcWpd5lGaJcu/S4iN+QoEvVbpddNvcIrRwPRYqgBZinmEm3twn0PlWWQmjZpSIOzD
         4Pes2tKRiTKXphDcjskJfW2l28G6K+meMd1gRoMFEyJkETqoFIPxV6wOq3dRCqalbtI6
         0WHe/ogbpj8x72XKqngujalUAtSIciGpxZgvVUeSkx4gSbfSnDm0A0u2KEr8DnwfPdaz
         vsWvlKkhf4dJaJYSzgXv2erpcR1tRRAh6u62MigGK/XGLrXgWbzJ5e8XqmfIgu6hUYwF
         F7+A==
X-Gm-Message-State: APjAAAXbkkTV/LD4MZ5NAQpgRBHiQwRuMzM/1Ox/6ROVJxRhd++W4eMU
        0dfYza7JiUrbqVTiWbhUT82cpaxi+ENM5hkTlyU=
X-Google-Smtp-Source: APXvYqw7z/G000E74naYRSALQNnmNRrw0cRjYs2C5wAzrF9FiInot9iHNesX21g3d95n0NHpLL9UMtgt3fxiJGInFeE=
X-Received: by 2002:a6b:f406:: with SMTP id i6mr38634089iog.110.1564531722141;
 Tue, 30 Jul 2019 17:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190730014924.2193-1-deepa.kernel@gmail.com> <20190730014924.2193-4-deepa.kernel@gmail.com>
 <87d0hsapwr.fsf@mail.parknet.co.jp> <CABeXuvqgaxDSR8N_D1Tdw06g_5PGinZS--6nx-bPtAWP4v+mwg@mail.gmail.com>
 <5340224D-5625-48A6-909E-70B24D2084BC@tuxera.com>
In-Reply-To: <5340224D-5625-48A6-909E-70B24D2084BC@tuxera.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 30 Jul 2019 17:08:30 -0700
Message-ID: <CABeXuvq_9YTTGZwmxO1WuEivuttDesNHKxeSQL5SsvkBSR884Q@mail.gmail.com>
Subject: Re: [PATCH 03/20] timestamp_truncate: Replace users of timespec64_trunc
To:     Anton Altaparmakov <anton@tuxera.com>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        stoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Joel Becker <jlbec@evilplan.org>,
        Richard Weinberger <richard@nod.at>, Tejun Heo <tj@kernel.org>,
        "yuchao0@huawei.com" <yuchao0@huawei.com>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        linux-mtd <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 30, 2019 at 3:28 PM Anton Altaparmakov <anton@tuxera.com> wrote=
:
>
> Hi Deepa,
>
> > On 30 Jul 2019, at 18:26, Deepa Dinamani <deepa.kernel@gmail.com> wrote=
:
> >
> > On Tue, Jul 30, 2019 at 1:27 AM OGAWA Hirofumi
> > <hirofumi@mail.parknet.co.jp> wrote:
> >>
> >> Deepa Dinamani <deepa.kernel@gmail.com> writes:
> >>
> >>> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> >>> index 1e08bd54c5fb..53bb7c6bf993 100644
> >>> --- a/fs/fat/misc.c
> >>> +++ b/fs/fat/misc.c
> >>> @@ -307,8 +307,9 @@ int fat_truncate_time(struct inode *inode, struct=
 timespec64 *now, int flags)
> >>>              inode->i_atime =3D (struct timespec64){ seconds, 0 };
> >>>      }
> >>>      if (flags & S_CTIME) {
> >>> -             if (sbi->options.isvfat)
> >>> -                     inode->i_ctime =3D timespec64_trunc(*now, 10000=
000);
> >>> +             if (sbi->options.isvfat) {
> >>> +                     inode->i_ctime =3D timestamp_truncate(*now, ino=
de);
> >>> +             }
> >>>              else
> >>>                      inode->i_ctime =3D fat_timespec64_trunc_2secs(*n=
ow);
> >>>      }
> >>
> >> Looks like broken. It changed to sb->s_time_gran from 10000000, and
> >> changed coding style.
> >
> > This is using a new api: timestamp_truncate(). granularity is gotten
> > by inode->sb->s_time_gran. See Patch [2/20]:
> > https://lkml.org/lkml/2019/7/29/1853
> >
> > So this is not broken if fat is filling in the right granularity in the=
 sb.
>
> It is broken for FAT because FAT has different granularities for differen=
t timestamps so it cannot put the correct value in the sb as that only allo=
ws one granularity.  Your patch is totally broken for fat as it would be im=
mediately obvious if you spent a few minutes looking at the code...

It seemed to me that FAT had already covered the special cases (2s and
1d) granularities by using internal functions. This one could also be
an inlined calculation, but I will just drop the FAT part from this
patch and leave it as is for now.

Thanks,
Deepa
