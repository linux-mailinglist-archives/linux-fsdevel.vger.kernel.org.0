Return-Path: <linux-fsdevel+bounces-67139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5156C360E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 15:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F1DE4FA4BA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 14:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731F432D0EB;
	Wed,  5 Nov 2025 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w7G70X1G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xEwNRmlV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w7G70X1G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xEwNRmlV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A5D32D7DE
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352693; cv=none; b=oA3+LEW+B/L2H02LfFrbMbAL2/g+Y+E3mIdh7OQ6pIZVc5c/5zI8053k+U8MClc1iHhxYOfnZpN1N2YTl6hejI0nnpwkcZtUxe78L1PZYIoISg2LUpaEZeWTkZBgCWPjJhXCHoezBZas8tFNNVCilBelxcDbChIjRTvevSA8hBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352693; c=relaxed/simple;
	bh=CWwktoKkTy1P4TVrgNyhg9qXN+zt8F5q7YgF4PHFE1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b42sbbpsACubJ+m2jXAbaC6QV0P25m2nQBOoq4docvG/uYNuc8+RFDM2RMLMFzzrhkCKLN0i9n5xpek3tXt102bR6XjJRYBAx5O//AbhUO9mtBF7JSZWGG5LMgzhg/hPXwglByt07DWAqwvYr6Kp4cu13PKxZeKn1yxxpj2rCIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w7G70X1G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xEwNRmlV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w7G70X1G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xEwNRmlV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8810721212;
	Wed,  5 Nov 2025 14:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762352686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOJCqA3ChKMUkfQCzWNlBGp07o5Zw6zrQX3w0zpRHbA=;
	b=w7G70X1Gjn5ouRgIvlOChQH0ztbfr89JwglRFz0B+ueaZ19RqGpimXK/sXcuOd4+/vgQke
	R5KQPHzQ7ca7fjoKr/NcO2c4GM0OauAARG6fZPzG1zKsIyCmrJCGEKtGtPufGTk4yGyDo7
	pRVPvB97y+dIuzgdP2QEhJwI7uroV/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762352686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOJCqA3ChKMUkfQCzWNlBGp07o5Zw6zrQX3w0zpRHbA=;
	b=xEwNRmlV9EndqFP4HWITx9qtuB0L7J/x/Cx3wg8tV7ydoEehA2YDYEyvjDPLMmRekyF7mi
	yH9WVFA6MF6bqhBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=w7G70X1G;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xEwNRmlV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762352686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOJCqA3ChKMUkfQCzWNlBGp07o5Zw6zrQX3w0zpRHbA=;
	b=w7G70X1Gjn5ouRgIvlOChQH0ztbfr89JwglRFz0B+ueaZ19RqGpimXK/sXcuOd4+/vgQke
	R5KQPHzQ7ca7fjoKr/NcO2c4GM0OauAARG6fZPzG1zKsIyCmrJCGEKtGtPufGTk4yGyDo7
	pRVPvB97y+dIuzgdP2QEhJwI7uroV/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762352686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOJCqA3ChKMUkfQCzWNlBGp07o5Zw6zrQX3w0zpRHbA=;
	b=xEwNRmlV9EndqFP4HWITx9qtuB0L7J/x/Cx3wg8tV7ydoEehA2YDYEyvjDPLMmRekyF7mi
	yH9WVFA6MF6bqhBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F94113699;
	Wed,  5 Nov 2025 14:24:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IadQFy5eC2k/SQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Nov 2025 14:24:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A32ABA28C0; Wed,  5 Nov 2025 15:24:41 +0100 (CET)
Date: Wed, 5 Nov 2025 15:24:41 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>, 
	cem@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, gabriel@krisman.be, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 1/6] iomap: report file IO errors to fsnotify
Message-ID: <g2xevmkixxjturg47qv4gokvxvbah275z5slweehj2pvesl3zs@ordfml4v7gaa>
References: <176230366393.1647991.7608961849841103569.stgit@frogsfrogsfrogs>
 <176230366453.1647991.17002688390201603817.stgit@frogsfrogsfrogs>
 <ewqcnrecsvpi5wy3mufy3swnf46ejnz4kc5ph2eb4iriftdddi@mamiprlrvi75>
 <CAOQ4uxhfrHNk+b=BW5o7We=jC7ob4JbuL4vQz8QhUKD0VaRP=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhfrHNk+b=BW5o7We=jC7ob4JbuL4vQz8QhUKD0VaRP=A@mail.gmail.com>
X-Rspamd-Queue-Id: 8810721212
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Wed 05-11-25 12:14:52, Amir Goldstein wrote:
> On Wed, Nov 5, 2025 at 12:00 PM Jan Kara <jack@suse.cz> wrote:
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index 5e4b3a4b24823f..1cb3965db3275c 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -80,6 +80,7 @@ struct fs_context;
> > >  struct fs_parameter_spec;
> > >  struct file_kattr;
> > >  struct iomap_ops;
> > > +struct notifier_head;
> > >
> > >  extern void __init inode_init(void);
> > >  extern void __init inode_init_early(void);
> > > @@ -1587,6 +1588,7 @@ struct super_block {
> > >
> > >       spinlock_t              s_inode_wblist_lock;
> > >       struct list_head        s_inodes_wb;    /* writeback inodes */
> > > +     struct blocking_notifier_head   s_error_notifier;
> > >  } __randomize_layout;
> > >
> > >  static inline struct user_namespace *i_user_ns(const struct inode *inode)
> > > @@ -4069,4 +4071,66 @@ static inline bool extensible_ioctl_valid(unsigned int cmd_a,
> > >       return true;
> > >  }
> > >
> > > +enum fs_error_type {
> > > +     /* pagecache reads and writes */
> > > +     FSERR_READAHEAD,
> > > +     FSERR_WRITEBACK,
> > > +
> > > +     /* directio read and writes */
> > > +     FSERR_DIO_READ,
> > > +     FSERR_DIO_WRITE,
> > > +
> > > +     /* media error */
> > > +     FSERR_DATA_LOST,
> > > +
> > > +     /* filesystem metadata */
> > > +     FSERR_METADATA,
> > > +};
> > > +
> > > +struct fs_error {
> > > +     struct work_struct work;
> > > +     struct super_block *sb;
> > > +     struct inode *inode;
> > > +     loff_t pos;
> > > +     u64 len;
> > > +     enum fs_error_type type;
> > > +     int error;
> > > +};
> > > +
> > > +struct fs_error_hook {
> > > +     struct notifier_block nb;
> > > +};
> > > +
> > > +static inline int sb_hook_error(struct super_block *sb,
> > > +                             struct fs_error_hook *h)
> > > +{
> > > +     return blocking_notifier_chain_register(&sb->s_error_notifier, &h->nb);
> > > +}
> > > +
> > > +static inline void sb_unhook_error(struct super_block *sb,
> > > +                                struct fs_error_hook *h)
> > > +{
> > > +     blocking_notifier_chain_unregister(&sb->s_error_notifier, &h->nb);
> > > +}
> > > +
> > > +static inline void sb_init_error_hook(struct fs_error_hook *h, notifier_fn_t fn)
> > > +{
> > > +     h->nb.notifier_call = fn;
> > > +     h->nb.priority = 0;
> > > +}
> > > +
> > > +void __sb_error(struct super_block *sb, struct inode *inode,
> > > +             enum fs_error_type type, loff_t pos, u64 len, int error);
> > > +
> > > +static inline void sb_error(struct super_block *sb, int error)
> > > +{
> > > +     __sb_error(sb, NULL, FSERR_METADATA, 0, 0, error);
> > > +}
> > > +
> > > +static inline void inode_error(struct inode *inode, enum fs_error_type type,
> > > +                            loff_t pos, u64 len, int error)
> > > +{
> > > +     __sb_error(inode->i_sb, inode, type, pos, len, error);
> > > +}
> > > +
> 
> Apart from the fact that Christian is not going to be happy with this
> bloat of fs.h shouldn't all this be part of fsnotify.h?

Point that this maybe doesn't belong to fs.h is a good one. But I don't
think fsnotify.h is appropriate either because this isn't really part of
fsnotify. It is a layer on top that's binding fsnotify and notifier chain
notification. So maybe a new fs_error.h header?

> I do not see why ext4 should not use the same workqueue
> or why any code would need to call fsnotify_sb_error() directly.

Yes, I guess we can convert ext4 to the same framework but I'm fine with
cleaning that up later.

> > > +void __sb_error(struct super_block *sb, struct inode *inode,
> > > +             enum fs_error_type type, loff_t pos, u64 len, int error)
> > > +{
> > > +     struct fs_error *fserr = kzalloc(sizeof(struct fs_error), GFP_ATOMIC);
> > > +
> > > +     if (!fserr) {
> > > +             printk(KERN_ERR
> > > + "lost fs error report for ino %lu type %u pos 0x%llx len 0x%llx error %d",
> > > +                             inode ? inode->i_ino : 0, type,
> > > +                             pos, len, error);
> > > +             return;
> > > +     }
> > > +
> > > +     if (inode) {
> > > +             fserr->sb = inode->i_sb;
> > > +             fserr->inode = igrab(inode);
> > > +     } else {
> > > +             fserr->sb = sb;
> > > +     }
> > > +     fserr->type = type;
> > > +     fserr->pos = pos;
> > > +     fserr->len = len;
> > > +     fserr->error = error;
> > > +     INIT_WORK(&fserr->work, handle_sb_error);
> > > +
> > > +     schedule_work(&fserr->work);
> > > +}
> > > +EXPORT_SYMBOL_GPL(__sb_error);
> > >
> 
> ...
> We recently discovered that fsnotify_sb_error() calls are exposed to
> races with generic_shutdown_super():
> https://lore.kernel.org/linux-fsdevel/scmyycf2trich22v25s6gpe3ib6ejawflwf76znxg7sedqablp@ejfycd34xvpa/
> 
> Will punting all FS_ERROR events to workqueue help to improve this
> situation or will it make it worse?

Worse. But you raise a really good point which I've missed during my
review. Currently there's nothing which synchronizes pending works with
superblock getting destroyed with obvious UAF issues already in
handle_sb_error().

> Another question to ask is whether reporting fs error duing fs shutdown
> is a feature or anti feature?

I think there must be a point of no return during fs shutdown after which
we just stop emitting errors.

> If this is needed then we could change fsnotify_sb_error() to
> take ino,gen or file handle directly instead of calling filesystem to encode
> a file handle to report with the event.

This lifetime issue is not limited to fsnotify. I think __sb_error() needs
to check whether the superblock is still alive and synchronize properly
with sb shutdown (at which point making ext4 use this framework will be a
net win because it will close this race for ext4 as well).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

