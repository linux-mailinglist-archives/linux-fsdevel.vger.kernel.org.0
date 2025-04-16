Return-Path: <linux-fsdevel+bounces-46551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB3DA8B5AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 11:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED3097A85A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 09:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EF1235C11;
	Wed, 16 Apr 2025 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nrhdX0ES";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/9ERkXod";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nrhdX0ES";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/9ERkXod"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0AD2356A9
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744796334; cv=none; b=DA7CpADCE3j2FHpWbS/a3u7ESDiYOM3T9dB49bqxNnFSeL+DimLlO5+aReOWgjLUQaqCNNTEWeeGM6mVemDMOaqD4dhmrM0oXZoppQe0eSSa75pU+jbnqPUpaaR3qQ/DWb1kldvExt5tlii+rZnTXhxz+Q78CXc23m05aLs7hIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744796334; c=relaxed/simple;
	bh=g1FgX9X40/Jda31P3XEIf+KwP1n/k4Y5wqn/2zZ5NuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkibE6sqKGieYH0NeRPC5g45/AE0o0YBe4KpnYj2BYTgcCDfNqCfRzQy5F6t0yKYPdyTNU1ezys3xGYATTjNtXi7AunirZfb7/gc80meLKW1VvyT7wLXkmJze+7UuP8RsLL4w7j0X2KuBf+BPx/4ownfR0H+o95uwVmhVVScm3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nrhdX0ES; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/9ERkXod; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nrhdX0ES; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/9ERkXod; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7DE71211A0;
	Wed, 16 Apr 2025 09:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744796331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CwKUhCev7DSKFNU9JiOO8wb+m3mv7Nt4AZi2zzinDyg=;
	b=nrhdX0ESmLpdFEDz0p6S15Mz8CwUJZAdLfavK+9DmTl1EzSGF9N368QETp5U+zeIrskSNc
	A9H9BMiXQrTbAzj4z2MOh7qNWErM0aQMVE+5qCVbyxmIGew/cO8qmrPTDCxWNdrEK0Vrk2
	QrHBYwru8V3io81WwyG2xZNtphfnn1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744796331;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CwKUhCev7DSKFNU9JiOO8wb+m3mv7Nt4AZi2zzinDyg=;
	b=/9ERkXodQS8u3ZM1bEVenxcco9BRDYLaEZUJvY1gHECJKeIU9Cxr9lsEUlg/u1aRmIf7Ff
	yRqSOUWsLWq5hMAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744796331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CwKUhCev7DSKFNU9JiOO8wb+m3mv7Nt4AZi2zzinDyg=;
	b=nrhdX0ESmLpdFEDz0p6S15Mz8CwUJZAdLfavK+9DmTl1EzSGF9N368QETp5U+zeIrskSNc
	A9H9BMiXQrTbAzj4z2MOh7qNWErM0aQMVE+5qCVbyxmIGew/cO8qmrPTDCxWNdrEK0Vrk2
	QrHBYwru8V3io81WwyG2xZNtphfnn1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744796331;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CwKUhCev7DSKFNU9JiOO8wb+m3mv7Nt4AZi2zzinDyg=;
	b=/9ERkXodQS8u3ZM1bEVenxcco9BRDYLaEZUJvY1gHECJKeIU9Cxr9lsEUlg/u1aRmIf7Ff
	yRqSOUWsLWq5hMAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7360B13976;
	Wed, 16 Apr 2025 09:38:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I80uHKt6/2cvdQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 16 Apr 2025 09:38:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 37F83A0947; Wed, 16 Apr 2025 11:38:47 +0200 (CEST)
Date: Wed, 16 Apr 2025 11:38:47 +0200
From: Jan Kara <jack@suse.cz>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca, 
	brauner@kernel.org, mcgrof@kernel.org, willy@infradead.org, hare@suse.de, 
	djwong@kernel.org, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 5/7] fs/jbd2: use sleeping version of __find_get_block()
Message-ID: <6tqny4muvkyejvokjkx6gh53ihc2duxleonzwqlkl6hn7y6w7n@r3x6dns3q6pn>
References: <20250415231635.83960-1-dave@stgolabs.net>
 <20250415231635.83960-6-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415231635.83960-6-dave@stgolabs.net>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 15-04-25 16:16:33, Davidlohr Bueso wrote:
> Convert to the new nonatomic flavor to benefit from potential
> performance benefits and adapt in the future vs migration such
> that semantics are kept.
> 
> - jbd2_journal_revoke(): can sleep (has might_sleep() in the beginning)
> 
> - jbd2_journal_cancel_revoke(): only used from do_get_write_access() and
>     do_get_create_access() which do sleep. So can sleep.
> 
> - jbd2_clear_buffer_revoked_flags() - only called from journal commit code
>     which sleeps. So can sleep.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/jbd2/revoke.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
> index 0cf0fddbee81..1467f6790747 100644
> --- a/fs/jbd2/revoke.c
> +++ b/fs/jbd2/revoke.c
> @@ -345,7 +345,8 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
>  	bh = bh_in;
>  
>  	if (!bh) {
> -		bh = __find_get_block(bdev, blocknr, journal->j_blocksize);
> +		bh = __find_get_block_nonatomic(bdev, blocknr,
> +						journal->j_blocksize);
>  		if (bh)
>  			BUFFER_TRACE(bh, "found on hash");
>  	}
> @@ -355,7 +356,8 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
>  
>  		/* If there is a different buffer_head lying around in
>  		 * memory anywhere... */
> -		bh2 = __find_get_block(bdev, blocknr, journal->j_blocksize);
> +		bh2 = __find_get_block_nonatomic(bdev, blocknr,
> +						 journal->j_blocksize);
>  		if (bh2) {
>  			/* ... and it has RevokeValid status... */
>  			if (bh2 != bh && buffer_revokevalid(bh2))
> @@ -464,7 +466,8 @@ void jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
>  	 * state machine will get very upset later on. */
>  	if (need_cancel) {
>  		struct buffer_head *bh2;
> -		bh2 = __find_get_block(bh->b_bdev, bh->b_blocknr, bh->b_size);
> +		bh2 = __find_get_block_nonatomic(bh->b_bdev, bh->b_blocknr,
> +						 bh->b_size);
>  		if (bh2) {
>  			if (bh2 != bh)
>  				clear_buffer_revoked(bh2);
> @@ -492,9 +495,9 @@ void jbd2_clear_buffer_revoked_flags(journal_t *journal)
>  			struct jbd2_revoke_record_s *record;
>  			struct buffer_head *bh;
>  			record = (struct jbd2_revoke_record_s *)list_entry;
> -			bh = __find_get_block(journal->j_fs_dev,
> -					      record->blocknr,
> -					      journal->j_blocksize);
> +			bh = __find_get_block_nonatomic(journal->j_fs_dev,
> +							record->blocknr,
> +							journal->j_blocksize);
>  			if (bh) {
>  				clear_buffer_revoked(bh);
>  				__brelse(bh);
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

