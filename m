Return-Path: <linux-fsdevel+bounces-9519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C299C8422C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 12:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7966C296549
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 11:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EED67E91;
	Tue, 30 Jan 2024 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wnSKfYN+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J1gPgPNr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iGTFcS83";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y46nuuz/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB5167E6D;
	Tue, 30 Jan 2024 11:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613360; cv=none; b=Fevby1YP+Svta5sLPyMwyTLODKLUebC7LGSJJeQC5EWMKgcDdfOtGSNrtq55TxDg3NxnhzpBlUrGOmz8OowwbFv5MBudQPEvh+m5g7MhPVv88GbCNe+Rby7Dzia8iCuR0ehtU5zTgiiacAHIX77EZ0ZhoajvxDa5ZWI29RmVMIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613360; c=relaxed/simple;
	bh=1u4ISiGKciq/te4aoqonTD2lmefQOKlXtD+Z/JlW8Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/c9p9w2nwHIoGko6MNNVS7DJlZk6Yb25TDfmDWIuZ/MyWxjKqGeC7lVzwft0vbqj8WlsiEL6NEevz29YShxQZdLDgpbSmbf5S/sMC65zNc1B+sghDfqWj9oBufHCWdh5hVnVfASqVmhznok8arWdVkxPbS4NLU62f9nhTt9yhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wnSKfYN+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J1gPgPNr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iGTFcS83; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y46nuuz/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DAA4C1F846;
	Tue, 30 Jan 2024 11:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706613355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+OQ1bCF/HA8s2JUmEwbhXiDyJh9rd41WXFOaLCe3q/U=;
	b=wnSKfYN+XJOFJdv+dIeQpzY4JIiNbrGSw4Y7TNl6Md/2JxugJt0tqDrgMEdVfeF3AY3k8Q
	J5IzIe8sB/hN1tq18WdTy2tOTlXSR96u3t9Fp5HQGw+B4ryGR3LqcO/eLmsSUj2+iP8cVF
	08RrIjWoPRQvPz08P5U8xLawh3WQJwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706613355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+OQ1bCF/HA8s2JUmEwbhXiDyJh9rd41WXFOaLCe3q/U=;
	b=J1gPgPNr+S4rVl9Ov63My5ktcVTtV6BiCeTHyd/ovTVtlf8nAxDqdR+bw5WTSRF4Smc09z
	RB6XFKAyCxGUO6DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706613353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+OQ1bCF/HA8s2JUmEwbhXiDyJh9rd41WXFOaLCe3q/U=;
	b=iGTFcS83zowJfNaToC+rm0tIl5H77AwpQNLp7kSNLyudQ/GATEhEzPkRUiqbaNDvaJ9oSr
	DFHQfu237sJf/VAHMkrOuV55laaylOvgIbg+OMOitUX12LI9GA8d67LLxVSoQUebXMylrK
	ZR69Eh2ifP668eRisCIHdqyB2FHwehw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706613353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+OQ1bCF/HA8s2JUmEwbhXiDyJh9rd41WXFOaLCe3q/U=;
	b=Y46nuuz/iBKzdbyJIaAipdLauaXAHfII8sF5/k+jxsw4JEJccNJu+RU7WASk6pd9PeHNpN
	WNnTPyPQ0WdmL/Bg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CD97B13212;
	Tue, 30 Jan 2024 11:15:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id f9oqMmnauGVlCwAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 30 Jan 2024 11:15:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5C9E7A0807; Tue, 30 Jan 2024 12:15:53 +0100 (CET)
Date: Tue, 30 Jan 2024 12:15:53 +0100
From: Jan Kara <jack@suse.cz>
To: Kees Cook <keescook@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] select: Avoid wrap-around instrumentation in
 do_sys_poll()
Message-ID: <20240130111553.yxm74p5q64pyuurs@quack3>
References: <20240129184014.work.593-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129184014.work.593-kees@kernel.org>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iGTFcS83;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Y46nuuz/"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,chromium.org:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -5.51
X-Rspamd-Queue-Id: DAA4C1F846
X-Spam-Flag: NO

On Mon 29-01-24 10:40:15, Kees Cook wrote:
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
> Link: https://github.com/KSPP/linux/issues/26 [1]
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Yeah, good cleanup. Feel free to add:

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

