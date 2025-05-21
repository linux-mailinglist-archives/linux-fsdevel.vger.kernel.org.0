Return-Path: <linux-fsdevel+bounces-49567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29647ABF016
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 11:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495374E2F65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 09:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFA7248888;
	Wed, 21 May 2025 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dz+d7TJO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C582367AC;
	Wed, 21 May 2025 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747820206; cv=none; b=oxGxkuOMFVwq7qrNBChNotwJR6Qw3ZXqxhAgWBL02pKUMXkcHiiIembwIVnlSkjPRppADLtHAD+WigJshcaXaPomTE5BqcPD1R0c2rBkfmTDEw1yAwS2V8BY5VuDo2023sEX8JVM3nsKkIycM6ScolSuza2YqR4jEBjXqXL04t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747820206; c=relaxed/simple;
	bh=e9mhTzPo8UBltwt4IxdWmpzOcMesj+ao1kr0nV4Kb2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LsKDJmn7Q1KjftyEr/eSpejXopvTi9ExEaSlj7F15KMG/5FCRkS7oOlLqHMvPFqxJ5v6P7IVHGBilnv77YumagReWVE0D08w3GBwud7xwLJpkaPOhYsLqYgl+z37XVV1/wL0MPZOIvDibwmVnwlce3OQs0fgJd3z9rmt04WTc2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dz+d7TJO; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-acae7e7587dso944210866b.2;
        Wed, 21 May 2025 02:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747820203; x=1748425003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fDT/rPyS09cFNKeRhfGuyH5tO25pffu2I+mqbu+oKo=;
        b=dz+d7TJOmlYNJrO/T4tS2+Q+GkNgDAipNmz1+/g0jvAU6mnO6xVsikxMxEp8tMtXDS
         JfUYLfmDiEGkF/WCc4rnZ+LHbRQpKsnHaJODxH1adlGf96R75/EF3dvjZjIv1Srj5HhO
         soh/NhgLelMKyXSbJITC6R9lPQkKmW4WbS4bgfYeKL94LW5y9Dt5nzlYCOQFJZ0DUwHp
         lSXiqtJmVCClSyFvT09SxAT5LmPAehaDv+bfqMky2t93D3qXOfREfAfMvvozcFoRgYgI
         igw/qCcPMuMCxx/p1R3Z+b0zqkDRpyk6kklr5UlpzgdTpcKSn9mqsUbmJ8HVA3YlL1/Z
         WNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747820203; x=1748425003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fDT/rPyS09cFNKeRhfGuyH5tO25pffu2I+mqbu+oKo=;
        b=nogLqF467GdwPiHWU2AMjKNNO89JOBbgnNTrhKv7E4KdmyspVSKmbO8OdDnGxdGXGo
         OH1kJem2SdQ3zzVCvBQ0fUWcLBwjIKxw6a2ydChHZTKMmViD0QeE/wob1gnz5VccCfCf
         oKK3h3K5U+rwyNFrznV9dfGqLFP8Gt6Q9BKa8I3uzc6effmHpGB6wC67q2L8QdzC4jCq
         7IFXCoXmha4MBhvinNcMUa0GaaqJkJWk+ViPUv2rOsr/Uj/3AIiOOEMm7A2Ve5X1Ym+M
         U4FTTijUnK2p9SqBdpe9N6zzow2qg9uGUp9XXjgRPavqRqI50oQDTLKKNl74YCQFN/f2
         urrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU22yq1RLXHrItJYaRuN6CDyxncobuw/jTc0tAOInduPQzHciHei4sG7OQgWY+rmE8J/EIcvYeFR4Lp3V0=@vger.kernel.org, AJvYcCUX8SYeVYPbeBkC3IXj+AYUYWreBfdn4dg0nUJzUVqsx2Im9vYpRmO8x0Ft0MjJSAwQk/ba2AcLbes=@vger.kernel.org, AJvYcCUuGH7GFdKX4ciDwVcKCawQroBA+BCV0Jv+5e2EU0Sif8gjv6JNhNsmKN867ifwTG9i7diE34o/VyuJGA==@vger.kernel.org, AJvYcCVDSPQIwzVB2Weg6kW0yJiBudW1oYV3gMQ+Z+ZGs1wc/K1glhaOMwcMT/7cAnEL62xIshn9jdW1d7JP2A==@vger.kernel.org, AJvYcCVkTv5SUygNKAJy1mZhuL054mljQI4i0oMXrJh2Gw+pVDBYaWVnumGPQwuonYp8TsM37GB16CznfA==@vger.kernel.org, AJvYcCW4g98MZS14CpsisoJ7/YzOU+xYsce/Yf3zuB9jOy1GD2NWPsVO9MsqbOM/xwlUEnzrWBLm2kVO7bpzFQw6@vger.kernel.org, AJvYcCWCdnDHBIvBHQXKDsaTadkGRen9lJzgdDFOMv38lgXz6NSWFXsryDsWQyU1zxcxwfH641nmqNKRM6fE9ch+@vger.kernel.org, AJvYcCWMpMt3AWtfKJbJqdg8p/eUGtZahp5ZEi8TJ5Fosm6W7xO7IEkWj/aSCP2r3qHA2yms6DzRvzWeRg==@vger.kernel.org, AJvYcCWit1kcfXV3mb0yWac/xGJOvX0cmL3QvLjxpWBDxrGEK5R61UfJ6ckwe1zWe71fl92OFhL6ztbw6hbbpQ==@vger.kernel.org, AJvYcCXReKL/XrPpTiffB16A6vEP
 bid1kG5h92P9MgkccUBkFrr/154CqIUpPMncw/HEURvCGrJ3akiEaX2DYIOvEw==@vger.kernel.org, AJvYcCXTRbfeDGWgQ/MXjelsFuH4bnF2wLkPSRIFXQXG/Hrdvmu/3aWi9RuCYSTx5obbB5BMcJMCOtm7lBX5@vger.kernel.org, AJvYcCXtc4FQjxS/WTY+WIImp+OpsRwU2MLtxLR5K8MV/OA3etGNlh2NbAWV27RvLopwP5ADDRRbgJbxdUcodXXw1RwVBY7IgfJN@vger.kernel.org, AJvYcCXu82LB9BqzvAy8rpp/NQMSNrNMAnD9rfai4DUdbxhVSEHNwF8unVXTwzW8Op5+sj4K3AKIediBhNC3c33vtA==@vger.kernel.org, AJvYcCXvOGnZzxGyOx452/tbs6zPuG4X8ezQhxH33DmEgdvyNhqW2+Brwu1KywsMTRig49GDZRy/VjU+x/Ex@vger.kernel.org, AJvYcCXxbxrQLyXLGoI6bHr9LMgBgGwv7wKGA4IIHaNxrLjxzDxx48GNOGMQqvLEjxp0zGYMbimxxZhSr0//kQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9639IddxqQpgb7Rx14baW5gdlGi+uEpf/XgdvbUCfIubn+ife
	9Q4CgPiMaANA1DN3wbOMSnh3g7GHyNp4KrTbZdAdpU4VCz7Jl50Q92KKYgRnthwb8OQ6KjGfkOy
	wA4NLpqr9Ve0e2yxjmdDvhJethoGaHDw=
X-Gm-Gg: ASbGnctgxBRhW5H414aJk2ltYrtGbjathJ3ZEd2CHAanG6xwmgEneR4xVhWQWDdh4l5
	jSWlhbc2xj7638t9j6hos1mvTczQ5HIW1kIL4edjd3u9Y5UQhzznDW9BwB7uBM7hPzwFgWXFHrC
	sGNA+LadNgEDplkVnknN0Ld44+9Wc/QKXJ
X-Google-Smtp-Source: AGHT+IFRnJEcWleyx7qwRg7vCSphUUiTic92QQTbjBIO27j1RZLPz4oc9+NYTvPTi3d4hgYaU1hHw6EOra2vJZB7M9Q=
X-Received: by 2002:a17:906:2b1b:b0:ad5:3746:591b with SMTP id
 a640c23a62f3a-ad537465cf1mr1369436966b.55.1747820202406; Wed, 21 May 2025
 02:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513-xattrat-syscall-v5-0-22bb9c6c767f@kernel.org>
 <399fdabb-74d3-4dd6-9eee-7884a986dab1@app.fastmail.com> <20250515-bedarf-absagen-464773be3e72@brauner>
 <CAOQ4uxicuEkOas2UR4mqfus9Q2RAeKKYTwbE2XrkcE_zp8oScQ@mail.gmail.com>
 <aCsX4LTpAnGfFjHg@dread.disaster.area> <sfmrojifgnrpeilqxtixyqrdjj5uvvpbvirxmlju5yce7z72vi@ondnx7qbie4y>
In-Reply-To: <sfmrojifgnrpeilqxtixyqrdjj5uvvpbvirxmlju5yce7z72vi@ondnx7qbie4y>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 21 May 2025 11:36:31 +0200
X-Gm-Features: AX0GCFvWQ5JZ1WJhnjsofvtr8p7StwkfQswgOpTGVD-EYd-NOKxs-pNdKNcJ-sU
Message-ID: <CAOQ4uxiM+BBNODHfxu=v3XN2ezA-0k54qC5R4qdELbZW+W-xkg@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] fs: introduce file_getattr and file_setattr syscalls
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, selinux@vger.kernel.org, 
	ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 10:48=E2=80=AFAM Andrey Albershteyn <aalbersh@redha=
t.com> wrote:
>
> On 2025-05-19 21:37:04, Dave Chinner wrote:
> > On Thu, May 15, 2025 at 12:33:31PM +0200, Amir Goldstein wrote:
> > > On Thu, May 15, 2025 at 11:02=E2=80=AFAM Christian Brauner <brauner@k=
ernel.org> wrote:
> > > >
> > > > On Tue, May 13, 2025 at 11:53:23AM +0200, Arnd Bergmann wrote:
> > > > > On Tue, May 13, 2025, at 11:17, Andrey Albershteyn wrote:
> > > > >
> > > > > >
> > > > > >     long syscall(SYS_file_getattr, int dirfd, const char *pathn=
ame,
> > > > > >             struct fsxattr *fsx, size_t size, unsigned int at_f=
lags);
> > > > > >     long syscall(SYS_file_setattr, int dirfd, const char *pathn=
ame,
> > > > > >             struct fsxattr *fsx, size_t size, unsigned int at_f=
lags);
> > > > >
> > > > > I don't think we can have both the "struct fsxattr" from the uapi
> > > > > headers, and a variable size as an additional argument. I would
> > > > > still prefer not having the extensible structure at all and just
> > > >
> > > > We're not going to add new interfaces that are fixed size unless fo=
r the
> > > > very basic cases. I don't care if we're doing that somewhere else i=
n the
> > > > kernel but we're not doing that for vfs apis.
> > > >
> > > > > use fsxattr, but if you want to make it extensible in this way,
> > > > > it should use a different structure (name). Otherwise adding
> > > > > fields after fsx_pad[] would break the ioctl interface.
> > > >
> > > > Would that really be a problem? Just along the syscall simply add
> > > > something like:
> > > >
> > > > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > > > index c91fd2b46a77..d3943805c4be 100644
> > > > --- a/fs/ioctl.c
> > > > +++ b/fs/ioctl.c
> > > > @@ -868,12 +868,6 @@ static int do_vfs_ioctl(struct file *filp, uns=
igned int fd,
> > > >         case FS_IOC_SETFLAGS:
> > > >                 return ioctl_setflags(filp, argp);
> > > >
> > > > -       case FS_IOC_FSGETXATTR:
> > > > -               return ioctl_fsgetxattr(filp, argp);
> > > > -
> > > > -       case FS_IOC_FSSETXATTR:
> > > > -               return ioctl_fssetxattr(filp, argp);
> > > > -
> > > >         case FS_IOC_GETFSUUID:
> > > >                 return ioctl_getfsuuid(filp, argp);
> > > >
> > > > @@ -886,6 +880,20 @@ static int do_vfs_ioctl(struct file *filp, uns=
igned int fd,
> > > >                 break;
> > > >         }
> > > >
> > > > +       switch (_IOC_NR(cmd)) {
> > > > +       case _IOC_NR(FS_IOC_FSGETXATTR):
> > > > +               if (WARN_ON_ONCE(_IOC_TYPE(cmd) !=3D _IOC_TYPE(FS_I=
OC_FSGETXATTR)))
> > > > +                       return SOMETHING_SOMETHING;
> > > > +               /* Only handle original size. */
> > > > +               return ioctl_fsgetxattr(filp, argp);
> > > > +
> > > > +       case _IOC_NR(FFS_IOC_FSSETXATTR):
> > > > +               if (WARN_ON_ONCE(_IOC_TYPE(cmd) !=3D _IOC_TYPE(FFS_=
IOC_FSSETXATTR)))
> > > > +                       return SOMETHING_SOMETHING;
> > > > +               /* Only handle original size. */
> > > > +               return ioctl_fssetxattr(filp, argp);
> > > > +       }
> > > > +
> > >
> > > I think what Arnd means is that we will not be able to change struct
> > > sfxattr in uapi
> > > going forward, because we are not going to deprecate the ioctls and
> >
> > There's no need to deprecate anything to rev an ioctl API.  We have
> > had to solve this "changing struct size" problem previously in XFS
> > ioctls. See XFS_IOC_FSGEOMETRY and the older XFS_IOC_FSGEOMETRY_V4
> > and XFS_IOC_FSGEOMETRY_V1 versions of the API/ABI.
> >
> > If we need to increase the structure size, we can rename the existing
> > ioctl and struct to fix the version in the API, then use the
> > original name for the new ioctl and structure definition.
> >
> > The only thing we have to make sure of is that the old and new
> > structures have exactly the same overlapping structure. i.e.
> > extension must always be done by appending new varibles, they can't
> > be put in the middle of the structure.
> >
> > This way applications being rebuild will pick up the new definition
> > automatically when the system asserts that it is suppored, whilst
> > existing binaries will always still be supported by the kernel.
> >
> > If the application wants/needs to support all possible kernels, then
> > if XFS_IOC_FSGEOMETRY is not supported, call XFS_IOC_FSGEOMETRY_V4,
> > and if that fails (only on really old irix!) or you only need
> > something in that original subset, call XFS_IOC_FSGEOMETRY_V1 which
> > will always succeed....
> >
> > > Should we will need to depart from this struct definition and we migh=
t
> > > as well do it for the initial release of the syscall rather than late=
r on, e.g.:
> > >
> > > --- a/include/uapi/linux/fs.h
> > > +++ b/include/uapi/linux/fs.h
> > > @@ -148,6 +148,17 @@ struct fsxattr {
> > >         unsigned char   fsx_pad[8];
> > >  };
> > >
> > > +/*
> > > + * Variable size structure for file_[sg]et_attr().
> > > + */
> > > +struct fsx_fileattr {
> > > +       __u32           fsx_xflags;     /* xflags field value (get/se=
t) */
> > > +       __u32           fsx_extsize;    /* extsize field value (get/s=
et)*/
> > > +       __u32           fsx_nextents;   /* nextents field value (get)=
   */
> > > +       __u32           fsx_projid;     /* project identifier (get/se=
t) */
> > > +       __u32           fsx_cowextsize; /* CoW extsize field value (g=
et/set)*/
> > > +};
> > > +
> > > +#define FSXATTR_SIZE_VER0 20
> > > +#define FSXATTR_SIZE_LATEST FSXATTR_SIZE_VER0
> >
> > If all the structures overlap the same, all that is needed in the
> > code is to define the structure size that should be copied in and
> > parsed. i.e:
> >
> >       case FSXATTR..._V1:
> >               return ioctl_fsxattr...(args, sizeof(fsx_fileattr_v1));
> >       case FSXATTR..._V2:
> >               return ioctl_fsxattr...(args, sizeof(fsx_fileattr_v2));
> >       case FSXATTR...:
> >               return ioctl_fsxattr...(args, sizeof(fsx_fileattr));
> >
> > -Dave.
> > --
> > Dave Chinner
> > david@fromorbit.com
> >
>
> So, looks like there's at least two solutions to this concern.
> Considering also that we have a bit of space in fsxattr,
> 'fsx_pad[8]', I think it's fine to stick with the current fsxattr
> for now.

Not sure which two solutions you are referring to.

I proposed fsx_fileattr as what I think is the path of least resistance.
There are opinions that we may be able to avoid defining
this struct, but I don't think there was any objection to adding it.

So unless I am missing an objection that I did not understand
define it and get over this hurdle?

Thanks,
Amir.

