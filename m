Return-Path: <linux-fsdevel+bounces-42297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13343A3FF8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 20:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4197219C7AAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 19:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5BB253336;
	Fri, 21 Feb 2025 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtEhtADO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1376C1E990B;
	Fri, 21 Feb 2025 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740165339; cv=none; b=f/L5P8sdpHrBFEJevFdNKW2YieZr4P1ZBzsDOiBy2NGX3Yi+RYocF0vfWcV2Vcf6vLEv3wXMvEyuL7PmZxrWSIuvRsRRh6Vpny3T/s/27Lt83drIXlrAGURNIQ/qgEKBiTaX5tHoETpAyIM3hbObWWWG+XFO8IESbo+809EI/xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740165339; c=relaxed/simple;
	bh=7wXWL18I2e+S7HDfKEXHr7snoKAoVoYulnZRFwhp1sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yolr4hTm+DkEQ/r0g9WxXXJHErlpt4Z8+CZvu5HB5oRiRgQV1VhbKeyu2jm9Q9xfZbwA/nI/RttCX6tRSFMedg5bFS5xuRsjnFekPn4Mg6qz15coQEZymuW2YxNbA2tHj9tdiHQGWPn4J1J+eLo8GEGL7CoxgdE1JZ/LMbafJI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtEhtADO; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abb8d63b447so316809666b.0;
        Fri, 21 Feb 2025 11:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740165336; x=1740770136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZ4qzcaVyk05FmCACIvsQQhed5C/TdPL3HUS3iSi4mM=;
        b=CtEhtADONXtZjY46HGFQSVzXEga2fSDHFmp8wsUVrnuXYbxqL1oZ7by8/d2SJIcGVw
         WFCyP/jS471pcw2EuXzjujDWzaUwmy5itSEtBejzgtKzQPbOq7+v9TQfi5uFmOnNEyZS
         oh2slvGa5mWGdP/7V1crXSW9K6SWMktFk+ruq8O8HIi0ZAR3cuBeD6lNT4isEcfBdNNs
         W68vtSKLuTOxUbA11Dw9jMK4HcV59lo8LntKRcFxhxhB0gRotUZzQg/HEAXoO9pGQpd4
         RKQlJAPEZcLhNGk0pW1M7SCtQHBGuJ/aZ6v8CO96iTucbpkxWwW3hQzr3zU7xTjmlQmn
         lijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740165336; x=1740770136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZ4qzcaVyk05FmCACIvsQQhed5C/TdPL3HUS3iSi4mM=;
        b=dFvh38gFJCh818sao/3Oe5PMyFe7u4U8cdXuER3Tk/XPE0O7UEf7Xy1ox67o+KARCB
         0God8jfNLurITt0SqxNAivxXgRKQVeb6fuCOfTebItrsti4lb/sWqekh2OhdnCH/GuSa
         CR60sZN6SRxSXv9WFV0GH0QF6GzgoYCnT2wgsgsaEhtZAGb7srxb7Ph2ZbYnPApK1uPB
         aGyA+RJDmlTqpw6RXjwbmEEclS1TrTsoc+X2L1T9ChNV6jPBvRK2eambp8SnitJDLanS
         lTLUU7G/tK49ZiIQnB8egbre2E5WeaI5W1OkNURW5Bkza+mI1e20cBK5TsktpB0ga6kU
         6LBA==
X-Forwarded-Encrypted: i=1; AJvYcCUA2HL+H74VIGeTHWPU1S6W/kEI6BUvRUS+sxhba/f5lEQMbnHlPyMZ9/7Z+bnyRJLiJmiR3R4AnTWlcA==@vger.kernel.org, AJvYcCUc9Ic3SvISGSx4mj5TP7FAlL4xoIJFDv1xzXFW953hLRk/BzjbmLVgssXSkGsWHJOxnCRM3KnrZ/iA3vZn@vger.kernel.org, AJvYcCV3AlaFT86UAkgvxh7MZZ/O3iWvhFQOiw5fDhowG6Xh9K5Ai/v+PcmvpAxduy970lBf4OHJ+JEuONmO@vger.kernel.org, AJvYcCVHQf7zKj4oTy+q97xbrLhliiNBty7OfcZ6AYU5LJssnkzgTfuuP2ciOz66pj5l6gGx+pRestrHWi6HSo8+@vger.kernel.org, AJvYcCVc/+ujV1gjF6QDXEvJzGoOGhOIpuYcq7PVOD+m1A98ugmCUh3azFrQdvcgHmLIbfbkBD3mlUCy/2nB@vger.kernel.org, AJvYcCWJK2C7Vj34ixPqL3unNk98A0+NyARxRhLFSz7cWTYbeY6PthsFVyXP7rZw2jdh5Y0FJMyu4H81zPC9QC5IwxGCEW4TZeK3@vger.kernel.org, AJvYcCWwHbX89sEYO2Qh6TdCxZ1pZPoEEGLd6keOu0DWJ1eToC4iPvJjNnE+Iik9tIAK/xpR7i+gjsYqPyE=@vger.kernel.org, AJvYcCX7fKvjPYWcmxsfg3yJzp/dU9M/NGvE9iqCQtA1vf3TEOfDxrPMT2Yg3a2eAiUiSu1vpbENL0FDYs+VdA==@vger.kernel.org, AJvYcCXB8H6MgQ/Nxpzh6dm5++1Y6vPUQCzND8E1S1jTCVhp8wqsoZu7+XD5x2E+xBqTkuQ+AVJwh16Q/+I/rQ==@vger.kernel.org, AJvYcCXKvS3dPLXH
 /yCGKNkziK7FMnoE+QoizmJacPAhbP9MT4ELIiRgOIy9dvm9V9R+pbJSouQZ79Ochga1kw==@vger.kernel.org, AJvYcCXgFylXe7/jiZPtNOpB6pzAluMDH6lIi2Fr7pX4RoIavM0DYoxGbiySC2chLQ6lkOMngiExZm9hwzB8Kw==@vger.kernel.org, AJvYcCXnQWpiFGE9FjOgukUKNU1XzkSCgxbKDVGFlCONSxo0DKz67JbcXM5KXXl6OcLV3o7SzjFWAi5SoQ61G/2I2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YycldZaYi+Zm0siTW4VGZKp5uOYytpWEpTDzx0kuRc7tYQ37BrC
	Yv7QQSxTTy+EEIrXQPUhkiTF2djLSr7fjPCKBp1W0eZ/trz9b7iEwRSVyMIQsHZrTN9PgamXZ6X
	A9aFRLHrapkYv17XYQMu+MptuZMo=
X-Gm-Gg: ASbGncuu7S2ZBH90ZhaoGTExAoXIZSqLxR/57JuNZu/N4bcznPfDo6PlE12sfQmsUjf
	rdlncics+KVcmqLY+h+gmn26OIRk8pTXJnf0zEqs288x2aGGG44Eb/ykNFxb2QIO8i1Ci7N/gtW
	oYYunr9g0=
X-Google-Smtp-Source: AGHT+IFWDn5RXyBT2VBc0JnIa0dvQSE5CN14Z1A/WEoUOuvFw2fX/qPzzDoEoQ7kDiO+vVIgCpjqmVbZCbaRSc500nk=
X-Received: by 2002:a17:907:2daa:b0:ab7:10e1:8779 with SMTP id
 a640c23a62f3a-abc09a9c58emr545901766b.27.1740165335746; Fri, 21 Feb 2025
 11:15:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org> <20250221181135.GW21808@frogsfrogsfrogs>
In-Reply-To: <20250221181135.GW21808@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 21 Feb 2025 20:15:24 +0100
X-Gm-Features: AWEUYZl6ee15urB13zi6bMenPf2pKrOJTL6JxjfoDGHoEUCbXunWqtruY9b7YnQ
Message-ID: <CAOQ4uxgyYBFqkq6cQsso4LxJsPJ4uECOdskXmz-nmGhhV5BQWg@mail.gmail.com>
Subject: Re: [PATCH v3] fs: introduce getfsxattrat and setfsxattrat syscalls
To: "Darrick J. Wong" <djwong@kernel.org>
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
	Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-xfs@vger.kernel.org, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 7:13=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Tue, Feb 11, 2025 at 06:22:47PM +0100, Andrey Albershteyn wrote:
> > From: Andrey Albershteyn <aalbersh@redhat.com>
> >
> > Introduce getfsxattrat and setfsxattrat syscalls to manipulate inode
> > extended attributes/flags. The syscalls take parent directory fd and
> > path to the child together with struct fsxattr.
> >
> > This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
> > that file don't need to be open as we can reference it with a path
> > instead of fd. By having this we can manipulated inode extended
> > attributes not only on regular files but also on special ones. This
> > is not possible with FS_IOC_FSSETXATTR ioctl as with special files
> > we can not call ioctl() directly on the filesystem inode using fd.
> >
> > This patch adds two new syscalls which allows userspace to get/set
> > extended inode attributes on special files by using parent directory
> > and a path - *at() like syscall.
> >
> > Also, as vfs_fileattr_set() is now will be called on special files
> > too, let's forbid any other attributes except projid and nextents
> > (symlink can have an extent).
> >
> > CC: linux-api@vger.kernel.org
> > CC: linux-fsdevel@vger.kernel.org
> > CC: linux-xfs@vger.kernel.org
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > ---
> > v1:
> > https://lore.kernel.org/linuxppc-dev/20250109174540.893098-1-aalbersh@k=
ernel.org/
> >
> > Previous discussion:
> > https://lore.kernel.org/linux-xfs/20240520164624.665269-2-aalbersh@redh=
at.com/
> >
> > XFS has project quotas which could be attached to a directory. All
> > new inodes in these directories inherit project ID set on parent
> > directory.
> >
> > The project is created from userspace by opening and calling
> > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > files such as FIFO, SOCK, BLK etc. Therefore, some inodes are left
> > with empty project ID. Those inodes then are not shown in the quota
> > accounting but still exist in the directory. Moreover, in the case
> > when special files are created in the directory with already
> > existing project quota, these inode inherit extended attributes.
> > This than leaves them with these attributes without the possibility
> > to clear them out. This, in turn, prevents userspace from
> > re-creating quota project on these existing files.
> > ---
> > Changes in v3:
> > - Remove unnecessary "dfd is dir" check as it checked in user_path_at()
> > - Remove unnecessary "same filesystem" check
> > - Use CLASS() instead of directly calling fdget/fdput
> > - Link to v2: https://lore.kernel.org/r/20250122-xattrat-syscall-v2-1-5=
b360d4fbcb2@kernel.org
> > ---
> >  arch/alpha/kernel/syscalls/syscall.tbl      |  2 +
> >  arch/arm/tools/syscall.tbl                  |  2 +
> >  arch/arm64/tools/syscall_32.tbl             |  2 +
> >  arch/m68k/kernel/syscalls/syscall.tbl       |  2 +
> >  arch/microblaze/kernel/syscalls/syscall.tbl |  2 +
> >  arch/mips/kernel/syscalls/syscall_n32.tbl   |  2 +
> >  arch/mips/kernel/syscalls/syscall_n64.tbl   |  2 +
> >  arch/mips/kernel/syscalls/syscall_o32.tbl   |  2 +
> >  arch/parisc/kernel/syscalls/syscall.tbl     |  2 +
> >  arch/powerpc/kernel/syscalls/syscall.tbl    |  2 +
> >  arch/s390/kernel/syscalls/syscall.tbl       |  2 +
> >  arch/sh/kernel/syscalls/syscall.tbl         |  2 +
> >  arch/sparc/kernel/syscalls/syscall.tbl      |  2 +
> >  arch/x86/entry/syscalls/syscall_32.tbl      |  2 +
> >  arch/x86/entry/syscalls/syscall_64.tbl      |  2 +
> >  arch/xtensa/kernel/syscalls/syscall.tbl     |  2 +
> >  fs/inode.c                                  | 75 +++++++++++++++++++++=
++++++++
> >  fs/ioctl.c                                  | 16 +++++-
> >  include/linux/fileattr.h                    |  1 +
> >  include/linux/syscalls.h                    |  4 ++
> >  include/uapi/asm-generic/unistd.h           |  8 ++-
> >  21 files changed, 133 insertions(+), 3 deletions(-)
> >
>
> <cut to the syscall definitions>
>
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 6b4c77268fc0ecace4ac78a9ca777fbffc277f4a..b2dddd9db4fabaf67a6cbf5=
41a86978b290411ec 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -23,6 +23,9 @@
> >  #include <linux/rw_hint.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/debugfs.h>
> > +#include <linux/syscalls.h>
> > +#include <linux/fileattr.h>
> > +#include <linux/namei.h>
> >  #include <trace/events/writeback.h>
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/timestamp.h>
> > @@ -2953,3 +2956,75 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
> >       return mode & ~S_ISGID;
> >  }
> >  EXPORT_SYMBOL(mode_strip_sgid);
> > +
> > +SYSCALL_DEFINE4(getfsxattrat, int, dfd, const char __user *, filename,
> > +             struct fsxattr __user *, fsx, unsigned int, at_flags)
>
> Should the kernel require userspace to pass the size of the fsx buffer?
> That way we avoid needing to rev the interface when we decide to grow
> the structure.
>

This makes sense to me, but I see that Andreas proposed other ways,
as long as we have a plan on how to extend the struct if we need more space=
.

Andrey, I am sorry to bring this up in v3, but I would like to request
two small changes before merging this API.

This patch by Pali [1] adds fsx_xflags_mask for the filesystem to
report the supported set of xflags.

It was argued that we can make this change with the existing ioctl,
because it is not going to break xfs_io -c lsattr/chattr, which is fine,
but I think that we should merge the fsx_xflags_mask change along
with getfsxattrat() which is a new UAPI.

The second request is related to setfsxattrat().
With current FS_IOC_FSSETXATTR, IIUC, xfs ignores unsupported
fsx_xflags. I think this needs to be fixed before merging setfsxattrat().
It's ok that a program calling FS_IOC_FSSETXATTR will not know
if unsupported flags will be ignored, because that's the way it is,
but I think that setfsxattrat() must return -EINVAL for trying to
set unsupported xflags.

As I explained in [2] I think it is fine if FS_IOC_FSSETXATTR
will also start returning -EINVAL for unsupported flags, but I would
like setfsxattrat() to make that a guarantee.

There was an open question, what does fsx_xflags_mask mean
for setfsxattrat() - it is a mask like in inode_set_flags() as Andreas
suggested? I think that would be a good idea.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20250216164029.20673-4-pali@kerne=
l.org/
[2] https://lore.kernel.org/linux-fsdevel/CAOQ4uxjwQJiKAqyjEmKUnq-VihyeSsxy=
Ey2F+J38NXwrAXurFQ@mail.gmail.com/

