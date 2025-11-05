Return-Path: <linux-fsdevel+bounces-67189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68260C3786A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 20:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D158E3B9643
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 19:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B043A340DA6;
	Wed,  5 Nov 2025 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGAXjhk7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116902FA0E9;
	Wed,  5 Nov 2025 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371700; cv=none; b=Qr+sNADONVJzeyjBtNyjXAXBk+yKn/Of2UfQ94ArYBwIyV8E7CW39E6J1UaMqj/adENYx/wjmYSs3abpHp8mz4KtFAtlDUgRxYrULzpxmYiWQXtGVahoPjyOrrl0OUfSRAENcPx2b+Z/Vx5/UeKERY4WifKG8CAQDtZOUyKCGqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371700; c=relaxed/simple;
	bh=J3lEa3yvmlj8N7Ao4+ED+N2Cv0DcbbunmpgLxZYGrQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4TpOJwGWEgw0DEGq239u1t5WEVaTcDKQqLX85fJ9C/6CcbuhGwpCuiXqtnP8LRaUN6mhA6ENv/Bs8QzcCkTy8jPK3bG9+Cxj1DRr8E3XFuKNBYgdfenlexmfaMvZ24oSCSy+njbDe2NwVnpsfbq0q0WvBlUvJUKzDRWURdlByE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGAXjhk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D989C116B1;
	Wed,  5 Nov 2025 19:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762371699;
	bh=J3lEa3yvmlj8N7Ao4+ED+N2Cv0DcbbunmpgLxZYGrQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oGAXjhk7mPpiErk0Z++ZjYkub4Mo+SE7uo4OUAwvbdf+xtwiLWdCPdZpj/01A/Bi7
	 G123X2cJnGmFfdcejTzG/4vu9/jxECFt2MuZ8cSXpvueDuFuinStkfnj2DS9SK7/a9
	 1DQH2/1kR98qc5v4FzReevLA81PNw3qrbvrd5hGEnnyXp4y98gxlWwIbgR9p0Y4srX
	 pQbxDGLD8YNkMhkb2Z4l5mxAz2Knwcgxg3la359lh38F3sPKqy3T/VjASU5oTU//PF
	 kCZ3mwh55GXQa+muBNOeePfxLYyFEnyQacv6Rtp+TR9mdFGHlRLE5yJeZ2M/5xkSmB
	 mc/njV1u6M4ag==
Date: Wed, 5 Nov 2025 11:41:38 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, cem@kernel.org, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	gabriel@krisman.be, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 1/6] iomap: report file IO errors to fsnotify
Message-ID: <20251105194138.GK196362@frogsfrogsfrogs>
References: <176230366393.1647991.7608961849841103569.stgit@frogsfrogsfrogs>
 <176230366453.1647991.17002688390201603817.stgit@frogsfrogsfrogs>
 <ewqcnrecsvpi5wy3mufy3swnf46ejnz4kc5ph2eb4iriftdddi@mamiprlrvi75>
 <CAOQ4uxhfrHNk+b=BW5o7We=jC7ob4JbuL4vQz8QhUKD0VaRP=A@mail.gmail.com>
 <g2xevmkixxjturg47qv4gokvxvbah275z5slweehj2pvesl3zs@ordfml4v7gaa>
 <20251105182808.GC196370@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105182808.GC196370@frogsfrogsfrogs>

On Wed, Nov 05, 2025 at 10:28:08AM -0800, Darrick J. Wong wrote:
> On Wed, Nov 05, 2025 at 03:24:41PM +0100, Jan Kara wrote:
> > On Wed 05-11-25 12:14:52, Amir Goldstein wrote:
> > > On Wed, Nov 5, 2025 at 12:00 PM Jan Kara <jack@suse.cz> wrote:
> > > > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > > > index 5e4b3a4b24823f..1cb3965db3275c 100644
> > > > > --- a/include/linux/fs.h
> > > > > +++ b/include/linux/fs.h
> > > > > @@ -80,6 +80,7 @@ struct fs_context;
> > > > >  struct fs_parameter_spec;
> > > > >  struct file_kattr;
> > > > >  struct iomap_ops;
> > > > > +struct notifier_head;
> > > > >
> > > > >  extern void __init inode_init(void);
> > > > >  extern void __init inode_init_early(void);
> > > > > @@ -1587,6 +1588,7 @@ struct super_block {
> > > > >
> > > > >       spinlock_t              s_inode_wblist_lock;
> > > > >       struct list_head        s_inodes_wb;    /* writeback inodes */
> > > > > +     struct blocking_notifier_head   s_error_notifier;
> > > > >  } __randomize_layout;
> > > > >
> > > > >  static inline struct user_namespace *i_user_ns(const struct inode *inode)
> > > > > @@ -4069,4 +4071,66 @@ static inline bool extensible_ioctl_valid(unsigned int cmd_a,
> > > > >       return true;
> > > > >  }
> > > > >
> > > > > +enum fs_error_type {
> > > > > +     /* pagecache reads and writes */
> > > > > +     FSERR_READAHEAD,
> > > > > +     FSERR_WRITEBACK,
> > > > > +
> > > > > +     /* directio read and writes */
> > > > > +     FSERR_DIO_READ,
> > > > > +     FSERR_DIO_WRITE,
> > > > > +
> > > > > +     /* media error */
> > > > > +     FSERR_DATA_LOST,
> > > > > +
> > > > > +     /* filesystem metadata */
> > > > > +     FSERR_METADATA,
> > > > > +};
> > > > > +
> > > > > +struct fs_error {
> > > > > +     struct work_struct work;
> > > > > +     struct super_block *sb;
> > > > > +     struct inode *inode;
> > > > > +     loff_t pos;
> > > > > +     u64 len;
> > > > > +     enum fs_error_type type;
> > > > > +     int error;
> > > > > +};
> > > > > +
> > > > > +struct fs_error_hook {
> > > > > +     struct notifier_block nb;
> > > > > +};
> > > > > +
> > > > > +static inline int sb_hook_error(struct super_block *sb,
> > > > > +                             struct fs_error_hook *h)
> > > > > +{
> > > > > +     return blocking_notifier_chain_register(&sb->s_error_notifier, &h->nb);
> > > > > +}
> > > > > +
> > > > > +static inline void sb_unhook_error(struct super_block *sb,
> > > > > +                                struct fs_error_hook *h)
> > > > > +{
> > > > > +     blocking_notifier_chain_unregister(&sb->s_error_notifier, &h->nb);
> > > > > +}
> > > > > +
> > > > > +static inline void sb_init_error_hook(struct fs_error_hook *h, notifier_fn_t fn)
> > > > > +{
> > > > > +     h->nb.notifier_call = fn;
> > > > > +     h->nb.priority = 0;
> > > > > +}
> > > > > +
> > > > > +void __sb_error(struct super_block *sb, struct inode *inode,
> > > > > +             enum fs_error_type type, loff_t pos, u64 len, int error);
> > > > > +
> > > > > +static inline void sb_error(struct super_block *sb, int error)
> > > > > +{
> > > > > +     __sb_error(sb, NULL, FSERR_METADATA, 0, 0, error);
> > > > > +}
> > > > > +
> > > > > +static inline void inode_error(struct inode *inode, enum fs_error_type type,
> > > > > +                            loff_t pos, u64 len, int error)
> > > > > +{
> > > > > +     __sb_error(inode->i_sb, inode, type, pos, len, error);
> > > > > +}
> > > > > +
> > > 
> > > Apart from the fact that Christian is not going to be happy with this
> > > bloat of fs.h shouldn't all this be part of fsnotify.h?
> > 
> > Point that this maybe doesn't belong to fs.h is a good one. But I don't
> > think fsnotify.h is appropriate either because this isn't really part of
> > fsnotify. It is a layer on top that's binding fsnotify and notifier chain
> > notification. So maybe a new fs_error.h header?
> 
> Fine with me, though it'd be a small header.
> 
> > > I do not see why ext4 should not use the same workqueue
> > > or why any code would need to call fsnotify_sb_error() directly.
> > 
> > Yes, I guess we can convert ext4 to the same framework but I'm fine with
> > cleaning that up later.
> 
> Yes, that should be a trivial patch to change fsnotify_sb_error ->
> sb_error/inode_error.
> 
> > > > > +void __sb_error(struct super_block *sb, struct inode *inode,
> > > > > +             enum fs_error_type type, loff_t pos, u64 len, int error)
> > > > > +{
> > > > > +     struct fs_error *fserr = kzalloc(sizeof(struct fs_error), GFP_ATOMIC);
> > > > > +
> > > > > +     if (!fserr) {
> > > > > +             printk(KERN_ERR
> > > > > + "lost fs error report for ino %lu type %u pos 0x%llx len 0x%llx error %d",
> > > > > +                             inode ? inode->i_ino : 0, type,
> > > > > +                             pos, len, error);
> > > > > +             return;
> > > > > +     }
> > > > > +
> > > > > +     if (inode) {
> > > > > +             fserr->sb = inode->i_sb;
> > > > > +             fserr->inode = igrab(inode);
> > > > > +     } else {
> > > > > +             fserr->sb = sb;
> > > > > +     }
> > > > > +     fserr->type = type;
> > > > > +     fserr->pos = pos;
> > > > > +     fserr->len = len;
> > > > > +     fserr->error = error;
> > > > > +     INIT_WORK(&fserr->work, handle_sb_error);
> > > > > +
> > > > > +     schedule_work(&fserr->work);
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(__sb_error);
> > > > >
> > > 
> > > ...
> > > We recently discovered that fsnotify_sb_error() calls are exposed to
> > > races with generic_shutdown_super():
> > > https://lore.kernel.org/linux-fsdevel/scmyycf2trich22v25s6gpe3ib6ejawflwf76znxg7sedqablp@ejfycd34xvpa/
> 
> Hrmm.  I've noticed that ever since I added this new patchset, I've been
> getting more instances of outright crashes in the timer code, or
> workqueue lockups.  I wonder if that UAF is what's going on here...
> 
> > > Will punting all FS_ERROR events to workqueue help to improve this
> > > situation or will it make it worse?
> > 
> > Worse. But you raise a really good point which I've missed during my
> > review. Currently there's nothing which synchronizes pending works with
> > superblock getting destroyed with obvious UAF issues already in
> > handle_sb_error().
> 
> I wonder, could __sb_error call get_active_super() to obtain an active
> reference to the sb, and then deactivate_super() it in the workqueue
> callback?  If we can't get an active ref then we presume that the fs is
> already shutting down and don't send the event.

...and now that I've actually tried it, I realize that we can't actually
call get_active_super because it can sleep waiting for s_umount and
SB_BORN.  Maybe we could directly atomic_inc_not_zero(&sb->s_active)
adn trust that the caller has an active ref to the sb?  I think that's
true for anyone calling __sb_error with a non-null inode.

--D

> The igrab/iput was supposed to prevent the same UAF from happening with
> the inode, but I should've checked for a non-null return value.
> 
> > > Another question to ask is whether reporting fs error duing fs shutdown
> > > is a feature or anti feature?
> > 
> > I think there must be a point of no return during fs shutdown after which
> > we just stop emitting errors.
> 
> I agree, once S_ACTIVE hits zero there's no point in sending further
> errors.
> 
> > > If this is needed then we could change fsnotify_sb_error() to
> > > take ino,gen or file handle directly instead of calling filesystem to encode
> > > a file handle to report with the event.
> 
> That would be another way to do it.  The sole downstream consumer of the
> s_error_notifier-based events only cares about ino/gen.
> 
> > This lifetime issue is not limited to fsnotify. I think __sb_error() needs
> > to check whether the superblock is still alive and synchronize properly
> > with sb shutdown (at which point making ext4 use this framework will be a
> > net win because it will close this race for ext4 as well).
> 
> <nod>
> 
> --D
> 
> > 								Honza
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
> > 
> 

