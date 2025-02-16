Return-Path: <linux-fsdevel+bounces-41803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842B5A37775
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 21:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B7C188D9EA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 20:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAC81A255C;
	Sun, 16 Feb 2025 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUQsJ/8E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2907018DF6B;
	Sun, 16 Feb 2025 20:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739737494; cv=none; b=E4xKqH3CPpIaV14h2SgjsQMbPQh/fCOK9D7INN0CqgSgzUsJ0rzujpHAO087sRkzrUc/MSExA85XcCyQXwm93Y/TK6NJJRl6JOeghuGgZAHdkL+UnmtsVsWgY1iY2rTvBOvxIEAlFaqppwE4uOCXDsKGHuu0YQMCITBk8Z61gGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739737494; c=relaxed/simple;
	bh=r9JEgcOxnzNtoItYqF/1p17G52QEzRvGskS3plFFchE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPBDVdaji9Mc8tnn8xPG4w+DvPERQGzmp0Y9q47/jM1JAdx/RQHgFz3ihJhRZ0eXwOvQLwHiZr6AscvmgRxF3zqIF3Eh3um45aTzhGgY+4x2uw6r1ADFuFC3REVAbKHx42jyigCAifoQy0QYz+S8F1l5zk62zi7mA9oulv5fNmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUQsJ/8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED1FC4CEDD;
	Sun, 16 Feb 2025 20:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739737493;
	bh=r9JEgcOxnzNtoItYqF/1p17G52QEzRvGskS3plFFchE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YUQsJ/8E+de+NTmeUBaAsXqVttig9QRPbxb9VEtDYiz3cNcGVYyXXsEbb0XC6fdMo
	 obmJiUSQPOoXyrmoO+6BhkL5bRyMNZ/PmARBGXv0nQsuUd6KZGwMNppo6tW8Z7zx5C
	 +t/uEdXwrMpbkTyUf5nQh3HoFRXINQifGO7mR3Aj3A6/72cXOw7oENm2QS024zFzYP
	 2bOX5upJtO2GOCiPU4+0WDCwzoYvRkVyrz+gIaYq2wdcp8UMy8dBWdoAtHChNmCNMX
	 6ljZkRNp0OenaUOL2wBMRIOKvT5xWSg0k+268jbPeUXJUQ93ozlCma4xZdF0RLxxQr
	 209u5QHRyjRjw==
Received: by pali.im (Postfix)
	id 235127FD; Sun, 16 Feb 2025 21:24:41 +0100 (CET)
Date: Sun, 16 Feb 2025 21:24:41 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] fs: Add FS_XFLAG_COMPRESSED & FS_XFLAG_ENCRYPTED
 for FS_IOC_FS[GS]ETXATTR API
Message-ID: <20250216202441.d3re7lfky6bcozkv@pali>
References: <20250216164029.20673-1-pali@kernel.org>
 <20250216164029.20673-2-pali@kernel.org>
 <20250216183432.GA2404@sol.localdomain>
 <CAOQ4uxigYpzpttfaRc=xAxJc=f2bz89_eCideuftf3egTiE+3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxigYpzpttfaRc=xAxJc=f2bz89_eCideuftf3egTiE+3A@mail.gmail.com>
User-Agent: NeoMutt/20180716

On Sunday 16 February 2025 21:17:55 Amir Goldstein wrote:
> On Sun, Feb 16, 2025 at 7:34 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Sun, Feb 16, 2025 at 05:40:26PM +0100, Pali Rohár wrote:
> > > This allows to get or set FS_COMPR_FL and FS_ENCRYPT_FL bits via FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR API.
> > >
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> >
> > Does this really allow setting FS_ENCRYPT_FL via FS_IOC_FSSETXATTR, and how does
> > this interact with the existing fscrypt support in ext4, f2fs, ubifs, and ceph
> > which use that flag?
> 
> As far as I can tell, after fileattr_fill_xflags() call in
> ioctl_fssetxattr(), the call
> to ext4_fileattr_set() should behave exactly the same if it came some
> FS_IOC_FSSETXATTR or from FS_IOC_SETFLAGS.
> IOW, EXT4_FL_USER_MODIFIABLE mask will still apply.
> 
> However, unlike the legacy API, we now have an opportunity to deal with
> EXT4_FL_USER_MODIFIABLE better than this:
>         /*
>          * chattr(1) grabs flags via GETFLAGS, modifies the result and
>          * passes that to SETFLAGS. So we cannot easily make SETFLAGS
>          * more restrictive than just silently masking off visible but
>          * not settable flags as we always did.
>          */
> 
> if we have the xflags_mask in the new API (not only the xflags) then
> chattr(1) can set EXT4_FL_USER_MODIFIABLE in xflags_mask
> ext4_fileattr_set() can verify that
> (xflags_mask & ~EXT4_FL_USER_MODIFIABLE == 0).
> 
> However, Pali, this is an important point that your RFC did not follow -
> AFAICT, the current kernel code of ext4_fileattr_set() and xfs_fileattr_set()
> (and other fs) does not return any error for unknown xflags, it just
> ignores them.
> 
> This is why a new ioctl pair FS_IOC_[GS]ETFSXATTR2 is needed IMO
> before adding support to ANY new xflags, whether they are mapped to
> existing flags like in this patch or are completely new xflags.
> 
> Thanks,
> Amir.

But xflags_mask is available in this new API. It is available if the
FS_XFLAG_HASEXTFIELDS flag is set. So I think that the ext4 improvement
mentioned above can be included into this new API.

Or I'm missing something?

