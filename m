Return-Path: <linux-fsdevel+bounces-45168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FEFA73FCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 22:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1A017DECE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 21:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE771DDC04;
	Thu, 27 Mar 2025 20:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5LxuiwP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0922816EB7C;
	Thu, 27 Mar 2025 20:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743109069; cv=none; b=T/7wd7wTZbadBGGuHc/QgdpBs2OTyfqpWWYHA3Uqm8wDRSF3D3vHpberSWcfhz+kCGa1CiJ18KNtR2vHSaPPsv01Kn2StGhR3VeA362hDJiTE+quiXljxP9cUnuo68rqgyASUcqdJFJjk0iFJK/EM2gxM2NkICKQexVqZOnRe7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743109069; c=relaxed/simple;
	bh=U8ACEjPhWjyeheO55YZkIdTijNWUWhAGycuMJrtPNTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLSP1uKpFiEM4MMevhT8LaaqvbpMctSIv3y6+j5o6eNGXsTUEeU7pwkHvW1HZQBgm3z3Giywu99UzNmuR8nD/u6EFmOscEDQi2qx+sIYJVwnUb97jXr8DQlVNT70FPgC94zt5fA2t790XbiayaJCS8FIP8quL1UHu3grni7413U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5LxuiwP; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5eb92df4fcbso2566995a12.0;
        Thu, 27 Mar 2025 13:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743109066; x=1743713866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VR7DEyijnU2Btuzsq24JxQagRdb3glRQ+pQ9YwQUpTo=;
        b=I5LxuiwPXwh8KHngjSLkCaAxERKQ5T7eSxwFgSPsPyOXXloSgjKRY3qkoQeggeEGHj
         93m5VWwnt/yoF4y41AXrP0zRvy+YduUHWy2jTJu4DUoHJFrttirwvb4z6BE+k6lAOaVj
         G1Epltp5nr/g7CyqnEFMBmLFHM2ssOvYbhr8T+ux4igJSr/PXtFoHIMkqCIW8nWi/BOl
         502rc0jVl12dWnioAFhEUfnjCPO0YG7wrU3l0RmcxvVgHBTlZUPv9p4Vh34lYEmgu1L/
         4z+RwP3KIYHxvkSe7InxhQIbCXiWV5TqhiPxPe/uEnI2ySZT978pRP4Eq3TUk04EM7cn
         FruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743109066; x=1743713866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VR7DEyijnU2Btuzsq24JxQagRdb3glRQ+pQ9YwQUpTo=;
        b=OITeAxKpG+PTlkMEEZNbZaD3bsYaagsrL/qGRqROy6fpTG9mfwU9If6RAB8CBM7lQu
         7bkf17roJjnPx2Nlre8y+7YzrJUGOhKM2U8sFJz44pvXQrAaO2WhJpgIPyUApJm/SDV4
         OB1KTB5a6N477gy0+JeA/vYM7BOK9wkJvGzr9sLlxFbl63eUGjli0IdrpnKu6EHXFjyL
         sraM//OgdigFEGhAYNQ49ayjNF2UKd3PGz1AfkdLoyr/s3Q0+U4yZRqDT3n0TwmQN82s
         RSo+4UeYd9BR2dsdqLj9mdhsIhpiceMMfpk9uy5S4YRewFwlfPGQdz/SWMX7FTW4gRRq
         pkhw==
X-Forwarded-Encrypted: i=1; AJvYcCUMelncLNt5YNWJBvzeF6tBPoB0R5QhWpfNEZiE0U6YCjpgcRVIP9UKjjJWSDLf6Y9mIlSzQDyoYIAcwg==@vger.kernel.org, AJvYcCUW8mNGGSimsyrKfUe/H5TpmY2B8yRjZVumcEg07I4d8pCyHuY8qor2G71ZoerpxbQKRuNbb5GjGnAoXQ==@vger.kernel.org, AJvYcCUtfd6b+FsHb+quMY0AF7Zn2DGxK15l3n0pavt2kgMcWMvSvB854fRqWtR+lVvU2uv+mpX5hr6l3nCDYA==@vger.kernel.org, AJvYcCV+0q2qNB8439owZTLBP64iyJCPIvraOOJhUStlvelWvO8HDHhbbdor2jAQ+tyKtew924XAvWz5FQwE3xlh@vger.kernel.org, AJvYcCVoUlOfnDmlt0XxmIg+KGIJWxvkk++Zx9U2hbd8a2kCDa5pa2ousf5JFaSiP5arkHbQJgQNpgf4AJqVFe2p4A==@vger.kernel.org, AJvYcCW2XwZa20ZpIWgjHx1fTA+HEZL8DJ6FHZUDSOZ2z67aE/42tlAkMhj6d/bXQTeGsCf53F142Pt6DiSJ@vger.kernel.org, AJvYcCWcCx7hzNEFMwmuDUXo0fkDVR6yfkXU+Qo4zsjmyFbJZ9uuRpU9lay1WvFA2/ye2JXimZMzbOEk1LU=@vger.kernel.org, AJvYcCX0OqA0H1QyE4gw2fOYlrNa7nRK0xqn+V663LqkXWfvKKwmXepV9nHLdz+psNc9pacsOGMmyMBF+g==@vger.kernel.org, AJvYcCXLIzCeGbL9GX51Kn9rrLQY24fs7c5c3yOPqeDkmuH93zYd4H24xofDaBBLNqjsr+Xo8ElO7tFlHovesA==@vger.kernel.org, AJvYcCXapDtz23xgFTYR5GQS
 j7S4MsaVP1jUv3Ym79MB59Xdps7zJhTRI7Hndzb3rE9nJvQhYphKPvasvaA9DQ==@vger.kernel.org, AJvYcCXj0E5E2R31SbN2JOWEd+hZ9T22rTOieTkPGMuzz5jh3WYqBRQrI9DaEEpgiP1CngQkpiTv1qp3JCHo@vger.kernel.org, AJvYcCXsQRf7SYp4BJ9CmpAYLvUq+x05r3sPxIKnqOg8CGowWGH2vHYcv34HGqhxa2hZCozVf2JrF2XyVLysNg0p@vger.kernel.org, AJvYcCXwjFMDkQiTrxwnvapfCq+M8ybx1ky2VAfF97HYnwCzfJRJQo3k7gkUVqvwtGwYOYrCgxW8bVIWnjG3GQFwdgiB7XU3ur0j@vger.kernel.org
X-Gm-Message-State: AOJu0YyDXjaKPy0SIpCGMmlrZVoOI9BQf6z8qYrtfNZCDYyVZ3kEhGXw
	tzefrTbuzXYc7DMIM1gKVRnkoSZv7WOagqsbz3/FHw3y7NUqaAEvbopCp99gcWehd7nlOIa/HEL
	GKCPImbLqtcmx5U6CL5Uok1hhRwQ=
X-Gm-Gg: ASbGncv+B9rcSwfPBDU9D9CUkq0gFAOLyp54EzncsOuRhzk2pAnwDGhvrGSqw1Im9g+
	LTjASbndZff3ZKMajPvgWN0JoIHoLCtB6UoGD13+FON5+wGle+JfHfZaNgGrKLyuqp8475AMvzD
	wOJHVFn3aCdQSln07ZATQlQ0YRZg==
X-Google-Smtp-Source: AGHT+IGQy/9DoQYCCr9US5q6EnypmXetXiJBY3dnHtL1iSSGFXJt9gHT/MXORtXg0qR63MnGE5R7UOJG3H1b0VV82NI=
X-Received: by 2002:a05:6402:26d0:b0:5e6:23c:a242 with SMTP id
 4fb4d7f45d1cf-5ed8e59f048mr6048289a12.18.1743109065684; Thu, 27 Mar 2025
 13:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org>
 <CAOQ4uxjQDUg8HFG+mSxMkR54zen7nC2jttzOKqh13Bx-uosh3Q@mail.gmail.com>
 <20250323103234.2mwhpsbigpwtiby4@pali> <CAOQ4uxiTKhGs1H-w1Hv-+MqY284m92Pvxfem0iWO+8THdzGvuA@mail.gmail.com>
 <20250327192629.ivnarhlkfbhbzjcl@pali>
In-Reply-To: <20250327192629.ivnarhlkfbhbzjcl@pali>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 27 Mar 2025 21:57:34 +0100
X-Gm-Features: AQ5f1JpYIOUBRGbLo4K_0o1yQv002a0U-X2PtgEoVHqkLx0cP_6nsQWGxHLw9Sg
Message-ID: <CAOQ4uxhJ53h+1AjtF4B64onqvRfZsJ3n1OFikyJpXAPTyX45iQ@mail.gmail.com>
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

On Thu, Mar 27, 2025 at 8:26=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
>
> On Thursday 27 March 2025 12:47:02 Amir Goldstein wrote:
> > On Sun, Mar 23, 2025 at 11:32=E2=80=AFAM Pali Roh=C3=A1r <pali@kernel.o=
rg> wrote:
> > >
> > > On Sunday 23 March 2025 09:45:06 Amir Goldstein wrote:
> > > > On Fri, Mar 21, 2025 at 8:50=E2=80=AFPM Andrey Albershteyn <aalbers=
h@redhat.com> wrote:
> > > > >
> > > > > This patchset introduced two new syscalls getfsxattrat() and
> > > > > setfsxattrat(). These syscalls are similar to FS_IOC_FSSETXATTR i=
octl()
> > > > > except they use *at() semantics. Therefore, there's no need to op=
en the
> > > > > file to get an fd.
> > > > >
> > > > > These syscalls allow userspace to set filesystem inode attributes=
 on
> > > > > special files. One of the usage examples is XFS quota projects.
> > > > >
> > > > > XFS has project quotas which could be attached to a directory. Al=
l
> > > > > new inodes in these directories inherit project ID set on parent
> > > > > directory.
> > > > >
> > > > > The project is created from userspace by opening and calling
> > > > > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > > > > files such as FIFO, SOCK, BLK etc. Therefore, some inodes are lef=
t
> > > > > with empty project ID. Those inodes then are not shown in the quo=
ta
> > > > > accounting but still exist in the directory. This is not critical=
 but in
> > > > > the case when special files are created in the directory with alr=
eady
> > > > > existing project quota, these new inodes inherit extended attribu=
tes.
> > > > > This creates a mix of special files with and without attributes.
> > > > > Moreover, special files with attributes don't have a possibility =
to
> > > > > become clear or change the attributes. This, in turn, prevents us=
erspace
> > > > > from re-creating quota project on these existing files.
> > > > >
> > > > > Christian, if this get in some mergeable state, please don't merg=
e it
> > > > > yet. Amir suggested these syscalls better to use updated struct f=
sxattr
> > > > > with masking from Pali Roh=C3=A1r patchset, so, let's see how it =
goes.
> > > >
> > > > Andrey,
> > > >
> > > > To be honest I don't think it would be fair to delay your syscalls =
more
> > > > than needed.
> > >
> > > I agree.
> > >
> > > > If Pali can follow through and post patches on top of your syscalls=
 for
> > > > next merge window that would be great, but otherwise, I think the
> > > > minimum requirement is that the syscalls return EINVAL if fsx_pad
> > > > is not zero. we can take it from there later.
> > >
> > > IMHO SYS_getfsxattrat is fine in this form.
> > >
> > > For SYS_setfsxattrat I think there are needed some modifications
> > > otherwise we would have problem again with backward compatibility as
> > > is with ioctl if the syscall wants to be extended in future.
> > >
> > > I would suggest for following modifications for SYS_setfsxattrat:
> > >
> > > - return EINVAL if fsx_xflags contains some reserved or unsupported f=
lag
> > >
> > > - add some flag to completely ignore fsx_extsize, fsx_projid, and
> > >   fsx_cowextsize fields, so SYS_setfsxattrat could be used just to
> > >   change fsx_xflags, and so could be used without the preceding
> > >   SYS_getfsxattrat call.
> > >
> > > What do you think about it?
> >
> > I think all Andrey needs to do now is return -EINVAL if fsx_pad is not =
zero.
> >
> > You can use this later to extend for the semantics of flags/fields mask
> > and we can have a long discussion later on what this semantics should b=
e.
> >
> > Right?
> >
> > Amir.
>
> It is really enough?

I don't know. Let's see...

> All new extensions later would have to be added
> into fsx_pad fields, and currently unused bits in fsx_xflags would be
> unusable for extensions.

I am working under the assumption that the first extension would be
to support fsx_xflags_mask and from there, you could add filesystem
flags support checks and then new flags. Am I wrong?

Obviously, fsx_xflags_mask would be taken from fsx_pad space.
After that extension is implemented, calling SYS_setfsxattrat() with
a zero fsx_xflags_mask would be silly for programs that do not do
the legacy get+set.

So when we introduce  fsx_xflags_mask, we could say that a value
of zero means that the mask is not being checked at all and unknown
flags in set syscall are ignored (a.k.a legacy ioctl behavior).

Programs that actually want to try and set without get will have to set
a non zero fsx_xflags_mask to do something useful.

I don't think this is great.
I would rather that the first version of syscalls will require the mask
and will always enforce filesystems supported flags.

If you can get those patches (on top of current series) posted and
reviewed in time for the next merge window, including consensus
on the actual semantics, that would be the best IMO.

But I am just preparing a plan B in case you do not have time to
work on the patches or if consensus on the API extensions is not
reached on time.

I think that for plan B, the minimum is to verify zero pad field and
that is something that this syscall has to do anyway, because this
is the way that backward compact APIs work.

If you want the syscall to always return -EINVAL for setting xflags
that are currently undefined I agree that would be nice as well.

Thanks,
Amir.

