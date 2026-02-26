Return-Path: <linux-fsdevel+bounces-78479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBuiGD5KoGkuhwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:27:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A861A6882
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6E9930AD630
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 13:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADBA335542;
	Thu, 26 Feb 2026 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PBiBvZ97";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yKJKpq1w";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PBiBvZ97";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yKJKpq1w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577E23242BC
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 13:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772112121; cv=none; b=GtWLIRCEyNoRyPUp7poDXg4ZepaAjzuPCvCJj1WEQJew0rlwGTaMb//9/MpRgl6FfRm6W8HrTCDPrKXhM5KNu2xA09qcxujiK4EPRUjqS/QzznDWf4TOrDeJEAWqzJfR8SvCcEHdSPaZ+b+JBmdHhvIt3VWR2T+Kz/1vx6oeHVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772112121; c=relaxed/simple;
	bh=5yGsS82X0SeiBMdHwqt+M5j0u+wrH/Ac6+KtEN7Bj3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIMxk2QWNGOSRjGHmXpn6A3VNBVOEQ8BuDLXdgXWRC8m63nWOj008UJwVAsBWg7Mfg28siILu5LjZ9c/aIgcdpZtyMXvELuIu7nn0Aou+H8wBHYioMVmwvJSUXis1QcR29oiVZS05uKOeDwvI9iowdvoFNyfBSF9vVIyGnERUA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PBiBvZ97; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yKJKpq1w; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PBiBvZ97; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yKJKpq1w; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 903213FD91;
	Thu, 26 Feb 2026 13:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772112117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6fDaSkVhy0E33BiFULWhZdEJNcGyrApfeqESCYAmwD8=;
	b=PBiBvZ97kx3nE8Sx3Iqr2jG5qsX80nZ2QZEXA7XtGku+vlcy2CmVQufsvmFLIxPxb6R1o+
	VNcFM/i1N7uvIMZ63qlWZj58vjqkIC6cLtuo7yRQmA94JTf46RvXW3UqZaRhz2rU5qYpm5
	5uC0hdfRgvc4icWc/ipstowyGMbsuZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772112117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6fDaSkVhy0E33BiFULWhZdEJNcGyrApfeqESCYAmwD8=;
	b=yKJKpq1wn5G35h25U8MPNWJFk0Rth71l9BQh2uX7wTyWNc7We7QYgoCHRktLaHztRqM8kO
	HbJyGRl/FuICxXDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772112117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6fDaSkVhy0E33BiFULWhZdEJNcGyrApfeqESCYAmwD8=;
	b=PBiBvZ97kx3nE8Sx3Iqr2jG5qsX80nZ2QZEXA7XtGku+vlcy2CmVQufsvmFLIxPxb6R1o+
	VNcFM/i1N7uvIMZ63qlWZj58vjqkIC6cLtuo7yRQmA94JTf46RvXW3UqZaRhz2rU5qYpm5
	5uC0hdfRgvc4icWc/ipstowyGMbsuZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772112117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6fDaSkVhy0E33BiFULWhZdEJNcGyrApfeqESCYAmwD8=;
	b=yKJKpq1wn5G35h25U8MPNWJFk0Rth71l9BQh2uX7wTyWNc7We7QYgoCHRktLaHztRqM8kO
	HbJyGRl/FuICxXDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F8F23EA62;
	Thu, 26 Feb 2026 13:21:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yNo1G/VIoGn1UQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Feb 2026 13:21:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 234ABA0A27; Thu, 26 Feb 2026 14:21:57 +0100 (CET)
Date: Thu, 26 Feb 2026 14:21:57 +0100
From: Jan Kara <jack@suse.cz>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	syzbot+6880f676b265dbd42d63@syzkaller.appspotmail.com, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] mm: annotate data race of f_ra.prev_pos
Message-ID: <2xzc3lp6ehtjwbzip4i5muh4g6oep4l72zh3j6sablfghbvbau@kh7famgorzrh>
References: <20260226084020.163720-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226084020.163720-1-jiayuan.chen@linux.dev>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78479-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.cz:dkim,appspotmail.com:email,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,6880f676b265dbd42d63];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F2A861A6882
X-Rspamd-Action: no action

On Thu 26-02-26 16:40:07, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> KCSAN reports a data race when concurrent readers access the same
> struct file:
> 
>   BUG: KCSAN: data-race in filemap_read / filemap_splice_read
> 
>   write to 0xffff88811a6f8228 of 8 bytes by task 10061 on cpu 0:
>    filemap_splice_read+0x523/0x780 mm/filemap.c:3125
>    ...
> 
>   write to 0xffff88811a6f8228 of 8 bytes by task 10066 on cpu 1:
>    filemap_read+0x98d/0xa10 mm/filemap.c:2873
>    ...
> 
> Both filemap_read() and filemap_splice_read() update f_ra.prev_pos
> without synchronization. This is a benign race since prev_pos is only
> used as a hint for readahead heuristics in page_cache_sync_ra(), and a
> stale or torn value merely results in a suboptimal readahead decision,
> not a correctness issue.
> 
> Use WRITE_ONCE/READ_ONCE to annotate all accesses to prev_pos across
> the tree for consistency and silence KCSAN.
> 
> Reported-by: syzbot+6880f676b265dbd42d63@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=6880f676b265dbd42d63
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>

Given this, I think it would be much less intrusive and also more
explanatory to just mark prev_pos with __data_racy with appropriate reason
you're mentioning in the changelog.

								Honza

> ---
>  fs/ext4/dir.c                    | 2 +-
>  fs/ntfs3/fsntfs.c                | 2 +-
>  include/trace/events/readahead.h | 2 +-
>  mm/filemap.c                     | 6 +++---
>  mm/readahead.c                   | 4 ++--
>  mm/shmem.c                       | 2 +-
>  6 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> index 28b2a3deb954..1ddf7acce5ca 100644
> --- a/fs/ext4/dir.c
> +++ b/fs/ext4/dir.c
> @@ -200,7 +200,7 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
>  					sb->s_bdev->bd_mapping,
>  					&file->f_ra, file, index,
>  					1 << EXT4_SB(sb)->s_min_folio_order);
> -			file->f_ra.prev_pos = (loff_t)index << PAGE_SHIFT;
> +			WRITE_ONCE(file->f_ra.prev_pos, (loff_t)index << PAGE_SHIFT);
>  			bh = ext4_bread(NULL, inode, map.m_lblk, 0);
>  			if (IS_ERR(bh)) {
>  				err = PTR_ERR(bh);
> diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
> index 0df2aa81d884..d1232fc03c08 100644
> --- a/fs/ntfs3/fsntfs.c
> +++ b/fs/ntfs3/fsntfs.c
> @@ -1239,7 +1239,7 @@ int ntfs_read_run_nb_ra(struct ntfs_sb_info *sbi, const struct runs_tree *run,
>  			if (!ra_has_index(ra, index)) {
>  				page_cache_sync_readahead(mapping, ra, NULL,
>  							  index, 1);
> -				ra->prev_pos = (loff_t)index << PAGE_SHIFT;
> +				WRITE_ONCE(ra->prev_pos, (loff_t)index << PAGE_SHIFT);
>  			}
>  		}
>  
> diff --git a/include/trace/events/readahead.h b/include/trace/events/readahead.h
> index 0997ac5eceab..63d8df6c2983 100644
> --- a/include/trace/events/readahead.h
> +++ b/include/trace/events/readahead.h
> @@ -101,7 +101,7 @@ DECLARE_EVENT_CLASS(page_cache_ra_op,
>  		__entry->async_size = ra->async_size;
>  		__entry->ra_pages = ra->ra_pages;
>  		__entry->mmap_miss = ra->mmap_miss;
> -		__entry->prev_pos = ra->prev_pos;
> +		__entry->prev_pos = READ_ONCE(ra->prev_pos);
>  		__entry->req_count = req_count;
>  	),
>  
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 63f256307fdd..d3e2d4b826b9 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2771,7 +2771,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>  	int i, error = 0;
>  	bool writably_mapped;
>  	loff_t isize, end_offset;
> -	loff_t last_pos = ra->prev_pos;
> +	loff_t last_pos = READ_ONCE(ra->prev_pos);
>  
>  	if (unlikely(iocb->ki_pos < 0))
>  		return -EINVAL;
> @@ -2870,7 +2870,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>  	} while (iov_iter_count(iter) && iocb->ki_pos < isize && !error);
>  
>  	file_accessed(filp);
> -	ra->prev_pos = last_pos;
> +	WRITE_ONCE(ra->prev_pos, last_pos);
>  	return already_read ? already_read : error;
>  }
>  EXPORT_SYMBOL_GPL(filemap_read);
> @@ -3122,7 +3122,7 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
>  			len -= n;
>  			total_spliced += n;
>  			*ppos += n;
> -			in->f_ra.prev_pos = *ppos;
> +			WRITE_ONCE(in->f_ra.prev_pos, *ppos);
>  			if (pipe_is_full(pipe))
>  				goto out;
>  		}
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 7b05082c89ea..de49b35b0329 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -142,7 +142,7 @@ void
>  file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
>  {
>  	ra->ra_pages = inode_to_bdi(mapping->host)->ra_pages;
> -	ra->prev_pos = -1;
> +	WRITE_ONCE(ra->prev_pos, -1);
>  }
>  EXPORT_SYMBOL_GPL(file_ra_state_init);
>  
> @@ -584,7 +584,7 @@ void page_cache_sync_ra(struct readahead_control *ractl,
>  	}
>  
>  	max_pages = ractl_max_pages(ractl, req_count);
> -	prev_index = (unsigned long long)ra->prev_pos >> PAGE_SHIFT;
> +	prev_index = (unsigned long long)READ_ONCE(ra->prev_pos) >> PAGE_SHIFT;
>  	/*
>  	 * A start of file, oversized read, or sequential cache miss:
>  	 * trivial case: (index - prev_index) == 1
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 5e7dcf5bc5d3..03569199baf4 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3642,7 +3642,7 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
>  		len -= n;
>  		total_spliced += n;
>  		*ppos += n;
> -		in->f_ra.prev_pos = *ppos;
> +		WRITE_ONCE(in->f_ra.prev_pos, *ppos);
>  		if (pipe_is_full(pipe))
>  			break;
>  
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

