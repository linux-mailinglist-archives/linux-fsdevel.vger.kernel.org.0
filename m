Return-Path: <linux-fsdevel+bounces-78871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aL3KDxdVpWnR9AUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 10:15:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7251D5606
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 10:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCA87302EA9F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 09:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D7F38E106;
	Mon,  2 Mar 2026 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gy3YI4c/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vKrhrjxe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bOOHWhwH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jl1vtw9k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A583D38CFF3
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772442691; cv=none; b=gL5N/uKcKZYx+AzR38mjM2HLMsAZslGk1hQgoPmxoJxyy2keUdGKJ/hX6Y7XJjWv4VQ7631gXPCAomvXbzcy/nts0son1cca1CKikReHR8reFAqJBzAFjvxo2cQMtqMm90S5PvDHZ8n/hKhcsZpyTcZ6fgziRQ22ucE0BcNXna4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772442691; c=relaxed/simple;
	bh=mvQLTwmrSD8dspK32eKTIahwi/9lhspVJ31hBeGRhCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+tz4jHTKd2bWaGywV1hz/4Njl95Se8wCtIwzrOcXDAMPTSwpploObmaAWoEuO1C8w0H9ofUFomHutSWP38DEtTPuyxz9JNVPFxtMwwUS015UgD9hQyHwW95HFneYx06oVy/XGyMarw1JhOTZddnNbuy8TFK+9X12d3k3FfEu3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gy3YI4c/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vKrhrjxe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bOOHWhwH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jl1vtw9k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D28C83E847;
	Mon,  2 Mar 2026 09:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772442688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vAnmRLMm8a2fR89ZeXIizBJSqoFgJNl3qhftcyIkWPs=;
	b=Gy3YI4c/TA5IPlDYK/sR9YAq7mKf4gdDPZXpcrAycscCVHGhZ+MIbmoRz60ax+tZLE6VNI
	VuiiOlNONvwt+fCCPsPOSpleSdUf6opje+n8qn7i+dUCXfDcdXCAwXLnRgdy+enHoNE6nD
	O6ylxNNedFo1d/HFn8wt+Z8uspK4e3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772442688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vAnmRLMm8a2fR89ZeXIizBJSqoFgJNl3qhftcyIkWPs=;
	b=vKrhrjxeQ7Nv+IrOBKPcHIu8uF3ffMnbXQm2oJwIme8zxNGosBGXgsaQ69xARhqGjcGr9c
	tb9x1hg/rmPBI9Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772442687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vAnmRLMm8a2fR89ZeXIizBJSqoFgJNl3qhftcyIkWPs=;
	b=bOOHWhwHHl7EkUzBk5e9XNf9DdNQygJO1DSqd4VFEq4JKe2xShPDpedsnCxTtWye42Ukhd
	qQ68F546vbiZObAyu3DiS0PBeIcSUMzNAsQyDKUP5EHxNEPsh4pu3raM4i3P6B1QeW7cm9
	c6FZAsnUXJ1tsgyMhRFZr08ew6PPUKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772442687;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vAnmRLMm8a2fR89ZeXIizBJSqoFgJNl3qhftcyIkWPs=;
	b=Jl1vtw9kkBwXJbPBFO2LkD5OfmmoruLfHAjXA1LmOzHqVpqBGmp86yyDD/OcXa1dS3HlXl
	GJnbiyyY4xwSBHCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A56403EA69;
	Mon,  2 Mar 2026 09:11:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Rp1eKD9UpWm/XgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Mar 2026 09:11:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 56F97A0AAA; Mon,  2 Mar 2026 10:11:19 +0100 (CET)
Date: Mon, 2 Mar 2026 10:11:19 +0100
From: Jan Kara <jack@suse.cz>
To: Tal Zussman <tz2294@columbia.edu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH RFC v3 1/2] filemap: defer dropbehind invalidation from
 IRQ context
Message-ID: <wen63cjbk3k54mjzgw7zftsuze6bzxmdk5u5wdjabzdiqg645k@67666k5lrevh>
References: <20260227-blk-dontcache-v3-0-cd309ccd5868@columbia.edu>
 <20260227-blk-dontcache-v3-1-cd309ccd5868@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-blk-dontcache-v3-1-cd309ccd5868@columbia.edu>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:dkim,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78871-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AD7251D5606
X-Rspamd-Action: no action

On Fri 27-02-26 11:41:07, Tal Zussman wrote:
> folio_end_dropbehind() is called from folio_end_writeback(), which can
> run in IRQ context through buffer_head completion.
> 
> Previously, when folio_end_dropbehind() detected !in_task(), it skipped
> the invalidation entirely. This meant that folios marked for dropbehind
> via RWF_DONTCACHE would remain in the page cache after writeback when
> completed from IRQ context, defeating the purpose of using it.
> 
> Fix this by adding folio_end_dropbehind_irq() which defers the
> invalidation to a workqueue. The folio is added to a per-cpu folio_batch
> protected by a local_lock, and a work item pinned to that CPU drains the
> batch. folio_end_writeback() dispatches between the task and IRQ paths
> based on in_task().
> 
> A CPU hotplug dead callback drains any remaining folios from the
> departing CPU's batch to avoid leaking folio references.
> 
> This unblocks enabling RWF_DONTCACHE for block devices and other
> buffer_head-based I/O.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Thanks for the patch. Couple of comments below:

> @@ -1613,26 +1617,131 @@ static void filemap_end_dropbehind(struct folio *folio)
>   * If folio was marked as dropbehind, then pages should be dropped when writeback
>   * completes. Do that now. If we fail, it's likely because of a big folio -
>   * just reset dropbehind for that case and latter completions should invalidate.
> + *
> + * When called from IRQ context (e.g. buffer_head completion), we cannot lock
> + * the folio and invalidate. Defer to a workqueue so that callers like
> + * end_buffer_async_write() that complete in IRQ context still get their folios
> + * pruned.
> + */
> +struct dropbehind_batch {
> +	local_lock_t lock_irq;
> +	struct folio_batch fbatch;
> +	struct work_struct work;
> +};
> +
> +static DEFINE_PER_CPU(struct dropbehind_batch, dropbehind_batch) = {
> +	.lock_irq = INIT_LOCAL_LOCK(lock_irq),
> +};
> +
> +static void dropbehind_work_fn(struct work_struct *w)
> +{
> +	struct dropbehind_batch *db_batch;
> +	struct folio_batch fbatch;
> +
> +again:
> +	local_lock_irq(&dropbehind_batch.lock_irq);
> +	db_batch = this_cpu_ptr(&dropbehind_batch);
> +	fbatch = db_batch->fbatch;
> +	folio_batch_reinit(&db_batch->fbatch);
> +	local_unlock_irq(&dropbehind_batch.lock_irq);
> +
> +	for (int i = 0; i < folio_batch_count(&fbatch); i++) {
> +		struct folio *folio = fbatch.folios[i];
> +
> +		if (folio_trylock(folio)) {
> +			filemap_end_dropbehind(folio);
> +			folio_unlock(folio);
> +		}
> +		folio_put(folio);
> +	}

This logic of take folio batch and call filemap_end_dropbehind() for each
folio repeats twice in this patch - perhaps we can factor it out into a
helper function fbatch_end_dropbehind()?

> +
> +	/* Drain folios that were added while we were processing. */
> +	local_lock_irq(&dropbehind_batch.lock_irq);
> +	if (folio_batch_count(&db_batch->fbatch)) {
> +		local_unlock_irq(&dropbehind_batch.lock_irq);
> +		goto again;

I'm somewhat nervous from this potentially unbounded loop if someone is
able to feed folios into db_batch fast enough. That could hog the CPU for
quite a long time causing all sorts of interesting effects. If nothing else
we should abort this loop if need_resched() is true.

> +	}
> +	local_unlock_irq(&dropbehind_batch.lock_irq);
> +}
> +
> +/*
> + * Drain a dead CPU's dropbehind batch. The CPU is already dead so no
> + * locking is needed.
> + */
> +void dropbehind_drain_cpu(int cpu)
> +{
> +	struct dropbehind_batch *db_batch = per_cpu_ptr(&dropbehind_batch, cpu);
> +	struct folio_batch *fbatch = &db_batch->fbatch;
> +
> +	for (int i = 0; i < folio_batch_count(fbatch); i++) {
> +		struct folio *folio = fbatch->folios[i];
> +
> +		if (folio_trylock(folio)) {
> +			filemap_end_dropbehind(folio);
> +			folio_unlock(folio);
> +		}
> +		folio_put(folio);
> +	}
> +	folio_batch_reinit(fbatch);
> +}
> +
> +static void __init dropbehind_init(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct dropbehind_batch *db_batch = per_cpu_ptr(&dropbehind_batch, cpu);
> +
> +		folio_batch_init(&db_batch->fbatch);
> +		INIT_WORK(&db_batch->work, dropbehind_work_fn);
> +	}
> +}
> +
> +/*
> + * Must be called from task context. Use folio_end_dropbehind_irq() for
> + * IRQ context (e.g. buffer_head completion).
>   */
>  void folio_end_dropbehind(struct folio *folio)
>  {
>  	if (!folio_test_dropbehind(folio))
>  		return;
>  
> -	/*
> -	 * Hitting !in_task() should not happen off RWF_DONTCACHE writeback,
> -	 * but can happen if normal writeback just happens to find dirty folios
> -	 * that were created as part of uncached writeback, and that writeback
> -	 * would otherwise not need non-IRQ handling. Just skip the
> -	 * invalidation in that case.
> -	 */
> -	if (in_task() && folio_trylock(folio)) {
> +	if (folio_trylock(folio)) {
>  		filemap_end_dropbehind(folio);
>  		folio_unlock(folio);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(folio_end_dropbehind);
>  
> +/*
> + * In IRQ context we cannot lock the folio or call into the invalidation
> + * path. Defer to a workqueue. This happens for buffer_head-based writeback
> + * which runs from bio IRQ context.
> + */
> +static void folio_end_dropbehind_irq(struct folio *folio)
> +{
> +	struct dropbehind_batch *db_batch;
> +	unsigned long flags;
> +
> +	if (!folio_test_dropbehind(folio))
> +		return;
> +
> +	local_lock_irqsave(&dropbehind_batch.lock_irq, flags);
> +	db_batch = this_cpu_ptr(&dropbehind_batch);
> +
> +	/* If there is no space in the folio_batch, skip the invalidation. */
> +	if (!folio_batch_space(&db_batch->fbatch)) {
> +		local_unlock_irqrestore(&dropbehind_batch.lock_irq, flags);
> +		return;

Folio batches are relatively small (31 folios). With 4k folios it is very
easy to overflow the batch with a single IO completion. Large folios will
obviously make this less likely but I'm not sure reasonable working of
dropbehind should be dependent on large folios... Not sure how to best
address this though. We could use larger batches but that would mean using
our own array of folios instead of folio_batch.

> +	}
> +
> +	folio_get(folio);
> +	folio_batch_add(&db_batch->fbatch, folio);
> +	local_unlock_irqrestore(&dropbehind_batch.lock_irq, flags);
> +
> +	schedule_work_on(smp_processor_id(), &db_batch->work);
> +}
> +
>  /**
>   * folio_end_writeback_no_dropbehind - End writeback against a folio.
>   * @folio: The folio.
> @@ -1685,7 +1794,10 @@ void folio_end_writeback(struct folio *folio)
>  	 */
>  	folio_get(folio);
>  	folio_end_writeback_no_dropbehind(folio);
> -	folio_end_dropbehind(folio);
> +	if (in_task())
> +		folio_end_dropbehind(folio);
> +	else
> +		folio_end_dropbehind_irq(folio);

I think it would be more elegant to have folio_end_dropbehind() which based
on context decides whether to offload to workqueue or not. Because
folio_end_dropbehind() is never safe in irq context so I don't think it
makes sense to ever give users possibility to call it in wrong context.

>  	folio_put(folio);
>  }
>  EXPORT_SYMBOL(folio_end_writeback);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

