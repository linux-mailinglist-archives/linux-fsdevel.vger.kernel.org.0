Return-Path: <linux-fsdevel+bounces-24510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045B393FF72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 22:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2CDF2846A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 20:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB9B18D4A6;
	Mon, 29 Jul 2024 20:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BN7Vb6gp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40E8188CAD;
	Mon, 29 Jul 2024 20:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284807; cv=none; b=PRpMW13vkz4S6pw+M2+ydSAcQEXMakUqp6aFHoEUNlvZaP1pEC0XZMsPHsRTG5lhc/PzdWgutk7CApzdz1flLb8KCTowKsEkpxaqBUyexootxYgxsIEtp7P+uckIEADUfzCNseuAL1oRhJnaFcVyV3evHN0zQJljLj2qBP48NRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284807; c=relaxed/simple;
	bh=4/M8PcMZ2pA0pcZmryHMaEkMSb1FJtRBcnrDbxk0+To=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWhmYnNxOpFuLQh5Cl9fgJsYO55L/kBjfWpZVynRPC8aTKtX6dcGn30XyGjOuROgy+3oW11pDNPUjdGGDamX8J0eixcwNSaBobskly+nn3JVbnV/jHJxJqBRQCaZnf7JQGgo6iJ6S28WzHtITKCDoDNnXXg+5oBx2OkYceLKXbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BN7Vb6gp; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f01b8738dso3940012e87.1;
        Mon, 29 Jul 2024 13:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722284803; x=1722889603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rU7VZ19DglSuk5shkD1EMAqDI834OMZeaLgq5GKE6U=;
        b=BN7Vb6gptT9xq4c0egpAxIFR6M5oFjB3yGSWIJH/Pasa7koOpfE42Hx53fxOJ+M4Gz
         0/fQs1KS4SUwcdIkA2i80pk2pfKnbNy5Te9vY+DY9T4zKS1WIKYS3nVS57wRHfrgU9L8
         jimRx+EwZnJAREFxmfWcK2ZhNdmoD58s+wxDf7TDVyJqwdJl/FuSgAvD1GHbu3eSRSon
         EZs8MZVMoDj935ruzfsNsoG5vCp+b5/hAZDM7jbkiYzZEKm4NrfsUUAJiChNLuDhhqGx
         ZJB0C3rE4eR2X7XTBR9GmxtX1FNIejbApCWKfmue5+CDCGktfDNb+r+dZasK7lC7SDIN
         qC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722284803; x=1722889603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rU7VZ19DglSuk5shkD1EMAqDI834OMZeaLgq5GKE6U=;
        b=Qi3VxXOgVeR60YyFugyDPCwQD50XApCv8XF1wTFVOdTSwjX3lx6nusLy2bvAHMP8s3
         9u5Az0bwVvgmpMFHeSKaa42IN5zh8A8uQomeXrn98ROREohF7uWEWVaS/F9pyMr8Kmks
         Ix0ciTAL9xNUV5IYRSESoaO24Irex4ergtaujNVrBIZDjeEL+akgaW0PipHGQeKA69kf
         ol5mweMF5dKnuWInHCCdWZcSx2LTpnlpBZS1o37Ip/byloknIkpygReua02HatxFPoMw
         j6+0D7QOqxWL3HvS7ZUgGkK01cvwgNH80l2mFQCFDYrVM/LYc1+w5l94kw23Z36eVzC8
         Hbzw==
X-Forwarded-Encrypted: i=1; AJvYcCX8omjlbt8z0tqJZGANfwzxxapPLcHyTcjl5H4sAg/I272KL1ZrWadMc1wDPrD6GE0O87PtWBava//9CcKKHv7rnT/Vx+cyMc/P66vO8edEBlI1bJPHYjOMljJg4coZTa1MM/cuuzl3fA==
X-Gm-Message-State: AOJu0Yzem1V2CSfN+llgnbae6MVmme93DH5sTfWeTagGmoAm06Qz4Zh5
	55I13w9emSR/+b+4FgEMG6YYxWM+g1ACPtZ9C2Ym9XnkGmCXh7aSo4L/SKD7IvVffFf/bXE8c4u
	SPxmDermCcGj3MUR6lnVsc0W5ISrPoB4Q
X-Google-Smtp-Source: AGHT+IG0UEsFBtOPY7uXQsDudxNq+y4z8DNZ8n5CElyHwQbjhii9onrKv8HSUxTFkPJ5Sfnv8H3r9y+Tgnn4sXcGfHQ=
X-Received: by 2002:a05:6512:e99:b0:52d:6673:11da with SMTP id
 2adb3069b0e04-5309b2ce6c5mr5846093e87.57.1722284802685; Mon, 29 Jul 2024
 13:26:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5ms+vyNND3XPkBo+HYEj3-YMSwqZJup8BSt2B3LYOgPF+A@mail.gmail.com>
 <5DBD1307-465D-4145-A42E-36AD04BB41A6@dilger.ca>
In-Reply-To: <5DBD1307-465D-4145-A42E-36AD04BB41A6@dilger.ca>
From: Steve French <smfrench@gmail.com>
Date: Mon, 29 Jul 2024 15:26:31 -0500
Message-ID: <CAH2r5muGmbafMMJozVxan+=qz3fXyLgV74pgEoewsfn30rbAQg@mail.gmail.com>
Subject: Re: Why do very few filesystems have umount helpers
To: Andreas Dilger <adilger@dilger.ca>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>  even though the filesystem on the host is kept mounted the whole time.  =
If the host filesystem
> is flushing its cache "in anticipation" of being fully unmounted, but is =
actually servicing dozens
> of guests, then it could be a significant hit to system performance

The good news (at least with cifs.ko) is that when multiple
superblocks get mounted on the same share
("tree connection" in cifs.ko) then the cached files (deferred close
for network handles with file leases) and
directory entries (with directory leases) won't get freed until the
last superblock mounted to that //server/sharename
is unmounted.


On Mon, Jul 29, 2024 at 12:31=E2=80=AFPM Andreas Dilger <adilger@dilger.ca>=
 wrote:
>
> On Jul 28, 2024, at 1:09 PM, Steve French <smfrench@gmail.com> wrote:
> >
> > I noticed that nfs has a umount helper (/sbin/umount.nfs) as does hfs
> > (as does /sbin/umount.udisks2).  Any ideas why those are the only
> > three filesystems have them but other fs don't?
>
> I think one of the reasons for this is that *unmount* helpers have been
> available only for a relatively short time compared to *mount* helpers,
> so not nearly as many filesystems have created them (though I'd wanted
> this functionality on occasion over the years).
>
> > Since umount does not notify the filesystem on unmount until
> > references are closed (unless you do "umount --force") and therefore
> > the filesystem is only notified at kill_sb time, an easier approach to
> > fixing some of the problems where resources are kept around too long
> > (e.g. cached handles or directory entries etc. or references on the
> > mount are held) may be to add a mount helper which notifies the fs
> > (e.g. via fs specific ioctl) when umount has begun.   That may be an
> > easier solution that adding a VFS call to notify the fs when umount
> > begins.
>
> I don't think that would be easier in the end, since you still need to
> change the kernel code to handle the new ioctl, and coordinate the umount
> helper to call this ioctl in userspace, rather than just have the kernel
> notify that an unmount is being called.
>
> One potential issue is with namespaces and virtualization, which may
> "unmount" the filesystem pretty frequently, even though the filesystem
> on the host is kept mounted the whole time.  If the host filesystem is
> flushing its cache "in anticipation" of being fully unmounted, but is
> actually servicing dozens of guests, then it could be a significant hit
> to system performance each time a guest/container starts and stops.
>
> Cheers, Andreas
>
> > As you can see from fs/namespace.c there is no mount
> > notification normally (only on "force" unmounts)
> >
> >        /*
> >         * If we may have to abort operations to get out of this
> >         * mount, and they will themselves hold resources we must
> >         * allow the fs to do things. In the Unix tradition of
> >         * 'Gee thats tricky lets do it in userspace' the umount_begin
> >         * might fail to complete on the first run through as other task=
s
> >         * must return, and the like. Thats for the mount program to wor=
ry
> >         * about for the moment.
> >         */
> >
> >        if (flags & MNT_FORCE && sb->s_op->umount_begin) {
> >                sb->s_op->umount_begin(sb);
> >        }
> >
> >
> > Any thoughts on why those three fs are the only cases where there are
> > umount helpers? And why they added them?
> >
> > I do notice umount failures (which can cause the subsequent mount to
> > fail) on some of our functional test runs e.g. generic/043 and
> > generic/044 often fail to Samba with
> >
> >     QA output created by 043
> >    +umount: /mnt-local-xfstest/scratch: target is busy.
> >    +mount error(16): Device or resource busy
>
>
> Cheers, Andreas
>
>
>
>
>


--=20
Thanks,

Steve

