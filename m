Return-Path: <linux-fsdevel+bounces-11705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ECD856425
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 14:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65BE61C223E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 13:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD1312FF86;
	Thu, 15 Feb 2024 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AQ2tRBCo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nCcc9m7Z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AQ2tRBCo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nCcc9m7Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B036512FB3A;
	Thu, 15 Feb 2024 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003006; cv=none; b=jhwegj7Xhril0LZ7nk34ZbSHXXxCuyJSVe3URdfGT2T+7wq0bjcAroyuz+zmk0W44oh36mm3FKp77RfY/tqZWDbQtEicFd1H+ZliHfjqrRaVAFkwNGfOJHyInq18WqthUM5CMe3S+XnhYCheWDyobnkA9aBEOjaQbE2+H8YYwqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003006; c=relaxed/simple;
	bh=tXS8kJ3cnmxGedEbNbJt3O6eJ/O5HF6b+PwyDoj/d8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHWi+voHkSyhyHRiNEBJ0bYfSvA3W7fWy6ro8vl6z2iNPXYGJvJSosQre5VWzzwhhptxZOhbnYeqcmoxcAuytg1tyk2Vdp0Y5/mO+np48H8gtz/UPuvehBCQU7Bc2vnKWmp+K2S2O6KJse+9NdZ1gPgNyZYyDmg1BmWBHVUOkuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AQ2tRBCo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nCcc9m7Z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AQ2tRBCo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nCcc9m7Z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D5BAA1F894;
	Thu, 15 Feb 2024 13:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708003002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XC9ny37YeuymNCw5oL8/H8lTvfpocVvdYjSKBeF69HM=;
	b=AQ2tRBCoH9bn0soo15rveqhmk1m6ldqFwAIV9VZLxH8JM/tj+p/QWLGOIDyZrazdliZZ9C
	wgii2W4yF3TOAFwElVJxrerWp8SEcNQ0760Wt1sco0PZvYyKy5c0EH52amvAerCkS2dC6X
	ttPYNs2wONV0DC0O+YoD8ODXHK8CsTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708003002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XC9ny37YeuymNCw5oL8/H8lTvfpocVvdYjSKBeF69HM=;
	b=nCcc9m7Zprgg/pMz6zOF6/4Wvt+f28PdzYLjqNehO9SMLYKloee3Krfl1LZxZLYrPkGu4b
	syTKURCaERdud9CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708003002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XC9ny37YeuymNCw5oL8/H8lTvfpocVvdYjSKBeF69HM=;
	b=AQ2tRBCoH9bn0soo15rveqhmk1m6ldqFwAIV9VZLxH8JM/tj+p/QWLGOIDyZrazdliZZ9C
	wgii2W4yF3TOAFwElVJxrerWp8SEcNQ0760Wt1sco0PZvYyKy5c0EH52amvAerCkS2dC6X
	ttPYNs2wONV0DC0O+YoD8ODXHK8CsTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708003002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XC9ny37YeuymNCw5oL8/H8lTvfpocVvdYjSKBeF69HM=;
	b=nCcc9m7Zprgg/pMz6zOF6/4Wvt+f28PdzYLjqNehO9SMLYKloee3Krfl1LZxZLYrPkGu4b
	syTKURCaERdud9CA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C811B139D0;
	Thu, 15 Feb 2024 13:16:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id uHPTMLoOzmX6FwAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 15 Feb 2024 13:16:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4B2E7A0809; Thu, 15 Feb 2024 14:16:38 +0100 (CET)
Date: Thu, 15 Feb 2024 14:16:38 +0100
From: Jan Kara <jack@suse.cz>
To: Chuck Lever <cel@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	hughd@google.com, akpm@linux-foundation.org,
	Liam.Howlett@oracle.com, oliver.sang@intel.com, feng.tang@intel.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Subject: Re: [PATCH RFC 7/7] libfs: Re-arrange locking in offset_iterate_dir()
Message-ID: <20240215131638.cxipaxanhidb3pev@quack3>
References: <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
 <170786028847.11135.14775608389430603086.stgit@91.116.238.104.host.secureserver.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170786028847.11135.14775608389430603086.stgit@91.116.238.104.host.secureserver.net>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AQ2tRBCo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nCcc9m7Z
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D5BAA1F894
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Tue 13-02-24 16:38:08, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Liam says that, unlike with xarray, once the RCU read lock is
> released ma_state is not safe to re-use for the next mas_find() call.
> But the RCU read lock has to be released on each loop iteration so
> that dput() can be called safely.
> 
> Thus we are forced to walk the offset tree with fresh state for each
> directory entry. mt_find() can do this for us, though it might be a
> little less efficient than maintaining ma_state locally.
> 
> Since offset_iterate_dir() doesn't build ma_state locally any more,
> there's no longer a strong need for offset_find_next(). Clean up by
> rolling these two helpers together.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Well, in general I think even xas_next_entry() is not safe to use how
offset_find_next() was using it. Once you drop rcu_read_lock(),
xas->xa_node could go stale. But since you're holding inode->i_rwsem when
using offset_find_next() you should be protected from concurrent
modifications of the mapping (whatever the underlying data structure is) -
that's what makes xas_next_entry() safe AFAIU. Isn't that enough for the
maple tree? Am I missing something?

								Honza

> ---
>  fs/libfs.c |   39 +++++++++++++++++----------------------
>  1 file changed, 17 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index f073e9aeb2bf..6e01fde1cf95 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -436,23 +436,6 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
>  	return vfs_setpos(file, offset, MAX_LFS_FILESIZE);
>  }
>  
> -static struct dentry *offset_find_next(struct ma_state *mas)
> -{
> -	struct dentry *child, *found = NULL;
> -
> -	rcu_read_lock();
> -	child = mas_find(mas, ULONG_MAX);
> -	if (!child)
> -		goto out;
> -	spin_lock(&child->d_lock);
> -	if (simple_positive(child))
> -		found = dget_dlock(child);
> -	spin_unlock(&child->d_lock);
> -out:
> -	rcu_read_unlock();
> -	return found;
> -}
> -
>  static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
>  {
>  	unsigned long offset = dentry2offset(dentry);
> @@ -465,13 +448,22 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
>  static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>  {
>  	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
> -	MA_STATE(mas, &octx->mt, ctx->pos, ctx->pos);
> -	struct dentry *dentry;
> +	struct dentry *dentry, *found;
> +	unsigned long offset;
>  
> +	offset = ctx->pos;
>  	while (true) {
> -		dentry = offset_find_next(&mas);
> +		found = mt_find(&octx->mt, &offset, ULONG_MAX);
> +		if (!found)
> +			goto out_noent;
> +
> +		dentry = NULL;
> +		spin_lock(&found->d_lock);
> +		if (simple_positive(found))
> +			dentry = dget_dlock(found);
> +		spin_unlock(&found->d_lock);
>  		if (!dentry)
> -			return ERR_PTR(-ENOENT);
> +			goto out_noent;
>  
>  		if (!offset_dir_emit(ctx, dentry)) {
>  			dput(dentry);
> @@ -479,9 +471,12 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>  		}
>  
>  		dput(dentry);
> -		ctx->pos = mas.index + 1;
> +		ctx->pos = offset;
>  	}
>  	return NULL;
> +
> +out_noent:
> +	return ERR_PTR(-ENOENT);
>  }
>  
>  /**
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

