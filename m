Return-Path: <linux-fsdevel+bounces-45170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A8BA74023
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 22:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F421894E79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 21:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9BC1DB13A;
	Thu, 27 Mar 2025 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjEZiBD8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAB01C5D44;
	Thu, 27 Mar 2025 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743109997; cv=none; b=c2KdwSLXP9K3+OHn/USovQkhSLEy8Nm49StS2iFwje2rLqjC3BHjkAbnuA9qkE+hKOQDFs4cSAK7zLqlpA8d3aSgL+pFV0AGst5XELQ5aRGckmtXMrE+EAbgxHgjfTA9W1cCsDPyxUR00rPMSCkfr9AAb/7gnMEMUZAIMWdUCzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743109997; c=relaxed/simple;
	bh=UMe20iZUuagLPcGXISw0+QA+ECxOrxToOggTG9tCl7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNOTV/cT/GY2aJ5Kjyacm2I8GB1Hly37RK6gSkMEcS+Cxtpdj7YJJjJG2y9jJ41pnea4cp5NNRTQAs4zBbd0DLDlLLIYNgNrKSuc8J5ynMPmJOvAORPtFq5uKF1XpqqSn5GVKOzS4oM5Y0VtZOL8An+pBG6tqVGYeV5xNbPCvvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjEZiBD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A25C4CEDD;
	Thu, 27 Mar 2025 21:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743109997;
	bh=UMe20iZUuagLPcGXISw0+QA+ECxOrxToOggTG9tCl7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pjEZiBD8e0ystDPIxq5rYB0BhzyFxROf/Ryj0zF5OUcIL6U1NSR+ohFVoWx75A5O1
	 zUDoz9NmZeNhN/ml8TDozSK+FHArIgNzTxMJisrUKKp0QrJDSE/48Gm/7w9gYMhpsC
	 0cjmF7vuhAtNHlUTYpDxoSTAP2NIVeQICKV+KIimhR/fvFSexTVvShIeniU2H9xu1t
	 lHLCiQ6glh0GSWZ9t6y1BCD9rlFIlXjQRsKBMmV5eyX9HujEsmEI+WN4RIPfT1OqXc
	 wkwp1dgNkF3j8gBSpRl+CYes246BZH+3WMNbFuFYx4I5178EjPlyXmTihrByrFKRp0
	 bGdzAIry8bGnQ==
Received: by pali.im (Postfix)
	id 9561981B; Thu, 27 Mar 2025 22:13:01 +0100 (CET)
Date: Thu, 27 Mar 2025 22:13:01 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Andrey Albershteyn <aalbersh@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
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
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, selinux@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 0/3] fs: introduce getfsxattrat and setfsxattrat
 syscalls
Message-ID: <20250327211301.kdsohqou3s242coa@pali>
References: <20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org>
 <CAOQ4uxjQDUg8HFG+mSxMkR54zen7nC2jttzOKqh13Bx-uosh3Q@mail.gmail.com>
 <20250323103234.2mwhpsbigpwtiby4@pali>
 <CAOQ4uxiTKhGs1H-w1Hv-+MqY284m92Pvxfem0iWO+8THdzGvuA@mail.gmail.com>
 <20250327192629.ivnarhlkfbhbzjcl@pali>
 <CAOQ4uxhJ53h+1AjtF4B64onqvRfZsJ3n1OFikyJpXAPTyX45iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhJ53h+1AjtF4B64onqvRfZsJ3n1OFikyJpXAPTyX45iQ@mail.gmail.com>
User-Agent: NeoMutt/20180716

On Thursday 27 March 2025 21:57:34 Amir Goldstein wrote:
> On Thu, Mar 27, 2025 at 8:26 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Thursday 27 March 2025 12:47:02 Amir Goldstein wrote:
> > > On Sun, Mar 23, 2025 at 11:32 AM Pali Rohár <pali@kernel.org> wrote:
> > > >
> > > > On Sunday 23 March 2025 09:45:06 Amir Goldstein wrote:
> > > > > On Fri, Mar 21, 2025 at 8:50 PM Andrey Albershteyn <aalbersh@redhat.com> wrote:
> > > > > >
> > > > > > This patchset introduced two new syscalls getfsxattrat() and
> > > > > > setfsxattrat(). These syscalls are similar to FS_IOC_FSSETXATTR ioctl()
> > > > > > except they use *at() semantics. Therefore, there's no need to open the
> > > > > > file to get an fd.
> > > > > >
> > > > > > These syscalls allow userspace to set filesystem inode attributes on
> > > > > > special files. One of the usage examples is XFS quota projects.
> > > > > >
> > > > > > XFS has project quotas which could be attached to a directory. All
> > > > > > new inodes in these directories inherit project ID set on parent
> > > > > > directory.
> > > > > >
> > > > > > The project is created from userspace by opening and calling
> > > > > > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > > > > > files such as FIFO, SOCK, BLK etc. Therefore, some inodes are left
> > > > > > with empty project ID. Those inodes then are not shown in the quota
> > > > > > accounting but still exist in the directory. This is not critical but in
> > > > > > the case when special files are created in the directory with already
> > > > > > existing project quota, these new inodes inherit extended attributes.
> > > > > > This creates a mix of special files with and without attributes.
> > > > > > Moreover, special files with attributes don't have a possibility to
> > > > > > become clear or change the attributes. This, in turn, prevents userspace
> > > > > > from re-creating quota project on these existing files.
> > > > > >
> > > > > > Christian, if this get in some mergeable state, please don't merge it
> > > > > > yet. Amir suggested these syscalls better to use updated struct fsxattr
> > > > > > with masking from Pali Rohár patchset, so, let's see how it goes.
> > > > >
> > > > > Andrey,
> > > > >
> > > > > To be honest I don't think it would be fair to delay your syscalls more
> > > > > than needed.
> > > >
> > > > I agree.
> > > >
> > > > > If Pali can follow through and post patches on top of your syscalls for
> > > > > next merge window that would be great, but otherwise, I think the
> > > > > minimum requirement is that the syscalls return EINVAL if fsx_pad
> > > > > is not zero. we can take it from there later.
> > > >
> > > > IMHO SYS_getfsxattrat is fine in this form.
> > > >
> > > > For SYS_setfsxattrat I think there are needed some modifications
> > > > otherwise we would have problem again with backward compatibility as
> > > > is with ioctl if the syscall wants to be extended in future.
> > > >
> > > > I would suggest for following modifications for SYS_setfsxattrat:
> > > >
> > > > - return EINVAL if fsx_xflags contains some reserved or unsupported flag
> > > >
> > > > - add some flag to completely ignore fsx_extsize, fsx_projid, and
> > > >   fsx_cowextsize fields, so SYS_setfsxattrat could be used just to
> > > >   change fsx_xflags, and so could be used without the preceding
> > > >   SYS_getfsxattrat call.
> > > >
> > > > What do you think about it?
> > >
> > > I think all Andrey needs to do now is return -EINVAL if fsx_pad is not zero.
> > >
> > > You can use this later to extend for the semantics of flags/fields mask
> > > and we can have a long discussion later on what this semantics should be.
> > >
> > > Right?
> > >
> > > Amir.
> >
> > It is really enough?
> 
> I don't know. Let's see...
> 
> > All new extensions later would have to be added
> > into fsx_pad fields, and currently unused bits in fsx_xflags would be
> > unusable for extensions.
> 
> I am working under the assumption that the first extension would be
> to support fsx_xflags_mask and from there, you could add filesystem
> flags support checks and then new flags. Am I wrong?
> 
> Obviously, fsx_xflags_mask would be taken from fsx_pad space.
> After that extension is implemented, calling SYS_setfsxattrat() with
> a zero fsx_xflags_mask would be silly for programs that do not do
> the legacy get+set.
> 
> So when we introduce  fsx_xflags_mask, we could say that a value
> of zero means that the mask is not being checked at all and unknown
> flags in set syscall are ignored (a.k.a legacy ioctl behavior).
> 
> Programs that actually want to try and set without get will have to set
> a non zero fsx_xflags_mask to do something useful.

Here we need to also solve the problem that without GET call we do not
have valid values for fsx_extsize, fsx_projid, and fsx_cowextsize. So
maybe we would need some flag in fsx_pad that fsx_extsize, fsx_projid,
or fsx_cowextsize are ignored/masked.

> I don't think this is great.
> I would rather that the first version of syscalls will require the mask
> and will always enforce filesystems supported flags.

It is not great... But what about this? In a first step (part of this
syscall patch series) would be just a check that fsx_pad is zero.
Non-zero will return -EINVAL.

In next changes would added fsx_filter bit field, which for each
fsx_xflags and also for fsx_extsize, fsx_projid, and fsx_cowextsize
fields would add a new bit flag which would say (when SET) that the
particular thing has to be ignored.

So when fsx_pad is all-zeros then fsx_filter (first field in fsx_pad)
would say that nothing in fsx_xflags, fsx_extsize, fsx_projid, and
fsx_cowextsize is ignored, and hence behave like before.

And when something in fsx_pad/fsx_filter is set then it says which
fields are ignored/filtered-out.

> If you can get those patches (on top of current series) posted and
> reviewed in time for the next merge window, including consensus
> on the actual semantics, that would be the best IMO.

I think that this starting to be more complicated to rebase my patches
in a way that they do not affect IOCTL path but implement it properly
for new syscall path. It does not sounds like a trivial thing which I
would finish in merge window time and having proper review and consensus
on this.

> But I am just preparing a plan B in case you do not have time to
> work on the patches or if consensus on the API extensions is not
> reached on time.
> 
> I think that for plan B, the minimum is to verify zero pad field and
> that is something that this syscall has to do anyway, because this
> is the way that backward compact APIs work.
> 
> If you want the syscall to always return -EINVAL for setting xflags
> that are currently undefined I agree that would be nice as well.
> 
> Thanks,
> Amir.

