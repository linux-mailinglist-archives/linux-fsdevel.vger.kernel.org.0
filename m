Return-Path: <linux-fsdevel+bounces-41517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F35FA30E29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 15:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE6C47A235C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 14:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1DF24E4D0;
	Tue, 11 Feb 2025 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gkc6qSuc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NbheNiTF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gkc6qSuc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NbheNiTF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B11E1EDA28;
	Tue, 11 Feb 2025 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739283899; cv=none; b=TtvlKde47VbfSDSsNqyHO8kCsJ/AYWJmiAXYGQ1MDFuFV1QLOFUvTPGz5O+xPWpV2/duJD7b09kjNs1h3PcW0oqlsIAK/Z/gAwLMElDbUoz2TVQVmvMysuBj9zjJ95MIe9uqQZgOo3EPjDm4ajVehH+0fWM3zyEJKLTDhAsW+I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739283899; c=relaxed/simple;
	bh=DN/CiudlUbUQPs4Q78QSjn+55Mn6VsEkYNtb0YcTn5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WobPwrQOgoxFkl52VgVElCaetTAuTfwC1+j25Tv7hlQffz59dC2k1P4dx0mKLoje7YkCorpnAdJC3VYKqnYh7Yg3I2F+jggTSTUbXrEwDKiJycW8HKGuw1kwNKNggzKdSoRQV6aroPQHPuq/7q6+Sp5Sz3H/w2KO22jEv8ilCCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gkc6qSuc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NbheNiTF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gkc6qSuc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NbheNiTF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C01D722CEC;
	Tue, 11 Feb 2025 13:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739279056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YFFibn67q20pZF197o1r5owqaCc643V0zxNj7E/kjN4=;
	b=Gkc6qSuc9SxbPUMJd0RXyIxC+qDNXQhkfkz4Z7DJkqEi/C1COHHFvRvPq5/0gzalAIPhvw
	YTtq7dbwm+FVnJNxlxlpLDJPdcloWhxTNpkUKbGQUWLRGFXD0CzeNHSN60kr6lPxUyup3X
	8u7BWAVJtw4jIMbVfnUPnf2xB17DZ6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739279056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YFFibn67q20pZF197o1r5owqaCc643V0zxNj7E/kjN4=;
	b=NbheNiTFlZV9Ck1t/YMc0phmvXzQNzcKE3N+nzAiLX6fwsKJpimlDvcHOB+v9ZzwGMs7ri
	V6p3b/6vlti2UjCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739279056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YFFibn67q20pZF197o1r5owqaCc643V0zxNj7E/kjN4=;
	b=Gkc6qSuc9SxbPUMJd0RXyIxC+qDNXQhkfkz4Z7DJkqEi/C1COHHFvRvPq5/0gzalAIPhvw
	YTtq7dbwm+FVnJNxlxlpLDJPdcloWhxTNpkUKbGQUWLRGFXD0CzeNHSN60kr6lPxUyup3X
	8u7BWAVJtw4jIMbVfnUPnf2xB17DZ6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739279056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YFFibn67q20pZF197o1r5owqaCc643V0zxNj7E/kjN4=;
	b=NbheNiTFlZV9Ck1t/YMc0phmvXzQNzcKE3N+nzAiLX6fwsKJpimlDvcHOB+v9ZzwGMs7ri
	V6p3b/6vlti2UjCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9B3013715;
	Tue, 11 Feb 2025 13:04:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id optsKdBKq2doMAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 11 Feb 2025 13:04:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 37081A095C; Tue, 11 Feb 2025 14:04:16 +0100 (CET)
Date: Tue, 11 Feb 2025 14:04:16 +0100
From: Jan Kara <jack@suse.cz>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Subject: Re: [PATCH v5 3/3] vfs: add notifications for mount attach and detach
Message-ID: <576qf3jt7zjimgmq2feegjk5mw7rgxwsvo7xsudpun4ai5ucvm@hpziug4gs3iy>
References: <20250129165803.72138-1-mszeredi@redhat.com>
 <20250129165803.72138-4-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129165803.72138-4-mszeredi@redhat.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,suse.cz,gmail.com,redhat.com,poettering.net,themaw.net,zeniv.linux.org.uk,paul-moore.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 29-01-25 17:58:01, Miklos Szeredi wrote:
> Add notifications for attaching and detaching mounts to fs/namespace.c
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/mount.h     | 20 +++++++++++++
>  fs/namespace.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  fs/pnode.c     |  4 ++-
>  3 files changed, 101 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/mount.h b/fs/mount.h
> index 5324a931b403..946dc8b792d7 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -5,6 +5,8 @@
>  #include <linux/ns_common.h>
>  #include <linux/fs_pin.h>
>  
> +extern struct list_head notify_list;
> +
>  struct mnt_namespace {
>  	struct ns_common	ns;
>  	struct mount *	root;
> @@ -80,6 +82,8 @@ struct mount {
>  #ifdef CONFIG_FSNOTIFY
>  	struct fsnotify_mark_connector __rcu *mnt_fsnotify_marks;
>  	__u32 mnt_fsnotify_mask;
> +	struct list_head to_notify;	/* need to queue notification */
> +	struct mnt_namespace *prev_ns;	/* previous namespace (NULL if none) */
>  #endif
>  	int mnt_id;			/* mount identifier, reused */
>  	u64 mnt_id_unique;		/* mount ID unique until reboot */
> @@ -182,4 +186,20 @@ static inline struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
>  	return container_of(ns, struct mnt_namespace, ns);
>  }
>  
> +#ifdef CONFIG_FSNOTIFY
> +static inline void mnt_notify_add(struct mount *m)
> +{
> +	/* Optimize the case where there are no watches */
> +	if ((m->mnt_ns && m->mnt_ns->n_fsnotify_marks) ||
> +	    (m->prev_ns && m->prev_ns->n_fsnotify_marks))
> +		list_add_tail(&m->to_notify, &notify_list);
> +	else
> +		m->prev_ns = m->mnt_ns;
> +}
> +#else
> +static inline void mnt_notify_add(struct mount *m)
> +{
> +}
> +#endif
> +
>  struct mnt_namespace *mnt_ns_from_dentry(struct dentry *dentry);
> diff --git a/fs/namespace.c b/fs/namespace.c
> index d8d70da56e7b..1e964b646509 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -81,6 +81,9 @@ static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
>  static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
>  static DEFINE_SEQLOCK(mnt_ns_tree_lock);
>  
> +#ifdef CONFIG_FSNOTIFY
> +LIST_HEAD(notify_list); /* protected by namespace_sem */
> +#endif
>  static struct rb_root mnt_ns_tree = RB_ROOT; /* protected by mnt_ns_tree_lock */
>  static LIST_HEAD(mnt_ns_list); /* protected by mnt_ns_tree_lock */
>  
> @@ -163,6 +166,7 @@ static void mnt_ns_release(struct mnt_namespace *ns)
>  {
>  	/* keep alive for {list,stat}mount() */
>  	if (refcount_dec_and_test(&ns->passive)) {
> +		fsnotify_mntns_delete(ns);
>  		put_user_ns(ns->user_ns);
>  		kfree(ns);
>  	}
> @@ -1176,6 +1180,8 @@ static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
>  		ns->mnt_first_node = &mnt->mnt_node;
>  	rb_link_node(&mnt->mnt_node, parent, link);
>  	rb_insert_color(&mnt->mnt_node, &ns->mounts);
> +
> +	mnt_notify_add(mnt);
>  }
>  
>  /*
> @@ -1723,6 +1729,50 @@ int may_umount(struct vfsmount *mnt)
>  
>  EXPORT_SYMBOL(may_umount);
>  
> +#ifdef CONFIG_FSNOTIFY
> +static void mnt_notify(struct mount *p)
> +{
> +	if (!p->prev_ns && p->mnt_ns) {
> +		fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
> +	} else if (p->prev_ns && !p->mnt_ns) {
> +		fsnotify_mnt_detach(p->prev_ns, &p->mnt);
> +	} else if (p->prev_ns == p->mnt_ns) {
> +		fsnotify_mnt_move(p->mnt_ns, &p->mnt);
> +	} else {
> +		fsnotify_mnt_detach(p->prev_ns, &p->mnt);
> +		fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
> +	}
> +	p->prev_ns = p->mnt_ns;
> +}
> +
> +static void notify_mnt_list(void)
> +{
> +	struct mount *m, *tmp;
> +	/*
> +	 * Notify about mounts that were added/reparented/detached/remain
> +	 * connected after unmount.
> +	 */
> +	list_for_each_entry_safe(m, tmp, &notify_list, to_notify) {
> +		mnt_notify(m);
> +		list_del_init(&m->to_notify);
> +	}
> +}
> +
> +static bool need_notify_mnt_list(void)
> +{
> +	return !list_empty(&notify_list);
> +}
> +#else
> +static void notify_mnt_list(void)
> +{
> +}
> +
> +static bool need_notify_mnt_list(void)
> +{
> +	return false;
> +}
> +#endif
> +
>  static void namespace_unlock(void)
>  {
>  	struct hlist_head head;
> @@ -1733,7 +1783,18 @@ static void namespace_unlock(void)
>  	hlist_move_list(&unmounted, &head);
>  	list_splice_init(&ex_mountpoints, &list);
>  
> -	up_write(&namespace_sem);
> +	if (need_notify_mnt_list()) {
> +		/*
> +		 * No point blocking out concurrent readers while notifications
> +		 * are sent. This will also allow statmount()/listmount() to run
> +		 * concurrently.
> +		 */
> +		downgrade_write(&namespace_sem);
> +		notify_mnt_list();
> +		up_read(&namespace_sem);
> +	} else {
> +		up_write(&namespace_sem);
> +	}
>  
>  	shrink_dentry_list(&list);
>  
> @@ -1846,6 +1907,19 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
>  		change_mnt_propagation(p, MS_PRIVATE);
>  		if (disconnect)
>  			hlist_add_head(&p->mnt_umount, &unmounted);
> +
> +		/*
> +		 * At this point p->mnt_ns is NULL, notification will be queued
> +		 * only if
> +		 *
> +		 *  - p->prev_ns is non-NULL *and*
> +		 *  - p->prev_ns->n_fsnotify_marks is non-NULL
> +		 *
> +		 * This will preclude queuing the mount if this is a cleanup
> +		 * after a failed copy_tree() or destruction of an anonymous
> +		 * namespace, etc.
> +		 */
> +		mnt_notify_add(p);
>  	}
>  }
>  
> @@ -2555,6 +2629,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>  			dest_mp = smp;
>  		unhash_mnt(source_mnt);
>  		attach_mnt(source_mnt, top_mnt, dest_mp, beneath);
> +		mnt_notify_add(source_mnt);
>  		touch_mnt_namespace(source_mnt->mnt_ns);
>  	} else {
>  		if (source_mnt->mnt_ns) {
> @@ -4476,6 +4551,8 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
>  	list_del_init(&new_mnt->mnt_expire);
>  	put_mountpoint(root_mp);
>  	unlock_mount_hash();
> +	mnt_notify_add(root_mnt);
> +	mnt_notify_add(new_mnt);
>  	chroot_fs_refs(&root, &new);
>  	error = 0;
>  out4:
> diff --git a/fs/pnode.c b/fs/pnode.c
> index ef048f008bdd..82d809c785ec 100644
> --- a/fs/pnode.c
> +++ b/fs/pnode.c
> @@ -549,8 +549,10 @@ static void restore_mounts(struct list_head *to_restore)
>  			mp = parent->mnt_mp;
>  			parent = parent->mnt_parent;
>  		}
> -		if (parent != mnt->mnt_parent)
> +		if (parent != mnt->mnt_parent) {
>  			mnt_change_mountpoint(parent, mp, mnt);
> +			mnt_notify_add(mnt);
> +		}
>  	}
>  }
>  
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

