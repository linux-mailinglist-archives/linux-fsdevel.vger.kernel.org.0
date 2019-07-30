Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 473B07B044
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 19:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbfG3Rjx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 13:39:53 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35180 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731313AbfG3Rjx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:39:53 -0400
Received: by mail-io1-f67.google.com with SMTP id m24so130086599ioo.2;
        Tue, 30 Jul 2019 10:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uwRGpPyO4rj41OhPrKgAKlV9LI4f1AOpgovGm7Ses18=;
        b=rksr4DjuGP0oernMgWLZxy30LGhFuhay1j1vOnOeicZjBWcqFJ+Nx6MfuUboj9QxPu
         +s3KqxCVZ6YCOwjMF6XAnU9scY8hJk64AiBY3aRG7qoKqJ43hiim+myQHFw1xdWZkquA
         j1S872SkhWEOxZ3WTO7SNFLVuh/RjTE+Dsg0DhnZMk0BtQ4l3EshZBGWijHr2OGFB4lv
         XodPLoOau1Z4SFA3GBfBRUiM4EGWadAnYO/oQaSDTIwMJHiGxAYIFQiwUyjXot/4VEm1
         JmGcG67m/98CXLV7fQSflRRr6EVkcNirxk4Ndfr17ug481gcd4md+nZyTaBTNiZXLGvg
         Zfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uwRGpPyO4rj41OhPrKgAKlV9LI4f1AOpgovGm7Ses18=;
        b=ZSxplPujgNu9gGh6f2A92+izWesCU4TaSMoIFwidmMBoP7QcrS/q57hKfJyIDAQ1y1
         Mzu/9bpv7LhhKoIp6uv3SgGOWOnxtO34X2XbaU1cMs3iAOUCr7ACO/97r/mxPyF7Yf2x
         Jp1fdbXWSh8mDnn2DiH8OOsMgKc7V4KWIWj2wcQ8RzfWHBBYvk4r4/lAyoZ5iN1uJYsW
         8/kN4y0SetOYojqw1w0LrsDZjsx+jLIN3vz1oRUfe2xJqv056XLi1DNgTS2161kY6/eJ
         TC3jKpKWY37nCtMtjeYahz0xpMg4X9vs1N/9z6eYYyEOieRbcSsV9XG6S2nONoJUvvy0
         hn4Q==
X-Gm-Message-State: APjAAAWjsdgzgIKuWih9855DYOSPlaQyudcNNI7hefdx9GCL4iAmeE3r
        vijNCZwtPyTAmkF8HOYXvkxhKutN2g92hCE3GsM=
X-Google-Smtp-Source: APXvYqzQMO3eczgpJRVOn78BhEOjZ3P9FqbQh5qXdx89yHk8g5EM3UU/ffKu0D3Gu1LNA9EcmgC8ssuM8FznO9tZjCo=
X-Received: by 2002:a6b:ed09:: with SMTP id n9mr36647545iog.153.1564508392466;
 Tue, 30 Jul 2019 10:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190730014924.2193-1-deepa.kernel@gmail.com> <20190730014924.2193-13-deepa.kernel@gmail.com>
 <878ssfc1id.fsf@mail.parknet.co.jp>
In-Reply-To: <878ssfc1id.fsf@mail.parknet.co.jp>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 30 Jul 2019 10:39:41 -0700
Message-ID: <CABeXuvoZCqGLaiOrf+qrg8pYNYnrY5qzDnwGpnuV+jh3jNvhjw@mail.gmail.com>
Subject: Re: [PATCH 12/20] fs: fat: Initialize filesystem timestamp ranges
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 30, 2019 at 2:31 AM OGAWA Hirofumi
<hirofumi@mail.parknet.co.jp> wrote:
>
> Deepa Dinamani <deepa.kernel@gmail.com> writes:
>
> > +/* DOS dates from 1980/1/1 through 2107/12/31 */
> > +#define FAT_DATE_MIN (0<<9 | 1<<5 | 1)
> > +#define FAT_DATE_MAX (127<<9 | 12<<5 | 31)
> > +#define FAT_TIME_MAX (23<<11 | 59<<5 | 29)
> > +
> >  /*
> >   * A deserialized copy of the on-disk structure laid out in struct
> >   * fat_boot_sector.
> > @@ -1605,6 +1610,7 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
> >       int debug;
> >       long error;
> >       char buf[50];
> > +     struct timespec64 ts;
> >
> >       /*
> >        * GFP_KERNEL is ok here, because while we do hold the
> > @@ -1698,6 +1704,12 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
> >       sbi->free_clus_valid = 0;
> >       sbi->prev_free = FAT_START_ENT;
> >       sb->s_maxbytes = 0xffffffff;
> > +     fat_time_fat2unix(sbi, &ts, 0, cpu_to_le16(FAT_DATE_MIN), 0);
> > +     sb->s_time_min = ts.tv_sec;
> > +
> > +     fat_time_fat2unix(sbi, &ts, cpu_to_le16(FAT_TIME_MAX),
> > +                       cpu_to_le16(FAT_DATE_MAX), 0);
> > +     sb->s_time_max = ts.tv_sec;
>
> At least, it is wrong to call fat_time_fat2unix() before setup parameters
> in sbi.

All the parameters that fat_time_fat2unix() cares in sbi is accessed through

static inline int fat_tz_offset(struct msdos_sb_info *sbi)
{
    return (sbi->options.tz_set ?
           -sbi->options.time_offset :
           sys_tz.tz_minuteswest) * SECS_PER_MIN;
}

Both the sbi fields sbi->options.tz_set and sbi->options.time_offset
are set by the call to parse_options(). And, parse_options() is called
before the calls to fat_time_fat2unix().:

int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
           void (*setup)(struct super_block *))
{
     <snip>

    error = parse_options(sb, data, isvfat, silent, &debug, &sbi->options);
    if (error)
        goto out_fail;

   <snip>

    sbi->prev_free = FAT_START_ENT;
    sb->s_maxbytes = 0xffffffff;
    fat_time_fat2unix(sbi, &ts, 0, cpu_to_le16(FAT_DATE_MIN), 0);
    sb->s_time_min = ts.tv_sec;

    fat_time_fat2unix(sbi, &ts, cpu_to_le16(FAT_TIME_MAX),
              cpu_to_le16(FAT_DATE_MAX), 0);
    sb->s_time_max = ts.tv_sec;

   <snip>
}

I do not see what the problem is.

-Deepa
