Return-Path: <linux-fsdevel+bounces-13485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4701B870591
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 16:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7061F25DBA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 15:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C760487A7;
	Mon,  4 Mar 2024 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmjMy/Dg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2584087C;
	Mon,  4 Mar 2024 15:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709566318; cv=none; b=skWdxjF0tQ3HGOEBqzT93ZoMH/c2GdCyQX7frlSLViLMJo8hxTaMN5UMPuokwozz1z/iMaeyHDl6w/+0P51/WQNWsnJRgYTRRMsWCZmjfqLwaV6RjoZCoMuuJEYqgCQfiPxD/uqEUadlZvV/a2qe2ufU93vXaRAhxn5AboUAhcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709566318; c=relaxed/simple;
	bh=Z/JTec2Ta53BlWf6X0Xj/wpGDySb1P2Q5y4tFWI7aX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8PJl0nzKythq0z23seqqfSBS/022Q2xwvc3VsX/udMahonuXvf7t4YvF1imxmdIdoEpTuDqvG3uXLRQJPqFA4n+0Hpvak/qQHBM4IdCUEZFopV/Yrlxy8IqdFWhZTlXz2sBKLeslCjL7+RkARKsH1E6Zj1BExkXUQoEHX1jbeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmjMy/Dg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6797C433F1;
	Mon,  4 Mar 2024 15:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709566318;
	bh=Z/JTec2Ta53BlWf6X0Xj/wpGDySb1P2Q5y4tFWI7aX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VmjMy/DgMXc5ruHQ8hi+UFjLUo8Q2dD6TFnvQfCxkjlhgJTayDjeNijl0xQNVhhvd
	 lHQgHoL1+fr0XgBm7WeeMUW/4TdydxQ1Lg5bQBnZLWJsMDDbqFz2z9w6Ibdb8dULSK
	 hlz8JxYar7wbKvhq+Ek/qf+IDduvrsSbPcNxMyxZqUoyJjAXxY8jYblnefJslS6G8b
	 5PLeGYPTkEzXdX/vC1aPQwpYHYewCRlMevG8/9b3pIe+8WGR+DefMQLYgnTvcJEXsd
	 UMgOzjczHMBFclkjLTF3CJIHTdJdKR04xXWZ4zs9vvftqDkZbcValu+bz47D7c5jEU
	 bPCvFkfbhaHng==
Date: Mon, 4 Mar 2024 09:31:56 -0600
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
Message-ID: <ZeXpbOsdRTbLsYe9@do-x1extreme>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-24-3039364623bd@kernel.org>
 <dcbd9e7869d2fcce69546b53851d694b8ebad54e.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcbd9e7869d2fcce69546b53851d694b8ebad54e.camel@huaweicloud.com>

On Mon, Mar 04, 2024 at 11:19:54AM +0100, Roberto Sassu wrote:
> On Wed, 2024-02-21 at 15:24 -0600, Seth Forshee (DigitalOcean) wrote:
> > Use the vfs interfaces for fetching file capabilities for killpriv
> > checks and from get_vfs_caps_from_disk(). While there, update the
> > kerneldoc for get_vfs_caps_from_disk() to explain how it is different
> > from vfs_get_fscaps_nosec().
> > 
> > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > ---
> >  security/commoncap.c | 30 +++++++++++++-----------------
> >  1 file changed, 13 insertions(+), 17 deletions(-)
> > 
> > diff --git a/security/commoncap.c b/security/commoncap.c
> > index a0ff7e6092e0..751bb26a06a6 100644
> > --- a/security/commoncap.c
> > +++ b/security/commoncap.c
> > @@ -296,11 +296,12 @@ int cap_capset(struct cred *new,
> >   */
> >  int cap_inode_need_killpriv(struct dentry *dentry)
> >  {
> > -	struct inode *inode = d_backing_inode(dentry);
> > +	struct vfs_caps caps;
> >  	int error;
> >  
> > -	error = __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, NULL, 0);
> > -	return error > 0;
> > +	/* Use nop_mnt_idmap for no mapping here as mapping is unimportant */
> > +	error = vfs_get_fscaps_nosec(&nop_mnt_idmap, dentry, &caps);
> > +	return error == 0;
> >  }
> >  
> >  /**
> > @@ -323,7 +324,7 @@ int cap_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry)
> >  {
> >  	int error;
> >  
> > -	error = __vfs_removexattr(idmap, dentry, XATTR_NAME_CAPS);
> > +	error = vfs_remove_fscaps_nosec(idmap, dentry);
> 
> Uhm, I see that the change is logically correct... but the original
> code was not correct, since the EVM post hook is not called (thus the
> HMAC is broken, or an xattr change is allowed on a portable signature
> which should be not).
> 
> For completeness, the xattr change on a portable signature should not
> happen in the first place, so cap_inode_killpriv() would not be called.
> However, since EVM allows same value change, we are here.

I really don't understand EVM that well and am pretty hesitant to try an
change any of the logic around it. But I'll hazard a thought: should EVM
have a inode_need_killpriv hook which returns an error in this
situation?

