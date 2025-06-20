Return-Path: <linux-fsdevel+bounces-52337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F80FAE1ED4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 17:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A9016BABA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 15:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0752C08A2;
	Fri, 20 Jun 2025 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cbag4dDC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zld8YIzN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cbag4dDC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zld8YIzN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F5B283FE1
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 15:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433914; cv=none; b=q9l95kE9s9XFBgFFp3jOd2TrBuENQwH47G0FbntCVi+qGkXA70wCETK3uph9rGwK9Vf28ATLvLdTXzai5XDAlm6gH4WXqnRptD6aGXY6WB/M8QECTDn0CfonS6nOipf2Mlm8YCU8e9RACE0f9xNtPRjNd+tRHpe4HlmYyWIHbJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433914; c=relaxed/simple;
	bh=ZrUptEdABxFs/5MnRor0BnOtB3BDUH3E879Cc8cJJ5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtWDL9uKScvUhHzYrq+4MzERevN1pnss+BQf+ksaW6HWHls7eSxrIDWhpVg5D1fcCUOMP+WC4YH1zfD3xnIj4ZKStz6IVw7e2zqlmQFX13cJwPvjIm6IGaICdwYZU+JSF1Oj/YjKhI+T8RG2Ngds6NxAVRII5R10Xx2hSpOeSUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cbag4dDC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zld8YIzN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cbag4dDC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zld8YIzN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9662021170;
	Fri, 20 Jun 2025 15:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750433910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nqXKYQR9f7zL/VSVdOK9ms/f6Hq1Ltyehx6IqnlgoM0=;
	b=cbag4dDCeG5GrIiUl2DrbkWRws7PnGsqvHlQ358IkOVGdmgx9T8mHnMktdnsD6j2V/MZoM
	iAQrRPpB37Hl44eyleoTOp4GQ404nvTVTNioC2ddROPqfcRdIEavDSCrAO/dEDLYVIyhkm
	e1ZYxrC5EpJGcdNP4Ub3QTSKu8bfwq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750433910;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nqXKYQR9f7zL/VSVdOK9ms/f6Hq1Ltyehx6IqnlgoM0=;
	b=Zld8YIzNPcNoHEPLEz9uOP5jlFQptHrTNc6PABus54UhYjIrVQdhrsDJwNJfQfeQKlRdB7
	DbNGGTFtoSo5lQDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cbag4dDC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Zld8YIzN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750433910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nqXKYQR9f7zL/VSVdOK9ms/f6Hq1Ltyehx6IqnlgoM0=;
	b=cbag4dDCeG5GrIiUl2DrbkWRws7PnGsqvHlQ358IkOVGdmgx9T8mHnMktdnsD6j2V/MZoM
	iAQrRPpB37Hl44eyleoTOp4GQ404nvTVTNioC2ddROPqfcRdIEavDSCrAO/dEDLYVIyhkm
	e1ZYxrC5EpJGcdNP4Ub3QTSKu8bfwq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750433910;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nqXKYQR9f7zL/VSVdOK9ms/f6Hq1Ltyehx6IqnlgoM0=;
	b=Zld8YIzNPcNoHEPLEz9uOP5jlFQptHrTNc6PABus54UhYjIrVQdhrsDJwNJfQfeQKlRdB7
	DbNGGTFtoSo5lQDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 838E713736;
	Fri, 20 Jun 2025 15:38:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9MocIHaAVWhrYgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Jun 2025 15:38:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8DB27A08DD; Fri, 20 Jun 2025 17:38:25 +0200 (CEST)
Date: Fri, 20 Jun 2025 17:38:25 +0200
From: Jan Kara <jack@suse.cz>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: annotate suspected data race between
 poll_schedule_timeout() and pollwake()
Message-ID: <ot5jb6uppda6zqic6wzxwkhldocmar5ielslfdscigqj2rjxsu@gtr4n7uso5iy>
References: <20250620063059.1800689-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620063059.1800689-1-dmantipov@yandex.ru>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9662021170
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[yandex.ru];
	FREEMAIL_ENVRCPT(0.00)[yandex.ru];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01
X-Spam-Level: 

On Fri 20-06-25 09:30:59, Dmitry Antipov wrote:
> When running almost any select()/poll() workload intense enough,
> KCSAN is likely to report data races around using 'triggered' flag
> of 'struct poll_wqueues'. For example, running 'find /' on a tty
> console may trigger the following:
> 
> BUG: KCSAN: data-race in poll_schedule_timeout / pollwake
> 
> write to 0xffffc900030cfb90 of 4 bytes by task 97 on cpu 5:
>  pollwake+0xd1/0x130
>  __wake_up_common_lock+0x7f/0xd0
>  n_tty_receive_buf_common+0x776/0xc30
>  n_tty_receive_buf2+0x3d/0x60
>  tty_ldisc_receive_buf+0x6b/0x100
>  tty_port_default_receive_buf+0x63/0xa0
>  flush_to_ldisc+0x169/0x3c0
>  process_scheduled_works+0x6fe/0xf40
>  worker_thread+0x53b/0x7b0
>  kthread+0x4f8/0x590
>  ret_from_fork+0x28c/0x450
>  ret_from_fork_asm+0x1a/0x30
> 
> read to 0xffffc900030cfb90 of 4 bytes by task 5802 on cpu 4:
>  poll_schedule_timeout+0x96/0x160
>  do_sys_poll+0x966/0xb30
>  __se_sys_ppoll+0x1c3/0x210
>  __x64_sys_ppoll+0x71/0x90
>  x64_sys_call+0x3079/0x32b0
>  do_syscall_64+0xfa/0x3b0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> According to Jan, "there's no practical issue here because it is hard
> to imagine how the compiler could compile the above code using some
> intermediate values stored into 'triggered' or multiple fetches from
> 'triggered'". Nevertheless, silence KCSAN by using WRITE_ONCE() in
> __pollwake() and READ_ONCE() in poll_schedule_timeout(), respectively.
> 
> Link: https://lore.kernel.org/linux-fsdevel/bwx72orsztfjx6aoftzzkl7wle3hi4syvusuwc7x36nw6t235e@bjwrosehblty
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/select.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/select.c b/fs/select.c
> index 9fb650d03d52..082cf60c7e23 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -192,7 +192,7 @@ static int __pollwake(wait_queue_entry_t *wait, unsigned mode, int sync, void *k
>  	 * and is paired with smp_store_mb() in poll_schedule_timeout.
>  	 */
>  	smp_wmb();
> -	pwq->triggered = 1;
> +	WRITE_ONCE(pwq->triggered, 1);
>  
>  	/*
>  	 * Perform the default wake up operation using a dummy
> @@ -237,7 +237,7 @@ static int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
>  	int rc = -EINTR;
>  
>  	set_current_state(state);
> -	if (!pwq->triggered)
> +	if (!READ_ONCE(pwq->triggered))
>  		rc = schedule_hrtimeout_range(expires, slack, HRTIMER_MODE_ABS);
>  	__set_current_state(TASK_RUNNING);
>  
> -- 
> 2.49.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

