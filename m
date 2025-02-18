Return-Path: <linux-fsdevel+bounces-42008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E3CA3A75F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 20:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B0D3A1F08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 19:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138631E5217;
	Tue, 18 Feb 2025 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv+kxxfr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D43717A308;
	Tue, 18 Feb 2025 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906838; cv=none; b=gHHdGgvmpx1gywUSmUAXPDMqTV9NbRiBzP+EZjHy3keBOXBO8AATTM53XK2EZciS+lX4rIjEjBikPJcc6ErtEt6RqNE/6biI22jtUhKSIWVtj2mpybAWSdTcQMl1hjdp2gd8jyss08ZHCLxsd1ni99g0Qk0jzGnf0qSuWDn1kLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906838; c=relaxed/simple;
	bh=5GSC+y+w4i1hQr+41WE0FYBKnlYPmuRJB82URWV5GNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5Mr3Z1UDbkdjZbNYdPFvwsxWddszJig//DDxoaRlXGqwuPUZWlEVp2u+IibVckfgH72wP6KB+Q999pYDdiHevNoQhDC04sHAhdrwWOw7HqEKDgvHSvS1HpLRNuh7ljclOAhwv53LZsBVmTl62YuSyb0MZg4AHQToTb9ZCVfZPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bv+kxxfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70705C4CEE2;
	Tue, 18 Feb 2025 19:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739906834;
	bh=5GSC+y+w4i1hQr+41WE0FYBKnlYPmuRJB82URWV5GNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bv+kxxfrKehnm3Jdumtsu/noEyOkpy0UruQtfyDB1pt50/2U60o4RUkGmfMJg5d/K
	 qZTTIp2E9aiv0q+bMMTGmofN73mIJXccbqmVdJ5OfIyeO4d4/raVlT2MNnrUyVuTAP
	 WAN+NeZSXRIJRhpsiokn6mBfBVXalX+bUGITNf96b5hO4P5koix95/6Ew2g+62IhAe
	 WWF5UIDs9j3MwYRSInH/dKz4HYhrbSIZCnrauIE+1rDSbEvuFiY6zwvqxJNDUnjQf5
	 si6Zha0dxRwa5a9uvCuEWhUUm6/oP+KQXgYL1cCmcgYV75sdGqL2njkv5tvx3w8TQS
	 ervm1UOB7CM7A==
Received: by pali.im (Postfix)
	id B87E67EF; Tue, 18 Feb 2025 20:27:01 +0100 (CET)
Date: Tue, 18 Feb 2025 20:27:01 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, Eric Biggers <ebiggers@kernel.org>,
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
Message-ID: <20250218192701.4q22uaqdyjxfp4p3@pali>
References: <20250216164029.20673-1-pali@kernel.org>
 <20250216164029.20673-2-pali@kernel.org>
 <20250216183432.GA2404@sol.localdomain>
 <CAOQ4uxigYpzpttfaRc=xAxJc=f2bz89_eCideuftf3egTiE+3A@mail.gmail.com>
 <20250216202441.d3re7lfky6bcozkv@pali>
 <CAOQ4uxj4urR70FmLB_4Qwbp1O5TwvHWSW6QPTCuq7uXp033B7Q@mail.gmail.com>
 <Z7Pjb5tI6jJDlFZn@dread.disaster.area>
 <CAOQ4uxh6aWO7Emygi=dXCE3auDcZZCmDP+jmjhgdffuz1Vx6uQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxh6aWO7Emygi=dXCE3auDcZZCmDP+jmjhgdffuz1Vx6uQ@mail.gmail.com>
User-Agent: NeoMutt/20180716

On Tuesday 18 February 2025 10:13:46 Amir Goldstein wrote:
> On Tue, Feb 18, 2025 at 2:33 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Sun, Feb 16, 2025 at 09:43:02PM +0100, Amir Goldstein wrote:
> > > On Sun, Feb 16, 2025 at 9:24 PM Pali Rohár <pali@kernel.org> wrote:
> > > >
> > > > On Sunday 16 February 2025 21:17:55 Amir Goldstein wrote:
> > > > > On Sun, Feb 16, 2025 at 7:34 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > > > > >
> > > > > > On Sun, Feb 16, 2025 at 05:40:26PM +0100, Pali Rohár wrote:
> > > > > > > This allows to get or set FS_COMPR_FL and FS_ENCRYPT_FL bits via FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR API.
> > > > > > >
> > > > > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > > >
> > > > > > Does this really allow setting FS_ENCRYPT_FL via FS_IOC_FSSETXATTR, and how does
> > > > > > this interact with the existing fscrypt support in ext4, f2fs, ubifs, and ceph
> > > > > > which use that flag?
> > > > >
> > > > > As far as I can tell, after fileattr_fill_xflags() call in
> > > > > ioctl_fssetxattr(), the call
> > > > > to ext4_fileattr_set() should behave exactly the same if it came some
> > > > > FS_IOC_FSSETXATTR or from FS_IOC_SETFLAGS.
> > > > > IOW, EXT4_FL_USER_MODIFIABLE mask will still apply.
> > > > >
> > > > > However, unlike the legacy API, we now have an opportunity to deal with
> > > > > EXT4_FL_USER_MODIFIABLE better than this:
> > > > >         /*
> > > > >          * chattr(1) grabs flags via GETFLAGS, modifies the result and
> > > > >          * passes that to SETFLAGS. So we cannot easily make SETFLAGS
> > > > >          * more restrictive than just silently masking off visible but
> > > > >          * not settable flags as we always did.
> > > > >          */
> > > > >
> > > > > if we have the xflags_mask in the new API (not only the xflags) then
> > > > > chattr(1) can set EXT4_FL_USER_MODIFIABLE in xflags_mask
> > > > > ext4_fileattr_set() can verify that
> > > > > (xflags_mask & ~EXT4_FL_USER_MODIFIABLE == 0).
> > > > >
> > > > > However, Pali, this is an important point that your RFC did not follow -
> > > > > AFAICT, the current kernel code of ext4_fileattr_set() and xfs_fileattr_set()
> > > > > (and other fs) does not return any error for unknown xflags, it just
> > > > > ignores them.
> > > > >
> > > > > This is why a new ioctl pair FS_IOC_[GS]ETFSXATTR2 is needed IMO
> > > > > before adding support to ANY new xflags, whether they are mapped to
> > > > > existing flags like in this patch or are completely new xflags.
> > > > >
> > > > > Thanks,
> > > > > Amir.
> > > >
> > > > But xflags_mask is available in this new API. It is available if the
> > > > FS_XFLAG_HASEXTFIELDS flag is set. So I think that the ext4 improvement
> > > > mentioned above can be included into this new API.
> > > >
> > > > Or I'm missing something?
> > >
> > > Yes, you are missing something very fundamental to backward compat API -
> > > You cannot change the existing kernels.
> > >
> > > You should ask yourself one question:
> > > What happens if I execute the old ioctl FS_IOC_FSSETXATTR
> > > on an existing old kernel with the new extended flags?
> >
> > It should ignore all the things it does not know about.
> >
> 
> I don't know about "should" but it certainly does, that's why I was
> wondering if a new fresh ioctl was in order before extending to new flags.

Not all filesystems ignore unknown flags. For example fs/ntfs3/file.c
function ntfs_fileattr_set() already contains:

	if (fileattr_has_fsx(fa))
		return -EOPNOTSUPP;

	if (flags & ~(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_COMPR_FL))
		return -EOPNOTSUPP;

So if it is called with FS_XFLAG_HASEXTFIELDS (required for fsx_xflags2)
then kernel already returns -EOPNOTSUPP.

But some filesystems like ext4 does not contain that
fileattr_has_fsx(fa) check.

> > But the correct usage of FS_IOC_FSSETXATTR is to call
> > FS_IOC_FSGETXATTR to initialise the structure with all the current
> > inode state.
> 
> Yeh, this is how the API is being used by exiting xfs_io chattr.
> It does not mean that this is a good API.
> 
> > In this situation, the fsx.fsx_xflags field needs to
> > return a flag that says "FS_XFLAGS_HAS_WIN_ATTRS" and now userspace
> > knows that it can set/clear the MS windows attr flags.

It does not say which windows attributes. For example UDF filesystem
supports only HIDDEN windows attribute. FAT32 supports more (+ READONLY,
SYSTEM, ARCHIVE), NTFS even more (+ TEMPORARY, OFFLINE, ...). And SMB
and ReFS even more (+ INTEGRITY). And then we have there NFS4 which
supports another subset of those windows attributes.

So how would userspace know if the OFFLINE attribute is supported or
not? OFFLINE is one which more people mentioned in these discussion that
want to see support for it.

That is why I introduced new mask field, which in FS_IOC_FSGETXATTR
ioctl response is filled with supported attributes and each filesystem
will return what it supports.

> > Hence if the
> > filesystem supports windows attributes, we can require them to
> > -support the entire set-.

We cannot because even the most commonly used NTFS filesystem does not
support the entire set.

> >
> > i.e. if an attempt to set a win attr that the filesystem cannot
> > implement (e.g. compression) then it returns an error (-EINVAL),
> > otherwise it will store the attr and perform whatever operation it
> > requires.
> >
> 
> I prefer not to limit the discussion to new "win" attributes,
> especially when discussing COMPR/ENCRYPT flags which are existing
> flags that are also part of the win attributes.

+1

> To put it another way, suppose Pali did not come forward with a patch set
> to add win attribute control to smb, but to add ENCRYPT support to xfs.

I agree. I chose smb in this RFC as an example to demonstrate as much
attribute as possible.

Sure I could choice xfs or udf in RFC to implement just one attribute
(ENCRYPT in xfs, HIDDEN in udf). But such example with just one
attribute would be less useful for demonstration.

> What would have been your prefered way to set the ENCRYPT flag in xfs?
> via FS_IOC_SETFLAGS or by extending FS_IOC_FSSETXATTR?
> and if the latter, then how would xfs_io chattr be expected to know if
> setting the ENCRYPT flag is supported or not?
> 
> > IMO, the whole implementation in the patchset is wrong - there is no
> > need for a new xflags2 field,
> 
> xflags2 is needed to add more bits. I am not following.

Theoretically it is possible to move all bits from xflags2 into xflags.
But if I'm counting correctly then there would be just one or two free
bits in xflags.

> > and there is no need for whacky field
> > masks or anything like that. All it needs is a single bit to
> > indicate if the windows attributes are supported, and they are all
> > implemented as normal FS_XFLAG fields in the fsx_xflags field.
> >

If MS adds 3 new attributes then we cannot add them to fsx_xflags
because all bits of fsx_xflags would be exhausted.

> Sorry, I did not understand your vision about the API.
> On the one hand, you are saying that there is no need for xflags2.
> On the other hand, that new flags should be treated differently than
> old flags (FS_XFLAGS_HAS_WIN_ATTRS).
> Either I did not understand what you mean or the documentation of
> what you are proposing sounds terribly confusing to me.

I understood it as:
- add FS_XFLAGS_HAS_WIN_ATTRS bit into fsx_xflags
- for every windows attribute add FS_XFLAG_<attr>
That is for sure possible but the space of fsx_xflags would be
exhausted.

> > > The answer, to the best of my code emulation abilities is that
> > > old kernel will ignore the new xflags including FS_XFLAG_HASEXTFIELDS
> > > and this is suboptimal, because it would be better for the new chattr tool
> > > to get -EINVAL when trying to set new xflags and mask on an old kernel.
> >
> > What new chattr tool? I would expect that xfs_io -c "chattr ..."
> > will be extended to support all these new fields because that is the
> > historical tool we use for FS_IOC_FS{GS}ETXATTR regression test
> > support in fstests. I would also expect that the e2fsprogs chattr(1)
> > program to grow support for the new FS_XFLAGS bits as well...
> >
> 
> That's exactly what I meant by "new chattr tool".
> when user executes chattr +i or xfs_io -c "chattr +i"
> user does not care which ioctl is used and it is best if both
> utils will support the entire set of modern flags with the new ioctls
> so that eventually (after old fs are deprecated) the old ioctl may also
> be deprecated.
> 
> > > It is true that the new chattr can call the old FS_IOC_FSGETXATTR
> > > ioctl and see that it has no FS_XFLAG_HASEXTFIELDS,
> > > so I agree that a new ioctl is not absolutely necessary,
> > > but I still believe that it is a better API design.
> >
> > This is how FS{GS}ETXATTR interface has always worked. You *must*
> > do a GET before a SET so that the fsx structure has been correctly
> > initialised so the SET operation makes only the exact change being
> > asked for.
> >
> > This makes the -API pair- backwards compatible by allowing struct
> > fsxattr feature bits to be reported in the GET operation. If the
> > feature bit is set, then those optional fields can be set. If the
> > feature bit is not set by the GET operation, then if you try to use
> > it on a SET operation you'll either get an error or it will be
> > silently ignored.

I think that this is perfectly fine, it is possible to implement it.
Personally I do not see a problem with this option, just it needs to be
decided what people wants.

> Yes, I know. I still think that this is a poor API design pattern.

I agree that this is also not my preferred API design. But I also
understand the argument "it is already there, so follow it".

> Imagine that people will be interested to include the fsxattr
> in rsync or such (it has been mentioned in the context of this effort)
> The current API is pretty useless for backup/restore and for
> copying supported attributes across filesystems.

I would not say that it is useless. It is still better than nothing. And
this API also allows to fully implement backup/restore functionality.
Just would require more calls:

    if (ioctl(orig_fd, FS_IOC_FSGETXATTR, &orig_attrs) != 0) goto fail;
    if (ioctl(back_fd, FS_IOC_FSGETXATTR, &back_attrs) != 0) gott fail;
    back_attrs.fsx_xflags = orig_attrs.fsx_xflags
    if (ioctl(back_fd, FS_IOC_FSSETXATTR, &back_attrs) != 0) goto fail;
    if (ioctl(back_fd, FS_IOC_FSGETXATTR, &back_attrs) != 0) goto fail;
    if (back_attrs.fsx_xflags != orig_attrs.fsx_xflags) goto fail;

> BTW, the internal ->fileattr_[gs]et() vfs API was created so that
> overlayfs could copy flags between filesystems on copy-up,
> but right now it only copies common flags.

This can be improved/extended.

> Adding a support mask to the API will allow smarter copy of
> supported attributes between filesystems that have a more
> specific common set of supported flags.
> 
> > > Would love to hear what other fs developers prefer.
> >
> > Do not overcomplicate the problem. Use the interface as intended:
> > GET then SET, and GET returns feature bits in the xflags field to
> > indicate what is valid in the overall struct fsxattr. It's trivial
> > to probe for native fs support of windows attributes like this. It
> > also allows filesystems to be converted one at a time to support the
> > windows attributes (e.g. as they have on-disk format support for
> > them added). Applications like Samba can then switch behaviours
> > based on what they probe from the underlying filesystem...
> >
> 
> OK, so we have two opinions.
> Debating at design time is much better than after API is released...
> 
> I'd still like to hear from other stakeholders before we perpetuate
> the existing design pattern which requires apps to GET before SET
> and treat new (WIN) flags differently than old flags.
> 
> Thanks,
> Amir.

I would like to know how to move forward. If we want to remove mask
fields or let them here. If we want to move all xflags2 to xflags or let
them split. I think that all of those are options which I can implement.
I'm open for any variant.

Just having only one FS_XFLAGS_HAS_WIN_ATTRS flag for determining windows
attribute support is not enough, as it would not say anything useful for
userspace.

