Return-Path: <linux-fsdevel+bounces-63539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55756BC1102
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 13:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA603C027B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 11:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D662D97B0;
	Tue,  7 Oct 2025 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiHeVisf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74622D94B6;
	Tue,  7 Oct 2025 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759834817; cv=none; b=hpHHG7LscRc76doT5sp2IuXnwjAhQ3hCrSspEsDcmuuuBFycjK6AropXT7aDkIWnULdCGTiFFeIh/ZFheriUy5IzxX0mn+gVBPUPur4AlU+JOt73oW0eIoC3JvZ2fMwdw5laATg7dZsJ33imVX2R2RxXHrQtBeNXPXxrUynMNbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759834817; c=relaxed/simple;
	bh=/2VIdMWbboXqCq5v9dnulh2ZyDJ42EWteyguSk+LUQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jn2tNGJaE6EoDjBGolixuF906ftuemsAAhcFNqMujY2UX5wCdi7fDwHwEUv/3JSomyKRqQejxJ6P7jnSjGNOacXJSOuO/mQOD7QDKVIRZQhtVdCNL/buu8SWERFJE4GcmNAfAwkes16uzkF/z+wLK/WSyXjWiUeCaVVilPnkp2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiHeVisf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DB3C4CEF1;
	Tue,  7 Oct 2025 11:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759834816;
	bh=/2VIdMWbboXqCq5v9dnulh2ZyDJ42EWteyguSk+LUQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UiHeVisfkY334uI4HpUo6w2kkokFLO6eSqGtCgtKtpTrQ+8Qcwb2HUCCyG1VcHWbn
	 mvj5HtNTiOXq4RTVkUbodi7e35ozsWpNgcx2q+Oc+dp+LWgLlrHwCjAjcuYdPa9Xie
	 knl+V7fA7fUvrZsEDkeUBLuIxI3kctX2Fex4gEmvDYd5iM5RyN1ImrksR3BzcLCP/y
	 7bPAcDjDkoUotQ4nsmGZ5OgSwIHycWfbJVEfNdPUgQvEhMu8/88FC8Q357QXyyvX3j
	 vEghprV6rvHauu2CYpxbLEzWok6pi4g4km6NDIFc3yybMfUD/Z4WQ4/MlqD3DxV9bi
	 X3hevpycblFfA==
Date: Tue, 7 Oct 2025 13:00:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Jiri Slaby <jirislaby@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, selinux@vger.kernel.org, 
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 4/6] fs: make vfs_fileattr_[get|set] return -EOPNOSUPP
Message-ID: <20251007-talent-extern-cda07dfddd11@brauner>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-4-c4e3bc35227b@kernel.org>
 <a622643f-1585-40b0-9441-cf7ece176e83@kernel.org>
 <jp3vopwtpik7bj77aejuknaziecuml6x2l2dr3oe2xoats6tls@yskzvehakmkv>
 <eyl6bzyi33tn6uys2ba5xjluvw7yjempqnla3jaih76mtgxgxq@i6xe2nquwqaf>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eyl6bzyi33tn6uys2ba5xjluvw7yjempqnla3jaih76mtgxgxq@i6xe2nquwqaf>

On Mon, Oct 06, 2025 at 08:52:32PM +0200, Andrey Albershteyn wrote:
> On 2025-10-06 17:39:46, Jan Kara wrote:
> > On Mon 06-10-25 13:09:05, Jiri Slaby wrote:
> > > On 30. 06. 25, 18:20, Andrey Albershteyn wrote:
> > > > Future patches will add new syscalls which use these functions. As
> > > > this interface won't be used for ioctls only, the EOPNOSUPP is more
> > > > appropriate return code.
> > > > 
> > > > This patch converts return code from ENOIOCTLCMD to EOPNOSUPP for
> > > > vfs_fileattr_get and vfs_fileattr_set. To save old behavior translate
> > > > EOPNOSUPP back for current users - overlayfs, encryptfs and fs/ioctl.c.
> > > > 
> > > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > > ...
> > > > @@ -292,6 +294,8 @@ int ioctl_setflags(struct file *file, unsigned int __user *argp)
> > > >   			fileattr_fill_flags(&fa, flags);
> > > >   			err = vfs_fileattr_set(idmap, dentry, &fa);
> > > >   			mnt_drop_write_file(file);
> > > > +			if (err == -EOPNOTSUPP)
> > > > +				err = -ENOIOCTLCMD;
> > > 
> > > This breaks borg code (unit tests already) as it expects EOPNOTSUPP, not
> > > ENOIOCTLCMD/ENOTTY:
> > > https://github.com/borgbackup/borg/blob/1c6ef7a200c7f72f8d1204d727fea32168616ceb/src/borg/platform/linux.pyx#L147
> > > 
> > > I.e. setflags now returns ENOIOCTLCMD/ENOTTY for cases where 6.16 used to
> > > return EOPNOTSUPP.
> > > 
> > > This minimal testcase program doing ioctl(fd2, FS_IOC_SETFLAGS,
> > > &FS_NODUMP_FL):
> > > https://github.com/jirislaby/collected_sources/tree/master/ioctl_setflags
> > > 
> > > dumps in 6.16:
> > > sf: ioctl: Operation not supported
> > > 
> > > with the above patch:
> > > sf: ioctl: Inappropriate ioctl for device
> > > 
> > > Is this expected?

Nope, unintentional regression as Arnd noted.

> > 
> > No, that's a bug and a clear userspace regression so we need to fix it. I
> > think we need to revert this commit and instead convert ENOIOCTLCMD from
> > vfs_fileattr_get/set() to EOPNOTSUPP in appropriate places. Andrey?
> 
> I will prepare a patch soon

Thanks!

