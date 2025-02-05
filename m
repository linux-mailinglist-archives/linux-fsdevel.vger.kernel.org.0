Return-Path: <linux-fsdevel+bounces-40991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ED4A29C43
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 23:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890BE165CF6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 22:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE0721517C;
	Wed,  5 Feb 2025 22:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+hPF3gb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3851DD526;
	Wed,  5 Feb 2025 22:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738792889; cv=none; b=CUAosVO4xEldE3kL2XR2Wx4WIQEQTvrY9fofAadzzegSiLP1BYrnlvQlWTapFvzwNsRR3rVniHPQLg/QRm6IQr2NMAv9PqksDjVXieZ+ue5waoyhhDKxFxsHnlKQiXKosRv5DpYc64rYSBZBdHC/owkxZO1TO/Lm0oAUNVXpuf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738792889; c=relaxed/simple;
	bh=DLaDrx1ymzkUzSVp/m4UlBZ11W07m8Flm2xClTwZvHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMXrxTonAMZjQ2+MeD6wfureSMdm6rdjG1mNnX5aLng041XbHKuFgTY3CxsQ3ML9By9tnjP2XonXankgo6LQqezGDxEUk7vOCItfUOJJK7xrsbmu0a6oQ537SJUMmJKvQ9Mqs/ZI4a3QlPXS8miLj6a1/QxKkd0vMC7RaIy+PLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+hPF3gb; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dcebd8604bso365995a12.3;
        Wed, 05 Feb 2025 14:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738792885; x=1739397685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnjIdNHns/v6cRzRhPY12PUprVa4q8GLUEjx+e4YvFs=;
        b=W+hPF3gbhmaNR9ZJd3fOaFgIHU7CcCt1Q8wHNzr2qjP1YUn+4UU4OnmOn6PAwYpmlg
         XNVAkdWii+mIM5x0BhGdDrky4npaSXFUJ/UhgUjTCeP9OPPNOrvhYYBsXz0IZqU1XzTR
         vXsU1GtFGZUIZR99ikQpvK9lW47fCN8/Zf04VmRQOd2vDXqGVMf1uKh8R4WUsHt+QO2i
         fr5R2GkfTeaUUgAg/XEgU/GLGMR2gFMQ6ujAjic4j/uxAJwV8t9CrOb/b/VeqzWKfmAl
         Ht2jqIG9vOMRe+TzTXUjwbnmWLIuRLBbb3ELCpAMvsW7Tq7Jtca9eyTQ6CmquIqdfn0a
         brCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738792885; x=1739397685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnjIdNHns/v6cRzRhPY12PUprVa4q8GLUEjx+e4YvFs=;
        b=j8eOatHfgD81PPN7l3el5seoGhHskCm3EX1eQevASnKUbogVxanGcNoBXFBGllpqyX
         DDakO35hNo+pRuOmcY9Cxub2aGWCEWixt/7t6ioNP4tDpDtX8ABRdxpSpVQ3OYGKWyII
         v8szw3hZiajemvH2mMhHqg5Ua8zceUGyCWffFfArN/mp8UOKWJWQkR5uo0fbAEctOXju
         /TDZAH2jr7vdKpLFC+fKAJfhDV8aRKJid7iwcPKN5cb2mLTny+YEIqrdUu3/cA5h8GVv
         Onbi29R9L/4exPQ5qJdlESQ2MSU3gMHGYCkal/1P5EipYVpqyiMhifOk2d3WykjLr+3R
         xDhg==
X-Forwarded-Encrypted: i=1; AJvYcCVzMA+sQzdPTeKcN1pOi3b/3sHvXcGYliJE4HVueXWW/gjljg9PKxZvPpFjbL53hdAY7VnXgCZRNrOn@vger.kernel.org, AJvYcCXHHeZmroybiParukFe0TogkYoSMAOr56VDacrteuxirFVByQ4tEYnWeaTUSq+jVaX2aa7sPtQFw8QpuPFS@vger.kernel.org, AJvYcCXk4RSU9pQn0Subfzm4r3Wi5uKd+4c4XRToV7OSWB3xQHJE3nO5CHc2xBCeq4usHamTAjDnE0oBMxz9OHCLIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwY366+hPJPfp/pywZRNF7GnDmpWDDWHgc2d9o3uLIU2RExBm8A
	A/jRfJb5lFkAXW/xsqfFJeDx9FTToCHYl72xb7iSPO1/Tlp0s8PAaJ5zy6TLZ27dNiKw/otN+ev
	nJ7p1Z/jqdMJ0/ZfmAkn/lM2uj9AGPeRhNIg=
X-Gm-Gg: ASbGncuWF04Us/J2gRosAMJp9MsZ8OmfD2x9Fw6EQNMbKwUDQO0emGUPRRZQLvSWlEt
	VGH9YJLirx5uTuACgol3viVJ9QOFKW6HEfSXYQtyRO1C3PCv0ZdhqSALlt+rKngIubOodSzSD
X-Google-Smtp-Source: AGHT+IGrj/nSPrWNFvwnS4jyD0PejaC8xi7+HsXw6p1BCAcFZK20LBJBmJT9arjMRNuBWmLJUqLUG2PTftxmhQFSlEo=
X-Received: by 2002:a05:6402:528c:b0:5dc:7538:3c0 with SMTP id
 4fb4d7f45d1cf-5dcdb6fa4e5mr11507577a12.4.1738792885016; Wed, 05 Feb 2025
 14:01:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxhh1LDz5zXzqFENPhJ9k851AL3E7Xc2d7pSVVYX4Fu9Jw@mail.gmail.com>
 <20250117185947.ylums2dhmo3j6hol@pali> <20250202152343.ahy4hnzbfuzreirz@pali>
 <CAOQ4uxgjbHTyQ53u=abWhyQ81ATL4cqSeWKDfOjz-EaR0NGmug@mail.gmail.com>
 <20250203221955.bgvlkp273o3wnzmf@pali> <CAOQ4uxhkB6oTJm7DvQxFbxkQ1u_KMUFEL0eWKVYf39hnuYrnfQ@mail.gmail.com>
 <20250203233403.5a5pcgl5xylj47nb@pali> <CAOQ4uxisXgDOuE1oDH6qtLYoiFeG55kjpUJaXDxZ+tp2ck++Sg@mail.gmail.com>
 <20250204212638.3hhlbc5muutnlluw@pali> <CAOQ4uxg5k5FP43y93FRujj54kVk8TyXD2AeO_VFJ2m+aB=b1_Q@mail.gmail.com>
 <20250205181645.4ps3kzafyasg4dgj@pali>
In-Reply-To: <20250205181645.4ps3kzafyasg4dgj@pali>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 5 Feb 2025 23:01:13 +0100
X-Gm-Features: AWEUYZnmLX3GPJ1ohnud4ivBzV02bJ06lbpI49PMwuBLfcyBPMgZpWfstrB3Et8
Message-ID: <CAOQ4uxg96LRqneKvNVH4S97OfaGt=yNbntgqHk6E=T-fojeOAA@mail.gmail.com>
Subject: Re: Immutable vs read-only for Windows compatibility
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, ronnie sahlberg <ronniesahlberg@gmail.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 7:16=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org> wr=
ote:
>
> On Wednesday 05 February 2025 17:33:30 Amir Goldstein wrote:
> > On Tue, Feb 4, 2025 at 10:26=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.or=
g> wrote:
> > >
> > > On Tuesday 04 February 2025 12:54:01 Amir Goldstein wrote:
> > > > On Tue, Feb 4, 2025 at 12:34=E2=80=AFAM Pali Roh=C3=A1r <pali@kerne=
l.org> wrote:
> > > > >
> > > > > On Tuesday 04 February 2025 00:02:44 Amir Goldstein wrote:
> > > > > > On Mon, Feb 3, 2025 at 11:20=E2=80=AFPM Pali Roh=C3=A1r <pali@k=
ernel.org> wrote:
> > > > > > >
> > > > > > > On Monday 03 February 2025 22:59:46 Amir Goldstein wrote:
> > > > > > > > On Sun, Feb 2, 2025 at 4:23=E2=80=AFPM Pali Roh=C3=A1r <pal=
i@kernel.org> wrote:
> > > > > > > > > And there is still unresolved issue with FILE_ATTRIBUTE_R=
EADONLY.
> > > > > > > > > Its meaning is similar to existing Linux FS_IMMUTABLE_FL,=
 just
> > > > > > > > > FILE_ATTRIBUTE_READONLY does not require root / CAP_LINUX=
_IMMUTABLE.
> > > > > > > > >
> > > > > > > > > I think that for proper support, to enforce FILE_ATTRIBUT=
E_READONLY
> > > > > > > > > functionality, it is needed to introduce new flag e.g.
> > > > > > > > > FS_IMMUTABLE_FL_USER to allow setting / clearing it also =
for normal
> > > > > > > > > users without CAP_LINUX_IMMUTABLE. Otherwise it would be =
unsuitable for
> > > > > > > > > any SMB client, SMB server or any application which would=
 like to use
> > > > > > > > > it, for example wine.
> > > > > > > > >
> > > > > > > > > Just to note that FreeBSD has two immutable flags SF_IMMU=
TABLE and
> > > > > > > > > UF_IMMUTABLE, one settable only by superuser and second f=
or owner.
> > > > > > > > >
> > > > > > > > > Any opinion?
> > > > > > > >
> > > > > > > > For filesystems that already support FILE_ATTRIBUTE_READONL=
Y,
> > > > > > > > can't you just set S_IMMUTABLE on the inode and vfs will do=
 the correct
> > > > > > > > enforcement?
> > > > > > > >
> > > > > > > > The vfs does not control if and how S_IMMUTABLE is set by f=
ilesystems,
> > > > > > > > so if you want to remove this vfs flag without CAP_LINUX_IM=
MUTABLE
> > > > > > > > in smb client, there is nothing stopping you (I think).
> > > > > > >
> > > > > > > Function fileattr_set_prepare() checks for CAP_LINUX_IMMUTABL=
E when
> > > > > > > trying to change FS_IMMUTABLE_FL bit. This function is called=
 from
> > > > > > > ioctl(FS_IOC_SETFLAGS) and also from ioctl(FS_IOC_FSSETXATTR)=
.
> > > > > > > And when function fileattr_set_prepare() fails then .fileattr=
_set
> > > > > > > callback is not called at all. So I think that it is not poss=
ible to
> > > > > > > remove the IMMUTABLE flag from userspace without capability f=
or smb
> > > > > > > client.
> > > > > > >
> > > > > >
> > > > > > You did not understand what I meant.
> > > > > >
> > > > > > You cannot relax the CAP_LINUX_IMMUTABLE for setting FS_IMMUTAB=
LE_FL
> > > > > > and there is no reason that you will need to relax it.
> > > > > >
> > > > > > The vfs does NOT enforce permissions according to FS_IMMUTABLE_=
FL
> > > > > > The vfs enforces permissions according to the S_IMMUTABLE in-me=
mory
> > > > > > inode flag.
> > > > > >
> > > > > > There is no generic vfs code that sets S_IMMUTABLE inode flags,=
 its
> > > > > > the filesystems that translate the on-disk FS_IMMUTABLE_FL to
> > > > > > in-memory S_IMMUTABLE inode flag.
> > > > > >
> > > > > > So if a filesystem already has an internal DOSATTRIB flags set,=
 this
> > > > > > filesystem can set the in-memory S_IMMUTABLE inode flag accordi=
ng
> > > > > > to its knowledge of the DOSATTRIB_READONLY flag and the
> > > > > > CAP_LINUX_IMMUTABLE rules do not apply to the DOSATTRIB_READONL=
Y
> > > > > > flag, which is NOT the same as the FS_IMMUTABLE_FL flag.
> > > > > >
> > > > > > > And it would not solve this problem for local filesystems (nt=
fs or ext4)
> > > > > > > when Samba server or wine would want to set this bit.
> > > > > > >
> > > > > >
> > > > > > The Samba server would use the FS_IOC_FS[GS]ETXATTR ioctl
> > > > > > API to get/set dosattrib, something like this:
> > > > > >
> > > > > > struct fsxattr fsxattr;
> > > > > > ret =3D ioctl_get_fsxattr(fd, &fsxattr);
> > > > > > if (!ret && fsxattr.fsx_xflags & FS_XFLAG_HASDOSATTR) {
> > > > > >     fsxattr.fsx_dosattr |=3D fs_dosattrib_readonly;
> > > > > >     ret =3D ioctl_set_fsxattr(fd, &fsxattr);
> > > > > > }
> > > > >
> > > > > Thanks for more explanation. First time I really did not understo=
od it.
> > > > > But now I think I understood it. So basically there would be two =
flags
> > > > > which would result in setting S_IMMUTABLE on inode. One is the ex=
isting
> > > > > FS_IMMUTABLE_FL which requires the capability and some new flag (=
e.g.
> > > > > FS_XFLAG_HASDOSATTR) which would not require it and can be implem=
ented
> > > > > for cifs, vfat, ntfs, ... Right?
> > > > >
> > > >
> > > > Well, almost right.
> > > > The flag that would correspond to FILE_ATTRIBUTE_READONLY
> > > > is FS_DOSATTRIB_READONLY from the new field fsx_dosattrib
> > > > (see below)
> > >
> > > Thank you for example, it is for sure good starting point for me.
> > >
> > > > --- a/include/uapi/linux/fs.h
> > > > +++ b/include/uapi/linux/fs.h
> > > > @@ -145,7 +145,8 @@ struct fsxattr {
> > > >         __u32           fsx_nextents;   /* nextents field value (ge=
t)   */
> > > >         __u32           fsx_projid;     /* project identifier (get/=
set) */
> > > >         __u32           fsx_cowextsize; /* CoW extsize field value =
(get/set)*/
> > > > -       unsigned char   fsx_pad[8];
> > > > +       __u32           fsx_dosattrib;  /* dosattrib field value (g=
et/set) */
> > > > +       unsigned char   fsx_pad[4];
> > > >  };
> > > >
> > > >  /*
> > > > @@ -167,7 +168,16 @@ struct fsxattr {
> > > >  #define FS_XFLAG_FILESTREAM    0x00004000      /* use filestream a=
llocator */
> > > >  #define FS_XFLAG_DAX           0x00008000      /* use DAX for IO *=
/
> > > >  #define FS_XFLAG_COWEXTSIZE    0x00010000      /* CoW extent size
> > > > allocator hint */
> > > > -#define FS_XFLAG_HASATTR       0x80000000      /* no DIFLAG for th=
is   */
> > > > +#define FS_XFLAG_HASATTR       0x80000000      /* has extended att=
ributes */
> > > > +
> > > > +/*
> > > > + * Flags for the fsx_dosattrib field
> > > > + */
> > > > +#define FS_DOSATTRIB_READONLY  0x00000001      /* R - read-only */
> > > > +#define FS_DOSATTRIB_HIDDEN    0x00000002      /* H - hidden */
> > > > +#define FS_DOSATTRIB_SYSTEM    0x00000004      /* S - system */
> > > > +#define FS_DOSATTRIB_ARCHIVE   0x00000020      /* A - archive */
> > > > +#define FS_DOSATTRIB_HASATTR   0x80000000      /* has dos attribut=
es */
> > >
> > > Should these FS_DOSATTRIB_* constants follows the Windows
> > > FILE_ATTRIBUTE_* constants? Because I see that you put a gap between
> > > system and archive.
> > >
> >
> > Well, no, they do not need to follow Windows contestants,
> > but then again, why not?
>
> I have just few cons:
> - there are gaps and unused bits (e.g. FILE_ATTRIBUTE_VOLUME)
> - there are bits which have more meanings (FILE_ATTRIBUTE_EA / FILE_ATTRI=
BUTE_RECALL_ON_OPEN)
> - there are bits used only by WinAPI and not by NT / SMB
> - there are bits which have different NT meaning in readdir() and in stat=
()
> - there are bits for which we already have FS_IOC_GETFLAGS API
>

valid points

> I think it that is is bad a idea if bit N in our ioctl() would have
> different meaning than in our statx().
>

definitely not, but I am not sure which bits you are referring to,

> Should we duplicate FS_IOC_GETFLAGS FS_COMPR_FL and FS_ENCRYPT_FL into
> that new fsx_dosattrib? For me it sounds like that it is a better idea
> to have compression bit and encryption bit only in one field and not
> duplicated.
>

No duplicates, of course, but notice there are no XFLAG for COMPR
and ENCRYPT.

The FS_IOC_[GS]ETFLAGS are a different alternative API.
It does not matter if you define them in fsx_xflags or on fsx_dosattrib
they will not be a duplicate of the FS_COMPR_FL flags, same as
FS_XFLAG_APPEND is not a duplicate of FS_APPEND_FL
it is a different API to control the same on-disk flag.
But you will need to include COMPRT/CRYPT in the
FS_XFLAG_COMMON masks, so the fsx_xflags probably makes
more sense.


> But we can slightly follow Windows constants. Not exactly, but remove
> redundancy, remove reserved bits, modify bits to have exactly one
> meaning, etc... So basically do some sane modifications.
>

Yep, conformity for the sake of conformity.
No hard rules.

> > I mean if we only ever needed the 4 RHSA bits above, we could
> > have used the FS_XFLAG_* flags space, but if we extend the API
> > with a new 32bit field, why not use 1-to-1 mapping at least as a starti=
ng point.
>
> I understand it, for me it looks also a good idea, just needs to resolve
> those problems above... and it would result in incompatibility that it
> would not be 1-to-1 mapping at the end.
>
> > You can see that it is quite common that filesystems re-define the
> > same constants for these flags (e.g. EXT4_IMMUTABLE_FL).
> > I am a bit surprised that there is no build time assertion
> > BUILD_BUG_ON(EXT4_IMMUTABLE_FL !=3D FS_IMMUTABLE_FL)
> > which would be the standard way to make sure that the constants
> > stay in sync if they need to be in sync, but some filesystems don't
> > even assume that these constants are in sync (e.g. f2fs_fsflags_map)
> >
> > > > This last special flag is debatable and I am not really sure that w=
e need it.
> > >
> > > This constant has very similar meaning to FILE_ATTRIBUTE_NORMAL. Both
> > > has some compatibility meaning that "field is valid or something is s=
et".
> > > Just FILE_ATTRIBUTE_NORMAL is not 31th bit.
> > >
> >
> > No it does not. I don't think that you understood the meaning of
> > FS_DOSATTRIB_HASATTR.
> > Nevermind it was a bad idea anyway. see more below.
> >
> > > > It is needed for proper backward compat with existing userspace too=
ls.
> > > > For example, if there was a backup tool storing the fsxattr blob re=
sult of
> > > > FS_IOC_FSGETXATTR and sets it later during restore with
> > > > FS_IOC_FSSETXATTR, then it would be better to ignore a zero
> > > > value of fsx_dosattrib instead of resetting all of the on-disk dosa=
ttrib flags
> > > > if the restore happens after ntfs gained support for setting dosatt=
rib flags
> > > > via FS_IOC_FSSETXATTR.
> > > >
> > > > When using the standard tools to set fsxattr (chattr and xfs_io -c =
chattr)
> > > > the tool does FS_IOC_FSGETXATTR + modify + FS_IOC_FSSETXATTR,
> > > > so those tools are expected to leave new bits in fsx_dosattrib at t=
heir
> > > > value if ntfs gains support for get/set fsx_dosattrib.
> > > >
> > > > Setting the auxiliary FS_DOSATTRIB_HASATTR flag can help the
> > > > kernel/fs to explicitly state that the values returned in fsx_dosat=
trib
> > > > are valid and the tool to state that values set in fsx_dosattrib ar=
e valid.
> > > > But using a single flag will not help expanding ntfs support for mo=
re
> > > > fsx_dosattrib flags later, so I am not sure if it is useful (?).
> > >
> > > If the fsx_dosattrib would match all FILE_ATTRIBUTE_* then we can do =
it
> > > as the ntfs matches FILE_ATTRIBUTE_* and no extension is needed for
> > > future.
> > >
> > > And I think that this backward compatibility sounds good.
> > >
> >
> > That's only true if you can support ALL the dosattrib flags from the
> > first version and that Windows will not add any of the reserved
> > flags in the future, which is hard to commit to.
>
> I see, it would not work. And Windows will for sure use some reserved
> bits in future.
>
> > > What could be useful for userspace is also ability to figure out whic=
h
> > > FS_DOSATTRIB_* are supported by the filesystem. Because for example U=
DF
> > > on-disk format supports only FS_DOSATTRIB_HIDDEN bit. And FAT only th=
ose
> > > attributes which are in the lowest byte.
> > >
> >
> > Exactly.
> > statx has this solved with the stx_attributes_mask field.
> >
> > We could do the same for FS_IOC_FS[GS]ETXATTR, but because
> > right now, this API does not verify that fsx_pad is zero, we will need =
to
> > define a new set of ioctl consants FS_IOC_[GS]ETFSXATTR2
> > with the exact same functionality but that userspace knows that they
> > publish and respect the dosattrib mask:
>
> I understand and this is a problem.
>
> > --- a/fs/ioctl.c
> > +++ b/fs/ioctl.c
> > @@ -868,9 +868,11 @@ static int do_vfs_ioctl(struct file *filp, unsigne=
d int fd,
> >         case FS_IOC_SETFLAGS:
> >                 return ioctl_setflags(filp, argp);
> >
> > +       case FS_IOC_GETFSXATTR2:
> >         case FS_IOC_FSGETXATTR:
> >                 return ioctl_fsgetxattr(filp, argp);
> >
> > +       case FS_IOC_SETFSXATTR2:
> >         case FS_IOC_FSSETXATTR:
> >                 return ioctl_fssetxattr(filp, argp);
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -145,7 +145,8 @@ struct fsxattr {
> >         __u32           fsx_nextents;   /* nextents field value (get)  =
 */
> >         __u32           fsx_projid;     /* project identifier (get/set)=
 */
> >         __u32           fsx_cowextsize; /* CoW extsize field value (get=
/set)*/
> > -       unsigned char   fsx_pad[8];
> > +       __u32           fsx_dosattrib;  /* dosattrib field value (get/s=
et) */
> > +       __u32           fsx_dosattrib_mask; /* dosattrib field validity=
 mask */
> >  };
> >
> >  /*
> > @@ -238,6 +248,9 @@ struct fsxattr {
> >  #define FS_IOC32_SETFLAGS              _IOW('f', 2, int)
> >  #define FS_IOC32_GETVERSION            _IOR('v', 1, int)
> >  #define FS_IOC32_SETVERSION            _IOW('v', 2, int)
> > +#define FS_IOC_GETFSXATTR2              _IOR('x', 31, struct fsxattr)
> > +#define FS_IOC_SETFSXATTR2              _IOW('x', 32, struct fsxattr)
> > +/* Duplicate legacy ioctl numbers for backward compact */
> >  #define FS_IOC_FSGETXATTR              _IOR('X', 31, struct fsxattr)
> >  #define FS_IOC_FSSETXATTR              _IOW('X', 32, struct fsxattr)
> >  #define FS_IOC_GETFSLABEL              _IOR(0x94, 49, char[FSLABEL_MAX=
])
> >
> > We could also use this opportunity to define a larger fsxattr2 struct
> > that also includes an fsx_xflags_mask field, so that the xflags namespa=
ce
> > could also be extended in a backward compat way going forward:
> >
> > @@ -145,7 +145,21 @@ struct fsxattr {
> >         __u32           fsx_nextents;   /* nextents field value (get)  =
 */
> >         __u32           fsx_projid;     /* project identifier (get/set)=
 */
> >         __u32           fsx_cowextsize; /* CoW extsize field value (get=
/set)*/
> >         unsigned char   fsx_pad[8];
> >
> >  };
> > +
> > +/*
> > + * Structure for FS_IOC_[GS]ETFSXATTR2.
> > + */
> > +struct fsxattr2 {
> > +       __u32           fsx_xflags;     /* xflags field value (get/set)=
 */
> > +       __u32           fsx_extsize;    /* extsize field value (get/set=
)*/
> > +       __u32           fsx_nextents;   /* nextents field value (get)  =
 */
> > +       __u32           fsx_projid;     /* project identifier (get/set)=
 */
> > +       __u32           fsx_cowextsize; /* CoW extsize field value (get=
/set)*/
> > +       __u32           fsx_xflags_mask; /* xflags field validity mask =
*/
> > +       __u32           fsx_dosattrib;  /* dosattrib field value (get/s=
et) */
> > +       __u32           fsx_dosattrib_mask; /* dosattrib field validity=
 mask */
> > +};
> >
> > And you'd also need to flug those new mask and dosattrib
> > via struct fileattr into filesystems - too much to explain.
> > try to figure it out (unless someone objects) and if you can't figure
> > it out let me know.
>
> Yea, I think that this is thing which I should be able to figure out
> once I start changing it.
>
> Anyway, I have alternative idea to the problem with fsx_pad. What about
> introducing new fsx_xflags flag which would say that fsx_pad=3Dfsx_dosatt=
rib
> is present? E.g.
>
> #define FS_XFLAG_HASDOSATTRIB 0x40000000
>
> Then we would not need new FS_IOC_GETFSXATTR2/FS_IOC_SETFSXATTR2 ioctls.
>
> Also fsx_pad has 8 bytes, which can store both attrib and mask, so new
> struct fsxattr2 would not be needed too.
>

As I wrote in the other response, this can work, but has some pitfalls.

Thanks,
Amir.

