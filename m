Return-Path: <linux-fsdevel+bounces-4875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F158054FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 13:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383E41C20E5A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 12:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9596156476
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3r7E0Ft"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA2357866;
	Tue,  5 Dec 2023 11:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414B1C433C8;
	Tue,  5 Dec 2023 11:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701777034;
	bh=1vi7lpWvyIlRPEOS8id0JlbcXrkUDYmCKkyVbkLEO/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3r7E0Ft/sNzRLXx9KPMN7wMK8H8PLP4BMf4GbJ85C0HONRDECADPNUDARiPaxc9J
	 9xmUAysv2FKUw4XeM/ClU/Y8ooaDZxUFAnzPn8c/w1s/gbXMDZmWWnIeP824av6jyb
	 AwW5ZLSKUow+R8KxgaBbbmYTJw8Vp9gLcJYg/v6I9XmArk3eooyu7Wn0B7lIKw33GM
	 shZiD1i8sf8dLaSUExtpjIcrnSrIrrl17uN7+qP40f+Y0Hr+vaJVqKjzWb7hg0FtHW
	 3mr1JsR2rqGHtfmtEjLIlAh4vKrVsYfBiHy6mCQkU2iKv0h0TPLsax/oq/DdQSjB8I
	 1mys7ZBCphkmQ==
Date: Tue, 5 Dec 2023 12:50:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, audit@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 07/16] fs: add inode operations to get/set/remove fscaps
Message-ID: <20231205-frettchen-weltoffen-16e63df530a7@brauner>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-7-da5a26058a5b@kernel.org>
 <20231201-drohnen-ausverkauf-61e5c94364ca@brauner>
 <ZWoaGU6xpF3S793+@do-x1extreme>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWoaGU6xpF3S793+@do-x1extreme>

On Fri, Dec 01, 2023 at 11:38:33AM -0600, Seth Forshee (DigitalOcean) wrote:
> On Fri, Dec 01, 2023 at 06:02:55PM +0100, Christian Brauner wrote:
> > On Wed, Nov 29, 2023 at 03:50:25PM -0600, Seth Forshee (DigitalOcean) wrote:
> > > Add inode operations for getting, setting and removing filesystem
> > > capabilities rather than passing around raw xattr data. This provides
> > > better type safety for ids contained within xattrs.
> > > 
> > > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > > ---
> > >  include/linux/fs.h | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index 98b7a7a8c42e..a0a77f67b999 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -2002,6 +2002,11 @@ struct inode_operations {
> > >  				     int);
> > >  	int (*set_acl)(struct mnt_idmap *, struct dentry *,
> > >  		       struct posix_acl *, int);
> > > +	int (*get_fscaps)(struct mnt_idmap *, struct dentry *,
> > > +			  struct vfs_caps *);
> > > +	int (*set_fscaps)(struct mnt_idmap *, struct dentry *,
> > > +			  const struct vfs_caps *, int flags);
> > 
> > If it's really a flags argument, then unsigned int, please,
> 
> This is the flags for setxattr, which is an int everywhere. Or almost

Ah right. Ugh, we should clean that up but not necessarily in this
series.

