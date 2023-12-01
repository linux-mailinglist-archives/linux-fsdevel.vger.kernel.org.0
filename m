Return-Path: <linux-fsdevel+bounces-4606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C70B801309
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 19:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C22A1C21002
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 18:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7895101A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXTtho4e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30FE4E618;
	Fri,  1 Dec 2023 17:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1946BC433B7;
	Fri,  1 Dec 2023 17:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701452493;
	bh=75rmXXel6gkQ09ZUtOrVjeJz8Bv+JHZyI/Mg2YOrLIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WXTtho4ex0hJPDqQpffSCq2fOFEj/CJfHgGppx0uP4cFjMq/OFG/QzUcTT9daD19T
	 YbU5UnTBHwdslUPhQLXYdpr/3w7Dds3e0DEVf2E7aV8zOPoAt1fsLe6tr9y2TJt42Y
	 mdi0Cdm/wpNwS99RpGQgYIJSKoz1GeFlMf6b6/pwNZ/Qw2GQpVqAFGMq+ZJDNwAN5M
	 x02jF6FKxM/kI9crv3m9hg1b9PSS30YwLxzvNIJI9K+VnPaJMoURTJsQQIW74Vz9qe
	 m3WWp9pn7gMOSgZ51/WsFjs4+VBm6nJ2WsZX4aS2y8o1GzjvNOO9nK/U13bpMDRhi1
	 0yZ3lsPQ2ZVgA==
Date: Fri, 1 Dec 2023 11:41:32 -0600
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
Subject: Re: [PATCH 08/16] fs: add vfs_get_fscaps()
Message-ID: <ZWoazNMO/R36u1QB@do-x1extreme>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-8-da5a26058a5b@kernel.org>
 <20231201-wodurch-holen-ce9c44d8aaf5@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201-wodurch-holen-ce9c44d8aaf5@brauner>

On Fri, Dec 01, 2023 at 06:09:36PM +0100, Christian Brauner wrote:
> On Wed, Nov 29, 2023 at 03:50:26PM -0600, Seth Forshee (DigitalOcean) wrote:
> > Provide a type-safe interface for retrieving filesystem capabilities and
> > a generic implementation suitable for most filesystems. Also add an
> > internal interface, __vfs_get_fscaps(), which skips security checks for
> > later use from the capability code.
> > 
> > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > ---
> >  fs/xattr.c         | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/fs.h |  4 ++++
> >  2 files changed, 70 insertions(+)
> > 
> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index 09d927603433..3abaf9bef0a5 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -181,6 +181,72 @@ xattr_supports_user_prefix(struct inode *inode)
> >  }
> >  EXPORT_SYMBOL(xattr_supports_user_prefix);
> >  
> > +static int generic_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> > +			      struct vfs_caps *caps)
> > +{
> > +	struct inode *inode = d_inode(dentry);
> > +	struct vfs_ns_cap_data *nscaps = NULL;
> > +	int ret;
> > +
> > +	ret = (int)vfs_getxattr_alloc(idmap, dentry, XATTR_NAME_CAPS,
> 
> I don't think you need that case here.

Yep. I played with a few different implementations of this function, so
I'm guessing I did need it at one point and failed to notice when it was
no longer needed.

> 
> > +				      (char **)&nscaps, 0, GFP_NOFS);
> > +
> > +	if (ret >= 0)
> > +		ret = vfs_caps_from_xattr(idmap, i_user_ns(inode), caps, nscaps, ret);
> > +
> > +	kfree(nscaps);
> > +	return ret;
> > +}
> > +
> > +/**
> > + * __vfs_get_fscaps - get filesystem capabilities without security checks
> > + * @idmap: idmap of the mount the inode was found from
> > + * @dentry: the dentry from which to get filesystem capabilities
> > + * @caps: storage in which to return the filesystem capabilities
> > + *
> > + * This function gets the filesystem capabilities for the dentry and returns
> > + * them in @caps. It does not perform security checks.
> > + *
> > + * Return: 0 on success, a negative errno on error.
> > + */
> > +int __vfs_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> > +		     struct vfs_caps *caps)
> 
> I would rename that to vfs_get_fscaps_nosec(). We do that for
> vfs_getxattr_nosec() as well. It's not pretty but it's better than just
> slapping underscores onto it imo.

Will do.

