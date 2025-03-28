Return-Path: <linux-fsdevel+bounces-45231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84208A74E86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 17:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B3C189760F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 16:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04021D934D;
	Fri, 28 Mar 2025 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jKlnddoY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB80A935
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Mar 2025 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743179178; cv=none; b=s6wlsFyoI5XiLEDqeVFPVyky2K3w40MDx6D0tENmbpYWyArn2KAjOpgDQ+bKyeOc+BZbhY3l8HOr0aC4Byyhd1OpbPu5zy8P20hk4ERZxmbiKF39bk2x3oFQV8R3J+riua657zaoerWZlQ5pgZqwJR04UIb9wTBRkcJwNI3/NoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743179178; c=relaxed/simple;
	bh=+pAYmFG35tho5dbQ3eLOJhU94fwqXMapm7RQeM3QjC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3uA/2sRfMK04mfRmfy83v1c4TTK8U5muu6BoxlEj1RJQg9lU6O8ylRjx0fOx9Ut3iCj9p8rnNyspniiqGSypBBsIlyds6RBKXFr/2iI7Uwd5U+2cxwcyIOGThN5jkyp66eAoGRwZqJkOtJZW4Uakfb9bi0/Exgwc2WUUQ+KeK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jKlnddoY; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 28 Mar 2025 12:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743179170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7/qa0edAWMlranoyL+nTInr92sFi6AEqh1M+j4KdVPI=;
	b=jKlnddoYpmjg9phx+tRf0Scr2nVY6PxB/rX7rK0bqICrPXOdGTZxgRHFb+70t4/lwALSWt
	iTcR0iVt8ngqj2e+yvamJcJNd4jwcYCApBjAd9TqlS0VrmE+CvGKKJEdk+XuFLeN0T5MJF
	GSr3p1jBf2Pwsu2cgYvjqjt/ibTi34o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: Petr Vorel <pvorel@suse.cz>, 
	Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Li Wang <liwang@redhat.com>, Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [LTP] [PATCH] ioctl_ficlone03: fix capabilities on immutable
 files
Message-ID: <7ltgrgqgfummyrlvw7hnfhnu42rfiamoq3lpcvrjnlyytldmzp@yazbhusnztqn>
References: <20250326-fix_ioctl_ficlone03_32bit_bcachefs-v1-1-554a0315ebf5@suse.com>
 <20250326134749.GA45449@pevik>
 <Z-Sgj_XOVar8myLw@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-Sgj_XOVar8myLw@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 27, 2025 at 11:49:19AM +1100, Dave Chinner wrote:
> On Wed, Mar 26, 2025 at 02:47:49PM +0100, Petr Vorel wrote:
> > Hi all,
> > 
> > [ Cc Kent and other filesystem folks to be sure we don't hide a bug ]
> > 
> > > From: Andrea Cervesato <andrea.cervesato@suse.com>
> > 
> > > Make sure that capabilities requirements are satisfied when accessing
> > > immutable files. On OpenSUSE Tumbleweed 32bit bcachefs fails with the
> > > following error due to missing capabilities:
> > 
> > > tst_test.c:1833: TINFO: === Testing on bcachefs ===
> > > ..
> > > ioctl_ficlone03.c:74: TBROK: ioctl .. failed: ENOTTY (25)
> > > ioctl_ficlone03.c:89: TWARN: ioctl ..  failed: ENOTTY (25)
> > > ioctl_ficlone03.c:91: TWARN: ioctl ..  failed: ENOTTY (25)
> > > ioctl_ficlone03.c:98: TWARN: close(-1) failed: EBADF (9)
> 
> None of these are -EPERM, so how is a missing capability that
> results in -EPERM being returned cause -ENOTTY or -EBADF failures?
> 
> ohhhhh. ENOTTY is a result of a kernel side compat ioctl handling bug
> w/ bcachefs.
> 
> bcachefs doesn't implement ->fileattr_set().
> 
> sys_compat_ioctl() does:
> 
>         case FS_IOC32_GETFLAGS:
>         case FS_IOC32_SETFLAGS:
>                 cmd = (cmd == FS_IOC32_GETFLAGS) ?
>                         FS_IOC_GETFLAGS : FS_IOC_SETFLAGS;
> 
> and then calls do_vfs_ioctl().
> 
> This then ends up in vfs_fileattr_set(), which does:
> 
> 	if (!inode->i_op->fileattr_set)
>                 return -ENOIOCTLCMD;
> 
> which means sys_compat_ioctl() then falls back to calling
> ->compat_ioctl().
> 
> However, cmd has been overwritten to FS_IOC_SETFLAGS and
> bch2_compat_fs_ioctl() looks for FS_IOC32_SETFLAGS, so it returns
> -ENOIOCTLCMD as it doesn't handle the ioctl command passed in.
> 
> sys_compat_ioctl() then converts the -ENOIOCTLCMD to -ENOTTY, and
> there's the error being reported.
> 
> OK, this is a bcachefs compat ioctl handling bug, triggered by not
> implementing ->fileattr_set and implementing FS_IOC_SETFLAGS
> directly itself via ->unlocked_ioctl.
> 
> Yeah, fixes to bcachefs needed here, not LTP.
> 
> > I wonder why it does not fail for generic VFS fs/ioctl.c used by Btrfs and XFS:
> 
> Because they implement ->fileattr_set() and so all the compat ioctl
> FS_IOC32_SETFLAGS handling works as expected.

thanks for the analysis, I'll try to get this fixed soon

