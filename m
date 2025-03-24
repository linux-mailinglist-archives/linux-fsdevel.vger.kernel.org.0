Return-Path: <linux-fsdevel+bounces-44894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C91EBA6E376
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 20:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CAA3AA639
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 19:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C781519C554;
	Mon, 24 Mar 2025 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ZHOurTVq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B835B1957FC
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844435; cv=none; b=i0NQGgO6Zl+mKD1YdZHGAccQiSNaQIW5iDcAym36PpW/+FMWhXvEXxi3Dp+XbOm/gEw5cD676WlKXF1vpMDyWEMd8VKO1hUmF5Yr63Z9EriX4Z4DbfVBZnZfElLbDCiw1IrMEeie1guUZbNlC4R4AI8BjnrfEGDa+ihV4KDy4ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844435; c=relaxed/simple;
	bh=P4P2z1eF/YNnOfLW8fBoOKbdAwyqWpJFO/rcNQNfqQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=schmMIm1RyUKcYYh1jd5Nj+QbAA9/H74aPgQc9BP+O/BBP5G1Xd6Sq0AQpFykCwGFIxxuh8pVOQPEDeSevq697y+Cqck/seQsOPOF5OP6dwQwvKfoKIHySiPSEe+mXbRAkY6Kbf6oO4nlOwnXuWv1IdKNK4+551V6RRb7bqe0JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ZHOurTVq; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZM32x2TBHzdNB;
	Mon, 24 Mar 2025 20:27:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742844425;
	bh=QBR/kecod01J1h193BKpllSnIdD5DJtmTOWxdGopk5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZHOurTVqBYQHfSi3F6pdPowbpieWYs2igBgvPmtLeNtKh6bOX6LndXdRYsKY6jh9C
	 KH3Sauy/1pIzJ/oIq5tcqOK2Grf+Vopzl7YTCM6Ps/dI4TzMQV42PBtmh1lSd4a4Ot
	 uxKt6oeGXt0Fw5OGk8If/a4DunNXPqyIjb/UWnHQ=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZM32v3B5vz9hp;
	Mon, 24 Mar 2025 20:27:03 +0100 (CET)
Date: Mon, 24 Mar 2025 20:27:02 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, 
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
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v4 1/3] lsm: introduce new hooks for setting/getting
 inode  fsxattr
Message-ID: <20250324.aThi9ioghiex@digikod.net>
References: <20250321-xattrat-syscall-v4-1-3e82e6fb3264@kernel.org>
 <e2d5b27847fde03e0b4b9fc7a464fd87@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2d5b27847fde03e0b4b9fc7a464fd87@paul-moore.com>
X-Infomaniak-Routing: alpha

On Fri, Mar 21, 2025 at 05:32:25PM -0400, Paul Moore wrote:
> On Mar 21, 2025 Andrey Albershteyn <aalbersh@redhat.com> wrote:
> > 
> > Introduce new hooks for setting and getting filesystem extended
> > attributes on inode (FS_IOC_FSGETXATTR).
> > 
> > Cc: selinux@vger.kernel.org
> > Cc: Paul Moore <paul@paul-moore.com>
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  fs/ioctl.c                    |  7 ++++++-
> >  include/linux/lsm_hook_defs.h |  4 ++++
> >  include/linux/security.h      | 16 ++++++++++++++++
> >  security/security.c           | 32 ++++++++++++++++++++++++++++++++
> >  4 files changed, 58 insertions(+), 1 deletion(-)
> 
> Thanks Andrey, one small change below, but otherwise this looks pretty
> good.  If you feel like trying to work up the SELinux implementation but
> need some assitance please let me know, I'll be happy to help :)
> 
> > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > index 638a36be31c14afc66a7fd6eb237d9545e8ad997..4434c97bc5dff5a3e8635e28745cd99404ff353e 100644
> > --- a/fs/ioctl.c
> > +++ b/fs/ioctl.c
> > @@ -525,10 +525,15 @@ EXPORT_SYMBOL(fileattr_fill_flags);
> >  int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
> >  {
> >  	struct inode *inode = d_inode(dentry);
> > +	int error;
> >  
> >  	if (!inode->i_op->fileattr_get)
> >  		return -ENOIOCTLCMD;
> >  
> > +	error = security_inode_getfsxattr(inode, fa);
> > +	if (error)
> > +		return error;
> > +
> >  	return inode->i_op->fileattr_get(dentry, fa);
> >  }
> >  EXPORT_SYMBOL(vfs_fileattr_get);
> > @@ -692,7 +697,7 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
> >  			fa->flags |= old_ma.flags & ~FS_COMMON_FL;
> >  		}
> >  		err = fileattr_set_prepare(inode, &old_ma, fa);
> > -		if (!err)
> > +		if (!err && !security_inode_setfsxattr(inode, fa))
> >  			err = inode->i_op->fileattr_set(idmap, dentry, fa);
> >  	}
> >  	inode_unlock(inode);
> 
> I don't believe we want to hide or otherwise drop the LSM return code as
> that could lead to odd behavior, e.g. returning 0/success despite not
> having executed the fileattr_set operation.

Yes, this should look something like this:

 		err = fileattr_set_prepare(inode, &old_ma, fa);
 		if (err)
 			goto out;
 		err = security_inode_setfsxattr(dentry, fa);
 		if (err)
 			goto out;
 		err = inode->i_op->fileattr_set(idmap, dentry, fa);
 		if (err)
 			goto out;

> 
> --
> paul-moore.com
> 

