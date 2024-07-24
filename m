Return-Path: <linux-fsdevel+bounces-24180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3939C93AD22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 09:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B87282769
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 07:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7713173462;
	Wed, 24 Jul 2024 07:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZc/WOix"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432DF4C84;
	Wed, 24 Jul 2024 07:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721805874; cv=none; b=YB4kOdVLrX0xnExgVKfRqdGn1kkrYRUGmb+KMH83+pdzAMAutNjSjSK4OnC1Aw4fae6xYne8M9Lu6LSL5mklam0FL5FvqaRANm9xHBWtJ+RABtOHZbh+OQB0OPV4LUFatS6JtZibVCnKs9IAXsBB8693CLREumzFTJ1JjvPtjn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721805874; c=relaxed/simple;
	bh=LEWX+k/8MSd4SFfdq0QfS/26x3ssgRjoHc8BM0oLmgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mqge5VZrmdmSxwsitzd4hqTUFry+gRTEVMcwJjC4HxoYDi7bofIbeE+ISC7cZECn5aU2nss6cTv4JoMdThIr3jpuhQXxHHBPdAdMOR/NFtQJUEd3+Jy94mPfYhzgG0cCL2Q49/YYhLlSZk/Fhrw6UWSWxqkJKZsbBJbNxtcPWCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZc/WOix; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8100f08b5a8so1944478241.0;
        Wed, 24 Jul 2024 00:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721805872; x=1722410672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+f5FFSvM6HT5KTKo2M2ZBCowOBY1NaiePK0PXlKNIY=;
        b=IZc/WOixhNFzVj1M6gu7S4eTzhK5jtnhiLYp2Q1k7EFd09qabvLAXMS22GJoGDmNHe
         2rESRHPuv+R/D9ARvjH/ggCuKu73xVjIPwfpOs5grJMlAEcdsDW7EkM/TxpXpxH13aeP
         Ltsfzcg5VBQDfDZ7XA/VXEQ5ms8l60Lq0uRbKPGbQgOOdk1U7LxUsvqK3AOROLYQEvNo
         4oumlsIq/0DkA+h96Gem92GjqKPbQclK0B4jYtDkxRTCrrWhARVXDjFZAm4wKzmvVm66
         BRhfOytAtFw193uwG1iQsGRewbpAqKvdGtMsDsNoI3//el+JWnGQ6LHR69VCQjqfOKIw
         sxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721805872; x=1722410672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+f5FFSvM6HT5KTKo2M2ZBCowOBY1NaiePK0PXlKNIY=;
        b=xCjUdNmDtDg1uDp04KN5pt93IWmiGOzS0ljI4laqTtlKd9mdnFXzXeg2nfTmoYHs+E
         TXFPupXICkCqoT4DG8hRYBhNADf+/g1yFLWURO/bKUWPtOgdZ7gonOvS68LXe+HdxuwA
         Je1Cf5KitFoeT0TZq/unjFr/9HUgutjBxt2Uj8/XEdre/LGsMBUKsMjmElvW2W92I39o
         2+57KTIEu0GAzMmpGSYasuoBaSw1Bc0e16Jua9lFobzTqT6CT4u1WlCJJNh3HG52c/l8
         3Z1u/R0hKVVLzIIUb3UlWgebFpzk7C5yZ01uBF+uVzYKSH0GyXMlI4VDBaIt5clB6oDI
         ZtPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8c6lv9VoECkTuK7Ti0+PPtuFJVoYqABgj21EMFBsfIFAny6AtudmxTo9H0+6+8tZS/parlDtEJRUpb0HDUHhha3yuTASK/IqOGaExjk6KC248Jv/MDiFM3BwK+9opG+lNBO1PJhweSEdLSQ==
X-Gm-Message-State: AOJu0YwfIOg5GPfzAha0kfRKNB3SmZMAPcjp5YRaZVinYV0m7yXHmqNK
	kQREsJQNaZGPQdrmBYRpxl6LB4rONFXD2QO+7lf9IXSX0WjVWe6Po5Hr96mSroCC0LUVnPs7n2V
	UMnx9q2cUf7NFtLqL3UlTfimDVm8=
X-Google-Smtp-Source: AGHT+IHRFYlBwND9t9/mNEss4X5sthyFDCVaW46huTYDtIoZCQPLNqonp3J0AbBpAK3sk1/yR5P/PbQq3sQNsrLUkzw=
X-Received: by 2002:a05:6102:800f:b0:492:7675:a394 with SMTP id
 ada2fe7eead31-493c1890bd2mr2875452137.2.1721805872023; Wed, 24 Jul 2024
 00:24:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240723105423epcas1p4d4ee53975fbc4644e969b5c9b7514c9b@epcas1p4.samsung.com>
 <20240723105412.3615926-1-dongliang.cui@unisoc.com> <1625601dadd97$88eca020$9ac5e060$@samsung.com>
In-Reply-To: <1625601dadd97$88eca020$9ac5e060$@samsung.com>
From: dongliang cui <cuidongliang390@gmail.com>
Date: Wed, 24 Jul 2024 15:24:21 +0800
Message-ID: <CAPqOJe3mdz_heMQe09uZTf-E40ZBTMDuf49jE+hd10qYOjURmg@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: check disk status during buffer write
To: Sungjong Seo <sj1557.seo@samsung.com>
Cc: Dongliang Cui <dongliang.cui@unisoc.com>, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	niuzhiguo84@gmail.com, hao_hao.wang@unisoc.com, ke.wang@unisoc.com, 
	Zhiguo Niu <zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 3:03=E2=80=AFPM Sungjong Seo <sj1557.seo@samsung.co=
m> wrote:
>
> > We found that when writing a large file through buffer write, if the
> > disk is inaccessible, exFAT does not return an error normally, which
> > leads to the writing process not stopping properly.
> >
> > To easily reproduce this issue, you can follow the steps below:
> >
> > 1. format a device to exFAT and then mount (with a full disk erase)
> > 2. dd if=3D/dev/zero of=3D/exfat_mount/test.img bs=3D1M count=3D8192
> > 3. eject the device
> >
> > You may find that the dd process does not stop immediately and may
> > continue for a long time.
> >
> > The root cause of this issue is that during buffer write process,
> > exFAT does not need to access the disk to look up directory entries
> > or the FAT table (whereas FAT would do) every time data is written.
> > Instead, exFAT simply marks the buffer as dirty and returns,
> > delegating the writeback operation to the writeback process.
> >
> > If the disk cannot be accessed at this time, the error will only be
> > returned to the writeback process, and the original process will not
> > receive the error, so it cannot be returned to the user side.
> >
> > When the disk cannot be accessed normally, an error should be returned
> > to stop the writing process.
> >
> > Signed-off-by: Dongliang Cui <dongliang.cui@unisoc.com>
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> > Changes in v2:
> >  - Refer to the block_device_ejected in ext4 for determining the
> >    device status.
> >  - Change the disk_check process to exfat_get_block to cover all
> >    buffer write scenarios.
> > ---
> > ---
> >  fs/exfat/inode.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
> > index dd894e558c91..463cebb19852 100644
> > --- a/fs/exfat/inode.c
> > +++ b/fs/exfat/inode.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/mpage.h>
> >  #include <linux/bio.h>
> >  #include <linux/blkdev.h>
> > +#include <linux/backing-dev-defs.h>
> >  #include <linux/time.h>
> >  #include <linux/writeback.h>
> >  #include <linux/uio.h>
> > @@ -275,6 +276,13 @@ static int exfat_map_new_buffer(struct
> > exfat_inode_info *ei,
> >       return 0;
> >  }
> >
> > +static int exfat_block_device_ejected(struct super_block *sb)
> > +{
> > +     struct backing_dev_info *bdi =3D sb->s_bdi;
> > +
> > +     return bdi->dev =3D=3D NULL;
> > +}
> Have you tested with this again?
Yes, I tested it in this way. The user side can receive the -ENODEV error
after the device is ejected.
dongliang.cui@deivice:/data/tmp # dd if=3D/dev/zero of=3Dtest.img bs=3D1M c=
ount=3D10240
dd: test.img: write error: No such device
1274+0 records in
1273+1 records out
1335635968 bytes (1.2 G) copied, 8.060 s, 158 M/s

>
> > +
> >  static int exfat_get_block(struct inode *inode, sector_t iblock,
> >               struct buffer_head *bh_result, int create)
> >  {
> > @@ -290,6 +298,9 @@ static int exfat_get_block(struct inode *inode,
> > sector_t iblock,
> >       sector_t valid_blks;
> >       loff_t pos;
> >
> > +     if (exfat_block_device_ejected(sb))
> This looks better than the modified location in the last patch.
> However, the caller of this function may not be interested in exfat
> error handling, so here we should call exfat_fs_error_ratelimit()
> with an appropriate error message.
Thank you for the reminder. I will make the changes in the next version.

>
> > +             return -ENODEV;
> > +
> >       mutex_lock(&sbi->s_lock);
> >       last_block =3D EXFAT_B_TO_BLK_ROUND_UP(i_size_read(inode), sb);
> >       if (iblock >=3D last_block && !create)
> > --
> > 2.25.1
>
>

