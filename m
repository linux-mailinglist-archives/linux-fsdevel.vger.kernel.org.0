Return-Path: <linux-fsdevel+bounces-37137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E224B9EE40B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 11:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B919281C11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 10:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EA2211299;
	Thu, 12 Dec 2024 10:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QT5hy2eT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R0LOOB0s";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QT5hy2eT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R0LOOB0s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2BD18B467;
	Thu, 12 Dec 2024 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999091; cv=none; b=UcwgH8HBlwmQRwKNNOy/NXUEh/AXg4c3XOOT3NwWjq6lfd19R0x9AeNsSAxHN7ddMtSGp1g2YYxXZ9XERkq974TmDcUDcmCKWGREXqXx2t0KH2u275cOkHnvvxFHeb7ePko6NPYknwfUtYL5Kn+Sw/hO+Q5B30J4W7mdN3NNP+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999091; c=relaxed/simple;
	bh=elSn5EMKBSJAe1t5atIhWgNvGF8K+SoHvOCXEqaepOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4rYGGhvwrgDmaxFTK11kYlubTLlxhljsHXfqXKnGkCfr4zfBFPxfBihUsyScWU4xiidpVE237zVzlvpdyChnN2h5VVkx9FYl9Ptv7PRR4/WpByyKmJJee4D+X6mYaZy/MAOIYD7wJCjrpX7SQO4U73slffAPCdfAOVYqRlA7Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QT5hy2eT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R0LOOB0s; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QT5hy2eT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R0LOOB0s; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 997F61F445;
	Thu, 12 Dec 2024 10:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733999087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JSUUxzG9opR3Xi0ZHSRkRiPyIbSVnqpTCvgStZMvOmg=;
	b=QT5hy2eTFO0raA091ld/V4Xtv5Xize9dcNyYNy3kMeXhbsHswPFHLQfX/J8+FS1IWRVAK9
	nDQlkW9APRuqOa6mMnJjEZ79VBuKqKgz4mKvvxAAmgDG8XIlWWHpXfIgd4rQSjI7p8sgkF
	Ld848Owpi1CJJHLUSNRCwZo22w2eNpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733999087;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JSUUxzG9opR3Xi0ZHSRkRiPyIbSVnqpTCvgStZMvOmg=;
	b=R0LOOB0skr8gVNQv2sbsKWpwVO8Vt8TWroYwZiNOGiOUvdC3xvM9MCJs/ZKMFthK9PsyS8
	EL7fG7bXbE781HBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QT5hy2eT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=R0LOOB0s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733999087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JSUUxzG9opR3Xi0ZHSRkRiPyIbSVnqpTCvgStZMvOmg=;
	b=QT5hy2eTFO0raA091ld/V4Xtv5Xize9dcNyYNy3kMeXhbsHswPFHLQfX/J8+FS1IWRVAK9
	nDQlkW9APRuqOa6mMnJjEZ79VBuKqKgz4mKvvxAAmgDG8XIlWWHpXfIgd4rQSjI7p8sgkF
	Ld848Owpi1CJJHLUSNRCwZo22w2eNpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733999087;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JSUUxzG9opR3Xi0ZHSRkRiPyIbSVnqpTCvgStZMvOmg=;
	b=R0LOOB0skr8gVNQv2sbsKWpwVO8Vt8TWroYwZiNOGiOUvdC3xvM9MCJs/ZKMFthK9PsyS8
	EL7fG7bXbE781HBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84CAA13939;
	Thu, 12 Dec 2024 10:24:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MfEoIO+5WmdOIQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Dec 2024 10:24:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1A52FA0894; Thu, 12 Dec 2024 11:24:43 +0100 (CET)
Date: Thu, 12 Dec 2024 11:24:43 +0100
From: Jan Kara <jack@suse.cz>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	kpsingh@kernel.org, mattbobrowski@google.com, liamwisehart@meta.com,
	shankaran@meta.com
Subject: Re: [PATCH v3 bpf-next 4/6] bpf: fs/xattr: Add BPF kfuncs to set and
 remove xattrs
Message-ID: <20241212102443.umqdrvthsi6r4ioy@quack3>
References: <20241210220627.2800362-1-song@kernel.org>
 <20241210220627.2800362-5-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210220627.2800362-5-song@kernel.org>
X-Rspamd-Queue-Id: 997F61F445
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,meta.com,kernel.org,gmail.com,iogearbox.net,linux.dev,zeniv.linux.org.uk,suse.cz,google.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 10-12-24 14:06:25, Song Liu wrote:
> Add the following kfuncs to set and remove xattrs from BPF programs:
> 
>   bpf_set_dentry_xattr
>   bpf_remove_dentry_xattr
>   bpf_set_dentry_xattr_locked
>   bpf_remove_dentry_xattr_locked
> 
> The _locked version of these kfuncs are called from hooks where
> dentry->d_inode is already locked.
> 
> Signed-off-by: Song Liu <song@kernel.org>

A few comments below.

> @@ -161,6 +162,160 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
>  	return bpf_get_dentry_xattr(dentry, name__str, value_p);
>  }
>  
> +static int bpf_xattr_write_permission(const char *name, struct inode *inode)
> +{
> +	if (WARN_ON(!inode))
> +		return -EINVAL;
> +
> +	/* Only allow setting and removing security.bpf. xattrs */
> +	if (!match_security_bpf_prefix(name))
> +		return -EPERM;
> +
> +	return inode_permission(&nop_mnt_idmap, inode, MAY_WRITE);
> +}
> +
> +static int __bpf_set_dentry_xattr(struct dentry *dentry, const char *name,
> +				  const struct bpf_dynptr *value_p, int flags, bool lock_inode)
> +{
> +	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
> +	struct inode *inode = d_inode(dentry);
> +	const void *value;
> +	u32 value_len;
> +	int ret;
> +
> +	ret = bpf_xattr_write_permission(name, inode);
> +	if (ret)
> +		return ret;

The permission checking should already happen under inode lock. Otherwise
you'll have TTCTTU races.

> +
> +	value_len = __bpf_dynptr_size(value_ptr);
> +	value = __bpf_dynptr_data(value_ptr, value_len);
> +	if (!value)
> +		return -EINVAL;
> +
> +	if (lock_inode)
> +		inode_lock(inode);
> +	ret = __vfs_setxattr(&nop_mnt_idmap, dentry, inode, name,
> +			     value, value_len, flags);
> +	if (!ret) {
> +		fsnotify_xattr(dentry);

Do we really want to generate fsnotify event for this? I expect
security.bpf is an internal bookkeeping of a BPF security module and
generating fsnotify event for it seems a bit like generating it for
filesystem metadata modifications. On the other hand as I'm checking IMA
generates fsnotify events when modifying its xattrs as well. So probably
this fine. OK.

...

> +static int __bpf_remove_dentry_xattr(struct dentry *dentry, const char *name__str,
> +				     bool lock_inode)
> +{
> +	struct inode *inode = d_inode(dentry);
> +	int ret;
> +
> +	ret = bpf_xattr_write_permission(name__str, inode);
> +	if (ret)
> +		return ret;
> +
> +	if (lock_inode)
 +		inode_lock(inode);

The same comment WRT inode lock as above.

> +	ret = __vfs_removexattr(&nop_mnt_idmap, dentry, name__str);
> +	if (!ret) {
> +		fsnotify_xattr(dentry);
> +
> +		/* This xattr is removed by BPF LSM, so we do not call
> +		 * security_inode_post_removexattr.
> +		 */
> +	}
> +	if (lock_inode)
> +		inode_unlock(inode);
> +	return ret;
> +}

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

