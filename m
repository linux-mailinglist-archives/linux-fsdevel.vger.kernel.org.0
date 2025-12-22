Return-Path: <linux-fsdevel+bounces-71829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3012BCD687C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 16:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D64EC3011B28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 15:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB57132E146;
	Mon, 22 Dec 2025 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zw7sO8ES";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EFxgzX7N";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dj/ljclW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CbZ/HmJl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6DF32D7F9
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766417428; cv=none; b=besBE/hFQxjsGhw4oxmh5mRwjeTY+1zdr3Q2wCbon/c++UBjiL8y+PRhcz3QcDgQ15stIFOEDf3hX5+XSYdJOmra2dYUuSUk9bf+LJ0GR/AjHis466iTDB9H4L4A7N6iJ7p39WwDyOFUi2m6kdn29DPVQtZiRYx9TbMyGxwNtWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766417428; c=relaxed/simple;
	bh=XnN6EflEKp/eYb58YH9xHCz8rnekR7GFnKf0c/4uQok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OS5CqsW7ifBeEe/g+b/3KzOpIroLVbD9WpUys9L5rKHpw2e8Xu79JHn0wtmduiZcGJz3DZzIw4wKnoL2siEYmnWHN1vePIX0v1rzwl5tfFXpHz3pwNytCb8PyRiPbJV7jbCak5zPjAc6PKSaXgGxTCw90vg0j0/MbK6JbeSmf5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zw7sO8ES; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EFxgzX7N; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dj/ljclW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CbZ/HmJl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 048085BCDA;
	Mon, 22 Dec 2025 15:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766417421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FgRC0OwhbptUyq8wymRkGUMEXCjSvB4yp4BzwrBvNz8=;
	b=zw7sO8ESADioDfSMkN8+AsySezgi6aGGerhUiaw9ybQ0m4gEspw+L0gSKFhUB//sIsZXah
	8BLqlifQ2QfTo77Cr+jYeVpSTzOiHqZ6IXOC/qswcbDlrEig33QM9xn4HSwjTf7IqwtoS3
	HFcMPbCxFZnWhP038+6FmFV2VKcPMyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766417421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FgRC0OwhbptUyq8wymRkGUMEXCjSvB4yp4BzwrBvNz8=;
	b=EFxgzX7NDTqU/yHq5YL9K5WYzZj12T0ErSGUntAGwMfpE+XQWY97iIVQc9mrPTYE7Vxjqz
	lkC1u9imoprocyAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Dj/ljclW";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="CbZ/HmJl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766417420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FgRC0OwhbptUyq8wymRkGUMEXCjSvB4yp4BzwrBvNz8=;
	b=Dj/ljclWUg3sBmMFJebCqxK21aFOVBSE5lxgNPSufGdu1y54CcW3zRN6pfdRPbEchTbbzM
	LJzH74Zu+5RmGBbsKgtz1F/myQDqMySCfkHPbHgLT4L0WqrCqqNKhZod1lrkcyYgLLUOK0
	PsSQ/IrLZaXe3avxfhNEldFwLcyzNBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766417420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FgRC0OwhbptUyq8wymRkGUMEXCjSvB4yp4BzwrBvNz8=;
	b=CbZ/HmJl95jxOHM6pzRZ8922NiiVMCrQ5BGM6A6qHnQ3lDXaKnTCB6txLu0Be69nUrHwft
	dOovP+bFtL0IIRCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB1551364B;
	Mon, 22 Dec 2025 15:30:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q1pdOQtkSWl/DQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Dec 2025 15:30:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AFB15A09CB; Mon, 22 Dec 2025 16:30:19 +0100 (CET)
Date: Mon, 22 Dec 2025 16:30:19 +0100
From: Jan Kara <jack@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, linux-ext4@vger.kernel.org, jack@suse.cz, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, gabriel@krisman.be, hch@lst.de, 
	amir73il@gmail.com
Subject: Re: [PATCH 3/6] iomap: report file I/O errors to the VFS
Message-ID: <r2gurwreel7vcr3pkyq3axn7qotvz32qnwcrm4rrhkkqg3xtrl@qjldvkhr4epo>
References: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
 <176602332192.686273.7145566076281990940.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176602332192.686273.7145566076281990940.stgit@frogsfrogsfrogs>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 048085BCDA
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
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,suse.cz,krisman.be,lst.de,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Wed 17-12-25 18:03:27, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Wire up iomap so that it reports all file read and write errors to the
> VFS (and hence fsnotify) via the new fserror mechanism.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/iomap/buffered-io.c |   23 ++++++++++++++++++++++-
>  fs/iomap/direct-io.c   |   12 ++++++++++++
>  fs/iomap/ioend.c       |    6 ++++++
>  3 files changed, 40 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e5c1ca440d93bd..b21e989b9fa5e6 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -8,6 +8,7 @@
>  #include <linux/writeback.h>
>  #include <linux/swap.h>
>  #include <linux/migrate.h>
> +#include <linux/fserror.h>
>  #include "internal.h"
>  #include "trace.h"
>  
> @@ -371,8 +372,11 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
>  	if (folio_test_uptodate(folio))
>  		return 0;
>  
> -	if (WARN_ON_ONCE(size > iomap->length))
> +	if (WARN_ON_ONCE(size > iomap->length)) {
> +		fserror_report_io(iter->inode, FSERR_BUFFERED_READ,
> +				  iomap->offset, size, -EIO, GFP_NOFS);
>  		return -EIO;
> +	}
>  	if (offset > 0)
>  		ifs_alloc(iter->inode, folio, iter->flags);
>  
> @@ -399,6 +403,11 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
>  		spin_unlock_irqrestore(&ifs->state_lock, flags);
>  	}
>  
> +	if (error)
> +		fserror_report_io(folio->mapping->host, FSERR_BUFFERED_READ,
> +				  folio_pos(folio) + off, len, error,
> +				  GFP_ATOMIC);
> +
>  	if (finished)
>  		folio_end_read(folio, uptodate);
>  }
> @@ -540,6 +549,10 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
>  			if (!*bytes_submitted)
>  				iomap_read_init(folio);
>  			ret = ctx->ops->read_folio_range(iter, ctx, plen);
> +			if (ret < 0)
> +				fserror_report_io(iter->inode,
> +						  FSERR_BUFFERED_READ, pos,
> +						  plen, ret, GFP_NOFS);
>  			if (ret)
>  				return ret;
>  			*bytes_submitted += plen;
> @@ -815,6 +828,10 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
>  			else
>  				status = iomap_bio_read_folio_range_sync(iter,
>  						folio, block_start, plen);
> +			if (status < 0)
> +				fserror_report_io(iter->inode,
> +						  FSERR_BUFFERED_READ, pos,
> +						  len, status, GFP_NOFS);
>  			if (status)
>  				return status;
>  		}
> @@ -1805,6 +1822,7 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
>  	u64 pos = folio_pos(folio);
>  	u64 end_pos = pos + folio_size(folio);
>  	u64 end_aligned = 0;
> +	loff_t orig_pos = pos;
>  	size_t bytes_submitted = 0;
>  	int error = 0;
>  	u32 rlen;
> @@ -1848,6 +1866,9 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
>  
>  	if (bytes_submitted)
>  		wpc->nr_folios++;
> +	if (error && pos > orig_pos)
> +		fserror_report_io(inode, FSERR_BUFFERED_WRITE, orig_pos, 0,
> +				  error, GFP_NOFS);
>  
>  	/*
>  	 * We can have dirty bits set past end of file in page_mkwrite path
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 8e273408453a9c..a06c73eaa8901b 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -7,6 +7,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/iomap.h>
>  #include <linux/task_io_accounting_ops.h>
> +#include <linux/fserror.h>
>  #include "internal.h"
>  #include "trace.h"
>  
> @@ -78,6 +79,13 @@ static void iomap_dio_submit_bio(const struct iomap_iter *iter,
>  	}
>  }
>  
> +static inline enum fserror_type iomap_dio_err_type(const struct iomap_dio *dio)
> +{
> +	if (dio->flags & IOMAP_DIO_WRITE)
> +		return FSERR_DIRECTIO_WRITE;
> +	return FSERR_DIRECTIO_READ;
> +}
> +
>  ssize_t iomap_dio_complete(struct iomap_dio *dio)
>  {
>  	const struct iomap_dio_ops *dops = dio->dops;
> @@ -87,6 +95,10 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
>  
>  	if (dops && dops->end_io)
>  		ret = dops->end_io(iocb, dio->size, ret, dio->flags);
> +	if (dio->error)
> +		fserror_report_io(file_inode(iocb->ki_filp),
> +				  iomap_dio_err_type(dio), offset, dio->size,
> +				  dio->error, GFP_NOFS);
>  
>  	if (likely(!ret)) {
>  		ret = dio->size;
> diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
> index 86f44922ed3b6a..5b27ee98896707 100644
> --- a/fs/iomap/ioend.c
> +++ b/fs/iomap/ioend.c
> @@ -6,6 +6,7 @@
>  #include <linux/list_sort.h>
>  #include <linux/pagemap.h>
>  #include <linux/writeback.h>
> +#include <linux/fserror.h>
>  #include "internal.h"
>  #include "trace.h"
>  
> @@ -55,6 +56,11 @@ static u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
>  
>  	/* walk all folios in bio, ending page IO on them */
>  	bio_for_each_folio_all(fi, bio) {
> +		if (ioend->io_error)
> +			fserror_report_io(inode, FSERR_BUFFERED_WRITE,
> +					  folio_pos(fi.folio) + fi.offset,
> +					  fi.length, ioend->io_error,
> +					  GFP_ATOMIC);
>  		iomap_finish_folio_write(inode, fi.folio, fi.length);
>  		folio_count++;
>  	}
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

