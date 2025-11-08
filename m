Return-Path: <linux-fsdevel+bounces-67520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C89FC421E1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 01:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D5D3B94E4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 00:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EA61EF09D;
	Sat,  8 Nov 2025 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdjusx5W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4641A8412;
	Sat,  8 Nov 2025 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762561074; cv=none; b=iJW+/kjIn0wgTu/QWuPMj6wi2VPu+A01qMqpUzhTmrJE1b2Gg0yu3jS8YG2sSnpwHnAZQjfLBhAVWW5mcZtWMgT21jJkxcGAHV5QR4p5py5+ZyFaWsjCNGoLn0Vo4CAho7mjsX98dOBJ94ub4hQrTrPqJ8T6sxtAWNUzYC1aBeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762561074; c=relaxed/simple;
	bh=CikzHQdYPPrcHjCkhAIDGYvfODUf+OZY1sNrBnVXhe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LA1lwEZeM+K9rvSKkifphMD7rRG9V6HDpY0y97S2cmkE82eyM+7FD7P3Q7aHT6+SyCSg6NcRBvexKa68yKP6XQklhLeNWM7DzlNRpLpIDkcifXdwZTg5JrShOyT9pgYJIynD1YZA6m9AVii7sOAblqNCcLgG2U3ws05W85FwHJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdjusx5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B417C16AAE;
	Sat,  8 Nov 2025 00:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762561074;
	bh=CikzHQdYPPrcHjCkhAIDGYvfODUf+OZY1sNrBnVXhe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mdjusx5WoNDb2oKZidmXAJwdQtJXXijRNgZVL8Ne4Eqo50l2DMMgUtAmsWQQ9DqjL
	 GxcZC2miT8dOwZke+VQj3yiunNCdV/LVEMVeXZzgXFkfshe66uvnqQwDEkKkoGOgdI
	 MMG2omyrQ04IIYVMfRSQfjOKucRmpalXr/2Eihia9rd6b5jEd9fytTXi0j6MJrlrBK
	 vGuZn9/PvQlPc7WWmjZJlUjeafg5Ph8qzKG5SxYIIvhgfo2UrZCx+8exOHLG6IQy8o
	 Epkw3hDwANKqzuUXOTadnTwlZN2J8xp0MBDZduc3oQkynYPX3wJmGjiRlEgwdvoUSt
	 XjCnY/z2HUMEw==
Date: Fri, 7 Nov 2025 16:17:53 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/5] fuse: update file mode when updating acls
Message-ID: <20251108001753.GL196391@frogsfrogsfrogs>
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
 <176169809339.1424347.12261722424900811903.stgit@frogsfrogsfrogs>
 <CAJnrk1apJbki7aZq2tNnnBcbkGKUmWDfmXVBD5YaMKUH2Fd-FA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1apJbki7aZq2tNnnBcbkGKUmWDfmXVBD5YaMKUH2Fd-FA@mail.gmail.com>

On Fri, Nov 07, 2025 at 12:29:04PM -0800, Joanne Koong wrote:
> On Tue, Oct 28, 2025 at 5:43 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > If someone sets ACLs on a file that can be expressed fully as Unix DAC
> > mode bits, most local filesystems will then update the mode bits and
> > drop the ACL xattr to reduce inefficiency in the file access paths.
> > Let's do that too.  Note that means that we can setacl and end up with
> > no ACL xattrs, so we also need to tolerate ENODATA returns from
> > fuse_removexattr.
> >
> > Note that here we define a "local" fuse filesystem as one that uses
> > fuseblk mode; we'll shortly add fuse servers that use iomap for the file
> > IO path to that list.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/fuse_i.h |    2 +-
> >  fs/fuse/acl.c    |   43 ++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 43 insertions(+), 2 deletions(-)
> >
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 8c47d103c8ffa6..d550937770e16e 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -1050,7 +1050,7 @@ static inline struct fuse_mount *get_fuse_mount(struct inode *inode)
> >         return get_fuse_mount_super(inode->i_sb);
> >  }
> >
> > -static inline struct fuse_conn *get_fuse_conn(struct inode *inode)
> > +static inline struct fuse_conn *get_fuse_conn(const struct inode *inode)
> >  {
> >         return get_fuse_mount_super(inode->i_sb)->fc;
> >  }
> > diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
> > index 8f484b105f13ab..72bb4c94079b7b 100644
> > --- a/fs/fuse/acl.c
> > +++ b/fs/fuse/acl.c
> > @@ -11,6 +11,18 @@
> >  #include <linux/posix_acl.h>
> >  #include <linux/posix_acl_xattr.h>
> >
> > +/*
> > + * If this fuse server behaves like a local filesystem, we can implement the
> > + * kernel's optimizations for ACLs for local filesystems instead of passing
> > + * the ACL requests straight through to another server.
> > + */
> > +static inline bool fuse_inode_has_local_acls(const struct inode *inode)
> > +{
> > +       const struct fuse_conn *fc = get_fuse_conn(inode);
> > +
> > +       return fc->posix_acl && fuse_inode_is_exclusive(inode);
> > +}
> > +
> >  static struct posix_acl *__fuse_get_acl(struct fuse_conn *fc,
> >                                         struct inode *inode, int type, bool rcu)
> >  {
> > @@ -98,6 +110,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> >         struct inode *inode = d_inode(dentry);
> >         struct fuse_conn *fc = get_fuse_conn(inode);
> >         const char *name;
> > +       umode_t mode = inode->i_mode;
> >         int ret;
> >
> >         if (fuse_is_bad(inode))
> > @@ -113,6 +126,18 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> >         else
> >                 return -EINVAL;
> >
> > +       /*
> > +        * If the ACL can be represented entirely with changes to the mode
> > +        * bits, then most filesystems will update the mode bits and delete
> > +        * the ACL xattr.
> > +        */
> > +       if (acl && type == ACL_TYPE_ACCESS &&
> > +           fuse_inode_has_local_acls(inode)) {
> > +               ret = posix_acl_update_mode(idmap, inode, &mode, &acl);
> > +               if (ret)
> > +                       return ret;
> > +       }
> 
> nit: this could be inside the if (acl) block below.
> 
> I'm not too familiar with ACLs so i'll abstain from adding my
> Reviewed-by to this.

posix_acl_update_mode can set acl to NULL.

--D

> Thanks,
> Joanne
> 
> > +
> >         if (acl) {
> >                 unsigned int extra_flags = 0;
> >                 /*
> > @@ -143,7 +168,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> >                  * through POSIX ACLs. Such daemons don't expect setgid bits to
> >                  * be stripped.
> >                  */
> > -               if (fc->posix_acl &&
> > +               if (fc->posix_acl && mode == inode->i_mode &&
> >                     !in_group_or_capable(idmap, inode,
> >                                          i_gid_into_vfsgid(idmap, inode)))
> >                         extra_flags |= FUSE_SETXATTR_ACL_KILL_SGID;
> > @@ -152,6 +177,22 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> >                 kfree(value);
> >         } else {
> >                 ret = fuse_removexattr(inode, name);
> > +               /* If the acl didn't exist to start with that's fine. */
> > +               if (ret == -ENODATA)
> > +                       ret = 0;
> > +       }
> > +
> > +       /* If we scheduled a mode update above, push that to userspace now. */
> > +       if (!ret) {
> > +               struct iattr attr = { };
> > +
> > +               if (mode != inode->i_mode) {
> > +                       attr.ia_valid |= ATTR_MODE;
> > +                       attr.ia_mode = mode;
> > +               }
> > +
> > +               if (attr.ia_valid)
> > +                       ret = fuse_do_setattr(idmap, dentry, &attr, NULL);
> >         }
> >
> >         if (fc->posix_acl) {
> >

