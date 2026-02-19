Return-Path: <linux-fsdevel+bounces-77702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAzLLg38lmkXtQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 13:03:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B31C15E7CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 13:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 910D63035D5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 12:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AB43358C0;
	Thu, 19 Feb 2026 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FX3La7g9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NroNxCrq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FX3La7g9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NroNxCrq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52982FD675
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 12:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771502585; cv=none; b=uJ0DbpsaZVy27Bq9y/DaHrkGgSjOskJf5haxKhS838bp0DPsWySjXmKsi2maKf0KDfcqrG5neIjmOMn3ZmfwInzSIYM6s10mHJDzHCMPcVEPaxMMC5OBh/PImF9aWkFE7Cc+C7gVTV3qWykLdFrQ9Ez4K2dmL4gq+Je1Ege2cqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771502585; c=relaxed/simple;
	bh=R2wi7pz1uWWNINYF+qbl+Y5HyzW0s3Euy2EaSq2Rl2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fF5hCClDKw3TTbzAy0mFGcFI9bNM1+GdygmlPYx15CwlCuIArQTHoY2mDd5YavcYIbwAImCUeoswitwtuY19Chflk9F0z3l35xdAM7jvrrHkct3oQdeJ9CxBI7CQelt7+IiBkqSfdvVwYEtUJyjreL71U9rSf7eEoaY5qUi15f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FX3La7g9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NroNxCrq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FX3La7g9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NroNxCrq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0BDF43E6DB;
	Thu, 19 Feb 2026 12:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771502581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYIguF5TPw9Bm5ffYF+ezNu69qmxavOJ15nqAdMnsBo=;
	b=FX3La7g9lSI644cAJzI9v5F9vi/V+5Hpcix96v6lt+D0D89nqAeB3dgu8rau2hCiTOSJiZ
	lzetvgo0gNzcFcQGantfXs5RDF7qFnCE6GH/bBEJfFKY81BmEpVkKUWYPXAZjTF/TMIvax
	QLrEe5l6dM0z/Qwe3++GAg/EfvGyqW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771502581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYIguF5TPw9Bm5ffYF+ezNu69qmxavOJ15nqAdMnsBo=;
	b=NroNxCrqBXmR+uaYb7gSDV9Z1n9WRiE6wJfD385TwA7Uf9tyZnceL0eQKy9R+IruzABSh+
	Z8sGXwVwwLOb0JBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771502581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYIguF5TPw9Bm5ffYF+ezNu69qmxavOJ15nqAdMnsBo=;
	b=FX3La7g9lSI644cAJzI9v5F9vi/V+5Hpcix96v6lt+D0D89nqAeB3dgu8rau2hCiTOSJiZ
	lzetvgo0gNzcFcQGantfXs5RDF7qFnCE6GH/bBEJfFKY81BmEpVkKUWYPXAZjTF/TMIvax
	QLrEe5l6dM0z/Qwe3++GAg/EfvGyqW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771502581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYIguF5TPw9Bm5ffYF+ezNu69qmxavOJ15nqAdMnsBo=;
	b=NroNxCrqBXmR+uaYb7gSDV9Z1n9WRiE6wJfD385TwA7Uf9tyZnceL0eQKy9R+IruzABSh+
	Z8sGXwVwwLOb0JBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E84613EA65;
	Thu, 19 Feb 2026 12:03:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zSavOPT7lmkiVAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 19 Feb 2026 12:03:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AB2CFA06FE; Thu, 19 Feb 2026 13:03:00 +0100 (CET)
Date: Thu, 19 Feb 2026 13:03:00 +0100
From: Jan Kara <jack@suse.cz>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Jens Axboe <axboe@kernel.dk>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Dave Kleikamp <shaggy@kernel.org>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Bob Copeland <me@bobcopeland.com>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, linux-karma-devel@lists.sourceforge.net
Subject: Re: [PATCH RFC] block: enable RWF_DONTCACHE for block devices
Message-ID: <ew75xhk7i26smogev3mhd6vg24dsiguyh4fvhfghcobyne6w2d@shlc7nufv5b7>
References: <20260218-blk-dontcache-v1-1-fad6675ef71f@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218-blk-dontcache-v1-1-fad6675ef71f@columbia.edu>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77702-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,columbia.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[kernel.dk,gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,samsung.com,sony.com,dubeyko.com,paragon-software.com,bobcopeland.com,vger.kernel.org,lists.sourceforge.net,lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2B31C15E7CA
X-Rspamd-Action: no action

On Wed 18-02-26 16:13:17, Tal Zussman wrote:
> Block device buffered reads and writes already pass through
> filemap_read() and iomap_file_buffered_write() respectively, both of
> which handle IOCB_DONTCACHE. Enable RWF_DONTCACHE for block device files
> by setting FOP_DONTCACHE in def_blk_fops.
> 
> For CONFIG_BUFFER_HEAD paths, thread the kiocb through
> block_write_begin() so that buffer_head-based I/O can use DONTCACHE
> behavior as well. Callers without a kiocb context (e.g. nilfs2 recovery)
> pass NULL, which preserves the existing behavior.
> 
> This support is useful for databases that operate on raw block devices,
> among other userspace applications.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> This is based on v6.19. Please let me know if there's a different tree I
> should base this on.
> 
> I wasn't sure if the block_write_begin() changes were necessary for
> block device support if CONFIG_BUFFER_HEAD is set (hence the RFC tag). I
> can remove those if they're not necessary.
> ---
>  block/fops.c                |  4 ++--
>  fs/bfs/file.c               |  2 +-
>  fs/buffer.c                 | 12 ++++++++----
>  fs/exfat/inode.c            |  2 +-
>  fs/ext2/inode.c             |  2 +-
>  fs/jfs/inode.c              |  2 +-
>  fs/minix/inode.c            |  2 +-
>  fs/nilfs2/inode.c           |  2 +-
>  fs/nilfs2/recovery.c        |  2 +-
>  fs/ntfs3/inode.c            |  2 +-
>  fs/omfs/file.c              |  2 +-
>  fs/udf/inode.c              |  2 +-
>  fs/ufs/inode.c              |  2 +-
>  include/linux/buffer_head.h |  5 +++--
>  14 files changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 4d32785b31d9..6bc727f8b252 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -505,7 +505,7 @@ static int blkdev_write_begin(const struct kiocb *iocb,
>  			      unsigned len, struct folio **foliop,
>  			      void **fsdata)
>  {
> -	return block_write_begin(mapping, pos, len, foliop, blkdev_get_block);
> +	return block_write_begin(iocb, mapping, pos, len, foliop, blkdev_get_block);
>  }
>  
>  static int blkdev_write_end(const struct kiocb *iocb,
> @@ -967,7 +967,7 @@ const struct file_operations def_blk_fops = {
>  	.splice_write	= iter_file_splice_write,
>  	.fallocate	= blkdev_fallocate,
>  	.uring_cmd	= blkdev_uring_cmd,
> -	.fop_flags	= FOP_BUFFER_RASYNC,
> +	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
>  };
>  
>  static __init int blkdev_init(void)
> diff --git a/fs/bfs/file.c b/fs/bfs/file.c
> index d33d6bde992b..f2804e38b8a7 100644
> --- a/fs/bfs/file.c
> +++ b/fs/bfs/file.c
> @@ -177,7 +177,7 @@ static int bfs_write_begin(const struct kiocb *iocb,
>  {
>  	int ret;
>  
> -	ret = block_write_begin(mapping, pos, len, foliop, bfs_get_block);
> +	ret = block_write_begin(iocb, mapping, pos, len, foliop, bfs_get_block);
>  	if (unlikely(ret))
>  		bfs_write_failed(mapping, pos + len);
>  
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 838c0c571022..33c3580b85d8 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2241,14 +2241,18 @@ EXPORT_SYMBOL(block_commit_write);
>   *
>   * The filesystem needs to handle block truncation upon failure.
>   */
> -int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
> -		struct folio **foliop, get_block_t *get_block)
> +int block_write_begin(const struct kiocb *iocb, struct address_space *mapping,
> +		loff_t pos, unsigned len, struct folio **foliop, get_block_t *get_block)
>  {
>  	pgoff_t index = pos >> PAGE_SHIFT;
> +	fgf_t fgp_flags = FGP_WRITEBEGIN;
>  	struct folio *folio;
>  	int status;
>  
> -	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
> +	if (iocb && iocb->ki_flags & IOCB_DONTCACHE)
> +		fgp_flags |= FGP_DONTCACHE;
> +
> +	folio = __filemap_get_folio(mapping, index, fgp_flags,
>  			mapping_gfp_mask(mapping));
>  	if (IS_ERR(folio))
>  		return PTR_ERR(folio);
> @@ -2591,7 +2595,7 @@ int cont_write_begin(const struct kiocb *iocb, struct address_space *mapping,
>  		(*bytes)++;
>  	}
>  
> -	return block_write_begin(mapping, pos, len, foliop, get_block);
> +	return block_write_begin(iocb, mapping, pos, len, foliop, get_block);
>  }
>  EXPORT_SYMBOL(cont_write_begin);
>  
> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
> index f9501c3a3666..39d36e8fdfd6 100644
> --- a/fs/exfat/inode.c
> +++ b/fs/exfat/inode.c
> @@ -456,7 +456,7 @@ static int exfat_write_begin(const struct kiocb *iocb,
>  	if (unlikely(exfat_forced_shutdown(mapping->host->i_sb)))
>  		return -EIO;
>  
> -	ret = block_write_begin(mapping, pos, len, foliop, exfat_get_block);
> +	ret = block_write_begin(iocb, mapping, pos, len, foliop, exfat_get_block);
>  
>  	if (ret < 0)
>  		exfat_write_failed(mapping, pos+len);
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index dbfe9098a124..11aab03de752 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -930,7 +930,7 @@ ext2_write_begin(const struct kiocb *iocb, struct address_space *mapping,
>  {
>  	int ret;
>  
> -	ret = block_write_begin(mapping, pos, len, foliop, ext2_get_block);
> +	ret = block_write_begin(iocb, mapping, pos, len, foliop, ext2_get_block);
>  	if (ret < 0)
>  		ext2_write_failed(mapping, pos + len);
>  	return ret;
> diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
> index 4709762713ef..ae52db437771 100644
> --- a/fs/jfs/inode.c
> +++ b/fs/jfs/inode.c
> @@ -303,7 +303,7 @@ static int jfs_write_begin(const struct kiocb *iocb,
>  {
>  	int ret;
>  
> -	ret = block_write_begin(mapping, pos, len, foliop, jfs_get_block);
> +	ret = block_write_begin(iocb, mapping, pos, len, foliop, jfs_get_block);
>  	if (unlikely(ret))
>  		jfs_write_failed(mapping, pos + len);
>  
> diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> index 51ea9bdc813f..9075c0ba2f20 100644
> --- a/fs/minix/inode.c
> +++ b/fs/minix/inode.c
> @@ -465,7 +465,7 @@ static int minix_write_begin(const struct kiocb *iocb,
>  {
>  	int ret;
>  
> -	ret = block_write_begin(mapping, pos, len, foliop, minix_get_block);
> +	ret = block_write_begin(iocb, mapping, pos, len, foliop, minix_get_block);
>  	if (unlikely(ret))
>  		minix_write_failed(mapping, pos + len);
>  
> diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
> index 51bde45d5865..d9d57eeecc5d 100644
> --- a/fs/nilfs2/inode.c
> +++ b/fs/nilfs2/inode.c
> @@ -230,7 +230,7 @@ static int nilfs_write_begin(const struct kiocb *iocb,
>  	if (unlikely(err))
>  		return err;
>  
> -	err = block_write_begin(mapping, pos, len, foliop, nilfs_get_block);
> +	err = block_write_begin(iocb, mapping, pos, len, foliop, nilfs_get_block);
>  	if (unlikely(err)) {
>  		nilfs_write_failed(mapping, pos + len);
>  		nilfs_transaction_abort(inode->i_sb);
> diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
> index a9c61d0492cb..2f5fe44bf736 100644
> --- a/fs/nilfs2/recovery.c
> +++ b/fs/nilfs2/recovery.c
> @@ -541,7 +541,7 @@ static int nilfs_recover_dsync_blocks(struct the_nilfs *nilfs,
>  		}
>  
>  		pos = rb->blkoff << inode->i_blkbits;
> -		err = block_write_begin(inode->i_mapping, pos, blocksize,
> +		err = block_write_begin(NULL, inode->i_mapping, pos, blocksize,
>  					&folio, nilfs_get_block);
>  		if (unlikely(err)) {
>  			loff_t isize = inode->i_size;
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index 0a9ac5efeb67..8c788feb319e 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -966,7 +966,7 @@ int ntfs_write_begin(const struct kiocb *iocb, struct address_space *mapping,
>  			goto out;
>  	}
>  
> -	err = block_write_begin(mapping, pos, len, foliop,
> +	err = block_write_begin(iocb, mapping, pos, len, foliop,
>  				ntfs_get_block_write_begin);
>  
>  out:
> diff --git a/fs/omfs/file.c b/fs/omfs/file.c
> index 49a1de5a827f..3bade632e36e 100644
> --- a/fs/omfs/file.c
> +++ b/fs/omfs/file.c
> @@ -317,7 +317,7 @@ static int omfs_write_begin(const struct kiocb *iocb,
>  {
>  	int ret;
>  
> -	ret = block_write_begin(mapping, pos, len, foliop, omfs_get_block);
> +	ret = block_write_begin(iocb, mapping, pos, len, foliop, omfs_get_block);
>  	if (unlikely(ret))
>  		omfs_write_failed(mapping, pos + len);
>  
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index 7fae8002344a..aec9cdc938be 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -259,7 +259,7 @@ static int udf_write_begin(const struct kiocb *iocb,
>  	int ret;
>  
>  	if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
> -		ret = block_write_begin(mapping, pos, len, foliop,
> +		ret = block_write_begin(iocb, mapping, pos, len, foliop,
>  					udf_get_block);
>  		if (unlikely(ret))
>  			udf_write_failed(mapping, pos + len);
> diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
> index e2b0a35de2a7..dfba985265a8 100644
> --- a/fs/ufs/inode.c
> +++ b/fs/ufs/inode.c
> @@ -481,7 +481,7 @@ static int ufs_write_begin(const struct kiocb *iocb,
>  {
>  	int ret;
>  
> -	ret = block_write_begin(mapping, pos, len, foliop, ufs_getfrag_block);
> +	ret = block_write_begin(iocb, mapping, pos, len, foliop, ufs_getfrag_block);
>  	if (unlikely(ret))
>  		ufs_write_failed(mapping, pos + len);
>  
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index b16b88bfbc3e..4b07dec5f8eb 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -258,8 +258,9 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
>  		get_block_t *get_block, struct writeback_control *wbc);
>  int block_read_full_folio(struct folio *, get_block_t *);
>  bool block_is_partially_uptodate(struct folio *, size_t from, size_t count);
> -int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
> -		struct folio **foliop, get_block_t *get_block);
> +int block_write_begin(const struct kiocb *iocb, struct address_space *mapping,
> +		loff_t pos, unsigned len, struct folio **foliop,
> +		get_block_t *get_block);
>  int __block_write_begin(struct folio *folio, loff_t pos, unsigned len,
>  		get_block_t *get_block);
>  int block_write_end(loff_t pos, unsigned len, unsigned copied, struct folio *);
> 
> ---
> base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
> change-id: 20260218-blk-dontcache-338133dd045e
> 
> Best regards,
> -- 
> Tal Zussman <tz2294@columbia.edu>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

