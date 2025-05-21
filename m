Return-Path: <linux-fsdevel+bounces-49565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DFAABEEC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 10:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCCF94E09CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 08:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BBB238C1B;
	Wed, 21 May 2025 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qnbh/9kI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3DD236A70;
	Wed, 21 May 2025 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747817879; cv=none; b=Zx2oRhOFjdkm1WZGcKYTrImhNx3eO5s9eYomUctUnMjp3BIRPlh9KT66CZGVMlJca0QD0eHNasfnxedMx1VzlllOHawEmO0io20DKIPM2GSdzdc31NezIFw2nGgiXw+96/KrTaGL0sAR0wTf7QX64P6vIeJ+63cLMVQK9XMDkNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747817879; c=relaxed/simple;
	bh=ua7q+H1WgOWVcLV6yULMClYrx7Bnz34PuVBhzv5mcnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMWQ0nnNLUl2tXWxxezcvkGxAculrzVAP0rdwu4M0paH6rFzelprgtEtjfLLOPfHLRc9xCAVPWYQVZqixo822JtHDy67B5fOLbW0qCIkqutYUoWN2uKlcPtF8zU0wHykBCRijJakSMWsfv4o4VW0hTXucNmx/OkVcvikkj1FYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qnbh/9kI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA2CC4CEE4;
	Wed, 21 May 2025 08:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747817878;
	bh=ua7q+H1WgOWVcLV6yULMClYrx7Bnz34PuVBhzv5mcnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qnbh/9kIwlewmeCrHEnn70KkQc7O6ES+h8TW8j/oXsWNJ8+b91k9gp3+D3oZZAEac
	 35c3sk+4H9+LrdhVh3+BRIaFwTuEgCY/r5l2yO92nXgCMQy61/k0yoNjWKeGc2V/Si
	 NY9oILnzoc9TzjFhgfrBKetfvo6MC0PZqBtDlnbkaS/ubj3EVJQy1dj6E+ibksH16G
	 rJDUt+ooLqAAhB6VGuaiYtoqpd4RD5k+dgbtaPRgKAslON+3YvDyq2wtTcroGVVnt0
	 sLcgQKTGtDmhr5cPTHPpW0YoTRs0xFSaPqveGoMro01wO/uvx2kF19riNOx4IWeT06
	 9A24umMO5i9CA==
Received: by pali.im (Postfix)
	id 61EBE723; Wed, 21 May 2025 10:57:55 +0200 (CEST)
Date: Wed, 21 May 2025 10:57:55 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
	Linux-Arch <linux-arch@vger.kernel.org>, selinux@vger.kernel.org,
	ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v5 0/7] fs: introduce file_getattr and file_setattr
 syscalls
Message-ID: <20250521085755.4bucg7vq2kb3mbfk@pali>
References: <20250513-xattrat-syscall-v5-0-22bb9c6c767f@kernel.org>
 <399fdabb-74d3-4dd6-9eee-7884a986dab1@app.fastmail.com>
 <20250515-bedarf-absagen-464773be3e72@brauner>
 <CAOQ4uxicuEkOas2UR4mqfus9Q2RAeKKYTwbE2XrkcE_zp8oScQ@mail.gmail.com>
 <aCsX4LTpAnGfFjHg@dread.disaster.area>
 <sfmrojifgnrpeilqxtixyqrdjj5uvvpbvirxmlju5yce7z72vi@ondnx7qbie4y>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sfmrojifgnrpeilqxtixyqrdjj5uvvpbvirxmlju5yce7z72vi@ondnx7qbie4y>
User-Agent: NeoMutt/20180716

On Wednesday 21 May 2025 10:48:26 Andrey Albershteyn wrote:
> On 2025-05-19 21:37:04, Dave Chinner wrote:
> > On Thu, May 15, 2025 at 12:33:31PM +0200, Amir Goldstein wrote:
> > > On Thu, May 15, 2025 at 11:02 AM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > On Tue, May 13, 2025 at 11:53:23AM +0200, Arnd Bergmann wrote:
> > > > > On Tue, May 13, 2025, at 11:17, Andrey Albershteyn wrote:
> > > > >
> > > > > >
> > > > > >     long syscall(SYS_file_getattr, int dirfd, const char *pathname,
> > > > > >             struct fsxattr *fsx, size_t size, unsigned int at_flags);
> > > > > >     long syscall(SYS_file_setattr, int dirfd, const char *pathname,
> > > > > >             struct fsxattr *fsx, size_t size, unsigned int at_flags);
> > > > >
> > > > > I don't think we can have both the "struct fsxattr" from the uapi
> > > > > headers, and a variable size as an additional argument. I would
> > > > > still prefer not having the extensible structure at all and just
> > > >
> > > > We're not going to add new interfaces that are fixed size unless for the
> > > > very basic cases. I don't care if we're doing that somewhere else in the
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
> > > > @@ -868,12 +868,6 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
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
> > > > @@ -886,6 +880,20 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
> > > >                 break;
> > > >         }
> > > >
> > > > +       switch (_IOC_NR(cmd)) {
> > > > +       case _IOC_NR(FS_IOC_FSGETXATTR):
> > > > +               if (WARN_ON_ONCE(_IOC_TYPE(cmd) != _IOC_TYPE(FS_IOC_FSGETXATTR)))
> > > > +                       return SOMETHING_SOMETHING;
> > > > +               /* Only handle original size. */
> > > > +               return ioctl_fsgetxattr(filp, argp);
> > > > +
> > > > +       case _IOC_NR(FFS_IOC_FSSETXATTR):
> > > > +               if (WARN_ON_ONCE(_IOC_TYPE(cmd) != _IOC_TYPE(FFS_IOC_FSSETXATTR)))
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
> > > Should we will need to depart from this struct definition and we might
> > > as well do it for the initial release of the syscall rather than later on, e.g.:
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
> > > +       __u32           fsx_xflags;     /* xflags field value (get/set) */
> > > +       __u32           fsx_extsize;    /* extsize field value (get/set)*/
> > > +       __u32           fsx_nextents;   /* nextents field value (get)   */
> > > +       __u32           fsx_projid;     /* project identifier (get/set) */
> > > +       __u32           fsx_cowextsize; /* CoW extsize field value (get/set)*/
> > > +};
> > > +
> > > +#define FSXATTR_SIZE_VER0 20
> > > +#define FSXATTR_SIZE_LATEST FSXATTR_SIZE_VER0
> > 
> > If all the structures overlap the same, all that is needed in the
> > code is to define the structure size that should be copied in and
> > parsed. i.e:
> > 
> > 	case FSXATTR..._V1:
> > 		return ioctl_fsxattr...(args, sizeof(fsx_fileattr_v1));
> > 	case FSXATTR..._V2:
> > 		return ioctl_fsxattr...(args, sizeof(fsx_fileattr_v2));
> > 	case FSXATTR...:
> > 		return ioctl_fsxattr...(args, sizeof(fsx_fileattr));
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
> 
> -- 
> - Andrey
> 

It is planned to extend this structure for new windows attributes as was
discussed. And seem that the current free space would not be enough for
everything.

