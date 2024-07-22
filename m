Return-Path: <linux-fsdevel+bounces-24054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5117D938CB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 11:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7263C1C23DA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 09:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6748F16CD35;
	Mon, 22 Jul 2024 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uJ2nDHxe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="moeqspR6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uJ2nDHxe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="moeqspR6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04EF161314;
	Mon, 22 Jul 2024 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721642051; cv=none; b=TvXERL1krdJfCuA++vxcta1/JFnO78eqOg6GiCyWABUp+0tWaDXo208L0DW5BDK6FsrP6GpC76PPA57OEkA5EXcPNeq/I5vamc0m8f6EhOtwMOXC6m/nVDNaHvasvxYK0upksDVlUbzSMEFHnWQoAdJGZUULC+9Sz2OZA4s1FVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721642051; c=relaxed/simple;
	bh=7g9slfVu/3zr6gzxkjFec5Q3i7xKpfbdt5Yuc1ecpZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiGg5Zfbk7eTUwo4NHbT5MMtvzNRaKysDCbnGDc1Y1Nfs/Ly2HM7H7iRAub8cfa9oK2SQXKT+ZSah5ABu+EKl4FGK3S2yC2KlytoZsYyg5vWYhuME/fidUqHN401RqwRX8DH9x/O3ecEstGRkJ1uYAeVuhflIm0PqZe7xVqBxcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uJ2nDHxe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=moeqspR6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uJ2nDHxe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=moeqspR6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 02D2B21296;
	Mon, 22 Jul 2024 09:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721642048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9bGXVPhInfCB6EOUjhvchmco6bKWzE7hciyQg2JPAtQ=;
	b=uJ2nDHxexYtjqZHGkU8NmF5iVqpf07fKTminA6ZwPY84Yjt8D7tDVfcPcCgfbBQ73jBytt
	n84l4QW3ZioyB7NNRoDyPYGwSASc/yh0Bdrrv1l0eZVeVyRiHOtcfDUXrUs06EdR9zkAE3
	ot9FxRoUiccbYTUjADyYnlya22xVqKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721642048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9bGXVPhInfCB6EOUjhvchmco6bKWzE7hciyQg2JPAtQ=;
	b=moeqspR6dhDotj1FNokmi4zgXYZn7XWqJ/Dxa5Z1bWckRxCqM+IkfXGCqUP96dL/uVDuL2
	hAxqmTAQe4mKtbDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721642048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9bGXVPhInfCB6EOUjhvchmco6bKWzE7hciyQg2JPAtQ=;
	b=uJ2nDHxexYtjqZHGkU8NmF5iVqpf07fKTminA6ZwPY84Yjt8D7tDVfcPcCgfbBQ73jBytt
	n84l4QW3ZioyB7NNRoDyPYGwSASc/yh0Bdrrv1l0eZVeVyRiHOtcfDUXrUs06EdR9zkAE3
	ot9FxRoUiccbYTUjADyYnlya22xVqKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721642048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9bGXVPhInfCB6EOUjhvchmco6bKWzE7hciyQg2JPAtQ=;
	b=moeqspR6dhDotj1FNokmi4zgXYZn7XWqJ/Dxa5Z1bWckRxCqM+IkfXGCqUP96dL/uVDuL2
	hAxqmTAQe4mKtbDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBF3E138A7;
	Mon, 22 Jul 2024 09:54:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +9aUOT8snma6dAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Jul 2024 09:54:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A87E0A08BD; Mon, 22 Jul 2024 11:54:03 +0200 (CEST)
Date: Mon, 22 Jul 2024 11:54:03 +0200
From: Jan Kara <jack@suse.cz>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	paulmck@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] nsfs: Fix the missed rcu_read_unlock() invoking in
 ns_ioctl()
Message-ID: <20240722095403.dmnewl7g7ti6fqat@quack3>
References: <20240722085149.32479-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722085149.32479-1-qiang.zhang1211@gmail.com>
X-Spam-Score: 0.90
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.90 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Level: 

On Mon 22-07-24 16:51:49, Zqiang wrote:
> Currently, the syzbot report follow wanings:
> 
> Voluntary context switch within RCU read-side critical section!
> WARNING: CPU: 0 PID: 3460 at kernel/rcu/tree_plugin.h:330 rcu_note_context_switch+0x354/0x49c
> Call trace:
> rcu_note_context_switch+0x354/0x49c kernel/rcu/tree_plugin.h:330
> __schedule+0xb0/0x850 kernel/sched/core.c:6417
> __schedule_loop kernel/sched/core.c:6606 [inline]
> schedule+0x34/0x104 kernel/sched/core.c:6621
> do_notify_resume+0xe4/0x164 arch/arm64/kernel/entry-common.c:136
> exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
> exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
> el0_interrupt+0xc4/0xc8 arch/arm64/kernel/entry-common.c:797
> __el0_irq_handler_common+0x18/0x24 arch/arm64/kernel/entry-common.c:802
> el0t_64_irq_handler+0x10/0x1c arch/arm64/kernel/entry-common.c:807
> el0t_64_irq+0x19c/0x1a0 arch/arm64/kernel/entry.S:599
> 
> This happens when the tsk pointer is null and a call to rcu_read_unlock()
> is missed in ns_ioctl(), this commit therefore invoke rcu_read_lock()
> when tsk pointer is null.
> 
> Reported-by: syzbot+784d0a1246a539975f05@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=784d0a1246a539975f05
> Fixes: ca567df74a28 ("nsfs: add pid translation ioctls")
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Thanks for the fix but this should be already fixed by commit
280e36f0d5b9971 ("nsfs: use cleanup guard") that was recently merged
upstream.

								Honza

> ---
>  fs/nsfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index a4a925dce331..e228d06f0949 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -188,8 +188,10 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
>  			tsk = find_task_by_vpid(arg);
>  		else
>  			tsk = find_task_by_pid_ns(arg, pid_ns);
> -		if (!tsk)
> +		if (!tsk) {
> +			rcu_read_unlock();
>  			break;
> +		}
>  
>  		switch (ioctl) {
>  		case NS_GET_PID_FROM_PIDNS:
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

