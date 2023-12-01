Return-Path: <linux-fsdevel+bounces-4604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6C2801306
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 19:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3CCEB20BC9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 18:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F9C54BC1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8XQxcls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A2722080;
	Fri,  1 Dec 2023 17:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733D4C433C8;
	Fri,  1 Dec 2023 17:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701452315;
	bh=Dz0B5fxn/oqyZ4YCUdxRSHvWd24ECZxBcKDsdAS+OP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L8XQxclsI+SfocWX7pLQg4yTcgnoloNmJKFzNin3DuEOugJh6FR9HozYzAHV3NTwh
	 +3ZjARg0I6K6FNsw7aF4/04ubGHDL9VORUBV3a5oydbq9Jz6LcqULE6mTTiv2pELXa
	 Qi58qBD5KnMEvY+VEffgOPWBYOuSj8TVjtzBi4YZguMJl9PBI2ueUi9rqiqFIgNIiT
	 qtn4Z/loHTRwmOgKYcpX7SPoBfgz4E5035z6IMV1rEjT3C0jvvYimsU+eUqEraINyZ
	 B2kChFVseZHPmy1CLml9Q0M0DNC/mRetdSHHKQMjdErEtwviYgUDS54kZUsN3VNRvH
	 Te6+37vaI5zGw==
Date: Fri, 1 Dec 2023 11:38:33 -0600
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
Subject: Re: [PATCH 07/16] fs: add inode operations to get/set/remove fscaps
Message-ID: <ZWoaGU6xpF3S793+@do-x1extreme>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-7-da5a26058a5b@kernel.org>
 <20231201-drohnen-ausverkauf-61e5c94364ca@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201-drohnen-ausverkauf-61e5c94364ca@brauner>

On Fri, Dec 01, 2023 at 06:02:55PM +0100, Christian Brauner wrote:
> On Wed, Nov 29, 2023 at 03:50:25PM -0600, Seth Forshee (DigitalOcean) wrote:
> > Add inode operations for getting, setting and removing filesystem
> > capabilities rather than passing around raw xattr data. This provides
> > better type safety for ids contained within xattrs.
> > 
> > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > ---
> >  include/linux/fs.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 98b7a7a8c42e..a0a77f67b999 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2002,6 +2002,11 @@ struct inode_operations {
> >  				     int);
> >  	int (*set_acl)(struct mnt_idmap *, struct dentry *,
> >  		       struct posix_acl *, int);
> > +	int (*get_fscaps)(struct mnt_idmap *, struct dentry *,
> > +			  struct vfs_caps *);
> > +	int (*set_fscaps)(struct mnt_idmap *, struct dentry *,
> > +			  const struct vfs_caps *, int flags);
> 
> If it's really a flags argument, then unsigned int, please,

This is the flags for setxattr, which is an int everywhere. Or almost
everywhere; I just noticed that it is actually an unsigned int in struct
xattr_ctx. But for consistency I think it makes sense to have it be an
int here too. Though maybe naming it setxattr_flags would be helpful for
clarity.

