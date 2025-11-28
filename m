Return-Path: <linux-fsdevel+bounces-70135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 418D8C91CA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 12:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 969243489D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 11:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63DA30F537;
	Fri, 28 Nov 2025 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T7Fcl/yN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+2vBdcrj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hW7uJfSI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6MYUdJFH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB5B30CD93
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764329416; cv=none; b=RcK9CsUlWNzo81N2m3RogYf+y8RHVorHihW6ek350UePiz1McN2SQC3OPQnxTS87V0cTYBFPGFRFDY6oE1dW7FXKa5qqFIVRzrgTxJ6Qxh6IS+OIa37A2UaMmJGTJLJxwubWgCQAJMPuGQncGMyRL2mWYghc0z1DlL0q90pQQjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764329416; c=relaxed/simple;
	bh=OyRXGdJjpv2YGTxWOPPjGbMEuEXqdrLI0iSwATmCR2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBHJoUoqJPBBhEreBuFxiV5rzrP5U0TWLSh5/N5MrYfaeUDYin/Tb8VIl5CSWh/opBHnFhEhrdLNfieJiJmbrZyTMewwVKNkkP6LSf989ZucmvnQAdWmLPujm8ggP/7z3OFEPMYQvhrWxSvSPqyZtysRR0YFxdVbUzluWbAEIxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T7Fcl/yN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+2vBdcrj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hW7uJfSI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6MYUdJFH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 78A1C33704;
	Fri, 28 Nov 2025 11:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764329412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9oCccdBwgPDZW63qgG+gOIk2zak6WxihYzilxbcWdns=;
	b=T7Fcl/yNVn6TisaMooll8P68G9AbQsudE8iPA6lHRGf7i/eD2XwnG4kclstzdzNeY4qzTi
	DpUh1bI3vg4y+0R6LjfKcvyyHtMf9dVE4leQQe9MZXwiSGmnBfmkCaO8NlncDAFJm8aLiQ
	eR1K8gdJHJ1/6ONYGoLNN1Ytcy5+Lew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764329412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9oCccdBwgPDZW63qgG+gOIk2zak6WxihYzilxbcWdns=;
	b=+2vBdcrj2HtWKslcnbuwMulBXayfS3q1il+TrSeEpCdV5HuvLl83Bx9Uk/ma9mLtSgiHT1
	JXqJGcgzNOp3QBAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hW7uJfSI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6MYUdJFH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764329411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9oCccdBwgPDZW63qgG+gOIk2zak6WxihYzilxbcWdns=;
	b=hW7uJfSI4+SHfr47TGvtWOA/0RbQg10nkApp1EvmLu7sooDubMG3bvreqiOy/sVx1QPLrw
	qxTRbuBtsiJDlPCcSCcafuKVf9gObvS1XuHfynXS7/2+/sPyqGfGf9EQLuaT7npViUss7w
	NMjYPgvn63xA6AldG30l1foCnoExwsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764329411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9oCccdBwgPDZW63qgG+gOIk2zak6WxihYzilxbcWdns=;
	b=6MYUdJFHVms+/7CIlUkRPv50DFpNrC9CRtV4EzJN0rRnfDLASIk4Qjh1NxKU2FggQv2rau
	idCc6rREId8P15CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68CF83EA63;
	Fri, 28 Nov 2025 11:30:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TlGFGcOHKWnpMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 28 Nov 2025 11:30:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1EEE1A08BE; Fri, 28 Nov 2025 12:30:03 +0100 (CET)
Date: Fri, 28 Nov 2025 12:30:03 +0100
From: Jan Kara <jack@suse.cz>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+321168dfa622eda99689@syzkaller.appspotmail.com
Subject: Re: [PATCH] fanotify: Don't call fsnotify_destroy_group() when
 fsnotify_alloc_group() fails.
Message-ID: <xlywujl6hhu6nqntnimdcdwbh2okcqxknwzlt5j3p7kqi5uuy7@x3pkdhfkpwf7>
References: <20251127201618.2115275-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127201618.2115275-1-kuniyu@google.com>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[321168dfa622eda99689];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,gmail.com,google.com,vger.kernel.org,syzkaller.appspotmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,appspotmail.com:email,suse.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 78A1C33704

On Thu 27-11-25 20:16:15, Kuniyuki Iwashima wrote:
> syzbot reported the splat in __do_sys_fanotify_init(). [0]
> 
> The cited commit introduced the fsnotify_group class.
> 
> The constructor is fsnotify_alloc_group() and could fail,
> so the error is handled this way:
> 
> 	CLASS(fsnotify_group, group)(&fanotify_fsnotify_ops,
> 				     FSNOTIFY_GROUP_USER);
> 	if (IS_ERR(group))
> 		return PTR_ERR(group);
> 
> Even we return from the path, the destructor is triggered,
> and the condition does not take IS_ERR() into account.
> 
> 	if (_T) fsnotify_destroy_group(_T),
> 
> Thus, fsnotify_destroy_group() could be called for ERR_PTR().
> 
> Let's fix the condition to !IS_ERR_OR_NULL(_T).
> 
> [0]:
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
> CPU: 1 UID: 0 PID: 6016 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:210
> Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 e9 40 01 33 09 cc 66 66 66 66 66 66 2e
> RSP: 0018:ffffc90003147c10 EFLAGS: 00010207
> RAX: dffffc0000000000 RBX: ffffffff8b5a8b4e RCX: 707d8ea8101f1b00
> RDX: 0000000000000000 RSI: ffffffff8b5a8b4e RDI: 0000000000000003
> RBP: ffffffff824e37fd R08: 0000000000000001 R09: 0000000000000000
> R10: dffffc0000000000 R11: fffffbfff1c0c6f3 R12: 0000000000000000
> R13: 000000000000001c R14: 000000000000001c R15: 0000000000000001
> FS:  000055556de07500(0000) GS:ffff888125f8b000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f09c332b5a0 CR3: 00000000750b0000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  __kasan_check_byte+0x12/0x40 mm/kasan/common.c:572
>  kasan_check_byte include/linux/kasan.h:401 [inline]
>  lock_acquire+0x84/0x340 kernel/locking/lockdep.c:5842
>  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>  spin_lock include/linux/spinlock.h:351 [inline]
>  fsnotify_group_stop_queueing fs/notify/group.c:39 [inline]
>  fsnotify_destroy_group+0x8d/0x320 fs/notify/group.c:58
>  class_fsnotify_group_destructor fs/notify/fanotify/fanotify_user.c:1600 [inline]
>  __do_sys_fanotify_init fs/notify/fanotify/fanotify_user.c:1759 [inline]
>  __se_sys_fanotify_init+0x991/0xbc0 fs/notify/fanotify/fanotify_user.c:1607
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f09c338f749
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd8b6be3e8 EFLAGS: 00000246 ORIG_RAX: 000000000000012c
> RAX: ffffffffffffffda RBX: 00007f09c35e5fa0 RCX: 00007f09c338f749
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000f00
> RBP: 00007ffd8b6be440 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007f09c35e5fa0 R14: 00007f09c35e5fa0 R15: 0000000000000002
>  </TASK>
> Modules linked in:
> 
> Fixes: 3a6b564a6beb ("fanotify: convert fanotify_init() to FD_PREPARE()")
> Reported-by: syzbot+321168dfa622eda99689@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/6928b121.a70a0220.d98e3.0110.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks for fixing this! The patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/notify/fanotify/fanotify_user.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index be0a96ad4316..d0b9b984002f 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1598,10 +1598,10 @@ static struct hlist_head *fanotify_alloc_merge_hash(void)
>  }
>  
>  DEFINE_CLASS(fsnotify_group,
> -	      struct fsnotify_group *,
> -	      if (_T) fsnotify_destroy_group(_T),
> -	      fsnotify_alloc_group(ops, flags),
> -	      const struct fsnotify_ops *ops, int flags)
> +	     struct fsnotify_group *,
> +	     if (!IS_ERR_OR_NULL(_T)) fsnotify_destroy_group(_T),
> +	     fsnotify_alloc_group(ops, flags),
> +	     const struct fsnotify_ops *ops, int flags)
>  
>  /* fanotify syscalls */
>  SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
> -- 
> 2.52.0.158.g65b55ccf14-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

