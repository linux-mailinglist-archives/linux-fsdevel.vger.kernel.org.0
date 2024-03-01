Return-Path: <linux-fsdevel+bounces-13281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE1886E285
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 14:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C655C1C22E87
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 13:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6E671B34;
	Fri,  1 Mar 2024 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="fFDki6eV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AFE70CAA
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 13:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300537; cv=none; b=kVAhQEeq0IRm8ex6pB3FfCBfEdjD82uCHpzaLCBF9IZ1HOwumbMjo/HJDRTcKnvoxf2y5nbEL5v0bV/gcqNCFiD0KW7DypUCW+Y95dOzUP/Kxa5l1Lq/zOT26P907MS6DNSy0jyeKhL4k4LLTL2qHHTtqUhqXTGQ8YGTeDsAr6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300537; c=relaxed/simple;
	bh=hiOCYAxLrK/yle5FUJTsTjsTZMa8xWuHi7Oi5k9zdoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiILWcZqDu5uwomlbMuh1WvfvJt9yhgqX0DLpG8qCdhl8tN2sA1foWpi57ip94MvRoWgG9xApi8EBUQ5HZ662pUEQ/FCwC9+LxMQ5ZhSUGp/spBR6gOQKGmarp1li/b/HdRbX90LdjG4RhX3Alti6i3c9MuzaPklnQzynZDAER4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=fFDki6eV; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TmTm25tK3zKbS;
	Fri,  1 Mar 2024 14:42:10 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TmTm21DMLzMpnPh;
	Fri,  1 Mar 2024 14:42:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709300530;
	bh=hiOCYAxLrK/yle5FUJTsTjsTZMa8xWuHi7Oi5k9zdoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fFDki6eV2aX0WzFDanEnHtaYH8Ifw3/KjOIZzm6L6FW/pVREWXrU96chcrn35eFAH
	 +fCCCoXvcTpceUJTFIoTpKPUdGCtoyiKC3njsphjbh9/OYpWaZNCpVNg63C5NTSO5D
	 TiPV16yYZ2qm5mk4UYePJvjHLNb3ooqlVyEUEEgw=
Date: Fri, 1 Mar 2024 14:42:00 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
Message-ID: <20240301.deax4thooPhu@digikod.net>
References: <20240219.chu4Yeegh3oo@digikod.net>
 <20240219183539.2926165-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219183539.2926165-1-mic@digikod.net>
X-Infomaniak-Routing: alpha

Arnd, Christian, are you OK with this approach to identify VFS IOCTLs?

If yes, Günther should include it in his next patch series.

On Mon, Feb 19, 2024 at 07:35:39PM +0100, Mickaël Salaün wrote:
> vfs_masks_device_ioctl() and vfs_masks_device_ioctl_compat() are useful
> to differenciate between device driver IOCTL implementations and
> filesystem ones.  The goal is to be able to filter well-defined IOCTLs
> from per-device (i.e. namespaced) IOCTLs and control such access.
> 
> Add a new ioctl_compat() helper, similar to vfs_ioctl(), to wrap
> compat_ioctl() calls and handle error conversions.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Günther Noack <gnoack@google.com>
> ---
>  fs/ioctl.c         | 101 +++++++++++++++++++++++++++++++++++++++++----
>  include/linux/fs.h |  12 ++++++
>  2 files changed, 105 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 76cf22ac97d7..f72c8da47d21 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -763,6 +763,38 @@ static int ioctl_fssetxattr(struct file *file, void __user *argp)
>  	return err;
>  }
>  
> +/*
> + * Safeguard to maintain a list of valid IOCTLs handled by do_vfs_ioctl()
> + * instead of def_blk_fops or def_chr_fops (see init_special_inode).
> + */
> +__attribute_const__ bool vfs_masked_device_ioctl(const unsigned int cmd)
> +{
> +	switch (cmd) {
> +	case FIOCLEX:
> +	case FIONCLEX:
> +	case FIONBIO:
> +	case FIOASYNC:
> +	case FIOQSIZE:
> +	case FIFREEZE:
> +	case FITHAW:
> +	case FS_IOC_FIEMAP:
> +	case FIGETBSZ:
> +	case FICLONE:
> +	case FICLONERANGE:
> +	case FIDEDUPERANGE:
> +	/* FIONREAD is forwarded to device implementations. */
> +	case FS_IOC_GETFLAGS:
> +	case FS_IOC_SETFLAGS:
> +	case FS_IOC_FSGETXATTR:
> +	case FS_IOC_FSSETXATTR:
> +	/* file_ioctl()'s IOCTLs are forwarded to device implementations. */
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +EXPORT_SYMBOL(vfs_masked_device_ioctl);
> +
>  /*
>   * do_vfs_ioctl() is not for drivers and not intended to be EXPORT_SYMBOL()'d.
>   * It's just a simple helper for sys_ioctl and compat_sys_ioctl.
> @@ -858,6 +890,8 @@ SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
>  {
>  	struct fd f = fdget(fd);
>  	int error;
> +	const struct inode *inode;
> +	bool is_device;
>  
>  	if (!f.file)
>  		return -EBADF;
> @@ -866,9 +900,18 @@ SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
>  	if (error)
>  		goto out;
>  
> +	inode = file_inode(f.file);
> +	is_device = S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode);
> +	if (is_device && !vfs_masked_device_ioctl(cmd)) {
> +		error = vfs_ioctl(f.file, cmd, arg);
> +		goto out;
> +	}
> +
>  	error = do_vfs_ioctl(f.file, fd, cmd, arg);
> -	if (error == -ENOIOCTLCMD)
> +	if (error == -ENOIOCTLCMD) {
> +		WARN_ON_ONCE(is_device);
>  		error = vfs_ioctl(f.file, cmd, arg);
> +	}
>  
>  out:
>  	fdput(f);
> @@ -911,11 +954,49 @@ long compat_ptr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  }
>  EXPORT_SYMBOL(compat_ptr_ioctl);
>  
> +static long ioctl_compat(struct file *filp, unsigned int cmd,
> +			 compat_ulong_t arg)
> +{
> +	int error = -ENOTTY;
> +
> +	if (!filp->f_op->compat_ioctl)
> +		goto out;
> +
> +	error = filp->f_op->compat_ioctl(filp, cmd, arg);
> +	if (error == -ENOIOCTLCMD)
> +		error = -ENOTTY;
> +
> +out:
> +	return error;
> +}
> +
> +__attribute_const__ bool vfs_masked_device_ioctl_compat(const unsigned int cmd)
> +{
> +	switch (cmd) {
> +	case FICLONE:
> +#if defined(CONFIG_X86_64)
> +	case FS_IOC_RESVSP_32:
> +	case FS_IOC_RESVSP64_32:
> +	case FS_IOC_UNRESVSP_32:
> +	case FS_IOC_UNRESVSP64_32:
> +	case FS_IOC_ZERO_RANGE_32:
> +#endif
> +	case FS_IOC32_GETFLAGS:
> +	case FS_IOC32_SETFLAGS:
> +		return true;
> +	default:
> +		return vfs_masked_device_ioctl(cmd);
> +	}
> +}
> +EXPORT_SYMBOL(vfs_masked_device_ioctl_compat);
> +
>  COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
>  		       compat_ulong_t, arg)
>  {
>  	struct fd f = fdget(fd);
>  	int error;
> +	const struct inode *inode;
> +	bool is_device;
>  
>  	if (!f.file)
>  		return -EBADF;
> @@ -924,6 +1005,13 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
>  	if (error)
>  		goto out;
>  
> +	inode = file_inode(f.file);
> +	is_device = S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode);
> +	if (is_device && !vfs_masked_device_ioctl_compat(cmd)) {
> +		error = ioctl_compat(f.file, cmd, arg);
> +		goto out;
> +	}
> +
>  	switch (cmd) {
>  	/* FICLONE takes an int argument, so don't use compat_ptr() */
>  	case FICLONE:
> @@ -964,13 +1052,10 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
>  	default:
>  		error = do_vfs_ioctl(f.file, fd, cmd,
>  				     (unsigned long)compat_ptr(arg));
> -		if (error != -ENOIOCTLCMD)
> -			break;
> -
> -		if (f.file->f_op->compat_ioctl)
> -			error = f.file->f_op->compat_ioctl(f.file, cmd, arg);
> -		if (error == -ENOIOCTLCMD)
> -			error = -ENOTTY;
> +		if (error == -ENOIOCTLCMD) {
> +			WARN_ON_ONCE(is_device);
> +			error = ioctl_compat(f.file, cmd, arg);
> +		}
>  		break;
>  	}
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index ed5966a70495..b620d0c00e16 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1902,6 +1902,18 @@ extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
>  #define compat_ptr_ioctl NULL
>  #endif
>  
> +extern __attribute_const__ bool vfs_masked_device_ioctl(const unsigned int cmd);
> +#ifdef CONFIG_COMPAT
> +extern __attribute_const__ bool
> +vfs_masked_device_ioctl_compat(const unsigned int cmd);
> +#else /* CONFIG_COMPAT */
> +static inline __attribute_const__ bool
> +vfs_masked_device_ioctl_compat(const unsigned int cmd)
> +{
> +	return vfs_masked_device_ioctl(cmd);
> +}
> +#endif /* CONFIG_COMPAT */
> +
>  /*
>   * VFS file helper functions.
>   */
> -- 
> 2.43.0
> 
> 

