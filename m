Return-Path: <linux-fsdevel+bounces-60767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E26B5180B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 15:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9BF417539F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 13:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07267315785;
	Wed, 10 Sep 2025 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCyptrfs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C851494CC;
	Wed, 10 Sep 2025 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757511496; cv=none; b=OY73BZK5AkSAA1Rr4LKTr7kXhFwTjsWbvdTwarG1PpZHh4cG9529FKvDsc/dSbZva6YlJffBN7MjFO/c2PqKLhuqpPk7COmBBPw9IperKrzrGfKvycirw0B2BnmITr+BcGbJEfxKaYKf2ZJoHXVvFHuwlJtQdgIsCaqFzIrQ5cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757511496; c=relaxed/simple;
	bh=GzE07U7VyPNCFpv1UikMtaenvDzjlPV/SgT6RwD3Nu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnHEMr86tRJf7gbLiQ90481r5wMYyicDjgd+cdoHCOqJ4gHrr9fZudOpbwFmTak2yBcrBWrM6tutt4Eksysi1NEjY2C/YGmBrKaqZmLSq5QV/zWLxcy+bLW5Up/+x9chKHESdNxWKy69DKQLhNcOsFGcU8a3FOlmverMLDo9z9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCyptrfs; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61cb4374d2fso10425661a12.2;
        Wed, 10 Sep 2025 06:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757511492; x=1758116292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rB0CJVUwev2L2WfSF2Qg0RNSFBgy0+1Icq6NNNZRzAU=;
        b=aCyptrfs2/XXahYyFKVd0SVckLXD5NVZGasW4ICWC2c7b5hublwo6Qr2WDn3WyGU60
         ID7/EMItNYD6HPdCx4apdG9plULNLbV/gMUqOf55x+JelR1EhbLDOvPGuvVkNjol1Lbq
         xBmox3kd1LdzV0oqR635mFDtK131B1ch+tDYL8X/nx6bSzJ5+FQio1C65a0MZTQmAlZ5
         NsIuGkD9M9DLCHmoGZGriRWEkIJQ8ymz7u+lJtO6JtHBjSfraZetD+0LBxsqCaB43Ao3
         YwDMJJ7uXAvQ+8l/mF0OJPqAgKqILI4A6PYt8CqjE7aUYkjA8fQ1jDIbfybvZCHAu6IK
         KHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757511492; x=1758116292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rB0CJVUwev2L2WfSF2Qg0RNSFBgy0+1Icq6NNNZRzAU=;
        b=FVS1rlM4Y54Ne8V2krqWBIBa5VDxVb9povwRfg6ijZ6MTdgB15mZGxBPBWbkABUxlm
         nGu6pJfxznDgSV208rGORbfMxsa15EEhlhgn0QiZ6v1qX7DtLLJK6qpICHoc3jggCA8a
         AUF/MWvR0Gl3bUPS8eE2ZMgP+96neHIL5TzkLOrUnyQ2jr/6qYq/rNl45RojANBomPB7
         9SpuvB8B3V7Qef8s/Spp/Ms2DC0swYkDzoIm1nGBcv/ZPYHIDCtlXaQPi0eozL+qiUZs
         VQQpZlGsOqYIrfBOLG4Pv/hL4NbyYJa3iKYG69VesD83v3a80J3OhajsfhihKGOu4qJq
         BCHg==
X-Forwarded-Encrypted: i=1; AJvYcCUdPYvQHJeyffCifYn+mOhsXiBzl8s/w0eiiqAF67EQalYkDcCK0yQiw2EsS6U8gZsTxkBje78wFlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMcimmIeXqIHuiqL3IEps+MD0wcWvCeH6PP5/xI+44F+Cf6VLG
	jE/eXcfmWlY5GW4OI/a/YfI99IgENIG+HY4sjZg/EMVUlyS2eBqfGSG8IJr+NG0anuBPUh/NtL7
	/q9c8Pogf5zdETZ2yo+xhqdjoQPpe6OcF
X-Gm-Gg: ASbGncvNakYE0Ju2pi145dm+O17TIiBU06s5t66N6iPh63aw9wJwTswPT1hNM9Drf5G
	g74hVBbGRW9Rz+81GtN4aUmr+lHuHwOha8obHqjE2oA5ctefwUmRteIBt426xoEHscf7/f4lhy0
	nsPUWOpgneMvdQIq76c+zyq4K39kKvs7DwyGv86dn19h4rrjm3WjqvRSdtCLxvnRFou6H9nMELT
	MZB4QdsBuZBACYcd3ggTweEWqlG0YOOnyYdMi5WNWONsc6BfA==
X-Google-Smtp-Source: AGHT+IHOpgZ7rJgeVNl6Tg8AxEsslAl8q/uY3O5zAlY/jFydfnrzPISjj5ou4BG8X55S05ov/8ZKp6ARLYDVGBDbn+4=
X-Received: by 2002:a05:6402:42cf:b0:617:eb8d:283b with SMTP id
 4fb4d7f45d1cf-6237f943f04mr16944729a12.26.1757511491739; Wed, 10 Sep 2025
 06:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
 <CALXu0Ufgv7RK7gDOK53MJsD+7x4f0+BYYwo2xNXidigxLDeuMg@mail.gmail.com>
 <44250631-2b70-4ce8-b513-a632e70704ed@oracle.com> <aEZ3zza0AsDgjUKq@infradead.org>
 <e5e385fd-d58a-41c7-93d9-95ff727425dd@oracle.com> <aEfD3Gd0E8ykYNlL@infradead.org>
 <CALXu0UfgvZdrotUnyeS6F6qYSOspLg_xwVab8BBO6N3c9SFGfA@mail.gmail.com>
 <e1ca19a0-ab61-453f-9aea-ede6537ce9da@oracle.com> <CALXu0Uc9WGU8QfKwuLHMvNrq3oAftV+41K5vbGSkDrbXJftbPw@mail.gmail.com>
 <47ece316-6ca6-4d5d-9826-08bb793a7361@oracle.com> <CAKAoaQ=RNxx4RpjdjTVUKOa+mg-=bJqb3d1wtLKMFL-dDaXgCA@mail.gmail.com>
In-Reply-To: <CAKAoaQ=RNxx4RpjdjTVUKOa+mg-=bJqb3d1wtLKMFL-dDaXgCA@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Wed, 10 Sep 2025 06:37:57 -0700
X-Gm-Features: AS18NWCWqiKdNAuM-oKNLX1jqBzP3lv2zthOYyP0uvWT6Zgmu87Sfb92em3bsdw
Message-ID: <CAM5tNy7w71r6WgWOz4tXtLi=yvw55t_5dFe_x-13Thy5NgjEGA@mail.gmail.com>
Subject: Re: NFSv4.x export options to mark export as case-insensitive,
 case-preserving? Re: LInux NFSv4.1 client and server- case insensitive
 filesystems supported?
To: Roland Mainz <roland.mainz@nrubsig.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 3:47=E2=80=AFAM Roland Mainz <roland.mainz@nrubsig.=
org> wrote:
>
> On Tue, Sep 9, 2025 at 9:32=E2=80=AFPM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
> >
> > On 9/9/25 12:33 PM, Cedric Blancher wrote:
> > > On Tue, 9 Sept 2025 at 18:12, Chuck Lever <chuck.lever@oracle.com> wr=
ote:
> > >>
> > >> On 9/9/25 12:06 PM, Cedric Blancher wrote:
> > >>> Due lack of a VFS interface and the urgend use case of needing to
> > >>> export a case-insensitive filesystem via NFSv4.x, could we please g=
et
> > >>> two /etc/exports options, one setting the case-insensitive boolean
> > >>> (true, false, get-default-from-fs) and one for case-preserving (tru=
e,
> > >>> false, get-default-from-fs)?
> > >>>
> > >>> So far LInux nfsd does the WRONG thing here, and exports even
> > >>> case-insensitive filesystems as case-sensitive. The Windows NFSv4.1
> > >>> server does it correctly.
> >
> > As always, I encourage you to, first, prototype in NFSD the hard-coding
> > of these settings as returned to NFS clients to see if that does what
> > you really need with Linux-native file systems.
>
> If Cedric wants just case-insensitive mounts for a Windows NFSv4
> (Exceed, OpenText, ms-nfs41-client, ms-nfs42-client, ...), then the
> only thing needed is ext4fs or NTFS in case-insensitive mode, and that
> the Linux NFSv4.1 server sets FATTR4_WORD0_CASE_INSENSITIVE=3D=3Dtrue and
> FATTR4_WORD0_CASE_PRESERVING=3D=3Dtrue (for FAT
> FATTR4_WORD0_CASE_PRESERVING=3D=3Dfalse). Only applications using ADS
> (Alternate Data Streams) will not work, because the Linux NFS server
> does not support "OPENATTR"&co ops.
>
> If Cedric wants Windows home dirs:
> This is not working with the Linux NFSv4.1 server, because it must suppor=
t:
> - FATTR4_WORD1_SYSTEM
> - FATTR4_WORD0_ARCHIVE
> - FATTR4_WORD0_HIDDEN
> - Full ACL support, the current draft POSIX-ACLs in Linux NFSv4.1
> server&&{ ext4fs, btrfs, xfs etc. } causes malfunctions in the Windows
> "New User" profile setup (and gets you a temporary profile in
> C:\Users\*.temp+lots of warnings and a note to log out immediately
> because your user profile dir has been "corrupted")
>
> Windows home dirs with NFSv4 only work so far with the
> Solaris&&Illumos NFS servers, and maybe the FreeBSD >=3D 14 NFS server
> (not tested yet).
I'll just note that the named attribute support (the windows client
folk like the name)
along with Hidden and System are in 15 only.
And Archive is not supported because it is listed as "deprecated" in the RF=
C.
(If this case really needs it, someone should try to get it "undeprecated" =
on
nfsv4@ietf.org. I could add Archive easily. All of these are for ZFS only.
ZFS also knows case insensitive, although I have not tried it.)

rick

>
> ----
>
> Bye,
> Roland
> --
>   __ .  . __
>  (o.\ \/ /.o) roland.mainz@nrubsig.org
>   \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
>   /O /=3D=3D\ O\  TEL +49 641 3992797
>  (;O/ \/ \O;)
>

