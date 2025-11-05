Return-Path: <linux-fsdevel+bounces-67095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BBEC354A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 12:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7DE621130
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 11:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0815D30E838;
	Wed,  5 Nov 2025 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FISNXOCI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7PDYM1GS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rgkfWe0A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/uoTGEpt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D03630E0F0
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762340414; cv=none; b=Ul78/e46uqqEoJT0h1mi0RIOQbXANsJxwAu4KLqiuTC1KqEJUWoB1xj88ogTxi4CEQhHWhOxuc+R+TS+IIi6bsmFCVC+QJYy9qAYfqPZNVuT2JdE1bkwxgzEsaEFynWUfYhWQcbSZqEib728c1n1lYjX8qlJG2F58pe2Fkacw8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762340414; c=relaxed/simple;
	bh=9JI6ZKt6SA1vq6zzU2qJJ6K2S+lKB/ARPOhKr7DrHD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgBTEnTRmZAjTKUGFqAitkhAiBU6IScfLEmh3xyweTMSQLqx64crfWqOjWdJcfWCesbSiY7c8NCJVbAbOEgDZ/TP/J5OY594GbrL9fOSS+AR69k+rr6n3UKp36lcJA/t1rzyLnF8ndwvkYKuaPYu12KshKTKpYpTO7BFAQdQcBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FISNXOCI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7PDYM1GS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rgkfWe0A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/uoTGEpt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D00F61F394;
	Wed,  5 Nov 2025 11:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762340407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B0EDhVOfadecWEHOedu+NJa48+ElQ1ksq1ANBGH5YYs=;
	b=FISNXOCIxqdw6IFZYgIljOnp6iAVwBZlUmKBXU4MATRPWfFq4BMlfHzhNYz9Za4GhEl1Pf
	Gr8gNS7hr/vtoxukP4roYp2Wb9/tDBkE73UYe4DrYwPFQIizfZkqg1SLio8Gz0FCxifE2C
	D4c12r5rvnlatoJQuMMcv7rmjEGG2rg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762340407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B0EDhVOfadecWEHOedu+NJa48+ElQ1ksq1ANBGH5YYs=;
	b=7PDYM1GSBYDgdrnak00uaudQF01Cg3swiRQmtd8czQLuUI0p57unXkBnD9IpnZ7465DWaz
	dIYk6663JdkzbECw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rgkfWe0A;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/uoTGEpt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762340405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B0EDhVOfadecWEHOedu+NJa48+ElQ1ksq1ANBGH5YYs=;
	b=rgkfWe0A0pItmPQSzMYqjjjz6I5ePXEenw35at98n9FP+Fj3U45nD+fLJ5EKoRRIJ32liO
	YZllOhkHrBQuwUUvdKOTspSRUaV9VIk1YrWAwn1PW/HvyEqXiHBbaBsl6InMvPVfnHRPRj
	3VTY0ALdb36C1PhLxfzpJBf7FQ0SzBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762340405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B0EDhVOfadecWEHOedu+NJa48+ElQ1ksq1ANBGH5YYs=;
	b=/uoTGEpt6PPY9Ld5kj7LDmNhNXDEG9wCkbx7G1PE6eHVsGZ6X4CI/HJiQl/ksjWWfe+EJL
	xvuZQ6LvgIWwP4Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBAED132DD;
	Wed,  5 Nov 2025 11:00:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SkbPLTUuC2lbdwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Nov 2025 11:00:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 69623A28C2; Wed,  5 Nov 2025 12:00:05 +0100 (CET)
Date: Wed, 5 Nov 2025 12:00:05 +0100
From: Jan Kara <jack@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, amir73il@gmail.com, jack@suse.cz, gabriel@krisman.be
Subject: Re: [PATCH 1/6] iomap: report file IO errors to fsnotify
Message-ID: <ewqcnrecsvpi5wy3mufy3swnf46ejnz4kc5ph2eb4iriftdddi@mamiprlrvi75>
References: <176230366393.1647991.7608961849841103569.stgit@frogsfrogsfrogs>
 <176230366453.1647991.17002688390201603817.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176230366453.1647991.17002688390201603817.stgit@frogsfrogsfrogs>
X-Rspamd-Queue-Id: D00F61F394
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lst.de,vger.kernel.org,gmail.com,suse.cz,krisman.be];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Tue 04-11-25 16:54:24, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create a generic hook for iomap filesystems to report IO errors to
> fsnotify and in-kernel subsystems that want to know about such things.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h     |   64 ++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/iomap/buffered-io.c |    6 +++++
>  fs/iomap/direct-io.c   |    5 ++++
>  fs/super.c             |   53 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 128 insertions(+)
> 
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 5e4b3a4b24823f..1cb3965db3275c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -80,6 +80,7 @@ struct fs_context;
>  struct fs_parameter_spec;
>  struct file_kattr;
>  struct iomap_ops;
> +struct notifier_head;
>  
>  extern void __init inode_init(void);
>  extern void __init inode_init_early(void);
> @@ -1587,6 +1588,7 @@ struct super_block {
>  
>  	spinlock_t		s_inode_wblist_lock;
>  	struct list_head	s_inodes_wb;	/* writeback inodes */
> +	struct blocking_notifier_head	s_error_notifier;
>  } __randomize_layout;
>  
>  static inline struct user_namespace *i_user_ns(const struct inode *inode)
> @@ -4069,4 +4071,66 @@ static inline bool extensible_ioctl_valid(unsigned int cmd_a,
>  	return true;
>  }
>  
> +enum fs_error_type {
> +	/* pagecache reads and writes */
> +	FSERR_READAHEAD,
> +	FSERR_WRITEBACK,
> +
> +	/* directio read and writes */
> +	FSERR_DIO_READ,
> +	FSERR_DIO_WRITE,
> +
> +	/* media error */
> +	FSERR_DATA_LOST,
> +
> +	/* filesystem metadata */
> +	FSERR_METADATA,
> +};
> +
> +struct fs_error {
> +	struct work_struct work;
> +	struct super_block *sb;
> +	struct inode *inode;
> +	loff_t pos;
> +	u64 len;
> +	enum fs_error_type type;
> +	int error;
> +};
> +
> +struct fs_error_hook {
> +	struct notifier_block nb;
> +};
> +
> +static inline int sb_hook_error(struct super_block *sb,
> +				struct fs_error_hook *h)
> +{
> +	return blocking_notifier_chain_register(&sb->s_error_notifier, &h->nb);
> +}
> +
> +static inline void sb_unhook_error(struct super_block *sb,
> +				   struct fs_error_hook *h)
> +{
> +	blocking_notifier_chain_unregister(&sb->s_error_notifier, &h->nb);
> +}
> +
> +static inline void sb_init_error_hook(struct fs_error_hook *h, notifier_fn_t fn)
> +{
> +	h->nb.notifier_call = fn;
> +	h->nb.priority = 0;
> +}
> +
> +void __sb_error(struct super_block *sb, struct inode *inode,
> +		enum fs_error_type type, loff_t pos, u64 len, int error);
> +
> +static inline void sb_error(struct super_block *sb, int error)
> +{
> +	__sb_error(sb, NULL, FSERR_METADATA, 0, 0, error);
> +}
> +
> +static inline void inode_error(struct inode *inode, enum fs_error_type type,
> +			       loff_t pos, u64 len, int error)
> +{
> +	__sb_error(inode->i_sb, inode, type, pos, len, error);
> +}
> +
>  #endif /* _LINUX_FS_H */
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8dd5421cb910b5..dc19311fe1c6c0 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -291,6 +291,12 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
>  inline void iomap_mapping_ioerror(struct address_space *mapping, int direction,
>  		loff_t pos, u64 len, int error)
>  {
> +	struct inode *inode = mapping->host;
> +
> +	inode_error(inode,
> +		    direction == READ ? FSERR_READAHEAD : FSERR_WRITEBACK,
> +		    pos, len, error);
> +
>  	if (mapping && mapping->a_ops->ioerror)
>  		mapping->a_ops->ioerror(mapping, direction, pos, len,
>  				error);
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 1512d8dbb0d2e7..9f6ce0d9c531bb 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -95,6 +95,11 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
>  
>  	if (dops && dops->end_io)
>  		ret = dops->end_io(iocb, dio->size, ret, dio->flags);
> +	if (dio->error)
> +		inode_error(file_inode(iocb->ki_filp),
> +			    (dio->flags & IOMAP_DIO_WRITE) ? FSERR_DIO_WRITE :
> +							     FSERR_DIO_READ,
> +			    offset, dio->size, dio->error);
>  	if (dio->error && dops && dops->ioerror)
>  		dops->ioerror(file_inode(iocb->ki_filp),
>  				(dio->flags & IOMAP_DIO_WRITE) ? WRITE : READ,
> diff --git a/fs/super.c b/fs/super.c
> index 5bab94fb7e0358..f6d38e4b3d76b2 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -363,6 +363,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
>  	spin_lock_init(&s->s_inode_list_lock);
>  	INIT_LIST_HEAD(&s->s_inodes_wb);
>  	spin_lock_init(&s->s_inode_wblist_lock);
> +	BLOCKING_INIT_NOTIFIER_HEAD(&s->s_error_notifier);
>  
>  	s->s_count = 1;
>  	atomic_set(&s->s_active, 1);
> @@ -2267,3 +2268,55 @@ int sb_init_dio_done_wq(struct super_block *sb)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(sb_init_dio_done_wq);
> +
> +static void handle_sb_error(struct work_struct *work)
> +{
> +	struct fs_error *fserr = container_of(work, struct fs_error, work);
> +
> +	fsnotify_sb_error(fserr->sb, fserr->inode, fserr->error);
> +	blocking_notifier_call_chain(&fserr->sb->s_error_notifier, fserr->type,
> +				     fserr);
> +	iput(fserr->inode);
> +	kfree(fserr);
> +}
> +
> +/**
> + * Report a filesystem error.  The actual work is deferred to a workqueue so
> + * that we're always in process context and to avoid blowing out the caller's
> + * stack.
> + *
> + * @sb Filesystem superblock
> + * @inode Inode within filesystem, if applicable
> + * @type Type of error
> + * @pos Start of file range affected, if applicable
> + * @len Length of file range affected, if applicable
> + * @error Error encountered.
> + */
> +void __sb_error(struct super_block *sb, struct inode *inode,
> +		enum fs_error_type type, loff_t pos, u64 len, int error)
> +{
> +	struct fs_error *fserr = kzalloc(sizeof(struct fs_error), GFP_ATOMIC);
> +
> +	if (!fserr) {
> +		printk(KERN_ERR
> + "lost fs error report for ino %lu type %u pos 0x%llx len 0x%llx error %d",
> +				inode ? inode->i_ino : 0, type,
> +				pos, len, error);
> +		return;
> +	}
> +
> +	if (inode) {
> +		fserr->sb = inode->i_sb;
> +		fserr->inode = igrab(inode);
> +	} else {
> +		fserr->sb = sb;
> +	}
> +	fserr->type = type;
> +	fserr->pos = pos;
> +	fserr->len = len;
> +	fserr->error = error;
> +	INIT_WORK(&fserr->work, handle_sb_error);
> +
> +	schedule_work(&fserr->work);
> +}
> +EXPORT_SYMBOL_GPL(__sb_error);
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

