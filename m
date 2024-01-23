Return-Path: <linux-fsdevel+bounces-8611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E66983971C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 19:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B80C2B29DAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 18:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE9C81211;
	Tue, 23 Jan 2024 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kiV/UvtX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8T+6+jW/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N7RwBA6F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7+M8i/DF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FC38005D;
	Tue, 23 Jan 2024 18:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032819; cv=none; b=ndCEyi2fEw101xKgWIb8jXU6md2fzynAOYfXMrP4GRUecYmX2mBFAQW5MD//T6hmCgGcJl+5+sCeF2U+4aa4Dj0tCATLvkTv6Xoi3SXDzStd7Odze1hpAcYpW33mZC5bjwhqAbLqHoWk/VZ/0T+1ZTNSqKN+DIBESPc4gJ40NQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032819; c=relaxed/simple;
	bh=x+4DKQ0VomY5Vn/A2UNegg9hB/vO0L2w7CrEM1I0bng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnjPrhT2WvC1x3GKUCaRgvQLMxPYpfm3reUCQcadUXJHxdkqZDCqBaBR9WUjjumZeUNi5XJW2Fui18bfWZYZ0CV+CwW9gCE95UKs5VGr5k4vRYMXhLrg24geaCIt/XGfj8mS/yAYixA4moG3NrJCX8Kx/uxvBsUDZFLV4n2LdxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kiV/UvtX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8T+6+jW/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N7RwBA6F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7+M8i/DF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C6EDB1F79B;
	Tue, 23 Jan 2024 18:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706032809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=INBI/Isa3O19dYdw2aRIskylv6DV2Svn3LWWNjvnDaE=;
	b=kiV/UvtXntEAK8kIull+dRj6dexryLwH4imrKZ+MyXmAyrOhkr15RuzMGIaJXXintJjb7e
	t9KDU1IHCFB5jye/TKO/8kQaPHhwXWfxfywZc3NhfSWn+VRILt5XJlRbWInjxSXoLXkB43
	/rgsB7hoQzs13LHiHqqmiM/ALAOeoCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706032809;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=INBI/Isa3O19dYdw2aRIskylv6DV2Svn3LWWNjvnDaE=;
	b=8T+6+jW/0prvyKoDs1LZw2bQpHKrm7TScVec8e7i4wyErKLJ2+U4Tv2LtVIUC8jXdWG8Nx
	rbKaqYqt20SaLBCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706032808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=INBI/Isa3O19dYdw2aRIskylv6DV2Svn3LWWNjvnDaE=;
	b=N7RwBA6FBOSZIY00nSEYwyStKOhMVag1aZC5AFlB8kbvvE8XfiBW3uD4f4R7SnVSomsJY/
	56xfcM/wdX9uvklhm5q0n23/0ad6leOz7cnJjFODvnuFsgKIICL9jHBE2+2nMJ1WNxNfOq
	XcM+BNrYfQbI7ywxPshpnzX8VsC3TUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706032808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=INBI/Isa3O19dYdw2aRIskylv6DV2Svn3LWWNjvnDaE=;
	b=7+M8i/DF36t2tADhHtScro2yUi1M09IQuMjQ8Igq2MsJYPa2feIo97ElujbXiNZGgkfFCz
	TdZQc9TArcnaAlDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8601136A4;
	Tue, 23 Jan 2024 18:00:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lZ/zLKj+r2XcKAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jan 2024 18:00:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 53DFFA0803; Tue, 23 Jan 2024 19:00:08 +0100 (CET)
Date: Tue, 23 Jan 2024 19:00:08 +0100
From: Jan Kara <jack@suse.cz>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/82] select: Avoid wrap-around instrumentation in
 do_sys_poll()
Message-ID: <20240123180008.sg77hnu5r7nqrgjy@quack3>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-9-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123002814.1396804-9-keescook@chromium.org>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,linux.org.uk:email,chromium.org:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Mon 22-01-24 16:26:44, Kees Cook wrote:
> The mix of int, unsigned int, and unsigned long used by struct
> poll_list::len, todo, len, and j meant that the signed overflow
> sanitizer got worried it needed to instrument several places where
> arithmetic happens between these variables. Since all of the variables
> are always positive and bounded by unsigned int, use a single type in
> all places. Additionally expand the zero-test into an explicit range
> check before updating "todo".
> 
> This keeps sanitizer instrumentation[1] out of a UACCESS path:
> 
> vmlinux.o: warning: objtool: do_sys_poll+0x285: call to __ubsan_handle_sub_overflow() with UACCESS enabled
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/select.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/select.c b/fs/select.c
> index 0ee55af1a55c..11a3b1312abe 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -839,7 +839,7 @@ SYSCALL_DEFINE1(old_select, struct sel_arg_struct __user *, arg)
>  
>  struct poll_list {
>  	struct poll_list *next;
> -	int len;
> +	unsigned int len;
>  	struct pollfd entries[];
>  };
>  
> @@ -975,14 +975,15 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
>  		struct timespec64 *end_time)
>  {
>  	struct poll_wqueues table;
> -	int err = -EFAULT, fdcount, len;
> +	int err = -EFAULT, fdcount;
>  	/* Allocate small arguments on the stack to save memory and be
>  	   faster - use long to make sure the buffer is aligned properly
>  	   on 64 bit archs to avoid unaligned access */
>  	long stack_pps[POLL_STACK_ALLOC/sizeof(long)];
>  	struct poll_list *const head = (struct poll_list *)stack_pps;
>   	struct poll_list *walk = head;
> - 	unsigned long todo = nfds;
> +	unsigned int todo = nfds;
> +	unsigned int len;
>  
>  	if (nfds > rlimit(RLIMIT_NOFILE))
>  		return -EINVAL;
> @@ -998,9 +999,9 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
>  					sizeof(struct pollfd) * walk->len))
>  			goto out_fds;
>  
> -		todo -= walk->len;
> -		if (!todo)
> +		if (walk->len >= todo)
>  			break;
> +		todo -= walk->len;
>  
>  		len = min(todo, POLLFD_PER_PAGE);
>  		walk = walk->next = kmalloc(struct_size(walk, entries, len),
> @@ -1020,7 +1021,7 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
>  
>  	for (walk = head; walk; walk = walk->next) {
>  		struct pollfd *fds = walk->entries;
> -		int j;
> +		unsigned int j;
>  
>  		for (j = walk->len; j; fds++, ufds++, j--)
>  			unsafe_put_user(fds->revents, &ufds->revents, Efault);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

