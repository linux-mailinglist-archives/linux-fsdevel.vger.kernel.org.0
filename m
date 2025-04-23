Return-Path: <linux-fsdevel+bounces-47083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD33A986F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 12:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5240C3B063D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 10:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265E226D4F2;
	Wed, 23 Apr 2025 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y2hEvVj4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vs5Q0MW2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xax/DTfg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="swnaPlWm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A1126C3A5
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403213; cv=none; b=bjH0xmCnazwudck5gKtOHxiCwr4zsCY9284UOzgf4MAkJ+iDc7B6/VOjMwW2dRPB+6IKg4+D3Y6KU77Lt+Pk8WEHYtBph7J6G0va0N4SMKnPxjtnvNRM5qngi+NswvCnh2s3RdiZbkbaMJXUhKGsjRQg772Okh0oLCb9Nqh5dWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403213; c=relaxed/simple;
	bh=EY1Mr4B96gj5KSTR7is5KoHCMgY8GoGZWEnrIBr9rSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIbOmnwT96dm14CQVteJLn+BdQ1+RUElXC+DsQHTpKiad1zLwkO6yD5+nRxzLN3Vv9Aj4LwFPG9ff+56Wc9agAfTf+7ciyJ3FdyVbRzQpzcyhLsGcKhumphbE88p6UYHrmJS8ddyufI6ccD/d247MD5Sh9A+r9CDnnuzg8nO7P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y2hEvVj4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vs5Q0MW2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xax/DTfg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=swnaPlWm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D94AD211AA;
	Wed, 23 Apr 2025 10:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745403210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=scvC0nxHQsvb9LvLM+uRWu+/QPrlkFfGmi7eUya2g+g=;
	b=Y2hEvVj42VjicWlUgFh98GXAAJsnxiM2snQGVgvz7sf7Otq2HbXhjH4DGW0N92oHbArHZs
	bdL00+oxOlRlLxmd2P92+4Me5X/FmPVkrTY2QJ4APxlxsMBhpZv/kzGP5VfVJSSAi7YdvM
	x65BtD5SJlWLa7N4Cd4+HhOSbqzgJQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745403210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=scvC0nxHQsvb9LvLM+uRWu+/QPrlkFfGmi7eUya2g+g=;
	b=Vs5Q0MW24G6eSoJcE2y8nAT7lkgpCsCQnGJsIR0Pkk5Y6CsIEAh/bbieG7+njCjxLfVscW
	sbJv9rps3DIO6KAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745403209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=scvC0nxHQsvb9LvLM+uRWu+/QPrlkFfGmi7eUya2g+g=;
	b=xax/DTfgSPtKw5GBvjVrkgg4ci0UyH1hHpAR9g27efwzTAqGIWLlgerra/YQERQ60CI7UF
	Min8JAtK6iFCJnBP1m6OrUNTvdv7Mi4aEPCGvqa3w+7jgRsJuiEjuk8fn9+d+LieI6xY+t
	qCu15PXn7ZwL6E/d4SGDlQg1PTopXH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745403209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=scvC0nxHQsvb9LvLM+uRWu+/QPrlkFfGmi7eUya2g+g=;
	b=swnaPlWmLUUTEvpw1Ky8mjNvt1hx0ltWKiP7zXNI1rYUmaftkIrB6swzp/NjCpehMH8ZTF
	qZB7b8nVReRkI7Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C65AE13691;
	Wed, 23 Apr 2025 10:13:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2fAmMEm9CGgWGwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 23 Apr 2025 10:13:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 863C6A07A7; Wed, 23 Apr 2025 12:13:29 +0200 (CEST)
Date: Wed, 23 Apr 2025 12:13:29 +0200
From: Jan Kara <jack@suse.cz>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: syzbot+de1498ff3a934ac5e8b4@syzkaller.appspotmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [RFC PATCH] fs/buffer: Handle non folio buffer case for
 drop_buffer()
Message-ID: <nfnwvcefhvm5sfrvlqqf4zcdq2iyzk4f2n366ux3bjatj7o4vl@5hq5evovwsxp>
References: <66fcb7f9.050a0220.f28ec.04e8.GAE@google.com>
 <20250423023703.632613-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423023703.632613-1-richard120310@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[de1498ff3a934ac5e8b4];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Wed 23-04-25 10:37:03, I Hsin Cheng wrote:
> When the folio doesn't have any buffers, "folio_buffers(folio)" will
> return NULL, causing "buffer_busy(bh)" to dereference a null pointer.
> Handle the case and jump to detach the folio if there's no buffer within
> it.
> 
> Reported-by: syzbot+de1498ff3a934ac5e8b4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=de1498ff3a934ac5e8b4
> Fixes: 6439476311a64 ("fs: Convert drop_buffers() to use a folio")
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> ---
> syzbot reported a null pointer dereference issue. [1]
> 
> If the folio be sent into "drop_buffer()" doesn't have any buffers,
> assigning "bh = head" will make "bh" to NULL, and the following
> operation of cleaning the buffer will encounter null pointer
> dereference.
> 
> I checked other use cases of "folio_buffers()", e.g. the one used in
> "buffer_check_dirty_writeback()" [2]. They generally use the same
> approach to check whether a folio_buffers() return NULL.
> 
> I'm not sure whether it's normal for a non-buffer folio to reach inside
> "drop_buffers()", if it's not maybe we have to dig more into the problem
> and find out where did the buffers of folio get freed or corrupted, let
> me know if that's needed and what can I test to help. I'm new to fs
> correct me if I'm wrong I'll be happy to learn, and know more about
> what's the expected behavior or correct behavior for a folio, thanks !

Thanks for the patch but try_to_free_buffers() is not expected to be called
when there are no buffers. Seeing the stacktrace below, it is unexpected it
got called because filemap_release_folio() calls folio_needs_release()
which should make sure there are indeed buffers attached.

Can you print more about the folio where this happened? In particular it
would be interesting what's in folio->flags, folio->mapping->flags and
folio->mapping->aops (resolved to a symbol). Because either the mapping has
AS_RELEASE_ALWAYS set but then we should have ->releasepage handler, or
have PG_Private bit set without buffers attached to a page but then again
either ->releasepage should be set or there's some bug in fs/buffer.c which
can set PG_Private without attaching buffers (I don't see where that could
be).

								Honza

> 
> [1]:
> BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:68 [inline]
> BUG: KASAN: null-ptr-deref in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
> BUG: KASAN: null-ptr-deref in buffer_busy fs/buffer.c:2881 [inline]
> BUG: KASAN: null-ptr-deref in drop_buffers+0x6f/0x710 fs/buffer.c:2893
> Read of size 4 at addr 0000000000000060 by task kswapd0/74
> 
> CPU: 0 UID: 0 PID: 74 Comm: kswapd0 Not tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_report+0xe8/0x550 mm/kasan/report.c:491
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>  instrument_atomic_read include/linux/instrumented.h:68 [inline]
>  atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
>  buffer_busy fs/buffer.c:2881 [inline]
>  drop_buffers+0x6f/0x710 fs/buffer.c:2893
>  try_to_free_buffers+0x295/0x5f0 fs/buffer.c:2947
>  shrink_folio_list+0x240c/0x8cc0 mm/vmscan.c:1432
>  evict_folios+0x549b/0x7b50 mm/vmscan.c:4583
>  try_to_shrink_lruvec+0x9ab/0xbb0 mm/vmscan.c:4778
>  shrink_one+0x3b9/0x850 mm/vmscan.c:4816
>  shrink_many mm/vmscan.c:4879 [inline]
>  lru_gen_shrink_node mm/vmscan.c:4957 [inline]
>  shrink_node+0x3799/0x3de0 mm/vmscan.c:5937
>  kswapd_shrink_node mm/vmscan.c:6765 [inline]
>  balance_pgdat mm/vmscan.c:6957 [inline]
>  kswapd+0x1ca3/0x3700 mm/vmscan.c:7226
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> 
> [2]:https://elixir.bootlin.com/linux/v6.14.3/source/fs/buffer.c#L97
> 
> Best regards,
> I Hsin Cheng
> ---
>  fs/buffer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index cc8452f60251..29fd17f78265 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2883,6 +2883,8 @@ drop_buffers(struct folio *folio, struct buffer_head **buffers_to_free)
>  	struct buffer_head *head = folio_buffers(folio);
>  	struct buffer_head *bh;
>  
> +	if (!head)
> +		goto detach_folio;
>  	bh = head;
>  	do {
>  		if (buffer_busy(bh))
> @@ -2897,6 +2899,7 @@ drop_buffers(struct folio *folio, struct buffer_head **buffers_to_free)
>  			__remove_assoc_queue(bh);
>  		bh = next;
>  	} while (bh != head);
> +detach_folio:
>  	*buffers_to_free = head;
>  	folio_detach_private(folio);
>  	return true;
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

