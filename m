Return-Path: <linux-fsdevel+bounces-42833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD457A4938D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 09:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FB0C7A6B75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 08:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F1B2528F8;
	Fri, 28 Feb 2025 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dui1sz6N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4934A2500C6
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731448; cv=none; b=Zp3kIGGP3xfUYl2Ch4WWmduXXLyQeIHr8bnxH04KEnZ5+u7qCuZqMnUgHGd7lEDDZjCozxi6+T3DM/L7jBICudAe5tzjJqw53s++KkpTzPenpH1IUXfa+QI+k+NaXP5t0O7ZRip1WzLqJgznA33rLlu2Dk6p/ZSvMDa0pIjmAYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731448; c=relaxed/simple;
	bh=9JRh0vQu00gcGDgHvqANg3ZiBZ1ZNLJx8nUj+BWm9B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUdy80sMQgQ+bsAxtbcuu2QBPMSPGRnCTpJGHR3h/slVgvpqZ8pps8cnE9OugMADQZ00knKEuUmsOk6iU6NtVcldj4pm5masd5udTRkgaDjwmOiIbd+9uHmDk1cg8EBD/Qobcz6T5gDa0a0PqhS9xF0BgePDy5fI5ov2ekIGrWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dui1sz6N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740731445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IAk7T/agbjQFnKEBQSUNnzMrHpjZ/FADtSxLOMcXTqc=;
	b=Dui1sz6NBA52u2gWpD/Jv+g8u440V4PvsD6EoEGuq/Ll7p0AYhpNTwHGVZ96KDS+MCI+BG
	nmnAyQoBXTSDiRxAIUUEvXikd9FOA3L2GXJvbWFiKg9SGqjwySmg1KmYFUCquaqftV+Poi
	qhHzNfOdmnFIGCJUrXcO88GNm+YxEdg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-zHVc-eceM2yKr8soEQxPCA-1; Fri, 28 Feb 2025 03:30:43 -0500
X-MC-Unique: zHVc-eceM2yKr8soEQxPCA-1
X-Mimecast-MFC-AGG-ID: zHVc-eceM2yKr8soEQxPCA_1740731442
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-abbae81829fso205036566b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 00:30:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740731442; x=1741336242;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IAk7T/agbjQFnKEBQSUNnzMrHpjZ/FADtSxLOMcXTqc=;
        b=XQVT49cNBQ8gXk6nCyrSeRUGC8O9T1s5ujAtuSuiGRr4eBT079x5QWknmGHg6QpfV3
         0SHrZ/oglgEG+GKcIZD8zZJO8LjQSB8D+Wrdr17mT42AicnR+6yDUKb+Je5yek5kFvMO
         cbq8UHqfkzOSnISZRzOh0H02gJXDjtrZ4YpugiIe9Ao7FFp1MWIOxQRHjFHhwhxEZl4e
         BKSMAst5lAktTnn3sXur5Vj/nWssbWdAwEMdAVOarYG9tm3VF/EfA2NeqFOVAgE7Z1F/
         3QUWCpQASXNyrUTnkWMS8/iaTvHZhX3lcxGnOVpJJnvTEoFReZEgq/vj6NRVvuL/Rami
         4Y3A==
X-Forwarded-Encrypted: i=1; AJvYcCWSm2Vaz3oUdv1fQ4hlVOjrcwSkwEebsxLYg7sp/k0LSAYcL0dIHCKk4+5EdPuC0C/w8+R5bw4YENnKOzMW@vger.kernel.org
X-Gm-Message-State: AOJu0YyrSzGEtTsFsUFHB/D7d37qXggzKvhZnh++JCI35odrOjp4OeV5
	2C2nTQH+paMOSUSgthOTJSGjMkXyFaF+mbO0g11aZZHQmaLakV4UebOiy4d/T8YsACMhcKitWvl
	1X72CtZvMikgI/O/omyo+L16HqUmAt9a87z5iEwfYF7hxKm6P18s2y5n0P0h2OQ==
X-Gm-Gg: ASbGncvz8DdCZkeZmsgOD84ohMeoR3KDOh46oWHKzZFlg+vHaDJ2Kl0BS3Owz4gXa6d
	y9w/RcQ5B0keeIGd+5Nj6CA85YUS1WLY+51wVY/8/ZQXWoSXzpXzpl8VVEQJrX2VMHg3r6dqBC7
	354kiK+se6PtpGEfzMEaWYZZnIS8Pjp3wgyxotuPBnAlE7UmKQ9pF9rYeFznUpVBEmzEFkW98xc
	Ji7Ecm2uUPTG2wa8JoxtGJbaLDzefuceBrtUxAEVpzgI4q6gkBsEXnTAzdJslSTYAheNtsoFDCl
	MJGbIOFi/BS/qYgcxw7kc8OAAdOCKJLagRA=
X-Received: by 2002:a17:907:2d08:b0:abf:22cd:9a7e with SMTP id a640c23a62f3a-abf261f5471mr234891466b.30.1740731441897;
        Fri, 28 Feb 2025 00:30:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZIWf4Mi/ez8uccBE3ejxNf0ox83n9Aynget7e7VbyIxs4sY20lz/2ANqi9H9OCRURVdUpFw==
X-Received: by 2002:a17:907:2d08:b0:abf:22cd:9a7e with SMTP id a640c23a62f3a-abf261f5471mr234884766b.30.1740731441289;
        Fri, 28 Feb 2025 00:30:41 -0800 (PST)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c74c714sm254400566b.124.2025.02.28.00.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 00:30:40 -0800 (PST)
Date: Fri, 28 Feb 2025 09:30:38 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH v3] fs: introduce getfsxattrat and setfsxattrat syscalls
Message-ID: <ihkez5xfcuocis7cmipvts2vxnfan2ub5kcpvsrnzm37glwnax@nxp72byvetye>
References: <20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org>
 <20250221181135.GW21808@frogsfrogsfrogs>
 <CAOQ4uxgyYBFqkq6cQsso4LxJsPJ4uECOdskXmz-nmGhhV5BQWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgyYBFqkq6cQsso4LxJsPJ4uECOdskXmz-nmGhhV5BQWg@mail.gmail.com>

On 2025-02-21 20:15:24, Amir Goldstein wrote:
> On Fri, Feb 21, 2025 at 7:13 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Tue, Feb 11, 2025 at 06:22:47PM +0100, Andrey Albershteyn wrote:
> > > From: Andrey Albershteyn <aalbersh@redhat.com>
> > >
> > > Introduce getfsxattrat and setfsxattrat syscalls to manipulate inode
> > > extended attributes/flags. The syscalls take parent directory fd and
> > > path to the child together with struct fsxattr.
> > >
> > > This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
> > > that file don't need to be open as we can reference it with a path
> > > instead of fd. By having this we can manipulated inode extended
> > > attributes not only on regular files but also on special ones. This
> > > is not possible with FS_IOC_FSSETXATTR ioctl as with special files
> > > we can not call ioctl() directly on the filesystem inode using fd.
> > >
> > > This patch adds two new syscalls which allows userspace to get/set
> > > extended inode attributes on special files by using parent directory
> > > and a path - *at() like syscall.
> > >
> > > Also, as vfs_fileattr_set() is now will be called on special files
> > > too, let's forbid any other attributes except projid and nextents
> > > (symlink can have an extent).
> > >
> > > CC: linux-api@vger.kernel.org
> > > CC: linux-fsdevel@vger.kernel.org
> > > CC: linux-xfs@vger.kernel.org
> > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > ---
> > > v1:
> > > https://lore.kernel.org/linuxppc-dev/20250109174540.893098-1-aalbersh@kernel.org/
> > >
> > > Previous discussion:
> > > https://lore.kernel.org/linux-xfs/20240520164624.665269-2-aalbersh@redhat.com/
> > >
> > > XFS has project quotas which could be attached to a directory. All
> > > new inodes in these directories inherit project ID set on parent
> > > directory.
> > >
> > > The project is created from userspace by opening and calling
> > > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > > files such as FIFO, SOCK, BLK etc. Therefore, some inodes are left
> > > with empty project ID. Those inodes then are not shown in the quota
> > > accounting but still exist in the directory. Moreover, in the case
> > > when special files are created in the directory with already
> > > existing project quota, these inode inherit extended attributes.
> > > This than leaves them with these attributes without the possibility
> > > to clear them out. This, in turn, prevents userspace from
> > > re-creating quota project on these existing files.
> > > ---
> > > Changes in v3:
> > > - Remove unnecessary "dfd is dir" check as it checked in user_path_at()
> > > - Remove unnecessary "same filesystem" check
> > > - Use CLASS() instead of directly calling fdget/fdput
> > > - Link to v2: https://lore.kernel.org/r/20250122-xattrat-syscall-v2-1-5b360d4fbcb2@kernel.org
> > > ---
> > >  arch/alpha/kernel/syscalls/syscall.tbl      |  2 +
> > >  arch/arm/tools/syscall.tbl                  |  2 +
> > >  arch/arm64/tools/syscall_32.tbl             |  2 +
> > >  arch/m68k/kernel/syscalls/syscall.tbl       |  2 +
> > >  arch/microblaze/kernel/syscalls/syscall.tbl |  2 +
> > >  arch/mips/kernel/syscalls/syscall_n32.tbl   |  2 +
> > >  arch/mips/kernel/syscalls/syscall_n64.tbl   |  2 +
> > >  arch/mips/kernel/syscalls/syscall_o32.tbl   |  2 +
> > >  arch/parisc/kernel/syscalls/syscall.tbl     |  2 +
> > >  arch/powerpc/kernel/syscalls/syscall.tbl    |  2 +
> > >  arch/s390/kernel/syscalls/syscall.tbl       |  2 +
> > >  arch/sh/kernel/syscalls/syscall.tbl         |  2 +
> > >  arch/sparc/kernel/syscalls/syscall.tbl      |  2 +
> > >  arch/x86/entry/syscalls/syscall_32.tbl      |  2 +
> > >  arch/x86/entry/syscalls/syscall_64.tbl      |  2 +
> > >  arch/xtensa/kernel/syscalls/syscall.tbl     |  2 +
> > >  fs/inode.c                                  | 75 +++++++++++++++++++++++++++++
> > >  fs/ioctl.c                                  | 16 +++++-
> > >  include/linux/fileattr.h                    |  1 +
> > >  include/linux/syscalls.h                    |  4 ++
> > >  include/uapi/asm-generic/unistd.h           |  8 ++-
> > >  21 files changed, 133 insertions(+), 3 deletions(-)
> > >
> >
> > <cut to the syscall definitions>
> >
> > > diff --git a/fs/inode.c b/fs/inode.c
> > > index 6b4c77268fc0ecace4ac78a9ca777fbffc277f4a..b2dddd9db4fabaf67a6cbf541a86978b290411ec 100644
> > > --- a/fs/inode.c
> > > +++ b/fs/inode.c
> > > @@ -23,6 +23,9 @@
> > >  #include <linux/rw_hint.h>
> > >  #include <linux/seq_file.h>
> > >  #include <linux/debugfs.h>
> > > +#include <linux/syscalls.h>
> > > +#include <linux/fileattr.h>
> > > +#include <linux/namei.h>
> > >  #include <trace/events/writeback.h>
> > >  #define CREATE_TRACE_POINTS
> > >  #include <trace/events/timestamp.h>
> > > @@ -2953,3 +2956,75 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
> > >       return mode & ~S_ISGID;
> > >  }
> > >  EXPORT_SYMBOL(mode_strip_sgid);
> > > +
> > > +SYSCALL_DEFINE4(getfsxattrat, int, dfd, const char __user *, filename,
> > > +             struct fsxattr __user *, fsx, unsigned int, at_flags)
> >
> > Should the kernel require userspace to pass the size of the fsx buffer?
> > That way we avoid needing to rev the interface when we decide to grow
> > the structure.
> >
> 
> This makes sense to me, but I see that Andreas proposed other ways,
> as long as we have a plan on how to extend the struct if we need more space.
> 
> Andrey, I am sorry to bring this up in v3, but I would like to request
> two small changes before merging this API.
> 
> This patch by Pali [1] adds fsx_xflags_mask for the filesystem to
> report the supported set of xflags.
> 
> It was argued that we can make this change with the existing ioctl,
> because it is not going to break xfs_io -c lsattr/chattr, which is fine,
> but I think that we should merge the fsx_xflags_mask change along
> with getfsxattrat() which is a new UAPI.
> 
> The second request is related to setfsxattrat().
> With current FS_IOC_FSSETXATTR, IIUC, xfs ignores unsupported
> fsx_xflags. I think this needs to be fixed before merging setfsxattrat().
> It's ok that a program calling FS_IOC_FSSETXATTR will not know
> if unsupported flags will be ignored, because that's the way it is,
> but I think that setfsxattrat() must return -EINVAL for trying to
> set unsupported xflags.
> 
> As I explained in [2] I think it is fine if FS_IOC_FSSETXATTR
> will also start returning -EINVAL for unsupported flags, but I would
> like setfsxattrat() to make that a guarantee.
> 
> There was an open question, what does fsx_xflags_mask mean
> for setfsxattrat() - it is a mask like in inode_set_flags() as Andreas
> suggested? I think that would be a good idea.
> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/linux-fsdevel/20250216164029.20673-4-pali@kernel.org/
> [2] https://lore.kernel.org/linux-fsdevel/CAOQ4uxjwQJiKAqyjEmKUnq-VihyeSsxyEy2F+J38NXwrAXurFQ@mail.gmail.com/
> 

I'm fine with making Pali's patchset a dependency for this syscall,
as if vfs_fileattr_set() will start returning EINVAL on unsupported
flags this syscall will pass it through (ioctls will need to ignore
it). And as these syscalls use fsxattr anyway the fsx_xflags_mask
field will be here.

-- 
- Andrey


