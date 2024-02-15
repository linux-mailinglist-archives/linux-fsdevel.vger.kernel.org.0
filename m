Return-Path: <linux-fsdevel+bounces-11701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A947D856396
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 13:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8171F26136
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 12:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5B012E1C9;
	Thu, 15 Feb 2024 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GfTUL9tm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hCJjNIfk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GfTUL9tm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hCJjNIfk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B9D12E1C0;
	Thu, 15 Feb 2024 12:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001240; cv=none; b=nvu4uzIHVHPVZ852mHW8qOEQ/vlBbpW6kfyyqyxpVnY7x0mAaSkhN5k0gB+3kvLZmk1KTLqIGZcyfGRU4BzjyQKRY7sYqmVds4UvHU+OqY32sj+CoxwDay4YT7rm91X1Pp2jYbeLpfU2gee2zQDQrdy6kXmbBDLc7FDPW2Npm4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001240; c=relaxed/simple;
	bh=yZAktc3RIvz3rC+Yhn+37ZHvJEr/l54KlqabnYz03Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGoeWvV+D4paXCTnJDEc9bpoWIMfZ1BMpNZyh0sWU4vO/hqROQnnoLlyXpy40A6LRzIhMmM/y8DOBCGWhwYgUWylv0ziSNv0YBHevNg+PmBsoz1CBzM0faAKQIVHp2+Aj3jgEYUohVNMhS6bSvREA/dLajHOukQnI0fBN1CMdys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GfTUL9tm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hCJjNIfk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GfTUL9tm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hCJjNIfk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 756F61F893;
	Thu, 15 Feb 2024 12:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708001236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+cWO/tWfyRm+uLRU3AlRpL172DdnCULMSesTiEnWQ9I=;
	b=GfTUL9tmlOv92k8l4zlSF9Tu1SL55JdV/3vw8wfaPFcfFFzIUjo8DN+7u3fqye4wK2Q+xi
	nJGOgp8o2COBQ+fLPc3APPa9r95FdBOzfIZhPbcDUyKhhE8USCHOqeGolNz1ZMA5RJ0/OP
	8PWzR6Ir7EnrR60yea1+EG1eWV5w5Ac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708001236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+cWO/tWfyRm+uLRU3AlRpL172DdnCULMSesTiEnWQ9I=;
	b=hCJjNIfkKuflINvJYN1DacPorlSqfOeOGWa0eC9yp1gT1Pja0hilfS06+/LF4FsxdGisoJ
	OIuDqSU1Q9fplKDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708001236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+cWO/tWfyRm+uLRU3AlRpL172DdnCULMSesTiEnWQ9I=;
	b=GfTUL9tmlOv92k8l4zlSF9Tu1SL55JdV/3vw8wfaPFcfFFzIUjo8DN+7u3fqye4wK2Q+xi
	nJGOgp8o2COBQ+fLPc3APPa9r95FdBOzfIZhPbcDUyKhhE8USCHOqeGolNz1ZMA5RJ0/OP
	8PWzR6Ir7EnrR60yea1+EG1eWV5w5Ac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708001236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+cWO/tWfyRm+uLRU3AlRpL172DdnCULMSesTiEnWQ9I=;
	b=hCJjNIfkKuflINvJYN1DacPorlSqfOeOGWa0eC9yp1gT1Pja0hilfS06+/LF4FsxdGisoJ
	OIuDqSU1Q9fplKDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AC43139D0;
	Thu, 15 Feb 2024 12:47:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 26QeFtQHzmWVEQAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 15 Feb 2024 12:47:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 149AFA0809; Thu, 15 Feb 2024 13:47:16 +0100 (CET)
Date: Thu, 15 Feb 2024 13:47:16 +0100
From: Jan Kara <jack@suse.cz>
To: Chuck Lever <cel@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	hughd@google.com, akpm@linux-foundation.org,
	Liam.Howlett@oracle.com, oliver.sang@intel.com, feng.tang@intel.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Subject: Re: [PATCH RFC 2/7] libfs: Define a minimum directory offset
Message-ID: <20240215124716.a7vdfjcnntyc6qj6@quack3>
References: <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
 <170786025248.11135.14453586596030949713.stgit@91.116.238.104.host.secureserver.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170786025248.11135.14453586596030949713.stgit@91.116.238.104.host.secureserver.net>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GfTUL9tm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hCJjNIfk
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,oracle.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 756F61F893
X-Spam-Flag: NO

On Tue 13-02-24 16:37:32, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> This value is used in several places, so make it a symbolic
> constant.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/libfs.c |   13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index bfbe1a8c5d2d..a38af72f4719 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -240,6 +240,11 @@ const struct inode_operations simple_dir_inode_operations = {
>  };
>  EXPORT_SYMBOL(simple_dir_inode_operations);
>  
> +/* 0 is '.', 1 is '..', so always start with offset 2 or more */
> +enum {
> +	DIR_OFFSET_MIN	= 2,
> +};
> +
>  static void offset_set(struct dentry *dentry, u32 offset)
>  {
>  	dentry->d_fsdata = (void *)((uintptr_t)(offset));
> @@ -261,9 +266,7 @@ void simple_offset_init(struct offset_ctx *octx)
>  {
>  	xa_init_flags(&octx->xa, XA_FLAGS_ALLOC1);
>  	lockdep_set_class(&octx->xa.xa_lock, &simple_offset_xa_lock);
> -
> -	/* 0 is '.', 1 is '..', so always start with offset 2 */
> -	octx->next_offset = 2;
> +	octx->next_offset = DIR_OFFSET_MIN;
>  }
>  
>  /**
> @@ -276,7 +279,7 @@ void simple_offset_init(struct offset_ctx *octx)
>   */
>  int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
>  {
> -	static const struct xa_limit limit = XA_LIMIT(2, U32_MAX);
> +	static const struct xa_limit limit = XA_LIMIT(DIR_OFFSET_MIN, U32_MAX);
>  	u32 offset;
>  	int ret;
>  
> @@ -481,7 +484,7 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
>  		return 0;
>  
>  	/* In this case, ->private_data is protected by f_pos_lock */
> -	if (ctx->pos == 2)
> +	if (ctx->pos == DIR_OFFSET_MIN)
>  		file->private_data = NULL;
>  	else if (file->private_data == ERR_PTR(-ENOENT))
>  		return 0;
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

