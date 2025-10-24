Return-Path: <linux-fsdevel+bounces-65514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8287AC06303
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 14:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E8D47344C89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 12:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCDA3148D3;
	Fri, 24 Oct 2025 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CjojHoYq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1acUFfy3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CjojHoYq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1acUFfy3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6273302CD6
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761308003; cv=none; b=ZbSDHkFabzhMgVqe8B3Z8wyw/Cn+Iq3EFYC9Pi/UQXAixQWmP/yvdt5N4q8oga6mWMP5PNpWCWqrKztNWowLhB5x77j1otLbGswWguBkR+Xwdt9lhQCZSCUT2qFP+CzNPn8T1rcILKz+1G5XC6NkHNRl3D+jHSwTd4ZTNBBhm6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761308003; c=relaxed/simple;
	bh=i0EfOjInC/aJdda6sojezLSbi8o9QQmIbE3cti/JV8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=di/tIjQE1Bs1zi68S1NsMnZEkyRvCK2+DaFYiynBAVAXnl0wdgPhUXae0n8PnOTSAG2nPbkEByDTuDNGMKV6cKZpPJSUDFXXImffzfKxhzsusSKmPZdOyUTkMTIxB7RT62SJDHI7S5MmHfsaXlSCZljWmmrHF9iRvLqDtcPUbeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CjojHoYq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1acUFfy3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CjojHoYq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1acUFfy3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46D6C2120A;
	Fri, 24 Oct 2025 12:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761308000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AkVO73khQEXexPsxQT0RVGnJrziAwGHpdDpx2ltyfZ0=;
	b=CjojHoYqaGMzfr5XqNusQqu1GyDxPy0hnR6Ldj+jMf2eYrTAdI2alMTnKoUSmrXoHvFzyY
	UToaifYK+aQl8TtK32yOMGz7StJr1kY/XFCLmL8yl3rGsIxvYxpuaYXr9RvWQe45kcVwON
	5/tuFmNtP0/OwY0IBwV80drSEDaabHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761308000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AkVO73khQEXexPsxQT0RVGnJrziAwGHpdDpx2ltyfZ0=;
	b=1acUFfy3hGwnqk5XZUYklOyZE7Yzi46EVBZ/g+PJSSiLxPnydp7ewriPn0sf5iaWyR9gF9
	M2aK7AndCIkzA5Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761308000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AkVO73khQEXexPsxQT0RVGnJrziAwGHpdDpx2ltyfZ0=;
	b=CjojHoYqaGMzfr5XqNusQqu1GyDxPy0hnR6Ldj+jMf2eYrTAdI2alMTnKoUSmrXoHvFzyY
	UToaifYK+aQl8TtK32yOMGz7StJr1kY/XFCLmL8yl3rGsIxvYxpuaYXr9RvWQe45kcVwON
	5/tuFmNtP0/OwY0IBwV80drSEDaabHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761308000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AkVO73khQEXexPsxQT0RVGnJrziAwGHpdDpx2ltyfZ0=;
	b=1acUFfy3hGwnqk5XZUYklOyZE7Yzi46EVBZ/g+PJSSiLxPnydp7ewriPn0sf5iaWyR9gF9
	M2aK7AndCIkzA5Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 301D713693;
	Fri, 24 Oct 2025 12:13:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Mwu+C2Bt+2jXOQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 24 Oct 2025 12:13:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3BF23A28AB; Fri, 24 Oct 2025 14:13:19 +0200 (CEST)
Date: Fri, 24 Oct 2025 14:13:19 +0200
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
Subject: Re: [PATCH 10/10] mm: rename filemap_fdatawrite_range_kick to
 filemap_flush_range
Message-ID: <yybiur2jmv6s4n2sjlubwimmfbsrb3gx6tk67ki23jnqncaeba@wayirnpbaum3>
References: <20251024080431.324236-1-hch@lst.de>
 <20251024080431.324236-11-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024080431.324236-11-hch@lst.de>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Fri 24-10-25 10:04:21, Christoph Hellwig wrote:
> Rename filemap_fdatawrite_range_kick to filemap_flush_range because it
> is the ranged version of filemap_flush.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/sync.c          | 3 +--
>  include/linux/fs.h | 6 +++---
>  mm/fadvise.c       | 2 +-
>  mm/filemap.c       | 8 ++++----
>  4 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/sync.c b/fs/sync.c
> index 6d8b04e04c3c..1759f6ba36cd 100644
> --- a/fs/sync.c
> +++ b/fs/sync.c
> @@ -285,8 +285,7 @@ int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
>  			ret = filemap_fdatawrite_range(mapping, offset,
>  					endbyte);
>  		else
> -			ret = filemap_fdatawrite_range_kick(mapping, offset,
> -					endbyte);
> +			ret = filemap_flush_range(mapping, offset, endbyte);
>  		if (ret < 0)
>  			goto out;
>  	}
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c895146c1444..a5dbfa20f8d7 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3014,7 +3014,7 @@ extern int __must_check file_fdatawait_range(struct file *file, loff_t lstart,
>  extern int __must_check file_check_and_advance_wb_err(struct file *file);
>  extern int __must_check file_write_and_wait_range(struct file *file,
>  						loff_t start, loff_t end);
> -int filemap_fdatawrite_range_kick(struct address_space *mapping, loff_t start,
> +int filemap_flush_range(struct address_space *mapping, loff_t start,
>  		loff_t end);
>  
>  static inline int file_write_and_wait(struct file *file)
> @@ -3051,8 +3051,8 @@ static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
>  	} else if (iocb->ki_flags & IOCB_DONTCACHE) {
>  		struct address_space *mapping = iocb->ki_filp->f_mapping;
>  
> -		filemap_fdatawrite_range_kick(mapping, iocb->ki_pos - count,
> -					      iocb->ki_pos - 1);
> +		filemap_flush_range(mapping, iocb->ki_pos - count,
> +				iocb->ki_pos - 1);
>  	}
>  
>  	return count;
> diff --git a/mm/fadvise.c b/mm/fadvise.c
> index f1be619f0e58..67028e30aa91 100644
> --- a/mm/fadvise.c
> +++ b/mm/fadvise.c
> @@ -111,7 +111,7 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
>  		spin_unlock(&file->f_lock);
>  		break;
>  	case POSIX_FADV_DONTNEED:
> -		filemap_fdatawrite_range_kick(mapping, offset, endbyte);
> +		filemap_flush_range(mapping, offset, endbyte);
>  
>  		/*
>  		 * First and last FULL page! Partial pages are deliberately
> diff --git a/mm/filemap.c b/mm/filemap.c
> index f90f5bb2b825..fa770768ea3a 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -419,7 +419,7 @@ int filemap_fdatawrite(struct address_space *mapping)
>  EXPORT_SYMBOL(filemap_fdatawrite);
>  
>  /**
> - * filemap_fdatawrite_range_kick - start writeback on a range
> + * filemap_flush_range - start writeback on a range
>   * @mapping:	target address_space
>   * @start:	index to start writeback on
>   * @end:	last (inclusive) index for writeback
> @@ -429,12 +429,12 @@ EXPORT_SYMBOL(filemap_fdatawrite);
>   *
>   * Return: %0 on success, negative error code otherwise.
>   */
> -int filemap_fdatawrite_range_kick(struct address_space *mapping, loff_t start,
> +int filemap_flush_range(struct address_space *mapping, loff_t start,
>  				  loff_t end)
>  {
>  	return filemap_writeback(mapping, start, end, WB_SYNC_NONE, NULL);
>  }
> -EXPORT_SYMBOL_GPL(filemap_fdatawrite_range_kick);
> +EXPORT_SYMBOL_GPL(filemap_flush_range);
>  
>  /**
>   * filemap_flush - mostly a non-blocking flush
> @@ -447,7 +447,7 @@ EXPORT_SYMBOL_GPL(filemap_fdatawrite_range_kick);
>   */
>  int filemap_flush(struct address_space *mapping)
>  {
> -	return filemap_fdatawrite_range_kick(mapping, 0, LLONG_MAX);
> +	return filemap_flush_range(mapping, 0, LLONG_MAX);
>  }
>  EXPORT_SYMBOL(filemap_flush);
>  
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

