Return-Path: <linux-fsdevel+bounces-46412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43041A88DA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 23:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794221893324
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 21:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311721B393A;
	Mon, 14 Apr 2025 21:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VH03ikhN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RgLxks+A";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VH03ikhN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RgLxks+A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C688D2DFA4E
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 21:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665582; cv=none; b=JhDnkJizlALJGy0SiWwXh1DEYT2RfT9P7vW9kyGaJOakambMhQwFLHOYkFJpPZTojpQ+1OSv7D7dCaaB9kx4L8tZWaT4SS8vb1K9bb7D2BYdLkoYiC0vgqdhjlwqEulL0Fwwzu56IeodPVvbb0sRps1vE9YaEQGqe4O35dUSLfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665582; c=relaxed/simple;
	bh=l6Ig6+J4GuZ6/A1K7dy/rvTJpQ17WTMvlIYEG5kw3+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHMWBZetb6XJvm7ksjIHt67t+UI8fNVsqwV1RJ26uRFCEd3IDLYK7r9V2lkv1uXZrDxIkE8T+IFCLcVX9UMPv+zXYvC/6gQPYzLPKYkYPgOyqTTYaAeD5jJKcixhFcy6YMuYx56xeMEX9mM2Sro0EoKyR8s/vpM8BH+UwWfVAtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VH03ikhN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RgLxks+A; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VH03ikhN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RgLxks+A; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 659131F45B;
	Mon, 14 Apr 2025 21:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744665578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MHjAdveFHhSGLZ4CIDQb2VoA7kwShSVVqZUnvl1wzMc=;
	b=VH03ikhNbN+pf7J5KELnXkgYCtnG4Lz3GGCS9Y353hXRvdDn5MhN1DAsmM9DiFUbTpAYxf
	TohKfUw3V0liGYCSKZwU8r9qZq88IqGSrZlrWPNrlRhP93QLLWgWyrUsJ63znxewGt1ul5
	oAXKJ9nBpPPwfLTjJOfmal477ErOJE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744665578;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MHjAdveFHhSGLZ4CIDQb2VoA7kwShSVVqZUnvl1wzMc=;
	b=RgLxks+A1xFTiFaPiZ+n/fFH88xxUcy7atXiE330rq0N/nIOkhdQtUbDG4UFWACBSPh22y
	pDgcgKRx7OLWt4Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VH03ikhN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RgLxks+A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744665578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MHjAdveFHhSGLZ4CIDQb2VoA7kwShSVVqZUnvl1wzMc=;
	b=VH03ikhNbN+pf7J5KELnXkgYCtnG4Lz3GGCS9Y353hXRvdDn5MhN1DAsmM9DiFUbTpAYxf
	TohKfUw3V0liGYCSKZwU8r9qZq88IqGSrZlrWPNrlRhP93QLLWgWyrUsJ63znxewGt1ul5
	oAXKJ9nBpPPwfLTjJOfmal477ErOJE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744665578;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MHjAdveFHhSGLZ4CIDQb2VoA7kwShSVVqZUnvl1wzMc=;
	b=RgLxks+A1xFTiFaPiZ+n/fFH88xxUcy7atXiE330rq0N/nIOkhdQtUbDG4UFWACBSPh22y
	pDgcgKRx7OLWt4Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56BF51336F;
	Mon, 14 Apr 2025 21:19:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JIGRFOp7/WcMAwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 14 Apr 2025 21:19:38 +0000
Message-ID: <4bbd0623-e6d8-4103-9582-cc27d50d03d5@suse.cz>
Date: Mon, 14 Apr 2025 23:19:38 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: add kern_path_locked_negative()
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: NeilBrown <neilb@suse.de>
References: <20250414-rennt-wimmeln-f186c3a780f1@brauner>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250414-rennt-wimmeln-f186c3a780f1@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 659131F45B
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,opensuse.org:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/14/25 22:13, Christian Brauner wrote:
> The audit code relies on the fact that kern_path_locked() returned a
> path even for a negative dentry. If it doesn't find a valid dentry it
> immediately calls:
> 
>     audit_find_parent(d_backing_inode(parent_path.dentry));
> 
> which assumes that parent_path.dentry is still valid. But it isn't since
> kern_path_locked() has been changed to path_put() also for a negative
> dentry.
> 
> Fix this by adding a helper that implements the required audit semantics
> and allows us to fix the immediate bleeding. We can find a unified
> solution for this afterwards.

I've been seeing these warnings on every boot since rc1:
https://paste.opensuse.org/pastes/5501e8bfc22f

One time there was also an oops later on:
https://paste.opensuse.org/pastes/48406b5d1c96

At least the warnings are gone with this patch. Thanks!

Reported-and-tested-by: Vlastimil Babka <vbabka@suse.cz>

> Fixes: 1c3cb50b58c3 ("VFS: change kern_path_locked() and user_path_locked_at() to never return negative dentry")
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/namei.c            | 65 ++++++++++++++++++++++++++++++++-----------
>  include/linux/namei.h |  1 +
>  kernel/audit_watch.c  | 16 +++++++----
>  3 files changed, 60 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 360a86ca1f02..2c5ca9ef6811 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1665,27 +1665,20 @@ static struct dentry *lookup_dcache(const struct qstr *name,
>  	return dentry;
>  }
>  
> -/*
> - * Parent directory has inode locked exclusive.  This is one
> - * and only case when ->lookup() gets called on non in-lookup
> - * dentries - as the matter of fact, this only gets called
> - * when directory is guaranteed to have no in-lookup children
> - * at all.
> - * Will return -ENOENT if name isn't found and LOOKUP_CREATE wasn't passed.
> - * Will return -EEXIST if name is found and LOOKUP_EXCL was passed.
> - */
> -struct dentry *lookup_one_qstr_excl(const struct qstr *name,
> -				    struct dentry *base,
> -				    unsigned int flags)
> +static struct dentry *lookup_one_qstr_excl_raw(const struct qstr *name,
> +					       struct dentry *base,
> +					       unsigned int flags)
>  {
> -	struct dentry *dentry = lookup_dcache(name, base, flags);
> +	struct dentry *dentry;
>  	struct dentry *old;
> -	struct inode *dir = base->d_inode;
> +	struct inode *dir;
>  
> +	dentry = lookup_dcache(name, base, flags);
>  	if (dentry)
> -		goto found;
> +		return dentry;
>  
>  	/* Don't create child dentry for a dead directory. */
> +	dir = base->d_inode;
>  	if (unlikely(IS_DEADDIR(dir)))
>  		return ERR_PTR(-ENOENT);
>  
> @@ -1698,7 +1691,24 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
>  		dput(dentry);
>  		dentry = old;
>  	}
> -found:
> +	return dentry;
> +}
> +
> +/*
> + * Parent directory has inode locked exclusive.  This is one
> + * and only case when ->lookup() gets called on non in-lookup
> + * dentries - as the matter of fact, this only gets called
> + * when directory is guaranteed to have no in-lookup children
> + * at all.
> + * Will return -ENOENT if name isn't found and LOOKUP_CREATE wasn't passed.
> + * Will return -EEXIST if name is found and LOOKUP_EXCL was passed.
> + */
> +struct dentry *lookup_one_qstr_excl(const struct qstr *name,
> +				    struct dentry *base, unsigned int flags)
> +{
> +	struct dentry *dentry;
> +
> +	dentry = lookup_one_qstr_excl_raw(name, base, flags);
>  	if (IS_ERR(dentry))
>  		return dentry;
>  	if (d_is_negative(dentry) && !(flags & LOOKUP_CREATE)) {
> @@ -2762,6 +2772,29 @@ static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct
>  	return d;
>  }
>  
> +struct dentry *kern_path_locked_negative(const char *name, struct path *path)
> +{
> +	struct filename *filename __free(putname) = getname_kernel(name);
> +	struct dentry *d;
> +	struct qstr last;
> +	int type, error;
> +
> +	error = filename_parentat(AT_FDCWD, filename, 0, path, &last, &type);
> +	if (error)
> +		return ERR_PTR(error);
> +	if (unlikely(type != LAST_NORM)) {
> +		path_put(path);
> +		return ERR_PTR(-EINVAL);
> +	}
> +	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
> +	d = lookup_one_qstr_excl_raw(&last, path->dentry, 0);
> +	if (IS_ERR(d)) {
> +		inode_unlock(path->dentry->d_inode);
> +		path_put(path);
> +	}
> +	return d;
> +}
> +
>  struct dentry *kern_path_locked(const char *name, struct path *path)
>  {
>  	struct filename *filename = getname_kernel(name);
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index e3042176cdf4..bbaf55fb3101 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -62,6 +62,7 @@ extern struct dentry *kern_path_create(int, const char *, struct path *, unsigne
>  extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
>  extern void done_path_create(struct path *, struct dentry *);
>  extern struct dentry *kern_path_locked(const char *, struct path *);
> +extern struct dentry *kern_path_locked_negative(const char *, struct path *);
>  extern struct dentry *user_path_locked_at(int , const char __user *, struct path *);
>  int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
>  			   struct path *parent, struct qstr *last, int *type,
> diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> index 367eaf2c78b7..0ebbbe37a60f 100644
> --- a/kernel/audit_watch.c
> +++ b/kernel/audit_watch.c
> @@ -347,12 +347,17 @@ static void audit_remove_parent_watches(struct audit_parent *parent)
>  /* Get path information necessary for adding watches. */
>  static int audit_get_nd(struct audit_watch *watch, struct path *parent)
>  {
> -	struct dentry *d = kern_path_locked(watch->path, parent);
> +	struct dentry *d;
> +
> +	d = kern_path_locked_negative(watch->path, parent);
>  	if (IS_ERR(d))
>  		return PTR_ERR(d);
> -	/* update watch filter fields */
> -	watch->dev = d->d_sb->s_dev;
> -	watch->ino = d_backing_inode(d)->i_ino;
> +
> +	if (d_is_positive(d)) {
> +		/* update watch filter fields */
> +		watch->dev = d->d_sb->s_dev;
> +		watch->ino = d_backing_inode(d)->i_ino;
> +	}
>  
>  	inode_unlock(d_backing_inode(parent->dentry));
>  	dput(d);
> @@ -418,11 +423,10 @@ int audit_add_watch(struct audit_krule *krule, struct list_head **list)
>  	/* caller expects mutex locked */
>  	mutex_lock(&audit_filter_mutex);
>  
> -	if (ret && ret != -ENOENT) {
> +	if (ret) {
>  		audit_put_watch(watch);
>  		return ret;
>  	}
> -	ret = 0;
>  
>  	/* either find an old parent or attach a new one */
>  	parent = audit_find_parent(d_backing_inode(parent_path.dentry));


