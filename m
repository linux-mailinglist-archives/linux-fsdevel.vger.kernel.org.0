Return-Path: <linux-fsdevel+bounces-39391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A255A13765
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 11:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85176188A391
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 10:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DF41DDA35;
	Thu, 16 Jan 2025 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MK4OtRqt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a7EWIuQJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MK4OtRqt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a7EWIuQJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A621156C76;
	Thu, 16 Jan 2025 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021984; cv=none; b=FwBNJp7DBsTYtAGU8kDwOrwtzpbizWJYxyOsXFVrKf8UuQUF5Zy2F7sCYhix/vb1bXe/o3gmjTPxHLyyWGRvjYOUNYzdvr05yNBdIlBpG9QjdWSvjlXM3VUFNUkuDE4EFmMYgHpEAu5QUX/VsRS5P9WUdUWP/jDu3VTc7IfzJhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021984; c=relaxed/simple;
	bh=kaFgQcnk6WlYe7pfq08jmdgw5+Z1z/+zioMakFLI9io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laobbXVorr8LQUUk+dLDesOjyHcDeX3Ys7/M+T6lRJt4/j8hcTlGP92fmdQI3/ojXcqdYBhPMYvAC7g7saqE2tuU45pXOoFoUV3okPAHu9fknopsyr0t6M1XgGxIxS0JPYM0+SOwqZJ/dMKekSIK4ERA+41/iJGQp0FB81sdPd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MK4OtRqt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a7EWIuQJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MK4OtRqt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a7EWIuQJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7DA2C211C7;
	Thu, 16 Jan 2025 10:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737021980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3kEdGUUt3mUFMDsvAmnmoM/6NwvZPX9RyXclX3IF7Tk=;
	b=MK4OtRqtRx3QneHmrVf60GXFWHNz5LOnFSYkbJLWqi5ty3Qg5sRE5bzYWoEBG36zreoXVl
	S2LJl+1OCCI/QLhhX1YSwHPoREAu4b/K8x2oPylYwSuBWGMQtLTeQSWsyjT545/wJzbClg
	8uXwtOAXTlXoIXSV4qmDpxZ70On0knQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737021980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3kEdGUUt3mUFMDsvAmnmoM/6NwvZPX9RyXclX3IF7Tk=;
	b=a7EWIuQJS12/MogplZHAW00dFUdFG8jzuSJTerDWLuu4TpaHNJR4PoZuZXIIIjdegsjVQw
	JtESwAjnKjM8DWDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737021980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3kEdGUUt3mUFMDsvAmnmoM/6NwvZPX9RyXclX3IF7Tk=;
	b=MK4OtRqtRx3QneHmrVf60GXFWHNz5LOnFSYkbJLWqi5ty3Qg5sRE5bzYWoEBG36zreoXVl
	S2LJl+1OCCI/QLhhX1YSwHPoREAu4b/K8x2oPylYwSuBWGMQtLTeQSWsyjT545/wJzbClg
	8uXwtOAXTlXoIXSV4qmDpxZ70On0knQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737021980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3kEdGUUt3mUFMDsvAmnmoM/6NwvZPX9RyXclX3IF7Tk=;
	b=a7EWIuQJS12/MogplZHAW00dFUdFG8jzuSJTerDWLuu4TpaHNJR4PoZuZXIIIjdegsjVQw
	JtESwAjnKjM8DWDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7039D13A57;
	Thu, 16 Jan 2025 10:06:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vHRZGxzaiGcmIAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 16 Jan 2025 10:06:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2F793A08E0; Thu, 16 Jan 2025 11:06:20 +0100 (CET)
Date: Thu, 16 Jan 2025 11:06:20 +0100
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, agruenba@redhat.com, amir73il@gmail.com, 
	brauner@kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	hubcap@omnibond.com, jack@suse.cz, krisman@kernel.org, linux-nfs@vger.kernel.org, 
	miklos@szeredi.hu, torvalds@linux-foundation.org
Subject: Re: [PATCH v2 04/20] dissolve external_name.u into separate members
Message-ID: <p2e3b3ygbr6p2xxy62opacwspphbxaufdsaoyhmpzfeuqw7gzd@22tpnvoudooc>
References: <20250116052103.GF1977892@ZenIV>
 <20250116052317.485356-1-viro@zeniv.linux.org.uk>
 <20250116052317.485356-4-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116052317.485356-4-viro@zeniv.linux.org.uk>
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
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,gmail.com,kernel.org,omnibond.com,suse.cz,szeredi.hu,linux-foundation.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 16-01-25 05:23:01, Al Viro wrote:
> kept separate from the previous commit to keep the noise separate
> from actual changes...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dcache.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index f387dc97df86..6f36d3e8c739 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -296,10 +296,8 @@ static inline int dentry_cmp(const struct dentry *dentry, const unsigned char *c
>  }
>  
>  struct external_name {
> -	struct {
> -		atomic_t count;		// ->count and ->head can't be combined
> -		struct rcu_head head;	// see take_dentry_name_snapshot()
> -	} u;
> +	struct rcu_head head;	// ->head and ->count can't be combined
> +	atomic_t count;		// see take_dentry_name_snapshot()
>  	unsigned char name[];
>  };
>  
> @@ -344,7 +342,7 @@ void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry
>  		struct external_name *p;
>  		p = container_of(s, struct external_name, name[0]);
>  		// get a valid reference
> -		if (unlikely(!atomic_inc_not_zero(&p->u.count)))
> +		if (unlikely(!atomic_inc_not_zero(&p->count)))
>  			goto retry;
>  		name->name.name = s;
>  	}
> @@ -361,8 +359,8 @@ void release_dentry_name_snapshot(struct name_snapshot *name)
>  	if (unlikely(name->name.name != name->inline_name.string)) {
>  		struct external_name *p;
>  		p = container_of(name->name.name, struct external_name, name[0]);
> -		if (unlikely(atomic_dec_and_test(&p->u.count)))
> -			kfree_rcu(p, u.head);
> +		if (unlikely(atomic_dec_and_test(&p->count)))
> +			kfree_rcu(p, head);
>  	}
>  }
>  EXPORT_SYMBOL(release_dentry_name_snapshot);
> @@ -400,7 +398,7 @@ static void dentry_free(struct dentry *dentry)
>  	WARN_ON(!hlist_unhashed(&dentry->d_u.d_alias));
>  	if (unlikely(dname_external(dentry))) {
>  		struct external_name *p = external_name(dentry);
> -		if (likely(atomic_dec_and_test(&p->u.count))) {
> +		if (likely(atomic_dec_and_test(&p->count))) {
>  			call_rcu(&dentry->d_u.d_rcu, __d_free_external);
>  			return;
>  		}
> @@ -1681,7 +1679,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
>  			kmem_cache_free(dentry_cache, dentry); 
>  			return NULL;
>  		}
> -		atomic_set(&p->u.count, 1);
> +		atomic_set(&p->count, 1);
>  		dname = p->name;
>  	} else  {
>  		dname = dentry->d_shortname.string;
> @@ -2774,15 +2772,15 @@ static void copy_name(struct dentry *dentry, struct dentry *target)
>  	if (unlikely(dname_external(dentry)))
>  		old_name = external_name(dentry);
>  	if (unlikely(dname_external(target))) {
> -		atomic_inc(&external_name(target)->u.count);
> +		atomic_inc(&external_name(target)->count);
>  		dentry->d_name = target->d_name;
>  	} else {
>  		dentry->d_shortname = target->d_shortname;
>  		dentry->d_name.name = dentry->d_shortname.string;
>  		dentry->d_name.hash_len = target->d_name.hash_len;
>  	}
> -	if (old_name && likely(atomic_dec_and_test(&old_name->u.count)))
> -		kfree_rcu(old_name, u.head);
> +	if (old_name && likely(atomic_dec_and_test(&old_name->count)))
> +		kfree_rcu(old_name, head);
>  }
>  
>  /*
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

