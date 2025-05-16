Return-Path: <linux-fsdevel+bounces-49235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8887CAB99F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 12:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8E91BA143F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 10:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BD51C862B;
	Fri, 16 May 2025 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KMz7hydx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hxWR4sMr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KMz7hydx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hxWR4sMr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A715B21ABDA
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390665; cv=none; b=LsE0BLJRGbjag6bbiaFy/RvQ6RzlU+vXxay1xJIA6upScS5dRjL4kDdOdqEdaruLbofJDXsxjwTTous/DhSQsjrVN7+bMdYvC5A3Q8hSbKwPE4/ENbwS7zT7Mgg8tHcG1mAUiIyrhiJ7NnNgNWJ5fbzKbKqxkVcWVtSRfC+letg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390665; c=relaxed/simple;
	bh=mjxgZTlaJ0bk/qVD2RmINx8GDGAic+62Ege7yBhYlZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opcPS8bfdbGdrm890rhmuosaJbwfbbzhgpbkNqt8xv6IaYwYsgXrNh8KlWc8yO2gwhoNg7cTTyqDh6cF5G+1H+T9iKnXf+w7NfD+BglFaZ0xGp4T2DBEsnzK7EyZ9CePeIE3z8r+2XUF9im6lrqQH8fQPmdHUNlQkBo/72zs+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KMz7hydx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hxWR4sMr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KMz7hydx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hxWR4sMr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE35A218B5;
	Fri, 16 May 2025 10:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747390661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uO9x4Sj1nJ4i5yMk2K2202lgmAIgPbzgztfZFEf1C/Q=;
	b=KMz7hydxziyn9aIus2oIxGgbw9Nxi7FN7VDzXbj540J145/NeAZoZIZiSCD+FpTEvF+0Yt
	rrkoI7N/mqH9AKME5HtSF5xcJORpsuhN5lHyk383ZsxYcb0KUrUaBPlsGUS1uJ/Pz2YJTc
	czO5Yi4iFCEWN9jler0mUvD7Xv0ZSBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747390661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uO9x4Sj1nJ4i5yMk2K2202lgmAIgPbzgztfZFEf1C/Q=;
	b=hxWR4sMrJ1SQRVmnAh2q6k32MzTT6fdNlrbbseEgjYwi7BUUuyFhaItapNla+1sZSjbqAn
	PHR5XEulWkXhToBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747390661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uO9x4Sj1nJ4i5yMk2K2202lgmAIgPbzgztfZFEf1C/Q=;
	b=KMz7hydxziyn9aIus2oIxGgbw9Nxi7FN7VDzXbj540J145/NeAZoZIZiSCD+FpTEvF+0Yt
	rrkoI7N/mqH9AKME5HtSF5xcJORpsuhN5lHyk383ZsxYcb0KUrUaBPlsGUS1uJ/Pz2YJTc
	czO5Yi4iFCEWN9jler0mUvD7Xv0ZSBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747390661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uO9x4Sj1nJ4i5yMk2K2202lgmAIgPbzgztfZFEf1C/Q=;
	b=hxWR4sMrJ1SQRVmnAh2q6k32MzTT6fdNlrbbseEgjYwi7BUUuyFhaItapNla+1sZSjbqAn
	PHR5XEulWkXhToBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2A8713411;
	Fri, 16 May 2025 10:17:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SemZK8UQJ2hVfQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 16 May 2025 10:17:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 57F6CA09DD; Fri, 16 May 2025 12:17:37 +0200 (CEST)
Date: Fri, 16 May 2025 12:17:37 +0200
From: Jan Kara <jack@suse.cz>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] fs/buffer: optimize discard_buffer()
Message-ID: <khepgn2kxjm7tcfntoxuocalp6zesrpjbsurwi6ynjetwxocdp@mrhw7g7wa7mh>
References: <20250515173925.147823-1-dave@stgolabs.net>
 <20250515173925.147823-5-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515173925.147823-5-dave@stgolabs.net>
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80

On Thu 15-05-25 10:39:25, Davidlohr Bueso wrote:
> While invalidating, the clearing of the bits in discard_buffer()
> is done in one fully ordered CAS operation. In the past this was
> done via individual clear_bit(), until e7470ee89f0 (fs: buffer:
> do not use unnecessary atomic operations when discarding buffers).
> This implies that there were never strong ordering requirements
> outside of being serialized by the buffer lock.
> 
> As such relax the ordering for archs that can benefit. Further,
> the implied ordering in buffer_unlock() makes current cmpxchg
> implied barrier redundant due to release semantics. And while in
> theory the unlock could be part of the bulk clearing, it is
> best to leave it explicit, but without the double barriers.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Yes, we just want to clear several flag bits as cheaply as possible while
other tasks can be modifying other flags. You change makes sense so feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 210b43574a10..f0fc78910abf 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1616,8 +1616,8 @@ static void discard_buffer(struct buffer_head * bh)
>  	bh->b_bdev = NULL;
>  	b_state = READ_ONCE(bh->b_state);
>  	do {
> -	} while (!try_cmpxchg(&bh->b_state, &b_state,
> -			      b_state & ~BUFFER_FLAGS_DISCARD));
> +	} while (!try_cmpxchg_relaxed(&bh->b_state, &b_state,
> +				      b_state & ~BUFFER_FLAGS_DISCARD));
>  	unlock_buffer(bh);
>  }
>  
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

