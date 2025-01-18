Return-Path: <linux-fsdevel+bounces-39592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B76A15EB2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 21:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0CC18860F0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 20:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DD61B4224;
	Sat, 18 Jan 2025 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugKIbNRm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959B835968;
	Sat, 18 Jan 2025 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737231250; cv=none; b=GZ4hYx3dmuYp0roUio+ZHa8y9UJgyMs7U86RuTYjRH3/E6fUGcsw6khSU6/T643jSZjzG2j+/I+ZDwYMkMt58LXQvyAo6smLbF8TdfOkPf9qKQcODluvbte5T91fhNqyS5D94bmdVLvLk0UacN9jxdEXqtcrVuZUAHfLvur4IcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737231250; c=relaxed/simple;
	bh=fHHMr+HKXqQlRFCd+l7fLRsf+3H9anWso/9OIjYa0Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txfNQOftNYKKw1eYu2cHBpB0928+Jf5krSCNycrBNV8IaGIum4JE7mSjCdhk9JZzKmntwCB7MOdW1uhjdT53IMlgsziy5qD8VTBGIT1FIVgMhUy2GAG/JbylSbiAgBLeqL03MaJR3A6Dr3delKHXar0Znk8subNmEa9U5pL9VT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugKIbNRm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED38CC4CED1;
	Sat, 18 Jan 2025 20:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737231250;
	bh=fHHMr+HKXqQlRFCd+l7fLRsf+3H9anWso/9OIjYa0Qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ugKIbNRm22aBExz1R1jPLD3NFRp9CPvsZmmJa8uvEBU95w4GgE0JR+MgztEdRLBi0
	 T2m6K4xM7vpxPMocYOIuHfY66F2rzQ5cbI/Q20qxp0Vi3Y76ez2nu26nVncikKrCaA
	 SQRIqY/CBH+pPTn1NAy0yp87gN4KPVh6X0d+Nvb/NWz4v6vhKLsMMGSRn8x4tG4dqx
	 hg0lhfHQgsDcwC7KriQ9kkI0v8/IWPGDK7CXW7C84ma5/fPMe/6l56QX9KJJfumZA3
	 yK01vZAjlTNzA1S5bpl/wGHcYlCR+3q6hISmQ9he0DEEFNr+ux9fGPiHc/nbkrSVxu
	 CCFI3hpvVNOHQ==
Date: Sat, 18 Jan 2025 12:14:09 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] fstests: workaround for gcc-15
Message-ID: <20250118201409.GR3557553@frogsfrogsfrogs>
References: <20250117043709.2941857-1-zlang@kernel.org>
 <20250117172736.GG1611770@frogsfrogsfrogs>
 <20250118143214.gcrqvwfa4jnkawyj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250118143214.gcrqvwfa4jnkawyj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Sat, Jan 18, 2025 at 10:32:14PM +0800, Zorro Lang wrote:
> On Fri, Jan 17, 2025 at 09:27:36AM -0800, Darrick J. Wong wrote:
> > On Fri, Jan 17, 2025 at 12:37:09PM +0800, Zorro Lang wrote:
> > > GCC-15 does a big change, it changes the default language version for
> > > C compilation from -std=gnu17 to -std=gnu23. That cause lots of "old
> > > style" C codes hit build errors. On the other word, current xfstests
> > > can't be used with GCC-15. So -std=gnu17 can help that.
> > > 
> > > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > > ---
> > > 
> > > Hi,
> > > 
> > > I send this patch just for talking about this issue. The upcoming gcc-15
> > > does lots of changes, a big change is using C23 by default:
> > > 
> > >   https://gcc.gnu.org/gcc-15/porting_to.html
> > > 
> > > xfstests has many old style C codes, they hard to be built with gcc-15.
> > > So we have to either add -std=$old_version (likes this patch), or port
> > > the code to C23.
> > > 
> > > This patch is just a workaround (and a reminder for someone might hit
> > > this issue with gcc-15 too). If you have any good suggestions or experience
> > > (for this kind of issue) to share, feel free to reply.
> > 
> > -std=gnu11 to match the kernel and xfsprogs?
> 
> So you prefer using a settled "-std=xxx" to changing codes to match "gnu23"?

Only gcc 14 and 15 support gnu23, which will break the builds on ancient
distros such as Debian 12 and RHEL9.  Also, there's the human cost that
now fs developers have to know /two/ C dialects -- gnu11 for the kernel,
and gnu23 for fstests.

So yes, I prefer using -std=gnu11 for better consistency and tooling
support.

--D

> > 
> > --D
> > 
> > > Thanks,
> > > Zorro
> > > 
> > >  include/builddefs.in | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/include/builddefs.in b/include/builddefs.in
> > > index 5b5864278..ef124bb87 100644
> > > --- a/include/builddefs.in
> > > +++ b/include/builddefs.in
> > > @@ -75,7 +75,7 @@ HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
> > >  NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = @need_internal_xfs_ioc_exchange_range@
> > >  HAVE_FICLONE = @have_ficlone@
> > >  
> > > -GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall
> > > +GCCFLAGS = -funsigned-char -fno-strict-aliasing -std=gnu17 -Wall
> > >  SANITIZER_CFLAGS += @autovar_init_cflags@
> > >  
> > >  ifeq ($(PKG_PLATFORM),linux)
> > > -- 
> > > 2.47.1
> > > 
> > > 
> > 
> 

