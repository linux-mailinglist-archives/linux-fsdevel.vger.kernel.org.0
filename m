Return-Path: <linux-fsdevel+bounces-57544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8765FB22F09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 19:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B653168BB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAF92FDC20;
	Tue, 12 Aug 2025 17:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUKm3slb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D24E21D596;
	Tue, 12 Aug 2025 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755019688; cv=none; b=GLCWsIlFYIOWkwIEfn9DI7D05JwdM8sl9FVAgaIVKV1n8Y1DXydzXop9Z4V84jPtbOkPt2fHt3cZSb82deGWB5hsyxjdFI/OvPtbM3iyqHGqr8LiEkIXFLgeiAQqb7KalC6cXRpR/K2CWPigzEun4qP4eP0eobLVLTghUQBAlis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755019688; c=relaxed/simple;
	bh=0A6gNOcVkUiRTxlRG+XQ6gS+Dz81Jv29CzJ1M41z5Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASXLtb+SwdkccBKRntVlYULJROEPDgXDpVMeTfrCIC+sEHIaspg8fuFRWFVT8DETgbtYxyLLXgCSEyzMYNYQq3alu4QLJ/ChQdy0eq37xIsSKBxJRKzm0cFi3g/NrXHDP9UtJV3kas64S23XNf7oVDtOrFWEnkj7ouY+1ogEQV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUKm3slb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646FAC4CEF0;
	Tue, 12 Aug 2025 17:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755019688;
	bh=0A6gNOcVkUiRTxlRG+XQ6gS+Dz81Jv29CzJ1M41z5Yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LUKm3slbWiCBHsU9daETxVeZPkrBDRh5xzJgf95W2KBOwGSElr5/FleQO/PKh6543
	 TeuNC7zTc5V5M68AamjWo2bcPSYR3Lk0bphN77YquOW5mikxsZrE1dzfB0Vb4Pl172
	 cAXZFKmMh7NCkJJ6X9oot3OPdpM762x+swFUgc3aMr+KSKe2sCOHEJMOY/Nrn7Uips
	 54QqVJgXjkpwSkopalxasUXDBC9QfsdyDtfFZh4iRi/DY3JaUaJtMJnHMrk6PHcYd6
	 W3M2WLMDAoVFkJwf/UmR9aoMQ/AiQhK+r4CzhtJ0I999suJK9B5Ci+2JtLvelUJrkv
	 fL/xf4fypzjFQ==
Date: Tue, 12 Aug 2025 10:28:07 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: aalbersh@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/4] xfs_io: make ls/chattr work with special files
Message-ID: <20250812172807.GL7965@frogsfrogsfrogs>
References: <20250808-xattrat-syscall-v1-0-48567c29e45c@kernel.org>
 <20250808-xattrat-syscall-v1-3-48567c29e45c@kernel.org>
 <20250811151217.GC7965@frogsfrogsfrogs>
 <4566ibfc2eljlicxwgdyp3q2m4o72vm3mxe6epg7e7grbkvqv4@564comcelktz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4566ibfc2eljlicxwgdyp3q2m4o72vm3mxe6epg7e7grbkvqv4@564comcelktz>

On Mon, Aug 11, 2025 at 07:57:20PM +0200, Andrey Albershteyn wrote:
> On 2025-08-11 08:12:17, Darrick J. Wong wrote:
> > On Fri, Aug 08, 2025 at 09:30:18PM +0200, Andrey Albershteyn wrote:
> > > From: Andrey Albershteyn <aalbersh@redhat.com>
> > > 
> > > With new file_getattr/file_setattr syscalls we can now list/change file
> > > attributes on special files instead for ignoring them.
> > > 
> > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > > ---
> > >  io/attr.c | 130 ++++++++++++++++++++++++++++++++++++--------------------------
> > >  1 file changed, 75 insertions(+), 55 deletions(-)
> > > 
> > > diff --git a/io/attr.c b/io/attr.c
> > > index fd82a2e73801..1cce602074f4 100644
> > > --- a/io/attr.c
> > > +++ b/io/attr.c
> > > @@ -8,6 +8,7 @@
> > >  #include "input.h"
> > >  #include "init.h"
> > >  #include "io.h"
> > > +#include "libfrog/file_attr.h"
> > >  
> > >  static cmdinfo_t chattr_cmd;
> > >  static cmdinfo_t lsattr_cmd;
> > > @@ -156,36 +157,35 @@ lsattr_callback(
> > >  	int			status,
> > >  	struct FTW		*data)
> > >  {
> > > -	struct fsxattr		fsx;
> > > -	int			fd;
> > > +	struct file_attr	fa;
> > > +	int			error;
> > >  
> > >  	if (recurse_dir && !S_ISDIR(stat->st_mode))
> > >  		return 0;
> > >  
> > > -	if ((fd = open(path, O_RDONLY)) == -1) {
> > > -		fprintf(stderr, _("%s: cannot open %s: %s\n"),
> > > -			progname, path, strerror(errno));
> > > -		exitcode = 1;
> > > -	} else if ((xfsctl(path, fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
> > > +	error = file_getattr(AT_FDCWD, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
> > > +	if (error) {
> > >  		fprintf(stderr, _("%s: cannot get flags on %s: %s\n"),
> > >  			progname, path, strerror(errno));
> > >  		exitcode = 1;
> > > -	} else
> > > -		printxattr(fsx.fsx_xflags, 0, 1, path, 0, 1);
> > > +		return 0;
> > > +	}
> > > +
> > > +	printxattr(fa.fa_xflags, 0, 1, path, 0, 1);
> > 
> > Maybe it's time to rename this printxflags or something that's less
> > easily confused with extended attributes...
> 
> print_xflags()?

Sounds good to me.

> > 
> > >  
> > > -	if (fd != -1)
> > > -		close(fd);
> > >  	return 0;
> > >  }
> > >  
> > >  static int
> > >  lsattr_f(
> > > -	int		argc,
> > > -	char		**argv)
> > > +	int			argc,
> > > +	char			**argv)
> > >  {
> > > -	struct fsxattr	fsx;
> > > -	char		*name = file->name;
> > > -	int		c, aflag = 0, vflag = 0;
> > > +	struct file_attr	fa;
> > > +	char			*name = file->name;
> > > +	int			c, aflag = 0, vflag = 0;
> > > +	struct stat		st;
> > > +	int			error;
> > >  
> > >  	recurse_all = recurse_dir = 0;
> > >  	while ((c = getopt(argc, argv, "DRav")) != EOF) {
> > > @@ -211,17 +211,27 @@ lsattr_f(
> > >  	if (recurse_all || recurse_dir) {
> > >  		nftw(name, lsattr_callback,
> > >  			100, FTW_PHYS | FTW_MOUNT | FTW_DEPTH);
> > > -	} else if ((xfsctl(name, file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
> > > +		return 0;
> > > +	}
> > > +
> > > +	error = stat(name, &st);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	error = file_getattr(AT_FDCWD, name, &st, &fa, AT_SYMLINK_NOFOLLOW);
> > > +	if (error) {
> > >  		fprintf(stderr, _("%s: cannot get flags on %s: %s\n"),
> > >  			progname, name, strerror(errno));
> > >  		exitcode = 1;
> > > -	} else {
> > > -		printxattr(fsx.fsx_xflags, vflag, !aflag, name, vflag, !aflag);
> > > -		if (aflag) {
> > > -			fputs("/", stdout);
> > > -			printxattr(-1, 0, 1, name, 0, 1);
> > > -		}
> > > +		return 0;
> > >  	}
> > > +
> > > +	printxattr(fa.fa_xflags, vflag, !aflag, name, vflag, !aflag);
> > > +	if (aflag) {
> > > +		fputs("/", stdout);
> > > +		printxattr(-1, 0, 1, name, 0, 1);
> > > +	}
> > > +
> > >  	return 0;
> > >  }
> > >  
> > > @@ -232,44 +242,43 @@ chattr_callback(
> > >  	int			status,
> > >  	struct FTW		*data)
> > >  {
> > > -	struct fsxattr		attr;
> > > -	int			fd;
> > > +	struct file_attr	attr;
> > > +	int			error;
> > >  
> > >  	if (recurse_dir && !S_ISDIR(stat->st_mode))
> > >  		return 0;
> > >  
> > > -	if ((fd = open(path, O_RDONLY)) == -1) {
> > > -		fprintf(stderr, _("%s: cannot open %s: %s\n"),
> > > -			progname, path, strerror(errno));
> > > -		exitcode = 1;
> > > -	} else if (xfsctl(path, fd, FS_IOC_FSGETXATTR, &attr) < 0) {
> > > +	error = file_getattr(AT_FDCWD, path, stat, &attr, AT_SYMLINK_NOFOLLOW);
> > > +	if (error) {
> > >  		fprintf(stderr, _("%s: cannot get flags on %s: %s\n"),
> > >  			progname, path, strerror(errno));
> > >  		exitcode = 1;
> > > -	} else {
> > > -		attr.fsx_xflags |= orflags;
> > > -		attr.fsx_xflags &= ~andflags;
> > > -		if (xfsctl(path, fd, FS_IOC_FSSETXATTR, &attr) < 0) {
> > > -			fprintf(stderr, _("%s: cannot set flags on %s: %s\n"),
> > > -				progname, path, strerror(errno));
> > > -			exitcode = 1;
> > > -		}
> > > +		return 0;
> > > +	}
> > > +
> > > +	attr.fa_xflags |= orflags;
> > > +	attr.fa_xflags &= ~andflags;
> > > +	error = file_setattr(AT_FDCWD, path, stat, &attr, AT_SYMLINK_NOFOLLOW);
> > > +	if (error) {
> > > +		fprintf(stderr, _("%s: cannot set flags on %s: %s\n"),
> > > +			progname, path, strerror(errno));
> > > +		exitcode = 1;
> > >  	}
> > >  
> > > -	if (fd != -1)
> > > -		close(fd);
> > >  	return 0;
> > >  }
> > >  
> > >  static int
> > >  chattr_f(
> > > -	int		argc,
> > > -	char		**argv)
> > > +	int			argc,
> > > +	char			**argv)
> > >  {
> > > -	struct fsxattr	attr;
> > > -	struct xflags	*p;
> > > -	unsigned int	i = 0;
> > > -	char		*c, *name = file->name;
> > > +	struct file_attr	attr;
> > > +	struct xflags		*p;
> > > +	unsigned int		i = 0;
> > > +	char			*c, *name = file->name;
> > > +	struct stat		st;
> > > +	int			error;
> > >  
> > >  	orflags = andflags = 0;
> > >  	recurse_all = recurse_dir = 0;
> > > @@ -326,19 +335,30 @@ chattr_f(
> > >  	if (recurse_all || recurse_dir) {
> > >  		nftw(name, chattr_callback,
> > >  			100, FTW_PHYS | FTW_MOUNT | FTW_DEPTH);
> > > -	} else if (xfsctl(name, file->fd, FS_IOC_FSGETXATTR, &attr) < 0) {
> > > +		return 0;
> > > +	}
> > > +
> > > +	error = stat(name, &st);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	error = file_getattr(AT_FDCWD, name, &st, &attr, AT_SYMLINK_NOFOLLOW);
> > > +	if (error) {
> > >  		fprintf(stderr, _("%s: cannot get flags on %s: %s\n"),
> > >  			progname, name, strerror(errno));
> > >  		exitcode = 1;
> > > -	} else {
> > > -		attr.fsx_xflags |= orflags;
> > > -		attr.fsx_xflags &= ~andflags;
> > > -		if (xfsctl(name, file->fd, FS_IOC_FSSETXATTR, &attr) < 0) {
> > > -			fprintf(stderr, _("%s: cannot set flags on %s: %s\n"),
> > > -				progname, name, strerror(errno));
> > > -			exitcode = 1;
> > > -		}
> > > +		return 0;
> > >  	}
> > > +
> > > +	attr.fa_xflags |= orflags;
> > > +	attr.fa_xflags &= ~andflags;
> > > +	error = file_setattr(AT_FDCWD, name, &st, &attr, AT_SYMLINK_NOFOLLOW);
> > 
> > For my own curiosity, if you wanted to do the get/set sequence on a file
> > that's already open, is that just:
> > 
> > 	file_getattr(fd, "", &attr, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW);
> > 	...
> > 	file_setattr(fd, "", &attr, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW);
> 
> yeah, that should work

Cool, thanks for confirming my understanding. :)

--D

> > 
> > --D
> > 
> > > +	if (error) {
> > > +		fprintf(stderr, _("%s: cannot set flags on %s: %s\n"),
> > > +			progname, name, strerror(errno));
> > > +		exitcode = 1;
> > > +	}
> > > +
> > >  	return 0;
> > >  }
> > >  
> > > 
> > > -- 
> > > 2.49.0
> > > 
> > > 
> > 
> 
> -- 
> - Andrey
> 
> 

