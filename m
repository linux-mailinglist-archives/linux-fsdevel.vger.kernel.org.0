Return-Path: <linux-fsdevel+bounces-41519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD55A30EF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 16:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E0A188585A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 15:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D1224F5AA;
	Tue, 11 Feb 2025 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YslulnSR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DPucBIj7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YslulnSR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DPucBIj7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0DA3D69;
	Tue, 11 Feb 2025 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286048; cv=none; b=efOvbeIE/d+pjt8fkA+gZ2yWnNmqYT5wS7f2ZtejIY0z7NDBWoUBNiokHs8RPo3K/R86+Wo6YX7lhhNH2FWQZmAG+G/75nawEgkBjfokmf2ICewE5Gbkn0j6nkFgpeWrd/+6bfbGMmrB9N+A3wt2haqIC5nt2mMvZknWwVksaII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286048; c=relaxed/simple;
	bh=+XAdjg3nAQ55UtGE8yXdCg94BWO608DjUnjqAMQiztQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZbvf2nuc1GlpaG4efKfHxEC3953VSjC7SBhHISkqRe3dZromtSREMvKutf76BA6DA6JJs76gPxQLZWhjOqtLkEGFZAXJszpn5IBvDDD0WkmQneRJGvvBABKINE32IaHgr74J5UL7iLFHBHp4Wz+rnxyrm0/lxTk2PbIxbFDCHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YslulnSR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DPucBIj7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YslulnSR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DPucBIj7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 14EAE5C0EF;
	Tue, 11 Feb 2025 13:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739279147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K5ToiMDj+LJmXdAWXjXslty1cdzOUwqokjskgeAgRW0=;
	b=YslulnSRDpssOo0lQL9dayscqEkvAOIafUK0mIY7ojV6z4b0iOPpVADddYfX1sYfurTAoE
	pevtDHLqeaigkD68wf4fLqy/T8puipxA58qjMqvLmBJOwFK7ZGqup48krrXkDaOSxwPEBj
	X45oJVkuWZeWXpsexP3tGc2+Rqmu1NM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739279147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K5ToiMDj+LJmXdAWXjXslty1cdzOUwqokjskgeAgRW0=;
	b=DPucBIj7p+hT3DlhmZPPNAsFSNuBlAdisD+WGuw2vQ0iPXutGNjXmwI5mCB/L1wJmo4hw4
	7FCLCOHCc0951yCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739279147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K5ToiMDj+LJmXdAWXjXslty1cdzOUwqokjskgeAgRW0=;
	b=YslulnSRDpssOo0lQL9dayscqEkvAOIafUK0mIY7ojV6z4b0iOPpVADddYfX1sYfurTAoE
	pevtDHLqeaigkD68wf4fLqy/T8puipxA58qjMqvLmBJOwFK7ZGqup48krrXkDaOSxwPEBj
	X45oJVkuWZeWXpsexP3tGc2+Rqmu1NM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739279147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K5ToiMDj+LJmXdAWXjXslty1cdzOUwqokjskgeAgRW0=;
	b=DPucBIj7p+hT3DlhmZPPNAsFSNuBlAdisD+WGuw2vQ0iPXutGNjXmwI5mCB/L1wJmo4hw4
	7FCLCOHCc0951yCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F287F13715;
	Tue, 11 Feb 2025 13:05:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NBkzOypLq2cCMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 11 Feb 2025 13:05:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A3B0AA095C; Tue, 11 Feb 2025 14:05:31 +0100 (CET)
Date: Tue, 11 Feb 2025 14:05:31 +0100
From: Jan Kara <jack@suse.cz>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Subject: Re: [PATCH v5 1/3] fsnotify: add mount notification infrastructure
Message-ID: <s3vl2j7ahwsji5toll2k6z2uw3oujhhisdkl5xqusdgdq6b6z4@gba62ncxlxxp>
References: <20250129165803.72138-1-mszeredi@redhat.com>
 <20250129165803.72138-2-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129165803.72138-2-mszeredi@redhat.com>
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 29-01-25 17:57:59, Miklos Szeredi wrote:
> This is just the plumbing between the event source (fs/namespace.c) and the
> event consumer (fanotify).  In itself it does nothing.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/mount.h                       |  4 +++
>  fs/notify/fsnotify.c             | 47 +++++++++++++++++++++++++++-----
>  fs/notify/fsnotify.h             | 11 ++++++++
>  fs/notify/mark.c                 | 14 ++++++++--
>  include/linux/fsnotify.h         | 20 ++++++++++++++
>  include/linux/fsnotify_backend.h | 42 ++++++++++++++++++++++++++++
>  6 files changed, 128 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/mount.h b/fs/mount.h
> index ffb613cdfeee..82aa3bad7cf5 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -21,6 +21,10 @@ struct mnt_namespace {
>  		struct rcu_head		mnt_ns_rcu;
>  	};
>  	u64 event;
> +#ifdef CONFIG_FSNOTIFY
> +	__u32			n_fsnotify_mask;
> +	struct fsnotify_mark_connector __rcu *n_fsnotify_marks;
> +#endif
>  	unsigned int		nr_mounts; /* # of mounts in the namespace */
>  	unsigned int		pending_mounts;
>  	struct rb_node		mnt_ns_tree_node; /* node in the mnt_ns_tree */
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 8ee495a58d0a..c64b95cf50c7 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -28,6 +28,11 @@ void __fsnotify_vfsmount_delete(struct vfsmount *mnt)
>  	fsnotify_clear_marks_by_mount(mnt);
>  }
>  
> +void __fsnotify_mntns_delete(struct mnt_namespace *mntns)
> +{
> +	fsnotify_clear_marks_by_mntns(mntns);
> +}
> +
>  /**
>   * fsnotify_unmount_inodes - an sb is unmounting.  handle any watched inodes.
>   * @sb: superblock being unmounted.
> @@ -420,7 +425,7 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
>  				     file_name, cookie, iter_info);
>  }
>  
> -static struct fsnotify_mark *fsnotify_first_mark(struct fsnotify_mark_connector **connp)
> +static struct fsnotify_mark *fsnotify_first_mark(struct fsnotify_mark_connector *const *connp)
>  {
>  	struct fsnotify_mark_connector *conn;
>  	struct hlist_node *node = NULL;
> @@ -538,14 +543,15 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>  {
>  	const struct path *path = fsnotify_data_path(data, data_type);
>  	struct super_block *sb = fsnotify_data_sb(data, data_type);
> -	struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
> +	const struct fsnotify_mnt *mnt_data = fsnotify_data_mnt(data, data_type);
> +	struct fsnotify_sb_info *sbinfo = sb ? fsnotify_sb_info(sb) : NULL;
>  	struct fsnotify_iter_info iter_info = {};
>  	struct mount *mnt = NULL;
>  	struct inode *inode2 = NULL;
>  	struct dentry *moved;
>  	int inode2_type;
>  	int ret = 0;
> -	__u32 test_mask, marks_mask;
> +	__u32 test_mask, marks_mask = 0;
>  
>  	if (path)
>  		mnt = real_mount(path->mnt);
> @@ -578,17 +584,20 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>  	if ((!sbinfo || !sbinfo->sb_marks) &&
>  	    (!mnt || !mnt->mnt_fsnotify_marks) &&
>  	    (!inode || !inode->i_fsnotify_marks) &&
> -	    (!inode2 || !inode2->i_fsnotify_marks))
> +	    (!inode2 || !inode2->i_fsnotify_marks) &&
> +	    (!mnt_data || !mnt_data->ns->n_fsnotify_marks))
>  		return 0;
>  
> -	marks_mask = READ_ONCE(sb->s_fsnotify_mask);
> +	if (sb)
> +		marks_mask |= READ_ONCE(sb->s_fsnotify_mask);
>  	if (mnt)
>  		marks_mask |= READ_ONCE(mnt->mnt_fsnotify_mask);
>  	if (inode)
>  		marks_mask |= READ_ONCE(inode->i_fsnotify_mask);
>  	if (inode2)
>  		marks_mask |= READ_ONCE(inode2->i_fsnotify_mask);
> -
> +	if (mnt_data)
> +		marks_mask |= READ_ONCE(mnt_data->ns->n_fsnotify_mask);
>  
>  	/*
>  	 * If this is a modify event we may need to clear some ignore masks.
> @@ -618,6 +627,10 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>  		iter_info.marks[inode2_type] =
>  			fsnotify_first_mark(&inode2->i_fsnotify_marks);
>  	}
> +	if (mnt_data) {
> +		iter_info.marks[FSNOTIFY_ITER_TYPE_MNTNS] =
> +			fsnotify_first_mark(&mnt_data->ns->n_fsnotify_marks);
> +	}
>  
>  	/*
>  	 * We need to merge inode/vfsmount/sb mark lists so that e.g. inode mark
> @@ -702,11 +715,31 @@ void file_set_fsnotify_mode(struct file *file)
>  }
>  #endif
>  
> +void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount *mnt)
> +{
> +	struct fsnotify_mnt data = {
> +		.ns = ns,
> +		.mnt_id = real_mount(mnt)->mnt_id_unique,
> +	};
> +
> +	if (WARN_ON_ONCE(!ns))
> +		return;
> +
> +	/*
> +	 * This is an optimization as well as making sure fsnotify_init() has
> +	 * been called.
> +	 */
> +	if (!ns->n_fsnotify_marks)
> +		return;
> +
> +	fsnotify(mask, &data, FSNOTIFY_EVENT_MNT, NULL, NULL, NULL, 0);
> +}
> +
>  static __init int fsnotify_init(void)
>  {
>  	int ret;
>  
> -	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 24);
> +	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 26);
>  
>  	ret = init_srcu_struct(&fsnotify_mark_srcu);
>  	if (ret)
> diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
> index 663759ed6fbc..5950c7a67f41 100644
> --- a/fs/notify/fsnotify.h
> +++ b/fs/notify/fsnotify.h
> @@ -33,6 +33,12 @@ static inline struct super_block *fsnotify_conn_sb(
>  	return conn->obj;
>  }
>  
> +static inline struct mnt_namespace *fsnotify_conn_mntns(
> +				struct fsnotify_mark_connector *conn)
> +{
> +	return conn->obj;
> +}
> +
>  static inline struct super_block *fsnotify_object_sb(void *obj,
>  			enum fsnotify_obj_type obj_type)
>  {
> @@ -89,6 +95,11 @@ static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
>  	fsnotify_destroy_marks(fsnotify_sb_marks(sb));
>  }
>  
> +static inline void fsnotify_clear_marks_by_mntns(struct mnt_namespace *mntns)
> +{
> +	fsnotify_destroy_marks(&mntns->n_fsnotify_marks);
> +}
> +
>  /*
>   * update the dentry->d_flags of all of inode's children to indicate if inode cares
>   * about events that happen to its children.
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index 4981439e6209..798340db69d7 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -107,6 +107,8 @@ static fsnotify_connp_t *fsnotify_object_connp(void *obj,
>  		return &real_mount(obj)->mnt_fsnotify_marks;
>  	case FSNOTIFY_OBJ_TYPE_SB:
>  		return fsnotify_sb_marks(obj);
> +	case FSNOTIFY_OBJ_TYPE_MNTNS:
> +		return &((struct mnt_namespace *)obj)->n_fsnotify_marks;
>  	default:
>  		return NULL;
>  	}
> @@ -120,6 +122,8 @@ static __u32 *fsnotify_conn_mask_p(struct fsnotify_mark_connector *conn)
>  		return &fsnotify_conn_mount(conn)->mnt_fsnotify_mask;
>  	else if (conn->type == FSNOTIFY_OBJ_TYPE_SB)
>  		return &fsnotify_conn_sb(conn)->s_fsnotify_mask;
> +	else if (conn->type == FSNOTIFY_OBJ_TYPE_MNTNS)
> +		return &fsnotify_conn_mntns(conn)->n_fsnotify_mask;
>  	return NULL;
>  }
>  
> @@ -346,12 +350,15 @@ static void *fsnotify_detach_connector_from_object(
>  		fsnotify_conn_mount(conn)->mnt_fsnotify_mask = 0;
>  	} else if (conn->type == FSNOTIFY_OBJ_TYPE_SB) {
>  		fsnotify_conn_sb(conn)->s_fsnotify_mask = 0;
> +	} else if (conn->type == FSNOTIFY_OBJ_TYPE_MNTNS) {
> +		fsnotify_conn_mntns(conn)->n_fsnotify_mask = 0;
>  	}
>  
>  	rcu_assign_pointer(*connp, NULL);
>  	conn->obj = NULL;
>  	conn->type = FSNOTIFY_OBJ_TYPE_DETACHED;
> -	fsnotify_update_sb_watchers(sb, conn);
> +	if (sb)
> +		fsnotify_update_sb_watchers(sb, conn);
>  
>  	return inode;
>  }
> @@ -724,7 +731,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark, void *obj,
>  	 * Attach the sb info before attaching a connector to any object on sb.
>  	 * The sb info will remain attached as long as sb lives.
>  	 */
> -	if (!fsnotify_sb_info(sb)) {
> +	if (sb && !fsnotify_sb_info(sb)) {
>  		err = fsnotify_attach_info_to_sb(sb);
>  		if (err)
>  			return err;
> @@ -770,7 +777,8 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark, void *obj,
>  	/* mark should be the last entry.  last is the current last entry */
>  	hlist_add_behind_rcu(&mark->obj_list, &last->obj_list);
>  added:
> -	fsnotify_update_sb_watchers(sb, conn);
> +	if (sb)
> +		fsnotify_update_sb_watchers(sb, conn);
>  	/*
>  	 * Since connector is attached to object using cmpxchg() we are
>  	 * guaranteed that connector initialization is fully visible by anyone
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 1a9ef8f6784d..589e274adc7d 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -299,6 +299,11 @@ static inline void fsnotify_vfsmount_delete(struct vfsmount *mnt)
>  	__fsnotify_vfsmount_delete(mnt);
>  }
>  
> +static inline void fsnotify_mntns_delete(struct mnt_namespace *mntns)
> +{
> +	__fsnotify_mntns_delete(mntns);
> +}
> +
>  /*
>   * fsnotify_inoderemove - an inode is going away
>   */
> @@ -507,4 +512,19 @@ static inline int fsnotify_sb_error(struct super_block *sb, struct inode *inode,
>  			NULL, NULL, NULL, 0);
>  }
>  
> +static inline void fsnotify_mnt_attach(struct mnt_namespace *ns, struct vfsmount *mnt)
> +{
> +	fsnotify_mnt(FS_MNT_ATTACH, ns, mnt);
> +}
> +
> +static inline void fsnotify_mnt_detach(struct mnt_namespace *ns, struct vfsmount *mnt)
> +{
> +	fsnotify_mnt(FS_MNT_DETACH, ns, mnt);
> +}
> +
> +static inline void fsnotify_mnt_move(struct mnt_namespace *ns, struct vfsmount *mnt)
> +{
> +	fsnotify_mnt(FS_MNT_MOVE, ns, mnt);
> +}
> +
>  #endif	/* _LINUX_FS_NOTIFY_H */
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 0d24a21a8e60..6cd8d1d28b8b 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -59,6 +59,10 @@
>  
>  #define FS_PRE_ACCESS		0x00100000	/* Pre-content access hook */
>  
> +#define FS_MNT_ATTACH		0x01000000	/* Mount was attached */
> +#define FS_MNT_DETACH		0x02000000	/* Mount was detached */
> +#define FS_MNT_MOVE		(FS_MNT_ATTACH | FS_MNT_DETACH)
> +
>  /*
>   * Set on inode mark that cares about things that happen to its children.
>   * Always set for dnotify and inotify.
> @@ -80,6 +84,9 @@
>   */
>  #define ALL_FSNOTIFY_DIRENT_EVENTS (FS_CREATE | FS_DELETE | FS_MOVE | FS_RENAME)
>  
> +/* Mount namespace events */
> +#define FSNOTIFY_MNT_EVENTS (FS_MNT_ATTACH | FS_MNT_DETACH)
> +
>  /* Content events can be used to inspect file content */
>  #define FSNOTIFY_CONTENT_PERM_EVENTS (FS_OPEN_PERM | FS_OPEN_EXEC_PERM | \
>  				      FS_ACCESS_PERM)
> @@ -108,6 +115,7 @@
>  
>  /* Events that can be reported to backends */
>  #define ALL_FSNOTIFY_EVENTS (ALL_FSNOTIFY_DIRENT_EVENTS | \
> +			     FSNOTIFY_MNT_EVENTS | \
>  			     FS_EVENTS_POSS_ON_CHILD | \
>  			     FS_DELETE_SELF | FS_MOVE_SELF | \
>  			     FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED | \
> @@ -298,6 +306,7 @@ enum fsnotify_data_type {
>  	FSNOTIFY_EVENT_PATH,
>  	FSNOTIFY_EVENT_INODE,
>  	FSNOTIFY_EVENT_DENTRY,
> +	FSNOTIFY_EVENT_MNT,
>  	FSNOTIFY_EVENT_ERROR,
>  };
>  
> @@ -318,6 +327,11 @@ static inline const struct path *file_range_path(const struct file_range *range)
>  	return range->path;
>  }
>  
> +struct fsnotify_mnt {
> +	const struct mnt_namespace *ns;
> +	u64 mnt_id;
> +};
> +
>  static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
>  {
>  	switch (data_type) {
> @@ -383,6 +397,24 @@ static inline struct super_block *fsnotify_data_sb(const void *data,
>  	}
>  }
>  
> +static inline const struct fsnotify_mnt *fsnotify_data_mnt(const void *data,
> +							   int data_type)
> +{
> +	switch (data_type) {
> +	case FSNOTIFY_EVENT_MNT:
> +		return data;
> +	default:
> +		return NULL;
> +	}
> +}
> +
> +static inline u64 fsnotify_data_mnt_id(const void *data, int data_type)
> +{
> +	const struct fsnotify_mnt *mnt_data = fsnotify_data_mnt(data, data_type);
> +
> +	return mnt_data ? mnt_data->mnt_id : 0;
> +}
> +
>  static inline struct fs_error_report *fsnotify_data_error_report(
>  							const void *data,
>  							int data_type)
> @@ -420,6 +452,7 @@ enum fsnotify_iter_type {
>  	FSNOTIFY_ITER_TYPE_SB,
>  	FSNOTIFY_ITER_TYPE_PARENT,
>  	FSNOTIFY_ITER_TYPE_INODE2,
> +	FSNOTIFY_ITER_TYPE_MNTNS,
>  	FSNOTIFY_ITER_TYPE_COUNT
>  };
>  
> @@ -429,6 +462,7 @@ enum fsnotify_obj_type {
>  	FSNOTIFY_OBJ_TYPE_INODE,
>  	FSNOTIFY_OBJ_TYPE_VFSMOUNT,
>  	FSNOTIFY_OBJ_TYPE_SB,
> +	FSNOTIFY_OBJ_TYPE_MNTNS,
>  	FSNOTIFY_OBJ_TYPE_COUNT,
>  	FSNOTIFY_OBJ_TYPE_DETACHED = FSNOTIFY_OBJ_TYPE_COUNT
>  };
> @@ -613,8 +647,10 @@ extern int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data
>  extern void __fsnotify_inode_delete(struct inode *inode);
>  extern void __fsnotify_vfsmount_delete(struct vfsmount *mnt);
>  extern void fsnotify_sb_delete(struct super_block *sb);
> +extern void __fsnotify_mntns_delete(struct mnt_namespace *mntns);
>  extern void fsnotify_sb_free(struct super_block *sb);
>  extern u32 fsnotify_get_cookie(void);
> +extern void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount *mnt);
>  
>  static inline __u32 fsnotify_parent_needed_mask(__u32 mask)
>  {
> @@ -928,6 +964,9 @@ static inline void __fsnotify_vfsmount_delete(struct vfsmount *mnt)
>  static inline void fsnotify_sb_delete(struct super_block *sb)
>  {}
>  
> +static inline void __fsnotify_mntns_delete(struct mnt_namespace *mntns)
> +{}
> +
>  static inline void fsnotify_sb_free(struct super_block *sb)
>  {}
>  
> @@ -942,6 +981,9 @@ static inline u32 fsnotify_get_cookie(void)
>  static inline void fsnotify_unmount_inodes(struct super_block *sb)
>  {}
>  
> +static inline void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount *mnt)
> +{}
> +
>  #endif	/* CONFIG_FSNOTIFY */
>  
>  #endif	/* __KERNEL __ */
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

