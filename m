Return-Path: <linux-fsdevel+bounces-62574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9183B99B33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 13:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC3C4C3640
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 11:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B182FFDF3;
	Wed, 24 Sep 2025 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RKtEV/zn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mcrvgx0q";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RKtEV/zn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mcrvgx0q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7042FFDC0
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715149; cv=none; b=bPFo+LvDF0X4LBvpZyxomkmMCnmp46aoxvFm/yFI7z9PJBvIghyHfsbb6iml/5VZ3MTX17cxZHYzVtHaFWdE6ZyXCF/E1frTjbk60z02qgN7xs/trIdW0opB3SymtCV8JLI5vfjL4l8wIIYAqQpEAJDnjPlMWFXBgjYwMWx02W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715149; c=relaxed/simple;
	bh=WzWZTe/jQvniz02JkQ8K0mN0CDhN/MlUNJx9722GGjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuuRZSEkIpeb1XZKVZBkrMbtble4gKoP7EKC1O0jdTnuYyRL9CbXCBDafqX9HUsw2LBJW3/HqS2odJBGCL8oVGXRY0MywNdcGYLuLgNCWo0gFTUdTeUeu+p+ad0s6mxZ2KPa9aB1Ldj4f9elSz7d7SPnZUEdbKQY/ke+wiaeKJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RKtEV/zn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mcrvgx0q; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RKtEV/zn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mcrvgx0q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4DC613415A;
	Wed, 24 Sep 2025 11:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758715141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERqSBBGUqESJzn4ijffoYQoeuaKdfrarGQW41Aic/qI=;
	b=RKtEV/zn3v6dVyoDch3+S7FXyOqkL1g1hHWXmLudc5fQnYnqP+SJ0C+X2TQU22TBu1tV0+
	7DrfoKOo/rry9stIMS2dET4u2p16aiSEZEvEsvjIUeKbm3BLPMrhCQEvTviZ9pjs6jhc3d
	IbKYFQW1HAdQRo9uk2XB9L+CTJTk9no=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758715141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERqSBBGUqESJzn4ijffoYQoeuaKdfrarGQW41Aic/qI=;
	b=mcrvgx0qjOXZIIvPjGpW/VhyOexnPa/A6tWjxWgBWoozT8ZpaEaE/HX5CIo4tqZNA9pGoK
	F5CAjjNQ7vmQ8lDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="RKtEV/zn";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mcrvgx0q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758715141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERqSBBGUqESJzn4ijffoYQoeuaKdfrarGQW41Aic/qI=;
	b=RKtEV/zn3v6dVyoDch3+S7FXyOqkL1g1hHWXmLudc5fQnYnqP+SJ0C+X2TQU22TBu1tV0+
	7DrfoKOo/rry9stIMS2dET4u2p16aiSEZEvEsvjIUeKbm3BLPMrhCQEvTviZ9pjs6jhc3d
	IbKYFQW1HAdQRo9uk2XB9L+CTJTk9no=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758715141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERqSBBGUqESJzn4ijffoYQoeuaKdfrarGQW41Aic/qI=;
	b=mcrvgx0qjOXZIIvPjGpW/VhyOexnPa/A6tWjxWgBWoozT8ZpaEaE/HX5CIo4tqZNA9pGoK
	F5CAjjNQ7vmQ8lDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C0CE13647;
	Wed, 24 Sep 2025 11:59:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HYykDgXd02h3SAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Sep 2025 11:59:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EBA95A0A9A; Wed, 24 Sep 2025 13:58:56 +0200 (CEST)
Date: Wed, 24 Sep 2025 13:58:56 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Aleksa Sarai <cyphar@cyphar.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Jakub Kicinski <kuba@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] ns: move ns type into struct ns_common
Message-ID: <xazkdfypqztvzpczc47ujgkgjviq6sav3kslttz264tcho7gmr@i4qnm7lrd5xc>
References: <20250924-work-namespaces-fixes-v1-0-8fb682c8678e@kernel.org>
 <20250924-work-namespaces-fixes-v1-2-8fb682c8678e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-work-namespaces-fixes-v1-2-8fb682c8678e@kernel.org>
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
	RCPT_COUNT_TWELVE(0.00)[20];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,suse.cz,cmpxchg.org,suse.com,linutronix.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 4DC613415A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Wed 24-09-25 13:33:59, Christian Brauner wrote:
> It's misplaced in struct proc_ns_operations and ns->ops might be NULL if
> the namespace is compiled out but we still want to know the type of the
> namespace for the initial namespace struct.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namespace.c            |  6 +++---
>  fs/nsfs.c                 | 18 +++++++++---------
>  include/linux/ns_common.h | 30 +++++++++++++++++++++++++-----
>  include/linux/proc_ns.h   |  1 -
>  init/version-timestamp.c  |  1 +
>  ipc/msgutil.c             |  1 +
>  ipc/namespace.c           |  1 -
>  kernel/cgroup/cgroup.c    |  1 +
>  kernel/cgroup/namespace.c |  1 -
>  kernel/nscommon.c         |  5 +++--
>  kernel/nsproxy.c          |  4 ++--
>  kernel/nstree.c           |  8 ++++----
>  kernel/pid.c              |  1 +
>  kernel/pid_namespace.c    |  2 --
>  kernel/time/namespace.c   |  3 +--
>  kernel/user.c             |  1 +
>  kernel/user_namespace.c   |  1 -
>  kernel/utsname.c          |  1 -
>  net/core/net_namespace.c  |  1 -
>  19 files changed, 52 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index d65917ec5544..01334d5038a2 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4927,7 +4927,7 @@ static int build_mount_idmapped(const struct mount_attr *attr, size_t usize,
>  		return -EINVAL;
>  
>  	ns = get_proc_ns(file_inode(fd_file(f)));
> -	if (ns->ops->type != CLONE_NEWUSER)
> +	if (ns->ns_type != CLONE_NEWUSER)
>  		return -EINVAL;
>  
>  	/*
> @@ -5830,7 +5830,7 @@ static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_req *kreq
>  			return ERR_PTR(-EINVAL);
>  
>  		ns = get_proc_ns(file_inode(fd_file(f)));
> -		if (ns->ops->type != CLONE_NEWNS)
> +		if (ns->ns_type != CLONE_NEWNS)
>  			return ERR_PTR(-EINVAL);
>  
>  		mnt_ns = to_mnt_ns(ns);
> @@ -6016,6 +6016,7 @@ struct mnt_namespace init_mnt_ns = {
>  	.ns.ops		= &mntns_operations,
>  	.user_ns	= &init_user_ns,
>  	.ns.__ns_ref	= REFCOUNT_INIT(1),
> +	.ns.ns_type	= ns_common_type(&init_mnt_ns),
>  	.passive	= REFCOUNT_INIT(1),
>  	.mounts		= RB_ROOT,
>  	.poll		= __WAIT_QUEUE_HEAD_INITIALIZER(init_mnt_ns.poll),
> @@ -6333,7 +6334,6 @@ static struct user_namespace *mntns_owner(struct ns_common *ns)
>  
>  const struct proc_ns_operations mntns_operations = {
>  	.name		= "mnt",
> -	.type		= CLONE_NEWNS,
>  	.get		= mntns_get,
>  	.put		= mntns_put,
>  	.install	= mntns_install,
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index dc0a4404b971..e7fd8a790aaa 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -219,9 +219,9 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
>  			return -EINVAL;
>  		return open_related_ns(ns, ns->ops->get_parent);
>  	case NS_GET_NSTYPE:
> -		return ns->ops->type;
> +		return ns->ns_type;
>  	case NS_GET_OWNER_UID:
> -		if (ns->ops->type != CLONE_NEWUSER)
> +		if (ns->ns_type != CLONE_NEWUSER)
>  			return -EINVAL;
>  		user_ns = container_of(ns, struct user_namespace, ns);
>  		argp = (uid_t __user *) arg;
> @@ -234,7 +234,7 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
>  	case NS_GET_PID_IN_PIDNS:
>  		fallthrough;
>  	case NS_GET_TGID_IN_PIDNS: {
> -		if (ns->ops->type != CLONE_NEWPID)
> +		if (ns->ns_type != CLONE_NEWPID)
>  			return -EINVAL;
>  
>  		ret = -ESRCH;
> @@ -273,7 +273,7 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
>  		return ret;
>  	}
>  	case NS_GET_MNTNS_ID:
> -		if (ns->ops->type != CLONE_NEWNS)
> +		if (ns->ns_type != CLONE_NEWNS)
>  			return -EINVAL;
>  		fallthrough;
>  	case NS_GET_ID: {
> @@ -293,7 +293,7 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
>  		struct mnt_ns_info __user *uinfo = (struct mnt_ns_info __user *)arg;
>  		size_t usize = _IOC_SIZE(ioctl);
>  
> -		if (ns->ops->type != CLONE_NEWNS)
> +		if (ns->ns_type != CLONE_NEWNS)
>  			return -EINVAL;
>  
>  		if (!uinfo)
> @@ -314,7 +314,7 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
>  		struct file *f __free(fput) = NULL;
>  		size_t usize = _IOC_SIZE(ioctl);
>  
> -		if (ns->ops->type != CLONE_NEWNS)
> +		if (ns->ns_type != CLONE_NEWNS)
>  			return -EINVAL;
>  
>  		if (usize < MNT_NS_INFO_SIZE_VER0)
> @@ -453,7 +453,7 @@ static int nsfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
>  	}
>  
>  	fid->ns_id	= ns->ns_id;
> -	fid->ns_type	= ns->ops->type;
> +	fid->ns_type	= ns->ns_type;
>  	fid->ns_inum	= inode->i_ino;
>  	return FILEID_NSFS;
>  }
> @@ -489,14 +489,14 @@ static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
>  			return NULL;
>  
>  		VFS_WARN_ON_ONCE(ns->ns_id != fid->ns_id);
> -		VFS_WARN_ON_ONCE(ns->ops->type != fid->ns_type);
> +		VFS_WARN_ON_ONCE(ns->ns_type != fid->ns_type);
>  		VFS_WARN_ON_ONCE(ns->inum != fid->ns_inum);
>  
>  		if (!__ns_ref_get(ns))
>  			return NULL;
>  	}
>  
> -	switch (ns->ops->type) {
> +	switch (ns->ns_type) {
>  #ifdef CONFIG_CGROUPS
>  	case CLONE_NEWCGROUP:
>  		if (!current_in_namespace(to_cg_ns(ns)))
> diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
> index 56492cd9ff8d..f5b68b8abb54 100644
> --- a/include/linux/ns_common.h
> +++ b/include/linux/ns_common.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/refcount.h>
>  #include <linux/rbtree.h>
> +#include <uapi/linux/sched.h>
>  
>  struct proc_ns_operations;
>  
> @@ -37,6 +38,7 @@ extern const struct proc_ns_operations timens_operations;
>  extern const struct proc_ns_operations timens_for_children_operations;
>  
>  struct ns_common {
> +	u32 ns_type;
>  	struct dentry *stashed;
>  	const struct proc_ns_operations *ops;
>  	unsigned int inum;
> @@ -51,7 +53,7 @@ struct ns_common {
>  	};
>  };
>  
> -int __ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops, int inum);
> +int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops, int inum);
>  void __ns_common_free(struct ns_common *ns);
>  
>  #define to_ns_common(__ns)                                    \
> @@ -106,10 +108,28 @@ void __ns_common_free(struct ns_common *ns);
>  		struct user_namespace *:   (IS_ENABLED(CONFIG_USER_NS) ? &userns_operations   : NULL), \
>  		struct uts_namespace *:    (IS_ENABLED(CONFIG_UTS_NS)  ? &utsns_operations    : NULL))
>  
> -#define ns_common_init(__ns) \
> -	__ns_common_init(to_ns_common(__ns), to_ns_operations(__ns), (((__ns) == ns_init_ns(__ns)) ? ns_init_inum(__ns) : 0))
> -
> -#define ns_common_init_inum(__ns, __inum) __ns_common_init(to_ns_common(__ns), to_ns_operations(__ns), __inum)
> +#define ns_common_type(__ns)                                \
> +	_Generic((__ns),                                    \
> +		struct cgroup_namespace *: CLONE_NEWCGROUP, \
> +		struct ipc_namespace *:    CLONE_NEWIPC,    \
> +		struct mnt_namespace *:    CLONE_NEWNS,     \
> +		struct net *:              CLONE_NEWNET,    \
> +		struct pid_namespace *:    CLONE_NEWPID,    \
> +		struct time_namespace *:   CLONE_NEWTIME,   \
> +		struct user_namespace *:   CLONE_NEWUSER,   \
> +		struct uts_namespace *:    CLONE_NEWUTS)
> +
> +#define ns_common_init(__ns)                     \
> +	__ns_common_init(to_ns_common(__ns),     \
> +			 ns_common_type(__ns),   \
> +			 to_ns_operations(__ns), \
> +			 (((__ns) == ns_init_ns(__ns)) ? ns_init_inum(__ns) : 0))
> +
> +#define ns_common_init_inum(__ns, __inum)        \
> +	__ns_common_init(to_ns_common(__ns),     \
> +			 ns_common_type(__ns),   \
> +			 to_ns_operations(__ns), \
> +			 __inum)
>  
>  #define ns_common_free(__ns) __ns_common_free(to_ns_common((__ns)))
>  
> diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
> index 08016f6e0e6f..e81b8e596e4f 100644
> --- a/include/linux/proc_ns.h
> +++ b/include/linux/proc_ns.h
> @@ -17,7 +17,6 @@ struct inode;
>  struct proc_ns_operations {
>  	const char *name;
>  	const char *real_ns_name;
> -	int type;
>  	struct ns_common *(*get)(struct task_struct *task);
>  	void (*put)(struct ns_common *ns);
>  	int (*install)(struct nsset *nsset, struct ns_common *ns);
> diff --git a/init/version-timestamp.c b/init/version-timestamp.c
> index 376b7c856d4d..d071835121c2 100644
> --- a/init/version-timestamp.c
> +++ b/init/version-timestamp.c
> @@ -8,6 +8,7 @@
>  #include <linux/utsname.h>
>  
>  struct uts_namespace init_uts_ns = {
> +	.ns.ns_type = ns_common_type(&init_uts_ns),
>  	.ns.__ns_ref = REFCOUNT_INIT(2),
>  	.name = {
>  		.sysname	= UTS_SYSNAME,
> diff --git a/ipc/msgutil.c b/ipc/msgutil.c
> index dca6c8ec8f5f..7a03f6d03de3 100644
> --- a/ipc/msgutil.c
> +++ b/ipc/msgutil.c
> @@ -33,6 +33,7 @@ struct ipc_namespace init_ipc_ns = {
>  #ifdef CONFIG_IPC_NS
>  	.ns.ops = &ipcns_operations,
>  #endif
> +	.ns.ns_type = ns_common_type(&init_ipc_ns),
>  };
>  
>  struct msg_msgseg {
> diff --git a/ipc/namespace.c b/ipc/namespace.c
> index d89dfd718d2b..76abac74a5c3 100644
> --- a/ipc/namespace.c
> +++ b/ipc/namespace.c
> @@ -248,7 +248,6 @@ static struct user_namespace *ipcns_owner(struct ns_common *ns)
>  
>  const struct proc_ns_operations ipcns_operations = {
>  	.name		= "ipc",
> -	.type		= CLONE_NEWIPC,
>  	.get		= ipcns_get,
>  	.put		= ipcns_put,
>  	.install	= ipcns_install,
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 245b43ff2fa4..9b75102e81cb 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -224,6 +224,7 @@ struct cgroup_namespace init_cgroup_ns = {
>  	.ns.ops		= &cgroupns_operations,
>  	.ns.inum	= ns_init_inum(&init_cgroup_ns),
>  	.root_cset	= &init_css_set,
> +	.ns.ns_type	= ns_common_type(&init_cgroup_ns),
>  };
>  
>  static struct file_system_type cgroup2_fs_type;
> diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
> index 04c98338ac08..241ca05f07c8 100644
> --- a/kernel/cgroup/namespace.c
> +++ b/kernel/cgroup/namespace.c
> @@ -137,7 +137,6 @@ static struct user_namespace *cgroupns_owner(struct ns_common *ns)
>  
>  const struct proc_ns_operations cgroupns_operations = {
>  	.name		= "cgroup",
> -	.type		= CLONE_NEWCGROUP,
>  	.get		= cgroupns_get,
>  	.put		= cgroupns_put,
>  	.install	= cgroupns_install,
> diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> index 3cef89ddef41..92c9df1e8774 100644
> --- a/kernel/nscommon.c
> +++ b/kernel/nscommon.c
> @@ -7,7 +7,7 @@
>  #ifdef CONFIG_DEBUG_VFS
>  static void ns_debug(struct ns_common *ns, const struct proc_ns_operations *ops)
>  {
> -	switch (ns->ops->type) {
> +	switch (ns->ns_type) {
>  #ifdef CONFIG_CGROUPS
>  	case CLONE_NEWCGROUP:
>  		VFS_WARN_ON_ONCE(ops != &cgroupns_operations);
> @@ -52,12 +52,13 @@ static void ns_debug(struct ns_common *ns, const struct proc_ns_operations *ops)
>  }
>  #endif
>  
> -int __ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops, int inum)
> +int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops, int inum)
>  {
>  	refcount_set(&ns->__ns_ref, 1);
>  	ns->stashed = NULL;
>  	ns->ops = ops;
>  	ns->ns_id = 0;
> +	ns->ns_type = ns_type;
>  	RB_CLEAR_NODE(&ns->ns_tree_node);
>  	INIT_LIST_HEAD(&ns->ns_list_node);
>  
> diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> index 5f31fdff8a38..8d62449237b6 100644
> --- a/kernel/nsproxy.c
> +++ b/kernel/nsproxy.c
> @@ -545,9 +545,9 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
>  
>  	if (proc_ns_file(fd_file(f))) {
>  		ns = get_proc_ns(file_inode(fd_file(f)));
> -		if (flags && (ns->ops->type != flags))
> +		if (flags && (ns->ns_type != flags))
>  			err = -EINVAL;
> -		flags = ns->ops->type;
> +		flags = ns->ns_type;
>  	} else if (!IS_ERR(pidfd_pid(fd_file(f)))) {
>  		err = check_setns_flags(flags);
>  	} else {
> diff --git a/kernel/nstree.c b/kernel/nstree.c
> index 113d681857f1..ef956924db06 100644
> --- a/kernel/nstree.c
> +++ b/kernel/nstree.c
> @@ -105,7 +105,7 @@ void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree)
>  
>  	write_seqlock(&ns_tree->ns_tree_lock);
>  
> -	VFS_WARN_ON_ONCE(ns->ops->type != ns_tree->type);
> +	VFS_WARN_ON_ONCE(ns->ns_type != ns_tree->type);
>  
>  	node = rb_find_add_rcu(&ns->ns_tree_node, &ns_tree->ns_tree, ns_cmp);
>  	/*
> @@ -127,7 +127,7 @@ void __ns_tree_remove(struct ns_common *ns, struct ns_tree *ns_tree)
>  {
>  	VFS_WARN_ON_ONCE(RB_EMPTY_NODE(&ns->ns_tree_node));
>  	VFS_WARN_ON_ONCE(list_empty(&ns->ns_list_node));
> -	VFS_WARN_ON_ONCE(ns->ops->type != ns_tree->type);
> +	VFS_WARN_ON_ONCE(ns->ns_type != ns_tree->type);
>  
>  	write_seqlock(&ns_tree->ns_tree_lock);
>  	rb_erase(&ns->ns_tree_node, &ns_tree->ns_tree);
> @@ -196,7 +196,7 @@ struct ns_common *ns_tree_lookup_rcu(u64 ns_id, int ns_type)
>  	if (!node)
>  		return NULL;
>  
> -	VFS_WARN_ON_ONCE(node_to_ns(node)->ops->type != ns_type);
> +	VFS_WARN_ON_ONCE(node_to_ns(node)->ns_type != ns_type);
>  
>  	return node_to_ns(node);
>  }
> @@ -224,7 +224,7 @@ struct ns_common *__ns_tree_adjoined_rcu(struct ns_common *ns,
>  	if (list_is_head(list, &ns_tree->ns_list))
>  		return ERR_PTR(-ENOENT);
>  
> -	VFS_WARN_ON_ONCE(list_entry_rcu(list, struct ns_common, ns_list_node)->ops->type != ns_tree->type);
> +	VFS_WARN_ON_ONCE(list_entry_rcu(list, struct ns_common, ns_list_node)->ns_type != ns_tree->type);
>  
>  	return list_entry_rcu(list, struct ns_common, ns_list_node);
>  }
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 7e8c66e0bf67..0c2dcddb317a 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -85,6 +85,7 @@ struct pid_namespace init_pid_ns = {
>  #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
>  	.memfd_noexec_scope = MEMFD_NOEXEC_SCOPE_EXEC,
>  #endif
> +	.ns.ns_type = ns_common_type(&init_pid_ns),
>  };
>  EXPORT_SYMBOL_GPL(init_pid_ns);
>  
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index a262a3f19443..f5b222c8ac39 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -443,7 +443,6 @@ static struct user_namespace *pidns_owner(struct ns_common *ns)
>  
>  const struct proc_ns_operations pidns_operations = {
>  	.name		= "pid",
> -	.type		= CLONE_NEWPID,
>  	.get		= pidns_get,
>  	.put		= pidns_put,
>  	.install	= pidns_install,
> @@ -454,7 +453,6 @@ const struct proc_ns_operations pidns_operations = {
>  const struct proc_ns_operations pidns_for_children_operations = {
>  	.name		= "pid_for_children",
>  	.real_ns_name	= "pid",
> -	.type		= CLONE_NEWPID,
>  	.get		= pidns_for_children_get,
>  	.put		= pidns_put,
>  	.install	= pidns_install,
> diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
> index 9f26e61be044..530cf99c2212 100644
> --- a/kernel/time/namespace.c
> +++ b/kernel/time/namespace.c
> @@ -462,7 +462,6 @@ int proc_timens_set_offset(struct file *file, struct task_struct *p,
>  
>  const struct proc_ns_operations timens_operations = {
>  	.name		= "time",
> -	.type		= CLONE_NEWTIME,
>  	.get		= timens_get,
>  	.put		= timens_put,
>  	.install	= timens_install,
> @@ -472,7 +471,6 @@ const struct proc_ns_operations timens_operations = {
>  const struct proc_ns_operations timens_for_children_operations = {
>  	.name		= "time_for_children",
>  	.real_ns_name	= "time",
> -	.type		= CLONE_NEWTIME,
>  	.get		= timens_for_children_get,
>  	.put		= timens_put,
>  	.install	= timens_install,
> @@ -480,6 +478,7 @@ const struct proc_ns_operations timens_for_children_operations = {
>  };
>  
>  struct time_namespace init_time_ns = {
> +	.ns.ns_type	= ns_common_type(&init_time_ns),
>  	.ns.__ns_ref	= REFCOUNT_INIT(3),
>  	.user_ns	= &init_user_ns,
>  	.ns.inum	= ns_init_inum(&init_time_ns),
> diff --git a/kernel/user.c b/kernel/user.c
> index b2a53674d506..0163665914c9 100644
> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -65,6 +65,7 @@ struct user_namespace init_user_ns = {
>  			.nr_extents = 1,
>  		},
>  	},
> +	.ns.ns_type = ns_common_type(&init_user_ns),
>  	.ns.__ns_ref = REFCOUNT_INIT(3),
>  	.owner = GLOBAL_ROOT_UID,
>  	.group = GLOBAL_ROOT_GID,
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index e1559e8a8a02..03cb63883d04 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -1400,7 +1400,6 @@ static struct user_namespace *userns_owner(struct ns_common *ns)
>  
>  const struct proc_ns_operations userns_operations = {
>  	.name		= "user",
> -	.type		= CLONE_NEWUSER,
>  	.get		= userns_get,
>  	.put		= userns_put,
>  	.install	= userns_install,
> diff --git a/kernel/utsname.c b/kernel/utsname.c
> index 00001592ad13..a8cdc84648ee 100644
> --- a/kernel/utsname.c
> +++ b/kernel/utsname.c
> @@ -146,7 +146,6 @@ static struct user_namespace *utsns_owner(struct ns_common *ns)
>  
>  const struct proc_ns_operations utsns_operations = {
>  	.name		= "uts",
> -	.type		= CLONE_NEWUTS,
>  	.get		= utsns_get,
>  	.put		= utsns_put,
>  	.install	= utsns_install,
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index bdea7d5fac56..dfe84bd35f98 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -1543,7 +1543,6 @@ static struct user_namespace *netns_owner(struct ns_common *ns)
>  
>  const struct proc_ns_operations netns_operations = {
>  	.name		= "net",
> -	.type		= CLONE_NEWNET,
>  	.get		= netns_get,
>  	.put		= netns_put,
>  	.install	= netns_install,
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

