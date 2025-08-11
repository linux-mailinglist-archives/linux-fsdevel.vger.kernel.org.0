Return-Path: <linux-fsdevel+bounces-57406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BB1B213B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 19:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C812A8438
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 17:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33B62D47EF;
	Mon, 11 Aug 2025 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qza7rxg2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A802C21FF
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754934727; cv=none; b=CX4+8+2kAQ67G63tkSKTpNwqi455JD/5LE7tL1xwiFz75f9gpBv9LETV6Gw9DObjNiCLG9HnyjMB41/8TeiH4fQgCZy8a+RerUMchTL58hcutk+MfEey5Tbqd4OVnJgG7LoykpLaHJtMLMmnNELbshOukBWBHc+JUkvkHNOdrSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754934727; c=relaxed/simple;
	bh=LylafxiwH3k+ZP4j46HDIJ64h1LHH7pZctqxhPvSUs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxQHNbkqvJqCFghkyaxWxFKGfy4L+/4iH1ZmF9J3Hra0PHHBp0HI36RrMRpUzoZ7cmRiebeeK3kxOF27Dr8aYRdUvN/EtRSJ0gFWmuqfyIBS7/9DpdPkTk5lN2+nbCHQpbOyW7HPjuBqoLJf9NX7WnDqs8tl1B7T3E4HV2vLREM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qza7rxg2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754934722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gXT4qvfbPfbCMUM3Y5jBW6QA3yFneKsWJs0UM5FJ3j4=;
	b=Qza7rxg29VeDnUB8S53Wt3URNa5glzNhayH4107ihQ0o6t/LaxJruTVHaCVXknkyj84MS0
	D7e5iOihJWZ1Dy57lCAjCx7Oqba+jEYJlw1FIVztimzV89bk4jE7qejWSzk1deRf/lWZ8w
	7abEclTuHT1pzn+i7FGDgHKpBX9Xu64=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-STJeJykgMhWRwGLG13gCGw-1; Mon, 11 Aug 2025 13:52:01 -0400
X-MC-Unique: STJeJykgMhWRwGLG13gCGw-1
X-Mimecast-MFC-AGG-ID: STJeJykgMhWRwGLG13gCGw_1754934719
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b7931d3d76so3115190f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 10:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754934719; x=1755539519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXT4qvfbPfbCMUM3Y5jBW6QA3yFneKsWJs0UM5FJ3j4=;
        b=ax0q8qM5dEBb0FJ9aIA/rVFEv1TRcLPVkW32X+rfioDR0HKnUfepTQlZFAi/Cmmjfv
         hYT6zH6gx3vRDRgTIkozgxpyFtlKrW0Wia0RgZsi3lNxJqu847NwA9IU/gkjuWImOpLh
         azE9BUUonIhzMpeyaKDf8zMF3IoOJCkLKUoRYLDo6Z1pXQeT0hGdy/CrXP+7qwJTjQ5w
         37OJcu1g07sQiXWpgVico4UZU14j/B1rOLLmG4H6pR57V4r9R9lvaq3Mjiz9bFP1uck0
         85Qjv6k0+H6jIYgnm7NyzmPNHz7LFRWrWWDoz+Xlj0fejCKFuzMAH+SHmTZGxkMDNG0c
         maYA==
X-Forwarded-Encrypted: i=1; AJvYcCWBtWZPeDt7aVJvjAhhGYOKSm12c5SOoIU5O4YABjvX11t+x6J0I2d/1F5wTIqgYnc3xJSUHkqDVzX+BzTh@vger.kernel.org
X-Gm-Message-State: AOJu0YyETzQDncsnJUgNGcSboF+BWQ6YivrpSgiHMsEpAnGKERgCqitL
	hgOL58c/Hi2YnoDHQu3/FBYoy53Lb8pp61QGb7Rc5xXmSkvbSemv/zTkhAm5v0hDmvujNPQB5S3
	9uayAAEIZqM+E4eof74a58oGqllrr7iZL4SIDcO9JfD8RkiW3pcQmoMAjpxjPx4+Jrg==
X-Gm-Gg: ASbGncscDOz50VNwNeKFWyS5ns7N1EvDXHkfrARqwCYRTghl5wywxf5Eami4SyGa1rR
	nwIVjzqv4FGyKuN6vfPiKnPvVD0zt8SkrCEoN4ZpDRxkaRAEotLkbb/xuLrYsoNc7j74gWiBpgg
	Yj6uQSLXFi+6zdjswiS7idP6lM/wxojp6871Mp95gdMYW+0tZdYyeuy76+MWzCFU8k2NJw68N3z
	uV0uW52SXRFegrlBiXE/u4XIqqt4Q3CPskDLVnnj/0A7FAXs2k7/3ZGUHMwAZ405FaFmU74sSK3
	/Dk2uuaxx591ysqO8yQbW+ogGtcSHAGtTcx63QtTH73sXwt7TM1OD6lWmu8=
X-Received: by 2002:a05:6000:290c:b0:3b7:94a2:87e8 with SMTP id ffacd0b85a97d-3b900b4db70mr9585405f8f.18.1754934718581;
        Mon, 11 Aug 2025 10:51:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj17bPm4Yt4yABD7ZRqL6YobksjOiBPmA+a8Y9DlRybFQy4FXjOcwwYwQSd70b/Otxj5PXXA==
X-Received: by 2002:a05:6000:290c:b0:3b7:94a2:87e8 with SMTP id ffacd0b85a97d-3b900b4db70mr9585385f8f.18.1754934718029;
        Mon, 11 Aug 2025 10:51:58 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e583ff76sm261620775e9.5.2025.08.11.10.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 10:51:57 -0700 (PDT)
Date: Mon, 11 Aug 2025 19:51:57 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/4] xfs_quota: utilize file_setattr to set prjid on
 special files
Message-ID: <l3nhzpwey4zw3h3gz7mgotf7b3n2aa3jueo3rkmsvoyyafuwfr@en4klcgxwwqq>
References: <20250808-xattrat-syscall-v1-0-48567c29e45c@kernel.org>
 <20250808-xattrat-syscall-v1-2-48567c29e45c@kernel.org>
 <20250811150747.GB7965@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811150747.GB7965@frogsfrogsfrogs>

On 2025-08-11 08:07:47, Darrick J. Wong wrote:
> On Fri, Aug 08, 2025 at 09:30:17PM +0200, Andrey Albershteyn wrote:
> > From: Andrey Albershteyn <aalbersh@redhat.com>
> > 
> > Utilize new file_getattr/file_setattr syscalls to set project ID on
> > special files. Previously, special files were skipped due to lack of the
> > way to call FS_IOC_SETFSXATTR ioctl on them. The quota accounting was
> > therefore missing these inodes (special files created before project
> > setup). The ones created after porject initialization did inherit the
> > projid flag from the parent.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > ---
> >  quota/project.c | 144 +++++++++++++++++++++++++++++---------------------------
> >  1 file changed, 74 insertions(+), 70 deletions(-)
> > 
> > diff --git a/quota/project.c b/quota/project.c
> > index adb26945fa57..93d7ace0e11b 100644
> > --- a/quota/project.c
> > +++ b/quota/project.c
> > @@ -4,14 +4,17 @@
> >   * All Rights Reserved.
> >   */
> >  
> > +#include <unistd.h>
> >  #include "command.h"
> >  #include "input.h"
> >  #include "init.h"
> > +#include "libfrog/file_attr.h"
> >  #include "quota.h"
> >  
> >  static cmdinfo_t project_cmd;
> >  static prid_t prid;
> >  static int recurse_depth = -1;
> > +static int dfd;
> 
> Ew, global scope variables, can we pass that through to check_project?

it's used in all ops (setup, check and clear), this is opened in
project_operations() which then calls nftw which doesn't seem to
have any context for callbacks. So, I think in anyway we will need
some global state.

> 
> >  enum {
> >  	CHECK_PROJECT	= 0x1,
> > @@ -19,13 +22,6 @@ enum {
> >  	CLEAR_PROJECT	= 0x4,
> >  };
> >  
> > -#define EXCLUDED_FILE_TYPES(x) \
> > -	   (S_ISCHR((x)) \
> > -	|| S_ISBLK((x)) \
> > -	|| S_ISFIFO((x)) \
> > -	|| S_ISLNK((x)) \
> > -	|| S_ISSOCK((x)))
> > -
> >  static void
> >  project_help(void)
> >  {
> > @@ -85,8 +81,8 @@ check_project(
> >  	int			flag,
> >  	struct FTW		*data)
> >  {
> > -	struct fsxattr		fsx;
> > -	int			fd;
> > +	int			error;
> > +	struct file_attr	fa = { 0 };
> >  
> >  	if (recurse_depth >= 0 && data->level > recurse_depth)
> >  		return 0;
> > @@ -96,30 +92,30 @@ check_project(
> >  		fprintf(stderr, _("%s: cannot stat file %s\n"), progname, path);
> >  		return 0;
> >  	}
> > -	if (EXCLUDED_FILE_TYPES(stat->st_mode)) {
> > -		fprintf(stderr, _("%s: skipping special file %s\n"), progname, path);
> > -		return 0;
> > -	}
> >  
> > -	if ((fd = open(path, O_RDONLY|O_NOCTTY)) == -1) {
> > -		exitcode = 1;
> > -		fprintf(stderr, _("%s: cannot open %s: %s\n"),
> > -			progname, path, strerror(errno));
> > -	} else if ((xfsctl(path, fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
> > -		exitcode = 1;
> > +	error = file_getattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
> > +	if (error) {
> > +#ifndef HAVE_FILE_ATTR
> > +		if (SPECIAL_FILE(stat->st_mode)) {
> > +			fprintf(stderr, _("%s: skipping special file %s\n"),
> > +					progname, path);
> > +			return 0;
> > +		}
> > +#endif
> 
> Yeah, file_getattr really ought to return some error code for "not
> supported" and then this becomes:
> 
> 	error = file_getattr(...);
> 	if (error && errno == EOPNOTSUPP) {
> 		fprintf(stderr, _("%s: skipping special file %s\n"),
> 					progname, path);
> 		return 0;
> 	}
> 	if (error) {
> 		fprintf(stderr, _("%s: cannot get flags on %s: %s\n"),
> 			progname, path, strerror(errno));
> 		exitcode = 1;
> 		return 0;
> 	}

Sure, that's better, will redo file_getattr()

> 
> >  		fprintf(stderr, _("%s: cannot get flags on %s: %s\n"),
> > -			progname, path, strerror(errno));
> > -	} else {
> > -		if (fsx.fsx_projid != prid)
> > -			printf(_("%s - project identifier is not set"
> > -				 " (inode=%u, tree=%u)\n"),
> > -				path, fsx.fsx_projid, (unsigned int)prid);
> > -		if (!(fsx.fsx_xflags & FS_XFLAG_PROJINHERIT) && S_ISDIR(stat->st_mode))
> > -			printf(_("%s - project inheritance flag is not set\n"),
> > -				path);
> > +				progname, path, strerror(errno));
> > +		exitcode = 1;
> > +		return 0;
> >  	}
> > -	if (fd != -1)
> > -		close(fd);
> > +
> > +	if (fa.fa_projid != prid)
> > +		printf(_("%s - project identifier is not set"
> > +				" (inode=%u, tree=%u)\n"),
> > +			path, fa.fa_projid, (unsigned int)prid);
> > +	if (!(fa.fa_xflags & FS_XFLAG_PROJINHERIT) && S_ISDIR(stat->st_mode))
> > +		printf(_("%s - project inheritance flag is not set\n"),
> > +			path);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -130,8 +126,8 @@ clear_project(
> >  	int			flag,
> >  	struct FTW		*data)
> >  {
> > -	struct fsxattr		fsx;
> > -	int			fd;
> > +	int			error;
> > +	struct file_attr	fa;
> >  
> >  	if (recurse_depth >= 0 && data->level > recurse_depth)
> >  		return 0;
> > @@ -141,32 +137,31 @@ clear_project(
> >  		fprintf(stderr, _("%s: cannot stat file %s\n"), progname, path);
> >  		return 0;
> >  	}
> > -	if (EXCLUDED_FILE_TYPES(stat->st_mode)) {
> > -		fprintf(stderr, _("%s: skipping special file %s\n"), progname, path);
> > -		return 0;
> > -	}
> >  
> > -	if ((fd = open(path, O_RDONLY|O_NOCTTY)) == -1) {
> > -		exitcode = 1;
> > -		fprintf(stderr, _("%s: cannot open %s: %s\n"),
> > -			progname, path, strerror(errno));
> > -		return 0;
> > -	} else if (xfsctl(path, fd, FS_IOC_FSGETXATTR, &fsx) < 0) {
> > -		exitcode = 1;
> > +	error = file_getattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
> > +	if (error) {
> > +#ifndef HAVE_FILE_ATTR
> > +		if (SPECIAL_FILE(stat->st_mode)) {
> > +			fprintf(stderr, _("%s: skipping special file %s\n"),
> > +					progname, path);
> > +			return 0;
> > +		}
> > +#endif
> >  		fprintf(stderr, _("%s: cannot get flags on %s: %s\n"),
> > -			progname, path, strerror(errno));
> > -		close(fd);
> > +				progname, path, strerror(errno));
> > +		exitcode = 1;
> >  		return 0;
> >  	}
> >  
> > -	fsx.fsx_projid = 0;
> > -	fsx.fsx_xflags &= ~FS_XFLAG_PROJINHERIT;
> > -	if (xfsctl(path, fd, FS_IOC_FSSETXATTR, &fsx) < 0) {
> > -		exitcode = 1;
> > +	fa.fa_projid = 0;
> > +	fa.fa_xflags &= ~FS_XFLAG_PROJINHERIT;
> > +
> > +	error = file_setattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
> > +	if (error) {
> >  		fprintf(stderr, _("%s: cannot clear project on %s: %s\n"),
> >  			progname, path, strerror(errno));
> > +		exitcode = 1;
> >  	}
> > -	close(fd);
> >  	return 0;
> >  }
> >  
> > @@ -177,8 +172,8 @@ setup_project(
> >  	int			flag,
> >  	struct FTW		*data)
> >  {
> > -	struct fsxattr		fsx;
> > -	int			fd;
> > +	struct file_attr	fa;
> > +	int			error;
> >  
> >  	if (recurse_depth >= 0 && data->level > recurse_depth)
> >  		return 0;
> > @@ -188,32 +183,32 @@ setup_project(
> >  		fprintf(stderr, _("%s: cannot stat file %s\n"), progname, path);
> >  		return 0;
> >  	}
> > -	if (EXCLUDED_FILE_TYPES(stat->st_mode)) {
> > -		fprintf(stderr, _("%s: skipping special file %s\n"), progname, path);
> > -		return 0;
> > -	}
> >  
> > -	if ((fd = open(path, O_RDONLY|O_NOCTTY)) == -1) {
> > -		exitcode = 1;
> > -		fprintf(stderr, _("%s: cannot open %s: %s\n"),
> > -			progname, path, strerror(errno));
> > -		return 0;
> > -	} else if (xfsctl(path, fd, FS_IOC_FSGETXATTR, &fsx) < 0) {
> > -		exitcode = 1;
> > +	error = file_getattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
> > +	if (error) {
> > +#ifndef HAVE_FILE_ATTR
> > +		if (SPECIAL_FILE(stat->st_mode)) {
> > +			fprintf(stderr, _("%s: skipping special file %s\n"),
> > +					progname, path);
> > +			return 0;
> > +		}
> > +#endif
> >  		fprintf(stderr, _("%s: cannot get flags on %s: %s\n"),
> > -			progname, path, strerror(errno));
> > -		close(fd);
> > +				progname, path, strerror(errno));
> > +		exitcode = 1;
> >  		return 0;
> >  	}
> >  
> > -	fsx.fsx_projid = prid;
> > -	fsx.fsx_xflags |= FS_XFLAG_PROJINHERIT;
> > -	if (xfsctl(path, fd, FS_IOC_FSSETXATTR, &fsx) < 0) {
> > -		exitcode = 1;
> > +	fa.fa_projid = prid;
> > +	if (S_ISDIR(stat->st_mode))
> > +		fa.fa_xflags |= FS_XFLAG_PROJINHERIT;
> > +
> > +	error = file_setattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
> > +	if (error) {
> >  		fprintf(stderr, _("%s: cannot set project on %s: %s\n"),
> >  			progname, path, strerror(errno));
> > +		exitcode = 1;
> >  	}
> > -	close(fd);
> >  	return 0;
> >  }
> >  
> > @@ -223,6 +218,13 @@ project_operations(
> >  	char		*dir,
> >  	int		type)
> >  {
> > +	dfd = open(dir, O_RDONLY|O_NOCTTY);
> > +	if (dfd < -1) {
> > +		printf(_("Error opening dir %s for project %s...\n"), dir,
> > +				project);
> > +		return;
> > +	}
> > +
> >  	switch (type) {
> >  	case CHECK_PROJECT:
> >  		printf(_("Checking project %s (path %s)...\n"), project, dir);
> > @@ -237,6 +239,8 @@ project_operations(
> >  		nftw(dir, clear_project, 100, FTW_PHYS|FTW_MOUNT);
> >  		break;
> >  	}
> > +
> > +	close(dfd);
> >  }
> >  
> >  static void
> > 
> > -- 
> > 2.49.0
> > 
> > 
> 

-- 
- Andrey


