Return-Path: <linux-fsdevel+bounces-37727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0769F6512
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 12:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A9B18939DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 11:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074191A23A3;
	Wed, 18 Dec 2024 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rPNkHz7m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jMNKP+rb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nQYTIOAQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QZr0jquw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B272161310;
	Wed, 18 Dec 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734522101; cv=none; b=nTW4g86X9JvMj3ZLycjnmgrI0qq98Sm7dd4zkGFIZrF/Z9lvbAUeJA4uGHmpce+TtyZ4+12dqPW8Eb7sdObrE/WLSLayWgFkO0R/4L9Q3VpjAOPrZlRqtypIfEJGOB+olEiss4jhh045LoceBYc2RYcP71b8qBbzfzQohjai9YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734522101; c=relaxed/simple;
	bh=jIhlk8uvy6HrKArYDPzubzRzDPP6RkTF814/9kYXh+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O53Nfnuc2vFg1wvw53QHmektVdHOICUMbJeGloI9np22Lm4vM0nogPQfzVB5Riu+MOn8qNkotWF9JMhWqJHMFgNWABFBX7t8Zs8iEmFOIbiI1Wi1XZFgKwlCNL92oIKIh2pqjloq4uxSqxzWWrFQ/4c3T8v5/DQ4OTNco12LdnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rPNkHz7m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jMNKP+rb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nQYTIOAQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QZr0jquw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C28241F396;
	Wed, 18 Dec 2024 11:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734522097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6B3852qQKp8WfUVxdKcqFB2wusrAAaYORMzobHsGT8g=;
	b=rPNkHz7mh5tm/yBxyLPVMz/oDfMy2/m6FLt7L6u6oiRFSwq0pqVB5fzA4WhfhhONwaNPEg
	3QSO5oEay5phlYtPy+qHKgGGY+u/qPX+n6fIsQfZjf/YUyieQ8WhWneKF3YwtCGiS8iBF7
	9p16PkMqhxCmpzRE+Njr4DfXscTxxm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734522097;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6B3852qQKp8WfUVxdKcqFB2wusrAAaYORMzobHsGT8g=;
	b=jMNKP+rbXsv9Os6STJ3H6aJjT2x0Or2P8kjfKLykWa5QN7XyA4ahE4rha1/ZCaOdQa5lfL
	1NTSXWS+979N5rCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nQYTIOAQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QZr0jquw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734522096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6B3852qQKp8WfUVxdKcqFB2wusrAAaYORMzobHsGT8g=;
	b=nQYTIOAQixSNvw2OolFlEfanj+fwVUYREdRHydDmUCJu/3m3h1r9t/hK4ivKK6S2e9RQ9D
	jbDpSeEix1uoHETdwlkxwGVkVSvgkBqq5I7rhLfR1IIhHqSKJcSF8d57TZzGOtlXhfOMgY
	GbPRpZ9PmgWdlkFEP2Uvyb9QDgfEri0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734522096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6B3852qQKp8WfUVxdKcqFB2wusrAAaYORMzobHsGT8g=;
	b=QZr0jquw3JeLNlobmwBVz5PS1G+d0crQf5dr6nRlN3pfyNg4LkPo/MNFdKeAU1Rbo3VqTX
	n8qwNI0B23gqHuBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACC1A132EA;
	Wed, 18 Dec 2024 11:41:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8fHKKfC0Ymc6cAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 18 Dec 2024 11:41:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 62EBEA0935; Wed, 18 Dec 2024 12:41:32 +0100 (CET)
Date: Wed, 18 Dec 2024 12:41:32 +0100
From: Jan Kara <jack@suse.cz>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	kpsingh@kernel.org, mattbobrowski@google.com, liamwisehart@meta.com,
	shankaran@meta.com
Subject: Re: [PATCH v4 bpf-next 1/6] fs/xattr: bpf: Introduce security.bpf.
 xattr name prefix
Message-ID: <20241218114132.xfmavorzcpwo6nwg@quack3>
References: <20241217063821.482857-1-song@kernel.org>
 <20241217063821.482857-2-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217063821.482857-2-song@kernel.org>
X-Rspamd-Queue-Id: C28241F396
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Mon 16-12-24 22:38:16, Song Liu wrote:
> Introduct new xattr name prefix security.bpf., and enable reading these
> xattrs from bpf kfuncs bpf_get_[file|dentry]_xattr().
> 
> As we are on it, correct the comments for return value of
> bpf_get_[file|dentry]_xattr(), i.e. return length the xattr value on
> success.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> Acked-by: Christian Brauner <brauner@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/bpf_fs_kfuncs.c         | 19 ++++++++++++++-----
>  include/uapi/linux/xattr.h |  4 ++++
>  2 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 3fe9f59ef867..8a65184c8c2c 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -93,6 +93,11 @@ __bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
>  	return len;
>  }
>  
> +static bool match_security_bpf_prefix(const char *name__str)
> +{
> +	return !strncmp(name__str, XATTR_NAME_BPF_LSM, XATTR_NAME_BPF_LSM_LEN);
> +}
> +
>  /**
>   * bpf_get_dentry_xattr - get xattr of a dentry
>   * @dentry: dentry to get xattr from
> @@ -101,9 +106,10 @@ __bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
>   *
>   * Get xattr *name__str* of *dentry* and store the output in *value_ptr*.
>   *
> - * For security reasons, only *name__str* with prefix "user." is allowed.
> + * For security reasons, only *name__str* with prefix "user." or
> + * "security.bpf." is allowed.
>   *
> - * Return: 0 on success, a negative value on error.
> + * Return: length of the xattr value on success, a negative value on error.
>   */
>  __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__str,
>  				     struct bpf_dynptr *value_p)
> @@ -117,7 +123,9 @@ __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__st
>  	if (WARN_ON(!inode))
>  		return -EINVAL;
>  
> -	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
> +	/* Allow reading xattr with user. and security.bpf. prefix */
> +	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN) &&
> +	    !match_security_bpf_prefix(name__str))
>  		return -EPERM;
>  
>  	value_len = __bpf_dynptr_size(value_ptr);
> @@ -139,9 +147,10 @@ __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__st
>   *
>   * Get xattr *name__str* of *file* and store the output in *value_ptr*.
>   *
> - * For security reasons, only *name__str* with prefix "user." is allowed.
> + * For security reasons, only *name__str* with prefix "user." or
> + * "security.bpf." is allowed.
>   *
> - * Return: 0 on success, a negative value on error.
> + * Return: length of the xattr value on success, a negative value on error.
>   */
>  __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
>  				   struct bpf_dynptr *value_p)
> diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
> index 9854f9cff3c6..c7c85bb504ba 100644
> --- a/include/uapi/linux/xattr.h
> +++ b/include/uapi/linux/xattr.h
> @@ -83,6 +83,10 @@ struct xattr_args {
>  #define XATTR_CAPS_SUFFIX "capability"
>  #define XATTR_NAME_CAPS XATTR_SECURITY_PREFIX XATTR_CAPS_SUFFIX
>  
> +#define XATTR_BPF_LSM_SUFFIX "bpf."
> +#define XATTR_NAME_BPF_LSM (XATTR_SECURITY_PREFIX XATTR_BPF_LSM_SUFFIX)
> +#define XATTR_NAME_BPF_LSM_LEN (sizeof(XATTR_NAME_BPF_LSM) - 1)
> +
>  #define XATTR_POSIX_ACL_ACCESS  "posix_acl_access"
>  #define XATTR_NAME_POSIX_ACL_ACCESS XATTR_SYSTEM_PREFIX XATTR_POSIX_ACL_ACCESS
>  #define XATTR_POSIX_ACL_DEFAULT  "posix_acl_default"
> -- 
> 2.43.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

