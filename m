Return-Path: <linux-fsdevel+bounces-13642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7288187251B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 18:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269151F279E2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 17:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6706E14AA7;
	Tue,  5 Mar 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSmmtBeD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70D8DF5B;
	Tue,  5 Mar 2024 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658182; cv=none; b=ZbbHYkWnC1XvwIw1/g9YTSutbrsbcU7uLxMi9lrYqo13qfhvfkVzeDedlKexNTQUo/VOeviwLrDcxssHbXRA+HwRJ6RaknFJUw/ZtabXY4zOhgD7LxvVySBC/9ULM+pDC0gUmud/b9N94C9U+flIWkJCU/T/PN40tJWSqSk5smU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658182; c=relaxed/simple;
	bh=ojCQANAjYBZG0ygQ8b19OkNar0PVfA55/UxSz2wSlhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/eCMM0GN0zdRVvGOImMB89g3dR9/U0IoGb4PBSV5y4BniIvFOdlepI0yunp7La7fArYQ0/Y5LBFMtp65em8atAC1hnshLXpF98y7wOqajyvMJpTSmrLX2q2OBkfESUmFJKv1NyBwQ5Sm7ye6wh1Ca74trCP8d6B2aZnPzuh340=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSmmtBeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10016C433F1;
	Tue,  5 Mar 2024 17:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709658182;
	bh=ojCQANAjYBZG0ygQ8b19OkNar0PVfA55/UxSz2wSlhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZSmmtBeDEMakkfa1ODU71ZTSLmsc/DoJTzjopXItAKLAiBMhT93DlgDK+5ibZRud5
	 fwa98ZPN3/LZo7+zlG/b8JNkGckWBfHUV1Xr0HvcBdOBS1qnmYncMv/0gsDEf3wd2u
	 Y3RmNermB9Xs3epNvE5apjAhkkGHnHTnISfyDKw+gZEKK01AzUirT/6ZnqPpXB2SBh
	 yPezh8Wqk7J/t8LnzVGh/sI+T3Q5FK4AYYbe0+d1tfp4mb2DoIHbg8+mprPZjIndRo
	 iZOc3rjn+eCJwgPe/3gUv/kggplO3wPfEgm6hh6Ljkx3OZerjJJRMlTgsJpVS3qOQN
	 mPd4Ai1Gajgxw==
Date: Tue, 5 Mar 2024 11:03:01 -0600
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>,
	Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	James Morris <jmorris@namei.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, audit@vger.kernel.org,
	selinux@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 24/25] commoncap: use vfs fscaps interfaces
Message-ID: <ZedQRThbc60h+VoA@do-x1extreme>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-24-3039364623bd@kernel.org>
 <dcbd9e7869d2fcce69546b53851d694b8ebad54e.camel@huaweicloud.com>
 <ZeXpbOsdRTbLsYe9@do-x1extreme>
 <a7124afa6bed2fcadcb66efa08e256828cd6f8ab.camel@huaweicloud.com>
 <ZeX9MRhU/EGhHkCY@do-x1extreme>
 <20240305-fachjargon-abmontieren-75b1d6c67a83@brauner>
 <3098aef3e5f924e5717b4ba4a34817d9f22ec479.camel@huaweicloud.com>
 <20240305-zyklisch-halluzinationen-98b782666cf8@brauner>
 <133a912d05fb0790ab3672103a21a4f8bfb70405.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <133a912d05fb0790ab3672103a21a4f8bfb70405.camel@huaweicloud.com>

On Tue, Mar 05, 2024 at 05:35:11PM +0100, Roberto Sassu wrote:
> On Tue, 2024-03-05 at 17:26 +0100, Christian Brauner wrote:
> > On Tue, Mar 05, 2024 at 01:46:56PM +0100, Roberto Sassu wrote:
> > > On Tue, 2024-03-05 at 10:12 +0100, Christian Brauner wrote:
> > > > On Mon, Mar 04, 2024 at 10:56:17AM -0600, Seth Forshee (DigitalOcean) wrote:
> > > > > On Mon, Mar 04, 2024 at 05:17:57PM +0100, Roberto Sassu wrote:
> > > > > > On Mon, 2024-03-04 at 09:31 -0600, Seth Forshee (DigitalOcean) wrote:
> > > > > > > On Mon, Mar 04, 2024 at 11:19:54AM +0100, Roberto Sassu wrote:
> > > > > > > > On Wed, 2024-02-21 at 15:24 -0600, Seth Forshee (DigitalOcean) wrote:
> > > > > > > > > Use the vfs interfaces for fetching file capabilities for killpriv
> > > > > > > > > checks and from get_vfs_caps_from_disk(). While there, update the
> > > > > > > > > kerneldoc for get_vfs_caps_from_disk() to explain how it is different
> > > > > > > > > from vfs_get_fscaps_nosec().
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > > > > > > > > ---
> > > > > > > > >  security/commoncap.c | 30 +++++++++++++-----------------
> > > > > > > > >  1 file changed, 13 insertions(+), 17 deletions(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/security/commoncap.c b/security/commoncap.c
> > > > > > > > > index a0ff7e6092e0..751bb26a06a6 100644
> > > > > > > > > --- a/security/commoncap.c
> > > > > > > > > +++ b/security/commoncap.c
> > > > > > > > > @@ -296,11 +296,12 @@ int cap_capset(struct cred *new,
> > > > > > > > >   */
> > > > > > > > >  int cap_inode_need_killpriv(struct dentry *dentry)
> > > > > > > > >  {
> > > > > > > > > -	struct inode *inode = d_backing_inode(dentry);
> > > > > > > > > +	struct vfs_caps caps;
> > > > > > > > >  	int error;
> > > > > > > > >  
> > > > > > > > > -	error = __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, NULL, 0);
> > > > > > > > > -	return error > 0;
> > > > > > > > > +	/* Use nop_mnt_idmap for no mapping here as mapping is unimportant */
> > > > > > > > > +	error = vfs_get_fscaps_nosec(&nop_mnt_idmap, dentry, &caps);
> > > > > > > > > +	return error == 0;
> > > > > > > > >  }
> > > > > > > > >  
> > > > > > > > >  /**
> > > > > > > > > @@ -323,7 +324,7 @@ int cap_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry)
> > > > > > > > >  {
> > > > > > > > >  	int error;
> > > > > > > > >  
> > > > > > > > > -	error = __vfs_removexattr(idmap, dentry, XATTR_NAME_CAPS);
> > > > > > > > > +	error = vfs_remove_fscaps_nosec(idmap, dentry);
> > > > > > > > 
> > > > > > > > Uhm, I see that the change is logically correct... but the original
> > > > > > > > code was not correct, since the EVM post hook is not called (thus the
> > > > > > > > HMAC is broken, or an xattr change is allowed on a portable signature
> > > > > > > > which should be not).
> > > > > > > > 
> > > > > > > > For completeness, the xattr change on a portable signature should not
> > > > > > > > happen in the first place, so cap_inode_killpriv() would not be called.
> > > > > > > > However, since EVM allows same value change, we are here.
> > > > > > > 
> > > > > > > I really don't understand EVM that well and am pretty hesitant to try an
> > > > > > > change any of the logic around it. But I'll hazard a thought: should EVM
> > > > > > > have a inode_need_killpriv hook which returns an error in this
> > > > > > > situation?
> > > > > > 
> > > > > > Uhm, I think it would not work without modifying
> > > > > > security_inode_need_killpriv() and the hook definition.
> > > > > > 
> > > > > > Since cap_inode_need_killpriv() returns 1, the loop stops and EVM would
> > > > > > not be invoked. We would need to continue the loop and let EVM know
> > > > > > what is the current return value. Then EVM can reject the change.
> > > > > > 
> > > > > > An alternative way would be to detect that actually we are setting the
> > > > > > same value for inode metadata, and maybe not returning 1 from
> > > > > > cap_inode_need_killpriv().
> > > > > > 
> > > > > > I would prefer the second, since EVM allows same value change and we
> > > > > > would have an exception if there are fscaps.
> > > > > > 
> > > > > > This solves only the case of portable signatures. We would need to
> > > > > > change cap_inode_need_killpriv() anyway to update the HMAC for mutable
> > > > > > files.
> > > > > 
> > > > > I see. In any case this sounds like a matter for a separate patch
> > > > > series.
> > > > 
> > > > Agreed.
> > > 
> > > Christian, how realistic is that we don't kill priv if we are setting
> > > the same owner?
> > 
> > Uhm, I would need to see the wider context of the proposed change. But
> > iiuc then you would be comparing current and new fscaps and if they are
> > identical you don't kill privs? I think that would work. But again, I
> > would need to see the actual context/change to say something meaningful.
> 
> Ok, basically a software vendor can ship binaries with a signature over
> file metadata, including UID/GID, etc.
> 
> A system can verify the signature through the public key of the
> software vendor.
> 
> The problem is if someone (or even tar), executes chown on that binary,
> fscaps are lost. Thus, signature verification will fail from now on.
> 
> EVM locks file metadata as soon as signature verification succeeds
> (i.e. metadata are the same of those signed by the software vendor).
> 
> EVM locking works if someone is trying to set different metadata. But,
> if I try to chown to the same owner as the one stored in the inode, EVM
> allows it but the capability LSM removes security.capability, thus
> invalidating the signature.
> 
> At least, it would be desirable that security.capability is not removed
> when setting the same owner. If the owner is different, EVM will handle
> that.

When you say EVM "locks" file metadata, does that mean it prevents
modification to file metadata?

What about changes to file data? This will also result in removing
fscaps xattrs. Does EVM also block changes to file data when signature
verification succeeds?

