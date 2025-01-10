Return-Path: <linux-fsdevel+bounces-38844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB33A08C40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 10:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E379188CBA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 09:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695EE20ADE5;
	Fri, 10 Jan 2025 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1AP1nKZI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jTibacc5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1AP1nKZI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jTibacc5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7C320A5CE;
	Fri, 10 Jan 2025 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501722; cv=none; b=YEWq6zMrT+olTOJL47qNJCTDrJI6gOqbtayP3l0Jza3kmavkUwNMtrb90Fs9J+ogP6zzvzQJPIU2mlmMgjQbPfE8ERpMo3QJzT9z50HLQbBDrnSUHM0wIvSfF9nh/LQW2QSf5tTC0Rnn002zwJkBWlWlQt9yyzNskm2zmjvf3z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501722; c=relaxed/simple;
	bh=TQ+eHDbD50umq+ZEKX14eO/wOA3rhuw7CnKEGyY71vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzI1LoZyA/bLr4+SRDtUTdnaF0jlPCNqmU15eVxYCcmb+tQNijS541uGRgFJZHF6NRRynv6vUxmJR9CQxyWYggGEGSMyHj7F/OicCwJmDBfSo88TE6Aeiv5WK3Fjpq+TGGjpkAr0U2PYGEpNq+5y9UsXI3bNRGFD2y7maqRqgOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1AP1nKZI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jTibacc5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1AP1nKZI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jTibacc5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7D72E21108;
	Fri, 10 Jan 2025 09:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736501718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+dPV5SCyw5jR+UUW4wBWhIASOY9Net0C+XYx+P8OVcc=;
	b=1AP1nKZIa+mLekPo1+E5efrNOkTmLScwyD2KMTlAbiMCeU3ZQVc4XpcjMqUAfxNOwb94Eu
	NuOfrYlpuB01qSqZb5H7kjy6HmnvHn9tBN02AgmEvzzgIm0wW0LDGYBT0KDvj/RvOotev/
	Csb1tghSVh+DITi1X0kBUcG557Hv0hs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736501718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+dPV5SCyw5jR+UUW4wBWhIASOY9Net0C+XYx+P8OVcc=;
	b=jTibacc5AsBvXDEXLIzSPguEI2jfL22lEO2oKWGVev/C+kdznt7Rj2XrLJK47prpjdN6wA
	hI/H+MMkG815+sBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736501718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+dPV5SCyw5jR+UUW4wBWhIASOY9Net0C+XYx+P8OVcc=;
	b=1AP1nKZIa+mLekPo1+E5efrNOkTmLScwyD2KMTlAbiMCeU3ZQVc4XpcjMqUAfxNOwb94Eu
	NuOfrYlpuB01qSqZb5H7kjy6HmnvHn9tBN02AgmEvzzgIm0wW0LDGYBT0KDvj/RvOotev/
	Csb1tghSVh+DITi1X0kBUcG557Hv0hs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736501718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+dPV5SCyw5jR+UUW4wBWhIASOY9Net0C+XYx+P8OVcc=;
	b=jTibacc5AsBvXDEXLIzSPguEI2jfL22lEO2oKWGVev/C+kdznt7Rj2XrLJK47prpjdN6wA
	hI/H+MMkG815+sBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70EE413A86;
	Fri, 10 Jan 2025 09:35:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QuqPG9bpgGejEwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Jan 2025 09:35:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 22C52A0889; Fri, 10 Jan 2025 10:35:14 +0100 (CET)
Date: Fri, 10 Jan 2025 10:35:14 +0100
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, agruenba@redhat.com, amir73il@gmail.com, 
	brauner@kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	hubcap@omnibond.com, jack@suse.cz, krisman@kernel.org, linux-nfs@vger.kernel.org, 
	miklos@szeredi.hu, torvalds@linux-foundation.org
Subject: Re: [PATCH 02/20] dcache: back inline names with a struct-wrapped
 array of unsigned long
Message-ID: <4mqzkypsznfnkohe5yqz57p5sz5y4x6ftdsgiylbbf6jsu63qm@krbsv3jwdn4w>
References: <20250110023854.GS1977892@ZenIV>
 <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
 <20250110024303.4157645-2-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110024303.4157645-2-viro@zeniv.linux.org.uk>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,gmail.com,kernel.org,omnibond.com,suse.cz,szeredi.hu,linux-foundation.org];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 10-01-25 02:42:45, Al Viro wrote:
> ... so that they can be copied with struct assignment (which generates
> better code) and accessed word-by-word.
> 
> The type is union shortname_storage; it's a union of arrays of
> unsigned char and unsigned long.
> 
> struct name_snapshot.inline_name turned into union shortname_storage;
> users (all in fs/dcache.c) adjusted.
> 
> struct dentry.d_iname has some users outside of fs/dcache.c; to
> reduce the amount of noise in commit, it is replaced with
> union shortname_storage d_shortname and d_iname is turned into a macro
> that expands to d_shortname.string (similar to d_lock handling, hopefully
> temporary - most, if not all, users shouldn't be messing with it).)
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

I was thinking for a while whether if you now always copy 40 bytes instead
of only d_name.len bytes cannot have any adverse performance effects
(additional cacheline fetched / dirtied) but I don't think any path copying
the name is that performance critical to matter if it would be noticeable
at all.

								Honza


> ---
>  fs/dcache.c                                  | 43 +++++++++-----------
>  include/linux/dcache.h                       | 10 ++++-
>  tools/testing/selftests/bpf/progs/find_vma.c |  2 +-
>  3 files changed, 28 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index ea0f0bea511b..52662a5d08e4 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -324,7 +324,7 @@ static void __d_free_external(struct rcu_head *head)
>  
>  static inline int dname_external(const struct dentry *dentry)
>  {
> -	return dentry->d_name.name != dentry->d_iname;
> +	return dentry->d_name.name != dentry->d_shortname.string;
>  }
>  
>  void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry)
> @@ -334,9 +334,8 @@ void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry
>  	if (unlikely(dname_external(dentry))) {
>  		atomic_inc(&external_name(dentry)->u.count);
>  	} else {
> -		memcpy(name->inline_name, dentry->d_iname,
> -		       dentry->d_name.len + 1);
> -		name->name.name = name->inline_name;
> +		name->inline_name = dentry->d_shortname;
> +		name->name.name = name->inline_name.string;
>  	}
>  	spin_unlock(&dentry->d_lock);
>  }
> @@ -344,7 +343,7 @@ EXPORT_SYMBOL(take_dentry_name_snapshot);
>  
>  void release_dentry_name_snapshot(struct name_snapshot *name)
>  {
> -	if (unlikely(name->name.name != name->inline_name)) {
> +	if (unlikely(name->name.name != name->inline_name.string)) {
>  		struct external_name *p;
>  		p = container_of(name->name.name, struct external_name, name[0]);
>  		if (unlikely(atomic_dec_and_test(&p->u.count)))
> @@ -1654,10 +1653,10 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
>  	 * will still always have a NUL at the end, even if we might
>  	 * be overwriting an internal NUL character
>  	 */
> -	dentry->d_iname[DNAME_INLINE_LEN-1] = 0;
> +	dentry->d_shortname.string[DNAME_INLINE_LEN-1] = 0;
>  	if (unlikely(!name)) {
>  		name = &slash_name;
> -		dname = dentry->d_iname;
> +		dname = dentry->d_shortname.string;
>  	} else if (name->len > DNAME_INLINE_LEN-1) {
>  		size_t size = offsetof(struct external_name, name[1]);
>  		struct external_name *p = kmalloc(size + name->len,
> @@ -1670,7 +1669,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
>  		atomic_set(&p->u.count, 1);
>  		dname = p->name;
>  	} else  {
> -		dname = dentry->d_iname;
> +		dname = dentry->d_shortname.string;
>  	}	
>  
>  	dentry->d_name.len = name->len;
> @@ -2729,10 +2728,9 @@ static void swap_names(struct dentry *dentry, struct dentry *target)
>  			 * dentry:internal, target:external.  Steal target's
>  			 * storage and make target internal.
>  			 */
> -			memcpy(target->d_iname, dentry->d_name.name,
> -					dentry->d_name.len + 1);
>  			dentry->d_name.name = target->d_name.name;
> -			target->d_name.name = target->d_iname;
> +			target->d_shortname = dentry->d_shortname;
> +			target->d_name.name = target->d_shortname.string;
>  		}
>  	} else {
>  		if (unlikely(dname_external(dentry))) {
> @@ -2740,18 +2738,16 @@ static void swap_names(struct dentry *dentry, struct dentry *target)
>  			 * dentry:external, target:internal.  Give dentry's
>  			 * storage to target and make dentry internal
>  			 */
> -			memcpy(dentry->d_iname, target->d_name.name,
> -					target->d_name.len + 1);
>  			target->d_name.name = dentry->d_name.name;
> -			dentry->d_name.name = dentry->d_iname;
> +			dentry->d_shortname = target->d_shortname;
> +			dentry->d_name.name = dentry->d_shortname.string;
>  		} else {
>  			/*
>  			 * Both are internal.
>  			 */
> -			for (int i = 0; i < DNAME_INLINE_WORDS; i++) {
> -				swap(((long *) &dentry->d_iname)[i],
> -				     ((long *) &target->d_iname)[i]);
> -			}
> +			for (int i = 0; i < DNAME_INLINE_WORDS; i++)
> +				swap(dentry->d_shortname.words[i],
> +				     target->d_shortname.words[i]);
>  		}
>  	}
>  	swap(dentry->d_name.hash_len, target->d_name.hash_len);
> @@ -2766,9 +2762,8 @@ static void copy_name(struct dentry *dentry, struct dentry *target)
>  		atomic_inc(&external_name(target)->u.count);
>  		dentry->d_name = target->d_name;
>  	} else {
> -		memcpy(dentry->d_iname, target->d_name.name,
> -				target->d_name.len + 1);
> -		dentry->d_name.name = dentry->d_iname;
> +		dentry->d_shortname = target->d_shortname;
> +		dentry->d_name.name = dentry->d_shortname.string;
>  		dentry->d_name.hash_len = target->d_name.hash_len;
>  	}
>  	if (old_name && likely(atomic_dec_and_test(&old_name->u.count)))
> @@ -3101,12 +3096,12 @@ void d_mark_tmpfile(struct file *file, struct inode *inode)
>  {
>  	struct dentry *dentry = file->f_path.dentry;
>  
> -	BUG_ON(dentry->d_name.name != dentry->d_iname ||
> +	BUG_ON(dname_external(dentry) ||
>  		!hlist_unhashed(&dentry->d_u.d_alias) ||
>  		!d_unlinked(dentry));
>  	spin_lock(&dentry->d_parent->d_lock);
>  	spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
> -	dentry->d_name.len = sprintf(dentry->d_iname, "#%llu",
> +	dentry->d_name.len = sprintf(dentry->d_shortname.string, "#%llu",
>  				(unsigned long long)inode->i_ino);
>  	spin_unlock(&dentry->d_lock);
>  	spin_unlock(&dentry->d_parent->d_lock);
> @@ -3194,7 +3189,7 @@ static void __init dcache_init(void)
>  	 */
>  	dentry_cache = KMEM_CACHE_USERCOPY(dentry,
>  		SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_ACCOUNT,
> -		d_iname);
> +		d_shortname.string);
>  
>  	/* Hash may have been set up in dcache_init_early */
>  	if (!hashdist)
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 42dd89beaf4e..8bc567a35718 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -79,7 +79,13 @@ extern const struct qstr dotdot_name;
>  
>  #define DNAME_INLINE_LEN (DNAME_INLINE_WORDS*sizeof(unsigned long))
>  
> +union shortname_store {
> +	unsigned char string[DNAME_INLINE_LEN];
> +	unsigned long words[DNAME_INLINE_WORDS];
> +};
> +
>  #define d_lock	d_lockref.lock
> +#define d_iname d_shortname.string
>  
>  struct dentry {
>  	/* RCU lookup touched fields */
> @@ -90,7 +96,7 @@ struct dentry {
>  	struct qstr d_name;
>  	struct inode *d_inode;		/* Where the name belongs to - NULL is
>  					 * negative */
> -	unsigned char d_iname[DNAME_INLINE_LEN];	/* small names */
> +	union shortname_store d_shortname;
>  	/* --- cacheline 1 boundary (64 bytes) was 32 bytes ago --- */
>  
>  	/* Ref lookup also touches following */
> @@ -591,7 +597,7 @@ static inline struct inode *d_real_inode(const struct dentry *dentry)
>  
>  struct name_snapshot {
>  	struct qstr name;
> -	unsigned char inline_name[DNAME_INLINE_LEN];
> +	union shortname_store inline_name;
>  };
>  void take_dentry_name_snapshot(struct name_snapshot *, struct dentry *);
>  void release_dentry_name_snapshot(struct name_snapshot *);
> diff --git a/tools/testing/selftests/bpf/progs/find_vma.c b/tools/testing/selftests/bpf/progs/find_vma.c
> index 38034fb82530..02b82774469c 100644
> --- a/tools/testing/selftests/bpf/progs/find_vma.c
> +++ b/tools/testing/selftests/bpf/progs/find_vma.c
> @@ -25,7 +25,7 @@ static long check_vma(struct task_struct *task, struct vm_area_struct *vma,
>  {
>  	if (vma->vm_file)
>  		bpf_probe_read_kernel_str(d_iname, DNAME_INLINE_LEN - 1,
> -					  vma->vm_file->f_path.dentry->d_iname);
> +					  vma->vm_file->f_path.dentry->d_shortname.string);
>  
>  	/* check for VM_EXEC */
>  	if (vma->vm_flags & VM_EXEC)
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

