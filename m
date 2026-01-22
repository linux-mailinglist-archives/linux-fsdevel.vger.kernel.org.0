Return-Path: <linux-fsdevel+bounces-75164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FKLHVSlcmmMoQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 23:31:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F210C6E2F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 23:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CB3530166DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 22:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4C53921C2;
	Thu, 22 Jan 2026 22:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFYBBIDy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3353385AE;
	Thu, 22 Jan 2026 22:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769121081; cv=none; b=c8OTuhDGA4QFlsW+vvD+QKZqiMA+etpExojcvHfKEeoEQCmJ7FXnICtkz2CjgudZINoqHw2U0CvAaTKZ4xdo29oARTrm8oncwcnMJlP7lFhfbe7fc2EHBy5uRVaL/8XK+i4IodnMCBG8E8qRp05xoFNYKBJZGqC/B6n0bBLf92g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769121081; c=relaxed/simple;
	bh=4l0pCC1i/jydXwVQt8Aoc+8uBYuGmYvOewbjQikryIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5F2XdpYhv/6ke8Q//Pv0aBZW1MpjaEKr3wiFyKtypdypK2+JFLSoP73zb9cSiwza3urVvsdQ5on/K0r6mdp+1/ilAzBQcGDIEUD0lhViMjLfsu4zaUblAvyLOV92gfQXhdiwhciuIJtUMuS0JZGdHUKI4GvZkBLwlNGOVJRfws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFYBBIDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49638C116C6;
	Thu, 22 Jan 2026 22:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769121080;
	bh=4l0pCC1i/jydXwVQt8Aoc+8uBYuGmYvOewbjQikryIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFYBBIDyhsvyAjHq0OR2+vM0Zfs22GJOK3rhFTDg9qCcej766oQW50YdU4mBdHAQq
	 qEG6wjz5Zg80DqHXw0kdOS3olKztSohHHUXy10+9UKENiwNkwJQCANCehsJ+3Ga8TC
	 GVYpRG3hQGE43YiAC+2F2vWLPSuzsV5ryse5vud7odOVKzuq2Ngt9p6WZ7YxihkALA
	 1ZyFCqy7845jkD9/MaRRaHx4ai1HfZ7wcEtBSesblA91EvVL07SvbB4i0twHPyBWns
	 uIbreoP8qN3G+iUSxfmtC9tl+hXiPEd/a35QPo+ZQjcJHavdfu8Nr2gzvGp4Vv2iVO
	 NpeX1WGsENqcQ==
Date: Thu, 22 Jan 2026 14:31:19 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/31] fuse: implement basic iomap reporting such as
 FIEMAP and SEEK_{DATA,HOLE}
Message-ID: <20260122223119.GB5900@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <176169810568.1424854.4073875923015322741.stgit@frogsfrogsfrogs>
 <CAJnrk1Y8Fi7ZgY15WDtKZ1kVAsh-kzfNbEOvHKNwCxtA6iWzWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Y8Fi7ZgY15WDtKZ1kVAsh-kzfNbEOvHKNwCxtA6iWzWA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75164-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F210C6E2F0
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 06:07:12PM -0800, Joanne Koong wrote:
> On Tue, Oct 28, 2025 at 5:47 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Implement the basic file mapping reporting functions like FIEMAP, BMAP,
> > and SEEK_DATA/HOLE.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/fuse_i.h     |    8 ++++++
> >  fs/fuse/dir.c        |    1 +
> >  fs/fuse/file.c       |   13 ++++++++++
> >  fs/fuse/file_iomap.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  4 files changed, 89 insertions(+), 1 deletion(-)
> >
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index c7aeb324fe599e..6fe8aa1845b98d 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -1730,6 +1730,11 @@ static inline bool fuse_inode_has_iomap(const struct inode *inode)
> >
> >         return test_bit(FUSE_I_IOMAP, &fi->state);
> >  }
> > +
> > +int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> > +                     u64 start, u64 length);
> > +loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence);
> > +sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block);
> >  #else
> >  # define fuse_iomap_enabled(...)               (false)
> >  # define fuse_has_iomap(...)                   (false)
> > @@ -1739,6 +1744,9 @@ static inline bool fuse_inode_has_iomap(const struct inode *inode)
> >  # define fuse_iomap_init_nonreg_inode(...)     ((void)0)
> >  # define fuse_iomap_evict_inode(...)           ((void)0)
> >  # define fuse_inode_has_iomap(...)             (false)
> > +# define fuse_iomap_fiemap                     NULL
> > +# define fuse_iomap_lseek(...)                 (-ENOSYS)
> > +# define fuse_iomap_bmap(...)                  (-ENOSYS)
> >  #endif
> >
> >  #endif /* _FS_FUSE_I_H */
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index 18eb1bb192bb58..bafc386f2f4d3a 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -2296,6 +2296,7 @@ static const struct inode_operations fuse_common_inode_operations = {
> >         .set_acl        = fuse_set_acl,
> >         .fileattr_get   = fuse_fileattr_get,
> >         .fileattr_set   = fuse_fileattr_set,
> > +       .fiemap         = fuse_iomap_fiemap,
> >  };
> >
> >  static const struct inode_operations fuse_symlink_inode_operations = {
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index bd9c208a46c78d..8a981f41b1dbd0 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -2512,6 +2512,12 @@ static sector_t fuse_bmap(struct address_space *mapping, sector_t block)
> >         struct fuse_bmap_out outarg;
> >         int err;
> >
> > +       if (fuse_inode_has_iomap(inode)) {
> > +               sector_t alt_sec = fuse_iomap_bmap(mapping, block);
> > +               if (alt_sec > 0)
> > +                       return alt_sec;
> > +       }
> > +
> >         if (!inode->i_sb->s_bdev || fm->fc->no_bmap)
> >                 return 0;
> >
> > @@ -2547,6 +2553,13 @@ static loff_t fuse_lseek(struct file *file, loff_t offset, int whence)
> >         struct fuse_lseek_out outarg;
> >         int err;
> >
> > +       if (fuse_inode_has_iomap(inode)) {
> > +               loff_t alt_pos = fuse_iomap_lseek(file, offset, whence);
> > +
> > +               if (alt_pos >= 0 || (alt_pos < 0 && alt_pos != -ENOSYS))
> 
> I don't think you technically need the "alt_pos < 0" part here since
> the  "alt_pos >= 0 ||" part already accounts for that

alt_pos is loff_t, which is a signed type.

But I think this could be more concise:

		alt_pos = fuse_iomap_lseek(...);
		if (alt_pos != -ENOSYS)
			return alt_pos;

> > +                       return alt_pos;
> > +       }
> > +
> >         if (fm->fc->no_lseek)
> >                 goto fallback;
> >
> > diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> > index 66a7b8faa31ac2..ce64e7c4860ef8 100644
> > --- a/fs/fuse/file_iomap.c
> > +++ b/fs/fuse/file_iomap.c
> > @@ -4,6 +4,7 @@
> >   * Author: Darrick J. Wong <djwong@kernel.org>
> >   */
> >  #include <linux/iomap.h>
> > +#include <linux/fiemap.h>
> >  #include "fuse_i.h"
> >  #include "fuse_trace.h"
> >  #include "iomap_i.h"
> > @@ -561,7 +562,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
> >         return err;
> >  }
> >
> > -const struct iomap_ops fuse_iomap_ops = {
> > +static const struct iomap_ops fuse_iomap_ops = {
> >         .iomap_begin            = fuse_iomap_begin,
> >         .iomap_end              = fuse_iomap_end,
> >  };
> > @@ -690,3 +691,68 @@ void fuse_iomap_evict_inode(struct inode *inode)
> >         if (conn->iomap && fuse_inode_is_exclusive(inode))
> >                 clear_bit(FUSE_I_EXCLUSIVE, &fi->state);
> >  }
> > +
> > +int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> > +                     u64 start, u64 count)
> > +{
> > +       struct fuse_conn *fc = get_fuse_conn(inode);
> > +       int error;
> > +
> > +       /*
> > +        * We are called directly from the vfs so we need to check per-inode
> > +        * support here explicitly.
> > +        */
> > +       if (!fuse_inode_has_iomap(inode))
> > +               return -EOPNOTSUPP;
> > +
> > +       if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR)
> 
> I don't see where FIEMAP_FLAG_SYNC and FIEMAP_FLAG_CACHE are supported
> either, should these return -EOPNOTSUPP if they're set as well?

The vfs implements FIEMAP_FLAG_SYNC for us in fiemap_prep, which is
called by iomap_fiemap.

I'm not sure what FIEMAP_FLAG_CACHE means in this context.  Its comment
says "request caching of the extents" which doesn't sound like doing
anything is mandatory.

> > +               return -EOPNOTSUPP;
> > +
> > +       if (fuse_is_bad(inode))
> > +               return -EIO;
> > +
> > +       if (!fuse_allow_current_process(fc))
> > +               return -EACCES;
> > +
> > +       inode_lock_shared(inode);
> > +       error = iomap_fiemap(inode, fieinfo, start, count, &fuse_iomap_ops);
> > +       inode_unlock_shared(inode);
> > +
> > +       return error;
> > +}
> > +
> > +sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block)
> > +{
> > +       ASSERT(fuse_inode_has_iomap(mapping->host));
> > +
> > +       return iomap_bmap(mapping, block, &fuse_iomap_ops);
> > +}
> > +
> > +loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence)
> > +{
> > +       struct inode *inode = file->f_mapping->host;
> > +       struct fuse_conn *fc = get_fuse_conn(inode);
> > +
> > +       ASSERT(fuse_inode_has_iomap(inode));
> > +
> > +       if (fuse_is_bad(inode))
> > +               return -EIO;
> > +
> > +       if (!fuse_allow_current_process(fc))
> > +               return -EACCES;
> > +
> > +       switch (whence) {
> > +       case SEEK_HOLE:
> > +               offset = iomap_seek_hole(inode, offset, &fuse_iomap_ops);
> > +               break;
> > +       case SEEK_DATA:
> > +               offset = iomap_seek_data(inode, offset, &fuse_iomap_ops);
> > +               break;
> > +       default:
> 
> Does it make sense to have the default case just call generic_file_llseek()?

Yes.  Thanks for spotting that bug!

--D

> Thanks,
> Joanne
> 
> > +               return -ENOSYS;
> > +       }
> > +
> > +       if (offset < 0)
> > +               return offset;
> > +       return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
> > +}
> >
> 

