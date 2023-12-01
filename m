Return-Path: <linux-fsdevel+bounces-4607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D419580130A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 19:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16F8FB20CDA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 18:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC955102E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 18:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGaKbsUp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B144EB3C;
	Fri,  1 Dec 2023 18:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85ACAC433C7;
	Fri,  1 Dec 2023 18:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701454681;
	bh=ujCjp75X8yi+WvQp0VZeg+iQb5i3JpQWywg/I5QIQBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZGaKbsUpWLmQ+x99zErN9VEnQZkJDK2RXwFBwKt9EkRarBXR4Eq+oRs9CTm7VRogN
	 7CXUVH2iRK5JimTZJSit/XUgSn0e4pVksPYOo8ft0SLJf16t1yF6roxVv+Zg+CLbIa
	 sSjydc7rreEqs7iTUfOC8jFCVWVmFCYl5UURZVlCmu9pQ0TJbc5ezvtkBajPAVJGWV
	 stUE1Q5SbW+VbUiicRRVuxYvkTKpQattI4R2PoYhqSsmuc+paipASOfjZQuVQOGOBE
	 x0Xa2wjFsNiGAdD11zOBFpltnEO56LzG+qJQ3G4KK1C9ngKquLfHNgx7kXYyxDh8S4
	 vyLb93E9AgRtw==
Date: Fri, 1 Dec 2023 12:18:00 -0600
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, audit@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 09/16] fs: add vfs_set_fscaps()
Message-ID: <ZWojWE7/HRnByRb+@do-x1extreme>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-9-da5a26058a5b@kernel.org>
 <20231201-reintreten-gehalt-435a960f80ed@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201-reintreten-gehalt-435a960f80ed@brauner>

On Fri, Dec 01, 2023 at 06:39:18PM +0100, Christian Brauner wrote:
> > +/**
> > + * vfs_set_fscaps - set filesystem capabilities
> > + * @idmap: idmap of the mount the inode was found from
> > + * @dentry: the dentry on which to set filesystem capabilities
> > + * @caps: the filesystem capabilities to be written
> > + * @flags: setxattr flags to use when writing the capabilities xattr
> > + *
> > + * This function writes the supplied filesystem capabilities to the dentry.
> > + *
> > + * Return: 0 on success, a negative errno on error.
> > + */
> > +int vfs_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> > +		   const struct vfs_caps *caps, int flags)
> > +{
> > +	struct inode *inode = d_inode(dentry);
> > +	struct inode *delegated_inode = NULL;
> > +	struct vfs_ns_cap_data nscaps;
> > +	int size, error;
> > +
> > +	/*
> > +	 * Unfortunately EVM wants to have the raw xattr value to compare to
> > +	 * the on-disk version, so we need to pass the raw xattr to the
> > +	 * security hooks. But we also want to do security checks before
> > +	 * breaking leases, so that means a conversion to the raw xattr here
> > +	 * which will usually be reduntant with the conversion we do for
> > +	 * writing the xattr to disk.
> > +	 */
> > +	size = vfs_caps_to_xattr(idmap, i_user_ns(inode), caps, &nscaps,
> > +				 sizeof(nscaps));
> > +	if (size < 0)
> > +		return size;
> 
> Oh right, I remember that. Slight eyeroll. See below though...
> 
> > +
> > +retry_deleg:
> > +	inode_lock(inode);
> > +
> > +	error = xattr_permission(idmap, inode, XATTR_NAME_CAPS, MAY_WRITE);
> > +	if (error)
> > +		goto out_inode_unlock;
> > +	error = security_inode_setxattr(idmap, dentry, XATTR_NAME_CAPS, &nscaps,
> > +					size, flags);
> > +	if (error)
> > +		goto out_inode_unlock;
> 
> For posix acls I added dedicated security hooks that take the struct
> posix_acl stuff and then plumb that down into the security modules. You
> could do the same thing here and then just force EVM and others to do
> their own conversion from in-kernel to xattr format, instead of forcing
> the VFS to do this.
> 
> Because right now we make everyone pay the price all the time when
> really EVM should pay that price and this whole unpleasantness.

Good point, I'll do that.

> 
> > +
> > +	error = try_break_deleg(inode, &delegated_inode);
> > +	if (error)
> > +		goto out_inode_unlock;
> > +
> > +	if (inode->i_opflags & IOP_XATTR) {
> 
> So I'm trying to remember the details how I did this for POSIX ACLs in
> commit e499214ce3ef ("acl: don't depend on IOP_XATTR"). I think what you
> did here is correct because you need to have an xattr handler for
> fscaps currently. IOW, it isn't purely based on inode operations.
> 
> And here starts the hate mail in so far as you'll hate me for asking
> this:
> 
> I think I asked this before when we talked about this but how feasible
> would it be to move fscaps completely off of xattr handlers and purely
> on inode operations for all filesystems?
> 
> Yes, that's a fairly large patchset but it would also be a pretty good
> win because we avoid munging this from inode operations through xattr
> handlers again which seems a bit ugly and what we really wanted to
> avoid desperately with POSIX ACLs.
> 
> If this is feasible and you'd be up for it I wouldn't even mind doing
> that in two steps. IOW, merge something like this first and them move
> everyone off of their individual xattr handlers.
> 
> Could you quickly remind me whether there would be any issues with this?

It's certainly possible to do this. There wouldn't be any issues per se,
but there are some tradoffs to consider.

First, it's really only overlayfs that needs special handling. It seems
pretty unfortunate to make every filesystem provide its own
implementations which are virtually identical, which is what we'd need
to do if we want to completely avoid the xattr handlers. But we could
still provide a generic implementation that uses only
__vfs_{get,set}xattr(), and most filesystems could use those in their
inode ops. How does that sound?

The other drawback I see is needing to duplicate logic from the
{get,set}xattr codepaths into the fscaps codepaths and maintain them in
parallel. I was trying to avoid that as much as possible, but in the end
I had to duplicate some of the logic anyway. And as Amir pointed out I
did miss some things I needed to duplicate from the setxattr logic, so I
already need to revisit that code and probably pull in more of the
setxattr logic, so there may not be as much benefit here as I'd
originally hoped.

