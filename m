Return-Path: <linux-fsdevel+bounces-21115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6328FF2B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 18:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DABA1F232E2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 16:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706FA198A07;
	Thu,  6 Jun 2024 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lPkFH7X0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jiWqPDmL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lPkFH7X0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jiWqPDmL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F523197A8A
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2024 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692054; cv=none; b=n1233vGAyIWqj9dRBCmpmItWbZyod1ri1siEDibM90BDKEK9MnsQu0jJUQpxYA6unjqcUltdaVyWOOylhl3QGxNdPKhGgcidZEEYVSeuwx7XokvKV0rpFY/jXXxrdmLH1T8j6VV2k1pRBOo1mWirbvakHk8nc8/bwR4q/88T2TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692054; c=relaxed/simple;
	bh=8TBkpd8pPm/5pyZEpVbloCesd0UUY9nSuEQflbfNNkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVqpgDUB07yTGDpOoK2OEL2N0AkUUSuiy3x3Brn78QFFRmuiB6ItUcegz2WeKdkGdhsOAPuNhC+W52MhmRgSJDanVwT6urCgvHci0IdIWqvwmQ40TGVPRsElLxGdxhSAkDDV28/6WqCnNyBax3Cfa3bdUwx/crKqawsIa0WzysM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lPkFH7X0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jiWqPDmL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lPkFH7X0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jiWqPDmL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 03CB321B04;
	Thu,  6 Jun 2024 16:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717692051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FhkaLIsm3OMy5B1emSJtF/sEJqoxW+pm2SUVQ0HVT5o=;
	b=lPkFH7X0HzEsUi1I7uJhl5oU8S4s/VWWWCsz6zf4Hom7zv3iALCtkouafyQzQIA+1NrA07
	FT1UP0dZWl16NHbkXpQF90Bze1J8OYCeI5r8Fp0i2Sz8eDm0PtCA198f56qtMOMqZRSune
	Xs7AgiCxBNJcYgvHS8nPv2x1d+19OV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717692051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FhkaLIsm3OMy5B1emSJtF/sEJqoxW+pm2SUVQ0HVT5o=;
	b=jiWqPDmLojaUGwttBQ/BOai1tAEAm5X8SZIOB9EsDjxzYw0kUoM/PLrUsPaIQu9RZ5sSXm
	4d6fH4Wqj0a3SfCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717692051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FhkaLIsm3OMy5B1emSJtF/sEJqoxW+pm2SUVQ0HVT5o=;
	b=lPkFH7X0HzEsUi1I7uJhl5oU8S4s/VWWWCsz6zf4Hom7zv3iALCtkouafyQzQIA+1NrA07
	FT1UP0dZWl16NHbkXpQF90Bze1J8OYCeI5r8Fp0i2Sz8eDm0PtCA198f56qtMOMqZRSune
	Xs7AgiCxBNJcYgvHS8nPv2x1d+19OV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717692051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FhkaLIsm3OMy5B1emSJtF/sEJqoxW+pm2SUVQ0HVT5o=;
	b=jiWqPDmLojaUGwttBQ/BOai1tAEAm5X8SZIOB9EsDjxzYw0kUoM/PLrUsPaIQu9RZ5sSXm
	4d6fH4Wqj0a3SfCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E819513A1E;
	Thu,  6 Jun 2024 16:40:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f2VYOJLmYWZpCAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 06 Jun 2024 16:40:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7CA4CA088A; Thu,  6 Jun 2024 18:40:46 +0200 (CEST)
Date: Thu, 6 Jun 2024 18:40:46 +0200
From: Jan Kara <jack@suse.cz>
To: Jemmy <jemmywong512@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, jemmy512@icloud.com,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3] Improve readability of copy_tree
Message-ID: <20240606164046.nzsry5uoukukqoqx@quack3>
References: <20240604134347.9357-1-jemmywong512@gmail.com>
 <20240606090254.36274-1-jemmywong512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606090254.36274-1-jemmywong512@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,icloud.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,icloud.com,vger.kernel.org,zeniv.linux.org.uk];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 06-06-24 17:02:54, Jemmy wrote:
> by employing `copy mount tree from src to dst` concept.
> This involves renaming the opaque variables (e.g., p, q, r, s)
> to be more descriptive, aiming to make the code easier to understand.
> 
> Changes:
> mnt     -> src_root (root of the tree to copy)
> r       -> src_child (direct child of the root being cloning)

I'd call this src_root_child to distinguish it from a child of
"src_parent". Otherwise these names work for me.

> p       -> src_parent (parent of src_mnt)
> s       -> src_mnt (current mount being copying)
> parent  -> dst_parent (parent of dst_child)
> q       -> dst_mnt (freshly cloned mount)
> 
> Signed-off-by: Jemmy <jemmywong512@gmail.com>

								Honza

> ---
>  fs/namespace.c | 59 ++++++++++++++++++++++++++------------------------
>  1 file changed, 31 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 5a51315c6678..0dd43633607b 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1966,69 +1966,72 @@ static bool mnt_ns_loop(struct dentry *dentry)
>  	return current->nsproxy->mnt_ns->seq >= mnt_ns->seq;
>  }
>  
> -struct mount *copy_tree(struct mount *mnt, struct dentry *dentry,
> +struct mount *copy_tree(struct mount *src_root, struct dentry *dentry,
>  					int flag)
>  {
> -	struct mount *res, *p, *q, *r, *parent;
> +	struct mount *res, *src_parent, *src_child, *src_mnt,
> +		*dst_parent, *dst_mnt;
>  
> -	if (!(flag & CL_COPY_UNBINDABLE) && IS_MNT_UNBINDABLE(mnt))
> +	if (!(flag & CL_COPY_UNBINDABLE) && IS_MNT_UNBINDABLE(src_root))
>  		return ERR_PTR(-EINVAL);
>  
>  	if (!(flag & CL_COPY_MNT_NS_FILE) && is_mnt_ns_file(dentry))
>  		return ERR_PTR(-EINVAL);
>  
> -	res = q = clone_mnt(mnt, dentry, flag);
> -	if (IS_ERR(q))
> -		return q;
> +	res = dst_mnt = clone_mnt(src_root, dentry, flag);
> +	if (IS_ERR(dst_mnt))
> +		return dst_mnt;
>  
> -	q->mnt_mountpoint = mnt->mnt_mountpoint;
> +	src_parent = src_root;
> +	dst_mnt->mnt_mountpoint = src_root->mnt_mountpoint;
>  
> -	p = mnt;
> -	list_for_each_entry(r, &mnt->mnt_mounts, mnt_child) {
> -		struct mount *s;
> -		if (!is_subdir(r->mnt_mountpoint, dentry))
> +	list_for_each_entry(src_child, &src_root->mnt_mounts, mnt_child) {
> +		if (!is_subdir(src_child->mnt_mountpoint, dentry))
>  			continue;
>  
> -		for (s = r; s; s = next_mnt(s, r)) {
> +		for (src_mnt = src_child; src_mnt;
> +			src_mnt = next_mnt(src_mnt, src_child)) {
>  			if (!(flag & CL_COPY_UNBINDABLE) &&
> -			    IS_MNT_UNBINDABLE(s)) {
> -				if (s->mnt.mnt_flags & MNT_LOCKED) {
> +			    IS_MNT_UNBINDABLE(src_mnt)) {
> +				if (src_mnt->mnt.mnt_flags & MNT_LOCKED) {
>  					/* Both unbindable and locked. */
> -					q = ERR_PTR(-EPERM);
> +					dst_mnt = ERR_PTR(-EPERM);
>  					goto out;
>  				} else {
> -					s = skip_mnt_tree(s);
> +					src_mnt = skip_mnt_tree(src_mnt);
>  					continue;
>  				}
>  			}
>  			if (!(flag & CL_COPY_MNT_NS_FILE) &&
> -			    is_mnt_ns_file(s->mnt.mnt_root)) {
> -				s = skip_mnt_tree(s);
> +			    is_mnt_ns_file(src_mnt->mnt.mnt_root)) {
> +				src_mnt = skip_mnt_tree(src_mnt);
>  				continue;
>  			}
> -			while (p != s->mnt_parent) {
> -				p = p->mnt_parent;
> -				q = q->mnt_parent;
> +			while (src_parent != src_mnt->mnt_parent) {
> +				src_parent = src_parent->mnt_parent;
> +				dst_mnt = dst_mnt->mnt_parent;
>  			}
> -			p = s;
> -			parent = q;
> -			q = clone_mnt(p, p->mnt.mnt_root, flag);
> -			if (IS_ERR(q))
> +
> +			src_parent = src_mnt;
> +			dst_parent = dst_mnt;
> +			dst_mnt = clone_mnt(src_mnt, src_mnt->mnt.mnt_root, flag);
> +			if (IS_ERR(dst_mnt))
>  				goto out;
>  			lock_mount_hash();
> -			list_add_tail(&q->mnt_list, &res->mnt_list);
> -			attach_mnt(q, parent, p->mnt_mp, false);
> +			list_add_tail(&dst_mnt->mnt_list, &res->mnt_list);
> +			attach_mnt(dst_mnt, dst_parent, src_parent->mnt_mp, false);
>  			unlock_mount_hash();
>  		}
>  	}
>  	return res;
> +
>  out:
>  	if (res) {
>  		lock_mount_hash();
>  		umount_tree(res, UMOUNT_SYNC);
>  		unlock_mount_hash();
>  	}
> -	return q;
> +	return dst_mnt;
>  }
>  
>  /* Caller should check returned pointer for errors */
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

