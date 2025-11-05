Return-Path: <linux-fsdevel+bounces-67182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB557C374C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 19:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 25EB934DBCB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 18:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA0A280023;
	Wed,  5 Nov 2025 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZ4TiB4N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673ED279DCD;
	Wed,  5 Nov 2025 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367290; cv=none; b=NgL/jpC8oq3wg79FmQTQmqMyLoXS16DMo2rEtZEpbCo0RMbJ5yjbiweKZifMxZcnyJjrw5wtyWqawxoUOZB7gU2+pFLMLKCDvxxLP8pfg+vyWH1OivnVIP6sNlqCY8FAdbF7pwn3R8iw357ibW0hH4HyQO6CyJIwPseA02tyT2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367290; c=relaxed/simple;
	bh=lCErqhJPXCZ/Wked5pnYjVVMhMqyae/xHR41/rZuzgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTcL0u6nmWcvELoHsmPqBMSsFbw2Q9qdPXGu6xySa3+sBP00fmTC+PCdBhoNhUHUNgRTCCMsqtmRvU5WY52PiRX2H1s2WGXH0U63gj9fzdc4rkUnb/Ei14X91NjnfBNKVtMyS9XWL0L8Po7G9Q0LEqV6RrDpb/XJsX+b9ehNpVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZ4TiB4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C192FC116B1;
	Wed,  5 Nov 2025 18:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762367288;
	bh=lCErqhJPXCZ/Wked5pnYjVVMhMqyae/xHR41/rZuzgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YZ4TiB4N6+QOeirA5dp4+yqy3BQT3Ork849ApydejVLqsxckoCJ8ew71cpH8ZwUZS
	 1jQMfBf0mXyVE89dHbBa48zHxZKUese9ljnuFoDEJjfoy4Ise6XZ78Q+aD08Ie5q23
	 4dXsnxSdjU+M2CdGeFFvnxcwMTtZpI0zV0KHSeUlKuvOxnWNastbiOgOJxIpUtTmGR
	 hj1DWRmo5onPakVIT8UXIlwBPVOtI95mWcE826JHUM6Ek0nFL5pJFqtxmAhQ0/1GMG
	 +JSDT02Ui6BkAPUZf7zBwK2Xn3gauBrHN9RvE0PIzmtOZrjOCNj/Rv3zyxFiyVrdsU
	 lqD1i52B/NRuQ==
Date: Wed, 5 Nov 2025 10:28:08 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, cem@kernel.org, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	gabriel@krisman.be, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 1/6] iomap: report file IO errors to fsnotify
Message-ID: <20251105182808.GC196370@frogsfrogsfrogs>
References: <176230366393.1647991.7608961849841103569.stgit@frogsfrogsfrogs>
 <176230366453.1647991.17002688390201603817.stgit@frogsfrogsfrogs>
 <ewqcnrecsvpi5wy3mufy3swnf46ejnz4kc5ph2eb4iriftdddi@mamiprlrvi75>
 <CAOQ4uxhfrHNk+b=BW5o7We=jC7ob4JbuL4vQz8QhUKD0VaRP=A@mail.gmail.com>
 <g2xevmkixxjturg47qv4gokvxvbah275z5slweehj2pvesl3zs@ordfml4v7gaa>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <g2xevmkixxjturg47qv4gokvxvbah275z5slweehj2pvesl3zs@ordfml4v7gaa>

On Wed, Nov 05, 2025 at 03:24:41PM +0100, Jan Kara wrote:
> On Wed 05-11-25 12:14:52, Amir Goldstein wrote:
> > On Wed, Nov 5, 2025 at 12:00 PM Jan Kara <jack@suse.cz> wrote:
> > > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > > index 5e4b3a4b24823f..1cb3965db3275c 100644
> > > > --- a/include/linux/fs.h
> > > > +++ b/include/linux/fs.h
> > > > @@ -80,6 +80,7 @@ struct fs_context;
> > > >  struct fs_parameter_spec;
> > > >  struct file_kattr;
> > > >  struct iomap_ops;
> > > > +struct notifier_head;
> > > >
> > > >  extern void __init inode_init(void);
> > > >  extern void __init inode_init_early(void);
> > > > @@ -1587,6 +1588,7 @@ struct super_block {
> > > >
> > > >       spinlock_t              s_inode_wblist_lock;
> > > >       struct list_head        s_inodes_wb;    /* writeback inodes */
> > > > +     struct blocking_notifier_head   s_error_notifier;
> > > >  } __randomize_layout;
> > > >
> > > >  static inline struct user_namespace *i_user_ns(const struct inode *inode)
> > > > @@ -4069,4 +4071,66 @@ static inline bool extensible_ioctl_valid(unsigned int cmd_a,
> > > >       return true;
> > > >  }
> > > >
> > > > +enum fs_error_type {
> > > > +     /* pagecache reads and writes */
> > > > +     FSERR_READAHEAD,
> > > > +     FSERR_WRITEBACK,
> > > > +
> > > > +     /* directio read and writes */
> > > > +     FSERR_DIO_READ,
> > > > +     FSERR_DIO_WRITE,
> > > > +
> > > > +     /* media error */
> > > > +     FSERR_DATA_LOST,
> > > > +
> > > > +     /* filesystem metadata */
> > > > +     FSERR_METADATA,
> > > > +};
> > > > +
> > > > +struct fs_error {
> > > > +     struct work_struct work;
> > > > +     struct super_block *sb;
> > > > +     struct inode *inode;
> > > > +     loff_t pos;
> > > > +     u64 len;
> > > > +     enum fs_error_type type;
> > > > +     int error;
> > > > +};
> > > > +
> > > > +struct fs_error_hook {
> > > > +     struct notifier_block nb;
> > > > +};
> > > > +
> > > > +static inline int sb_hook_error(struct super_block *sb,
> > > > +                             struct fs_error_hook *h)
> > > > +{
> > > > +     return blocking_notifier_chain_register(&sb->s_error_notifier, &h->nb);
> > > > +}
> > > > +
> > > > +static inline void sb_unhook_error(struct super_block *sb,
> > > > +                                struct fs_error_hook *h)
> > > > +{
> > > > +     blocking_notifier_chain_unregister(&sb->s_error_notifier, &h->nb);
> > > > +}
> > > > +
> > > > +static inline void sb_init_error_hook(struct fs_error_hook *h, notifier_fn_t fn)
> > > > +{
> > > > +     h->nb.notifier_call = fn;
> > > > +     h->nb.priority = 0;
> > > > +}
> > > > +
> > > > +void __sb_error(struct super_block *sb, struct inode *inode,
> > > > +             enum fs_error_type type, loff_t pos, u64 len, int error);
> > > > +
> > > > +static inline void sb_error(struct super_block *sb, int error)
> > > > +{
> > > > +     __sb_error(sb, NULL, FSERR_METADATA, 0, 0, error);
> > > > +}
> > > > +
> > > > +static inline void inode_error(struct inode *inode, enum fs_error_type type,
> > > > +                            loff_t pos, u64 len, int error)
> > > > +{
> > > > +     __sb_error(inode->i_sb, inode, type, pos, len, error);
> > > > +}
> > > > +
> > 
> > Apart from the fact that Christian is not going to be happy with this
> > bloat of fs.h shouldn't all this be part of fsnotify.h?
> 
> Point that this maybe doesn't belong to fs.h is a good one. But I don't
> think fsnotify.h is appropriate either because this isn't really part of
> fsnotify. It is a layer on top that's binding fsnotify and notifier chain
> notification. So maybe a new fs_error.h header?

Fine with me, though it'd be a small header.

> > I do not see why ext4 should not use the same workqueue
> > or why any code would need to call fsnotify_sb_error() directly.
> 
> Yes, I guess we can convert ext4 to the same framework but I'm fine with
> cleaning that up later.

Yes, that should be a trivial patch to change fsnotify_sb_error ->
sb_error/inode_error.

> > > > +void __sb_error(struct super_block *sb, struct inode *inode,
> > > > +             enum fs_error_type type, loff_t pos, u64 len, int error)
> > > > +{
> > > > +     struct fs_error *fserr = kzalloc(sizeof(struct fs_error), GFP_ATOMIC);
> > > > +
> > > > +     if (!fserr) {
> > > > +             printk(KERN_ERR
> > > > + "lost fs error report for ino %lu type %u pos 0x%llx len 0x%llx error %d",
> > > > +                             inode ? inode->i_ino : 0, type,
> > > > +                             pos, len, error);
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     if (inode) {
> > > > +             fserr->sb = inode->i_sb;
> > > > +             fserr->inode = igrab(inode);
> > > > +     } else {
> > > > +             fserr->sb = sb;
> > > > +     }
> > > > +     fserr->type = type;
> > > > +     fserr->pos = pos;
> > > > +     fserr->len = len;
> > > > +     fserr->error = error;
> > > > +     INIT_WORK(&fserr->work, handle_sb_error);
> > > > +
> > > > +     schedule_work(&fserr->work);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(__sb_error);
> > > >
> > 
> > ...
> > We recently discovered that fsnotify_sb_error() calls are exposed to
> > races with generic_shutdown_super():
> > https://lore.kernel.org/linux-fsdevel/scmyycf2trich22v25s6gpe3ib6ejawflwf76znxg7sedqablp@ejfycd34xvpa/

Hrmm.  I've noticed that ever since I added this new patchset, I've been
getting more instances of outright crashes in the timer code, or
workqueue lockups.  I wonder if that UAF is what's going on here...

> > Will punting all FS_ERROR events to workqueue help to improve this
> > situation or will it make it worse?
> 
> Worse. But you raise a really good point which I've missed during my
> review. Currently there's nothing which synchronizes pending works with
> superblock getting destroyed with obvious UAF issues already in
> handle_sb_error().

I wonder, could __sb_error call get_active_super() to obtain an active
reference to the sb, and then deactivate_super() it in the workqueue
callback?  If we can't get an active ref then we presume that the fs is
already shutting down and don't send the event.

The igrab/iput was supposed to prevent the same UAF from happening with
the inode, but I should've checked for a non-null return value.

> > Another question to ask is whether reporting fs error duing fs shutdown
> > is a feature or anti feature?
> 
> I think there must be a point of no return during fs shutdown after which
> we just stop emitting errors.

I agree, once S_ACTIVE hits zero there's no point in sending further
errors.

> > If this is needed then we could change fsnotify_sb_error() to
> > take ino,gen or file handle directly instead of calling filesystem to encode
> > a file handle to report with the event.

That would be another way to do it.  The sole downstream consumer of the
s_error_notifier-based events only cares about ino/gen.

> This lifetime issue is not limited to fsnotify. I think __sb_error() needs
> to check whether the superblock is still alive and synchronize properly
> with sb shutdown (at which point making ext4 use this framework will be a
> net win because it will close this race for ext4 as well).

<nod>

--D

> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

