Return-Path: <linux-fsdevel+bounces-4448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175767FF9F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 447DB1C20C84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47895A0E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbewMVwK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D695E54FA6;
	Thu, 30 Nov 2023 16:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BAFC433C8;
	Thu, 30 Nov 2023 16:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701362458;
	bh=eMauWcpoHiWGcXeCJ6n8laJEDioZTrZnYDww6VNDcD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbewMVwKMEOHbYOQLQybblEflNdQip+Ra5frYeqsZTWZAms2Jc3Y7vZ7VASj5Aur8
	 2zcpnKl6VXvVqF/kauQ4Iiz6DQt73jk1dO6H+GoLx3lC2Yt97HLA9T/vmzzP3B+03Q
	 kPTyK/7HFP2KvQ4SKG0MDkNX4gmfFGIAyQE7Dz22TIRefJZJ/gc0YSFucBeOaMT/67
	 f5ls+Y0y+ImdrcDVR/MACxVOCl3kZppNqPy264LpK0ESvaBOEFvkoIHFv8e7NkdBGk
	 ZAAtIELOtR5UTdVF1PVhKL5Y6tVrJ43gmuW9DJ9HJXCC6/5leR2WXKhnvL4nNFn4y2
	 C3+wHN3tZckhg==
Date: Thu, 30 Nov 2023 10:40:57 -0600
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>,
	Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	James Morris <jmorris@namei.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, audit@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 16/16] vfs: return -EOPNOTSUPP for fscaps from
 vfs_*xattr()
Message-ID: <ZWi7GZoSId2EA1mR@do-x1extreme>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-16-da5a26058a5b@kernel.org>
 <CAOQ4uxhtJ89LknKjE=tiTgvZXbufmOaqHnhnrz348Ktq2H+yHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhtJ89LknKjE=tiTgvZXbufmOaqHnhnrz348Ktq2H+yHA@mail.gmail.com>

On Thu, Nov 30, 2023 at 08:10:15AM +0200, Amir Goldstein wrote:
> On Wed, Nov 29, 2023 at 11:51 PM Seth Forshee (DigitalOcean)
> <sforshee@kernel.org> wrote:
> >
> > Now that the new vfs-level interfaces are fully supported and all code
> > has been converted to use them, stop permitting use of the top-level vfs
> > xattr interfaces for capabilities xattrs. Unlike with ACLs we still need
> > to be able to work with fscaps xattrs using lower-level interfaces in a
> > handful of places, so only use of the top-level xattr interfaces is
> > restricted.
> 
> Can you explain why?
> Is there an inherent difference between ACLs and fscaps in that respect
> or is it just a matter of more work that needs to be done?

There are a number of differences. ACLs have caching, require additional
permission checks, and require a lot of filesystem-specific handling.
fscaps are simpler by comparison, and most filesystems can rely on a
common implementation that just converts to/from raw disk xattrs.

So at minimum I think the lowest level interfaces,
__vfs_{get,set,remove}xattr(), need to continue to allow fscaps, and
that's where ACL xattrs are blocked. Allowing some of the others to
still work with them is a matter of convenience (e.g. using
vfs_getxattr_alloc()) and trying to reduce code duplication. But as you
pointed out I did miss at least duplicating fsnotify_xattr(), so I'm
going to have another look at how I implemented these.

> 
> >
> > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > ---
> >  fs/xattr.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index 372644b15457..4b779779ad8c 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -540,6 +540,9 @@ vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
> >         const void  *orig_value = value;
> >         int error;
> >
> > +       if (!strcmp(name, XATTR_NAME_CAPS))
> > +               return -EOPNOTSUPP;
> > +
> 
> It this is really not expected, then it should be an assert and
> please use an inline helper like is_posix_acl_xattr():
> 
> if (WARN_ON_ONCE(is_fscaps_xattr(name)))

Ack, makes sense.

