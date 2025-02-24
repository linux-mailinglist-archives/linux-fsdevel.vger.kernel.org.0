Return-Path: <linux-fsdevel+bounces-42402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA811A41DF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 12:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F8167A15CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 11:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAEB25EF8C;
	Mon, 24 Feb 2025 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVWfNpja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B702571CD;
	Mon, 24 Feb 2025 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396753; cv=none; b=rIqZm3bDhtcSqC3ejtbSylHWLgD9q3h1z92vCdFjXSpSZ1rtHebJDQrPCcxeDg0dIwXFMAmHWLOdPNG0zJMOF7DofwxhYwYfIM/La4O8Gs4gT1v3xWBov6VEt0fu9Ne7IyGg79G3Gb4zCwyE8T6xKstj//jhYbl+LwHvlXC+WOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396753; c=relaxed/simple;
	bh=/3Mh6pug+713M2/VDC4hgpIDh9F4ngYOQu3zb5WfebM=;
	h=Date:From:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzFa8ZWVTTNg9FDNjHZziOf8hyQ/0KJKM66aJHKfbPIbCKf9CioQQ0/rgU85S74MLBObKdbV5mBx75lCNf4DAFCtzmxrvCOQGE7Sz1gdXffWSIAXNjwZZCLgzGfJ6VFke4N9GETRLCdGcf2IathFt16b1a6GaHnZGoknJlLFuf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVWfNpja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E138C4CED6;
	Mon, 24 Feb 2025 11:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396752;
	bh=/3Mh6pug+713M2/VDC4hgpIDh9F4ngYOQu3zb5WfebM=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=hVWfNpjapTs9Gzqso9NB1m1ULW6zQPSObcIfIOnmoo3UgEOo4r/dmDmSaSI9IfwTP
	 Ar8P2zDogME/kiUPhwy10R9KxLU//uhD6zuPOnNL0o/8YC/3Xlkw+2iGAx7Bv2r0JI
	 BRT5sV8wVLMC9dcbIUVu95Kd0KhrHyroW35DBtfhLb2axglzIrroUkqae91AxOZwtp
	 6t0UHwqaSbVkll8v4gtSgLaV36jXEMXEJBOJStRzYCLO239Fvq6RByGaH9nO9bwvFd
	 vytICMqj4HwAT3wRKsBcKZpqc8CSaDQOQWo5JwkzT3mWostsHNatJX17ydAshLFWah
	 mqN8YB3Ihk8MQ==
Date: Mon, 24 Feb 2025 12:32:17 +0100
From: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Andrey Albershteyn <aalbersh@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>, 
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
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH v3] fs: introduce getfsxattrat and setfsxattrat syscalls
Message-ID: <20250224-klinke-hochdekoriert-3f6be89005a8@brauner>
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

On Fri, Feb 21, 2025 at 08:15:24PM +0100, Amir Goldstein wrote:
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

Please version the struct by size as we do for clone3(),
mount_setattr(), listmount()'s struct mnt_id_req, sched_setattr(), all
the new xattrat*() system calls and a host of others. So laying out the
struct 64bit and passing a size alongside it.

This is all handled by copy_struct_from_user() and copy_struct_to_user()
so nothing to reinvent. And it's easy to copy from existing system
calls.

