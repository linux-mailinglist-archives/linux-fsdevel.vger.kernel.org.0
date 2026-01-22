Return-Path: <linux-fsdevel+bounces-75163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJa3OTWjcmkOnwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 23:22:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D106E219
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 23:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAEDD30115BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 22:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8193D5F5C;
	Thu, 22 Jan 2026 22:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLaviXeQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52938340A6C;
	Thu, 22 Jan 2026 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769120554; cv=none; b=vEvqWKrjM9FcTSzC7c+/cF7Ld/tAOOe2u70jYK/bnCVRzAEMkDE+xo5Myn6dLE+NNlvAZTmvR/Qz/xzVdlY/0ZIvFq1Fr6JbEH3XzhuLkITng9zETEM6Bmw/E0ce2SKMvwLrA0y4kGkY31mHcvR0k0A7V3WnfdXYHdwqdjFpV70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769120554; c=relaxed/simple;
	bh=vbZVdqnDpuNV44Hfrf6Xl1ppec06FKlDoiQRGs0GK98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxPND6HW8mAbOHbq0ZO8HsP4pCHVctKcR7a7KkPnz1RPPWxHIhpV/241zanh/xEMYuHOROZhEkX39fs0t2+1IpV3ocCsLIrOcdc6sTBpcqVepP+iNBysKBIhvXQ5y+W1GASdCQPMLoWd1n3gryDgFJR3Mj/yuD18kZ3biesrptU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLaviXeQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3311C116C6;
	Thu, 22 Jan 2026 22:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769120554;
	bh=vbZVdqnDpuNV44Hfrf6Xl1ppec06FKlDoiQRGs0GK98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LLaviXeQjDfm+CDG6c2K97GPpOkNM+4HOK2WfBy/dhWLdFZOeSQ4dXc+Yl/wEIQX+
	 op0Te7XmGuueYhBeNPZpdV/Cf5dLf+VVb92B5adgbmioSWmovYFpF1pSBmP6vRZ0qb
	 Lrowo1Xqyoxsvh+j595AFCEeESQ+ZPSpKAtCJ/rmAjnKdw5Mjo4/NLf8T12Ul+MUpu
	 MDwBqSGiM4N2kJAOv64bZo44ng0H1V7mDyFjJtfGZPmLLDTL1NSHChwUMaAZoVqPUf
	 HjjB/GqfhGcK8bma1hcE5D0Tcn4wGaOWG/Sdh/9nrijmq6AXmDzXzmhWsvGbXSwWYw
	 vVaDwpCSwA4Gg==
Date: Thu, 22 Jan 2026 14:22:33 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/31] fuse: create a per-inode flag for toggling iomap
Message-ID: <20260122222233.GA5900@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <176169810502.1424854.13869957103489591272.stgit@frogsfrogsfrogs>
 <CAJnrk1ZDeYytdjuCdg6-O-PGjcmwS33LOnfFT_YY9SPE=x=Qxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZDeYytdjuCdg6-O-PGjcmwS33LOnfFT_YY9SPE=x=Qxw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75163-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90D106E219
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 05:13:39PM -0800, Joanne Koong wrote:
> On Tue, Oct 28, 2025 at 5:46 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Create a per-inode flag to control whether or not this inode actually
> > uses iomap.  This is required for non-regular files because iomap
> > doesn't apply there; and enables fuse filesystems to provide some
> > non-iomap files if desired.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> The logic in this makes sense to me, left just a few comments below.
> 
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Thanks!

> > ---
> >  fs/fuse/fuse_i.h          |   17 ++++++++++++++++
> >  include/uapi/linux/fuse.h |    3 +++
> >  fs/fuse/file.c            |    1 +
> >  fs/fuse/file_iomap.c      |   49 +++++++++++++++++++++++++++++++++++++++++++++
> >  fs/fuse/inode.c           |   26 ++++++++++++++++++------
> >  5 files changed, 90 insertions(+), 6 deletions(-)
> >
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 839d4f2ada4656..c7aeb324fe599e 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -257,6 +257,8 @@ enum {
> >          * or the fuse server has an exclusive "lease" on distributed fs
> >          */
> >         FUSE_I_EXCLUSIVE,
> > +       /* Use iomap for this inode */
> > +       FUSE_I_IOMAP,
> >  };
> >
> >  struct fuse_conn;
> > @@ -1717,11 +1719,26 @@ extern const struct fuse_backing_ops fuse_iomap_backing_ops;
> >
> >  void fuse_iomap_mount(struct fuse_mount *fm);
> >  void fuse_iomap_unmount(struct fuse_mount *fm);
> > +
> > +void fuse_iomap_init_reg_inode(struct inode *inode, unsigned attr_flags);
> > +void fuse_iomap_init_nonreg_inode(struct inode *inode, unsigned attr_flags);
> > +void fuse_iomap_evict_inode(struct inode *inode);
> > +
> > +static inline bool fuse_inode_has_iomap(const struct inode *inode)
> > +{
> > +       const struct fuse_inode *fi = get_fuse_inode(inode);
> > +
> > +       return test_bit(FUSE_I_IOMAP, &fi->state);
> > +}
> >  #else
> >  # define fuse_iomap_enabled(...)               (false)
> >  # define fuse_has_iomap(...)                   (false)
> >  # define fuse_iomap_mount(...)                 ((void)0)
> >  # define fuse_iomap_unmount(...)               ((void)0)
> > +# define fuse_iomap_init_reg_inode(...)                ((void)0)
> > +# define fuse_iomap_init_nonreg_inode(...)     ((void)0)
> > +# define fuse_iomap_evict_inode(...)           ((void)0)
> > +# define fuse_inode_has_iomap(...)             (false)
> >  #endif
> >
> >  #endif /* _FS_FUSE_I_H */
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index e571f8ceecbfad..e949bfe022c3b0 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -243,6 +243,7 @@
> >   *
> >   *  7.99
> >   *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
> > + *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
> >   */
> >
> >  #ifndef _LINUX_FUSE_H
> > @@ -583,9 +584,11 @@ struct fuse_file_lock {
> >   *
> >   * FUSE_ATTR_SUBMOUNT: Object is a submount root
> >   * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
> > + * FUSE_ATTR_IOMAP: Use iomap for this inode
> >   */
> >  #define FUSE_ATTR_SUBMOUNT      (1 << 0)
> >  #define FUSE_ATTR_DAX          (1 << 1)
> > +#define FUSE_ATTR_IOMAP                (1 << 2)
> >
> >  /**
> >   * Open flags
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index f1ef77a0be05bb..42c85c19f3b13b 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -3135,6 +3135,7 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
> >         init_waitqueue_head(&fi->page_waitq);
> >         init_waitqueue_head(&fi->direct_io_waitq);
> >
> > +       fuse_iomap_init_reg_inode(inode, flags);
> 
> imo it's a bit confusing to have this here when the rest of the
> fuse_iomap_init_nonreg_inode() calls happen inside the switch case
> statement. Maybe it makes sense to have this inside the switch case
> like the fuse_iomap_init_nonreg_inode() calls, or alternatively move
> the fuse_iomap_init_nonreg_inode() calls into their corresponding
> helpers (eg fuse_init_dir(), etc.), so that it's consistent?

Ah, that.  Originally I /did/ have it in the switch statement in
fuse_init_inode.  Then I started trying to work on fsdax support (HA!)
for which it became necessary to move the fuse_iomap_init_reg_inode call
to fuse_init_file_inode and pass it a pointer to args->flags so that it
could clear FUSE_ATTR_DAX so that the other fuse dax io paths wouldn't
try to install themselves.

I never got fsdax working properly so that's why it's never been
attached to my fuse-iomap patches.  Maybe that'll happen some day in the
meantime ... should fuse_iomap_init_reg_inode move back to the switch?

> >         if (IS_ENABLED(CONFIG_FUSE_DAX))
> >                 fuse_dax_inode_init(inode, flags);
> >  }
> > diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> > index 1b9e1bf2f799a3..fc0d5f135bacf9 100644
> > --- a/fs/fuse/file_iomap.c
> > +++ b/fs/fuse/file_iomap.c
> > @@ -635,3 +635,52 @@ void fuse_iomap_unmount(struct fuse_mount *fm)
> >         fuse_flush_requests_and_wait(fc);
> >         fuse_send_destroy(fm);
> >  }
> > +
> > +static inline void fuse_inode_set_iomap(struct inode *inode)
> > +{
> > +       struct fuse_inode *fi = get_fuse_inode(inode);
> > +
> > +       set_bit(FUSE_I_IOMAP, &fi->state);
> > +}
> > +
> > +static inline void fuse_inode_clear_iomap(struct inode *inode)
> > +{
> > +       struct fuse_inode *fi = get_fuse_inode(inode);
> > +
> > +       clear_bit(FUSE_I_IOMAP, &fi->state);
> > +}
> > +
> > +void fuse_iomap_init_nonreg_inode(struct inode *inode, unsigned attr_flags)
> > +{
> > +       struct fuse_conn *conn = get_fuse_conn(inode);
> > +       struct fuse_inode *fi = get_fuse_inode(inode);
> > +
> > +       ASSERT(!S_ISREG(inode->i_mode));
> > +
> > +       if (conn->iomap && (attr_flags & FUSE_ATTR_IOMAP))
> > +               set_bit(FUSE_I_EXCLUSIVE, &fi->state);
> > +}
> > +
> > +void fuse_iomap_init_reg_inode(struct inode *inode, unsigned attr_flags)
> > +{
> > +       struct fuse_conn *conn = get_fuse_conn(inode);
> > +       struct fuse_inode *fi = get_fuse_inode(inode);
> > +
> > +       ASSERT(S_ISREG(inode->i_mode));
> > +
> > +       if (conn->iomap && (attr_flags & FUSE_ATTR_IOMAP)) {
> > +               set_bit(FUSE_I_EXCLUSIVE, &fi->state);
> > +               fuse_inode_set_iomap(inode);
> > +       }
> > +}
> > +
> > +void fuse_iomap_evict_inode(struct inode *inode)
> > +{
> > +       struct fuse_conn *conn = get_fuse_conn(inode);
> > +       struct fuse_inode *fi = get_fuse_inode(inode);
> > +
> > +       if (fuse_inode_has_iomap(inode))
> 
> If I'm understanding this correctly, a fuse inode can't have
> FUSE_I_IOMAP set on it if conn>iomap is not enabled, correct?

Correct.

> Maybe it makes sense to just return if (!conn->iomap) at the very
> beginning, to make that more clear?

<shrug> fuse_inode_has_iomap only checks FUSE_I_IOMAP...

> > +               fuse_inode_clear_iomap(inode);
> > +       if (conn->iomap && fuse_inode_is_exclusive(inode))
> > +               clear_bit(FUSE_I_EXCLUSIVE, &fi->state);

...but I wasn't going to assume that iomap is the only way that
FUSE_I_EXCLUSIVE could get set.

On the other hand, for non-regular files we set FUSE_I_EXCLUSIVE only if
conn->iomap is nonzero *and* attr->flags contains FUSE_ATTR_IOMAP.  So
this clearing code isn't quite the same as the setting code.

I wonder if that means we should set FUSE_I_IOMAP for non-regular files?
They don't use iomap itself, but I suppose it would be neat if "iomap
directories" also meant that timestamps and whatnot worked in the same
as they do for regular files.

> > +}
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 271356fa3be3ea..9b9e7b2dd0d928 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -196,6 +196,8 @@ static void fuse_evict_inode(struct inode *inode)
> >                 WARN_ON(!list_empty(&fi->write_files));
> >                 WARN_ON(!list_empty(&fi->queued_writes));
> >         }
> > +
> > +       fuse_iomap_evict_inode(inode);
> >  }
> >
> >  static int fuse_reconfigure(struct fs_context *fsc)
> > @@ -428,20 +430,32 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
> >         inode->i_size = attr->size;
> >         inode_set_mtime(inode, attr->mtime, attr->mtimensec);
> >         inode_set_ctime(inode, attr->ctime, attr->ctimensec);
> > -       if (S_ISREG(inode->i_mode)) {
> > +       switch (inode->i_mode & S_IFMT) {
> > +       case S_IFREG:
> >                 fuse_init_common(inode);
> >                 fuse_init_file_inode(inode, attr->flags);
> > -       } else if (S_ISDIR(inode->i_mode))
> > +               break;
> > +       case S_IFDIR:
> >                 fuse_init_dir(inode);
> > -       else if (S_ISLNK(inode->i_mode))
> > +               fuse_iomap_init_nonreg_inode(inode, attr->flags);
> > +               break;
> > +       case S_IFLNK:
> >                 fuse_init_symlink(inode);
> > -       else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
> > -                S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
> > +               fuse_iomap_init_nonreg_inode(inode, attr->flags);
> > +               break;
> > +       case S_IFCHR:
> > +       case S_IFBLK:
> > +       case S_IFIFO:
> > +       case S_IFSOCK:
> >                 fuse_init_common(inode);
> >                 init_special_inode(inode, inode->i_mode,
> >                                    new_decode_dev(attr->rdev));
> > -       } else
> > +               fuse_iomap_init_nonreg_inode(inode, attr->flags);
> > +               break;
> > +       default:
> >                 BUG();
> 
> Just thinking out loud here and curious to hear whether you like this
> idea or not: another option is calling
> 
> if (conn->iomap)
>     fuse_iomap_init_inode();
> 
> at the end, where fuse_iomap_init_inode() would be something like:
> 
> void fuse_iomap_init_inode(struct inode *inode, unsigned attr_flags)
> {
>     struct fuse_inode *fi = get_fuse_inode(inode);
> 
>     if (attr_flags & FUSE_ATTR_IOMAP)
>           set_bit(FUSE_I_EXCLUSIVE, &fi->state);
> 
>     if (S_ISREG(inode->i_mode))
>             fuse_inode_set_iomap(inode);
> }
> 
> which seems simpler to me than having both
> fuse_iomap_init_nonreg_inode() and fuse_iomap_init_reg_inode()
> function and invoking it per i_mode case.

Yeah that would be simpler, but for that weird fsdax enabling quirk I
mentioned earlier.

Hrmm, I could also modify fuse_dax_inode_init to return without doing
anything if FUSE_ATTR_IOMAP is set.

--D

> Thanks,
> Joanne
> 
> > +               break;
> > +       }
> >         /*
> >          * Ensure that we don't cache acls for daemons without FUSE_POSIX_ACL
> >          * so they see the exact same behavior as before.
> >
> 

