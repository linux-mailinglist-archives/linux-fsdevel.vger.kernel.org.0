Return-Path: <linux-fsdevel+bounces-41808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D21EDA377BE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 22:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9183AFBB6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 21:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F73D1A3178;
	Sun, 16 Feb 2025 21:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYQ5J64p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36E633C5;
	Sun, 16 Feb 2025 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739740650; cv=none; b=NoMG3vI1W6RQqgLwV05FDHca9n0VJnM/eXRS3OVbXl8y7oQMK35dilOaxf4Fljz0IX2/jrAEBfhscCGaSqvk/5JLWAnSg0hbSsFnUApvCTD9IfCQtiLSHcyJSljk1NO3iLe9pcWggQfsiePOnJ+3flXJezhpRGJrOOQrmebPK/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739740650; c=relaxed/simple;
	bh=B70L66JAjJLrVOOPdoxtwKfa95fTYtQahdSnp8u5cTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z50KH9tc9JQG6i/r74nL3po/GR1cTgGXq3oku6IJ6c27Sus6au/sQ0BbOswVWmcHnKowG10XnfiXqmON5YAv7TJ/+sTWOPFTAURv1wPKIJZBjig33y++1ZcXqxPGjoKbz0bXVv56wkXKH0L6uKW2KcdjFq1iSjNOGGz2vFmyMmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYQ5J64p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94B6C4CEDD;
	Sun, 16 Feb 2025 21:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739740650;
	bh=B70L66JAjJLrVOOPdoxtwKfa95fTYtQahdSnp8u5cTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EYQ5J64pnBy/0gpq4OvAANBzHRHbLamWsJTjcPOWAUNFUyjs5CZjpM7xGSY3MkjJ3
	 duDSbbHYJcdoPYF03PPqA4IqxD2ewLU+Q55HKxxYH88ypL6M9y7r7clySm5Os88DEs
	 oFu9bHIgFPIvH5LYl+/YaiiOJkLV4s3pAU4RvzfAijEn9cGhASCro4aXPtB2dsu/eD
	 mFUylndFn+SRyA6Q4uBTmD9OuyuMcnQ7raBp7gpn7anrHUJIKI8FvQWvD+sV1gtIo+
	 l2jJI9ZOV/EVdys19PqwjTo6eBwHZt9Kh9J0MND1PL9o0HaSgmImSdZj9KqcjVmojG
	 F+MJ3pHlnIqYA==
Received: by pali.im (Postfix)
	id 7E1147FD; Sun, 16 Feb 2025 22:17:17 +0100 (CET)
Date: Sun, 16 Feb 2025 22:17:17 +0100
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
Message-ID: <20250216211717.f7mvmh4lwpopbukn@pali>
References: <20250216164029.20673-1-pali@kernel.org>
 <20250216164029.20673-2-pali@kernel.org>
 <20250216183432.GA2404@sol.localdomain>
 <CAOQ4uxigYpzpttfaRc=xAxJc=f2bz89_eCideuftf3egTiE+3A@mail.gmail.com>
 <20250216202441.d3re7lfky6bcozkv@pali>
 <CAOQ4uxj4urR70FmLB_4Qwbp1O5TwvHWSW6QPTCuq7uXp033B7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj4urR70FmLB_4Qwbp1O5TwvHWSW6QPTCuq7uXp033B7Q@mail.gmail.com>
User-Agent: NeoMutt/20180716

On Sunday 16 February 2025 21:43:02 Amir Goldstein wrote:
> On Sun, Feb 16, 2025 at 9:24 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Sunday 16 February 2025 21:17:55 Amir Goldstein wrote:
> > > On Sun, Feb 16, 2025 at 7:34 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > > >
> > > > On Sun, Feb 16, 2025 at 05:40:26PM +0100, Pali Rohár wrote:
> > > > > This allows to get or set FS_COMPR_FL and FS_ENCRYPT_FL bits via FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR API.
> > > > >
> > > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > >
> > > > Does this really allow setting FS_ENCRYPT_FL via FS_IOC_FSSETXATTR, and how does
> > > > this interact with the existing fscrypt support in ext4, f2fs, ubifs, and ceph
> > > > which use that flag?
> > >
> > > As far as I can tell, after fileattr_fill_xflags() call in
> > > ioctl_fssetxattr(), the call
> > > to ext4_fileattr_set() should behave exactly the same if it came some
> > > FS_IOC_FSSETXATTR or from FS_IOC_SETFLAGS.
> > > IOW, EXT4_FL_USER_MODIFIABLE mask will still apply.
> > >
> > > However, unlike the legacy API, we now have an opportunity to deal with
> > > EXT4_FL_USER_MODIFIABLE better than this:
> > >         /*
> > >          * chattr(1) grabs flags via GETFLAGS, modifies the result and
> > >          * passes that to SETFLAGS. So we cannot easily make SETFLAGS
> > >          * more restrictive than just silently masking off visible but
> > >          * not settable flags as we always did.
> > >          */
> > >
> > > if we have the xflags_mask in the new API (not only the xflags) then
> > > chattr(1) can set EXT4_FL_USER_MODIFIABLE in xflags_mask
> > > ext4_fileattr_set() can verify that
> > > (xflags_mask & ~EXT4_FL_USER_MODIFIABLE == 0).
> > >
> > > However, Pali, this is an important point that your RFC did not follow -
> > > AFAICT, the current kernel code of ext4_fileattr_set() and xfs_fileattr_set()
> > > (and other fs) does not return any error for unknown xflags, it just
> > > ignores them.
> > >
> > > This is why a new ioctl pair FS_IOC_[GS]ETFSXATTR2 is needed IMO
> > > before adding support to ANY new xflags, whether they are mapped to
> > > existing flags like in this patch or are completely new xflags.
> > >
> > > Thanks,
> > > Amir.
> >
> > But xflags_mask is available in this new API. It is available if the
> > FS_XFLAG_HASEXTFIELDS flag is set. So I think that the ext4 improvement
> > mentioned above can be included into this new API.
> >
> > Or I'm missing something?
> 
> Yes, you are missing something very fundamental to backward compat API -
> You cannot change the existing kernels.
> 
> You should ask yourself one question:
> What happens if I execute the old ioctl FS_IOC_FSSETXATTR
> on an existing old kernel with the new extended flags?
> 
> The answer, to the best of my code emulation abilities is that
> old kernel will ignore the new xflags including FS_XFLAG_HASEXTFIELDS
> and this is suboptimal, because it would be better for the new chattr tool
> to get -EINVAL when trying to set new xflags and mask on an old kernel.
> 
> It is true that the new chattr can call the old FS_IOC_FSGETXATTR
> ioctl and see that it has no FS_XFLAG_HASEXTFIELDS,

Yes, this was my intention how the backward and forward compatibility
will work. I thought that reusing existing IOCTL is better than creating
new IOCTL and duplicating functionality.

> so I agree that a new ioctl is not absolutely necessary,
> but I still believe that it is a better API design.

If it is a bad idea then for sure I can prepare new IOCTL and move all
new functionality only into the new IOCTL, no problem.

> Would love to hear what other fs developers prefer.
> 
> Thanks,
> Amir.

