Return-Path: <linux-fsdevel+bounces-39055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09404A0BC0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 16:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60F318831C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 15:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584861C5D72;
	Mon, 13 Jan 2025 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVtRCE42"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE6629D19
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782320; cv=none; b=Xv72MfU3vlDsyZNPYN0XJy8Z5CbYE7ZtPUzLfZEJ6dM/ndS8MGF45AX8+kaQrEE8k+Bgwu1g9zVCOQwlyYn6kHTZzVwXxZgn9OiSX1ePWEvhVhPtwOxqDaa6xu5n/85HJ1An48fN/qSxJ1iGDGMEynKrut/qjkQm9C1c2duv2cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782320; c=relaxed/simple;
	bh=mvpUKblQy8XIPdlWHCLH8X7FWaiWEVy9c2RgcGTYsnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsDXHS4wZQw3w6GL07jc9chmhs8Wh184PxcXNP26yVKVUr6aelG9Ph31KA5GV+Fc2jo4ozDJPsK8MzT/XeLpH/JeUFjU0HAiBCc0LY0YTJ+SgWO9EFsnumCGzhWCd5ANFD/wygxfHBXY3zHaM2sbgwnUhhDLY12D1Mc8+MF3U9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LVtRCE42; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736782316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SZj62Px2ZKn8iOzamvEwo+3QljL+SdLMxOZ/y0XMPLY=;
	b=LVtRCE42cYTXtul0GJf5msuYGuay5DSwXJp5Rz8KQn5Umj2AKdWt5OnDcmB2WlrSnLIf1p
	u6sQgmgZclG42XmMzyOcaCME+5V0Cpksi74rJtXfyv4HrjEBYKxlT4bIBrXen+kAUYiH/k
	SI6MSYfmXBXirqd2oaqw3wCoAPWkW14=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-QGOLQwNNPqCIZ7homoQHeg-1; Mon, 13 Jan 2025 10:31:55 -0500
X-MC-Unique: QGOLQwNNPqCIZ7homoQHeg-1
X-Mimecast-MFC-AGG-ID: QGOLQwNNPqCIZ7homoQHeg
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa691c09772so400786866b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 07:31:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736782314; x=1737387114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZj62Px2ZKn8iOzamvEwo+3QljL+SdLMxOZ/y0XMPLY=;
        b=vLe2iYpu3ia36SjdXZ8+k6UeGbpGNPwCRnA2rlvuZCUbNrR1ZVQL8mB0W7s4T1ZPGK
         A9Wd66ciV4wY/l6wRn3Y67aQd9Wsj5BUZ2zwDrb3AcQ9UMK1sJ3F8AyXWacpYd8z1/WY
         UR3NurDI0DVJ0Q9E9aVomsX2iARNBM/7c65adLAEn+s0dEegCMckgOlTczpQ05z8zAUZ
         0KoUkfS+yAGQf5DsuDE9nrs0oN5b8jJL9+C2OxZVWxPnsyZ77D4YTAbKMliQCA/WEtf2
         dICxwigQJO7+8z96uERR3g68Y+4Bm88Uuz+TQprRgukRQkr1R/I2ODqzpmCYsYUs8Wgv
         2Xnw==
X-Gm-Message-State: AOJu0Yx7Jd6LFrIMCVYsgnpnubg40pzRPfbWTfr1ynk1oB0dng2O11dB
	LjINJ5yJxrYsfIzwWfhctcgndOJu/fqFfNAgXa/6ttqjVBWwXEiQ+aeO9ni81ZccSAxV49dQ/8Q
	tLlOTyVaSsDaExNIP5ZxYAn4CldixEws5F7c0JG93dtFN3iLSNPDMTlkjM808Gg==
X-Gm-Gg: ASbGncszSTQNSre6ZUpV0yfZZpef4MH3EmQQOMdgVij9S1eVvcu7P31lk8PELknu80a
	ddepCnCnadXTjKgRsWaB5ibN1JCiEyAfA0+nUtdaASD9LvvyAP9YZzycqxQrLGLNXpWtu0LhTW4
	JvZnRvfY31lON3zyti2vbMC/at22+xsY1Q3H1Rk1YCUC9CySXtKKHutfp5CvUAJuqz8ZnMy2GhA
	0mzOYOuBTK9iWzgrnW0wFUU+TCiEgiYtbm6NNL3UGWXR9NUfqaoIgWx7xOW9SQ/Gn3V8Tt8hQAO
X-Received: by 2002:a17:907:6d0e:b0:aaf:5c9:19f9 with SMTP id a640c23a62f3a-ab2ab6f3455mr1962694866b.27.1736782313736;
        Mon, 13 Jan 2025 07:31:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN9M8ywOrQBK6gF/5ntK43MmcNBbwRSFgySYURvnN/eomPTMHRMQ8vdhj//eDu8N4Cy9JGfg==
X-Received: by 2002:a17:907:6d0e:b0:aaf:5c9:19f9 with SMTP id a640c23a62f3a-ab2ab6f3455mr1962689566b.27.1736782313218;
        Mon, 13 Jan 2025 07:31:53 -0800 (PST)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9060b9dsm516473166b.4.2025.01.13.07.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 07:31:52 -0800 (PST)
Date: Mon, 13 Jan 2025 16:31:50 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	monstr@monstr.eu, mpe@ellerman.id.au, npiggin@gmail.com, 
	christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com, luto@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, arnd@arndb.de, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-arch@vger.kernel.org
Subject: Re: [PATCH] fs: introduce getfsxattrat and setfsxattrat syscalls
Message-ID: <cwz2kun2mm55um3hycrd4mkxrgm43zorty5kdxacksmseo34n3@dc3bd4x6cibd>
References: <20250109174540.893098-1-aalbersh@kernel.org>
 <doha6zamxgmqapwx4r6ehzbatzar4dcep33zehunonqforjzf5@lxpidn37tdjh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <doha6zamxgmqapwx4r6ehzbatzar4dcep33zehunonqforjzf5@lxpidn37tdjh>

On 2025-01-13 12:19:36, Jan Kara wrote:
> On Thu 09-01-25 18:45:40, Andrey Albershteyn wrote:
> > From: Andrey Albershteyn <aalbersh@redhat.com>
> > 
> > Introduce getfsxattrat and setfsxattrat syscalls to manipulate inode
> > extended attributes/flags. The syscalls take parent directory FD and
> > path to the child together with struct fsxattr.
> > 
> > This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
> > that file don't need to be open. By having this we can manipulated
> > inode extended attributes not only on normal files but also on
> > special ones. This is not possible with FS_IOC_FSSETXATTR ioctl as
> > opening special files returns VFS special inode instead of
> > underlying filesystem one.
> > 
> > This patch adds two new syscalls which allows userspace to set
> > extended inode attributes on special files by using parent directory
> > to open FS inode.
> > 
> > Also, as vfs_fileattr_set() is now will be called on special files
> > too, let's forbid any other attributes except projid and nextents
> > (symlink can have an extent).
> > 
> > CC: linux-api@vger.kernel.org
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> 
> Couple of comments below:
> 
> > @@ -2953,3 +2956,105 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
> >  	return mode & ~S_ISGID;
> >  }
> >  EXPORT_SYMBOL(mode_strip_sgid);
> > +
> > +SYSCALL_DEFINE4(getfsxattrat, int, dfd, const char __user *, filename,
> > +		struct fsxattr *, fsx, int, at_flags)
> 				       ^^^ at_flags should be probably
> unsigned - at least they seem to be for other syscalls.

sure

> 
> > +{
> > +	struct fd dir;
> > +	struct fileattr fa;
> > +	struct path filepath;
> > +	struct inode *inode;
> > +	int error;
> > +
> > +	if (at_flags)
> > +		return -EINVAL;
> 
> Shouldn't we support basic path resolve flags like AT_SYMLINK_NOFOLLOW or
> AT_EMPTY_PATH? I didn't put too much thought to this but intuitively I'd say
> we should follow what path_setxattrat() does.

Hmm, yeah, you are right these two can be passed. I thought about
setting AT_SYMLINK_NOFOLLOW by default (which is also missing here),
but adding allowing passing these seems to be fine.

> 
> > +
> > +	if (!capable(CAP_FOWNER))
> > +		return -EPERM;
> 
> Why? Firstly this does not handle user namespaces at all, secondly it
> doesn't match the check done during ioctl, and thirdly vfs_fileattr_get()
> should do all the needed checks?

Sorry, miss-understood how this works, I will remove this from both
get/set. get*() doesn't need it and set*() checks capabilities in
vfs_fileattr_set(). Thanks!

> 
> > +
> > +	dir = fdget(dfd);
> > +	if (!fd_file(dir))
> > +		return -EBADF;
> > +
> > +	if (!S_ISDIR(file_inode(fd_file(dir))->i_mode)) {
> > +		error = -EBADF;
> > +		goto out;
> > +	}
> > +
> > +	error = user_path_at(dfd, filename, at_flags, &filepath);
> > +	if (error)
> > +		goto out;
> 
> I guess this is OK for now but allowing full flexibility of the "_at"
> syscall (e.g. like setxattrat() does) would be preferred. Mostly so that
> userspace programmer doesn't have to read manpage in detail and think
> whether the particular combination of path arguments is supported by a
> particular syscall. Admittedly VFS could make this a bit simpler. Currently
> the boilerplate code that's needed in path_setxattrat() &
> filename_setxattr() / file_setxattr() is offputting.
> 
> > +
> > +	inode = filepath.dentry->d_inode;
> > +	if (file_inode(fd_file(dir))->i_sb->s_magic != inode->i_sb->s_magic) {
> > +		error = -EBADF;
> > +		goto out_path;
> > +	}
> 
> What's the motivation for this check?

This was one of the comments on the ioctl() patch, that it doesn't
make much sense to allow ioctl() to be called over different
filesystems. But for syscall this is probably make less sense to
restrict it like that. I will drop it.

> 
> > +
> > +	error = vfs_fileattr_get(filepath.dentry, &fa);
> > +	if (error)
> > +		goto out_path;
> > +
> > +	if (copy_fsxattr_to_user(&fa, fsx))
> > +		error = -EFAULT;
> > +
> > +out_path:
> > +	path_put(&filepath);
> > +out:
> > +	fdput(dir);
> > +	return error;
> > +}
> > +
> > +SYSCALL_DEFINE4(setfsxattrat, int, dfd, const char __user *, filename,
> > +		struct fsxattr *, fsx, int, at_flags)
> > +{
> 
> Same comments as for getfsxattrat() apply here as well.
> 
> > -static int copy_fsxattr_from_user(struct fileattr *fa,
> > -				  struct fsxattr __user *ufa)
> > +int copy_fsxattr_from_user(struct fileattr *fa, struct fsxattr __user *ufa)
> >  {
> >  	struct fsxattr xfa;
> >  
> > @@ -574,6 +573,7 @@ static int copy_fsxattr_from_user(struct fileattr *fa,
> >  
> >  	return 0;
> >  }
> > +EXPORT_SYMBOL(copy_fsxattr_from_user);
> 
> I guess no need to export this function? The code you call it from cannot
> be compiled as a module.

Yes, that's true, I added this because copy_fsxattr_to_user() also
is exported (same as many other functions). I will drop this.

-- 
- Andrey


