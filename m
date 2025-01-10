Return-Path: <linux-fsdevel+bounces-38846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C91A08CB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 10:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D81597A1F86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 09:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366A920D4EF;
	Fri, 10 Jan 2025 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ytd/+Lfl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N0W44tfq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ytd/+Lfl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N0W44tfq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E2620C028;
	Fri, 10 Jan 2025 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502334; cv=none; b=tgz0umkUbXFjJiheCe+mVUBl6tiznWVp0IAK6jpyhPqYzLh7LIxjGY2GQNGVKZV/JNy9y3TCuTV1yjkxp/ZdYvfUQEO7FG0I/o/g96dV74FepzrYSWcqLUiWVrD+flt9TaHxJoL8GhYiEnB66RUGEdTpFQjr/Di45lbngu/zLKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502334; c=relaxed/simple;
	bh=ba1wWltX8Jm35HQZX8TLwjITQhPwQitmTk5squ4TbsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukOlNIBJdE/8KQFuzhopSODRxXPcFuNUlya2MKatHJIe+W1Ffsx8F63QsKKvVP5dWRXrMskmMe9hVUvdD7fd5/yp7TsBvxGDuEBKArZi9ZlekJfHczYrS9HZvOPuKf1RHJ09tE8a7Rc0aveC9JWLdxDLgofJp0TWLId7fM+ReUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ytd/+Lfl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N0W44tfq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ytd/+Lfl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N0W44tfq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 835E61F394;
	Fri, 10 Jan 2025 09:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736502330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l2qa2L55vC2t0giFh2ERboOCPg3UQyUAglLoBSfdQWU=;
	b=ytd/+LflNPJlx4BLtDzJr/90HuHsRgDUAEkCBNK26LiE3kostGv9zJ8ZGtxAz4im1SNuHl
	6g7ApCSLY5OMCl0HrGPCQqfqeNLDCjvH/g/SBk5irLPQNlbFEyi3QtwUCjSFMZfmRWfXnD
	HVcIGIKwenD+TBWVcP/3oIethkQYxgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736502330;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l2qa2L55vC2t0giFh2ERboOCPg3UQyUAglLoBSfdQWU=;
	b=N0W44tfqFC/v27LClS7d9iTzYM3YKvU++Drgu6JISJTTQU4BKE+s+64EfDC1nU4d15mxTZ
	IVrejbLVKiqvWEBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="ytd/+Lfl";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=N0W44tfq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736502330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l2qa2L55vC2t0giFh2ERboOCPg3UQyUAglLoBSfdQWU=;
	b=ytd/+LflNPJlx4BLtDzJr/90HuHsRgDUAEkCBNK26LiE3kostGv9zJ8ZGtxAz4im1SNuHl
	6g7ApCSLY5OMCl0HrGPCQqfqeNLDCjvH/g/SBk5irLPQNlbFEyi3QtwUCjSFMZfmRWfXnD
	HVcIGIKwenD+TBWVcP/3oIethkQYxgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736502330;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l2qa2L55vC2t0giFh2ERboOCPg3UQyUAglLoBSfdQWU=;
	b=N0W44tfqFC/v27LClS7d9iTzYM3YKvU++Drgu6JISJTTQU4BKE+s+64EfDC1nU4d15mxTZ
	IVrejbLVKiqvWEBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65F7013A86;
	Fri, 10 Jan 2025 09:45:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BM7eGDrsgGeFGAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Jan 2025 09:45:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1887BA0889; Fri, 10 Jan 2025 10:45:26 +0100 (CET)
Date: Fri, 10 Jan 2025 10:45:26 +0100
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, agruenba@redhat.com, amir73il@gmail.com, 
	brauner@kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	hubcap@omnibond.com, jack@suse.cz, krisman@kernel.org, linux-nfs@vger.kernel.org, 
	miklos@szeredi.hu, torvalds@linux-foundation.org
Subject: Re: [PATCH 03/20] make take_dentry_name_snapshot() lockless
Message-ID: <2pgmld6ntcxtxzdv3gax63dmxe2wi2p2nfmkqcqbv5zgi7rni7@zxoum5yaqgtp>
References: <20250110023854.GS1977892@ZenIV>
 <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
 <20250110024303.4157645-3-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110024303.4157645-3-viro@zeniv.linux.org.uk>
X-Rspamd-Queue-Id: 835E61F394
X-Spam-Level: 
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,gmail.com,kernel.org,omnibond.com,suse.cz,szeredi.hu,linux-foundation.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linux.org.uk:email,suse.cz:dkim,suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 10-01-25 02:42:46, Al Viro wrote:
> Use ->d_seq instead of grabbing ->d_lock; in case of shortname dentries
> that avoids any stores to shared data objects and in case of long names
> we are down to (unavoidable) atomic_inc on the external_name refcount.
> 
> Makes the thing safer as well - the areas where ->d_seq is held odd are
> all nested inside the areas where ->d_lock is held, and the latter are
> much more numerous.
> 
> NOTE: now that there is a lockless path where we might try to grab
> a reference to an already doomed external_name instance, it is no
> longer possible for external_name.u.count and external_name.u.head
> to share space (kudos to Linus for spotting that).
> 
> To reduce the noice this commit just turns external_name.u into
> a struct (instead of union); the next commit will dissolve it.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Cool. One less lock roundtrip on relatively hot fsnotify path :). Feel free
to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dcache.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 52662a5d08e4..f387dc97df86 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -296,9 +296,9 @@ static inline int dentry_cmp(const struct dentry *dentry, const unsigned char *c
>  }
>  
>  struct external_name {
> -	union {
> -		atomic_t count;
> -		struct rcu_head head;
> +	struct {
> +		atomic_t count;		// ->count and ->head can't be combined
> +		struct rcu_head head;	// see take_dentry_name_snapshot()
>  	} u;
>  	unsigned char name[];
>  };
> @@ -329,15 +329,30 @@ static inline int dname_external(const struct dentry *dentry)
>  
>  void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry)
>  {
> -	spin_lock(&dentry->d_lock);
> -	name->name = dentry->d_name;
> -	if (unlikely(dname_external(dentry))) {
> -		atomic_inc(&external_name(dentry)->u.count);
> -	} else {
> +	unsigned seq;
> +	const unsigned char *s;
> +
> +	rcu_read_lock();
> +retry:
> +	seq = read_seqcount_begin(&dentry->d_seq);
> +	s = READ_ONCE(dentry->d_name.name);
> +	name->name.hash_len = dentry->d_name.hash_len;
> +	name->name.name = name->inline_name.string;
> +	if (likely(s == dentry->d_shortname.string)) {
>  		name->inline_name = dentry->d_shortname;
> -		name->name.name = name->inline_name.string;
> +	} else {
> +		struct external_name *p;
> +		p = container_of(s, struct external_name, name[0]);
> +		// get a valid reference
> +		if (unlikely(!atomic_inc_not_zero(&p->u.count)))
> +			goto retry;
> +		name->name.name = s;
>  	}
> -	spin_unlock(&dentry->d_lock);
> +	if (read_seqcount_retry(&dentry->d_seq, seq)) {
> +		release_dentry_name_snapshot(name);
> +		goto retry;
> +	}
> +	rcu_read_unlock();
>  }
>  EXPORT_SYMBOL(take_dentry_name_snapshot);
>  
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

