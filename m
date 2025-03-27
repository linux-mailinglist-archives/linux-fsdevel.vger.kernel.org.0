Return-Path: <linux-fsdevel+bounces-45126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A63A730A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 12:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72F607A2E43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 11:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092562135B3;
	Thu, 27 Mar 2025 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHWBdwZd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9344213E6B;
	Thu, 27 Mar 2025 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743076037; cv=none; b=ib1rF7DylRMjQ9iPsgsDB76zfUsB3f/AYKaluItmf9QMoqzoZbv8U2bi39APPZPB/4CJycy4sLjkQ2GNpUQOvgjEd4W5KSK/jSnJaazs/OPYT1PlySjHO91rfnHsCCAmWYxK8ktFu6s110Tl/8372OvUZHDdZyIDOJna9wldqeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743076037; c=relaxed/simple;
	bh=n1qijx/OKy6vODUrZhMc5X8x/a/woXnDRx8es3Z+U2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2z9w3NAPZQK9HgwB+BPQrMY+Zutn/FCgmWwWQbZrDd7N2Mr20t1SCiHmHcBnw0wOM9bDTCjuAlBBoGd2+derLakUqmTG4Ab7wWvQLSW8gr7SKHjkjrxKXZK3Yn69jx1XnNA/pYbxyGHK/r1vQCAnl4rwy5mbyji3pMpZGz1wxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHWBdwZd; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso142165466b.3;
        Thu, 27 Mar 2025 04:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743076034; x=1743680834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=is9+y2X85jwUJpC2vpoBI5XsOCH7hq1X1nDpdTQ6gJo=;
        b=OHWBdwZdGHxXuu64JeK3LatbgC/vLSSnwlW7ynWR8oJtMJAlOPLJy23623Lwc++xjU
         0oKbDkimsU9WUTUv7Yg5c9ms5y0gCXr4900HHeUdyex9w9dYelAYPwHx+aE7uSAYlUDJ
         pgfXp8wWrzO7UqbZuOlZQUaqy5KSWRDx5TTcG4rn3NAZ11ZRshUlsIvE3C33z0OuDWCo
         DsBUCXzbqYRk6TAC+PbMSL15q0U9moWPmupH50K+XCP22aby0GLcJ9TYQ1AFL9Y0PTEp
         5TonltQNY4d/FrW9juEBFavTGlBCdNg5CjfEK53EK4Qpt/NdVvXwnlTp+9nveK3Fmd5Q
         UleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743076034; x=1743680834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=is9+y2X85jwUJpC2vpoBI5XsOCH7hq1X1nDpdTQ6gJo=;
        b=etKGX0P0N2SdRxT3laCTJuUxy3C4UjRCv3zhGnWNMgc5woShSSe6Aw+gDdMi2mU1Tu
         XyPVac5QSoxsxrMQfjMPozaO/RS/05tmYOWSItGKExym8oYVuCz428tFhzR0nARSc0eC
         3nt1KnY4nbpC+yxmF+VfWdesjLXlugzPEGzlaDIfeynbCat9s4BaVqPYt484oljZoLOh
         EffkQsJr4EfoPsVsdGYQGQVg3cIGLip93jmnGwi9jB777HNbmn+asMHRj4vuJWg8jtu3
         bl06dwHh4FUHYaf4PbaCe6Iiam5KNyEMAWy/ziG/6nYEPFOdyYgBTAZcRIWU41LY915X
         G2mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhcpaPjt/WOsLNDlKo/sn87CvnYW1K75mUsN8fbi+v0+sW4M3bC1mjcBhddrCOF4RpHwkSzxT5eR9CFA==@vger.kernel.org, AJvYcCV8Ts24HwzGSZ8Smqj6pcWnwBbIZQV6xGJYRU8mpeLA4XSoDLVr4S/HQ0apVXiQGJ9byLNsHBT21cpak0gCGQ==@vger.kernel.org, AJvYcCVL0gMQumgGJbSYFoa72DHD2W2tm6gWTaNDCH+PNqxpIKtkI0denaPTdJTA3vvmtFsPD0Lbjb4dgdub6g==@vger.kernel.org, AJvYcCVXdJvqmAorpkhh3vZeY/xOYGBIWcrkM+N2wjN8/aJje0kfbs4696Mf4GY7aS30RwBaku0vn8ydmNjx@vger.kernel.org, AJvYcCW0T2mdqUwRg6+X4sXTJNjdbV4uhf79v2+wCo2BP1MN0s4ptDbT2lQRJgidU4fVWvy+F45lDWjO2lIUXg==@vger.kernel.org, AJvYcCW5ZGoDCaT8N/e9oL6QKcrdVdJnlp3cZmqqPFhz/ucYumTGX+/J5maUTdQ7DZ5RjduAbdg3jpzUhRV/jhrbWBH7lV5YLzAy@vger.kernel.org, AJvYcCWtqcCjsjMV1EPokgT/74IVjyS9t6aOkVgaQWbpvyqFj5SizKeSXNaGX8QkPxqz+WjOBqumtJ+34Ds=@vger.kernel.org, AJvYcCWw4e9jLog1rsquRE+l+d9YKl1cXQ0WvKJPqhUNqAlSmDlXO2qRNwJPhTSVHsFNun5E9ZX/oa20H7rRKR+V@vger.kernel.org, AJvYcCXDNi5mgCc4H/YiGGsdYRYPwAOuS8jqCCXUAAvoT3wRZ1snTc22JiCYHCzWI6tph389kP4go9S9nA==@vger.kernel.org, AJvYcCXF5DLF
 lOKck6HQkJbQRfJPMI2lq6yAC9i4E1g92mKm65F8piJmZ2VEo10TyJEhLVrcItub1mctUrAazQ==@vger.kernel.org, AJvYcCXFZpxIHLrAJhsFk/vy7s3Kujl7sEOvjlKV6XZf2o1t67S5/s1zvbX/uMw5ikPZqnKKOvG5TVavplqH@vger.kernel.org, AJvYcCXWd339mxkn33FRYdDQJwECgTt/FWq5NbwpHhJhmB1rFB4YP5WLCgszLRZ7FteJrtq5/tOZ2VCS+4PMzQ==@vger.kernel.org, AJvYcCXkO0+OFNNXlClftTez8QzsyVGudv8fE9+qW6G+ZcNeKEximzM2cf9bvaXenVo9ZzG5YBcZ0dT4x1CLdA0Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/08V4JT1k7O2KrOVLXpFV9SRPSxm+KWN52UbGkV2iufQuBMmR
	aE+v+MGGa1nZmqof9SfE7eGrLNzN29LLYZ9ZP4O4Cv1/jvtLq3YSb3i7JXwdHwffs107iRVtIXL
	9t8QaLzhM2agFZM04IzQVleStmM8=
X-Gm-Gg: ASbGnctoQULFj7XmWF3qvuYdcZvaentGyogwYs1KSBURFr3CDPfS74vXXWw21BMQgR9
	u2d0y7hIZ1bOv4UuvODKydJ8U85gwKR+9zw9IhKF9mhtsbqwWfPDJ0fb919tdtPlzgh5CCoW/Vr
	+K445EEBqguFf+RyKVcr8WjvT3ng==
X-Google-Smtp-Source: AGHT+IFDMEzXsY+VZjpd0kG58wjWGn9FeNWYrZGZgOC4akNvRiDgmmjaMJcSLaslSRq0Qq/XBA95rVTpeV7+0zkMjwY=
X-Received: by 2002:a17:907:7292:b0:ac2:9683:ad25 with SMTP id
 a640c23a62f3a-ac6faf46d6dmr291188966b.34.1743076033463; Thu, 27 Mar 2025
 04:47:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org>
 <CAOQ4uxjQDUg8HFG+mSxMkR54zen7nC2jttzOKqh13Bx-uosh3Q@mail.gmail.com> <20250323103234.2mwhpsbigpwtiby4@pali>
In-Reply-To: <20250323103234.2mwhpsbigpwtiby4@pali>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 27 Mar 2025 12:47:02 +0100
X-Gm-Features: AQ5f1Jpi0M5N9RWSGdapIu4-VZrbOc2LlwCzBFz2QmmwPCZLH_QgJtaO5jSCIs8
Message-ID: <CAOQ4uxiTKhGs1H-w1Hv-+MqY284m92Pvxfem0iWO+8THdzGvuA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] fs: introduce getfsxattrat and setfsxattrat syscalls
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-arch@vger.kernel.org, selinux@vger.kernel.org, 
	Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 23, 2025 at 11:32=E2=80=AFAM Pali Roh=C3=A1r <pali@kernel.org> =
wrote:
>
> On Sunday 23 March 2025 09:45:06 Amir Goldstein wrote:
> > On Fri, Mar 21, 2025 at 8:50=E2=80=AFPM Andrey Albershteyn <aalbersh@re=
dhat.com> wrote:
> > >
> > > This patchset introduced two new syscalls getfsxattrat() and
> > > setfsxattrat(). These syscalls are similar to FS_IOC_FSSETXATTR ioctl=
()
> > > except they use *at() semantics. Therefore, there's no need to open t=
he
> > > file to get an fd.
> > >
> > > These syscalls allow userspace to set filesystem inode attributes on
> > > special files. One of the usage examples is XFS quota projects.
> > >
> > > XFS has project quotas which could be attached to a directory. All
> > > new inodes in these directories inherit project ID set on parent
> > > directory.
> > >
> > > The project is created from userspace by opening and calling
> > > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > > files such as FIFO, SOCK, BLK etc. Therefore, some inodes are left
> > > with empty project ID. Those inodes then are not shown in the quota
> > > accounting but still exist in the directory. This is not critical but=
 in
> > > the case when special files are created in the directory with already
> > > existing project quota, these new inodes inherit extended attributes.
> > > This creates a mix of special files with and without attributes.
> > > Moreover, special files with attributes don't have a possibility to
> > > become clear or change the attributes. This, in turn, prevents usersp=
ace
> > > from re-creating quota project on these existing files.
> > >
> > > Christian, if this get in some mergeable state, please don't merge it
> > > yet. Amir suggested these syscalls better to use updated struct fsxat=
tr
> > > with masking from Pali Roh=C3=A1r patchset, so, let's see how it goes=
.
> >
> > Andrey,
> >
> > To be honest I don't think it would be fair to delay your syscalls more
> > than needed.
>
> I agree.
>
> > If Pali can follow through and post patches on top of your syscalls for
> > next merge window that would be great, but otherwise, I think the
> > minimum requirement is that the syscalls return EINVAL if fsx_pad
> > is not zero. we can take it from there later.
>
> IMHO SYS_getfsxattrat is fine in this form.
>
> For SYS_setfsxattrat I think there are needed some modifications
> otherwise we would have problem again with backward compatibility as
> is with ioctl if the syscall wants to be extended in future.
>
> I would suggest for following modifications for SYS_setfsxattrat:
>
> - return EINVAL if fsx_xflags contains some reserved or unsupported flag
>
> - add some flag to completely ignore fsx_extsize, fsx_projid, and
>   fsx_cowextsize fields, so SYS_setfsxattrat could be used just to
>   change fsx_xflags, and so could be used without the preceding
>   SYS_getfsxattrat call.
>
> What do you think about it?

I think all Andrey needs to do now is return -EINVAL if fsx_pad is not zero=
.

You can use this later to extend for the semantics of flags/fields mask
and we can have a long discussion later on what this semantics should be.

Right?

Amir.

