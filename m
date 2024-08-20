Return-Path: <linux-fsdevel+bounces-26402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E18958F1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 22:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A575284F84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 20:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F381BBBF0;
	Tue, 20 Aug 2024 20:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L0x1ULb8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xwM6zom+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r7I3Mecn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SGlp+5t+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF781862;
	Tue, 20 Aug 2024 20:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724185025; cv=none; b=Ac2PCMcPY9Z4zI22U9QmQG7vLJBgo3qrm5+PKg/vZ965UdEQXm2PUU25h7fjackYhtlXDzaotMgZgFlMkBrEucXyrrPhT+u2xoi5hVEg3gV4yUqDaINexSFHKD9mKMPonUn6W0Bj5qzVJQDic0epbP+QYMdgY2HgJ+LMRJzHaSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724185025; c=relaxed/simple;
	bh=OxJUUNwFru9yJDpld+I0d8zMg7aA6LbgQCI85+gNk/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=St2ALV55bh9OgOIkC7HK3NWvVjptfZ8jIaqfGDbyIckktmBYFFYetVxv3M9Woi+sWC1i49hWrWp5bDk6baU/xnegasp94Igh/ZjX60V659N203i2djN+pAl8v7xCkMlcjgUx04avi5R6ZffsqqKMGVuwS4OQqZur06ualtRTKgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L0x1ULb8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xwM6zom+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r7I3Mecn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SGlp+5t+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DB907225AD;
	Tue, 20 Aug 2024 20:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724185021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pvUdTrpsiCOOSJ6uovsNbdjF3G6E2dKscI4/V4e1O6M=;
	b=L0x1ULb8woeQUD0Y1V1qpY1dQFroXrFWztz7bW6zw62wtirM1Q60vvGOElV5lRlTh8lFNs
	/RkarrvxqrGJbqEQ4BmxLLIOAMeEftt0EaTcI2Q/mifyI8MSr2LjAWQCqGCUq47/pCUbPI
	Rtu2xlgRkLOy040DNO5jsxfXOkP5i8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724185021;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pvUdTrpsiCOOSJ6uovsNbdjF3G6E2dKscI4/V4e1O6M=;
	b=xwM6zom+6ET6iqPFmVsZk6czKy+9bdvz3x++HMwfvaJFsjJJBtCIHO3jgaXVhOq9dyC2MS
	JxNqRf1VikQ8ESCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724185019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pvUdTrpsiCOOSJ6uovsNbdjF3G6E2dKscI4/V4e1O6M=;
	b=r7I3MecnjpB0o0BGv+7zzx2koEX87wrUDbg4EsDp4cjtdfH+UgfctT2d9En/KWGeuYvoo9
	xK6oSB5IHIpRhcG/yUhME1yuZVE3KHLYrwvgjyKTO6Xkp1b+Nzc2Rt96cgFb4g0Ik5LO78
	rbac/SNSBF5Y/hf4Y9lWe1gU8sikd38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724185019;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pvUdTrpsiCOOSJ6uovsNbdjF3G6E2dKscI4/V4e1O6M=;
	b=SGlp+5t+UNVYvji81egQNiYXDqR/32rHe2J0UkaFI/VqftMiuYtXYXum0VdwahMyMFJyR8
	Fg8Ybor1rl+sP6DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B6B913770;
	Tue, 20 Aug 2024 20:16:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hZwdILv5xGaKBgAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 20 Aug 2024 20:16:59 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: viro@zeniv.linux.org.uk,  brauner@kernel.org,  tytso@mit.edu,
  linux-ext4@vger.kernel.org,  jack@suse.cz,  adilger.kernel@dilger.ca,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  kernel@collabora.com,  shreeya.patel@collabora.com
Subject: Re: [PATCH 1/2] fs/dcache: introduce d_alloc_parallel_check_existing
In-Reply-To: <20240705062621.630604-2-eugen.hristev@collabora.com> (Eugen
	Hristev's message of "Fri, 5 Jul 2024 09:26:20 +0300")
References: <20240705062621.630604-1-eugen.hristev@collabora.com>
	<20240705062621.630604-2-eugen.hristev@collabora.com>
Date: Tue, 20 Aug 2024 16:16:58 -0400
Message-ID: <87zfp7rltx.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,mailhost.krisman.be:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Eugen Hristev <eugen.hristev@collabora.com> writes:

> d_alloc_parallel currently looks for entries that match the name being
> added and return them if found.
> However if d_alloc_parallel is being called during the process of adding
> a new entry (that becomes in_lookup), the same entry is found by
> d_alloc_parallel in the in_lookup_hash and d_alloc_parallel will wait
> forever for it to stop being in lookup.
> To avoid this, it makes sense to check for an entry being currently
> added (e.g. by d_add_ci from a lookup func, like xfs is doing) and if this
> exact match is found, return the entry.
> This way, to add a new entry , as xfs is doing, is the following flow:
> _lookup_slow -> d_alloc_parallel -> entry is being created -> xfs_lookup ->
> d_add_ci -> d_alloc_parallel_check_existing(entry created before) ->
> d_splice_alias.

Hi Eugen,

I have a hard time understanding what xfs has anything to do with this.
xfs already users d_add_ci without problems.  The issue is that
ext4/f2fs have case-insensitive d_compare/d_hash functions, so they will
find the dentry-under-lookup itself here. Xfs doesn't have that problem
at all because it doesn't try to match case-inexact names in the dcache.

> The initial entry stops being in_lookup after d_splice_alias finishes, and
> it's returned to d_add_ci by d_alloc_parallel_check_existing.
> Without d_alloc_parallel_check_existing, d_alloc_parallel would be called
> instead and wait forever for the entry to stop being in lookup, as the
> iteration through the in_lookup_hash matches the entry.
> Currently XFS does not hang because it creates another entry in the second
> call of d_alloc_parallel if the name differs by case as the hashing and
> comparison functions used by XFS are not case insensitive.
>
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  fs/dcache.c            | 29 +++++++++++++++++++++++------
>  include/linux/dcache.h |  4 ++++
>  2 files changed, 27 insertions(+), 6 deletions(-)
>
> diff --git a/fs/dcache.c b/fs/dcache.c
> index a0a944fd3a1c..459a3d8b8bdb 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2049,8 +2049,9 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
>  		return found;
>  	}
>  	if (d_in_lookup(dentry)) {
> -		found = d_alloc_parallel(dentry->d_parent, name,
> -					dentry->d_wait);
> +		found = d_alloc_parallel_check_existing(dentry,
> +							dentry->d_parent, name,
> +							dentry->d_wait);
>  		if (IS_ERR(found) || !d_in_lookup(found)) {
>  			iput(inode);
>  			return found;
> @@ -2452,9 +2453,10 @@ static void d_wait_lookup(struct dentry *dentry)
>  	}
>  }
>  
> -struct dentry *d_alloc_parallel(struct dentry *parent,
> -				const struct qstr *name,
> -				wait_queue_head_t *wq)
> +struct dentry *d_alloc_parallel_check_existing(struct dentry *d_check,
> +					       struct dentry *parent,
> +					       const struct qstr *name,
> +					       wait_queue_head_t *wq)
>  {
>  	unsigned int hash = name->hash;
>  	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
> @@ -2523,6 +2525,14 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
>  		}
>  
>  		rcu_read_unlock();
> +
> +		/* if the entry we found is the same as the original we
> +		 * are checking against, then return it
> +		 */
> +		if (d_check == dentry) {
> +			dput(new);
> +			return dentry;
> +		}

The point of the patchset is to install a dentry with the disk-name in
the dcache if the name isn't an exact match to the name of the
dentry-under-lookup.  But, since you return the same
dentry-under-lookup, d_add_ci will just splice that dentry into the
cache - which is exactly the same as just doing d_splice_alias(dentry) at
the end of ->d_lookup() like we currently do, no?  Shreeya's idea in
that original patchset was to return a new dentry with the new name.

>  		/*
>  		 * somebody is likely to be still doing lookup for it;
>  		 * wait for them to finish
> @@ -2560,8 +2570,15 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
>  	dput(dentry);
>  	goto retry;
>  }
> -EXPORT_SYMBOL(d_alloc_parallel);
> +EXPORT_SYMBOL(d_alloc_parallel_check_existing);
>  
> +struct dentry *d_alloc_parallel(struct dentry *parent,
> +				const struct qstr *name,
> +				wait_queue_head_t *wq)
> +{
> +	return d_alloc_parallel_check_existing(NULL, parent, name, wq);
> +}
> +EXPORT_SYMBOL(d_alloc_parallel);
>  /*
>   * - Unhash the dentry
>   * - Retrieve and clear the waitqueue head in dentry
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index bf53e3894aae..6eb21a518cb0 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -232,6 +232,10 @@ extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
>  extern struct dentry * d_alloc_anon(struct super_block *);
>  extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *,
>  					wait_queue_head_t *);
> +extern struct dentry * d_alloc_parallel_check_existing(struct dentry *,
> +						       struct dentry *,
> +						       const struct qstr *,
> +						       wait_queue_head_t *);
>  extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
>  extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *);
>  extern bool d_same_name(const struct dentry *dentry, const struct dentry *parent,

-- 
Gabriel Krisman Bertazi

