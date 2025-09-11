Return-Path: <linux-fsdevel+bounces-60897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F86B52B32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 10:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16611C212ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 08:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAAF2D5C86;
	Thu, 11 Sep 2025 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktb4W/6Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95F22C3258;
	Thu, 11 Sep 2025 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757578094; cv=none; b=JiFBxrhuewNGKdzWKF96i8nhHt+/jPa6dhzuXxqRMKipgyLKTRBTlnKwhCgNInzdylYO/peeIkP3xrhEvRcDH9CPQZxYUSNu1a+x8JmIySn2wSQ/y6RketIaibFWflJg5BgLOJZMJyK4SjbZAaZSpiLbCSv3Lj5KjQJkmU/Ng3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757578094; c=relaxed/simple;
	bh=6ULBULBFFjI9uaDHpn8mS96tB7ILDHF0ZXJ+Ok6QDdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=BOYQ/zuhStbtOnaQUZAA4/mouS6H/024YCqCY4sDclt+hM3e5ldeJlfRp6l+4jNSAFvPVUlu/xlBQXCgZ2yAm+7Vj4e0jqptVpV3V6JtIz41AHT/FUjutHn80aR89tSJYydaT29DvMSG5jBmVQfsqIJ5dKKiE/D3y21hvZRuu6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktb4W/6Q; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-61bd4a3f39cso96714eaf.0;
        Thu, 11 Sep 2025 01:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757578091; x=1758182891; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ULBULBFFjI9uaDHpn8mS96tB7ILDHF0ZXJ+Ok6QDdc=;
        b=ktb4W/6Qbxt8GV+x2FEGa1SM5ZnE6ABFPEant3wH7b4MizKSaERYdSGh2obuMEqxuA
         wrSYpxb2YGjUm04+Y9yhopAH1AF9xCfTOYONGEmfWAyuUdTN08CjLei6+hCgtuYg+kjt
         dHlzKmoAaBjS/PCAKWYBbAgezT8fT0aDZ54xsOxlgcSdbD2hAo4hQMFPHErcvco014ST
         q0i/p8f4fuVTBFy6Lze9uaRvZSSXGqcTTUWWPxQyvoKwoyOesi3d981kbM8EqxeuAUiw
         b0KcEv/93zFozEUJhHoZGvAnuapdPnlAMKqByGiQOhJ9EcSwtdribCDiZfE/CpmyThRa
         IMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757578091; x=1758182891;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ULBULBFFjI9uaDHpn8mS96tB7ILDHF0ZXJ+Ok6QDdc=;
        b=Z/woxf2Hc6YF9jU3cFUN/Kaa555Lu4AVB3N4fTnbh0HZYZFeWu5RKFLaEmupk/A2zJ
         1EZuEcGwig4Mg17HEi+5UrjGmrK6jxvH1gpoi59F3WitADKK+uSZmHm10RvG9I25UWLu
         51q1LlKS2B3nR++DcyRxNwwBnrGI+dA8gVwwZQ9ME+fiNC5NJpPr7MZpnbnk1IkJrPIf
         zpvfPqz69Bd8fpHatbIfiJLG38173sgAV1OG2Kr/E7v8zZEfeIB/Gi07YJ4uPBCAgEQv
         +8s6Q7SZxfuMYTm8DG7H8J2snlAqeQxFTCa77Ys0jDsYzuxBrUnsjJ49fjaQR6TAh+22
         NdGA==
X-Forwarded-Encrypted: i=1; AJvYcCXFWgacuPrveBXP6hw1yoo6n6gWcuvP7IApjVkoRvwk8mzUDOWshGOBaXk1SzEIjbu6tQxqHHeYzB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4IjBRHuAPPTp5fCniqUuC3QW14zpX24ukDySKgaOu8vYmk+Ud
	flnWtq1E6NAqxX5oBuRLd8IQNMJrQ4of5IYn02PugPgzgf9UKioYLvfWIS2OImEBAQNK9oFYtTg
	ZRuNmgZMYzZx97HVNqepr5P60Q+OtD2KBkw==
X-Gm-Gg: ASbGncvxiFYaNB91NBqQ3VHYM9gxO4yCPv8LuE5vsY/GyjxKrWCVCTW9ZQGSSGfXGSs
	gk3CPy8zNpRRfGhLyR2M2V1XcOOlbmtt4YXKKwnENJTWvGXq77Ycx+HJeQpU9KC+Vk79TyvhneB
	YDVNnvqyVt8FNsg+r86WoS8HEsg7WnGrhz6S5cvfKSycDjTPcFWUx2W6QtMgpZZ8wGiwF0HmptQ
	R48xlA=
X-Google-Smtp-Source: AGHT+IEwR8uLLqKCt//ZYIG47ZIqvHUx4GV3seKH8J5nwfelseoGl6ksRH/8zqGAiVTzsHLiCIJee8/GvpDuXfrrZpE=
X-Received: by 2002:a05:6871:521e:b0:319:c5fd:44de with SMTP id
 586e51a60fabf-3226480d739mr9682400fac.26.1757578090679; Thu, 11 Sep 2025
 01:08:10 -0700 (PDT)
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
 <CAM5tNy7w71r6WgWOz4tXtLi=yvw55t_5dFe_x-13Thy5NgjEGA@mail.gmail.com>
In-Reply-To: <CAM5tNy7w71r6WgWOz4tXtLi=yvw55t_5dFe_x-13Thy5NgjEGA@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Thu, 11 Sep 2025 10:07:00 +0200
X-Gm-Features: AS18NWCuGUzc4egDyLe6O_WKEjI_fYAV9Afl2vBeDhyvSgKqMl3ZzUpNomTG3UU
Message-ID: <CALXu0Uep=q9mu1suZ0r04MGJn-xRn2twiRtQbGgtr1eZ7D_6sg@mail.gmail.com>
Subject: fattr4_archive "deprecated" ? Re: NFSv4.x export options to mark
 export as case-insensitive, case-preserving? Re: LInux NFSv4.1 client and
 server- case insensitive filesystems supported?
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Sept 2025 at 15:38, Rick Macklem <rick.macklem@gmail.com> wrote:
>
> On Wed, Sep 10, 2025 at 3:47=E2=80=AFAM Roland Mainz <roland.mainz@nrubsi=
g.org> wrote:
> >
> > On Tue, Sep 9, 2025 at 9:32=E2=80=AFPM Chuck Lever <chuck.lever@oracle.=
com> wrote:
> > >
> > > On 9/9/25 12:33 PM, Cedric Blancher wrote:
> > > > On Tue, 9 Sept 2025 at 18:12, Chuck Lever <chuck.lever@oracle.com> =
wrote:
> > > >>
> > > >> On 9/9/25 12:06 PM, Cedric Blancher wrote:
> > > >>> Due lack of a VFS interface and the urgend use case of needing to
> > > >>> export a case-insensitive filesystem via NFSv4.x, could we please=
 get
> > > >>> two /etc/exports options, one setting the case-insensitive boolea=
n
> > > >>> (true, false, get-default-from-fs) and one for case-preserving (t=
rue,
> > > >>> false, get-default-from-fs)?
> > > >>>
> > > >>> So far LInux nfsd does the WRONG thing here, and exports even
> > > >>> case-insensitive filesystems as case-sensitive. The Windows NFSv4=
.1
> > > >>> server does it correctly.
> > >
> > > As always, I encourage you to, first, prototype in NFSD the hard-codi=
ng
> > > of these settings as returned to NFS clients to see if that does what
> > > you really need with Linux-native file systems.
> >
> > If Cedric wants just case-insensitive mounts for a Windows NFSv4
> > (Exceed, OpenText, ms-nfs41-client, ms-nfs42-client, ...), then the
> > only thing needed is ext4fs or NTFS in case-insensitive mode, and that
> > the Linux NFSv4.1 server sets FATTR4_WORD0_CASE_INSENSITIVE=3D=3Dtrue a=
nd
> > FATTR4_WORD0_CASE_PRESERVING=3D=3Dtrue (for FAT
> > FATTR4_WORD0_CASE_PRESERVING=3D=3Dfalse). Only applications using ADS
> > (Alternate Data Streams) will not work, because the Linux NFS server
> > does not support "OPENATTR"&co ops.
> >
> > If Cedric wants Windows home dirs:
> > This is not working with the Linux NFSv4.1 server, because it must supp=
ort:
> > - FATTR4_WORD1_SYSTEM
> > - FATTR4_WORD0_ARCHIVE
> > - FATTR4_WORD0_HIDDEN
> > - Full ACL support, the current draft POSIX-ACLs in Linux NFSv4.1
> > server&&{ ext4fs, btrfs, xfs etc. } causes malfunctions in the Windows
> > "New User" profile setup (and gets you a temporary profile in
> > C:\Users\*.temp+lots of warnings and a note to log out immediately
> > because your user profile dir has been "corrupted")
> >
> > Windows home dirs with NFSv4 only work so far with the
> > Solaris&&Illumos NFS servers, and maybe the FreeBSD >=3D 14 NFS server
> > (not tested yet).
> I'll just note that the named attribute support (the windows client
> folk like the name)
> along with Hidden and System are in 15 only.
> And Archive is not supported because it is listed as "deprecated" in the =
RFC.
> (If this case really needs it, someone should try to get it "undeprecated=
" on
> nfsv4@ietf.org. I could add Archive easily. All of these are for ZFS only=
.
> ZFS also knows case insensitive, although I have not tried it.)

Who (name!) had the idea to declare fattr4_archive as "deprecated"? It
was explicitly added for Windows and DOS compatibility in NFSv4, and
unlike Windows EAs (which are depreciated, and were superseded by
"named streams") the "archive" attribute is still in use.

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

