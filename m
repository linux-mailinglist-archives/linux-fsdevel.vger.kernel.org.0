Return-Path: <linux-fsdevel+bounces-49107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 149A4AB81F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 11:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9CA717AE30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 09:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9EF296737;
	Thu, 15 May 2025 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHVHIl/G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D87221F2A;
	Thu, 15 May 2025 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747299777; cv=none; b=jtT3/N7R/lEE94yn+UGjppwZIRM1KbH6Dto8CSCGYo2zskVUPihDna11Rw9/+WY2JP+0bwkjNE9Yy8JEubE4mXo/TgYTSZmWQNu3vajVpJ3+gPSPnA1maGWSubZOOFBx7NBrF66XRT6VF23sBp1TAvijURY8GNaln7CzE83/2JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747299777; c=relaxed/simple;
	bh=DdR+iT74thckjay2jHl6JRdQgazSc4DbBO3/97MtQFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T15HEDIukXWlB5KwHKhNImXOriKlMM/1FT4vMBj7UqHdoxjy0Kab3Xhaqy0LfhmrObr81wxAxMGibsJRk+AG4iwMzsLIwO2k8qAzeEI1bd8piDbvsTUK/SOLRpQzQD2Q3xciCUwaunxn+rRf8Yy6PtaBHbl91tfCyzmF9IQGmwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHVHIl/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775F2C4CEE9;
	Thu, 15 May 2025 09:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747299775;
	bh=DdR+iT74thckjay2jHl6JRdQgazSc4DbBO3/97MtQFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HHVHIl/GQ3OfHIKWGc8LdkQdOynuN3eRK9dIFOH9AWzvAg/+YVBY38MKu8m6DIaJ8
	 ogZaKfyHPqx+ER/XGzvNDMaAJXfV6hrFs9q0ktQwnuejL3O9/or3b3r6zzw9MsoMlJ
	 /FEqGnayigRX/WV/PxkJx5UYmJfSr8I8UAHI+AqvH8WkR6JLeSgXDHx4KbTPL/+Xi7
	 MerAdihHYW10gxdyoj2xhrd476PtlJKjWgWOPqTFDM7lf3kHaaaJzyORvTLe7T8W30
	 GJu+ICmU1x4ydKhmvpPyUWChoXSJGDFoFi0Io4h8hJxpz5alVnvt2mKo1RambfbR00
	 hdnawvTLfvo3g==
Date: Thu, 15 May 2025 11:02:39 +0200
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, selinux@vger.kernel.org, ecryptfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v5 0/7] fs: introduce file_getattr and file_setattr
 syscalls
Message-ID: <20250515-bedarf-absagen-464773be3e72@brauner>
References: <20250513-xattrat-syscall-v5-0-22bb9c6c767f@kernel.org>
 <399fdabb-74d3-4dd6-9eee-7884a986dab1@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <399fdabb-74d3-4dd6-9eee-7884a986dab1@app.fastmail.com>

On Tue, May 13, 2025 at 11:53:23AM +0200, Arnd Bergmann wrote:
> On Tue, May 13, 2025, at 11:17, Andrey Albershteyn wrote:
> 
> >
> > 	long syscall(SYS_file_getattr, int dirfd, const char *pathname,
> > 		struct fsxattr *fsx, size_t size, unsigned int at_flags);
> > 	long syscall(SYS_file_setattr, int dirfd, const char *pathname,
> > 		struct fsxattr *fsx, size_t size, unsigned int at_flags);
> 
> I don't think we can have both the "struct fsxattr" from the uapi
> headers, and a variable size as an additional argument. I would
> still prefer not having the extensible structure at all and just

We're not going to add new interfaces that are fixed size unless for the
very basic cases. I don't care if we're doing that somewhere else in the
kernel but we're not doing that for vfs apis.

> use fsxattr, but if you want to make it extensible in this way,
> it should use a different structure (name). Otherwise adding
> fields after fsx_pad[] would break the ioctl interface.

Would that really be a problem? Just along the syscall simply add
something like:

diff --git a/fs/ioctl.c b/fs/ioctl.c
index c91fd2b46a77..d3943805c4be 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -868,12 +868,6 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
        case FS_IOC_SETFLAGS:
                return ioctl_setflags(filp, argp);

-       case FS_IOC_FSGETXATTR:
-               return ioctl_fsgetxattr(filp, argp);
-
-       case FS_IOC_FSSETXATTR:
-               return ioctl_fssetxattr(filp, argp);
-
        case FS_IOC_GETFSUUID:
                return ioctl_getfsuuid(filp, argp);

@@ -886,6 +880,20 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
                break;
        }

+       switch (_IOC_NR(cmd)) {
+       case _IOC_NR(FS_IOC_FSGETXATTR):
+               if (WARN_ON_ONCE(_IOC_TYPE(cmd) != _IOC_TYPE(FS_IOC_FSGETXATTR)))
+                       return SOMETHING_SOMETHING;
+               /* Only handle original size. */
+               return ioctl_fsgetxattr(filp, argp);
+
+       case _IOC_NR(FFS_IOC_FSSETXATTR):
+               if (WARN_ON_ONCE(_IOC_TYPE(cmd) != _IOC_TYPE(FFS_IOC_FSSETXATTR)))
+                       return SOMETHING_SOMETHING;
+               /* Only handle original size. */
+               return ioctl_fssetxattr(filp, argp);
+       }
+
        return -ENOIOCTLCMD;
 }

