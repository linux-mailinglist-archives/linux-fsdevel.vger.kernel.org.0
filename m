Return-Path: <linux-fsdevel+bounces-12960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 586D686999E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 16:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB701F24187
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 15:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB40148FFB;
	Tue, 27 Feb 2024 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsXgDuZq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75454145343;
	Tue, 27 Feb 2024 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045872; cv=none; b=QrcgrKWhHO/FCgxbhaFyJXx2XewJv/JaA0FIEJNawqYimE5M6YwwpUCSLDI5tEo0wUM3u8iZMsxeepepVDKM5cL8iAIE2g59IK2FaRObYnPSv2F3hIJ9P6TCVq8XbScvDg8B2tou3UaKGsWmBqtM+Ix7ejxusJBg9IBX4SCwbfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045872; c=relaxed/simple;
	bh=wmEclif75z08Y7k+kYIcq9r8njHDzniHYzsVWuX5qXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvcEbAN/CYonehRsQzbHPhoEnmFJbVdD71rxtQpTCDz1+LJmal3gxNKQUcW772uVU+78sxbhiBDrvW4ovnhLIqIMUnLFZGCk4nJJzSYjMT4FSeuSoLRY8RTDC/vP7liQk2qd9l1+9nNXNvwzEMLmC4CHOTFaYeGwwn4ci4ruHxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsXgDuZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB6BC433F1;
	Tue, 27 Feb 2024 14:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709045872;
	bh=wmEclif75z08Y7k+kYIcq9r8njHDzniHYzsVWuX5qXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tsXgDuZqZaxkgTGkVT4vgZZkifzs/XhauPG/Z8VblgKg3JYBuzgPCH2sN/AOfYAsz
	 Cizp02wJoy2Js13JQt0E+Zl0HHvCGA3oZPWP9ioF8VBtoICsQTFvdJzNjP0YHkL+jx
	 ZIEk0/YHOPTJNdkd9MEZU1P/jrlu9PFKFSfTKXyWBhplucxucznwgrqof5c5iGRM/2
	 tUKDL8CJyGhfVnM/DYhRi1QnqmdGaigiZHrlvcPEAFN5h7QksWvunvY47bRRJDFmc2
	 IfgbTjgpxKGsD+8Gs+Bdb72wnC6/I2S3F3cVc+DfaWBszVKJLxEdYDxu+6MSCu1WCQ
	 xKCvkJWQbWn0Q==
Date: Tue, 27 Feb 2024 08:57:51 -0600
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
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
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, audit@vger.kernel.org,
	selinux@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 20/25] ovl: add fscaps handlers
Message-ID: <Zd34b4Lw9hOHJYr2@do-x1extreme>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-20-3039364623bd@kernel.org>
 <CAOQ4uxjvrFuz2iCiO9dsOnear+qN=M+GFW-eEOZU5uCzBkTwLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjvrFuz2iCiO9dsOnear+qN=M+GFW-eEOZU5uCzBkTwLQ@mail.gmail.com>

On Tue, Feb 27, 2024 at 03:28:18PM +0200, Amir Goldstein wrote:
> > +int ovl_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> > +                  const struct vfs_caps *caps, int setxattr_flags)
> > +{
> > +       int err;
> > +       struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
> > +       struct dentry *upperdentry = ovl_dentry_upper(dentry);
> > +       struct dentry *realdentry = upperdentry ?: ovl_dentry_lower(dentry);
> > +       const struct cred *old_cred;
> > +
> > +       /*
> > +        * If the fscaps are to be remove from a lower file, check that they
> > +        * exist before copying up.
> > +        */
> 
> Don't you need to convert -ENODATA to 0 return value in this case?

Do you mean that trying to remove an xattr that does not exist should
return 0? Standard behavior is to return -ENODATA in this situation.

> 
> > +       if (!caps && !upperdentry) {
> > +               struct path realpath;
> > +               struct vfs_caps lower_caps;
> > +
> > +               ovl_path_lower(dentry, &realpath);
> > +               old_cred = ovl_override_creds(dentry->d_sb);
> > +               err = vfs_get_fscaps(mnt_idmap(realpath.mnt), realdentry,
> > +                                    &lower_caps);
> > +               revert_creds(old_cred);
> > +               if (err)
> > +                       goto out;
> > +       }
> > +
> > +       err = ovl_want_write(dentry);
> > +       if (err)
> > +               goto out;
> > +
> 
> ovl_want_write() should after ovl_copy_up(), see:
> 162d06444070 ("ovl: reorder ovl_want_write() after ovl_inode_lock()")

Fixed.

> > @@ -758,6 +826,8 @@ static const struct inode_operations ovl_symlink_inode_operations = {
> >         .get_link       = ovl_get_link,
> >         .getattr        = ovl_getattr,
> >         .listxattr      = ovl_listxattr,
> > +       .get_fscaps     = ovl_get_fscaps,
> > +       .set_fscaps     = ovl_set_fscaps,
> >         .update_time    = ovl_update_time,
> >  };
> >
> > @@ -769,6 +839,8 @@ static const struct inode_operations ovl_special_inode_operations = {
> >         .get_inode_acl  = ovl_get_inode_acl,
> >         .get_acl        = ovl_get_acl,
> >         .set_acl        = ovl_set_acl,
> > +       .get_fscaps     = ovl_get_fscaps,
> > +       .set_fscaps     = ovl_set_fscaps,
> >         .update_time    = ovl_update_time,
> >  };
> >
> 
> 
> Sorry, I did not understand the explanation why fscaps ops are needed
> for non regular files. It does not look right to me.

The kernel does not forbid XATTR_NAME_CAPS for non-regular files and
will internally even try to read them from non-regular files during
killpriv checks. If we do not add handlers then we will end up using the
normal ovl xattr handlers, which call vfs_*xattr(). These will return an
error for fscaps xattrs after this series, which would be a change in
behavior for overlayfs and make it behave differently from other
filesystems.

