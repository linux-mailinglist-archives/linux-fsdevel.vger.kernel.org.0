Return-Path: <linux-fsdevel+bounces-74609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDFFD3C64C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 11:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF4C55AA632
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 10:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4846D3AE71D;
	Tue, 20 Jan 2026 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q8lkCNwm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1aeMdp+9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vkmXViYG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pi5LvUOQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A43352C2D
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768906027; cv=none; b=HoqknKrsaIGuLudnbgnZZE7m2Mn85P7V+un6hWAQET0+HO5NXSq7dGPFX+wyOJAXU9NwYdxfO21frjlbC0diQ9m5a75zpxf/BxKin8vQOM5F8JpcEnTVALjPUWw/dtGhTVvXOZtctMC+H3CPWi3X9AL2FcStVx08+AzY9qIQaBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768906027; c=relaxed/simple;
	bh=1YZb9tfqKA8un2ph8X+/Pt/DbN5UWAKykIWUNZhqdVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBJkQH/3Fidag54ZsmlebmuYAO1GOZaa92JWl56NKPDiZAn3G6XP3vpsqycKPuh9QUOw4fbdz8i4YqcxvfSRnml0NI/Jb2TLMH7YWXHcv4ZfLSkuQra7ATgVf4JjDMWO5VU2kIDy9hjzilNQZ1ryzf6hIbBveOD2c2t8qlOxpDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q8lkCNwm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1aeMdp+9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vkmXViYG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pi5LvUOQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA9DA5BCD7;
	Tue, 20 Jan 2026 10:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768906024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yGlif2dytDGEW6wKlb/FY9gy2Oj9zzDrFNQ7ZqgDLuc=;
	b=q8lkCNwmtOIMBqetCRwHKREArDOVYvmYCjfyRnlbuFNpnRrnPDui3i5NFdk6dxtWO39Hko
	jwB5of6ZdCfgxe2ukgw53mNgIeFDVeeJgHD126NqpLU29sYSFCO7xp7J97w2gH1T0CvOhY
	+GznjrJYK8ydpZdkq3USRSbEqvPa3+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768906024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yGlif2dytDGEW6wKlb/FY9gy2Oj9zzDrFNQ7ZqgDLuc=;
	b=1aeMdp+9VOX7WnyoIcuDKmURnmupsn07aKWq4s5pawg+MG5oHGY3br6sT0e+SxH4xlYDTY
	uWPLyapz9x8I4nCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768906023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yGlif2dytDGEW6wKlb/FY9gy2Oj9zzDrFNQ7ZqgDLuc=;
	b=vkmXViYG8W3eDGrKunpUSbs55d4nIitLMxYwLLKO5d8uc5/GkXJIA+Frua44dZ83r2K4f2
	Mhm6ga3SEoJ4B7expay8FGrJzwCuJDNugdux0MTX2QoB2BOz3DS5m0U5lM85nVpHd0C+HE
	J4u26NOmDFF/mfP53fkhkxTVCgk4sng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768906023;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yGlif2dytDGEW6wKlb/FY9gy2Oj9zzDrFNQ7ZqgDLuc=;
	b=Pi5LvUOQrzxzzJBbP8Qy/WEz0iCH0AeJm/IBMJ5o/GZSKztpUQnxn07BaBS6DDSLt+NLHC
	v7kfvon91+3mb+CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF7343EA63;
	Tue, 20 Jan 2026 10:47:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eIWHNiddb2mcfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 20 Jan 2026 10:47:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8ED05A09DA; Tue, 20 Jan 2026 11:47:03 +0100 (CET)
Date: Tue, 20 Jan 2026 11:47:03 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] pidfs: convert rb-tree to rhashtable
Message-ID: <4v7ozybnizhbwyvbla7gbjwfixtsbme4qirndlo3x5buhkgluv@vxdkauy56mvv>
References: <20260119-work-pidfs-rhashtable-v1-1-159c7700300a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119-work-pidfs-rhashtable-v1-1-159c7700300a@kernel.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,suse.cz,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Mon 19-01-26 16:05:54, Christian Brauner wrote:
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
> The hashtable removal is deferred to the RCU callback to ensure safe
> concurrent lookups.

This doesn't look correct to me. See below in the code for details...

> To guard against accidently opening an already
> reaped task pidfs_ino_get_pid() uses additional checks beyond pid_vnr().
> If pid->attr is PIDFS_PID_DEAD or NULL the pid either never had a pidfd
> or it already went through pidfs_exit() aka the process as already
> reaped. If pid->attr is valid check PIDFS_ATTR_BIT_EXIT to figure out
> whether the task has exited. Switch to refcount_inc_not_zero() to ensure
> that the pid isn't about to be freed.
> 
> This slightly changes visibility semantics: pidfd creation is denied
> after pidfs_exit() runs, which is just before the pid number is removed
> from the via free_pid(). That should not be an issue though.
> 
> I haven't perfed this and I would like to make this Mateusz problem...

;-) I guess this note means you want to have some perf data justifying this
change. I agree that when replacing data structure like this we should have
some measurements showing that the expected improvements indeed translate
to a real improvements as well. It has happened to me more than once that
a theoretical improvement didn't really work out in practice...

> Link: https://lore.kernel.org/20251206131955.780557-1-mjguzik@gmail.com
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/pidfs.c            | 107 ++++++++++++++++++++++++++++----------------------
>  include/linux/pid.h   |   4 +-
>  include/linux/pidfs.h |   3 +-
>  kernel/pid.c          |  19 ++++++---
>  4 files changed, 79 insertions(+), 54 deletions(-)
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index dba703d4ce4a..e97931249ba2 100644
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
> @@ -55,7 +56,23 @@ struct pidfs_attr {
>  	__u32 coredump_signal;
>  };
>  
> -static struct rb_root pidfs_ino_tree = RB_ROOT;
> +static struct rhashtable pidfs_ino_ht;
> +
> +static int pidfs_ino_ht_cmp(struct rhashtable_compare_arg *arg, const void *pidp)
> +{
> +	const u64 *ino = arg->key;
> +	const struct pid *pid = pidp;
> +
> +	return pid->ino != *ino;
> +}

I don't think this comparison function is really needed. rhashtable
provides its own comparison function which is good enough for simple
fixed-length keys (rhashtable_compare() is used if .obj_cmpfn is not
provided).

> +
> +static const struct rhashtable_params pidfs_ino_ht_params = {
> +	.key_offset		= offsetof(struct pid, ino),
> +	.key_len		= sizeof(u64),
> +	.head_offset		= offsetof(struct pid, pidfs_hash),
> +	.obj_cmpfn		= pidfs_ino_ht_cmp,
> +	.automatic_shrinking	= true,
> +};
>  
>  #if BITS_PER_LONG == 32
>  static inline unsigned long pidfs_ino(u64 ino)
...
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
>  
> -	if (!node)
> +	pid = rhashtable_lookup(&pidfs_ino_ht, &ino, pidfs_ino_ht_params);
> +	if (!pid)
>  		return NULL;
>  
> -	pid = rb_entry(node, struct pid, pidfs_node);
> -
>  	/* Within our pid namespace hierarchy? */
>  	if (pid_vnr(pid) == 0)
>  		return NULL;
>  
> -	return get_pid(pid);
> +	/*
> +	 * If attr is NULL the pid is still in the IDR but never had
> +	 * a pidfd. If attr is an error the pid went through pidfs_exit()
> +	 * and is about to be removed. Either way, deny access.
> +	 */
> +	attr = READ_ONCE(pid->attr);
> +	if (IS_ERR_OR_NULL(attr))
> +		return NULL;
> +
> +	/*
> +	 * If PIDFS_ATTR_BIT_EXIT is set the task has exited and we
> +	 * should not allow new file handle lookups.
> +	 */
> +	if (test_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask))
> +		return NULL;
> +
> +	if (!refcount_inc_not_zero(&pid->count))

If this ever sees zero pid->count we have a problem because it means we are
reading freed memory, aren't we? I think RCU must be protecting from the
last reference of struct pid being dropped and struct pid getting freed...

> +		return NULL;
> +
> +	return pid;
>  }
>  
>  static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
...
> diff --git a/kernel/pid.c b/kernel/pid.c
> index ad4400a9f15f..7da2c3e8f79c 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
...
> @@ -106,6 +104,7 @@ EXPORT_SYMBOL_GPL(put_pid);
>  static void delayed_put_pid(struct rcu_head *rhp)
>  {
>  	struct pid *pid = container_of(rhp, struct pid, rcu);
> +	pidfs_remove_pid(pid);
>  	put_pid(pid);
>  }
>  
> @@ -141,7 +140,6 @@ void free_pid(struct pid *pid)
>  
>  		idr_remove(&ns->idr, upid->nr);
>  	}
> -	pidfs_remove_pid(pid);
>  	spin_unlock(&pidmap_lock);
>  
>  	call_rcu(&pid->rcu, delayed_put_pid);

I don't understand this. If you remove pid from the rhashtable after the
rcu period expires, then there can be rcu readers of rhashtable accessing
the freed object. So IMHO you need to keep the call to pidfs_remove_pid()
before call_rcu().

> @@ -315,7 +313,14 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *arg_set_tid,
>  	retval = -ENOMEM;
>  	if (unlikely(!(ns->pid_allocated & PIDNS_ADDING)))
>  		goto out_free;
> -	pidfs_add_pid(pid);
> +	pidfs_prepare_pid(pid);
> +	spin_unlock(&pidmap_lock);
> +
> +	retval = pidfs_add_pid(pid);
> +	if (retval)
> +		goto out_free_idr;
> +
> +	spin_lock(&pidmap_lock);

The PIDNS_ADDING logic now looks suspicious to me. With this change you can
check for PIDNS_ADDING here, then have another thread execute
disable_pid_allocation() and then still add new pid to the ns here so
AFAICT zap_pid_ns_processes() can miss the newly added entry? I'm sorry if
I'm missing something, I don't really deeply understand this code.

>  	for (upid = pid->numbers + ns->level; upid >= pid->numbers; --upid) {
>  		/* Make the PID visible to find_pid_ns. */
>  		idr_replace(&upid->ns->idr, pid, upid->nr);
> @@ -328,6 +333,11 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *arg_set_tid,
>  	return pid;
>  
>  out_free:
> +	spin_unlock(&pidmap_lock);
> +out_free_idr:
> +	idr_preload_end();

As a side note idr_preload games in this last part of alloc_pid() look
pointless to me because the only thing you do seems to be idr_replace()
which doesn't need any allocation.

> +
> +	spin_lock(&pidmap_lock);
>  	while (++i <= ns->level) {
>  		upid = pid->numbers + i;
>  		idr_remove(&upid->ns->idr, upid->nr);
> @@ -338,7 +348,6 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *arg_set_tid,
>  		idr_set_cursor(&ns->idr, 0);
>  
>  	spin_unlock(&pidmap_lock);
> -	idr_preload_end();
>  
>  out_abort:
>  	put_pid_ns(ns);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

