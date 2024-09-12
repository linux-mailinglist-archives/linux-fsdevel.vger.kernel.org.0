Return-Path: <linux-fsdevel+bounces-29151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FD99766FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 12:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BFEC1F23441
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 10:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFB219E980;
	Thu, 12 Sep 2024 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A+cQO9Fl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9ZPgpvRZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A+cQO9Fl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9ZPgpvRZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFAE15D5D9
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726138426; cv=none; b=d1Zg49ItEF3P3Bg8Winc/1IX1X4aE7rQgUp0p6LgEfNdUdhL+WcEE8+ZAth9bHqRGVkkTea6AZ59ALSEhMprKTnpQoTuCB12lFJp+BapDAJVaAVnvoEb2OLC6eEyDN1cD8FmxStCkg1Es2H3sZIM5a5DVfLifO0jCHFPEOr8AEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726138426; c=relaxed/simple;
	bh=5Q4EToOD5X1K45X7rBh/aexqUsL+J3Tb+qIZYFCfa1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifi45M8pGs8GEQOMGPFrClQTqovFPgbUofwoZLTCEtY806uDc7iCY9yiwwkx4KMIU33VuuveagxvaJ/d0655FzwMRxlIZtd+yWmXcr7aAm2Zzu3q4CofeBXTyH/oQTR2XAypETW4RKOWXoQHc7RGJU6r7rqdYIyTxxH9ICgH7YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A+cQO9Fl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9ZPgpvRZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A+cQO9Fl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9ZPgpvRZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0403521AF6;
	Thu, 12 Sep 2024 10:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726138421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8I2re7JWtSX6HtTWKJlZJE9uqKLVbGtyRmUr8M9A1o=;
	b=A+cQO9FlRa5O25tysTLg3cJeLCa2kYMkrViAZCSumM6KxnXN/qo2OJq2UO9k/krIesLZqr
	KdRwYqW3P/0/SdjjtbsWzDicx3wlL/5NHXsT+3fMUX7DYk0PBvFB57jEZQuJSjMT9tD54T
	QK2bjGBEOG1UYKcCyKE71tQjoxoGlBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726138421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8I2re7JWtSX6HtTWKJlZJE9uqKLVbGtyRmUr8M9A1o=;
	b=9ZPgpvRZ7okc/34F3edNCFNk8eoKu2DkBCaSYvTJ0MQqsBmC8ovuGI9+lk0nawLn8KuH40
	PlH9wf+3Od3/yTBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=A+cQO9Fl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9ZPgpvRZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726138421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8I2re7JWtSX6HtTWKJlZJE9uqKLVbGtyRmUr8M9A1o=;
	b=A+cQO9FlRa5O25tysTLg3cJeLCa2kYMkrViAZCSumM6KxnXN/qo2OJq2UO9k/krIesLZqr
	KdRwYqW3P/0/SdjjtbsWzDicx3wlL/5NHXsT+3fMUX7DYk0PBvFB57jEZQuJSjMT9tD54T
	QK2bjGBEOG1UYKcCyKE71tQjoxoGlBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726138421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8I2re7JWtSX6HtTWKJlZJE9uqKLVbGtyRmUr8M9A1o=;
	b=9ZPgpvRZ7okc/34F3edNCFNk8eoKu2DkBCaSYvTJ0MQqsBmC8ovuGI9+lk0nawLn8KuH40
	PlH9wf+3Od3/yTBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB3E413AD8;
	Thu, 12 Sep 2024 10:53:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2iRmOTTI4mZNPQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Sep 2024 10:53:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 83492A08B3; Thu, 12 Sep 2024 12:53:40 +0200 (CEST)
Date: Thu, 12 Sep 2024 12:53:40 +0200
From: Jan Kara <jack@suse.cz>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] vfs: Introduce a new open flag to imply dentry
 deletion on file removal
Message-ID: <20240912105340.k2qsq7ao2e7f4fci@quack3>
References: <20240912091548.98132-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240912091548.98132-1-laoar.shao@gmail.com>
X-Rspamd-Queue-Id: 0403521AF6
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim,suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Thu 12-09-24 17:15:48, Yafang Shao wrote:
> Commit 681ce8623567 ("vfs: Delete the associated dentry when deleting a
> file") introduced an unconditional deletion of the associated dentry when a
> file is removed. However, this led to performance regressions in specific
> benchmarks, such as ilebench.sum_operations/s [0], prompting a revert in
> commit 4a4be1ad3a6e ("Revert 'vfs: Delete the associated dentry when
> deleting a file'").
> 
> This patch seeks to reintroduce the concept conditionally, where the
> associated dentry is deleted only when the user explicitly opts for it
> during file removal.
> 
> There are practical use cases for this proactive dentry reclamation.
> Besides the Elasticsearch use case mentioned in commit 681ce8623567,
> additional examples have surfaced in our production environment. For
> instance, in video rendering services that continuously generate temporary
> files, upload them to persistent storage servers, and then delete them, a
> large number of negative dentries—serving no useful purpose—accumulate.
> Users in such cases would benefit from proactively reclaiming these
> negative dentries. This patch provides an API allowing users to actively
> delete these unnecessary negative dentries.
> 
> Link: https://lore.kernel.org/linux-fsdevel/202405291318.4dfbb352-oliver.sang@intel.com [0]
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>

Umm, I don't think we want to burn a FMODE flag and expose these details of
dentry reclaim to userspace. BTW, if we wanted to do this, we already have
d_mark_dontcache() for in-kernel users which we could presumably reuse.

But I would not completely give up on trying to handle this in an automated
way inside the kernel. The original solution you mention above was perhaps
too aggressive but maybe d_delete() could just mark the dentry with a
"deleted" flag, retain_dentry() would move such dentries into a special LRU
list which we'd prune once in a while (say once per 5 s). Also this list
would be automatically pruned from prune_dcache_sb(). This way if there's
quick reuse of a dentry, it will get reused and no harm is done, if it
isn't quickly reused, we'll free them to not waste memory.

What do people think about such scheme?

								Honza

> ---
>  fs/dcache.c                      | 7 ++++++-
>  fs/open.c                        | 9 ++++++++-
>  include/linux/dcache.h           | 2 +-
>  include/linux/sched.h            | 2 +-
>  include/uapi/asm-generic/fcntl.h | 4 ++++
>  5 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 3d8daaecb6d1..6d744b5e5a6c 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1667,7 +1667,10 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
>  	smp_store_release(&dentry->d_name.name, dname); /* ^^^ */
>  
>  	dentry->d_lockref.count = 1;
> -	dentry->d_flags = 0;
> +	if (current->flags & PF_REMOVE_DENTRY)
> +		dentry->d_flags = DCACHE_FILE_REMOVE;
> +	else
> +		dentry->d_flags = 0;
>  	spin_lock_init(&dentry->d_lock);
>  	seqcount_spinlock_init(&dentry->d_seq, &dentry->d_lock);
>  	dentry->d_inode = NULL;
> @@ -2394,6 +2397,8 @@ void d_delete(struct dentry * dentry)
>  	 * Are we the only user?
>  	 */
>  	if (dentry->d_lockref.count == 1) {
> +		if (dentry->d_flags & DCACHE_FILE_REMOVE)
> +			__d_drop(dentry);
>  		dentry->d_flags &= ~DCACHE_CANT_MOUNT;
>  		dentry_unlink_inode(dentry);
>  	} else {
> diff --git a/fs/open.c b/fs/open.c
> index 22adbef7ecc2..3441a004a841 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1428,7 +1428,14 @@ static long do_sys_openat2(int dfd, const char __user *filename,
>  long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
>  {
>  	struct open_how how = build_open_how(flags, mode);
> -	return do_sys_openat2(dfd, filename, &how);
> +	long err;
> +
> +	if (flags & O_NODENTRY)
> +		current->flags |= PF_REMOVE_DENTRY;
> +	err = do_sys_openat2(dfd, filename, &how);
> +	if (flags & O_NODENTRY)
> +		current->flags &= ~PF_REMOVE_DENTRY;
> +	return err;
>  }
>  
>  
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index bff956f7b2b9..82ba79bc0072 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -215,7 +215,7 @@ struct dentry_operations {
>  
>  #define DCACHE_NOKEY_NAME		BIT(25) /* Encrypted name encoded without key */
>  #define DCACHE_OP_REAL			BIT(26)
> -
> +#define DCACHE_FILE_REMOVE		BIT(27) /* remove this dentry when file is removed */
>  #define DCACHE_PAR_LOOKUP		BIT(28) /* being looked up (with parent locked shared) */
>  #define DCACHE_DENTRY_CURSOR		BIT(29)
>  #define DCACHE_NORCU			BIT(30) /* No RCU delay for freeing */
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index f8d150343d42..f931a3a882e0 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1649,7 +1649,7 @@ extern struct pid *cad_pid;
>  #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
>  #define PF_USER_WORKER		0x00004000	/* Kernel thread cloned from userspace thread */
>  #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
> -#define PF__HOLE__00010000	0x00010000
> +#define PF_REMOVE_DENTRY	0x00010000      /* Remove the dentry when the file is removed */
>  #define PF_KSWAPD		0x00020000	/* I am kswapd */
>  #define PF_MEMALLOC_NOFS	0x00040000	/* All allocations inherit GFP_NOFS. See memalloc_nfs_save() */
>  #define PF_MEMALLOC_NOIO	0x00080000	/* All allocations inherit GFP_NOIO. See memalloc_noio_save() */
> diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
> index 80f37a0d40d7..ca5f402d5e7d 100644
> --- a/include/uapi/asm-generic/fcntl.h
> +++ b/include/uapi/asm-generic/fcntl.h
> @@ -89,6 +89,10 @@
>  #define __O_TMPFILE	020000000
>  #endif
>  
> +#ifndef O_NODENTRY
> +#define O_NODENTRY     040000000
> +#endif
> +
>  /* a horrid kludge trying to make sure that this will fail on old kernels */
>  #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
>  
> -- 
> 2.43.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

