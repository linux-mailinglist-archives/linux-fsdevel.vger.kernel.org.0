Return-Path: <linux-fsdevel+bounces-40674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF441A26672
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 23:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 975B57A1DF5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 22:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB38120FA9C;
	Mon,  3 Feb 2025 22:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uV8PxFX+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DCE1F92A;
	Mon,  3 Feb 2025 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738621208; cv=none; b=ddHSogAMuqqBaVOhjUw58JJwTCs3ISQNsHxwxmu3fubxgK3yuVb4nfzGADOQVoFQQzUWNRaOtw2szbjtzXwY/gw0IuN/nF285ehwncoujuw2HECLIQgN48wLMzjNvL23lk2Td+V/MMW4Kroy5qQkPAjIW5dbKghdSpRy8cTaRXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738621208; c=relaxed/simple;
	bh=PA3NMuBem5rghZcWHiQ2TdTBORSdonrgrgLMvz81NXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i44mYKmQ8eCxR8Aek3rLlprMMJtNPZ7WXUIZWvzXr4Q0a6HIQ5NMPaU1FueHUXPVzYFLSPb2aQwSlxmFaJdIcBRgAGvUJyFX9MGMv0bc++jrscVIf7msyrPwBoNcxI3/QaBx9tt9rbXzMf12B/joPh048rqoXWWEQCpsSi3jV78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uV8PxFX+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F19C4CED2;
	Mon,  3 Feb 2025 22:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738621207;
	bh=PA3NMuBem5rghZcWHiQ2TdTBORSdonrgrgLMvz81NXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uV8PxFX+0xSQ6NwnaPRgFM0DwO+ZRuyyseury023GWNcQC4mDKxQgJXHitgTu3q0G
	 mLXsEBO27HUnJ1BPj6RPKnYUxMk0LhnANNGvit2Fuax9pcwcU6mT12SrzvVx54+iFT
	 Fc7zaj8CbnchFUPRYf6bUivWEC7YrL0q6a0JIvAlMrWi6jmNybwqhQf7mTWNfj9rBL
	 yeMuuGnxxafmTFInPXwvJci8YSCSRxEMs+TseDe2+9dO8FXvCqa8lHF7KIyl8T+AfN
	 OJ3/YmsCSTs2IjvrjU4DbDirxJorPu6nu1VPUQHIZ0hnwVygTMekbYr8/pqtmS+e/f
	 SiW111rD7pfHQ==
Received: by pali.im (Postfix)
	id 8B8EA7CA; Mon,  3 Feb 2025 23:19:55 +0100 (CET)
Date: Mon, 3 Feb 2025 23:19:55 +0100
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
Message-ID: <20250203221955.bgvlkp273o3wnzmf@pali>
References: <20250114215350.gkc2e2kcovj43hk7@pali>
 <CAN05THSXjmVtvYdFLB67kKOwGN5jsAiihtX57G=HT7fBb62yEw@mail.gmail.com>
 <20250114235547.ncqaqcslerandjwf@pali>
 <20250114235925.GC3561231@frogsfrogsfrogs>
 <CAOQ4uxjj3XUNh6p3LLp_4YCJQ+cQHu7dj8uM3gCiU61L3CQRpA@mail.gmail.com>
 <20250117173900.GN3557553@frogsfrogsfrogs>
 <CAOQ4uxhh1LDz5zXzqFENPhJ9k851AL3E7Xc2d7pSVVYX4Fu9Jw@mail.gmail.com>
 <20250117185947.ylums2dhmo3j6hol@pali>
 <20250202152343.ahy4hnzbfuzreirz@pali>
 <CAOQ4uxgjbHTyQ53u=abWhyQ81ATL4cqSeWKDfOjz-EaR0NGmug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgjbHTyQ53u=abWhyQ81ATL4cqSeWKDfOjz-EaR0NGmug@mail.gmail.com>
User-Agent: NeoMutt/20180716

On Monday 03 February 2025 22:59:46 Amir Goldstein wrote:
> On Sun, Feb 2, 2025 at 4:23 PM Pali Rohár <pali@kernel.org> wrote:
> > And there is still unresolved issue with FILE_ATTRIBUTE_READONLY.
> > Its meaning is similar to existing Linux FS_IMMUTABLE_FL, just
> > FILE_ATTRIBUTE_READONLY does not require root / CAP_LINUX_IMMUTABLE.
> >
> > I think that for proper support, to enforce FILE_ATTRIBUTE_READONLY
> > functionality, it is needed to introduce new flag e.g.
> > FS_IMMUTABLE_FL_USER to allow setting / clearing it also for normal
> > users without CAP_LINUX_IMMUTABLE. Otherwise it would be unsuitable for
> > any SMB client, SMB server or any application which would like to use
> > it, for example wine.
> >
> > Just to note that FreeBSD has two immutable flags SF_IMMUTABLE and
> > UF_IMMUTABLE, one settable only by superuser and second for owner.
> >
> > Any opinion?
> 
> For filesystems that already support FILE_ATTRIBUTE_READONLY,
> can't you just set S_IMMUTABLE on the inode and vfs will do the correct
> enforcement?
> 
> The vfs does not control if and how S_IMMUTABLE is set by filesystems,
> so if you want to remove this vfs flag without CAP_LINUX_IMMUTABLE
> in smb client, there is nothing stopping you (I think).

Function fileattr_set_prepare() checks for CAP_LINUX_IMMUTABLE when
trying to change FS_IMMUTABLE_FL bit. This function is called from
ioctl(FS_IOC_SETFLAGS) and also from ioctl(FS_IOC_FSSETXATTR).
And when function fileattr_set_prepare() fails then .fileattr_set
callback is not called at all. So I think that it is not possible to
remove the IMMUTABLE flag from userspace without capability for smb
client.

And it would not solve this problem for local filesystems (ntfs or ext4)
when Samba server or wine would want to set this bit.

> How about tackling this one small step at a time, not in that order
> necessarily:
> 
> 1. Implement the standard API with FS_IOC_FS[GS]ETXATTR ioctl
>     and with statx to get/set some non-controversial dosattrib flags on
>     ntfs/smb/vfat
> 2. Wire some interesting dosattrib flags (e.g. compr/enrypt) to local
>     filesystems that already support storing those bits
> 3. Wire network servers (e.g. Samba) to use the generic API if supported
> 4. Add on-disk support for storing the dosattrib flags to more local fs
> 5. Update S_IMMUTABLE inode flag if either FS_XFLAG_IMMUTABLE
>     or FS_DOSATTRIB_READONLY are set on the file
> 
> Thoughts?
> 
> Thanks,
> Amir.

