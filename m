Return-Path: <linux-fsdevel+bounces-21058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F68A8FD1CD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 17:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976C31C21320
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 15:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31581481D3;
	Wed,  5 Jun 2024 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2taKfjw5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="suAoY8gm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oCZ6wGr9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8yoxrJg6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8100119D891
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jun 2024 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601883; cv=none; b=JqJJoLo6+MBXzXhNPzKkxkTbEuvNd1hHvM4JW9Xuw/HmzQ4hrUQo3IhVBYuC0n8OVacaaNC26B/r7RHh4pA51ovIfndz5/pOR93GBwfSz7GjmEYUBvWX1fRj3Apd8Ee6STCYStuWJr16gJILPeABMfgxfSTC07CSzYpEfoMp9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601883; c=relaxed/simple;
	bh=6+a0HduqCUR7kANz00Jf/9Dmtarv140XVMFBj5qMRoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tauSXIYwDCBtwPmB+V8WMLUB/U2/9KrJlmgV+CsJo8waRR+T7SOuk3TdD1SQewq5kKGjqWdiVEU8U+/AbDfFclTmif59ZsRmcP3jlYDGHKDzSN1ozfacRjsM/4S5WFurGTDZ4oEZRQAZC3CwUTDwbSsvspycT/EbYEC+thcuR/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2taKfjw5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=suAoY8gm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oCZ6wGr9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8yoxrJg6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 57DEF21A86;
	Wed,  5 Jun 2024 15:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717601879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bX6gDXQML70p3N5o3TwGJkHa2c3BXgreA1dmoIS+C0Y=;
	b=2taKfjw5tFMiSaXN7VlyJAP2mV8E2jEPpYhtlqalszbpMHix+ffyuMuMNGNaVzG86grzVU
	euEHFm6Rw+Yvb+ZoyME8X9DAZ6E7OYFyiHR+flpzDg7OE0o657VLlePhhAGw/d8d8gBGxs
	ya7iiyEW+J2H4ei7Ru1kCXguI2DM+IY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717601879;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bX6gDXQML70p3N5o3TwGJkHa2c3BXgreA1dmoIS+C0Y=;
	b=suAoY8gmfyK++O+obrlZ+huxjaM2yl2aTsLcc8J+SR5vjf46/L9NM9Y/vKp61/GXfLP5cJ
	/fDkg1uVvDAjvoDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717601878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bX6gDXQML70p3N5o3TwGJkHa2c3BXgreA1dmoIS+C0Y=;
	b=oCZ6wGr9jKD5uQeFUU7+j4wv+vV2e1OIfxxxejpAY+5cKKG017nZrbDC/wwmpEjK/7QJZk
	bMvu/Ci0JE41tSbf73pMYTNJjBOthhhka/sBqo+lEXNDXgLcYeV4kvzuxBt4+7OaDBf3/G
	zannVeE3eO/Xk+Bn/TCBsCEYk/6tTww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717601878;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bX6gDXQML70p3N5o3TwGJkHa2c3BXgreA1dmoIS+C0Y=;
	b=8yoxrJg6iI0F4zYgSRbm639m6G8vH5FHEzPJeKlobV9sWeDc57crfBqAH9//VGOMeffuSC
	yMa5Uq3FaJ44vUDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4984D13A24;
	Wed,  5 Jun 2024 15:37:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NkzqEVaGYGaSSgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Jun 2024 15:37:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C3911A086C; Wed,  5 Jun 2024 17:37:57 +0200 (CEST)
Date: Wed, 5 Jun 2024 17:37:57 +0200
From: Jan Kara <jack@suse.cz>
To: Jemmy <jemmywong512@gmail.com>
Cc: longman@redhat.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org, jemmy512@icloud.com
Subject: Re: [PATCH] Improving readability of copy_tree
Message-ID: <20240605153757.acrxforzws5d5rby@quack3>
References: <20240604134347.9357-1-jemmywong512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604134347.9357-1-jemmywong512@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,icloud.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,icloud.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]


Hello!

On Tue 04-06-24 21:43:47, Jemmy wrote:
> I'm new to Linux kernel development
> and excited to make my first contribution.
> While working with the copy_tree function,
> I noticed some unclear variable names e.g., p, q, r.
> I've updated them to be more descriptive,
> aiming to make the code easier to understand.
> 
> Changes:
> 
> p       -> o_parent, old parent
> q       -> n_mnt, new mount
> r       -> o_mnt, old child
> s       -> o_child, old child
> parent  -> n_parent, new parent
> 
> Thanks for the opportunity to be part of this community!

So I agree more descriptive names would help readability of this code. But
I'd pick different names which IMHO better capture the purpose.

mnt -> root (root of the tree to copy)
r -> root_child (direct child of the root we are cloning)
s -> cur_mnt (current mount we are copying)
p -> cur_parent (parent of cur_mnt)
q -> cloned_mnt (freshly cloned mount)
parent -> cloned_parent

								Honza

> Signed-off-by: Jemmy <jemmywong512@gmail.com>
> ---
>  fs/namespace.c | 51 +++++++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 5a51315c6678..b1cf95ddfb87 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1969,7 +1969,7 @@ static bool mnt_ns_loop(struct dentry *dentry)
>  struct mount *copy_tree(struct mount *mnt, struct dentry *dentry,
>  					int flag)
>  {
> -	struct mount *res, *p, *q, *r, *parent;
> +	struct mount *res, *o_parent, *o_child, *o_mnt, *n_parent, *n_mnt;
>  
>  	if (!(flag & CL_COPY_UNBINDABLE) && IS_MNT_UNBINDABLE(mnt))
>  		return ERR_PTR(-EINVAL);
> @@ -1977,47 +1977,46 @@ struct mount *copy_tree(struct mount *mnt, struct dentry *dentry,
>  	if (!(flag & CL_COPY_MNT_NS_FILE) && is_mnt_ns_file(dentry))
>  		return ERR_PTR(-EINVAL);
>  
> -	res = q = clone_mnt(mnt, dentry, flag);
> -	if (IS_ERR(q))
> -		return q;
> +	res = n_mnt = clone_mnt(mnt, dentry, flag);
> +	if (IS_ERR(n_mnt))
> +		return n_mnt;
>  
> -	q->mnt_mountpoint = mnt->mnt_mountpoint;
> +	n_mnt->mnt_mountpoint = mnt->mnt_mountpoint;
>  
> -	p = mnt;
> -	list_for_each_entry(r, &mnt->mnt_mounts, mnt_child) {
> -		struct mount *s;
> -		if (!is_subdir(r->mnt_mountpoint, dentry))
> +	o_parent = mnt;
> +	list_for_each_entry(o_mnt, &mnt->mnt_mounts, mnt_child) {
> +		if (!is_subdir(o_mnt->mnt_mountpoint, dentry))
>  			continue;
>  
> -		for (s = r; s; s = next_mnt(s, r)) {
> +		for (o_child = o_mnt; o_child; o_child = next_mnt(o_child, o_mnt)) {
>  			if (!(flag & CL_COPY_UNBINDABLE) &&
> -			    IS_MNT_UNBINDABLE(s)) {
> -				if (s->mnt.mnt_flags & MNT_LOCKED) {
> +			    IS_MNT_UNBINDABLE(o_child)) {
> +				if (o_child->mnt.mnt_flags & MNT_LOCKED) {
>  					/* Both unbindable and locked. */
> -					q = ERR_PTR(-EPERM);
> +					n_mnt = ERR_PTR(-EPERM);
>  					goto out;
>  				} else {
> -					s = skip_mnt_tree(s);
> +					o_child = skip_mnt_tree(o_child);
>  					continue;
>  				}
>  			}
>  			if (!(flag & CL_COPY_MNT_NS_FILE) &&
> -			    is_mnt_ns_file(s->mnt.mnt_root)) {
> -				s = skip_mnt_tree(s);
> +			    is_mnt_ns_file(o_child->mnt.mnt_root)) {
> +				o_child = skip_mnt_tree(o_child);
>  				continue;
>  			}
> -			while (p != s->mnt_parent) {
> -				p = p->mnt_parent;
> -				q = q->mnt_parent;
> +			while (o_parent != o_child->mnt_parent) {
> +				o_parent = o_parent->mnt_parent;
> +				n_mnt = n_mnt->mnt_parent;
>  			}
> -			p = s;
> -			parent = q;
> -			q = clone_mnt(p, p->mnt.mnt_root, flag);
> -			if (IS_ERR(q))
> +			o_parent = o_child;
> +			n_parent = n_mnt;
> +			n_mnt = clone_mnt(o_parent, o_parent->mnt.mnt_root, flag);
> +			if (IS_ERR(n_mnt))
>  				goto out;
>  			lock_mount_hash();
> -			list_add_tail(&q->mnt_list, &res->mnt_list);
> -			attach_mnt(q, parent, p->mnt_mp, false);
> +			list_add_tail(&n_mnt->mnt_list, &res->mnt_list);
> +			attach_mnt(n_mnt, n_parent, o_parent->mnt_mp, false);
>  			unlock_mount_hash();
>  		}
>  	}
> @@ -2028,7 +2027,7 @@ struct mount *copy_tree(struct mount *mnt, struct dentry *dentry,
>  		umount_tree(res, UMOUNT_SYNC);
>  		unlock_mount_hash();
>  	}
> -	return q;
> +	return n_mnt;
>  }
>  
>  /* Caller should check returned pointer for errors */
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

