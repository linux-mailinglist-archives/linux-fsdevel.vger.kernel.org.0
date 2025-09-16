Return-Path: <linux-fsdevel+bounces-61718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95996B59473
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 12:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFF52A32BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 10:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3092C1596;
	Tue, 16 Sep 2025 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rINvNTXD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RGAeGeE8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EDEPYK4f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jm5TOFkh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF2629DB8F
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 10:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020210; cv=none; b=KsWCgqhaIWASX/K+oj1CkoeANDT9wWEbzno4toVbz97sxFW0yqvzP3e7LJ5n+9kjmwFDQB1ry34Nj7oMvEOO9eWarrlUOeHU0E2OiDOnLyvA/pKdrO+QOnaOtQsl/v7OH2DG4UQDqt5hPFzT5eLg7JZbJFHuWs+YYenH+tL9/IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020210; c=relaxed/simple;
	bh=pxmiK2G5fQJIkvvkHLZyEBKCBkCYa+9mjl3zcUyNVNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7EAnveBE4SafiV2zTtvqjBGp4Bxv+ELMnYIaBmV0e+BTsAPAawVQlncsl0+rkeAXOd9O+g+lojeGYnnN7ly0cZYwt/JpqkKyJ/U1dc1YNlzTwesPmbGyvNLc5iZXNDqiTZOQbOJseXg4FtoxusaqA5w1CmKFfRM46sq2US9bro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rINvNTXD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RGAeGeE8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EDEPYK4f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jm5TOFkh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 188911FB68;
	Tue, 16 Sep 2025 10:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758020207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGwWhNIO4PiBFylmCZMgRfTg1I0nw47qWzgCcsKqCBw=;
	b=rINvNTXDBiBlFnESIRVo4YWuA7hfvqCM5mEqzukAdXmWwpKxGa5AZ1ue0a76Umk/+Dg/Ao
	R19fVJjxMr4HOi0Ys3AHRK4aYO2hcnYwwlEPjmwVRqgxiM9apAEdzPyl3P8KqqXzxLmZFx
	OeKOys3rMKuxFdsGpVtjOsoSftZ7jC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758020207;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGwWhNIO4PiBFylmCZMgRfTg1I0nw47qWzgCcsKqCBw=;
	b=RGAeGeE8YfqXr/33Y8kqHLkebD+y2xiPmhJUCZFvzYlHM/l0VidFmQY07ZU6m3ig7EcSP6
	2lVXvtBpXhCtD0AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EDEPYK4f;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Jm5TOFkh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758020206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGwWhNIO4PiBFylmCZMgRfTg1I0nw47qWzgCcsKqCBw=;
	b=EDEPYK4fpCjFs0PuL3EJ9ZRiiFNhwMIUItJ3UwRgysHcThrzs6EUyZpYznqjnpDtgT8cnU
	GQq+rzld3PifYBAdxAk+HerPswajbFUWn3kDMeekqLh83i2Hs0Wf3caI47+vGryZINpKT7
	1y8E/ibbuLBsiLp6So/fHwXXH2x4nwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758020206;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGwWhNIO4PiBFylmCZMgRfTg1I0nw47qWzgCcsKqCBw=;
	b=Jm5TOFkhTL+48+l0TQ6Et1s6HejhTPyNglktnEiJUmZt0e5juvWdAX6/lXqH6FxTYJK46N
	qeWmSwCvUfkwzDBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0232113A63;
	Tue, 16 Sep 2025 10:56:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +ceGAG5CyWieWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 16 Sep 2025 10:56:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8FFA3A0A56; Tue, 16 Sep 2025 12:56:41 +0200 (CEST)
Date: Tue, 16 Sep 2025 12:56:41 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	hsiangkao@linux.alibaba.com, yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH 1/2] jbd2: ensure that all ongoing I/O complete before
 freeing blocks
Message-ID: <p7aznpdg4ue7g3hv7y4wv6lfqp3aoavkdzthz5jgbwtrkc2cnu@gndrpsqaoma2>
References: <20250916093337.3161016-1-yi.zhang@huaweicloud.com>
 <20250916093337.3161016-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916093337.3161016-2-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 188911FB68
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.com:email]
X-Spam-Score: -4.01

On Tue 16-09-25 17:33:36, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When releasing file system metadata blocks in jbd2_journal_forget(), if
> this buffer has not yet been checkpointed, it may have already been
> written back, currently be in the process of being written back, or has
> not yet written back. jbd2_journal_forget() calls
> jbd2_journal_try_remove_checkpoint() to check the buffer's status and
> add it to the current transaction if it has not been written back. This
> buffer can only be reallocated after the transaction is committed.
> 
> jbd2_journal_try_remove_checkpoint() attempts to lock the buffer and
> check its dirty status while holding the buffer lock. If the buffer has
> already been written back, everything proceeds normally. However, there
> are two issues. First, the function returns immediately if the buffer is
> locked by the write-back process. It does not wait for the write-back to
> complete. Consequently, until the current transaction is committed and
> the block is reallocated, there is no guarantee that the I/O will
> complete. This means that ongoing I/O could write stale metadata to the
> newly allocated block, potentially corrupting data. Second, the function
> unlocks the buffer as soon as it detects that the buffer is still dirty.
> If a concurrent write-back occurs immediately after this unlocking and
> before clear_buffer_dirty() is called in jbd2_journal_forget(), data
> corruption can theoretically still occur.
> 
> Although these two issues are unlikely to occur in practice since the
> undergoing metadata writeback I/O does not take this long to complete,
> it's better to explicitly ensure that all ongoing I/O operations are
> completed.
> 
> Fixes: 597599268e3b ("jbd2: discard dirty data when forgetting an un-journalled buffer")
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/transaction.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index c7867139af69..3e510564de6e 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -1659,6 +1659,7 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
>  	int drop_reserve = 0;
>  	int err = 0;
>  	int was_modified = 0;
> +	int wait_for_writeback = 0;
>  
>  	if (is_handle_aborted(handle))
>  		return -EROFS;
> @@ -1782,18 +1783,22 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
>  		}
>  
>  		/*
> -		 * The buffer is still not written to disk, we should
> -		 * attach this buffer to current transaction so that the
> -		 * buffer can be checkpointed only after the current
> -		 * transaction commits.
> +		 * The buffer has not yet been written to disk. We should
> +		 * either clear the buffer or ensure that the ongoing I/O
> +		 * is completed, and attach this buffer to current
> +		 * transaction so that the buffer can be checkpointed only
> +		 * after the current transaction commits.
>  		 */
>  		clear_buffer_dirty(bh);
> +		wait_for_writeback = 1;
>  		__jbd2_journal_file_buffer(jh, transaction, BJ_Forget);
>  		spin_unlock(&journal->j_list_lock);
>  	}
>  drop:
>  	__brelse(bh);
>  	spin_unlock(&jh->b_state_lock);
> +	if (wait_for_writeback)
> +		wait_on_buffer(bh);
>  	jbd2_journal_put_journal_head(jh);
>  	if (drop_reserve) {
>  		/* no need to reserve log space for this block -bzzz */
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

