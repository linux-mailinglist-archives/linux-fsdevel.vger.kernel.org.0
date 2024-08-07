Return-Path: <linux-fsdevel+bounces-25301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F82894A878
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 15:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE4A7B2329D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 13:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DBA1EA0B0;
	Wed,  7 Aug 2024 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L8WTwaQY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="26SUTiGQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pduOcCl/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xn+y4WG6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B172213A3F0;
	Wed,  7 Aug 2024 13:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723036858; cv=none; b=mDtX2BFJ2CI2MEVQSi3rjwWZ8O2s9Z70nwkngDMOsCENz5dN9opII839Xq761oqLBvFQdQwuwvRWiRn/mERQX5ts/QFG4fmy3/hQjcdW+0SSVVj8sO7z9WD78DF29U5vzE04ane/qpmEKdRmIsnswRj8729602inYWg0C5fUd7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723036858; c=relaxed/simple;
	bh=JnwX2AVonipUuZlR4Cdl1XgrlCBGqZew1tMD7T1N8+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RP6Kl886mRYP18MCe+ofLoEanvnCeuWFYw1KIVO/c8KVTZBWks3bV9OwneyW6pNYnVnxIo20uj1Eb7kCJPmsSJghONnjkk4cabwKJEnBowhm6NaB/ZVC+p5cYABy8LHlWjZ8Ly62Rg7lMlPfWck0Lnvkj05a3qktsKfYE3Kz1kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L8WTwaQY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=26SUTiGQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pduOcCl/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xn+y4WG6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DD10E21AC9;
	Wed,  7 Aug 2024 13:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723036854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oi7JmAOIAm400fxQ5TjTYdvdJqzdVHJz7YRcmveWM48=;
	b=L8WTwaQYKuoKTBqkDOFBDhIpfiZduhB652NI9ygMOeG3Ot2Xreo8wTb9zkMakY9U+LLCxd
	C0baaQbjwynC5kbSjxsmEIUSca2FkWqhpQqH0uolzZ9D4u8nor8t6dxOtkY3i2JMYlhsSE
	8gw662PXCHPlijb5my2MSqfGsnaSlns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723036854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oi7JmAOIAm400fxQ5TjTYdvdJqzdVHJz7YRcmveWM48=;
	b=26SUTiGQZN7sg1gSt8w4eVYUXVOp4drLmHP8zcURuOOTg4HmyWCETqEIts4KVCm3cVtgXH
	zFu7FxnPWJddxRCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="pduOcCl/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Xn+y4WG6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723036853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oi7JmAOIAm400fxQ5TjTYdvdJqzdVHJz7YRcmveWM48=;
	b=pduOcCl/5YXJMxyfLl0gjquvmX+cn2WG+t6zDs18FHPb7PU/KGauXQZ0Pah4qFft7BmxXx
	WOFo8iXAW8DmQSuG1vypFsV1fhL9MiefsSaY2p9VQlgAPBbGJkSHZa6d8HhCutgK+CCTNF
	UFrpxlyB/7JybE6Xw+mLodBEBu7crpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723036853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oi7JmAOIAm400fxQ5TjTYdvdJqzdVHJz7YRcmveWM48=;
	b=Xn+y4WG6S5glz0Ea7OxFYdtN/nLCFrW4Fw7MFzmHrPbXX7KksNoIX3y4MLYrSKio6LtFrH
	7OGxTmR1p5iUvRAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5F9513297;
	Wed,  7 Aug 2024 13:20:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SThqLLV0s2aNUgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Aug 2024 13:20:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 57C22A0762; Wed,  7 Aug 2024 15:20:53 +0200 (CEST)
Date: Wed, 7 Aug 2024 15:20:53 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andi Kleen <ak@linux.intel.com>, Mateusz Guzik <mjguzik@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fs: try an opportunistic lookup for O_CREAT opens too
Message-ID: <20240807132053.juvychehe4zfqj5w@quack3>
References: <20240807-openfast-v3-1-040d132d2559@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807-openfast-v3-1-040d132d2559@kernel.org>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,linux-foundation.org,linux.intel.com,gmail.com,toxicpanda.com,vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.01
X-Rspamd-Queue-Id: DD10E21AC9

On Wed 07-08-24 08:10:27, Jeff Layton wrote:
> Today, when opening a file we'll typically do a fast lookup, but if
> O_CREAT is set, the kernel always takes the exclusive inode lock. I
> assume this was done with the expectation that O_CREAT means that we
> always expect to do the create, but that's often not the case. Many
> programs set O_CREAT even in scenarios where the file already exists.
> 
> This patch rearranges the pathwalk-for-open code to also attempt a
> fast_lookup in certain O_CREAT cases. If a positive dentry is found, the
> inode_lock can be avoided altogether, and if auditing isn't enabled, it
> can stay in rcuwalk mode for the last step_into.
> 
> One notable exception that is hopefully temporary: if we're doing an
> rcuwalk and auditing is enabled, skip the lookup_fast. Legitimizing the
> dentry in that case is more expensive than taking the i_rwsem for now.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

I'm not very familiar with the path lookup code but the patch looks correct
to me and the win is nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Here's a revised patch that does a fast_lookup in the O_CREAT codepath
> too. The main difference here is that if a positive dentry is found and
> audit_dummy_context is true, then we keep the walk lazy for the last
> component, which avoids having to take any locks on the parent (just
> like with non-O_CREAT opens).
> 
> Mateusz wrote a will-it-scale test that does an O_CREAT open and close in
> the same directory repeatedly. Running that in 70 different processes:
> 
>     v6.10:		  754565
>     v6.10+patch:	25747851
> 
> ...which is roughly a 34x speedup. I also ran the unlink1 test in single
> process mode to try and gauge how bad the performance impact would be in
> the case where we always have to search, not find anything and do the
> create:
> 
>     v6.10:		200106
>     v6.10+patch:	199188
> 
> ~0.4% performance hit in that test. I'm not sure that's statistically
> significant, but we should keep an eye out for slowdowns in these sorts
> of workloads if we decide to take this.
> ---
> Changes in v3:
> - Check for IS_ERR in lookup_fast result
> - Future-proof open_last_lookups to handle case where lookup_fast_for_open
>   returns a positive dentry while auditing is enabled
> - Link to v2: https://lore.kernel.org/r/20240806-openfast-v2-1-42da45981811@kernel.org
> 
> Changes in v2:
> - drop the lockref patch since Mateusz is working on a better approach
> - add trailing_slashes helper function
> - add a lookup_fast_for_open helper function
> - make lookup_fast_for_open skip the lookup if auditing is enabled
> - if we find a positive dentry and auditing is disabled, don't unlazy
> - Link to v1: https://lore.kernel.org/r/20240802-openfast-v1-0-a1cff2a33063@kernel.org
> ---
>  fs/namei.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 64 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 1e05a0f3f04d..7894fafa8e71 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3518,6 +3518,49 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	return ERR_PTR(error);
>  }
>  
> +static inline bool trailing_slashes(struct nameidata *nd)
> +{
> +	return (bool)nd->last.name[nd->last.len];
> +}
> +
> +static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
> +{
> +	struct dentry *dentry;
> +
> +	if (open_flag & O_CREAT) {
> +		/* Don't bother on an O_EXCL create */
> +		if (open_flag & O_EXCL)
> +			return NULL;
> +
> +		/*
> +		 * FIXME: If auditing is enabled, then we'll have to unlazy to
> +		 * use the dentry. For now, don't do this, since it shifts
> +		 * contention from parent's i_rwsem to its d_lockref spinlock.
> +		 * Reconsider this once dentry refcounting handles heavy
> +		 * contention better.
> +		 */
> +		if ((nd->flags & LOOKUP_RCU) && !audit_dummy_context())
> +			return NULL;
> +	}
> +
> +	if (trailing_slashes(nd))
> +		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
> +
> +	dentry = lookup_fast(nd);
> +	if (IS_ERR_OR_NULL(dentry))
> +		return dentry;
> +
> +	if (open_flag & O_CREAT) {
> +		/* Discard negative dentries. Need inode_lock to do the create */
> +		if (!dentry->d_inode) {
> +			if (!(nd->flags & LOOKUP_RCU))
> +				dput(dentry);
> +			dentry = NULL;
> +		}
> +	}
> +	return dentry;
> +}
> +
>  static const char *open_last_lookups(struct nameidata *nd,
>  		   struct file *file, const struct open_flags *op)
>  {
> @@ -3535,28 +3578,39 @@ static const char *open_last_lookups(struct nameidata *nd,
>  		return handle_dots(nd, nd->last_type);
>  	}
>  
> +	/* We _can_ be in RCU mode here */
> +	dentry = lookup_fast_for_open(nd, open_flag);
> +	if (IS_ERR(dentry))
> +		return ERR_CAST(dentry);
> +
>  	if (!(open_flag & O_CREAT)) {
> -		if (nd->last.name[nd->last.len])
> -			nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
> -		/* we _can_ be in RCU mode here */
> -		dentry = lookup_fast(nd);
> -		if (IS_ERR(dentry))
> -			return ERR_CAST(dentry);
>  		if (likely(dentry))
>  			goto finish_lookup;
>  
>  		if (WARN_ON_ONCE(nd->flags & LOOKUP_RCU))
>  			return ERR_PTR(-ECHILD);
>  	} else {
> -		/* create side of things */
>  		if (nd->flags & LOOKUP_RCU) {
> -			if (!try_to_unlazy(nd))
> +			bool unlazied;
> +
> +			/* can stay in rcuwalk if not auditing */
> +			if (dentry && audit_dummy_context()) {
> +				if (trailing_slashes(nd))
> +					return ERR_PTR(-EISDIR);
> +				goto finish_lookup;
> +			}
> +			unlazied = dentry ? try_to_unlazy_next(nd, dentry) :
> +					    try_to_unlazy(nd);
> +			if (!unlazied)
>  				return ERR_PTR(-ECHILD);
>  		}
>  		audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
> -		/* trailing slashes? */
> -		if (unlikely(nd->last.name[nd->last.len]))
> +		if (trailing_slashes(nd)) {
> +			dput(dentry);
>  			return ERR_PTR(-EISDIR);
> +		}
> +		if (dentry)
> +			goto finish_lookup;
>  	}
>  
>  	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
> 
> ---
> base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
> change-id: 20240723-openfast-ac49a7b6ade2
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

