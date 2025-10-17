Return-Path: <linux-fsdevel+bounces-64655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E3ABF00EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 10:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A77024EC7EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 08:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47AF2EFD86;
	Mon, 20 Oct 2025 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DdYKApdD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n4Wy5xVw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GHKE85tk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3qhiJutp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E0E2EDD60
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760950615; cv=none; b=gRpYzPg5WTUK2POsYZcuqm/NcQWD/OF3xMpYFzQ1xwHQoMj3HA3wm01UYyldxwL5VNLEL9b3Fod6vFxWTCeGZuZS//0qbYCCEPzk8NfS2xC9LtIF3mzOT4/vJ3QrK13ylUHDxTf6gDlkP80ykZTwIeunfAi++X0P4maPypimknc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760950615; c=relaxed/simple;
	bh=ZjQ9lNky0ExxIGzK/WsmMuznwRwWdqfruI0rLDwLalU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDKgdZ95Tt3zzEUOyON0rwfOAenXV9ZVpGfh220tUFaA3IoAvTAqxGzusfq8i8FvkzsH+ULoKUAOTCcY7/wF9VgWrm/G1jtsv9VR58J4c8QMxd9Cvfk93sBT9yrNMfYjIE1xm3wTy7IbF3BEshnaajjdpxb0zeEjbjCv/vqNJCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DdYKApdD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n4Wy5xVw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GHKE85tk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3qhiJutp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 86FB71F444;
	Mon, 20 Oct 2025 08:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760950607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L9AZMaKK0rdk8fT5XwsO7G/zuw8BvSzFoOAnxBhJsTQ=;
	b=DdYKApdDfIpRBsXSqpzR28p/+DQUgUl3yu851Qs7/8Z4wcGyp2HwG2iKgzlXoStKMh4ryJ
	K5RVfJdjEo/Vj7EcPVSQUmQ5nWVqqfWbsP3Jtpj0p/VW0jtbpuhdNrGJK2Bbm/iHN2hmLa
	98S4sY0L4n4g2lqmFoE2NUx0jcNoQmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760950607;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L9AZMaKK0rdk8fT5XwsO7G/zuw8BvSzFoOAnxBhJsTQ=;
	b=n4Wy5xVw9WIz/qKbAzcQfJ+qcHXVOg/zyt38h9GYR1j4XrT5obg+111FTeo5Ap/PfpdAZW
	v8TSAn8NELhE4/DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760950605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L9AZMaKK0rdk8fT5XwsO7G/zuw8BvSzFoOAnxBhJsTQ=;
	b=GHKE85tkGuIDq6RbXCkKZDCD4WC9qR4U2YzfJ216q6A9gV80TkDNGXiFuFOFXct5vRI8g4
	ytmgG08qKExpm5T8YZonTMGEt8e7THiDV9azeNM1gNc/ol730BEuZTzDNebgafD68L7iAR
	xOgnOar3ffsVvIkvK5xElf1iR2oBHI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760950605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L9AZMaKK0rdk8fT5XwsO7G/zuw8BvSzFoOAnxBhJsTQ=;
	b=3qhiJutp1ZB2ObiDRSjK0xA5dJ2lc0JyuG50HsVg3sDIXjgt8+J53+9Q0wSgg/7ejCGwbW
	zeW7YRwqtHC5IJAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C0AD13B12;
	Mon, 20 Oct 2025 08:56:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CKFhGkH59Wh3ZQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Oct 2025 08:56:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 37DBAA28E6; Fri, 17 Oct 2025 14:32:01 +0200 (CEST)
Date: Fri, 17 Oct 2025 14:32:01 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Carlos Maiolino <cem@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, 
	dlemoal@kernel.org, hans.holmberg@wdc.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/3] writeback: allow the file system to override
 MIN_WRITEBACK_PAGES
Message-ID: <4gadspfntp6jzjbxlb65jv5o2ilyj7kl2pe3qy75g4yoxo7dua@safke3mbqhk4>
References: <20251017034611.651385-1-hch@lst.de>
 <20251017034611.651385-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017034611.651385-3-hch@lst.de>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DATE_IN_PAST(1.00)[68];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLe6y5t7si135x3gwwf9ui113p)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On Fri 17-10-25 05:45:48, Christoph Hellwig wrote:
> The relatively low minimal writeback size of 4MiB means that written back
> inodes on rotational media are switched a lot.  Besides introducing
> additional seeks, this also can lead to extreme file fragmentation on
> zoned devices when a lot of files are cached relative to the available
> writeback bandwidth.
> 
> Add a superblock field that allows the file system to override the
> default size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c         | 14 +++++---------
>  fs/super.c                |  1 +
>  include/linux/fs.h        |  1 +
>  include/linux/writeback.h |  5 +++++
>  4 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 11fd08a0efb8..6d50b02cdab6 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -31,11 +31,6 @@
>  #include <linux/memcontrol.h>
>  #include "internal.h"
>  
> -/*
> - * 4MB minimal write chunk size
> - */
> -#define MIN_WRITEBACK_PAGES	(4096UL >> (PAGE_SHIFT - 10))
> -
>  /*
>   * Passed into wb_writeback(), essentially a subset of writeback_control
>   */
> @@ -1874,8 +1869,8 @@ static int writeback_single_inode(struct inode *inode,
>  	return ret;
>  }
>  
> -static long writeback_chunk_size(struct bdi_writeback *wb,
> -				 struct wb_writeback_work *work)
> +static long writeback_chunk_size(struct super_block *sb,
> +		struct bdi_writeback *wb, struct wb_writeback_work *work)
>  {
>  	long pages;
>  
> @@ -1898,7 +1893,8 @@ static long writeback_chunk_size(struct bdi_writeback *wb,
>  	pages = min(wb->avg_write_bandwidth / 2,
>  		    global_wb_domain.dirty_limit / DIRTY_SCOPE);
>  	pages = min(pages, work->nr_pages);
> -	return round_down(pages + MIN_WRITEBACK_PAGES, MIN_WRITEBACK_PAGES);
> +	return round_down(pages + sb->s_min_writeback_pages,
> +			sb->s_min_writeback_pages);
>  }
>  
>  /*
> @@ -2000,7 +1996,7 @@ static long writeback_sb_inodes(struct super_block *sb,
>  		inode->i_state |= I_SYNC;
>  		wbc_attach_and_unlock_inode(&wbc, inode);
>  
> -		write_chunk = writeback_chunk_size(wb, work);
> +		write_chunk = writeback_chunk_size(inode->i_sb, wb, work);
>  		wbc.nr_to_write = write_chunk;
>  		wbc.pages_skipped = 0;
>  
> diff --git a/fs/super.c b/fs/super.c
> index 5bab94fb7e03..599c1d2641fe 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -389,6 +389,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
>  		goto fail;
>  	if (list_lru_init_memcg(&s->s_inode_lru, s->s_shrink))
>  		goto fail;
> +	s->s_min_writeback_pages = MIN_WRITEBACK_PAGES;
>  	return s;
>  
>  fail:
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c895146c1444..ae6f37c6eaa4 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1583,6 +1583,7 @@ struct super_block {
>  
>  	spinlock_t		s_inode_wblist_lock;
>  	struct list_head	s_inodes_wb;	/* writeback inodes */
> +	long			s_min_writeback_pages;
>  } __randomize_layout;
>  
>  static inline struct user_namespace *i_user_ns(const struct inode *inode)
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index 22dd4adc5667..49e1dd96f43e 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -374,4 +374,9 @@ bool redirty_page_for_writepage(struct writeback_control *, struct page *);
>  void sb_mark_inode_writeback(struct inode *inode);
>  void sb_clear_inode_writeback(struct inode *inode);
>  
> +/*
> + * 4MB minimal write chunk size
> + */
> +#define MIN_WRITEBACK_PAGES	(4096UL >> (PAGE_SHIFT - 10))
> +
>  #endif		/* WRITEBACK_H */
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

