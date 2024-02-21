Return-Path: <linux-fsdevel+bounces-12264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EBF85DABA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 14:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8C0283AB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 13:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D409D7CF1A;
	Wed, 21 Feb 2024 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RC20Cs0S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e3g3p8mM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RC20Cs0S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e3g3p8mM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C977866C;
	Wed, 21 Feb 2024 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522329; cv=none; b=ZbaAaJ/HlyIDLZOGRfiZnujOyj29E8jRLR8+UhaWSzBWr/PLAkmk8vyV5af84rh77UIgGxcxFJv+gzbHUFa2u+z0Zzppzkz1quauvgPFxQjz7b7zhZgg76Y6GjEPSwYChQ4en7ocBi2A6ablG9BQsEFkM1VkkkpaHgXUh77+BFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522329; c=relaxed/simple;
	bh=EaEOLSGNM6VDifbvN81OSAgHHAahgnwCSzxj2WV8yHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5l7AsacIWFNRJe34EJdpbA1AzLmNqtuBayp20bvZ1ST3YSuIcckfm5aHl99VzqODde991Rn1P0NoCvUUqH23aIKwRWBY0syAW7n2147pvMGxfRkaYgYa+ZgL21WWF+qKb+O9OZpd6sclFAjxyGJo9/QPAs+qQDOIPVyKfebAD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RC20Cs0S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e3g3p8mM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RC20Cs0S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e3g3p8mM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0AAD521EA7;
	Wed, 21 Feb 2024 13:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708522312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uP/pTL/sO1NtuE/Wku+EtoGvxfXo8u7Y5hh2SArc8WY=;
	b=RC20Cs0SuspBuacpmJe885/Rhshl8zdGafkCvAbnyJwxj2F4Y8WsQ2Ikfh1HbMP/PfOvI9
	RsxUhyAxxcG2wrsN0tzSEZR6GF5gaqznYA3p25B58bXAzJqOoN3jJ5HKU3Gb8nZECCEPtS
	guX+7vOyBFCBCaDAqH6ZM9U8y3Tm2Bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708522312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uP/pTL/sO1NtuE/Wku+EtoGvxfXo8u7Y5hh2SArc8WY=;
	b=e3g3p8mM5enw6IidLkPS76H7P6mIT5Cp8+XHzSeRRUplGyUdhyU/v7wumMvLbnTZm6n0kj
	U8HiYzZ5Asy6EZCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708522312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uP/pTL/sO1NtuE/Wku+EtoGvxfXo8u7Y5hh2SArc8WY=;
	b=RC20Cs0SuspBuacpmJe885/Rhshl8zdGafkCvAbnyJwxj2F4Y8WsQ2Ikfh1HbMP/PfOvI9
	RsxUhyAxxcG2wrsN0tzSEZR6GF5gaqznYA3p25B58bXAzJqOoN3jJ5HKU3Gb8nZECCEPtS
	guX+7vOyBFCBCaDAqH6ZM9U8y3Tm2Bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708522312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uP/pTL/sO1NtuE/Wku+EtoGvxfXo8u7Y5hh2SArc8WY=;
	b=e3g3p8mM5enw6IidLkPS76H7P6mIT5Cp8+XHzSeRRUplGyUdhyU/v7wumMvLbnTZm6n0kj
	U8HiYzZ5Asy6EZCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EBF9B13A25;
	Wed, 21 Feb 2024 13:31:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id wbuVOUf71WXbPgAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 21 Feb 2024 13:31:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 90712A0807; Wed, 21 Feb 2024 14:31:51 +0100 (CET)
Date: Wed, 21 Feb 2024 14:31:51 +0100
From: Jan Kara <jack@suse.cz>
To: Chuck Lever <cel@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	hughd@google.com, akpm@linux-foundation.org,
	Liam.Howlett@oracle.com, oliver.sang@intel.com, feng.tang@intel.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Subject: Re: [PATCH v2 6/6] libfs: Convert simple directory offsets to use a
 Maple Tree
Message-ID: <20240221133151.qbb45mzl5kl5u7hq@quack3>
References: <170820083431.6328.16233178852085891453.stgit@91.116.238.104.host.secureserver.net>
 <170820145616.6328.12620992971699079156.stgit@91.116.238.104.host.secureserver.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170820145616.6328.12620992971699079156.stgit@91.116.238.104.host.secureserver.net>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RC20Cs0S;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=e3g3p8mM
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.com:email,oracle.com:email,infradead.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0AAD521EA7
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Sat 17-02-24 15:24:16, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Test robot reports:
> > kernel test robot noticed a -19.0% regression of aim9.disk_src.ops_per_sec on:
> >
> > commit: a2e459555c5f9da3e619b7e47a63f98574dc75f1 ("shmem: stable directory offsets")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> Feng Tang further clarifies that:
> > ... the new simple_offset_add()
> > called by shmem_mknod() brings extra cost related with slab,
> > specifically the 'radix_tree_node', which cause the regression.
> 
> Willy's analysis is that, over time, the test workload causes
> xa_alloc_cyclic() to fragment the underlying SLAB cache.
> 
> This patch replaces the offset_ctx's xarray with a Maple Tree in the
> hope that Maple Tree's dense node mode will handle this scenario
> more scalably.
> 
> In addition, we can widen the simple directory offset maximum to
> signed long (as loff_t is also signed).
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202309081306.3ecb3734-oliver.sang@intel.com
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/libfs.c         |   47 +++++++++++++++++++++++------------------------
>  include/linux/fs.h |    5 +++--
>  2 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index f7f92a49a418..d3d31197c8e4 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -245,17 +245,17 @@ enum {
>  	DIR_OFFSET_MIN	= 2,
>  };
>  
> -static void offset_set(struct dentry *dentry, u32 offset)
> +static void offset_set(struct dentry *dentry, long offset)
>  {
> -	dentry->d_fsdata = (void *)((uintptr_t)(offset));
> +	dentry->d_fsdata = (void *)offset;
>  }
>  
> -static u32 dentry2offset(struct dentry *dentry)
> +static long dentry2offset(struct dentry *dentry)
>  {
> -	return (u32)((uintptr_t)(dentry->d_fsdata));
> +	return (long)dentry->d_fsdata;
>  }
>  
> -static struct lock_class_key simple_offset_xa_lock;
> +static struct lock_class_key simple_offset_lock_class;
>  
>  /**
>   * simple_offset_init - initialize an offset_ctx
> @@ -264,8 +264,8 @@ static struct lock_class_key simple_offset_xa_lock;
>   */
>  void simple_offset_init(struct offset_ctx *octx)
>  {
> -	xa_init_flags(&octx->xa, XA_FLAGS_ALLOC1);
> -	lockdep_set_class(&octx->xa.xa_lock, &simple_offset_xa_lock);
> +	mt_init_flags(&octx->mt, MT_FLAGS_ALLOC_RANGE);
> +	lockdep_set_class(&octx->mt.ma_lock, &simple_offset_lock_class);
>  	octx->next_offset = DIR_OFFSET_MIN;
>  }
>  
> @@ -274,20 +274,19 @@ void simple_offset_init(struct offset_ctx *octx)
>   * @octx: directory offset ctx to be updated
>   * @dentry: new dentry being added
>   *
> - * Returns zero on success. @so_ctx and the dentry offset are updated.
> + * Returns zero on success. @octx and the dentry's offset are updated.
>   * Otherwise, a negative errno value is returned.
>   */
>  int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
>  {
> -	static const struct xa_limit limit = XA_LIMIT(DIR_OFFSET_MIN, U32_MAX);
> -	u32 offset;
> +	unsigned long offset;
>  	int ret;
>  
>  	if (dentry2offset(dentry) != 0)
>  		return -EBUSY;
>  
> -	ret = xa_alloc_cyclic(&octx->xa, &offset, dentry, limit,
> -			      &octx->next_offset, GFP_KERNEL);
> +	ret = mtree_alloc_cyclic(&octx->mt, &offset, dentry, DIR_OFFSET_MIN,
> +				 LONG_MAX, &octx->next_offset, GFP_KERNEL);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -303,13 +302,13 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
>   */
>  void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
>  {
> -	u32 offset;
> +	long offset;
>  
>  	offset = dentry2offset(dentry);
>  	if (offset == 0)
>  		return;
>  
> -	xa_erase(&octx->xa, offset);
> +	mtree_erase(&octx->mt, offset);
>  	offset_set(dentry, 0);
>  }
>  
> @@ -332,7 +331,7 @@ int simple_offset_empty(struct dentry *dentry)
>  
>  	index = DIR_OFFSET_MIN;
>  	octx = inode->i_op->get_offset_ctx(inode);
> -	xa_for_each(&octx->xa, index, child) {
> +	mt_for_each(&octx->mt, child, index, LONG_MAX) {
>  		spin_lock(&child->d_lock);
>  		if (simple_positive(child)) {
>  			spin_unlock(&child->d_lock);
> @@ -362,8 +361,8 @@ int simple_offset_rename_exchange(struct inode *old_dir,
>  {
>  	struct offset_ctx *old_ctx = old_dir->i_op->get_offset_ctx(old_dir);
>  	struct offset_ctx *new_ctx = new_dir->i_op->get_offset_ctx(new_dir);
> -	u32 old_index = dentry2offset(old_dentry);
> -	u32 new_index = dentry2offset(new_dentry);
> +	long old_index = dentry2offset(old_dentry);
> +	long new_index = dentry2offset(new_dentry);
>  	int ret;
>  
>  	simple_offset_remove(old_ctx, old_dentry);
> @@ -389,9 +388,9 @@ int simple_offset_rename_exchange(struct inode *old_dir,
>  
>  out_restore:
>  	offset_set(old_dentry, old_index);
> -	xa_store(&old_ctx->xa, old_index, old_dentry, GFP_KERNEL);
> +	mtree_store(&old_ctx->mt, old_index, old_dentry, GFP_KERNEL);
>  	offset_set(new_dentry, new_index);
> -	xa_store(&new_ctx->xa, new_index, new_dentry, GFP_KERNEL);
> +	mtree_store(&new_ctx->mt, new_index, new_dentry, GFP_KERNEL);
>  	return ret;
>  }
>  
> @@ -404,7 +403,7 @@ int simple_offset_rename_exchange(struct inode *old_dir,
>   */
>  void simple_offset_destroy(struct offset_ctx *octx)
>  {
> -	xa_destroy(&octx->xa);
> +	mtree_destroy(&octx->mt);
>  }
>  
>  /**
> @@ -434,16 +433,16 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
>  
>  	/* In this case, ->private_data is protected by f_pos_lock */
>  	file->private_data = NULL;
> -	return vfs_setpos(file, offset, U32_MAX);
> +	return vfs_setpos(file, offset, LONG_MAX);
>  }
>  
>  static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
>  {
> +	MA_STATE(mas, &octx->mt, offset, offset);
>  	struct dentry *child, *found = NULL;
> -	XA_STATE(xas, &octx->xa, offset);
>  
>  	rcu_read_lock();
> -	child = xas_next_entry(&xas, U32_MAX);
> +	child = mas_find(&mas, LONG_MAX);
>  	if (!child)
>  		goto out;
>  	spin_lock(&child->d_lock);
> @@ -457,8 +456,8 @@ static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
>  
>  static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
>  {
> -	u32 offset = dentry2offset(dentry);
>  	struct inode *inode = d_inode(dentry);
> +	long offset = dentry2offset(dentry);
>  
>  	return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len, offset,
>  			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 03d141809a2c..55144c12ee0f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -43,6 +43,7 @@
>  #include <linux/cred.h>
>  #include <linux/mnt_idmapping.h>
>  #include <linux/slab.h>
> +#include <linux/maple_tree.h>
>  
>  #include <asm/byteorder.h>
>  #include <uapi/linux/fs.h>
> @@ -3260,8 +3261,8 @@ extern ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
>  		const void __user *from, size_t count);
>  
>  struct offset_ctx {
> -	struct xarray		xa;
> -	u32			next_offset;
> +	struct maple_tree	mt;
> +	unsigned long		next_offset;
>  };
>  
>  void simple_offset_init(struct offset_ctx *octx);
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

