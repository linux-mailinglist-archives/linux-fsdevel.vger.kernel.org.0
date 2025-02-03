Return-Path: <linux-fsdevel+bounces-40687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C2BA267EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 00:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D77D7A1BE8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 23:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31280211475;
	Mon,  3 Feb 2025 23:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRqBbUHR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818BE3597D;
	Mon,  3 Feb 2025 23:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738625656; cv=none; b=nIXOGjG6K3z98JHvyng0WQUxdyp4G6Cc+p6m2MzL74toJjXlhjR9yfcCa2RCEfgutnMQrYaq4rfosPiwKQZkDOLUbLIMj9LwSV89/27NCzVUQJrstRo4sWssUouWM5/RKisihdsNkvGHBzinRRnXUPL8kkr8/zgEjIANANmEzjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738625656; c=relaxed/simple;
	bh=TQ5qcyoAV7LIqUme0J70afHkjiheh5sdbY738cRv2hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M87tY/rs0ocPAbkRwSE/471M5Iuah4mXKF4ZbfMZppBm0PW1mKjew4zoD4Uj+JtodfP0HbyQO7vbljCbb7IMzVt06NSHEmRNjKtQEfrahmwcjwgAixxqyngA/2+q0erEnktZK8QXu1ajUvoUCXmUumWsnYCdr9J5ibo3WKFNCSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRqBbUHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62537C4CEE0;
	Mon,  3 Feb 2025 23:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738625655;
	bh=TQ5qcyoAV7LIqUme0J70afHkjiheh5sdbY738cRv2hA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oRqBbUHRHX75Yg509/xquv3c3T0ex/H/a+//a80oBPFz2waJNfA5aD+3s8h2YG67Z
	 BqQI8TgLccgzJpEkrDhywBSGxXf0izbzAyhVwq+/eVFlg5M6mdUNg1b1PhOm2nyvXB
	 TFRLCO40QCAJqAzfS/pp8BIl5tLPvWVKwM6HRbhIe56V5Nvl03nEHIhwzJEhnS7UBK
	 fhgRGpTHBfiJe9PvLeXywmnqAHD64qLY2qqQcVyrKuj/VQDjciC2/Z0baH9NNWCkuN
	 GwJdgFloJ8n2nEEfot6hG033MuZ4zkOG2EBE/DxGChaCvvw50xJOW4kJZC5r+LhMWj
	 gQZYD1ptDKNRA==
Received: by pali.im (Postfix)
	id 9E2E87CA; Tue,  4 Feb 2025 00:34:03 +0100 (CET)
Date: Tue, 4 Feb 2025 00:34:03 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Immutable vs read-only for Windows compatibility
Message-ID: <20250203233403.5a5pcgl5xylj47nb@pali>
References: <20250114235547.ncqaqcslerandjwf@pali>
 <20250114235925.GC3561231@frogsfrogsfrogs>
 <CAOQ4uxjj3XUNh6p3LLp_4YCJQ+cQHu7dj8uM3gCiU61L3CQRpA@mail.gmail.com>
 <20250117173900.GN3557553@frogsfrogsfrogs>
 <CAOQ4uxhh1LDz5zXzqFENPhJ9k851AL3E7Xc2d7pSVVYX4Fu9Jw@mail.gmail.com>
 <20250117185947.ylums2dhmo3j6hol@pali>
 <20250202152343.ahy4hnzbfuzreirz@pali>
 <CAOQ4uxgjbHTyQ53u=abWhyQ81ATL4cqSeWKDfOjz-EaR0NGmug@mail.gmail.com>
 <20250203221955.bgvlkp273o3wnzmf@pali>
 <CAOQ4uxhkB6oTJm7DvQxFbxkQ1u_KMUFEL0eWKVYf39hnuYrnfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhkB6oTJm7DvQxFbxkQ1u_KMUFEL0eWKVYf39hnuYrnfQ@mail.gmail.com>
User-Agent: NeoMutt/20180716

On Tuesday 04 February 2025 00:02:44 Amir Goldstein wrote:
> On Mon, Feb 3, 2025 at 11:20 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Monday 03 February 2025 22:59:46 Amir Goldstein wrote:
> > > On Sun, Feb 2, 2025 at 4:23 PM Pali Rohár <pali@kernel.org> wrote:
> > > > And there is still unresolved issue with FILE_ATTRIBUTE_READONLY.
> > > > Its meaning is similar to existing Linux FS_IMMUTABLE_FL, just
> > > > FILE_ATTRIBUTE_READONLY does not require root / CAP_LINUX_IMMUTABLE.
> > > >
> > > > I think that for proper support, to enforce FILE_ATTRIBUTE_READONLY
> > > > functionality, it is needed to introduce new flag e.g.
> > > > FS_IMMUTABLE_FL_USER to allow setting / clearing it also for normal
> > > > users without CAP_LINUX_IMMUTABLE. Otherwise it would be unsuitable for
> > > > any SMB client, SMB server or any application which would like to use
> > > > it, for example wine.
> > > >
> > > > Just to note that FreeBSD has two immutable flags SF_IMMUTABLE and
> > > > UF_IMMUTABLE, one settable only by superuser and second for owner.
> > > >
> > > > Any opinion?
> > >
> > > For filesystems that already support FILE_ATTRIBUTE_READONLY,
> > > can't you just set S_IMMUTABLE on the inode and vfs will do the correct
> > > enforcement?
> > >
> > > The vfs does not control if and how S_IMMUTABLE is set by filesystems,
> > > so if you want to remove this vfs flag without CAP_LINUX_IMMUTABLE
> > > in smb client, there is nothing stopping you (I think).
> >
> > Function fileattr_set_prepare() checks for CAP_LINUX_IMMUTABLE when
> > trying to change FS_IMMUTABLE_FL bit. This function is called from
> > ioctl(FS_IOC_SETFLAGS) and also from ioctl(FS_IOC_FSSETXATTR).
> > And when function fileattr_set_prepare() fails then .fileattr_set
> > callback is not called at all. So I think that it is not possible to
> > remove the IMMUTABLE flag from userspace without capability for smb
> > client.
> >
> 
> You did not understand what I meant.
> 
> You cannot relax the CAP_LINUX_IMMUTABLE for setting FS_IMMUTABLE_FL
> and there is no reason that you will need to relax it.
> 
> The vfs does NOT enforce permissions according to FS_IMMUTABLE_FL
> The vfs enforces permissions according to the S_IMMUTABLE in-memory
> inode flag.
> 
> There is no generic vfs code that sets S_IMMUTABLE inode flags, its
> the filesystems that translate the on-disk FS_IMMUTABLE_FL to
> in-memory S_IMMUTABLE inode flag.
> 
> So if a filesystem already has an internal DOSATTRIB flags set, this
> filesystem can set the in-memory S_IMMUTABLE inode flag according
> to its knowledge of the DOSATTRIB_READONLY flag and the
> CAP_LINUX_IMMUTABLE rules do not apply to the DOSATTRIB_READONLY
> flag, which is NOT the same as the FS_IMMUTABLE_FL flag.
> 
> > And it would not solve this problem for local filesystems (ntfs or ext4)
> > when Samba server or wine would want to set this bit.
> >
> 
> The Samba server would use the FS_IOC_FS[GS]ETXATTR ioctl
> API to get/set dosattrib, something like this:
> 
> struct fsxattr fsxattr;
> ret = ioctl_get_fsxattr(fd, &fsxattr);
> if (!ret && fsxattr.fsx_xflags & FS_XFLAG_HASDOSATTR) {
>     fsxattr.fsx_dosattr |= fs_dosattrib_readonly;
>     ret = ioctl_set_fsxattr(fd, &fsxattr);
> }

Thanks for more explanation. First time I really did not understood it.
But now I think I understood it. So basically there would be two flags
which would result in setting S_IMMUTABLE on inode. One is the existing
FS_IMMUTABLE_FL which requires the capability and some new flag (e.g.
FS_XFLAG_HASDOSATTR) which would not require it and can be implemented
for cifs, vfat, ntfs, ... Right?

> For ntfs/ext4, you will need to implement on-disk support for
> set/get the dosattrib flags.

ntfs has already on-disk support for FILE_ATTRIBUTE_READONLY.

On-disk support for ext4 and other linux filesystems can be discussed
later. I think that this could be more controversial.

> I can certainly not change the meaning of existing on-disk
> flag of FS_IMMUTABLE_FL to a flag that can be removed
> without CAP_LINUX_IMMUTABLE. that changes the meaning
> of the flag.
> 
> If ext4 maintainers agrees, you may be able to reuse some
> old unused on-disk flags (e.g.  EXT4_UNRM_FL) as storage
> place for FS_DOSATTRIB_READONLY, but that would be
> quite hackish.
> 
> > > How about tackling this one small step at a time, not in that order
> > > necessarily:
> > >
> > > 1. Implement the standard API with FS_IOC_FS[GS]ETXATTR ioctl
> > >     and with statx to get/set some non-controversial dosattrib flags on
> > >     ntfs/smb/vfat
> > > 2. Wire some interesting dosattrib flags (e.g. compr/enrypt) to local
> > >     filesystems that already support storing those bits
> > > 3. Wire network servers (e.g. Samba) to use the generic API if supported
> > > 4. Add on-disk support for storing the dosattrib flags to more local fs
> > > 5. Update S_IMMUTABLE inode flag if either FS_XFLAG_IMMUTABLE
> > >     or FS_DOSATTRIB_READONLY are set on the file
> > >
> > > Thoughts?
> > >
> 
> Anything wrong with the plan above?
> It seems that you are looking for shortcuts and I don't think that
> it is a good way to make progress.
> 
> Thanks,
> Amir.

If other developers agree that the FS_IOC_FS[GS]ETXATTR ioctl is the
right direction then for me it looks good.

