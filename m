Return-Path: <linux-fsdevel+bounces-23679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98C8931244
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 12:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C451C217CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 10:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650F018786F;
	Mon, 15 Jul 2024 10:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtAVxPk6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E272187561;
	Mon, 15 Jul 2024 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039306; cv=none; b=L8TTdbhm8u/j6lgiBwyeX2tdAd1SMHrZAnQ0Fih4OZ6gnTfXqZpY0QaCnV+c9//JltLM0Ew7OeByf5AGV9NXUy3pqiWD4cvOxWx3GCTBegv/maWk05ZYKZR9m2FBNBaBElXwpkPC8r0gfKtlo3YF8i2aMBiVPDVXiRyEu8Awxpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039306; c=relaxed/simple;
	bh=jWh8aolPcQUN6HW+bG6AksgWYGkRR+D9kYp2ZWxSneU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nnb/l/jTvjAbWlcPpJooxeulANr/+4v/R7AFTQvURJDjQXc/Ee8aIPPXsoJUtGKTLCP64GMHwkzpDat302X2S+Gc0hDi8hKweaFR7UHPocO4At9R1PFdvKW0303r1HbhnBsXhHsxfvxLvGFuaCOBDCPW9ydHiVsG5yKHcPPi8Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtAVxPk6; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79f02fe11aeso331918685a.2;
        Mon, 15 Jul 2024 03:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721039304; x=1721644104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgeWbA5looYm6PBW/8zreqXM2SHIapgVNeyP/UhRN1M=;
        b=CtAVxPk6HZS846Yge90cg/DSpQY/+B1YNFAINURYRH/LJcaOIoUMRQPXtF1+P1IDUx
         JJNNzrC9Lp7ehkqZ3dGjE0IHmrfM1pBh//yQ9xa5deoC4EQvbjmcyBYBdrM6UsISK6nT
         6qrQwAMS+ezGor1BoA7jWmAmiZhXK68mMSbLBQkMqnSq0Ql/medDt8DPucnLfMelpv+f
         93ddTQ7m/oorOtrFrUxIVj8p3Coafba8NRmtLkSLTecf1ER4X1h/A3dM6CBUPUqtDlI0
         OhzhtSrO8Gr6I4H4WhBDdPsGTFJ1bwfCelWUP0wmeHfjo6iOSb4wrorty8UVOUy7dxtC
         6Dww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721039304; x=1721644104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgeWbA5looYm6PBW/8zreqXM2SHIapgVNeyP/UhRN1M=;
        b=gRuwHjFLuT9JMuERk1Mswp8bcUtlASGGthsjbPwJify3ASpj4to13Wi8NgP9lBBx+t
         xmci1D3ixr3gddYvq2dUH/wWlu6yJnbem2liN1Q0nO4u3g6wNX+0EeXwvACnkCDEzNr8
         PpKM4ECY14pkTzOPb/Ke41B/vu41s0ocrjnk40vMGIbmEUwu/aA8YtPgCHcev9MfyCYu
         GpKFf3CTEmFNxXGOAdY/oyyjY8udnWnvUBytq9S7Gqm8Lpic2UOaPeMJg0qw0q67J9bW
         4a1KmpsSfupIPpbbYbZnNWfX+zMRl6FarqPCjuyi1iWCXWZhBc7C1VrxGMTxSoWQ3RvM
         wdAw==
X-Forwarded-Encrypted: i=1; AJvYcCXFXCaqGU3FhzU3XWbGpEEv+U/dGb5GKO4yEh14yOvbPrVnnvn5ruQG+S7mfsxl713GSYVz8ZQtEMKbzqnqQ5UJaI7qxsTOitxS5B/4bYx2gViLZmJmuPMCOg9jAKBM5TQ9XMAsbbwLqbORDg==
X-Gm-Message-State: AOJu0YzyGHppweXVEawHcm62i25AAsVkyI2SLINLBaPW0kx5vOY55VAB
	k21A90d1IctLIJ+Z/35+a5g8ehuT+gNObQwaB8CJI2uSR+T/MF2XfZUVTMNhbh5fbhJqWd6/gM6
	rWKKbP8NclIJugMlNFx8W9GxLGL4=
X-Google-Smtp-Source: AGHT+IH+Ob3ztKnB7vGZrA9GPa/jmeiGeW82xmDmr8Ep49G3B4JE9b2DD410tMKFmw8OiyIwTuaZpM60fih5vPdVArA=
X-Received: by 2002:a05:620a:12c8:b0:79d:67f3:636d with SMTP id
 af79cd13be357-79f19a6f782mr1942285285a.19.1721039304145; Mon, 15 Jul 2024
 03:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240705081528epcas1p32c38cfb39dae65109bbfbd405a9852b2@epcas1p3.samsung.com>
 <20240705081514.1901580-1-dongliang.cui@unisoc.com> <459601dad36f$c913a770$5b3af650$@samsung.com>
 <da2c0cd06c4a4dfa86f0ea2dbc3e1435@BJMBX02.spreadtrum.com>
In-Reply-To: <da2c0cd06c4a4dfa86f0ea2dbc3e1435@BJMBX02.spreadtrum.com>
From: dongliang cui <cuidongliang390@gmail.com>
Date: Mon, 15 Jul 2024 18:28:13 +0800
Message-ID: <CAPqOJe3gTwxr63k7MYofmcR_BOuq0yhcxL-DA5pkViFshQ9b0A@mail.gmail.com>
Subject: Re: [PATCH] exfat: check disk status during buffer write
To: =?UTF-8?B?5bSU5Lic5LquIChEb25nbGlhbmcgQ3VpKQ==?= <Dongliang.Cui@unisoc.com>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, "linkinjeon@kernel.org" <linkinjeon@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"niuzhiguo84@gmail.com" <niuzhiguo84@gmail.com>, =?UTF-8?B?546L55qTIChIYW9faGFvIFdhbmcp?= <Hao_hao.Wang@unisoc.com>, 
	=?UTF-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= <Zhiguo.Niu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 4:51=E2=80=AFPM =E5=B4=94=E4=B8=9C=E4=BA=AE (Dongli=
ang Cui)
<Dongliang.Cui@unisoc.com> wrote:
>
> > We found that when writing a large file through buffer write, if the
> > disk is inaccessible, exFAT does not return an error normally, which
> > leads to the writing process not stopping properly.
> >
> > To easily reproduce this issue, you can follow the steps below:
> >
> > 1. format a device to exFAT and then mount (with a full disk erase) 2.
> > dd if=3D/dev/zero of=3D/exfat_mount/test.img bs=3D1M count=3D8192 3. ej=
ect the
> > device
> >
> > You may find that the dd process does not stop immediately and may
> > continue for a long time.
> >
> > We compared it with the FAT, where FAT would prompt an EIO error and
> > immediately stop the dd operation.
> >
> > The root cause of this issue is that when the exfat_inode contains the
> > ALLOC_NO_FAT_CHAIN flag, exFAT does not need to access the disk to
> > look up directory entries or the FAT table (whereas FAT would do)
> > every time data is written. Instead, exFAT simply marks the buffer as
> > dirty and returns, delegating the writeback operation to the writeback
> > process.
> >
> > If the disk cannot be accessed at this time, the error will only be
> > returned to the writeback process, and the original process will not
> > receive the error, so it cannot be returned to the user side.
> >
> > Therefore, we think that when writing files with ALLOC_NO_FAT_CHAIN,
> > it is necessary to continuously check the status of the disk.
> >
> > When the disk cannot be accessed normally, an error should be returned
> > to stop the writing process.
> >
> > Signed-off-by: Dongliang Cui <dongliang.cui@unisoc.com>
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> >  fs/exfat/exfat_fs.h | 5 +++++
> >  fs/exfat/inode.c    | 5 +++++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h index
> > ecc5db952deb..c5f5a7a8b672 100644
> > --- a/fs/exfat/exfat_fs.h
> > +++ b/fs/exfat/exfat_fs.h
> > @@ -411,6 +411,11 @@ static inline unsigned int
> > exfat_sector_to_cluster(struct exfat_sb_info *sbi,
> >               EXFAT_RESERVED_CLUSTERS;  }
> >
> > +static inline bool exfat_check_disk_error(struct block_device *bdev)
> > +{
> > +     return blk_queue_dying(bdev_get_queue(bdev));
> Why don't you check it like ext4?
>
> static int block_device_ejected(struct super_block *sb) {
>        struct inode *bd_inode =3D sb->s_bdev->bd_inode;
>        struct backing_dev_info *bdi =3D inode_to_bdi(bd_inode);
>
>        return bdi->dev =3D=3D NULL;
> }
>
> The block_device->bd_inode has been removed in the latest code.
> We might be able to use super_block->s_bdi->dev for the judgment,
> or perhaps use blk_queue_dying?

Hi,
To provide more information,

Related commits for the removal of bd_inode,
203c1ce0bb06 RIP ->bd_inode

Since bd_inode has been removed, referencing the method of ext4 might
not be feasible. Can we consider using one of the following two methods
instead?

For example,
struct int exfat_block_device_ejected(struct super_block *sb)
{
        struct backing_dev_info *bdi =3D sb->s_bdi;
        return bdi->dev =3D=3D NULL;
}
Or,
static inline bool exfat_check_disk_error(struct block_device *bdev)
{
       return blk_queue_dying(bdev_get_queue(bdev));
}

Are there any other suggestions?

> >  static inline bool is_valid_cluster(struct exfat_sb_info *sbi,
> >               unsigned int clus)
> >  {
> > diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c index
> > dd894e558c91..efd02c1c83a6 100644
> > --- a/fs/exfat/inode.c
> > +++ b/fs/exfat/inode.c
> > @@ -147,6 +147,11 @@ static int exfat_map_cluster(struct inode *inode,
> > unsigned int clu_offset,
> >       *clu =3D last_clu =3D ei->start_clu;
> >
> >       if (ei->flags =3D=3D ALLOC_NO_FAT_CHAIN) {
> > +             if (exfat_check_disk_error(sb->s_bdev)) {
> > +                     exfat_fs_error(sb, "device inaccessiable!\n");
> > +                     return -EIO;
> This patch looks useful when using removable storage devices.
> BTW, in case of "ei->flags !=3D ALLOC_NO_FAT_CHAIN", There could be the s=
ame problem if it can be found from lru_cache. So, it would be nice to chec=
k disk_error regardless ei->flags. Also, Calling exfat_fs_error() seems unn=
ecessary. Instead, let's return -ENODEV instead of -EIO.
> I believe that these errors will be handled on exfat_get_block()
>
>
> Thanks.
> > +             }
> > +
> >               if (clu_offset > 0 && *clu !=3D EXFAT_EOF_CLUSTER) {
> >                       last_clu +=3D clu_offset - 1;
> >
> > --
> > 2.25.1
>
>

