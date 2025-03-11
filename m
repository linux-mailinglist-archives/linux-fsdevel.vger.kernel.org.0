Return-Path: <linux-fsdevel+bounces-43718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9008A5C997
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 16:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38173B10DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 15:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60758260391;
	Tue, 11 Mar 2025 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruPa3/dj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B372825F964;
	Tue, 11 Mar 2025 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708522; cv=none; b=nMUKUv2O3OWXX/TtR4oiOaG68dj9YCvFjAiBFw2u5h/C98rNC6F5FQFBOiz59WOh6gwf5k1rvBCScr1fttL4EFFTcx6BvpVaxOL4lWUl5plUzjYGX9DdhhlTdL+o1yVED3b21XbxIZKA1TVhm+IKFhAZ3xS6krb9cbYfqMmwTGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708522; c=relaxed/simple;
	bh=1G4VOJML/1ZMCLJfxNfbAz9mTQYKqipKdhXoRlUnunA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMYirhL4TIV/kjcAGLopbhUI+4vvx6F4sJ2ZDL+E+T/Cu1opT9HQT6221UCAQtUzm4CUPsDU3urohpQcpU+5Gqu+6Mgz76l+6dpAE7T9FGg1iphfiYBaQRVlY83U2awe2yNn8mCnZawKmrxq6Vj406K76dTAuSP6EZawfNUla68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruPa3/dj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9B0C4CEE9;
	Tue, 11 Mar 2025 15:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741708522;
	bh=1G4VOJML/1ZMCLJfxNfbAz9mTQYKqipKdhXoRlUnunA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ruPa3/djqKjIM8rFDlTLMPH8u7gMkiXxhowQ3QaSJPGd6WJmeISHbcC1Ej8iYchV1
	 Qt19ooH1Gs+eyghfwg1R9rOgAR/Z9j/JaB6Bo+6TteK4befrabD1feqqAb+oR4KhuI
	 oRqPiES3GfHelfKMEb7APuLjdplG5PiCMy67itar+I52ulZD7FWC0d0ZDHNGbfuwl9
	 ENGVRG8+bN5EB79wLl/3oz0kcCHt6g+aF67F8v1sMxkcrSvVFoAQx81ZfBcX6p5W4r
	 9jBgPWAxi53LVle3c2nImLIV19cqx/mFWjRm8b+ODEPkul/sQKIoPaZgjvNpGoFvDU
	 5iU6ClOmES+Gw==
Date: Tue, 11 Mar 2025 16:55:16 +0100
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ryan Lee <ryan.lee@canonical.com>, Malte =?utf-8?B?U2NocsO2ZGVy?= <malte.schroeder@tnxip.de>, 
	linux-security-module@vger.kernel.org, apparmor <apparmor@lists.ubuntu.com>, linux-efi@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, "jk@ozlabs.org" <jk@ozlabs.org>, linux-fsdevel@vger.kernel.org
Subject: Re: apparmor NULL pointer dereference on resume [efivarfs]
Message-ID: <20250311-trunk-farben-fe36bebe233a@brauner>
References: <e54e6a2f-1178-4980-b771-4d9bafc2aa47@tnxip.de>
 <CAKCV-6s3_7RzDfo_yGQj9ndf4ZKw_Awf8oNc6pYKXgDTxiDfjw@mail.gmail.com>
 <465d1d23-3b36-490e-b0dd-74889d17fa4c@tnxip.de>
 <CAKCV-6uuKo=RK37GhM+fV90yV9sxBFqj0s07EPSoHwVZdDWa3A@mail.gmail.com>
 <ea97dd9d1cb33e28d6ca830b6bff0c2ece374dbe.camel@HansenPartnership.com>
 <CAMj1kXGLXbki1jezLgzDGE7VX8mNmHKQ3VLQPq=j5uAyrSomvQ@mail.gmail.com>
 <20250311-visite-rastplatz-d1fdb223dc10@brauner>
 <814a257530ad5e8107ce5f48318ab43a3ef1f783.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <814a257530ad5e8107ce5f48318ab43a3ef1f783.camel@HansenPartnership.com>

On Tue, Mar 11, 2025 at 09:01:36AM -0400, James Bottomley wrote:
> On Tue, 2025-03-11 at 09:45 +0100, Christian Brauner wrote:
> > On Tue, Mar 11, 2025 at 08:16:34AM +0100, Ard Biesheuvel wrote:
> > > (cc Al Viro)
> > > 
> > > On Mon, 10 Mar 2025 at 22:49, James Bottomley
> > > <James.Bottomley@hansenpartnership.com> wrote:
> [...]
> > > > The problem comes down to the superblock functions not being able
> > > > to get the struct vfsmount for the superblock (because it isn't
> > > > even allocated until after they've all been called).  The
> > > > assumption I was operating under was that provided I added
> > > > O_NOATIME to prevent the parent directory being updated, passing
> > > > in a NULL mnt for the purposes of iterating the directory dentry
> > > > was safe.  What apparmour is trying to do is look up the idmap
> > > > for the mount point to do one of its checks.
> > > > 
> > > > There are two ways of fixing this that I can think of.  One would
> > > > be exporting a function that lets me dig the vfsmount out of
> > > > s_mounts and use that (it's well hidden in the internals of
> > > > fs/mount.h, so I suspect this might not be very acceptable) or to
> > > > get mnt_idmap to return
> > 
> > Nope, please don't.
> > 
> > > > &nop_mnt_idmap if the passed in mnt is NULL.  I'd lean towards
> > > > the latter, but I'm cc'ing fsdevel to see what others think.
> > 
> > A struct path with mount NULL and dentry != NULL is guaranteed to bit
> > us in the ass in other places. That's the bug.
> > 
> > > > 
> > > 
> > > 
> > > Al spotted the same issue based on a syzbot report [0]
> > > 
> > > [0] https://lore.kernel.org/all/20250310235831.GL2023217@ZenIV/
> > 
> > efivars as written only has a single global superblock and it doesn't
> > support idmapped mounts and I don't see why it ever would.
> 
> So that's not quite true: efivarfs currently supports uid and gid
> mapping as mount options, which certainly looks like they were designed
> to allow a second mount in a user directory.  I've no idea what the
> actual use case for this is, but if I go for a single superblock, any
> reconfigure with new uid/gid would become globally effective (change
> every current mount) because they're stored in the superblock
> information.
> 
> So what is the use case for this uid/gid parameter?  If no-one can
> remember and no-one actually uses it, perhaps the whole config path can
> be simplified by getting rid of the options?  Even if there is a use
> case, if it's single mount only then we can still go with a global
> superblock.

So efivarfs uses get_tree_single(). That means that only a single
superblock of the filesystem type efivarfs can ever exist on the system.

If efivars is mounted multiple times it will be the exact same
superblock that's used. IOW, mounting efivars multiple times is akin to
a bind-mount. It would be a bit ugly but it could be done by making sure
that any uid/gid changes are reflected. But see below.

> 
> > But since efivars does only ever have a single global superblock, one
> > possibility is to an internal superblock that always exits and is
> > resurfaced whenever userspace mounts efivarfs. That's essentially the
> > devtmpfs model.
> > 
> > Then you can stash:
> > 
> > static struct vfsmount *efivarfs_mnt;
> > 
> > globally and use that in efivarfs_pm_notify() to fill in struct path.
> 
> I didn't see devtmpfs when looking for examples, since it's hiding
> outside of the fs/ directory.  However, it does seem to be a bit legacy
> nasty as an example to copy.  However, I get the basics: we'd
> instantiate the mnt and superblock on init (stashing mnt in the sfi so
> the notifier gets it).  Then we can do the variable population on
> reconfigure, just in case an EFI system doesn't want to mount efivarfs
> to save memory.
> 
> I can code that up if I can get an answer to the uid/gid parameter
> question above.

I have some questions. efivarfs registers efivarfs_pm_notify even before
a superblock exists in efivarfs_init_fs_context(). That's called during
fd_context = fsopen("efivarfs") before a superblock even exists:

(1) Is it guaranteed that efivarfs_pm_notify() is only called once a
    superblock exists?

(2) Is it guaranteed that efivarfs_pm_notify() is only called when and
    while a mount for the superblock exists?

If the question to either one of those is "no" then the global
vfsmount hack will not help.

From reading efivarfs_pm_notify() it looks like the answer to (1) is
"yes" because you're dereferencing sfi->sb->s_root in
efivarfs_pm_notify().

But I'm not at all certain that (2) isn't a "no" and that
efivarfs_pm_notify() can be called before a mount exists. IOW, once
fsconfig(FSCONFIG_CMD_CREATE) is called the notifier seems ready and
registered but userspace isn't forced to call fsmount(fd_fs) at all.

They could just not to do it for whatever reason but the notifier should
already be able to run.

Another question is whether the superblock can be freed while
efivarfs_pm_notify() is running? I think that can't happen because
blocking_notifier_chain_unregister(&efivar_ops_nh, &sfi->nb) will block
in efivarfs_kill_sb() until all outstanding calls to
efivarfs_pm_notify() are finished?

If (2) isn't guranteed then efivarfs_pm_notify() needs to be rewritten
without relying on files because there's no guarantee that a mount
exists at all.

