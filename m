Return-Path: <linux-fsdevel+bounces-61316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB76B578F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4831886180
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 11:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48B1301006;
	Mon, 15 Sep 2025 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AwX5qXRk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MdGnup94";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AwX5qXRk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MdGnup94"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A39E2FE07E
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 11:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936959; cv=none; b=a++oR8zvu0zy33QomFNYwIlwzneSC2ggFRUmD+SUVi6k88vQrk24+JOkuJtvVyGu0JhmMWAMcYmWn1OTWyNmFkdrVBodm7SxcFi3CgA9qaBLxoU97TAln4yXs1xMxz6nBVnIaFIH6CEXimN79WTMcovS0hLO4tt7Fbuujy1YAyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936959; c=relaxed/simple;
	bh=++PTvo0YB29gHtvV22e6Oz+lhiyyWnhDNWpmd2ViOVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6mu7+N5RyPMEMYUymXazLRxwCojZX1CchauRVech4dii5DWmBEQwgUUsM7QBdg+fAP6Gpq60D2PQeKknKSSXOlTtfQOfuEWAytulTRrF01RUO+0orDK5uAb7+k68cQxkfTJSWrISLVtYN+qTp3jxSzC4l/OC1zoN1ChlpZnTuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AwX5qXRk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MdGnup94; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AwX5qXRk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MdGnup94; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 60EB31F8B0;
	Mon, 15 Sep 2025 11:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757936955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KCP6JoJ/J3a5hD+6adVxTBY55x8GA6ISumCDq2sI66g=;
	b=AwX5qXRkMUgJvAL6z9zqw8gW43jywMa/7bn9txSx0OCT7HiElqZztkrBrRRZTNNTBiYJ8F
	JXyfGfPc5XkSHI7e74D8l/klALrqg9O1OEXJwUWZnkdn/MpPiIcMFAh80DrdSrDbA/PQrH
	hhOSm20hYW6YD9/2NYcjM5FgJWg+NBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757936955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KCP6JoJ/J3a5hD+6adVxTBY55x8GA6ISumCDq2sI66g=;
	b=MdGnup94/ADgukHsLBzTWz1DQYV2kHbH0opedCEgEVDt0YLNSLwc0ohw+rVjPMf5rT7gQc
	IWuTsa/4dnqkqQBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AwX5qXRk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MdGnup94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757936955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KCP6JoJ/J3a5hD+6adVxTBY55x8GA6ISumCDq2sI66g=;
	b=AwX5qXRkMUgJvAL6z9zqw8gW43jywMa/7bn9txSx0OCT7HiElqZztkrBrRRZTNNTBiYJ8F
	JXyfGfPc5XkSHI7e74D8l/klALrqg9O1OEXJwUWZnkdn/MpPiIcMFAh80DrdSrDbA/PQrH
	hhOSm20hYW6YD9/2NYcjM5FgJWg+NBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757936955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KCP6JoJ/J3a5hD+6adVxTBY55x8GA6ISumCDq2sI66g=;
	b=MdGnup94/ADgukHsLBzTWz1DQYV2kHbH0opedCEgEVDt0YLNSLwc0ohw+rVjPMf5rT7gQc
	IWuTsa/4dnqkqQBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D1D91368D;
	Mon, 15 Sep 2025 11:49:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id grzTEjv9x2ipLAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Sep 2025 11:49:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0AF50A0A06; Mon, 15 Sep 2025 13:49:07 +0200 (CEST)
Date: Mon, 15 Sep 2025 13:49:07 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 17/33] nstree: make iterator generic
Message-ID: <jmyrgvk3zy2tbr2olqzyhmsgee52ubp3i44waj23y7gvjnwgkh@2hylimouxiwx>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-17-1a247645cef5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-work-namespace-v2-17-1a247645cef5@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 60EB31F8B0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,kernel.dk,cmpxchg.org,suse.com,google.com,redhat.com,oracle.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RL9r1cnt7e4118fjryeg1c95sa)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.com:email]
X-Spam-Score: -2.51

On Fri 12-09-25 13:52:40, Christian Brauner wrote:
> Move the namespace iteration infrastructure originally introduced for
> mount namespaces into a generic library usable by all namespace types.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/ns_common.h |   9 ++
>  include/linux/nstree.h    |  89 ++++++++++++++++++
>  include/linux/proc_ns.h   |   3 +
>  kernel/Makefile           |   2 +-
>  kernel/nstree.c           | 233 ++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 335 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
> index bc2e0758e1c9..7224072cccc5 100644
> --- a/include/linux/ns_common.h
> +++ b/include/linux/ns_common.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_NS_COMMON_H
>  
>  #include <linux/refcount.h>
> +#include <linux/rbtree.h>
>  
>  struct proc_ns_operations;
>  
> @@ -20,6 +21,14 @@ struct ns_common {
>  	const struct proc_ns_operations *ops;
>  	unsigned int inum;
>  	refcount_t count;
> +	union {
> +		struct {
> +			u64 ns_id;
> +			struct rb_node ns_tree_node;
> +			struct list_head ns_list_node;
> +		};
> +		struct rcu_head ns_rcu;
> +	};
>  };
>  
>  #define to_ns_common(__ns)                              \
> diff --git a/include/linux/nstree.h b/include/linux/nstree.h
> new file mode 100644
> index 000000000000..e26951a83924
> --- /dev/null
> +++ b/include/linux/nstree.h
> @@ -0,0 +1,89 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_NSTREE_H
> +#define _LINUX_NSTREE_H
> +
> +#include <linux/ns_common.h>
> +#include <linux/nsproxy.h>
> +#include <linux/rbtree.h>
> +#include <linux/seqlock.h>
> +#include <linux/rculist.h>
> +#include <linux/cookie.h>
> +
> +/**
> + * struct ns_tree - Namespace tree
> + * @ns_tree: Rbtree of namespaces of a particular type
> + * @ns_list: Sequentially walkable list of all namespaces of this type
> + * @ns_tree_lock: Seqlock to protect the tree and list
> + */
> +struct ns_tree {
> +	struct rb_root ns_tree;
> +	struct list_head ns_list;
> +	seqlock_t ns_tree_lock;
> +	int type;
> +};
> +
> +extern struct ns_tree cgroup_ns_tree;
> +extern struct ns_tree ipc_ns_tree;
> +extern struct ns_tree mnt_ns_tree;
> +extern struct ns_tree net_ns_tree;
> +extern struct ns_tree pid_ns_tree;
> +extern struct ns_tree time_ns_tree;
> +extern struct ns_tree user_ns_tree;
> +extern struct ns_tree uts_ns_tree;
> +
> +#define to_ns_tree(__ns)					\
> +	_Generic((__ns),					\
> +		struct cgroup_namespace *: &(cgroup_ns_tree),	\
> +		struct ipc_namespace *:    &(ipc_ns_tree),	\
> +		struct net *:              &(net_ns_tree),	\
> +		struct pid_namespace *:    &(pid_ns_tree),	\
> +		struct mnt_namespace *:    &(mnt_ns_tree),	\
> +		struct time_namespace *:   &(time_ns_tree),	\
> +		struct user_namespace *:   &(user_ns_tree),	\
> +		struct uts_namespace *:    &(uts_ns_tree))
> +
> +u64 ns_tree_gen_id(struct ns_common *ns);
> +void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree);
> +void __ns_tree_remove(struct ns_common *ns, struct ns_tree *ns_tree);
> +struct ns_common *ns_tree_lookup_rcu(u64 ns_id, int ns_type);
> +struct ns_common *__ns_tree_adjoined_rcu(struct ns_common *ns,
> +					 struct ns_tree *ns_tree,
> +					 bool previous);
> +
> +static inline void __ns_tree_add(struct ns_common *ns, struct ns_tree *ns_tree)
> +{
> +	ns_tree_gen_id(ns);
> +	__ns_tree_add_raw(ns, ns_tree);
> +}
> +
> +/**
> + * ns_tree_add_raw - Add a namespace to a namespace
> + * @ns: Namespace to add
> + *
> + * This function adds a namespace to the appropriate namespace tree
> + * without assigning a id.
> + */
> +#define ns_tree_add_raw(__ns) __ns_tree_add_raw(to_ns_common(__ns), to_ns_tree(__ns))
> +
> +/**
> + * ns_tree_add - Add a namespace to a namespace tree
> + * @ns: Namespace to add
> + *
> + * This function assigns a new id to the namespace and adds it to the
> + * appropriate namespace tree and list.
> + */
> +#define ns_tree_add(__ns) __ns_tree_add(to_ns_common(__ns), to_ns_tree(__ns))
> +
> +/**
> + * ns_tree_remove - Remove a namespace from a namespace tree
> + * @ns: Namespace to remove
> + *
> + * This function removes a namespace from the appropriate namespace
> + * tree and list.
> + */
> +#define ns_tree_remove(__ns)  __ns_tree_remove(to_ns_common(__ns), to_ns_tree(__ns))
> +
> +#define ns_tree_adjoined_rcu(__ns, __previous) \
> +	__ns_tree_adjoined_rcu(to_ns_common(__ns), to_ns_tree(__ns), __previous)
> +
> +#endif /* _LINUX_NSTREE_H */
> diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
> index e50d312f9fee..7f89f0829e60 100644
> --- a/include/linux/proc_ns.h
> +++ b/include/linux/proc_ns.h
> @@ -79,6 +79,9 @@ static inline int ns_common_init(struct ns_common *ns,
>  	refcount_set(&ns->count, 1);
>  	ns->stashed = NULL;
>  	ns->ops = ops;
> +	ns->ns_id = 0;
> +	RB_CLEAR_NODE(&ns->ns_tree_node);
> +	INIT_LIST_HEAD(&ns->ns_list_node);
>  	return 0;
>  }
>  
> diff --git a/kernel/Makefile b/kernel/Makefile
> index c60623448235..b807516a1b43 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -8,7 +8,7 @@ obj-y     = fork.o exec_domain.o panic.o \
>  	    sysctl.o capability.o ptrace.o user.o \
>  	    signal.o sys.o umh.o workqueue.o pid.o task_work.o \
>  	    extable.o params.o \
> -	    kthread.o sys_ni.o nsproxy.o \
> +	    kthread.o sys_ni.o nsproxy.o nstree.o \
>  	    notifier.o ksysfs.o cred.o reboot.o \
>  	    async.o range.o smpboot.o ucount.o regset.o ksyms_common.o
>  
> diff --git a/kernel/nstree.c b/kernel/nstree.c
> new file mode 100644
> index 000000000000..bbe8bedc924c
> --- /dev/null
> +++ b/kernel/nstree.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/nstree.h>
> +#include <linux/proc_ns.h>
> +#include <linux/vfsdebug.h>
> +
> +struct ns_tree mnt_ns_tree = {
> +	.ns_tree = RB_ROOT,
> +	.ns_list = LIST_HEAD_INIT(mnt_ns_tree.ns_list),
> +	.ns_tree_lock = __SEQLOCK_UNLOCKED(mnt_ns_tree.ns_tree_lock),
> +	.type = CLONE_NEWNS,
> +};
> +
> +struct ns_tree net_ns_tree = {
> +	.ns_tree = RB_ROOT,
> +	.ns_list = LIST_HEAD_INIT(net_ns_tree.ns_list),
> +	.ns_tree_lock = __SEQLOCK_UNLOCKED(net_ns_tree.ns_tree_lock),
> +	.type = CLONE_NEWNET,
> +};
> +EXPORT_SYMBOL_GPL(net_ns_tree);
> +
> +struct ns_tree uts_ns_tree = {
> +	.ns_tree = RB_ROOT,
> +	.ns_list = LIST_HEAD_INIT(uts_ns_tree.ns_list),
> +	.ns_tree_lock = __SEQLOCK_UNLOCKED(uts_ns_tree.ns_tree_lock),
> +	.type = CLONE_NEWUTS,
> +};
> +
> +struct ns_tree user_ns_tree = {
> +	.ns_tree = RB_ROOT,
> +	.ns_list = LIST_HEAD_INIT(user_ns_tree.ns_list),
> +	.ns_tree_lock = __SEQLOCK_UNLOCKED(user_ns_tree.ns_tree_lock),
> +	.type = CLONE_NEWUSER,
> +};
> +
> +struct ns_tree ipc_ns_tree = {
> +	.ns_tree = RB_ROOT,
> +	.ns_list = LIST_HEAD_INIT(ipc_ns_tree.ns_list),
> +	.ns_tree_lock = __SEQLOCK_UNLOCKED(ipc_ns_tree.ns_tree_lock),
> +	.type = CLONE_NEWIPC,
> +};
> +
> +struct ns_tree pid_ns_tree = {
> +	.ns_tree = RB_ROOT,
> +	.ns_list = LIST_HEAD_INIT(pid_ns_tree.ns_list),
> +	.ns_tree_lock = __SEQLOCK_UNLOCKED(pid_ns_tree.ns_tree_lock),
> +	.type = CLONE_NEWPID,
> +};
> +
> +struct ns_tree cgroup_ns_tree = {
> +	.ns_tree = RB_ROOT,
> +	.ns_list = LIST_HEAD_INIT(cgroup_ns_tree.ns_list),
> +	.ns_tree_lock = __SEQLOCK_UNLOCKED(cgroup_ns_tree.ns_tree_lock),
> +	.type = CLONE_NEWCGROUP,
> +};
> +
> +struct ns_tree time_ns_tree = {
> +	.ns_tree = RB_ROOT,
> +	.ns_list = LIST_HEAD_INIT(time_ns_tree.ns_list),
> +	.ns_tree_lock = __SEQLOCK_UNLOCKED(time_ns_tree.ns_tree_lock),
> +	.type = CLONE_NEWTIME,
> +};
> +
> +DEFINE_COOKIE(namespace_cookie);
> +
> +static inline struct ns_common *node_to_ns(const struct rb_node *node)
> +{
> +	if (!node)
> +		return NULL;
> +	return rb_entry(node, struct ns_common, ns_tree_node);
> +}
> +
> +static inline int ns_cmp(struct rb_node *a, const struct rb_node *b)
> +{
> +	struct ns_common *ns_a = node_to_ns(a);
> +	struct ns_common *ns_b = node_to_ns(b);
> +	u64 ns_id_a = ns_a->ns_id;
> +	u64 ns_id_b = ns_b->ns_id;
> +
> +	if (ns_id_a < ns_id_b)
> +		return -1;
> +	if (ns_id_a > ns_id_b)
> +		return 1;
> +	return 0;
> +}
> +
> +void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree)
> +{
> +	struct rb_node *node, *prev;
> +
> +	VFS_WARN_ON_ONCE(!ns->ns_id);
> +
> +	write_seqlock(&ns_tree->ns_tree_lock);
> +
> +	VFS_WARN_ON_ONCE(ns->ops->type != ns_tree->type);
> +
> +	node = rb_find_add_rcu(&ns->ns_tree_node, &ns_tree->ns_tree, ns_cmp);
> +	/*
> +	 * If there's no previous entry simply add it after the
> +	 * head and if there is add it after the previous entry.
> +	 */
> +	prev = rb_prev(&ns->ns_tree_node);
> +	if (!prev)
> +		list_add_rcu(&ns->ns_list_node, &ns_tree->ns_list);
> +	else
> +		list_add_rcu(&ns->ns_list_node, &node_to_ns(prev)->ns_list_node);
> +
> +	write_sequnlock(&ns_tree->ns_tree_lock);
> +
> +	VFS_WARN_ON_ONCE(node);
> +}
> +
> +void __ns_tree_remove(struct ns_common *ns, struct ns_tree *ns_tree)
> +{
> +	VFS_WARN_ON_ONCE(RB_EMPTY_NODE(&ns->ns_tree_node));
> +	VFS_WARN_ON_ONCE(list_empty(&ns->ns_list_node));
> +	VFS_WARN_ON_ONCE(ns->ops->type != ns_tree->type);
> +
> +	write_seqlock(&ns_tree->ns_tree_lock);
> +	rb_erase(&ns->ns_tree_node, &ns_tree->ns_tree);
> +	list_bidir_del_rcu(&ns->ns_list_node);
> +	RB_CLEAR_NODE(&ns->ns_tree_node);
> +	write_sequnlock(&ns_tree->ns_tree_lock);
> +}
> +EXPORT_SYMBOL_GPL(__ns_tree_remove);
> +
> +static int ns_find(const void *key, const struct rb_node *node)
> +{
> +	const u64 ns_id = *(u64 *)key;
> +	const struct ns_common *ns = node_to_ns(node);
> +
> +	if (ns_id < ns->ns_id)
> +		return -1;
> +	if (ns_id > ns->ns_id)
> +		return 1;
> +	return 0;
> +}
> +
> +
> +static struct ns_tree *ns_tree_from_type(int ns_type)
> +{
> +	switch (ns_type) {
> +	case CLONE_NEWCGROUP:
> +		return &cgroup_ns_tree;
> +	case CLONE_NEWIPC:
> +		return &ipc_ns_tree;
> +	case CLONE_NEWNS:
> +		return &mnt_ns_tree;
> +	case CLONE_NEWNET:
> +		return &net_ns_tree;
> +	case CLONE_NEWPID:
> +		return &pid_ns_tree;
> +	case CLONE_NEWUSER:
> +		return &user_ns_tree;
> +	case CLONE_NEWUTS:
> +		return &uts_ns_tree;
> +	case CLONE_NEWTIME:
> +		return &time_ns_tree;
> +	}
> +
> +	return NULL;
> +}
> +
> +struct ns_common *ns_tree_lookup_rcu(u64 ns_id, int ns_type)
> +{
> +	struct ns_tree *ns_tree;
> +	struct rb_node *node;
> +	unsigned int seq;
> +
> +	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "suspicious ns_tree_lookup_rcu() usage");
> +
> +	ns_tree = ns_tree_from_type(ns_type);
> +	if (!ns_tree)
> +		return NULL;
> +
> +	do {
> +		seq = read_seqbegin(&ns_tree->ns_tree_lock);
> +		node = rb_find_rcu(&ns_id, &ns_tree->ns_tree, ns_find);
> +		if (node)
> +			break;
> +	} while (read_seqretry(&ns_tree->ns_tree_lock, seq));
> +
> +	if (!node)
> +		return NULL;
> +
> +	VFS_WARN_ON_ONCE(node_to_ns(node)->ops->type != ns_type);
> +
> +	return node_to_ns(node);
> +}
> +
> +/**
> + * ns_tree_adjoined_rcu - find the next/previous namespace in the same
> + * tree
> + * @ns: namespace to start from
> + * @previous: if true find the previous namespace, otherwise the next
> + *
> + * Find the next or previous namespace in the same tree as @ns. If
> + * there is no next/previous namespace, -ENOENT is returned.
> + */
> +struct ns_common *__ns_tree_adjoined_rcu(struct ns_common *ns,
> +					 struct ns_tree *ns_tree, bool previous)
> +{
> +	struct list_head *list;
> +
> +	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "suspicious ns_tree_adjoined_rcu() usage");
> +
> +	if (previous)
> +		list = rcu_dereference(list_bidir_prev_rcu(&ns->ns_list_node));
> +	else
> +		list = rcu_dereference(list_next_rcu(&ns->ns_list_node));
> +	if (list_is_head(list, &ns_tree->ns_list))
> +		return ERR_PTR(-ENOENT);
> +
> +	VFS_WARN_ON_ONCE(list_entry_rcu(list, struct ns_common, ns_list_node)->ops->type != ns_tree->type);
> +
> +	return list_entry_rcu(list, struct ns_common, ns_list_node);
> +}
> +
> +/**
> + * ns_tree_gen_id - generate a new namespace id
> + * @ns: namespace to generate id for
> + *
> + * Generates a new namespace id and assigns it to the namespace. All
> + * namespaces types share the same id space and thus can be compared
> + * directly. IOW, when two ids of two namespace are equal, they are
> + * identical.
> + */
> +u64 ns_tree_gen_id(struct ns_common *ns)
> +{
> +	guard(preempt)();
> +	ns->ns_id = gen_cookie_next(&namespace_cookie);
> +	return ns->ns_id;
> +}
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

