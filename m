Return-Path: <linux-fsdevel+bounces-27302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E16F896011F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 07:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A677F282D42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 05:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7FB7E76D;
	Tue, 27 Aug 2024 05:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oofV1dnx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EAE219FF;
	Tue, 27 Aug 2024 05:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724737033; cv=none; b=GqCDPj8yzcPoeS4WetCrOKbI26fZ7CUkRnXF0DE10foheK1NUQJHJf34FDzvwID5gZt+6PvjFBSlk3/F6kxE6famsWKVeSJAs0gmITSf6lb2HZSn9gzI7WkpAvtYDC5OHfNe6e4PCX5Y4KX/bP2zlgpCuYmiWDIq8rpYa9mPa9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724737033; c=relaxed/simple;
	bh=FL8QMhvmY7D4W97mKq5c6qB6W77X4e851Ydl4kL/M9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLiqaNwHqQ2pcKcW7jGtn6YIrGKq2JXMqxyroL4xIT4oTsPZyvOzVnsnLCJLH4JxRDPcEF1xQTLB4lAIGeh0YCSUMM4imWw7mDdHjOJoBvJ3KtI9j6LRs0n3VfIsWYuePyLXY8lLNEGcUPb90qAHIM/OZ0t2cvZIHZnRFq1F3HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oofV1dnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7021BC8B7A0;
	Tue, 27 Aug 2024 05:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724737033;
	bh=FL8QMhvmY7D4W97mKq5c6qB6W77X4e851Ydl4kL/M9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oofV1dnx5iaw+EB5Lg06Cavz+fw+Qz1r1U1b5YuJySn/0PU6VI8HbGFWOPm0d5Wi5
	 0AKg5SKF241FKo76FFdO8y29f2HJGF4WVkRZYMdRknj4M/isIh15bAMHyqG50g/VjB
	 VR6WPhTXWBLgoL0FwBjyLHQScnV4N7KOtlEh07mX1WTk8/PAirmjtSDW+cPZ3Gxdf+
	 LhT6zvU8dW9hhEP/jNbxM8ZKCbIq/dh77Rwd770k9q0W6fe78NuD4Rtra3iUcMTGXg
	 z8Tg07PO35RdOK0QJBtCKCC/oy20JGmHlAWYhVgVpwtL7TneRHRiq09CgX6jIYc4Dg
	 xz4yjZ2zJ6FKg==
Date: Mon, 26 Aug 2024 22:37:12 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk,
	gnoack@google.com, mic@digikod.net, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: obtain the inode generation number from vfs
 directly
Message-ID: <20240827053712.GL6043@frogsfrogsfrogs>
References: <20240827014108.222719-1-lihongbo22@huawei.com>
 <20240827021300.GK6043@frogsfrogsfrogs>
 <1183f4ae-4157-4cda-9a56-141708c128fe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1183f4ae-4157-4cda-9a56-141708c128fe@huawei.com>

On Tue, Aug 27, 2024 at 10:32:38AM +0800, Hongbo Li wrote:
> 
> 
> On 2024/8/27 10:13, Darrick J. Wong wrote:
> > On Tue, Aug 27, 2024 at 01:41:08AM +0000, Hongbo Li wrote:
> > > Many mainstream file systems already support the GETVERSION ioctl,
> > > and their implementations are completely the same, essentially
> > > just obtain the value of i_generation. We think this ioctl can be
> > > implemented at the VFS layer, so the file systems do not need to
> > > implement it individually.
> > 
> > What if a filesystem never touches i_generation?  Is it ok to advertise
> > a generation number of zero when that's really meaningless?  Or should
> > we gate the generic ioctl on (say) whether or not the fs implements file
> > handles and/or supports nfs?
> 
> This ioctl mainly returns the i_generation, and whether it has meaning is up
> to the specific file system. Some tools will invoke IOC_GETVERSION, such as
> `lsattr -v`(but if it's lattr, it won't), but users may not necessarily
> actually use this value.

That's not how that works.  If the kernel starts exporting a datum,
people will start using it, and then the expectation that it will
*continue* to work becomes ingrained in the userspace ABI forever.
Be careful about establishing new behaviors for vfat.

--D

> Thanks,
> Hongbo
> 
> > 
> > --D
> > 
> > > Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> > > ---
> > >   fs/ioctl.c | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > > index 64776891120c..dff887ec52c4 100644
> > > --- a/fs/ioctl.c
> > > +++ b/fs/ioctl.c
> > > @@ -878,6 +878,9 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
> > >   	case FS_IOC_GETFSUUID:
> > >   		return ioctl_getfsuuid(filp, argp);
> > > +	case FS_IOC_GETVERSION:
> > > +		return put_user(inode->i_generation, (int __user *)argp);
> > > +
> > >   	case FS_IOC_GETFSSYSFSPATH:
> > >   		return ioctl_get_fs_sysfs_path(filp, argp);
> > > @@ -992,6 +995,9 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
> > >   		cmd = (cmd == FS_IOC32_GETFLAGS) ?
> > >   			FS_IOC_GETFLAGS : FS_IOC_SETFLAGS;
> > >   		fallthrough;
> > > +	case FS_IOC32_GETVERSION:
> > > +		cmd = FS_IOC_GETVERSION;
> > > +		fallthrough;
> > >   	/*
> > >   	 * everything else in do_vfs_ioctl() takes either a compatible
> > >   	 * pointer argument or no argument -- call it with a modified
> > > -- 
> > > 2.34.1
> > > 
> > > 
> > 
> 

