Return-Path: <linux-fsdevel+bounces-22335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E79A9166A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 13:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108A81F22303
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 11:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3C214BF98;
	Tue, 25 Jun 2024 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qFfTLU/f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8IiHEfLD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qFfTLU/f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8IiHEfLD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A701494A0;
	Tue, 25 Jun 2024 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316381; cv=none; b=rM9qGqhAJFbJd6rJiQMbhCG15ahim0Z7ZzYK0LO2ZxuZhq1pSi4Oo9io1x7VPYdGMFVD8b1SW7fcpgzZlfTh5JgFdYJKOzm5VDNfOMUX6pdv2/hwSpj823peeBjlNxqVcBMaUGTUC3ONe2lcfy0lT8CGP8NlsAvRunfzyNWIvYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316381; c=relaxed/simple;
	bh=yEXI9upsTGwmng1fzr/TmblhbgESfn49eFsRtzhxKMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8MtgZQEYpfWFlu/+jPapf/oKDO2FJtXlsbIEZhoDRyIMuYJigjsLBEOMex8+6YeGOZLECZnXJRXqNxGKyhM1hV5qP3Pz2oO0+hld6PMUfq381M2/eBrimg040JvnQ9TeZE67bwzym1NNQTXiOvhcboUKGd98DE6FDP7QoURqks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qFfTLU/f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8IiHEfLD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qFfTLU/f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8IiHEfLD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8FDD121A74;
	Tue, 25 Jun 2024 11:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719316377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g6QReXCptVvvnhWONvHMOQ9mYHpbTZJLv+/buDH78sM=;
	b=qFfTLU/feSIY+EL+6nPRavFzspOM/dJdK3v5F2BlmPNoOiENE4myYURQSXCFpXm/5KmZA2
	of63qoq/wSVl4Xj29vqXOrjxOyLWDMTPy/HWtwOXNbhg3ZwkZHLI2jV/Im5/OkHDqa2fui
	ShIYL2MqqIxGAEOYURuLn4h/doAiALs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719316377;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g6QReXCptVvvnhWONvHMOQ9mYHpbTZJLv+/buDH78sM=;
	b=8IiHEfLD271bS+UYd+Tfo//IJ4Em+a6JhIiifj/ICepXl2IwZnhQjxk4/5KzEFitcuBVK1
	iUJ0sZXiSIQeOwCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719316377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g6QReXCptVvvnhWONvHMOQ9mYHpbTZJLv+/buDH78sM=;
	b=qFfTLU/feSIY+EL+6nPRavFzspOM/dJdK3v5F2BlmPNoOiENE4myYURQSXCFpXm/5KmZA2
	of63qoq/wSVl4Xj29vqXOrjxOyLWDMTPy/HWtwOXNbhg3ZwkZHLI2jV/Im5/OkHDqa2fui
	ShIYL2MqqIxGAEOYURuLn4h/doAiALs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719316377;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g6QReXCptVvvnhWONvHMOQ9mYHpbTZJLv+/buDH78sM=;
	b=8IiHEfLD271bS+UYd+Tfo//IJ4Em+a6JhIiifj/ICepXl2IwZnhQjxk4/5KzEFitcuBVK1
	iUJ0sZXiSIQeOwCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7770C13A9A;
	Tue, 25 Jun 2024 11:52:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0/0jHZmvemYWeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Jun 2024 11:52:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3054BA083E; Tue, 25 Jun 2024 13:52:57 +0200 (CEST)
Date: Tue, 25 Jun 2024 13:52:57 +0200
From: Jan Kara <jack@suse.cz>
To: Yu Ma <yu.ma@intel.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	mjguzik@gmail.com, edumazet@google.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v2 1/3] fs/file.c: add fast path in alloc_fd()
Message-ID: <20240625115257.piu47hzjyw5qnsa6@quack3>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240622154904.3774273-1-yu.ma@intel.com>
 <20240622154904.3774273-2-yu.ma@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240622154904.3774273-2-yu.ma@intel.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com,google.com,vger.kernel.org,intel.com,linux.intel.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Sat 22-06-24 11:49:02, Yu Ma wrote:
> There is available fd in the lower 64 bits of open_fds bitmap for most cases
> when we look for an available fd slot. Skip 2-levels searching via
> find_next_zero_bit() for this common fast path.
> 
> Look directly for an open bit in the lower 64 bits of open_fds bitmap when a
> free slot is available there, as:
> (1) The fd allocation algorithm would always allocate fd from small to large.
> Lower bits in open_fds bitmap would be used much more frequently than higher
> bits.
> (2) After fdt is expanded (the bitmap size doubled for each time of expansion),
> it would never be shrunk. The search size increases but there are few open fds
> available here.
> (3) find_next_zero_bit() itself has a fast path inside to speed up searching
> when size<=64.
> 
> Besides, "!start" is added to fast path condition to ensure the allocated fd is
> greater than start (i.e. >=0), given alloc_fd() is only called in two scenarios:
> (1) Allocating a new fd (the most common usage scenario) via
> get_unused_fd_flags() to find fd start from bit 0 in fdt (i.e. start==0).
> (2) Duplicating a fd (less common usage) via dup_fd() to find a fd start from
> old_fd's index in fdt, which is only called by syscall fcntl.
> 
> With the fast path added in alloc_fd(), pts/blogbench-1.1.0 read is improved
> by 17% and write by 9% on Intel ICX 160 cores configuration with v6.10-rc4.
> 
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Yu Ma <yu.ma@intel.com>
> ---
>  fs/file.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index a3b72aa64f11..50e900a47107 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -515,28 +515,35 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
>  	if (fd < files->next_fd)
>  		fd = files->next_fd;
>  
> -	if (fd < fdt->max_fds)
> +	error = -EMFILE;
> +	if (likely(fd < fdt->max_fds)) {
> +		if (~fdt->open_fds[0] && !start) {
> +			fd = find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, fd);

So I don't think this is quite correct. If files->next_fd is set, we could
end up calling find_next_zero_bit() starting from quite high offset causing
a regression? Also because we don't expand in this case, we could cause access
beyond end of fdtable?

Finally, AFAIU this speeds up the lookup for cases where fd < 64 is
available at the cost of cases where the first long is full (there we
unnecessarily load open_fds[0] into cache). Did you check if the cost is
visible (e.g. by making blogbench occupy first 64 fds before starting its
load)?

								Honza

> +			goto fastreturn;
> +		}
>  		fd = find_next_fd(fdt, fd);
> +	}
> +
> +	if (unlikely(fd >= fdt->max_fds)) {
> +		error = expand_files(files, fd);
> +		if (error < 0)
> +			goto out;
> +		/*
> +		 * If we needed to expand the fs array we
> +		 * might have blocked - try again.
> +		 */
> +		if (error)
> +			goto repeat;
> +	}
>  
> +fastreturn:
>  	/*
>  	 * N.B. For clone tasks sharing a files structure, this test
>  	 * will limit the total number of files that can be opened.
>  	 */
> -	error = -EMFILE;
> -	if (fd >= end)
> +	if (unlikely(fd >= end))
>  		goto out;
>  
> -	error = expand_files(files, fd);
> -	if (error < 0)
> -		goto out;
> -
> -	/*
> -	 * If we needed to expand the fs array we
> -	 * might have blocked - try again.
> -	 */
> -	if (error)
> -		goto repeat;
> -
>  	if (start <= files->next_fd)
>  		files->next_fd = fd + 1;
>  
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

