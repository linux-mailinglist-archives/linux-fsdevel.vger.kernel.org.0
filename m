Return-Path: <linux-fsdevel+bounces-52165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0023AE0026
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 10:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515C1164632
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 08:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB05264F87;
	Thu, 19 Jun 2025 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j1Z91exI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uPch7lWf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j1Z91exI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uPch7lWf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A07264638
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750322650; cv=none; b=Nc9Fv7a39c40ZIEQsUXo8kkHZTH8gm+vLoYEoFP83AnDYPnqHe1k0GbKzKe+YFikZEpfHZ+odxoNJwti2zt3rNCj+ugctdBvRqfcYmaQ2e/OAI96YJUOgsP/Pl6K18afczNoCwyET0qoOpY/NYZ3nMfECGFy64g0aUM1oTOzdQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750322650; c=relaxed/simple;
	bh=+xVl6/jj9THBfshhuCt1K8ThjcHBk2h7Gbub1Jsx2LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SL6qVHolkdOQvhSopL1+UamhJrJ6GccLY2RkN9m4ylU5gMmVIWsvcDrYgav63Eqmbk5m7hwXifal6NnLLF5E13IZevWnZna8bMJuMbmoLa9oazsBgNr8r3YAT6Iuvr49Box8qE/ulQELhO1N7SifZpHVeYCyWHm1HGDEnbf0MDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j1Z91exI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uPch7lWf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j1Z91exI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uPch7lWf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5665421759;
	Thu, 19 Jun 2025 08:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750322647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t+86Xw7AZbDyJqESfIZuTTnEGlCQQdlNlBByXlPPoWg=;
	b=j1Z91exImAuSPKCeDMaCMc386FIiAxRGGVb7/eeYMZonGDrYipCsYhOVntkCxZyc5MkeKN
	4tI8xJhKVoi0NoQbfaeB++g2+WAS9EGDBqW84b0/wIWu9LigoFavmK9JXcPuceByB4yAT5
	BVYwOO9Zyn+OL0bX0w6bhLI06WqGhSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750322647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t+86Xw7AZbDyJqESfIZuTTnEGlCQQdlNlBByXlPPoWg=;
	b=uPch7lWfoRNLuQ8n1+y0URXq8rrHc31bZN95PtaZ/2OpV2Ep4DMIUONZgimXHivEPE2C39
	Mv3BE9CVuz3PdBCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750322647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t+86Xw7AZbDyJqESfIZuTTnEGlCQQdlNlBByXlPPoWg=;
	b=j1Z91exImAuSPKCeDMaCMc386FIiAxRGGVb7/eeYMZonGDrYipCsYhOVntkCxZyc5MkeKN
	4tI8xJhKVoi0NoQbfaeB++g2+WAS9EGDBqW84b0/wIWu9LigoFavmK9JXcPuceByB4yAT5
	BVYwOO9Zyn+OL0bX0w6bhLI06WqGhSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750322647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t+86Xw7AZbDyJqESfIZuTTnEGlCQQdlNlBByXlPPoWg=;
	b=uPch7lWfoRNLuQ8n1+y0URXq8rrHc31bZN95PtaZ/2OpV2Ep4DMIUONZgimXHivEPE2C39
	Mv3BE9CVuz3PdBCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D3DE13721;
	Thu, 19 Jun 2025 08:44:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id exyBDtfNU2gKOgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 19 Jun 2025 08:44:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E1C32A29F1; Thu, 19 Jun 2025 10:44:02 +0200 (CEST)
Date: Thu, 19 Jun 2025 10:44:02 +0200
From: Jan Kara <jack@suse.cz>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: On possible data race in pollwake() / poll_schedule_timeout()
Message-ID: <dpupr2pklrixvqtbgpj2oxlu5vexbaqmoc2r6s6y77v63wquhh@ruq6jpjrszja>
References: <d44bea2f-b9c4-4c68-92d3-fc33361e9d2b@yandex.ru>
 <bwx72orsztfjx6aoftzzkl7wle3hi4syvusuwc7x36nw6t235e@bjwrosehblty>
 <d2bd4e09-40d8-4b53-abf7-c20b4f81e095@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2bd4e09-40d8-4b53-abf7-c20b4f81e095@yandex.ru>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[yandex.ru];
	FREEMAIL_TO(0.00)[yandex.ru];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed 18-06-25 20:08:22, Dmitry Antipov wrote:
> On 6/18/25 6:20 PM, Jan Kara wrote:
> 
> > So KCSAN is really trigger-happy about issues like this. There's no
> > practical issue here because it is hard to imagine how the compiler could
> > compile the above code using some intermediate values stored into
> > 'triggered' or multiple fetches from 'triggered'. But for the cleanliness
> > of code and silencing of KCSAN your changes make sense.
> 
> Thanks. Surely I've read Documentation/memory-barriers.txt more than
> once, but, just for this particual case: is _ONCE() pair from the above
> expected to work in the same way as:

Firstly, I would not mess with this subtle code in unobvious ways unless
necessary ;)

> diff --git a/fs/select.c b/fs/select.c
> index 9fb650d03d52..1a4096fd3a95 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -191,8 +191,7 @@ static int __pollwake(wait_queue_entry_t *wait, unsigned mode, int sync, void *k
>          * smp_wmb() is equivalent to smp_wmb() in try_to_wake_up()
>          * and is paired with smp_store_mb() in poll_schedule_timeout.
>          */
> -       smp_wmb();
> -       pwq->triggered = 1;
> +       smp_store_release(&pwq->triggered, 1);

Yes, this should be equivalent AFAICS.

> @@ -237,7 +236,7 @@ static int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
>         int rc = -EINTR;
> 
>         set_current_state(state);
> -       if (!pwq->triggered)
> +       if (!smp_load_acquire(&pwq->triggered))

set_current_state() already contains a full barrier. Thus
smp_load_acquire() would add unnecessary overhead here AFAICT.

>                 rc = schedule_hrtimeout_range(expires, slack, HRTIMER_MODE_ABS);
>         __set_current_state(TASK_RUNNING);
> 
> @@ -252,7 +251,7 @@ static int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
>          * this problem doesn't exist for the first iteration as
>          * add_wait_queue() has full barrier semantics.
>          */
> -       smp_store_mb(pwq->triggered, 0);
> +       smp_store_release(&pwq->triggered, 0);

This is IMO wrong and would need very good explanation why you think this
is safe to do. Full barrier is stronger than just a RELEASE operation.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

