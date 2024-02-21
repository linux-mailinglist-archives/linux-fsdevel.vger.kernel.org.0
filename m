Return-Path: <linux-fsdevel+bounces-12261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34F185D937
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 14:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120181C22CDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 13:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D1C7641B;
	Wed, 21 Feb 2024 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1m8/Gvn7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DDdkVqxA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1m8/Gvn7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DDdkVqxA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6898869D09;
	Wed, 21 Feb 2024 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521347; cv=none; b=Tj14UbHqKBVMkvDHfNyK55BAf+DAe9GL8SEJzOvhGaAcPI48ajxt3g9biaA8dxgX0uyTQew7QLdneG3SZu11z7mPqi92zKbIzHxWnXvZ/gB1v/+yBa1P5W8Bi/hCOQTq6qzkyA6qlkagFbyFaWMUK6p/KXeTwHSZThEYQ/34OLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521347; c=relaxed/simple;
	bh=ftWuBdO0JcBz5ZpTPaW+smTKtB8dbs4rOByOV6biaB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntC/+M9tWwP2iUEmcnYzIksuNrN4zaYUF+wUUVYUdTtheF/a31+Aod+zLSgIX94fDJemGGeyF5G/yM55JcSvz6uxk/ZJTgR8E8iLrZcvkQMv4+vOCv5cqqysiE/lj/fS6/OjSLMqu1vjlKNzWgD2OeX/IFKkzx0bBiCiTYAZK2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1m8/Gvn7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DDdkVqxA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1m8/Gvn7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DDdkVqxA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F2461FB5D;
	Wed, 21 Feb 2024 13:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708521343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c1q+3O+PlbOI5pZ5NbAJnd5M96l97I4OwjtAWw0vYtw=;
	b=1m8/Gvn7K59jCByvWKztNp3YWT8CqQjqB+leAzVmDJAcJUWFqGR+3T6QPvpHMNVobx7qwx
	TepME9apOxb05L8J7XbCvBAmoha3GGVgDlHj7NRfWMbQNRTdSLScKTYiX6ar/4ZjAeatBR
	m6ND2M2BZAdlBD/vLmY+UYC+Se0ktlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708521343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c1q+3O+PlbOI5pZ5NbAJnd5M96l97I4OwjtAWw0vYtw=;
	b=DDdkVqxAy7gQJk5zJCxhHwR/BZVzVmqKdxr6B8HsoSDwwEPrdpjOlclcVi7l0DT0J40bWl
	UYV3pW1c7YM7FMDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708521343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c1q+3O+PlbOI5pZ5NbAJnd5M96l97I4OwjtAWw0vYtw=;
	b=1m8/Gvn7K59jCByvWKztNp3YWT8CqQjqB+leAzVmDJAcJUWFqGR+3T6QPvpHMNVobx7qwx
	TepME9apOxb05L8J7XbCvBAmoha3GGVgDlHj7NRfWMbQNRTdSLScKTYiX6ar/4ZjAeatBR
	m6ND2M2BZAdlBD/vLmY+UYC+Se0ktlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708521343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c1q+3O+PlbOI5pZ5NbAJnd5M96l97I4OwjtAWw0vYtw=;
	b=DDdkVqxAy7gQJk5zJCxhHwR/BZVzVmqKdxr6B8HsoSDwwEPrdpjOlclcVi7l0DT0J40bWl
	UYV3pW1c7YM7FMDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 64F9A13A25;
	Wed, 21 Feb 2024 13:15:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id g0CiGH/31WVHOwAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 21 Feb 2024 13:15:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0E782A0807; Wed, 21 Feb 2024 14:15:39 +0100 (CET)
Date: Wed, 21 Feb 2024 14:15:39 +0100
From: Jan Kara <jack@suse.cz>
To: Chuck Lever <cel@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	hughd@google.com, akpm@linux-foundation.org,
	Liam.Howlett@oracle.com, oliver.sang@intel.com, feng.tang@intel.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Subject: Re: [PATCH v2 1/6] libfs: Re-arrange locking in offset_iterate_dir()
Message-ID: <20240221131539.wmr5xde7xode2xn5@quack3>
References: <170820083431.6328.16233178852085891453.stgit@91.116.238.104.host.secureserver.net>
 <170820142021.6328.15047865406275957018.stgit@91.116.238.104.host.secureserver.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170820142021.6328.15047865406275957018.stgit@91.116.238.104.host.secureserver.net>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Sat 17-02-24 15:23:40, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Liam and Matthew say that once the RCU read lock is released,
> xa_state is not safe to re-use for the next xas_find() call. But the
> RCU read lock must be released on each loop iteration so that
> dput(), which might_sleep(), can be called safely.
> 
> Thus we are forced to walk the offset tree with fresh state for each
> directory entry. xa_find() can do this for us, though it might be a
> little less efficient than maintaining xa_state locally.
> 
> We believe that in the current code base, inode->i_rwsem provides
> protection for the xa_state maintained in
> offset_iterate_dir(). However, there is no guarantee that will
> continue to be the case in the future.
> 
> Since offset_iterate_dir() doesn't build xa_state locally any more,
> there's no longer a strong need for offset_find_next(). Clean up by
> rolling these two helpers together.
> 
> Suggested-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Message-ID: <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/libfs.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index eec6031b0155..752e24c669d9 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -402,12 +402,13 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
>  	return vfs_setpos(file, offset, U32_MAX);
>  }
>  
> -static struct dentry *offset_find_next(struct xa_state *xas)
> +static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
>  {
>  	struct dentry *child, *found = NULL;
> +	XA_STATE(xas, &octx->xa, offset);
>  
>  	rcu_read_lock();
> -	child = xas_next_entry(xas, U32_MAX);
> +	child = xas_next_entry(&xas, U32_MAX);
>  	if (!child)
>  		goto out;
>  	spin_lock(&child->d_lock);
> @@ -430,12 +431,11 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
>  
>  static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>  {
> -	struct offset_ctx *so_ctx = inode->i_op->get_offset_ctx(inode);
> -	XA_STATE(xas, &so_ctx->xa, ctx->pos);
> +	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
>  	struct dentry *dentry;
>  
>  	while (true) {
> -		dentry = offset_find_next(&xas);
> +		dentry = offset_find_next(octx, ctx->pos);
>  		if (!dentry)
>  			return ERR_PTR(-ENOENT);
>  
> @@ -444,8 +444,8 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>  			break;
>  		}
>  
> +		ctx->pos = dentry2offset(dentry) + 1;
>  		dput(dentry);
> -		ctx->pos = xas.xa_index + 1;
>  	}
>  	return NULL;
>  }
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

