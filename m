Return-Path: <linux-fsdevel+bounces-65512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4847C062BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 14:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54F384E411D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 12:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE473148D0;
	Fri, 24 Oct 2025 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lUfDGig/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mc8jLQtK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lUfDGig/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mc8jLQtK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E052A313556
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761307768; cv=none; b=UGEqWkwB2Fg7VfHRfImMGS4mQY2p3wMSIJFJxp1JcUjWaZRH4H4JeRRA4y7Kvl0/HcKuiHuxSO/EJY4bjHpxSSlwD6+Cri7oUqJs6YeHA+88q8RSl+9bJwmPgGgnGoJz3kbQbGnRAAs/wegPXw+Rer+5F+//RxA9uNbtkz0NKh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761307768; c=relaxed/simple;
	bh=/7GrhG+XNBm4vB6QS6VoSNUoFr3/5T/r6pWvp1jxZ4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHK6i+zb1nzxQrCX0uy6i798usIBP8LON+LUpy42Abjlq6Zg8Qf4hMMdSgaLCLLmqo+3HXnd7vDqgZ1IRIjKfX6vN4qQH/U6xPE9t3TVBZJuA8WUmhs2v/GUcp9JirTKE5nu3tFYkOFL8k/8OtGiEkY0q5x2sEntuQHk4llyVik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lUfDGig/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mc8jLQtK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lUfDGig/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mc8jLQtK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1F4EA211BF;
	Fri, 24 Oct 2025 12:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761307764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TQR+rmk5JJXbJh11H9IDr0zLIVayrC9/4bdXvKTXH9w=;
	b=lUfDGig/qurmVZAmpVVx1+6t4iItNTrwBssMnwosNyjfn/OD41thPRQZws77hFfL6Shbsy
	/S9YqER4is+c4uGjNaQv3YFeDuyT0hStEhOQ2hit/J3SmVLYsa73EEYwWDh/m4urXkFC6I
	jH1zSZOKjUxxP40wfWPq8Sh3ZY1JEYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761307764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TQR+rmk5JJXbJh11H9IDr0zLIVayrC9/4bdXvKTXH9w=;
	b=mc8jLQtKYuPOW4qIpvZhNNIhKVbUYxR27PH60LKkwxa7HFmNGDGYRGd0EQxn29H/BahXv3
	NUfOFibub6Ppi6Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761307764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TQR+rmk5JJXbJh11H9IDr0zLIVayrC9/4bdXvKTXH9w=;
	b=lUfDGig/qurmVZAmpVVx1+6t4iItNTrwBssMnwosNyjfn/OD41thPRQZws77hFfL6Shbsy
	/S9YqER4is+c4uGjNaQv3YFeDuyT0hStEhOQ2hit/J3SmVLYsa73EEYwWDh/m4urXkFC6I
	jH1zSZOKjUxxP40wfWPq8Sh3ZY1JEYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761307764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TQR+rmk5JJXbJh11H9IDr0zLIVayrC9/4bdXvKTXH9w=;
	b=mc8jLQtKYuPOW4qIpvZhNNIhKVbUYxR27PH60LKkwxa7HFmNGDGYRGd0EQxn29H/BahXv3
	NUfOFibub6Ppi6Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0A0B13693;
	Fri, 24 Oct 2025 12:09:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7k/ONnNs+2ikNQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 24 Oct 2025 12:09:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 33729A28AB; Fri, 24 Oct 2025 14:09:23 +0200 (CEST)
Date: Fri, 24 Oct 2025 14:09:23 +0200
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
	ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org, 
	David Hildenbrand <david@redhat.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 06/10] mm,btrfs: add a filemap_flush_nr helper
Message-ID: <myxuxundkuabvgmym5ayqycxjgzjgcxn35ncuxpmdxgwjc7ht4@utx2jecj6wpq>
References: <20251024080431.324236-1-hch@lst.de>
 <20251024080431.324236-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024080431.324236-7-hch@lst.de>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	R_RATELIMIT(0.00)[to_ip_from(RLzktxcg676y4egiq9xyqoc9t5)];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Fri 24-10-25 10:04:17, Christoph Hellwig wrote:
> Abstract out the btrfs-specific behavior of kicking off I/O on a number
> of pages on an address_space into a well-defined helper.
> 
> Note: there is no kerneldoc comment for the new function because it is
> not part of the public API.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/btrfs/inode.c        | 13 ++-----------
>  include/linux/pagemap.h |  1 +
>  mm/filemap.c            | 22 ++++++++++++++++++++++
>  3 files changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index b97d6c1f7772..d12b8116adde 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8752,19 +8752,10 @@ static int start_delalloc_inodes(struct btrfs_root *root, long *nr_to_write,
>  			btrfs_queue_work(root->fs_info->flush_workers,
>  					 &work->work);
>  		} else {
> -			struct writeback_control wbc = {
> -				.nr_to_write = *nr_to_write,
> -				.sync_mode = WB_SYNC_NONE,
> -				.range_start = 0,
> -				.range_end = LLONG_MAX,
> -			};
> -
> -			ret = filemap_fdatawrite_wbc(tmp_inode->i_mapping,
> -					&wbc);
> +			ret = filemap_flush_nr(tmp_inode->i_mapping,
> +					nr_to_write);
>  			btrfs_add_delayed_iput(inode);
>  
> -			if (*nr_to_write != LONG_MAX)
> -				*nr_to_write = wbc.nr_to_write;
>  			if (ret || *nr_to_write <= 0)
>  				goto out;
>  		}
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 09b581c1d878..cebdf160d3dd 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -38,6 +38,7 @@ int filemap_invalidate_pages(struct address_space *mapping,
>  int write_inode_now(struct inode *, int sync);
>  int filemap_fdatawrite(struct address_space *);
>  int filemap_flush(struct address_space *);
> +int filemap_flush_nr(struct address_space *mapping, long *nr_to_write);
>  int filemap_fdatawait_keep_errors(struct address_space *mapping);
>  int filemap_fdatawait_range(struct address_space *, loff_t lstart, loff_t lend);
>  int filemap_fdatawait_range_keep_errors(struct address_space *mapping,
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 99d6919af60d..e344b79a012d 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -474,6 +474,28 @@ int filemap_flush(struct address_space *mapping)
>  }
>  EXPORT_SYMBOL(filemap_flush);
>  
> +/*
> + * Start writeback on @nr_to_write pages from @mapping.  No one but the existing
> + * btrfs caller should be using this.  Talk to linux-mm if you think adding a
> + * new caller is a good idea.
> + */
> +int filemap_flush_nr(struct address_space *mapping, long *nr_to_write)
> +{
> +	struct writeback_control wbc = {
> +		.nr_to_write = *nr_to_write,
> +		.sync_mode = WB_SYNC_NONE,
> +		.range_start = 0,
> +		.range_end = LLONG_MAX,
> +	};
> +	int ret;
> +
> +	ret = filemap_fdatawrite_wbc(mapping, &wbc);
> +	if (!ret)
> +		*nr_to_write = wbc.nr_to_write;
> +	return ret;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(filemap_flush_nr, "btrfs");
> +
>  /**
>   * filemap_range_has_page - check if a page exists in range.
>   * @mapping:           address space within which to check
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

