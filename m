Return-Path: <linux-fsdevel+bounces-52048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01432ADF113
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A2907ACC31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 15:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE262EF2B0;
	Wed, 18 Jun 2025 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gpJuuM03";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YkJ15pfo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gpJuuM03";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YkJ15pfo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478DC2EF2AF
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750260061; cv=none; b=t2nO2rGXry8F6Zfg/1TqkokYZ+vZZ2v4uoeFFcJDC/6Ovy4Lpu9Kjd8sodrHKRN93kEUm+VDmTftBXVyHIpfjCUlmrSM30Nz/7144JHrniGHZ7t4Io5B8hq94Wru1LwXVlEivy2FXjBlE3V0X6AXJIWgE7st4j3Pw7bO0Ght9u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750260061; c=relaxed/simple;
	bh=Rnpmjb6jVLpT8dXBAvSLWBke4tA7uo/B1qAsBf5X9RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgGZJWfNqjUplq3aGR/QBtFfVTezceQhEcIB3saFNZkCOYTVAq+j/TuK5c9Dg6NSbFWCJx6j4yoBODPUcEyCBIY9PvMwOdsHxx8AjZY+OqEDkMqcRHLfpR/e70X/xj3uvHNAzOWuhNVuVQR9BnLwE6a+ToiacKOY5Id1aSS/I1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gpJuuM03; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YkJ15pfo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gpJuuM03; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YkJ15pfo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 498301F7BD;
	Wed, 18 Jun 2025 15:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750260057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2/JSOQWxCQsFkrP8XUOlGOnQuTaF2z8JGkNKRKEdLY=;
	b=gpJuuM03u8WDoO+HFivE9VxDta9QtHzXefLTk/VdEc0Ey/oXrQK85lJQbMFcNpfW2nZHZg
	9H6nmeQpkU3dyZdAVRcnN563D8ZeTdTHGSIaG2SQnbwb2VhCUCKamj8ZnooFxBCGGmjB8A
	jsiL+1J7Nk9cLoi4+CIz1ofxBkkXFE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750260057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2/JSOQWxCQsFkrP8XUOlGOnQuTaF2z8JGkNKRKEdLY=;
	b=YkJ15pfov+U8iN3MhOiiGDdaFUHp/YLD9BoBTiSxuBNAQ1LaftJ+XJ94hLNCl+rcMRJ8im
	aQIUw7UUe9/5/BDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gpJuuM03;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YkJ15pfo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750260057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2/JSOQWxCQsFkrP8XUOlGOnQuTaF2z8JGkNKRKEdLY=;
	b=gpJuuM03u8WDoO+HFivE9VxDta9QtHzXefLTk/VdEc0Ey/oXrQK85lJQbMFcNpfW2nZHZg
	9H6nmeQpkU3dyZdAVRcnN563D8ZeTdTHGSIaG2SQnbwb2VhCUCKamj8ZnooFxBCGGmjB8A
	jsiL+1J7Nk9cLoi4+CIz1ofxBkkXFE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750260057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2/JSOQWxCQsFkrP8XUOlGOnQuTaF2z8JGkNKRKEdLY=;
	b=YkJ15pfov+U8iN3MhOiiGDdaFUHp/YLD9BoBTiSxuBNAQ1LaftJ+XJ94hLNCl+rcMRJ8im
	aQIUw7UUe9/5/BDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D8B613A3F;
	Wed, 18 Jun 2025 15:20:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ck/9DlnZUmhtDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 18 Jun 2025 15:20:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E0F97A09DC; Wed, 18 Jun 2025 17:20:56 +0200 (CEST)
Date: Wed, 18 Jun 2025 17:20:56 +0200
From: Jan Kara <jack@suse.cz>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: On possible data race in pollwake() / poll_schedule_timeout()
Message-ID: <bwx72orsztfjx6aoftzzkl7wle3hi4syvusuwc7x36nw6t235e@bjwrosehblty>
References: <d44bea2f-b9c4-4c68-92d3-fc33361e9d2b@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d44bea2f-b9c4-4c68-92d3-fc33361e9d2b@yandex.ru>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[yandex.ru];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[yandex.ru];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 498301F7BD
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Tue 17-06-25 14:04:37, Dmitry Antipov wrote:
> Running both syzbot reproducers and even during regular system boots,
> KCSAN is likely to report the data race around using 'triggered' flag
> of 'struct poll_wqueues'. Suspected race may be either read vs. write
> (observed locally during system boot):
> 
> BUG: KCSAN: data-race in poll_schedule_timeout / pollwake
> 
> write to 0xffffc90004397b90 of 4 bytes by task 5619 on cpu 4:
>  pollwake+0xd1/0x130
>  __wake_up_common_lock+0x7f/0xd0
>  sock_def_readable+0x20e/0x590
>  unix_dgram_sendmsg+0xa3a/0x1050
>  unix_seqpacket_sendmsg+0xdb/0x140
>  __sock_sendmsg+0x151/0x190
>  sock_write_iter+0x172/0x1c0
>  vfs_write+0x66d/0x6f0
>  ksys_write+0xe7/0x1b0
>  __x64_sys_write+0x4a/0x60
>  x64_sys_call+0x2f35/0x32b0
>  do_syscall_64+0xfa/0x3b0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> read to 0xffffc90004397b90 of 4 bytes by task 5620 on cpu 2:
>  poll_schedule_timeout+0x96/0x160
>  do_sys_poll+0x966/0xb30
>  __se_sys_ppoll+0x1c3/0x210
>  __x64_sys_ppoll+0x71/0x90
>  x64_sys_call+0x3079/0x32b0
>  do_syscall_64+0xfa/0x3b0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> value changed: 0x00000000 -> 0x00000001
> 
> or concurrent write (example taken from
> https://syzkaller.appspot.com/bug?extid=4c7af974f816af4ede2a):
> 
> BUG: KCSAN: data-race in pollwake / pollwake
> 
> write to 0xffffc90000e539e0 of 4 bytes by task 3308 on cpu 1:
>  __pollwake fs/select.c:195 [inline]
>  pollwake+0xb6/0x100 fs/select.c:215
>  __wake_up_common kernel/sched/wait.c:89 [inline]
>  __wake_up_common_lock kernel/sched/wait.c:106 [inline]
>  __wake_up_sync_key+0x4f/0x80 kernel/sched/wait.c:173
>  anon_pipe_write+0x8ba/0xaa0 fs/pipe.c:594
>  new_sync_write fs/read_write.c:593 [inline]
>  vfs_write+0x4a0/0x8e0 fs/read_write.c:686
>  ksys_write+0xda/0x1a0 fs/read_write.c:738
>  __do_sys_write fs/read_write.c:749 [inline]
>  __se_sys_write fs/read_write.c:746 [inline]
>  __x64_sys_write+0x40/0x50 fs/read_write.c:746
>  x64_sys_call+0x2cdd/0x2fb0 arch/x86/include/generated/asm/syscalls_64.h:2
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> write to 0xffffc90000e539e0 of 4 bytes by task 4163 on cpu 0:
>  __pollwake fs/select.c:195 [inline]
>  pollwake+0xb6/0x100 fs/select.c:215
>  __wake_up_common kernel/sched/wait.c:89 [inline]
>  __wake_up_common_lock kernel/sched/wait.c:106 [inline]
>  __wake_up_sync_key+0x4f/0x80 kernel/sched/wait.c:173
>  anon_pipe_write+0x8ba/0xaa0 fs/pipe.c:594
>  new_sync_write fs/read_write.c:593 [inline]
>  vfs_write+0x4a0/0x8e0 fs/read_write.c:686
>  ksys_write+0xda/0x1a0 fs/read_write.c:738
>  __do_sys_write fs/read_write.c:749 [inline]
>  __se_sys_write fs/read_write.c:746 [inline]
>  __x64_sys_write+0x40/0x50 fs/read_write.c:746
>  x64_sys_call+0x2cdd/0x2fb0 arch/x86/include/generated/asm/syscalls_64.h:2
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> value changed: 0x00000000 -> 0x00000001
> 
> Using _ONCE() seems makes KCSAN quiet, i.e.:
> 
> diff --git a/fs/select.c b/fs/select.c
> index 9fb650d03d52..082cf60c7e23 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -192,7 +192,7 @@ static int __pollwake(wait_queue_entry_t *wait, unsigned mode, int sync, void *k
>          * and is paired with smp_store_mb() in poll_schedule_timeout.
>          */
>         smp_wmb();
> -       pwq->triggered = 1;
> +       WRITE_ONCE(pwq->triggered, 1);
> 
>         /*
>          * Perform the default wake up operation using a dummy
> @@ -237,7 +237,7 @@ static int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
>         int rc = -EINTR;
> 
>         set_current_state(state);
> -       if (!pwq->triggered)
> +       if (!READ_ONCE(pwq->triggered))
>                 rc = schedule_hrtimeout_range(expires, slack, HRTIMER_MODE_ABS);
>         __set_current_state(TASK_RUNNING);
> 
> but I'm curious whether this is a real fix for the real bug or
> KCSAN is just unable to handle smp_wmb()/smp_store_mb() trick.

So KCSAN is really trigger-happy about issues like this. There's no
practical issue here because it is hard to imagine how the compiler could
compile the above code using some intermediate values stored into
'triggered' or multiple fetches from 'triggered'. But for the cleanliness
of code and silencing of KCSAN your changes make sense.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

