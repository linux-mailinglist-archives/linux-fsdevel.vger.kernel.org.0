Return-Path: <linux-fsdevel+bounces-49574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 099C3ABF1F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 12:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7FFB1BC29FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 10:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7783F261389;
	Wed, 21 May 2025 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fxr+lJOM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C65725FA07;
	Wed, 21 May 2025 10:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747824287; cv=none; b=stYi1LKk2hl1ZaB1qX+iJVUVBxDYmaj2fEVACF2uotquJEsJOjU/9iY1lr4yjr2NGFIVi6B7+PZoHdG+ZPZ1NpxbaD7o9+Rppf8QzwlpxKjvBm3wLmTaVHcJWWG82FJRy4MMM7rElA7supSDAZNEO5ltkuhY06ZTWK857MniLkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747824287; c=relaxed/simple;
	bh=wdYyMOldSs5J7ZV607pnOvS2tgtojBPdZ8GgMIEtaqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGsbBqOCjxDDnfJZ2KR91axELJpA1fNP/wMuNe9LNz2pzV4iE3jmheIwQ0r+sRzs7QEaUtCZ3f7H6bhXb+KdX+8hND2GpoxT4EH/yW9Tw4q/RuRrYBhAyPoHhbjd3CdQNpJyYoG8fE3sdQFJ0DApv/caT8jTB1lbwPjyvBpzSss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fxr+lJOM; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad5533c468cso610946766b.0;
        Wed, 21 May 2025 03:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747824284; x=1748429084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7s86C99en4rKIGw3tj+5ymWyZfNfw27U2XEo8biwfc=;
        b=Fxr+lJOMM2Dj/pu+FcHG2Snsq569dNIu5kfWdhVPrdZdJNwYlt4xtdenN5+TQ62299
         jwoigc+cJnnO4qg6MZlZSl0MJODfh1cV+S8ccJIl++safjsjCX40siAHRmb9Hnnv8bdY
         ma16oUfTiq3AOu8qVGPV60YmJIMT88BoNR/lC1C0rD9A3QJVmhl43qTeckROAPpC/zFE
         ltpg5rtgOXg7OBoqltR0QjGtI3EGRdiRjtIIO0pEE4x/HdvfkgdaTF4kQ7n5DgUvd6jh
         GkIIGgadHH+tslKze77rybI7BDQTzLh7z0oDvw8eJftjHIr4mdsoipc9laKvr7YMjPfi
         o3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747824284; x=1748429084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7s86C99en4rKIGw3tj+5ymWyZfNfw27U2XEo8biwfc=;
        b=DX/l/wj5zcxuUCp7iEenK9AQXCZ3VGAQ9uamV9JGywliYQa6hqTLPMbvJQWnJ9J/2j
         SBbz1YHB42GufOlOc35uFaeupK2MVj3v9OPew50FfB63dfti/jaHLklW3vniGoEqksrK
         AK/0aLvTIY7ByMWTh+S3sho+kzYDtz/Js7sFS7CtR6wNgmtKPXBdKMSGXsNab3qO5XdT
         KHXF682bdcb8HOzhEUbxDUDc5//pL+q5ZiBHOrYK5QkBxoe3ewQNUMiaTZKlcFssDJ7p
         dzbK/qaJSFzc9h4OUIsKdVF8Y4DV+d6XWZWnxo1B/a0iOt1RZUKXwAYUJJJvHu06RDmS
         4BRg==
X-Forwarded-Encrypted: i=1; AJvYcCU0+7jXcjs2H1E/XHhSTuwT2NqZiijO/uxHa1UPliW49hyQME2jHX1aTRFd/7VPTQapS/rbuuVBh/+vlw==@vger.kernel.org, AJvYcCU0FKD6LkY6oBPJLDVfYSoDObq5cMy3q8M4kyOg2JWmDgDMaJuYHEGkr99bi7MVTlEPmLMYzN2ROBJFethLAw==@vger.kernel.org, AJvYcCUXPUAzOn4sjQ+LIBgUgBblkW57jGU+iWABTCYRa5/5Q7td6bWvC600VeJoeSaqcpYXJA6ciR3HQBbmVInC@vger.kernel.org, AJvYcCUfSHrsyy9j1lWm0lnAEP6UxdjEnOFrseaxu37C6OflTmxLKZXY8xdZgL7i5xd0bqtKSPYj+08gOA==@vger.kernel.org, AJvYcCUgJQfS6rBm2s1cpofPbw4ravhgVmYh2gJBGxEGQPBbDnXaboo9yLnDphgG1VXZWIh8DTCRbR7rL2n+@vger.kernel.org, AJvYcCV8I2dkht/kFEkzhCg+vvUiEmLV7O6dt76Y7DMoP1y4e+KGxZb+eLvjJLMIFzhtzvBKTL/CUUN5hGIVyhKW@vger.kernel.org, AJvYcCVdiqVGO1ZB4aGxHyfgaCiOFZX1FgP6bXzkJJCpkSl9nN8uCa20I6mFfA68/x3/Q81/nNOKYLt7x7EgIg==@vger.kernel.org, AJvYcCVrFsm3DWnTZKw6eFtrOeUL/mWY9XIIfidMaUypXsHN/YUSU3kus+liMco+gFgqapSrgrlBalVvZLU8Xw==@vger.kernel.org, AJvYcCWLfwcrim/ew4rr3PkSW8STxkVJ1lEOXKXqgKDdpQswV1DLY9Jzk2hnUSigCIehskN8Ayvuz4KNCF0EVi5qpg==@vger.kernel.org, AJvYcCWkld2qZp2B
 7uEOIYZQocLNXVafeGZHjfty89xAq3emLBtwopAj1wBxbPs+n5SaDiQY86fXe4J4nJFa@vger.kernel.org, AJvYcCWndX0BfQ670sixJpRei6Zw8NWzjdIqXjyPWdX2K7WFPd6MHmH6HRE2zRKHhzGbhHcl/xWG6jBrwCN5WIM=@vger.kernel.org, AJvYcCXRIi/ElYSmLckD8Qxd6hbKkhsiSgQrXHDo8MrZIJ6lDlg/HGRSiuG0wLNP7ANVUHBlAopJFZF5FhFj6w==@vger.kernel.org, AJvYcCXW+hg1lvlMf2W0bWuzwDFIc7NOl6ZeYqXS7SneA94cZv3gCLjYnb/gDFhdWyyPtEGGW9+jQ281cwK4vRXKf/ybxa1z/DGp@vger.kernel.org, AJvYcCXcJpHYDW94fVnOa+VxAu5Tg9r3s+V3v55odxXgLwuB7WcLRaGI9WfJLMxeBH5Qu3DYbO5OVOpiKQo=@vger.kernel.org, AJvYcCXjSJmQb59MExu3C+RHra9wKni8Gd9SmYbLW1A+tNIGv7tm3lPD3oSOXQn+VmycJbIuziyA5XVD0w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4qYKRT5xb+WuCfdYzdysMAi3klDPsZnRUd6sCmEK2OtEB2fYQ
	2mJcJvPNpVtz4E0G4E4Vq2RU/FzleXEZo2IcRb+fiDYkOX++G10x7qUgLBqeh18UClRbE5YPUkO
	lBHtG9BPVeEtL+d46dh0CvnSM/gGfL8M=
X-Gm-Gg: ASbGnct3SUalzdgTVriCGobDctZJ1azNRdnEs32RNrlIq6M13T1hGxbB0szMIV1gyX5
	XH/I1kF+/lYNqcnwmO1skh3SXOjxEpkUNtaT2urUTsGAAJM185PSpY7ApJy08S4w1DhD7XopFj5
	g5GyqcK+1QlGZCU24V5yk3zlicknBtqv+G
X-Google-Smtp-Source: AGHT+IHjdKaldjnagUYeAkZaxVv0PKTrOg3dvgceCo3K5CfAqPJX4ttSEQJcVm5rFWRa63l5bGpXFWyRh6DbM0BJP0M=
X-Received: by 2002:a17:906:8f8a:b0:ad2:1a66:a1ad with SMTP id
 a640c23a62f3a-ad536b7de17mr1674734766b.6.1747824283278; Wed, 21 May 2025
 03:44:43 -0700 (PDT)
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
 <CAOQ4uxiM+BBNODHfxu=v3XN2ezA-0k54qC5R4qdELbZW+W-xkg@mail.gmail.com> <mw2d36mqwzqoveguw5vlggrnw2wirsbhdxkox33z3fg7k6huz6@hj4ntgg3oj7p>
In-Reply-To: <mw2d36mqwzqoveguw5vlggrnw2wirsbhdxkox33z3fg7k6huz6@hj4ntgg3oj7p>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 21 May 2025 12:44:30 +0200
X-Gm-Features: AX0GCFtzhzw8HQOfKpcxXaUXYfRoIUIi0dE2W9yfpQHIc06WbddDr0-sckzPkGU
Message-ID: <CAOQ4uxiOaYusURMrjozD_s24Swih2g0x5_nTTYXO=+=EPCYtjw@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] fs: introduce file_getattr and file_setattr syscalls
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: pali@kernel.org, Dave Chinner <david@fromorbit.com>, 
	Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
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

On Wed, May 21, 2025 at 12:06=E2=80=AFPM Andrey Albershteyn <aalbersh@redha=
t.com> wrote:
>
> On 2025-05-21 11:36:31, Amir Goldstein wrote:
> > On Wed, May 21, 2025 at 10:48=E2=80=AFAM Andrey Albershteyn <aalbersh@r=
edhat.com> wrote:
> > >
> > > On 2025-05-19 21:37:04, Dave Chinner wrote:
> > > > On Thu, May 15, 2025 at 12:33:31PM +0200, Amir Goldstein wrote:
> > > > > On Thu, May 15, 2025 at 11:02=E2=80=AFAM Christian Brauner <braun=
er@kernel.org> wrote:
> > > > > >
> > > > > > On Tue, May 13, 2025 at 11:53:23AM +0200, Arnd Bergmann wrote:
> > > > > > > On Tue, May 13, 2025, at 11:17, Andrey Albershteyn wrote:
> > > > > > >
> > > > > > > >
> > > > > > > >     long syscall(SYS_file_getattr, int dirfd, const char *p=
athname,
> > > > > > > >             struct fsxattr *fsx, size_t size, unsigned int =
at_flags);
> > > > > > > >     long syscall(SYS_file_setattr, int dirfd, const char *p=
athname,
> > > > > > > >             struct fsxattr *fsx, size_t size, unsigned int =
at_flags);
> > > > > > >
> > > > > > > I don't think we can have both the "struct fsxattr" from the =
uapi
> > > > > > > headers, and a variable size as an additional argument. I wou=
ld
> > > > > > > still prefer not having the extensible structure at all and j=
ust
> > > > > >
> > > > > > We're not going to add new interfaces that are fixed size unles=
s for the
> > > > > > very basic cases. I don't care if we're doing that somewhere el=
se in the
> > > > > > kernel but we're not doing that for vfs apis.
> > > > > >
> > > > > > > use fsxattr, but if you want to make it extensible in this wa=
y,
> > > > > > > it should use a different structure (name). Otherwise adding
> > > > > > > fields after fsx_pad[] would break the ioctl interface.
> > > > > >
> > > > > > Would that really be a problem? Just along the syscall simply a=
dd
> > > > > > something like:
> > > > > >
> > > > > > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > > > > > index c91fd2b46a77..d3943805c4be 100644
> > > > > > --- a/fs/ioctl.c
> > > > > > +++ b/fs/ioctl.c
> > > > > > @@ -868,12 +868,6 @@ static int do_vfs_ioctl(struct file *filp,=
 unsigned int fd,
> > > > > >         case FS_IOC_SETFLAGS:
> > > > > >                 return ioctl_setflags(filp, argp);
> > > > > >
> > > > > > -       case FS_IOC_FSGETXATTR:
> > > > > > -               return ioctl_fsgetxattr(filp, argp);
> > > > > > -
> > > > > > -       case FS_IOC_FSSETXATTR:
> > > > > > -               return ioctl_fssetxattr(filp, argp);
> > > > > > -
> > > > > >         case FS_IOC_GETFSUUID:
> > > > > >                 return ioctl_getfsuuid(filp, argp);
> > > > > >
> > > > > > @@ -886,6 +880,20 @@ static int do_vfs_ioctl(struct file *filp,=
 unsigned int fd,
> > > > > >                 break;
> > > > > >         }
> > > > > >
> > > > > > +       switch (_IOC_NR(cmd)) {
> > > > > > +       case _IOC_NR(FS_IOC_FSGETXATTR):
> > > > > > +               if (WARN_ON_ONCE(_IOC_TYPE(cmd) !=3D _IOC_TYPE(=
FS_IOC_FSGETXATTR)))
> > > > > > +                       return SOMETHING_SOMETHING;
> > > > > > +               /* Only handle original size. */
> > > > > > +               return ioctl_fsgetxattr(filp, argp);
> > > > > > +
> > > > > > +       case _IOC_NR(FFS_IOC_FSSETXATTR):
> > > > > > +               if (WARN_ON_ONCE(_IOC_TYPE(cmd) !=3D _IOC_TYPE(=
FFS_IOC_FSSETXATTR)))
> > > > > > +                       return SOMETHING_SOMETHING;
> > > > > > +               /* Only handle original size. */
> > > > > > +               return ioctl_fssetxattr(filp, argp);
> > > > > > +       }
> > > > > > +
> > > > >
> > > > > I think what Arnd means is that we will not be able to change str=
uct
> > > > > sfxattr in uapi
> > > > > going forward, because we are not going to deprecate the ioctls a=
nd
> > > >
> > > > There's no need to deprecate anything to rev an ioctl API.  We have
> > > > had to solve this "changing struct size" problem previously in XFS
> > > > ioctls. See XFS_IOC_FSGEOMETRY and the older XFS_IOC_FSGEOMETRY_V4
> > > > and XFS_IOC_FSGEOMETRY_V1 versions of the API/ABI.
> > > >
> > > > If we need to increase the structure size, we can rename the existi=
ng
> > > > ioctl and struct to fix the version in the API, then use the
> > > > original name for the new ioctl and structure definition.
> > > >
> > > > The only thing we have to make sure of is that the old and new
> > > > structures have exactly the same overlapping structure. i.e.
> > > > extension must always be done by appending new varibles, they can't
> > > > be put in the middle of the structure.
> > > >
> > > > This way applications being rebuild will pick up the new definition
> > > > automatically when the system asserts that it is suppored, whilst
> > > > existing binaries will always still be supported by the kernel.
> > > >
> > > > If the application wants/needs to support all possible kernels, the=
n
> > > > if XFS_IOC_FSGEOMETRY is not supported, call XFS_IOC_FSGEOMETRY_V4,
> > > > and if that fails (only on really old irix!) or you only need
> > > > something in that original subset, call XFS_IOC_FSGEOMETRY_V1 which
> > > > will always succeed....
> > > >
> > > > > Should we will need to depart from this struct definition and we =
might
> > > > > as well do it for the initial release of the syscall rather than =
later on, e.g.:
> > > > >
> > > > > --- a/include/uapi/linux/fs.h
> > > > > +++ b/include/uapi/linux/fs.h
> > > > > @@ -148,6 +148,17 @@ struct fsxattr {
> > > > >         unsigned char   fsx_pad[8];
> > > > >  };
> > > > >
> > > > > +/*
> > > > > + * Variable size structure for file_[sg]et_attr().
> > > > > + */
> > > > > +struct fsx_fileattr {
> > > > > +       __u32           fsx_xflags;     /* xflags field value (ge=
t/set) */
> > > > > +       __u32           fsx_extsize;    /* extsize field value (g=
et/set)*/
> > > > > +       __u32           fsx_nextents;   /* nextents field value (=
get)   */
> > > > > +       __u32           fsx_projid;     /* project identifier (ge=
t/set) */
> > > > > +       __u32           fsx_cowextsize; /* CoW extsize field valu=
e (get/set)*/
> > > > > +};
> > > > > +
> > > > > +#define FSXATTR_SIZE_VER0 20
> > > > > +#define FSXATTR_SIZE_LATEST FSXATTR_SIZE_VER0
> > > >
> > > > If all the structures overlap the same, all that is needed in the
> > > > code is to define the structure size that should be copied in and
> > > > parsed. i.e:
> > > >
> > > >       case FSXATTR..._V1:
> > > >               return ioctl_fsxattr...(args, sizeof(fsx_fileattr_v1)=
);
> > > >       case FSXATTR..._V2:
> > > >               return ioctl_fsxattr...(args, sizeof(fsx_fileattr_v2)=
);
> > > >       case FSXATTR...:
> > > >               return ioctl_fsxattr...(args, sizeof(fsx_fileattr));
> > > >
> > > > -Dave.
> > > > --
> > > > Dave Chinner
> > > > david@fromorbit.com
> > > >
> > >
> > > So, looks like there's at least two solutions to this concern.
> > > Considering also that we have a bit of space in fsxattr,
> > > 'fsx_pad[8]', I think it's fine to stick with the current fsxattr
> > > for now.
> >
> > Not sure which two solutions you are referring to.
>
> Suggested by Christian and Dave
>

IIUC, those are suggestions of how we could cope with changing
struct fsxattr in the future, but it is easier not to have to do that.

> >
> > I proposed fsx_fileattr as what I think is the path of least resistance=
.
> > There are opinions that we may be able to avoid defining
> > this struct, but I don't think there was any objection to adding it.
> >
> > So unless I am missing an objection that I did not understand
> > define it and get over this hurdle?
>
> I see, sure, I misinterpreted the communication :) no problems, I
> will create 'struct fsx_fileattr' then.
>
> Pali, ah sorry, I forgot that you will extend fsxattr right away
>

Much less problems could be caused if fsxattr remain frozen in
time along with the ioctls as we continue to extend the syscalls.

Thanks,
Amir.

P.S. your CC list is a bit much.
I wouldn't trust get_maintainer.pl output when it provides such a huge list
it has some emails that bounce - not nice.

When you are at v5 you should be able to have figured out who is
participating in the review and for the rest, the public lists
linux-fsdevel, linux-api and linux-xfs should be enough.

