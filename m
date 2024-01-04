Return-Path: <linux-fsdevel+bounces-7362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C576824198
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 13:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CA28B21633
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 12:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA0921A03;
	Thu,  4 Jan 2024 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XFc8VLBs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BRLIxIrq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dWaipx2c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VFhD00b5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3FC21361;
	Thu,  4 Jan 2024 12:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C3FE921D3A;
	Thu,  4 Jan 2024 12:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704370935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dEOhbl6BxUdU6y2PPLv5OY3ZqGBD0PFejfclreExChI=;
	b=XFc8VLBsnl9aL7k3OjwpBjEyurAPHn/wozw7huEJg8Kh1XtexFXGnCOFrF5cdJObzIoVOB
	WSl0qwfGcHDQRAYaR70hDrxP5dEBoB1H4OgNdM9BCSFoyD0dNvFgWPJz8qJrVSt4tKq5qM
	SM0EzBf8FjQO8tP69JsU/iZJsUbAZBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704370935;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dEOhbl6BxUdU6y2PPLv5OY3ZqGBD0PFejfclreExChI=;
	b=BRLIxIrqPa8P6c1xZvwUjFY/XF/4q/Hh7Fr9qUPo3HG8bI8kuWp+Geq4NwDCe18M+n1X29
	u6rW+t5czthqMXCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704370934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dEOhbl6BxUdU6y2PPLv5OY3ZqGBD0PFejfclreExChI=;
	b=dWaipx2c9mtfXsouDbDbhmlJanWKJIihT+c3mI9H4+BEJ9hmUZtaN5Uu4ae2qTdtLH7xKW
	DDYet+i2/F2cAa+agkhhbr3Cv4olBkJ/pv8A4qgM43c2v3EY3PHpUBczoq93IpuUDz4twc
	YFhcZIKVsPkTvaHSTOYEQ6iZivXOeek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704370934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dEOhbl6BxUdU6y2PPLv5OY3ZqGBD0PFejfclreExChI=;
	b=VFhD00b5yP8kUic6tuTXvk6P7y+b439KNlXOG1em78AjaLBeb4nyWpSfko2ONapIBWJ8nM
	q4ULVr0ImRgl9xDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A408A137E8;
	Thu,  4 Jan 2024 12:22:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aIvDJ/ailmWuFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jan 2024 12:22:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 12451A07EF; Thu,  4 Jan 2024 13:22:14 +0100 (CET)
Date: Thu, 4 Jan 2024 13:22:14 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, roger.pau@citrix.com, colyli@suse.de,
	kent.overstreet@gmail.com, joern@lazybastard.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	nico@fluxnic.net, xiang@kernel.org, chao@kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.com, konishi.ryusuke@gmail.com,
	willy@infradead.org, akpm@linux-foundation.org, hare@suse.de,
	p.raghav@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-nilfs@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC v3 for-6.8/block 14/17] buffer: add a new helper to
 read sb block
Message-ID: <20240104122214.jndsqygnmljxmj5d@quack3>
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
 <20231221085853.1770062-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221085853.1770062-1-yukuai1@huaweicloud.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.31 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLhr85cyeg3mfw7iggddtjdkgs)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[99.99%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[48];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.dk,citrix.com,suse.de,gmail.com,lazybastard.org,bootlin.com,nod.at,ti.com,linux.ibm.com,oracle.com,fb.com,toxicpanda.com,suse.com,zeniv.linux.org.uk,kernel.org,fluxnic.net,mit.edu,dilger.ca,infradead.org,linux-foundation.org,samsung.com,vger.kernel.org,lists.xenproject.org,lists.infradead.org,lists.ozlabs.org,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dWaipx2c;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VFhD00b5
X-Spam-Score: -1.31
X-Rspamd-Queue-Id: C3FE921D3A

On Thu 21-12-23 16:58:53, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Unlike __bread_gfp(), ext4 has special handing while reading sb block:
> 
> 1) __GFP_NOFAIL is not set, and memory allocation can fail;
> 2) If buffer write failed before, set buffer uptodate and don't read
>    block from disk;
> 3) REQ_META is set for all IO, and REQ_PRIO is set for reading xattr;
> 4) If failed, return error ptr instead of NULL;
> 
> This patch add a new helper __bread_gfp2() that will match above 2 and 3(
> 1 will be used, and 4 will still be encapsulated by ext4), and prepare to
> prevent calling mapping_gfp_constraint() directly on bd_inode->i_mapping
> in ext4.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

I'm not enthusiastic about this but I guess it is as good as it gets
without larger cleanups in this area. So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c                 | 68 ++++++++++++++++++++++++++-----------
>  include/linux/buffer_head.h | 18 +++++++++-
>  2 files changed, 65 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 967f34b70aa8..188bd36c9fea 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1255,16 +1255,19 @@ void __bforget(struct buffer_head *bh)
>  }
>  EXPORT_SYMBOL(__bforget);
>  
> -static struct buffer_head *__bread_slow(struct buffer_head *bh)
> +static struct buffer_head *__bread_slow(struct buffer_head *bh,
> +					blk_opf_t op_flags,
> +					bool check_write_error)
>  {
>  	lock_buffer(bh);
> -	if (buffer_uptodate(bh)) {
> +	if (buffer_uptodate(bh) ||
> +	    (check_write_error && buffer_uptodate_or_error(bh))) {
>  		unlock_buffer(bh);
>  		return bh;
>  	} else {
>  		get_bh(bh);
>  		bh->b_end_io = end_buffer_read_sync;
> -		submit_bh(REQ_OP_READ, bh);
> +		submit_bh(REQ_OP_READ | op_flags, bh);
>  		wait_on_buffer(bh);
>  		if (buffer_uptodate(bh))
>  			return bh;
> @@ -1445,6 +1448,31 @@ void __breadahead(struct block_device *bdev, sector_t block, unsigned size)
>  }
>  EXPORT_SYMBOL(__breadahead);
>  
> +static struct buffer_head *
> +bread_gfp(struct block_device *bdev, sector_t block, unsigned int size,
> +	  blk_opf_t op_flags, gfp_t gfp, bool check_write_error)
> +{
> +	struct buffer_head *bh;
> +
> +	gfp |= mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
> +
> +	/*
> +	 * Prefer looping in the allocator rather than here, at least that
> +	 * code knows what it's doing.
> +	 */
> +	gfp |= __GFP_NOFAIL;
> +
> +	bh = bdev_getblk(bdev, block, size, gfp);
> +	if (unlikely(!bh))
> +		return NULL;
> +
> +	if (buffer_uptodate(bh) ||
> +	    (check_write_error && buffer_uptodate_or_error(bh)))
> +		return bh;
> +
> +	return __bread_slow(bh, op_flags, check_write_error);
> +}
> +
>  /**
>   *  __bread_gfp() - reads a specified block and returns the bh
>   *  @bdev: the block_device to read from
> @@ -1458,27 +1486,27 @@ EXPORT_SYMBOL(__breadahead);
>   *  It returns NULL if the block was unreadable.
>   */
>  struct buffer_head *
> -__bread_gfp(struct block_device *bdev, sector_t block,
> -		   unsigned size, gfp_t gfp)
> +__bread_gfp(struct block_device *bdev, sector_t block, unsigned int size,
> +	    gfp_t gfp)
>  {
> -	struct buffer_head *bh;
> -
> -	gfp |= mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
> -
> -	/*
> -	 * Prefer looping in the allocator rather than here, at least that
> -	 * code knows what it's doing.
> -	 */
> -	gfp |= __GFP_NOFAIL;
> -
> -	bh = bdev_getblk(bdev, block, size, gfp);
> -
> -	if (likely(bh) && !buffer_uptodate(bh))
> -		bh = __bread_slow(bh);
> -	return bh;
> +	return bread_gfp(bdev, block, size, 0, gfp, false);
>  }
>  EXPORT_SYMBOL(__bread_gfp);
>  
> +/*
> + * This works like __bread_gfp() except:
> + * 1) If buffer write failed before, set buffer uptodate and don't read
> + * block from disk;
> + * 2) Caller can pass in additional op_flags like REQ_META;
> + */
> +struct buffer_head *
> +__bread_gfp2(struct block_device *bdev, sector_t block, unsigned int size,
> +	     blk_opf_t op_flags, gfp_t gfp)
> +{
> +	return bread_gfp(bdev, block, size, op_flags, gfp, true);
> +}
> +EXPORT_SYMBOL(__bread_gfp2);
> +
>  static void __invalidate_bh_lrus(struct bh_lru *b)
>  {
>  	int i;
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 5f23ee599889..751b2744b4ae 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -171,6 +171,18 @@ static __always_inline int buffer_uptodate(const struct buffer_head *bh)
>  	return test_bit_acquire(BH_Uptodate, &bh->b_state);
>  }
>  
> +static __always_inline int buffer_uptodate_or_error(struct buffer_head *bh)
> +{
> +	/*
> +	 * If the buffer has the write error flag, data was failed to write
> +	 * out in the block. In this case, set buffer uptodate to prevent
> +	 * reading old data.
> +	 */
> +	if (buffer_write_io_error(bh))
> +		set_buffer_uptodate(bh);
> +	return buffer_uptodate(bh);
> +}
> +
>  static inline unsigned long bh_offset(const struct buffer_head *bh)
>  {
>  	return (unsigned long)(bh)->b_data & (page_size(bh->b_page) - 1);
> @@ -231,7 +243,11 @@ void __brelse(struct buffer_head *);
>  void __bforget(struct buffer_head *);
>  void __breadahead(struct block_device *, sector_t block, unsigned int size);
>  struct buffer_head *__bread_gfp(struct block_device *,
> -				sector_t block, unsigned size, gfp_t gfp);
> +				sector_t block, unsigned int size, gfp_t gfp);
> +struct buffer_head *__bread_gfp2(struct block_device *bdev, sector_t block,
> +				 unsigned int size, blk_opf_t op_flags,
> +				 gfp_t gfp);
> +
>  struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
>  void free_buffer_head(struct buffer_head * bh);
>  void unlock_buffer(struct buffer_head *bh);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

