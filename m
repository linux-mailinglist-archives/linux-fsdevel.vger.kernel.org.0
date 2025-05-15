Return-Path: <linux-fsdevel+bounces-49122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963F8AB8403
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 12:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0AE3B7AE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 10:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49E529898E;
	Thu, 15 May 2025 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNFFvB7+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B582980DB;
	Thu, 15 May 2025 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747305229; cv=none; b=bz7a7XcZS3t1tQj+10vlX/dG6bX7fzicGFyJrQICvS0CQLjV3vMIxmRyXq6dzLWWRZygP07AQ/HRy/coOszmdkFf0qVDfWPkIywxoLG0c06z5Bpo2A0tsUt/UYII0fs1wkX2BLOScPeVhoqAwrYtJDEAJG425vAqeMe4FbjaQGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747305229; c=relaxed/simple;
	bh=0Ca4GoXXMXx6cHQk8bHNd0lNmpQHYfAdXnzIxwgHL3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+nFs+e+8CatHm1vNJsGCo9zbaC8oui+kdPu4zQjXRq0FiXLjmcpCSWa/D2IBa3pIW9DVK53RAbYZ56or7gWTWadHro9t6eZ5p++3Sni1xX8ITx9nqcLxJyVjWUuIYUyPgCc6M/kmxzJUJRbM3I3W5baK2PD0yW7DTQyxBrMVeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNFFvB7+; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad228552355so145728266b.3;
        Thu, 15 May 2025 03:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747305224; x=1747910024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ix0mN7yylNXsLKVIXpa3RC7XyXUMorhAJgZhoj08KZI=;
        b=dNFFvB7+F4bQnqRGDE2+4A7yMNRNci41ukf9sM1SpKoP5h6okqXiIXRFAcqooe9hEw
         kaUx/tV81EFC+u0mn6Le+CyrNFLvbaOH4AXXbD96ikKi9eBWkXm6lXyTTVx9+F+WvxCu
         QCLbC65KNrv3b1DAyGVaQLBS/5VUvLZa8GdDj9+o7gsJWgRA2NbkaPUIEMKDfrnrXuBQ
         aMvr2s7eu23v2L952PmkdrtcWQYLg5s3TlFFyLZ66piMmmNg7QbAgTREsF+8BDzzEj++
         3/6IIvVKq4OoaPc3OmCt1SGq3n8VlTJFyCc2nT6YvaJt6JmzAHI1yEJTRH0PRwdkOLPn
         YAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747305224; x=1747910024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ix0mN7yylNXsLKVIXpa3RC7XyXUMorhAJgZhoj08KZI=;
        b=tHazuhTolEjm0AwedGQNaIwGVTICJQraA9S1nB7s9UJfjJtJcYpG2vEh+UxLGyWuw7
         rAJMoSlIvp9HJt9U1OUSjs5O7myGMotXVYUpvoy/nP9zhogP140G7SZh2kaBZVb9lJKf
         XzY6W0GPzKciXy3YHpttbxKMSovd4Gmh8Bxu8ogetrTGwWLS5J+yFKc2e2MH3AD9Qj4y
         MCCFSqOWPxhwQkIVNFAeZJ+zvXeF9e/hhMyBR0YVh8KaOjKbZSB3l4c/iQsIm0yZZzUb
         f1SHf5CH/Lde4hO8rArc7eIf2kCCXNM2bUCG90l+ySxIDMbaDQyA71MIwTYJuA6/xjKV
         XlSg==
X-Forwarded-Encrypted: i=1; AJvYcCUFnl18yK4fF8ZN2ucDTSkBtzfngOZ4W/Zb+AtLsGqpz4K3M7veduiKInDo13KpvYiJXoHkcDXTeh90xRC3YQ==@vger.kernel.org, AJvYcCUw/v0IOYfEKGhI5+PaJVUhjKZ7tN2HyFQ0iyjDsYmm6oiwhN1OoRkPrGGYwfDshbHCMvomAustbIVKq9ybvmOHfBImhqxZ@vger.kernel.org, AJvYcCV9z144RUR25t3aFg1JFeKuxmt3naFBbyv3tFPUNz3ve32dI/QuVr+k82PQL32ALdaUPURR4FJC3d5vpQ==@vger.kernel.org, AJvYcCVTr+YXfhfhWbVErezEaAdibon47HFbxkBSwd0L7a7b+ksE7LdIUWBlwMeYlLWA7YEU0QjsSlUWli9R0fAC@vger.kernel.org, AJvYcCVek3fQdptbsYZYs2oTWrZX8O/3F/GUbA9UVDvn0xntkcIuCgAgsgL4NsDuYQKBwWsq5LssXIC2X69I@vger.kernel.org, AJvYcCVps06mw7zk4bPdVN9Yv0+Ojg5M7awKR+XyXkPrZsyIDdXNnUGoLjCq5YOW4BmkxLpPtlBACTeKHLUaOiHn@vger.kernel.org, AJvYcCVsMxP8v6PDjt17331Nq8v25vO5ZRD2nB8rOnxTKEZlRI4NVSB/oBu6lmtH8OG/1ZKEBCDgIVhAz5ldcA==@vger.kernel.org, AJvYcCVv8csgEV2RJWy4XYXB0ZMv00S/ClXPdRJB8I80WrnXQCuhvexd6DQsUhYnVPePww51QU75xzVgRnA=@vger.kernel.org, AJvYcCW0F1JF43hz5eSJTXNoegIXA+RVMAgnJIiQXbTipAexlxh4iNhjELEC2iXqnyXmRdQR/4QXnMcSwh39XB2sBA==@vger.kernel.org, AJvY
 cCW18UDiAGv/4LOj3FNHdH3GSZNyBcI+jPZ4NVz6NORooYjdCOj2SChcjPvfjFyb8fgkjTQc4ZynhSI3AQ==@vger.kernel.org, AJvYcCW5jRkhGpM9gTLCfchk227w/7h2IKaZ0puV91k5iVX3Btl5kae+ywOqejl7MEoxxCZsrBf72PxbEg==@vger.kernel.org, AJvYcCWBoIgk+CVxvl2GSIdNKDKaBKfqA9ZlYws3gueo/jWH5ZXkzxQCbcu147xz1MNz3709XASbHT59EA==@vger.kernel.org, AJvYcCWUrm8XEOKGZJy3WAofc8WaI8Pk+8+JfgKsTXAw5huAhOLpPYobdqp15LMARaxNEbYwPdssmelvyJgNADM=@vger.kernel.org, AJvYcCWgu3aDI8Fl1QgcZi/LKLhCchAO1ENL1XEKHya4jDvdFC+3yRchmE2pcuxiEM0ts9LmbyPxYchwVMh+@vger.kernel.org, AJvYcCXDdGMbqYtbvTkGvKFJ9OZRQ1Dfqh5BWlwKfnXMpyIkBoS78woO5K1w8mWyL2pbNtc0AbI9uyh19XGGVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAhg0fRi2y/4LqaTxIBOyX0h6jMOVDsV+qkOx8Y33cZHfUOxq1
	xrRJJD+6a7oNRV0phyM/DJAUrxtFsomp7aFlMZfNKdzUU3uAZpywkR1lSGQ47Hs7pl13vEi2gYb
	yQVDVOloSRrg4NGi1eSonwE9w9RY=
X-Gm-Gg: ASbGncvgp+pMrYhwTDQZSDhHzNtbh29X5xDM/VKsLFbS/BaFNH5zYfxYT/k7bHjMq83
	xb5QRifdRF59rQNAS0SxCj3zrGWRbACLTsYNaMnzhA9bBhoC5QDF6ylCS11E4PVEDQvY7IPyhZ8
	aBRX+yXuYhY1uhDFh/H8D47JGosgkkMN1J
X-Google-Smtp-Source: AGHT+IH/YFjWiUa7Oe6APhoaMiAXM+TxOKXzzX9IOWrtv4bcH+n6gSWZSohhovEJvJss7Wr0el1TN6Dn7PUuhUUlRKw=
X-Received: by 2002:a17:907:72c1:b0:ad2:e683:a76c with SMTP id
 a640c23a62f3a-ad515d79f17mr198604066b.7.1747305223832; Thu, 15 May 2025
 03:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513-xattrat-syscall-v5-0-22bb9c6c767f@kernel.org>
 <399fdabb-74d3-4dd6-9eee-7884a986dab1@app.fastmail.com> <20250515-bedarf-absagen-464773be3e72@brauner>
In-Reply-To: <20250515-bedarf-absagen-464773be3e72@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 May 2025 12:33:31 +0200
X-Gm-Features: AX0GCFv6VzJTt0PbxjVfcfLF_B5PjKPMcuhdvqJqoMNLfQeCg9Kk1MZMyM5NBko
Message-ID: <CAOQ4uxicuEkOas2UR4mqfus9Q2RAeKKYTwbE2XrkcE_zp8oScQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] fs: introduce file_getattr and file_setattr syscalls
To: Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrey Albershteyn <aalbersh@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
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

On Thu, May 15, 2025 at 11:02=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Tue, May 13, 2025 at 11:53:23AM +0200, Arnd Bergmann wrote:
> > On Tue, May 13, 2025, at 11:17, Andrey Albershteyn wrote:
> >
> > >
> > >     long syscall(SYS_file_getattr, int dirfd, const char *pathname,
> > >             struct fsxattr *fsx, size_t size, unsigned int at_flags);
> > >     long syscall(SYS_file_setattr, int dirfd, const char *pathname,
> > >             struct fsxattr *fsx, size_t size, unsigned int at_flags);
> >
> > I don't think we can have both the "struct fsxattr" from the uapi
> > headers, and a variable size as an additional argument. I would
> > still prefer not having the extensible structure at all and just
>
> We're not going to add new interfaces that are fixed size unless for the
> very basic cases. I don't care if we're doing that somewhere else in the
> kernel but we're not doing that for vfs apis.
>
> > use fsxattr, but if you want to make it extensible in this way,
> > it should use a different structure (name). Otherwise adding
> > fields after fsx_pad[] would break the ioctl interface.
>
> Would that really be a problem? Just along the syscall simply add
> something like:
>
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index c91fd2b46a77..d3943805c4be 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -868,12 +868,6 @@ static int do_vfs_ioctl(struct file *filp, unsigned =
int fd,
>         case FS_IOC_SETFLAGS:
>                 return ioctl_setflags(filp, argp);
>
> -       case FS_IOC_FSGETXATTR:
> -               return ioctl_fsgetxattr(filp, argp);
> -
> -       case FS_IOC_FSSETXATTR:
> -               return ioctl_fssetxattr(filp, argp);
> -
>         case FS_IOC_GETFSUUID:
>                 return ioctl_getfsuuid(filp, argp);
>
> @@ -886,6 +880,20 @@ static int do_vfs_ioctl(struct file *filp, unsigned =
int fd,
>                 break;
>         }
>
> +       switch (_IOC_NR(cmd)) {
> +       case _IOC_NR(FS_IOC_FSGETXATTR):
> +               if (WARN_ON_ONCE(_IOC_TYPE(cmd) !=3D _IOC_TYPE(FS_IOC_FSG=
ETXATTR)))
> +                       return SOMETHING_SOMETHING;
> +               /* Only handle original size. */
> +               return ioctl_fsgetxattr(filp, argp);
> +
> +       case _IOC_NR(FFS_IOC_FSSETXATTR):
> +               if (WARN_ON_ONCE(_IOC_TYPE(cmd) !=3D _IOC_TYPE(FFS_IOC_FS=
SETXATTR)))
> +                       return SOMETHING_SOMETHING;
> +               /* Only handle original size. */
> +               return ioctl_fssetxattr(filp, argp);
> +       }
> +

I think what Arnd means is that we will not be able to change struct
sfxattr in uapi
going forward, because we are not going to deprecate the ioctls and
certainly not
the XFS specific ioctl XFS_IOC_FSGETXATTRA.

This struct is part of XFS uapi:
https://man7.org/linux/man-pages/man2/ioctl_xfs_fsgetxattr.2.html

Should we will need to depart from this struct definition and we might
as well do it for the initial release of the syscall rather than later on, =
e.g.:

--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -148,6 +148,17 @@ struct fsxattr {
        unsigned char   fsx_pad[8];
 };

+/*
+ * Variable size structure for file_[sg]et_attr().
+ */
+struct fsx_fileattr {
+       __u32           fsx_xflags;     /* xflags field value (get/set) */
+       __u32           fsx_extsize;    /* extsize field value (get/set)*/
+       __u32           fsx_nextents;   /* nextents field value (get)   */
+       __u32           fsx_projid;     /* project identifier (get/set) */
+       __u32           fsx_cowextsize; /* CoW extsize field value (get/set=
)*/
+};
+
+#define FSXATTR_SIZE_VER0 20
+#define FSXATTR_SIZE_LATEST FSXATTR_SIZE_VER0
+

Right?

Thanks,
Amir.

