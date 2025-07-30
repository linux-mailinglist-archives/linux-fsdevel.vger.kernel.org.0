Return-Path: <linux-fsdevel+bounces-56324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B74DCB15E81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 12:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E749F18C539F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 10:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8DB292B48;
	Wed, 30 Jul 2025 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xMzmwMLc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4nq/T99R";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PAlx+ANF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9gSKyhV+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7321E230981
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753872761; cv=none; b=kvlq4zdVhhcMy4ZJggTFo9wrNOf+kK6TFrfsni97is4zr60u3nsa4iGiydvnePNHzDE5R7gT9Wjj7wjbCxIsR98JVnLutqaAI+y6XAVIHC//yqQgrUo/cD9UwiTfZSOlsNm0Ed0sJPh7beeJU33VaazZ/PD+blvxnqFLDFqKK30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753872761; c=relaxed/simple;
	bh=eFoOrlxqYnMnNvJOYUbqwIYNCizkzCg+QhTxHNXLwB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XV6kdOByVGriAWdVnnjINyfOnqjkjAa0joyA6JXfLHH4ni93yl/nBB0ERbx88ynA7D9WaTdhCcTOvRCCEgZ3DokW0DlXvaKAmccLL4hUJEC6FTT+JwJtSKab80QsS7Gm4ziHG2NBQrtroO/7JtyEfy9DhDQI3HmVRnpYdGVmymI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xMzmwMLc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4nq/T99R; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PAlx+ANF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9gSKyhV+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 581851F385;
	Wed, 30 Jul 2025 10:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753872756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wc301orRKr1+S2MHSitGz+H4D8xT/O9/Fr5lKe+1fVg=;
	b=xMzmwMLcoKXPtfbgpkf/K4eCDc1YzDSooDORkXwYVttd1tQt1qAdx8t1GdLObf70YfM7Br
	YWZFePc+V7ey4D1hietpdYYzGd4BYJxuEZH4RLZ9eru36KFRfFD3JfVnviPWl7jw2da/Lo
	fxPLJpYwNG3+lP6TAvmzy1zyTkMSIsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753872756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wc301orRKr1+S2MHSitGz+H4D8xT/O9/Fr5lKe+1fVg=;
	b=4nq/T99RBoCZ+02roVmFzZCPWVxe66TDZYDrJ4OKQhrwM7ij6GbQiYaJPCfTDyR+2XT3G1
	8E+W0ux6jBj6wkAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PAlx+ANF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9gSKyhV+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753872755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wc301orRKr1+S2MHSitGz+H4D8xT/O9/Fr5lKe+1fVg=;
	b=PAlx+ANFBpMSKJrPGTgslQJH3xcRppVjCCaYMA+IH1ciL/r1UMCHG3wIlZcOTUwuQp0zhW
	OoHrqHUuCJqKiRfR0iW5WjB76TYmKZkt4xEud326H8ldftr99AQfVhvBQTQey8AcOi6cD7
	frLA+06OY1zHcFIsWqkrAmj5mOPga7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753872755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wc301orRKr1+S2MHSitGz+H4D8xT/O9/Fr5lKe+1fVg=;
	b=9gSKyhV+RZlq3YDoYw0z24hRmKfSoN7LV2uWy+HwGQi9gzacSgCEH0He3/Pi29GkUPAmGs
	x2wmKA9lWlqxzjAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 484CA1388B;
	Wed, 30 Jul 2025 10:52:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8KenEXP5iWicBgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 30 Jul 2025 10:52:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F35BDA094F; Wed, 30 Jul 2025 12:52:30 +0200 (CEST)
Date: Wed, 30 Jul 2025 12:52:30 +0200
From: Jan Kara <jack@suse.cz>
To: Dai Junbing <daijunbing@vivo.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1 5/5] jbd2: Add TASK_FREEZABLE to kjournald2 thread
Message-ID: <uj22sykbnhfsbk7abj3rdul46uko5vvhq425kdbtkzsw5l5kqa@ixs245eozsfe>
References: <20250730014708.1516-1-daijunbing@vivo.com>
 <20250730014708.1516-6-daijunbing@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730014708.1516-6-daijunbing@vivo.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 581851F385
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Wed 30-07-25 09:47:06, Dai Junbing wrote:
> Set the TASK_FREEZABLE flag when the kjournald2 kernel thread sleeps
> during journal commit operations. This prevents premature wakeups
> during system suspend/resume cycles, avoiding unnecessary CPU wakeups
> and power consumption.
> 
> in this case, the original code:
> 
> 	prepare_to_wait(&journal->j_wait_commit, &wait,
>                	 TASK_INTERRUPTIBLE);
> 	if (journal->j_commit_sequence != journal->j_commit_request)
>         	should_sleep = 0;
> 
> 	transaction = journal->j_running_transaction;
> 	if (transaction && time_after_eq(jiffies, transaction->t_expires))
>         	should_sleep = 0;
> 	......
> 	......
> 	if (should_sleep) {
>         	write_unlock(&journal->j_state_lock);
>         	schedule();
>         	write_lock(&journal->j_state_lock);
> 	}
> 
> is functionally equivalent to the more concise:
> 
> 	write_unlock(&journal->j_state_lock);
> 	wait_event_freezable_exclusive(&journal->j_wait_commit,
>         	journal->j_commit_sequence == journal->j_commit_request ||
>         	(journal->j_running_transaction &&
>          	time_after_eq(jiffies, transaction->t_expires)) ||
>         	(journal->j_flags & JBD2_UNMOUNT));
> 	write_lock(&journal->j_state_lock);

This would be actually wrong because you cannot safely do some of the
dereferences without holding j_state_lock. Luckily you didn't modify the
existing code in the patch, just the changelog is bogus so please fix it.

> Signed-off-by: Dai Junbing <daijunbing@vivo.com>
> ---
>  fs/jbd2/journal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index d480b94117cd..9a1def9f730b 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -222,7 +222,7 @@ static int kjournald2(void *arg)
>  		DEFINE_WAIT(wait);
>  
>  		prepare_to_wait(&journal->j_wait_commit, &wait,
> -				TASK_INTERRUPTIBLE);
> +				TASK_INTERRUPTIBLE | TASK_FREEZABLE);

So this looks fine but I have one question. There's code like:

        if (freezing(current)) {
                /*
                 * The simpler the better. Flushing journal isn't a
                 * good idea, because that depends on threads that may
                 * be already stopped.
                 */
                jbd2_debug(1, "Now suspending kjournald2\n");
                write_unlock(&journal->j_state_lock);
                try_to_freeze();
                write_lock(&journal->j_state_lock);

a few lines above. Is it still needed after your change? I guess that
probably yes (e.g. when the freeze attempt happens while kjournald still
performs some work then the later schedule in TASK_FREEZABLE state doesn't
necessarily freeze the kthread). But getting a confirmation would be nice.

								Honza

>  		transaction = journal->j_running_transaction;
>  		if (transaction == NULL ||
>  		    time_before(jiffies, transaction->t_expires)) {
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

