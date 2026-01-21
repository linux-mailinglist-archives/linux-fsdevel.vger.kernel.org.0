Return-Path: <linux-fsdevel+bounces-74842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DNtBiC0cGndZAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 12:10:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC8355BE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 12:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A08646CC20E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 10:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B7941C30E;
	Wed, 21 Jan 2026 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OR5jBxlE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iEx439dI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W5rjq6SI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QJukoyjl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD17347BD4
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768993157; cv=none; b=KAGndYU2zhS0VLbAC0rUwWcsQOfRjXeJ0LA1jIj6nDUS6DygPE+CVMv9t132erUpbrugJHNYDDkZ63uEr9wBglQEw5l2M3gLB97/xe8kcsLWPgVz1Jd+pFToAjR+OTpw19hmxnHz0xaMBqfI7ieDnzFKceMyVsdffa2ZQDMA/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768993157; c=relaxed/simple;
	bh=LFBEqtMrZKzE46L5/Zq8//Umyuol6faQqBKoH9nrbMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PadA+QG32t4x9ve/ko8ecZ5IzWrYk4RRAYBAjrTfjuJYcN8oDVxNqOQM4l44YDeIiO6nd/vX5yIzGnnJQfO0mW49JC19E1+lT3xzSIN+sGoElbOaBuzlxLOC/fDULCpOnsAmL6G7d7YbfOjiTIJ7yDserLowOnfBf04THSpv1/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OR5jBxlE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iEx439dI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W5rjq6SI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QJukoyjl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 904E233689;
	Wed, 21 Jan 2026 10:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768993152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Drv11WQyLu7r2Yef+xC1mfCEm+Km2RlqEpdSo3vkrw=;
	b=OR5jBxlEAWa4gHsbKZ4U/FKVwAE+Sr6fFVa54gxEhEm4IlSXGDbA5OZFFP3U9mHWDHvEiT
	0UQQv8+fpCXjuWmT2L99iS8NhxrbURdEQce1eK9z2bO1saG9AqH8Ticgkqk6LP8uUaR2tg
	VLk+w52WOnNwt4f7AENUTK+5wE0k08M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768993152;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Drv11WQyLu7r2Yef+xC1mfCEm+Km2RlqEpdSo3vkrw=;
	b=iEx439dIOxEVZ77uv6P7699dhMN0W0Kx0HigLHsxKdV/RUMxQ8j6wgiAATDJgJs/2wGZjM
	GeABiyMR3HXw40DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768993151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Drv11WQyLu7r2Yef+xC1mfCEm+Km2RlqEpdSo3vkrw=;
	b=W5rjq6SIU2eUto0oHJczFsAE5Ow+wOZTs0Q1+eox8i2QInrLDMTuhdnllAgLHtvx4BZFNC
	grZkHrNY7gEhXBNLRD+PWDBglsMBoyCiefTFr+XjS2chQQt7BXGqkR12ehgzJeRQ7nIAex
	mFlNJmDTzDBK9FlI4kNckJK6yUkrvLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768993151;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Drv11WQyLu7r2Yef+xC1mfCEm+Km2RlqEpdSo3vkrw=;
	b=QJukoyjlL9XNi28tc4oTKtow4hztZmTrK29lD7DxHrSrdTL11P+YrgcnTCiz9E4DXvsPq7
	ptmP5egk0GkUSPCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 746A33EA63;
	Wed, 21 Jan 2026 10:59:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HxtlHH+xcGncGAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Jan 2026 10:59:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 38E67A09E9; Wed, 21 Jan 2026 11:59:11 +0100 (CET)
Date: Wed, 21 Jan 2026 11:59:11 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2] pidfs: convert rb-tree to rhashtable
Message-ID: <6yefrqagwzxnyauuidtvzsaejowzrkh5u2cjrjwmn5ulbt27by@fy5fezgl4tsq>
References: <20260120-work-pidfs-rhashtable-v2-1-d593c4d0f576@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120-work-pidfs-rhashtable-v2-1-d593c4d0f576@kernel.org>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74842-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,msgid.link:url];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,suse.cz,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4EC8355BE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue 20-01-26 15:52:35, Christian Brauner wrote:
> Mateusz reported performance penalties [1] during task creation because
> pidfs uses pidmap_lock to add elements into the rbtree. Switch to an
> rhashtable to have separate fine-grained locking and to decouple from
> pidmap_lock moving all heavy manipulations outside of it.
> 
> Convert the pidfs inode-to-pid mapping from an rb-tree with seqcount
> protection to an rhashtable. This removes the global pidmap_lock
> contention from pidfs_ino_get_pid() lookups and allows the hashtable
> insert to happen outside the pidmap_lock.
> 
> pidfs_add_pid() is split. pidfs_prepare_pid() allocates inode number and
> initializes pid fields and is called inside pidmap_lock. pidfs_add_pid()
> inserts pid into rhashtable and is called outside pidmap_lock. Insertion
> into the rhashtable can fail and memory allocation may happen so we need
> to drop the spinlock.
> 
> To guard against accidently opening an already reaped task
> pidfs_ino_get_pid() uses additional checks beyond pid_vnr(). If
> pid->attr is PIDFS_PID_DEAD or NULL the pid either never had a pidfd or
> it already went through pidfs_exit() aka the process as already reaped.
> If pid->attr is valid check PIDFS_ATTR_BIT_EXIT to figure out whether
> the task has exited.
> 
> This slightly changes visibility semantics: pidfd creation is denied
> after pidfs_exit() runs, which is just before the pid number is removed
> from the via free_pid(). That should not be an issue though.
> 
> Link: https://lore.kernel.org/20251206131955.780557-1-mjguzik@gmail.com [1]
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks very nice! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

I have just one question about the new PIDFS_ATTR_BIT_EXIT check.  AFAIU it
protects from grabbing struct pid references for pids that are dying. But
we can also call free_pid() from places like ksys_setsid() where
PIDFS_ATTR_BIT_EXIT is not set. So this check only seems as a convenience
rather than some hard guarantee, am I right?

								Honza

> ---
> Changes in v2:
> - Ensure that pid is removed before call_rcu() from pidfs.
> - Don't drop and reacquire spinlock.
> - Link to v1: https://patch.msgid.link/20260119-work-pidfs-rhashtable-v1-1-159c7700300a@kernel.org
> ---
>  fs/pidfs.c            | 81 +++++++++++++++++++++------------------------------
>  include/linux/pid.h   |  4 +--
>  include/linux/pidfs.h |  3 +-
>  kernel/pid.c          | 13 ++++++---
>  4 files changed, 46 insertions(+), 55 deletions(-)
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index dba703d4ce4a..ee0e36dd29d2 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -21,6 +21,7 @@
>  #include <linux/utsname.h>
>  #include <net/net_namespace.h>
>  #include <linux/coredump.h>
> +#include <linux/rhashtable.h>
>  #include <linux/xattr.h>
>  
>  #include "internal.h"
> @@ -55,7 +56,14 @@ struct pidfs_attr {
>  	__u32 coredump_signal;
>  };
>  
> -static struct rb_root pidfs_ino_tree = RB_ROOT;
> +static struct rhashtable pidfs_ino_ht;
> +
> +static const struct rhashtable_params pidfs_ino_ht_params = {
> +	.key_offset		= offsetof(struct pid, ino),
> +	.key_len		= sizeof(u64),
> +	.head_offset		= offsetof(struct pid, pidfs_hash),
> +	.automatic_shrinking	= true,
> +};
>  
>  #if BITS_PER_LONG == 32
>  static inline unsigned long pidfs_ino(u64 ino)
> @@ -84,21 +92,11 @@ static inline u32 pidfs_gen(u64 ino)
>  }
>  #endif
>  
> -static int pidfs_ino_cmp(struct rb_node *a, const struct rb_node *b)
> -{
> -	struct pid *pid_a = rb_entry(a, struct pid, pidfs_node);
> -	struct pid *pid_b = rb_entry(b, struct pid, pidfs_node);
> -	u64 pid_ino_a = pid_a->ino;
> -	u64 pid_ino_b = pid_b->ino;
> -
> -	if (pid_ino_a < pid_ino_b)
> -		return -1;
> -	if (pid_ino_a > pid_ino_b)
> -		return 1;
> -	return 0;
> -}
> -
> -void pidfs_add_pid(struct pid *pid)
> +/*
> + * Allocate inode number and initialize pidfs fields.
> + * Called with pidmap_lock held.
> + */
> +void pidfs_prepare_pid(struct pid *pid)
>  {
>  	static u64 pidfs_ino_nr = 2;
>  
> @@ -131,20 +129,22 @@ void pidfs_add_pid(struct pid *pid)
>  		pidfs_ino_nr += 2;
>  
>  	pid->ino = pidfs_ino_nr;
> +	pid->pidfs_hash.next = NULL;
>  	pid->stashed = NULL;
>  	pid->attr = NULL;
>  	pidfs_ino_nr++;
> +}
>  
> -	write_seqcount_begin(&pidmap_lock_seq);
> -	rb_find_add_rcu(&pid->pidfs_node, &pidfs_ino_tree, pidfs_ino_cmp);
> -	write_seqcount_end(&pidmap_lock_seq);
> +int pidfs_add_pid(struct pid *pid)
> +{
> +	return rhashtable_insert_fast(&pidfs_ino_ht, &pid->pidfs_hash,
> +				      pidfs_ino_ht_params);
>  }
>  
>  void pidfs_remove_pid(struct pid *pid)
>  {
> -	write_seqcount_begin(&pidmap_lock_seq);
> -	rb_erase(&pid->pidfs_node, &pidfs_ino_tree);
> -	write_seqcount_end(&pidmap_lock_seq);
> +	rhashtable_remove_fast(&pidfs_ino_ht, &pid->pidfs_hash,
> +			       pidfs_ino_ht_params);
>  }
>  
>  void pidfs_free_pid(struct pid *pid)
> @@ -773,42 +773,24 @@ static int pidfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
>  	return FILEID_KERNFS;
>  }
>  
> -static int pidfs_ino_find(const void *key, const struct rb_node *node)
> -{
> -	const u64 pid_ino = *(u64 *)key;
> -	const struct pid *pid = rb_entry(node, struct pid, pidfs_node);
> -
> -	if (pid_ino < pid->ino)
> -		return -1;
> -	if (pid_ino > pid->ino)
> -		return 1;
> -	return 0;
> -}
> -
>  /* Find a struct pid based on the inode number. */
>  static struct pid *pidfs_ino_get_pid(u64 ino)
>  {
>  	struct pid *pid;
> -	struct rb_node *node;
> -	unsigned int seq;
> +	struct pidfs_attr *attr;
>  
>  	guard(rcu)();
> -	do {
> -		seq = read_seqcount_begin(&pidmap_lock_seq);
> -		node = rb_find_rcu(&ino, &pidfs_ino_tree, pidfs_ino_find);
> -		if (node)
> -			break;
> -	} while (read_seqcount_retry(&pidmap_lock_seq, seq));
> -
> -	if (!node)
> +	pid = rhashtable_lookup(&pidfs_ino_ht, &ino, pidfs_ino_ht_params);
> +	if (!pid)
> +		return NULL;
> +	attr = READ_ONCE(pid->attr);
> +	if (IS_ERR_OR_NULL(attr))
> +		return NULL;
> +	if (test_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask))
>  		return NULL;
> -
> -	pid = rb_entry(node, struct pid, pidfs_node);
> -
>  	/* Within our pid namespace hierarchy? */
>  	if (pid_vnr(pid) == 0)
>  		return NULL;
> -
>  	return get_pid(pid);
>  }
>  
> @@ -1086,6 +1068,9 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
>  
>  void __init pidfs_init(void)
>  {
> +	if (rhashtable_init(&pidfs_ino_ht, &pidfs_ino_ht_params))
> +		panic("Failed to initialize pidfs hashtable");
> +
>  	pidfs_attr_cachep = kmem_cache_create("pidfs_attr_cache", sizeof(struct pidfs_attr), 0,
>  					 (SLAB_HWCACHE_ALIGN | SLAB_RECLAIM_ACCOUNT |
>  					  SLAB_ACCOUNT | SLAB_PANIC), NULL);
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 003a1027d219..ce9b5cb7560b 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -6,6 +6,7 @@
>  #include <linux/rculist.h>
>  #include <linux/rcupdate.h>
>  #include <linux/refcount.h>
> +#include <linux/rhashtable-types.h>
>  #include <linux/sched.h>
>  #include <linux/wait.h>
>  
> @@ -60,7 +61,7 @@ struct pid {
>  	spinlock_t lock;
>  	struct {
>  		u64 ino;
> -		struct rb_node pidfs_node;
> +		struct rhash_head pidfs_hash;
>  		struct dentry *stashed;
>  		struct pidfs_attr *attr;
>  	};
> @@ -73,7 +74,6 @@ struct pid {
>  	struct upid numbers[];
>  };
>  
> -extern seqcount_spinlock_t pidmap_lock_seq;
>  extern struct pid init_struct_pid;
>  
>  struct file;
> diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
> index 3e08c33da2df..416bdff4d6ce 100644
> --- a/include/linux/pidfs.h
> +++ b/include/linux/pidfs.h
> @@ -6,7 +6,8 @@ struct coredump_params;
>  
>  struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
>  void __init pidfs_init(void);
> -void pidfs_add_pid(struct pid *pid);
> +void pidfs_prepare_pid(struct pid *pid);
> +int pidfs_add_pid(struct pid *pid);
>  void pidfs_remove_pid(struct pid *pid);
>  void pidfs_exit(struct task_struct *tsk);
>  #ifdef CONFIG_COREDUMP
> diff --git a/kernel/pid.c b/kernel/pid.c
> index ad4400a9f15f..6077da774652 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -43,7 +43,6 @@
>  #include <linux/sched/task.h>
>  #include <linux/idr.h>
>  #include <linux/pidfs.h>
> -#include <linux/seqlock.h>
>  #include <net/sock.h>
>  #include <uapi/linux/pidfd.h>
>  
> @@ -85,7 +84,6 @@ struct pid_namespace init_pid_ns = {
>  EXPORT_SYMBOL_GPL(init_pid_ns);
>  
>  static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(pidmap_lock);
> -seqcount_spinlock_t pidmap_lock_seq = SEQCNT_SPINLOCK_ZERO(pidmap_lock_seq, &pidmap_lock);
>  
>  void put_pid(struct pid *pid)
>  {
> @@ -141,9 +139,9 @@ void free_pid(struct pid *pid)
>  
>  		idr_remove(&ns->idr, upid->nr);
>  	}
> -	pidfs_remove_pid(pid);
>  	spin_unlock(&pidmap_lock);
>  
> +	pidfs_remove_pid(pid);
>  	call_rcu(&pid->rcu, delayed_put_pid);
>  }
>  
> @@ -315,7 +313,8 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *arg_set_tid,
>  	retval = -ENOMEM;
>  	if (unlikely(!(ns->pid_allocated & PIDNS_ADDING)))
>  		goto out_free;
> -	pidfs_add_pid(pid);
> +	pidfs_prepare_pid(pid);
> +
>  	for (upid = pid->numbers + ns->level; upid >= pid->numbers; --upid) {
>  		/* Make the PID visible to find_pid_ns. */
>  		idr_replace(&upid->ns->idr, pid, upid->nr);
> @@ -325,6 +324,12 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *arg_set_tid,
>  	idr_preload_end();
>  	ns_ref_active_get(ns);
>  
> +	retval = pidfs_add_pid(pid);
> +	if (unlikely(retval)) {
> +		free_pid(pid);
> +		pid = ERR_PTR(-ENOMEM);
> +	}
> +
>  	return pid;
>  
>  out_free:
> 
> ---
> base-commit: f54c7e54d2de2d7b58aa54604218a6fc00bb2e77
> change-id: 20260119-work-pidfs-rhashtable-9d14071bd77a
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

