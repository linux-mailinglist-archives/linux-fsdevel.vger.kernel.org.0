Return-Path: <linux-fsdevel+bounces-63954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A98BD2E58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 14:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53233AD44C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 12:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A74D26A0EB;
	Mon, 13 Oct 2025 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I6Tu6QEx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F5tMp6sH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b+bmMbsY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uZgagJZ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C462C267B12
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760357009; cv=none; b=aZZt/JrMuGeuiElbPqiy6aMdXi8LCI9S/dDh6Mln5HftOr1Qms+7NvrRHGj0iPrwIEvXWg1JDxNAgLhKohrWpB1b9FUDrjV0JdsuF9vF8xWdCYxtWY1Hcu9rkdkxRar8AJdFxSU1JNgE1wI/SYkxFoJjjTouOTwcLivkYJcMQyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760357009; c=relaxed/simple;
	bh=SBNCZHd+uoMeL3cSjM2rSAqlxELA4n9e4egR4+2G0fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1+MGh1RNOExgJc+cBV4OXBP/JFaL9ddNuTNnVaxKXAOdn3iKMH/R2Kdd6fet8YrqmSvh2E+RTXJZ7BgMQ9z0XKLzP7HVfdQnQ/5Wv6O+CxaUhOsFP1rwowSYcMzJuiYDS2j2bhYqv6nGzi9hgiF2nkl6PDxQPAhJZW6diWa8Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I6Tu6QEx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F5tMp6sH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b+bmMbsY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uZgagJZ4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53E081F385;
	Mon, 13 Oct 2025 12:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760357005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gxSdY8AEzXNttMyqmikG4KICkG68sQmVXDungx9myyE=;
	b=I6Tu6QExFV+dBebEO5FqWa4CnC/ZtZN0xOyEGAncmWdGoa0IVFsax7N9267RYZWCI4yDAe
	BFW3FdZz+2JOTd98CT1+hWculdJYDQ4LNt3cLfzcA4cAZIcrGHgW7En1dyBj0473RkMG9T
	OUcuSbJaN4bH1iJ36A29HSmcMeKxvDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760357005;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gxSdY8AEzXNttMyqmikG4KICkG68sQmVXDungx9myyE=;
	b=F5tMp6sHebc1bFNq3o1qlBgdw7WXSa0vxFWNhLozJ6p13Cc8QTGnffMoJWdwcUfP+UgWDy
	WJo390eCPwLnUVDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760357004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gxSdY8AEzXNttMyqmikG4KICkG68sQmVXDungx9myyE=;
	b=b+bmMbsYtdbqriqZU30MLE3rigTOge9VFILpR3ZAxAIp87aWzR0HZf5iXLy3Qmlc7o6ht4
	iBQVFePWgwKhRReC07vwR6ym9gJe2q+JZ+tpStLqlpxQvsC3xZPYxQhmVE3Yls+FXyCsJC
	G2vN2Sg2zwqFIUtoWSVWz9su12YR4E0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760357004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gxSdY8AEzXNttMyqmikG4KICkG68sQmVXDungx9myyE=;
	b=uZgagJZ4MaG1boq9mL70Dd8Oh/MLQG+tSddPXnq7M9Ii3bXEdvfa5li/T/T78DRLB8vpiJ
	ZCtWGQBAtDwPq6DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4362513874;
	Mon, 13 Oct 2025 12:03:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TKZxEIzq7GgcBwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 Oct 2025 12:03:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EBC7BA0A58; Mon, 13 Oct 2025 14:03:15 +0200 (CEST)
Date: Mon, 13 Oct 2025 14:03:15 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 09/10] mm: remove __filemap_fdatawrite_range
Message-ID: <ggj5mx662pc6557zthvqfbzcjzbltjntvf5ly5bj3czeof6ute@r3cjumpx3gtp>
References: <20251013025808.4111128-1-hch@lst.de>
 <20251013025808.4111128-10-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013025808.4111128-10-hch@lst.de>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Mon 13-10-25 11:58:04, Christoph Hellwig wrote:
> Use filemap_fdatawrite_range and filemap_fdatawrite_range_kick instead
> of the low-level __filemap_fdatawrite_range that requires the caller
> to know the internals of the writeback_control structure and remove
> __filemap_fdatawrite_range now that it is trivial and only two callers
> would be left.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c       |  6 +++---
>  fs/sync.c               | 11 +++++------
>  include/linux/pagemap.h |  2 --
>  mm/fadvise.c            |  3 +--
>  mm/filemap.c            | 25 +++++++------------------
>  5 files changed, 16 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 2b35e80037fe..8b002ab18103 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -807,9 +807,9 @@ static void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
>   * @wbc: writeback_control of interest
>   * @inode: target inode
>   *
> - * This function is to be used by __filemap_fdatawrite_range(), which is an
> - * alternative entry point into writeback code, and first ensures @inode is
> - * associated with a bdi_writeback and attaches it to @wbc.
> + * This function is to be used by filemap_fdatawrite*(), which write back data
> + * from arbitrary threads instead of the main writeback thread to ensure @inode
> + * is associated with a bdi_writeback and attached to @wbc.
>   */
>  void wbc_attach_fdatawrite_inode(struct writeback_control *wbc,
>  		struct inode *inode)
> diff --git a/fs/sync.c b/fs/sync.c
> index 2955cd4c77a3..6d8b04e04c3c 100644
> --- a/fs/sync.c
> +++ b/fs/sync.c
> @@ -280,14 +280,13 @@ int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
>  	}
>  
>  	if (flags & SYNC_FILE_RANGE_WRITE) {
> -		int sync_mode = WB_SYNC_NONE;
> -
>  		if ((flags & SYNC_FILE_RANGE_WRITE_AND_WAIT) ==
>  			     SYNC_FILE_RANGE_WRITE_AND_WAIT)
> -			sync_mode = WB_SYNC_ALL;
> -
> -		ret = __filemap_fdatawrite_range(mapping, offset, endbyte,
> -						 sync_mode);
> +			ret = filemap_fdatawrite_range(mapping, offset,
> +					endbyte);
> +		else
> +			ret = filemap_fdatawrite_range_kick(mapping, offset,
> +					endbyte);
>  		if (ret < 0)
>  			goto out;
>  	}
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 742ba1dd3990..664f23f2330a 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -55,8 +55,6 @@ static inline int filemap_fdatawait(struct address_space *mapping)
>  bool filemap_range_has_page(struct address_space *, loff_t lstart, loff_t lend);
>  int filemap_write_and_wait_range(struct address_space *mapping,
>  		loff_t lstart, loff_t lend);
> -int __filemap_fdatawrite_range(struct address_space *mapping,
> -		loff_t start, loff_t end, int sync_mode);
>  int filemap_fdatawrite_range(struct address_space *mapping,
>  		loff_t start, loff_t end);
>  int filemap_check_errors(struct address_space *mapping);
> diff --git a/mm/fadvise.c b/mm/fadvise.c
> index 588fe76c5a14..f1be619f0e58 100644
> --- a/mm/fadvise.c
> +++ b/mm/fadvise.c
> @@ -111,8 +111,7 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
>  		spin_unlock(&file->f_lock);
>  		break;
>  	case POSIX_FADV_DONTNEED:
> -		__filemap_fdatawrite_range(mapping, offset, endbyte,
> -					   WB_SYNC_NONE);
> +		filemap_fdatawrite_range_kick(mapping, offset, endbyte);
>  
>  		/*
>  		 * First and last FULL page! Partial pages are deliberately
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 26b692dbf091..ec19ed127de2 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -392,32 +392,23 @@ static int __filemap_fdatawrite(struct address_space *mapping, loff_t start,
>  }
>  
>  /**
> - * __filemap_fdatawrite_range - start writeback on mapping dirty pages in range
> + * filemap_fdatawrite_range - start writeback on mapping dirty pages in range
>   * @mapping:	address space structure to write
>   * @start:	offset in bytes where the range starts
>   * @end:	offset in bytes where the range ends (inclusive)
> - * @sync_mode:	enable synchronous operation
>   *
>   * Start writeback against all of a mapping's dirty pages that lie
>   * within the byte offsets <start, end> inclusive.
>   *
> - * If sync_mode is WB_SYNC_ALL then this is a "data integrity" operation, as
> - * opposed to a regular memory cleansing writeback.  The difference between
> - * these two operations is that if a dirty page/buffer is encountered, it must
> - * be waited upon, and not just skipped over.
> + * This is a data integrity operation that waits upon dirty or in writeback
> + * pages.
>   *
>   * Return: %0 on success, negative error code otherwise.
>   */
> -int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
> -				loff_t end, int sync_mode)
> -{
> -	return __filemap_fdatawrite(mapping, start, end, sync_mode, NULL);
> -}
> -
>  int filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
>  		loff_t end)
>  {
> -	return __filemap_fdatawrite_range(mapping, start, end, WB_SYNC_ALL);
> +	return __filemap_fdatawrite(mapping, start, end, WB_SYNC_ALL, NULL);
>  }
>  EXPORT_SYMBOL(filemap_fdatawrite_range);
>  
> @@ -441,7 +432,7 @@ EXPORT_SYMBOL(filemap_fdatawrite);
>  int filemap_fdatawrite_range_kick(struct address_space *mapping, loff_t start,
>  				  loff_t end)
>  {
> -	return __filemap_fdatawrite_range(mapping, start, end, WB_SYNC_NONE);
> +	return __filemap_fdatawrite(mapping, start, end, WB_SYNC_NONE, NULL);
>  }
>  EXPORT_SYMBOL_GPL(filemap_fdatawrite_range_kick);
>  
> @@ -689,8 +680,7 @@ int filemap_write_and_wait_range(struct address_space *mapping,
>  		return 0;
>  
>  	if (mapping_needs_writeback(mapping)) {
> -		err = __filemap_fdatawrite_range(mapping, lstart, lend,
> -						 WB_SYNC_ALL);
> +		err = filemap_fdatawrite_range(mapping, lstart, lend);
>  		/*
>  		 * Even if the above returned error, the pages may be
>  		 * written partially (e.g. -ENOSPC), so we wait for it.
> @@ -792,8 +782,7 @@ int file_write_and_wait_range(struct file *file, loff_t lstart, loff_t lend)
>  		return 0;
>  
>  	if (mapping_needs_writeback(mapping)) {
> -		err = __filemap_fdatawrite_range(mapping, lstart, lend,
> -						 WB_SYNC_ALL);
> +		err = filemap_fdatawrite_range(mapping, lstart, lend);
>  		/* See comment of filemap_write_and_wait() */
>  		if (err != -EIO)
>  			__filemap_fdatawait_range(mapping, lstart, lend);
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

