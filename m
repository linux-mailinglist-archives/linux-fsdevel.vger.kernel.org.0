Return-Path: <linux-fsdevel+bounces-49233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99542AB99E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 12:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF563B07CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 10:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F9B2367B7;
	Fri, 16 May 2025 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EIWK0fn8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y/SF/SBK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EIWK0fn8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y/SF/SBK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28DA2356D0
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390400; cv=none; b=DbZrIHQSVFCQgM64AhUUxAzdw73Quo8WREUTNpwJCyjRGFtdcXE8YWlgP1Q7UgaMAxPx3HxKBmCSgv72LNqBGeECpr2/T/Qz6iNHsL7hQLR5XseRKcq7JFDXi9gflqe6Z6cbF7/tda6LMA0obA9PiPtKAJTm9qBGCnY19P8NWx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390400; c=relaxed/simple;
	bh=RNz2HlkLiU0B6Xfu9XSuXzPa0RtCTo8+lHjAZfF1aO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXv+Cb6HXT0BX0cIXIVYsfxfYnfPh705sI7eNKuKNBUfsK4tJcJbomNcbqApkRUhUCCmSjBarCBJ6lEotxxaYbkkqqQ3Zv/9YadDy61dlOjTk/QZz4LxJR0OTBqVJZDzAdMxQCXMTkxd09YH+DNa8nV+CLeh69RTBXHrCUR/CBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EIWK0fn8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y/SF/SBK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EIWK0fn8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y/SF/SBK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 308AD216E6;
	Fri, 16 May 2025 10:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747390397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hDjtBB5BQJqD9vny7LHVgXcvldJyZpLTctvDg/Ebt/o=;
	b=EIWK0fn84RQV35i8ym3YhxVeUYRRW8UOQS9GC9qcDBUhrjuPFBs4Y7yD8vLdFaw+87Qq80
	7JLJtkpbMkmrmfx/r9Rv2MHXUCK8qGrwaxZyGXkizQmLF1SYg122cd/nBHk7STMoo5khkP
	448XZGsVp/ydFhjEjqADCtR3geAV8So=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747390397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hDjtBB5BQJqD9vny7LHVgXcvldJyZpLTctvDg/Ebt/o=;
	b=y/SF/SBKxOrATRB/5tzLlqRc8ayGWAcpW+bPqitVJGfnlTTwecIGMur1NzZvxed8W0IFNq
	YopIBjxCywYfKrDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EIWK0fn8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="y/SF/SBK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747390397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hDjtBB5BQJqD9vny7LHVgXcvldJyZpLTctvDg/Ebt/o=;
	b=EIWK0fn84RQV35i8ym3YhxVeUYRRW8UOQS9GC9qcDBUhrjuPFBs4Y7yD8vLdFaw+87Qq80
	7JLJtkpbMkmrmfx/r9Rv2MHXUCK8qGrwaxZyGXkizQmLF1SYg122cd/nBHk7STMoo5khkP
	448XZGsVp/ydFhjEjqADCtR3geAV8So=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747390397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hDjtBB5BQJqD9vny7LHVgXcvldJyZpLTctvDg/Ebt/o=;
	b=y/SF/SBKxOrATRB/5tzLlqRc8ayGWAcpW+bPqitVJGfnlTTwecIGMur1NzZvxed8W0IFNq
	YopIBjxCywYfKrDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 157FA13411;
	Fri, 16 May 2025 10:13:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DXw9Bb0PJ2jvewAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 16 May 2025 10:13:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9CC3AA09DD; Fri, 16 May 2025 12:13:16 +0200 (CEST)
Date: Fri, 16 May 2025 12:13:16 +0200
From: Jan Kara <jack@suse.cz>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] fs/buffer: remove superfluous statements
Message-ID: <lvrssktqvezbuzswlrl3awygrfupmci6y3w2wwkd66zucte6ql@ufttxb7ghltb>
References: <20250515173925.147823-1-dave@stgolabs.net>
 <20250515173925.147823-4-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515173925.147823-4-dave@stgolabs.net>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 308AD216E6
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action

On Thu 15-05-25 10:39:24, Davidlohr Bueso wrote:
> Get rid of those unnecessary return statements.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index b02cced96529..210b43574a10 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -297,7 +297,6 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
>  
>  still_busy:
>  	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
> -	return;
>  }
>  
>  struct postprocess_bh_ctx {
> @@ -422,7 +421,6 @@ static void end_buffer_async_write(struct buffer_head *bh, int uptodate)
>  
>  still_busy:
>  	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
> -	return;
>  }
>  
>  /*
> @@ -1684,7 +1682,6 @@ void block_invalidate_folio(struct folio *folio, size_t offset, size_t length)
>  		filemap_release_folio(folio, 0);
>  out:
>  	folio_clear_mappedtodisk(folio);
> -	return;
>  }
>  EXPORT_SYMBOL(block_invalidate_folio);
>  
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

