Return-Path: <linux-fsdevel+bounces-28356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C80DD969C18
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2D9283BF4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 11:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D921C9854;
	Tue,  3 Sep 2024 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lyhIrjci";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AYepL/UH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lyhIrjci";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AYepL/UH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F343D1A42CF
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363477; cv=none; b=on//0UuuMIgROE0bi9CGx0+8CbOrIRiG40TIcJ18aJKRVr9bH5cAXZzKyRqdX/2ZhVr+aVK1kCnA+x8IuRXFEtZ1fN96Dhvl95B7uz1fm7EHm00f1dOV/ARw8/qyaPNIBry6K37OWURNKVk1dM2Xf4UKi/V0LeOItlceCVZ4eXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363477; c=relaxed/simple;
	bh=J1Mk6Fp6cYRYPIqehUbzhEOmdPN3u3zEGlyV69zb1hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEpkbyWYoVRBNsmcr4JvaY6n+5fq3l7RID5n4rucdbJt5gmmqTouw77nOfBK2rUlV5FC91mCNC4pU7JaDlq6tyfytHPvnWlFW7cB+pmXNQn32r4YNTpR1n5II4Fr7qVijhmrQlW3BnByF7uQsxSQv9EOwREQXlLfHwNsy/0ALSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lyhIrjci; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AYepL/UH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lyhIrjci; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AYepL/UH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 44C1F1F444;
	Tue,  3 Sep 2024 11:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725363474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TBAhvOpTkPEsQAIWnPO+pLPuLnCuRJ8ezfneKvtMnyw=;
	b=lyhIrjciUJnhwG/8CsqaqJlz2yfTSYA0sNp2bPMqQs24a68b1t1ZbfGr8z1LqE8AxO+kLd
	IY5i9sRBuFVrM6Byziwu5rBbrCjZ1Be7hj1qrXsxG8gmQ89WgtCjeV7brh2HaOncV15gvU
	ojM2fFie5KTFFoNgHoGvoXWP3v80vhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725363474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TBAhvOpTkPEsQAIWnPO+pLPuLnCuRJ8ezfneKvtMnyw=;
	b=AYepL/UHVen6aasgaCAjjB1uCWWfQmc9/a+Mzs3Bgpz/wfOqrg+FiONPtnzVIRQTfP9Pqv
	HPLDZAxWKg4NTSCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725363474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TBAhvOpTkPEsQAIWnPO+pLPuLnCuRJ8ezfneKvtMnyw=;
	b=lyhIrjciUJnhwG/8CsqaqJlz2yfTSYA0sNp2bPMqQs24a68b1t1ZbfGr8z1LqE8AxO+kLd
	IY5i9sRBuFVrM6Byziwu5rBbrCjZ1Be7hj1qrXsxG8gmQ89WgtCjeV7brh2HaOncV15gvU
	ojM2fFie5KTFFoNgHoGvoXWP3v80vhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725363474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TBAhvOpTkPEsQAIWnPO+pLPuLnCuRJ8ezfneKvtMnyw=;
	b=AYepL/UHVen6aasgaCAjjB1uCWWfQmc9/a+Mzs3Bgpz/wfOqrg+FiONPtnzVIRQTfP9Pqv
	HPLDZAxWKg4NTSCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3519913A52;
	Tue,  3 Sep 2024 11:37:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /0ztDBL11mY1JAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Sep 2024 11:37:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EA304A096C; Tue,  3 Sep 2024 13:37:49 +0200 (CEST)
Date: Tue, 3 Sep 2024 13:37:49 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 11/20] ext4: store cookie in private data
Message-ID: <20240903113749.iyh45qp3lfniiria@quack3>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-11-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-vfs-file-f_version-v1-11-6d3e4816aa7b@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 30-08-24 15:04:52, Christian Brauner wrote:
> Store the cookie to detect concurrent seeks on directories in
> file->private_data.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/dir.c    | 50 ++++++++++++++++++++++++++++----------------------
>  fs/ext4/ext4.h   |  2 ++
>  fs/ext4/inline.c |  7 ++++---
>  3 files changed, 34 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> index ff4514e4626b..13196afe55ce 100644
> --- a/fs/ext4/dir.c
> +++ b/fs/ext4/dir.c
> @@ -133,6 +133,7 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
>  	struct super_block *sb = inode->i_sb;
>  	struct buffer_head *bh = NULL;
>  	struct fscrypt_str fstr = FSTR_INIT(NULL, 0);
> +	struct dir_private_info *info = file->private_data;
>  
>  	err = fscrypt_prepare_readdir(inode);
>  	if (err)
> @@ -229,7 +230,7 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
>  		 * readdir(2), then we might be pointing to an invalid
>  		 * dirent right now.  Scan from the start of the block
>  		 * to make sure. */
> -		if (!inode_eq_iversion(inode, file->f_version)) {
> +		if (!inode_eq_iversion(inode, info->cookie)) {
>  			for (i = 0; i < sb->s_blocksize && i < offset; ) {
>  				de = (struct ext4_dir_entry_2 *)
>  					(bh->b_data + i);
> @@ -249,7 +250,7 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
>  			offset = i;
>  			ctx->pos = (ctx->pos & ~(sb->s_blocksize - 1))
>  				| offset;
> -			file->f_version = inode_query_iversion(inode);
> +			info->cookie = inode_query_iversion(inode);
>  		}
>  
>  		while (ctx->pos < inode->i_size
> @@ -384,6 +385,7 @@ static inline loff_t ext4_get_htree_eof(struct file *filp)
>  static loff_t ext4_dir_llseek(struct file *file, loff_t offset, int whence)
>  {
>  	struct inode *inode = file->f_mapping->host;
> +	struct dir_private_info *info = file->private_data;
>  	int dx_dir = is_dx_dir(inode);
>  	loff_t ret, htree_max = ext4_get_htree_eof(file);
>  
> @@ -392,7 +394,7 @@ static loff_t ext4_dir_llseek(struct file *file, loff_t offset, int whence)
>  						    htree_max, htree_max);
>  	else
>  		ret = ext4_llseek(file, offset, whence);
> -	file->f_version = inode_peek_iversion(inode) - 1;
> +	info->cookie = inode_peek_iversion(inode) - 1;
>  	return ret;
>  }
>  
> @@ -429,18 +431,15 @@ static void free_rb_tree_fname(struct rb_root *root)
>  	*root = RB_ROOT;
>  }
>  
> -
> -static struct dir_private_info *ext4_htree_create_dir_info(struct file *filp,
> -							   loff_t pos)
> +static void ext4_htree_init_dir_info(struct file *filp, loff_t pos)
>  {
> -	struct dir_private_info *p;
> -
> -	p = kzalloc(sizeof(*p), GFP_KERNEL);
> -	if (!p)
> -		return NULL;
> -	p->curr_hash = pos2maj_hash(filp, pos);
> -	p->curr_minor_hash = pos2min_hash(filp, pos);
> -	return p;
> +	struct dir_private_info *p = filp->private_data;
> +
> +	if (is_dx_dir(file_inode(filp)) && !p->initialized) {
> +		p->curr_hash = pos2maj_hash(filp, pos);
> +		p->curr_minor_hash = pos2min_hash(filp, pos);
> +		p->initialized = true;
> +	}
>  }
>  
>  void ext4_htree_free_dir_info(struct dir_private_info *p)
> @@ -552,12 +551,7 @@ static int ext4_dx_readdir(struct file *file, struct dir_context *ctx)
>  	struct fname *fname;
>  	int ret = 0;
>  
> -	if (!info) {
> -		info = ext4_htree_create_dir_info(file, ctx->pos);
> -		if (!info)
> -			return -ENOMEM;
> -		file->private_data = info;
> -	}
> +	ext4_htree_init_dir_info(file, ctx->pos);
>  
>  	if (ctx->pos == ext4_get_htree_eof(file))
>  		return 0;	/* EOF */
> @@ -590,10 +584,10 @@ static int ext4_dx_readdir(struct file *file, struct dir_context *ctx)
>  		 * cached entries.
>  		 */
>  		if ((!info->curr_node) ||
> -		    !inode_eq_iversion(inode, file->f_version)) {
> +		    !inode_eq_iversion(inode, info->cookie)) {
>  			info->curr_node = NULL;
>  			free_rb_tree_fname(&info->root);
> -			file->f_version = inode_query_iversion(inode);
> +			info->cookie = inode_query_iversion(inode);
>  			ret = ext4_htree_fill_tree(file, info->curr_hash,
>  						   info->curr_minor_hash,
>  						   &info->next_hash);
> @@ -664,7 +658,19 @@ int ext4_check_all_de(struct inode *dir, struct buffer_head *bh, void *buf,
>  	return 0;
>  }
>  
> +static int ext4_dir_open(struct inode *inode, struct file *file)
> +{
> +	struct dir_private_info *info;
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +	file->private_data = info;
> +	return 0;
> +}
> +
>  const struct file_operations ext4_dir_operations = {
> +	.open		= ext4_dir_open,
>  	.llseek		= ext4_dir_llseek,
>  	.read		= generic_read_dir,
>  	.iterate_shared	= ext4_readdir,
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 08acd152261e..d62a4b9b26ce 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2553,6 +2553,8 @@ struct dir_private_info {
>  	__u32		curr_hash;
>  	__u32		curr_minor_hash;
>  	__u32		next_hash;
> +	u64		cookie;
> +	bool		initialized;
>  };
>  
>  /* calculate the first block number of the group */
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index e7a09a99837b..4282e12dc405 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -1460,6 +1460,7 @@ int ext4_read_inline_dir(struct file *file,
>  	struct ext4_iloc iloc;
>  	void *dir_buf = NULL;
>  	int dotdot_offset, dotdot_size, extra_offset, extra_size;
> +	struct dir_private_info *info = file->private_data;
>  
>  	ret = ext4_get_inode_loc(inode, &iloc);
>  	if (ret)
> @@ -1503,12 +1504,12 @@ int ext4_read_inline_dir(struct file *file,
>  	extra_size = extra_offset + inline_size;
>  
>  	/*
> -	 * If the version has changed since the last call to
> +	 * If the cookie has changed since the last call to
>  	 * readdir(2), then we might be pointing to an invalid
>  	 * dirent right now.  Scan from the start of the inline
>  	 * dir to make sure.
>  	 */
> -	if (!inode_eq_iversion(inode, file->f_version)) {
> +	if (!inode_eq_iversion(inode, info->cookie)) {
>  		for (i = 0; i < extra_size && i < offset;) {
>  			/*
>  			 * "." is with offset 0 and
> @@ -1540,7 +1541,7 @@ int ext4_read_inline_dir(struct file *file,
>  		}
>  		offset = i;
>  		ctx->pos = offset;
> -		file->f_version = inode_query_iversion(inode);
> +		info->cookie = inode_query_iversion(inode);
>  	}
>  
>  	while (ctx->pos < extra_size) {
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

