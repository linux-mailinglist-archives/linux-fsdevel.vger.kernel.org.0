Return-Path: <linux-fsdevel+bounces-21078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 575DD8FDD3D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 05:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042FE1C2267A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 03:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041EC1F5FD;
	Thu,  6 Jun 2024 03:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwLBoO52"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72AE23BF
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2024 03:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717643703; cv=none; b=b1ApPqRBFGOmqV8BjRPXvnhSU0t8O6L9rkwag3fq6srPLytxphnDkZFfbnqsim872te3w4b8P8ualV8yJT+YtZMFhVqIXFzm5KqJIRbtn5fana7faP0ENNuCQIMSut1IR1tkMKUIgr74P+iyJWTliBpP2CbbSpGqdCsQ8to225U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717643703; c=relaxed/simple;
	bh=OzOa6bbKT/STfd6Xhwl3H8585ms3oMFlgFIkNH3EyFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rH0f38kmkLdMmyafcXluKIDUIr0keVXCdpMuYKgKqalUngqNHf8Xo/GSjGuwhgWkdjiSY7A1KdKDKYQ93KjbxoTQszGDnlr00MUvbaIJWKA9rdzMoaga6aKQ2pxRzY2xP/U4pjyuwJXLwagxGMX0nNM7JeATjZfR8bIbH1BxmEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwLBoO52; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57aa64c6bbfso307691a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jun 2024 20:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717643700; x=1718248500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0GInmYCEY5FJcmol75dxVxvQaa/wE8syC5rHwzadwo=;
        b=CwLBoO52aYKcRf1Q4Q9MPzFyAsBnVxw2xVTiftYSf/HcybP54pSxKOSRsgekdoCVKy
         kkzMxWS+ccvwVuL7VybwtJO4MA5uifKmju/sMsIG4jacTNmdL/ix2zRS2cpzlHsFx3x6
         MfffBiT4uHlsntx92rvFDLY5KXq8VxBfcjGuaP/TuMH1CoMvCHuygNPNwye59GMKz621
         CA/rJSPGj7Vw4e/UtP4MLKHy1EDs5fpvEv922UjVJyfIHOPy0Ahz+W8VfqBn56PLNxYy
         4R0pZKoKnvY5ej4rRTBjnTqqCf4P+avzqhBo7WxswC6EyQX8NhB8FDNGr8m80TC0y5ux
         qcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717643700; x=1718248500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0GInmYCEY5FJcmol75dxVxvQaa/wE8syC5rHwzadwo=;
        b=RokyXzQ9NB4yM0ZXR6Vr6wtimzPn6Ol36tsH3yUZcDXBFwqW1sRQWmTodYVJTxE6Qo
         k2cXshySRzmd/LT3DiH2DFzOjJhhrkwxVMBhuZtURQpqtXeRWJCcEo1ViAQLWvfP1w65
         yLNRXZCHhfHhkeFxbzK/vFgwGUX37E/PD12vivmjYITkR+zjJ2vFdLJvegVaCuoMPNJx
         jjeXOKvoExgQQCN42sP088/Y38nUxjTjm6D9b7OXzJy1Q80UUrowCrHazecXGp1PwpKt
         C1Re6lgeCksWcXlVT0T0ImLVngQvRcEQX4c1xe4SDD5SGTN6f+nuJGmExw5uzeU0sfm+
         UUXA==
X-Forwarded-Encrypted: i=1; AJvYcCV4QOjhmvDq3mpZZ4AEsvShooeRXIMIgVpDxRT0K2QiqVsK0ro/WqoxusL8+zmAmTmlKo1/JfpPQdm/XOz3T0aIoetmVr7X3mIU3Bwz5A==
X-Gm-Message-State: AOJu0YwymSr5iZyY1yLGd1px+iQDapjycisd/YwAZQcn1hx4P/+Jjwtw
	gXilMkb65T9jYpWwnSm9oJ2n5b4SFMbN8xhlClGTK+Ri5C94VVD1LIog0At4ker+eytZy8ZieQo
	+l+9tIed3yQo0h7XRoVBzUihvIOM=
X-Google-Smtp-Source: AGHT+IGiJMiwe0qCkDyNiyl85DQwHtV8s+u6+QHEeLrr9SqqXlkYdvEUPbSpSB/WA4CftddAqzY4yqFOFrgj7Ndw2Ng=
X-Received: by 2002:a50:bac8:0:b0:578:6198:d6fa with SMTP id
 4fb4d7f45d1cf-57a8b6740a0mr2712418a12.2.1717643699601; Wed, 05 Jun 2024
 20:14:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHB1NaicRULmaq8ks4JCtc3ay3AQ9mG77jc5t_bNdn3wMwMrMg@mail.gmail.com>
 <CAJfpegsELV80nfYUP0CvbE=c45re184T4_WtUEhhfRGVmpmpcQ@mail.gmail.com>
 <CAHB1NaiddGRxh7UjaXejWsYnJY52dYDvaB2oZpqQXqVocxTm+w@mail.gmail.com>
 <20240604092757.k5kkc67j3ssnc6um@quack3> <CAHB1NahP14FAMj04D-T-bWs7JAn_mXfmXSeKUEkRbALZrLeqAA@mail.gmail.com>
 <20240605102945.q4nu67xpdwfziiqd@quack3>
In-Reply-To: <20240605102945.q4nu67xpdwfziiqd@quack3>
From: JunChao Sun <sunjunchao2870@gmail.com>
Date: Thu, 6 Jun 2024 11:14:48 +0800
Message-ID: <CAHB1NajZEy5kPXTcVu9G88WO-uZ5_Q6x3-EkFR4mfG0+XQWD3A@mail.gmail.com>
Subject: Re: Is is reasonable to support quota in fuse?
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	"Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jan Kara <jack@suse.cz> =E4=BA=8E2024=E5=B9=B46=E6=9C=885=E6=97=A5=E5=91=A8=
=E4=B8=89 18:29=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue 04-06-24 21:49:20, JunChao Sun wrote:
> > Jan Kara <jack@suse.cz> =E4=BA=8E2024=E5=B9=B46=E6=9C=884=E6=97=A5=E5=
=91=A8=E4=BA=8C 17:27=E5=86=99=E9=81=93=EF=BC=9A
> > > On Tue 04-06-24 14:54:01, JunChao Sun wrote:
> > > > Miklos Szeredi <miklos@szeredi.hu> =E4=BA=8E2024=E5=B9=B46=E6=9C=88=
4=E6=97=A5=E5=91=A8=E4=BA=8C 14:40=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > On Mon, 3 Jun 2024 at 13:37, JunChao Sun <sunjunchao2870@gmail.co=
m> wrote:
> > > > >
> > > > > > Given these challenges, I would like to inquire about the commu=
nity's
> > > > > > perspective on implementing quota functionality at the FUSE ker=
nel
> > > > > > part. Is it feasible to implement quota functionality in the FU=
SE
> > > > > > kernel module, allowing users to set quotas for FUSE just as th=
ey
> > > > > > would for ext4 (e.g., using commands like quotaon /mnt/fusefs o=
r
> > > > > > quotaset /mnt/fusefs)?  Would the community consider accepting =
patches
> > > > > > for this feature?
> > > > >
> > > > >
> > > > > > I would say yes, but I have no experience with quota in any way=
, so
> > > > > > cannot help with the details.
> > > >
> > > > Thanks for your reply. I'd like try to implement this feature.
> > >
> > > Nice idea! But before you go and spend a lot of time trying to implem=
ent
> > > something, I suggest that you write down a design how you imagine all=
 this
> > > to work and we can talk about it. Questions like: Do you have particu=
lar
> > > usecases in mind? Where do you plan to perform the accounting /
> > > enforcement? Where do you want to store quota information? How do you=
 want
> > > to recover from unclean shutdowns? Etc...
> >
> > Thanks a lot for your suggestions.
> >
> > I am reviewing the quota code of ext4 and the fuse code to determine
> > if the implementation method used in ext4 can be ported to fuse. Based
> > on my current understanding, the key issue is that ext4 reserves
> > several inodes for quotas and can manage the disk itself, allowing it
> > to directly flush quota data to the disk blocks corresponding to the
> > quota inodes within the kernel.
>
> Yes.
>
> > However, fuse does not seem to manage
> > the disk itself; it sends all read and write requests to user space
> > for completion. Therefore, it may not be possible to directly flush
> > the data in the quota inode to the disk in fuse.
>
> Yes, ext4 uses journalling to keep filesystem state consistent with quota
> information. Doing this within FUSE would be rather difficult (essentiall=
y
> you would have to implement journal within FUSE with will have rather hig=
h
> performace overhead).
>
>
> > But that's why I'm asking for usecases. For some usecases it may be fin=
e
> > that in case of unclean shutdown you run quotacheck program to update q=
uota
> > information based on current usage - non-journalling filesystems use th=
is
> > method. So where do you want to use quotas on a FUSE filesystem?

Please allow me to ask a silly question. I'm not sure if I correctly
understand what you mean by 'unclean shutdown'. Do you mean an
inconsistent state that requires using fsck to repair, like in ext4
after a sudden power loss, or is it something else only about quota?
In my scenario, FUSE (both the kernel and user space parts) acts
merely as a proxy. FUSE is based on multiple file systems, and a
user's file and directory exists in only one of these file systems. It
does not even have its own superblock or inode metadata. When a user
performs read or write operations on a specific file, FUSE checks the
directory corresponding to this file on each file system to see if the
user's file is there; if one is not, it continues to check the next
file system.

>
> > I am considering whether it would be feasible to implement the quota
> > inode in user space in a similar manner. For example, users could
> > reserve a few regular files that are invisible to actual file system
> > users to store the contents of quota. When updating the quota, the
> > user would be notified to flush the quota data to the disk. The
> > benefit of this approach is that it can directly reuse the quota
> > metadata format from the kernel, users do not need to redesign
> > metadata. However, performance might be an issue with this approach.
>
> Yes, storing quota data in some files inside the filesystem is probably t=
he
> easiest way to go. I'd just not bother with flushing because as you say
> the performance would suck in that case.

What about using caching and asynchronous updates? For example, in
FUSE, allocate some pages to cache the quota data. When updating quota
data, write to the cache first and then place the task in a work
queue. The work queue will then send the request to user space to
complete the actual disk write operation. When there are read
requests, the content is read directly from the cache.

The problem with this approach is that asynchronous updates might lead
to loss of quota data in the event of a sudden power failure. This
seems acceptable to me, but I am not sure if it aligns with the
definition of quota. Additionally, this assumes that the quota file
will not be very large, which I believe is a reasonable
assumption.Perhaps there are some drawbacks I haven't considered?

Regarding the enforcement of quota limits, I plan to perform this in
the kernel. For project quotas, the kernel can know how much space and
how many inodes are being used by the corresponding project ID. For
now, I only want to implement project quota because I believe that
user and group quotas can be simulated using project quotas.
Additionally, users' definitions of file system users and groups might
differ from file UID and GID. Users can freely use project IDs to
define file system users and groups.
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


Best regards,
--=20
Junchao Sun <sunjunchao2870@gmail.com>

