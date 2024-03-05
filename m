Return-Path: <linux-fsdevel+bounces-13638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C850887244F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 17:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2855AB24C0A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 16:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5140412D1E7;
	Tue,  5 Mar 2024 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCLAEoGx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9322C128374;
	Tue,  5 Mar 2024 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655976; cv=none; b=tLQb6OR32SGRSRbNL+Hcrpz6XiQflvAIyZUCTOQCIf2TDwdr4DwiP7UODbY4HNfk1zxQ2rBRe0+HingJE7i6COXog1D7p6xfMquaa2/Mwu/q7VIUwihKXFkDDW3ubhD9JSX1vkeGOPrPcEe/c4ZLMA3Uk+r4BWPFOw/6bVsjjTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655976; c=relaxed/simple;
	bh=rJDCbsppxsCZ/6gOdhGNkAd2bfvRU7iE7Ysglyc+jqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tL5PWemt8F36jDiMAtRRraxUQRq61Ts5un1xrfMXeTTL3jWbQ5VwscrAMWPcmwuZ8ohUAAXRx9QqxFafzT5ec+uONlH3ZRLvwsfP2/XBWeIJ0EfH3S6AEd9Yb7k5JzG01OonA78SbP5voYwOgWbVEtqUexRh7KrPY9r1+W7iSpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCLAEoGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE78C43390;
	Tue,  5 Mar 2024 16:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709655976;
	bh=rJDCbsppxsCZ/6gOdhGNkAd2bfvRU7iE7Ysglyc+jqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mCLAEoGxZC5006mHitJaoWtcNzJEIHdHVyzoN4RrD2KkYX82tM0YjFhucIxLOnwf+
	 hEbkkIh3icM7xU2GQ6hSzfWnuB8lmInH+goeDYWbitDBOVG+8NFpMYyvgLST0sGqd6
	 ZYfFGVSaUp/2ITdxhKmnshuznERdD47lSMOomdXMtv6/o7cMEYTlEKvS9mYgXJfylJ
	 QZU39f1XRVlKhQepG1YHi/6JSsIYzCBGfdcmlimq3k88R0HjtUeTmjyaRmLIJaCo2b
	 oXdnxvxOZUTCdi6kxcVU/YrQgedb+YZr7SPnX7kNkczD+9BqpHQicydKkG3tWmjMcO
	 93N6jg6WAXBmQ==
Date: Tue, 5 Mar 2024 17:26:08 +0100
From: Christian Brauner <brauner@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>, 
	Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
	James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, selinux@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 24/25] commoncap: use vfs fscaps interfaces
Message-ID: <20240305-zyklisch-halluzinationen-98b782666cf8@brauner>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-24-3039364623bd@kernel.org>
 <dcbd9e7869d2fcce69546b53851d694b8ebad54e.camel@huaweicloud.com>
 <ZeXpbOsdRTbLsYe9@do-x1extreme>
 <a7124afa6bed2fcadcb66efa08e256828cd6f8ab.camel@huaweicloud.com>
 <ZeX9MRhU/EGhHkCY@do-x1extreme>
 <20240305-fachjargon-abmontieren-75b1d6c67a83@brauner>
 <3098aef3e5f924e5717b4ba4a34817d9f22ec479.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3098aef3e5f924e5717b4ba4a34817d9f22ec479.camel@huaweicloud.com>

On Tue, Mar 05, 2024 at 01:46:56PM +0100, Roberto Sassu wrote:
> On Tue, 2024-03-05 at 10:12 +0100, Christian Brauner wrote:
> > On Mon, Mar 04, 2024 at 10:56:17AM -0600, Seth Forshee (DigitalOcean) wrote:
> > > On Mon, Mar 04, 2024 at 05:17:57PM +0100, Roberto Sassu wrote:
> > > > On Mon, 2024-03-04 at 09:31 -0600, Seth Forshee (DigitalOcean) wrote:
> > > > > On Mon, Mar 04, 2024 at 11:19:54AM +0100, Roberto Sassu wrote:
> > > > > > On Wed, 2024-02-21 at 15:24 -0600, Seth Forshee (DigitalOcean) wrote:
> > > > > > > Use the vfs interfaces for fetching file capabilities for killpriv
> > > > > > > checks and from get_vfs_caps_from_disk(). While there, update the
> > > > > > > kerneldoc for get_vfs_caps_from_disk() to explain how it is different
> > > > > > > from vfs_get_fscaps_nosec().
> > > > > > > 
> > > > > > > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > > > > > > ---
> > > > > > >  security/commoncap.c | 30 +++++++++++++-----------------
> > > > > > >  1 file changed, 13 insertions(+), 17 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/security/commoncap.c b/security/commoncap.c
> > > > > > > index a0ff7e6092e0..751bb26a06a6 100644
> > > > > > > --- a/security/commoncap.c
> > > > > > > +++ b/security/commoncap.c
> > > > > > > @@ -296,11 +296,12 @@ int cap_capset(struct cred *new,
> > > > > > >   */
> > > > > > >  int cap_inode_need_killpriv(struct dentry *dentry)
> > > > > > >  {
> > > > > > > -	struct inode *inode = d_backing_inode(dentry);
> > > > > > > +	struct vfs_caps caps;
> > > > > > >  	int error;
> > > > > > >  
> > > > > > > -	error = __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, NULL, 0);
> > > > > > > -	return error > 0;
> > > > > > > +	/* Use nop_mnt_idmap for no mapping here as mapping is unimportant */
> > > > > > > +	error = vfs_get_fscaps_nosec(&nop_mnt_idmap, dentry, &caps);
> > > > > > > +	return error == 0;
> > > > > > >  }
> > > > > > >  
> > > > > > >  /**
> > > > > > > @@ -323,7 +324,7 @@ int cap_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry)
> > > > > > >  {
> > > > > > >  	int error;
> > > > > > >  
> > > > > > > -	error = __vfs_removexattr(idmap, dentry, XATTR_NAME_CAPS);
> > > > > > > +	error = vfs_remove_fscaps_nosec(idmap, dentry);
> > > > > > 
> > > > > > Uhm, I see that the change is logically correct... but the original
> > > > > > code was not correct, since the EVM post hook is not called (thus the
> > > > > > HMAC is broken, or an xattr change is allowed on a portable signature
> > > > > > which should be not).
> > > > > > 
> > > > > > For completeness, the xattr change on a portable signature should not
> > > > > > happen in the first place, so cap_inode_killpriv() would not be called.
> > > > > > However, since EVM allows same value change, we are here.
> > > > > 
> > > > > I really don't understand EVM that well and am pretty hesitant to try an
> > > > > change any of the logic around it. But I'll hazard a thought: should EVM
> > > > > have a inode_need_killpriv hook which returns an error in this
> > > > > situation?
> > > > 
> > > > Uhm, I think it would not work without modifying
> > > > security_inode_need_killpriv() and the hook definition.
> > > > 
> > > > Since cap_inode_need_killpriv() returns 1, the loop stops and EVM would
> > > > not be invoked. We would need to continue the loop and let EVM know
> > > > what is the current return value. Then EVM can reject the change.
> > > > 
> > > > An alternative way would be to detect that actually we are setting the
> > > > same value for inode metadata, and maybe not returning 1 from
> > > > cap_inode_need_killpriv().
> > > > 
> > > > I would prefer the second, since EVM allows same value change and we
> > > > would have an exception if there are fscaps.
> > > > 
> > > > This solves only the case of portable signatures. We would need to
> > > > change cap_inode_need_killpriv() anyway to update the HMAC for mutable
> > > > files.
> > > 
> > > I see. In any case this sounds like a matter for a separate patch
> > > series.
> > 
> > Agreed.
> 
> Christian, how realistic is that we don't kill priv if we are setting
> the same owner?

Uhm, I would need to see the wider context of the proposed change. But
iiuc then you would be comparing current and new fscaps and if they are
identical you don't kill privs? I think that would work. But again, I
would need to see the actual context/change to say something meaningful.

