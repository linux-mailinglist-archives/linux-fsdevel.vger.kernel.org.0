Return-Path: <linux-fsdevel+bounces-74824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEdKKmydcGlyYgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 10:33:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1397254722
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 10:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2F31845A7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 09:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676A53A641E;
	Wed, 21 Jan 2026 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z0WT1kFC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xwXvhIGf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z0WT1kFC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xwXvhIGf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A60933C197
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987347; cv=none; b=esTcFSQxooZDA7tvKgbspSTg+O65ny/6TqwTiNCdNNnsTdevTBpsHUXQloNJABtXt/Z8XyPpVimr1uzN/JtbjppyadBAxqLaXh76LZTe+N1u+YRvcCly/Ufwg/O4oxQ+nijfuwfbZSUcsEw/ggpxAQ8BCT9heFDfCnSZPx2OC1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987347; c=relaxed/simple;
	bh=MyJyFxhwIhr4IVIx7oUM2AIlBmnz8fUrm1GF+AoGSqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8c6copXC6U1POPql4q3tiMBS4frP3WTO4GI6UsYdgXzMK0zqgSu5KhpfvmyIEqsujI/zI0vWH3XzgY1/PrvKfl6lXRlWD9EbJwc7HjPj0+Gt0g3p3qROzRf+TpG/mW1oGoX6GyeqJyXZbsQzw8MHXnQOTDP+bswCYfIqkEMVQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z0WT1kFC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xwXvhIGf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z0WT1kFC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xwXvhIGf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6F9395BCD2;
	Wed, 21 Jan 2026 09:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768987343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9NKk9MHajUDADjWRtly80Zlsega5THMxMJ9/UTBvCGA=;
	b=z0WT1kFCshvD+ETO4UZvFsR+elFSoqF/mPEJGd3uuE0XSDXgBGu3ojEhUWjfgUTWu+01P5
	2fq4RRqUmTNX8mcs8sDVxXzX8JMf4uzpSHkaAh+j9HvcQhQ/4RcA2pm7E+tJn02rGxXhS6
	WCpbCX1SEVFbfjCYmMdsFL5woLZyKx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768987343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9NKk9MHajUDADjWRtly80Zlsega5THMxMJ9/UTBvCGA=;
	b=xwXvhIGfKadKVgXY21yKb96kDn05HGvocN73xYkyRmhxvGaxA4/MtQjd/DNGydpu/VVo3V
	LeeZ8mPmhbIqw9Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768987343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9NKk9MHajUDADjWRtly80Zlsega5THMxMJ9/UTBvCGA=;
	b=z0WT1kFCshvD+ETO4UZvFsR+elFSoqF/mPEJGd3uuE0XSDXgBGu3ojEhUWjfgUTWu+01P5
	2fq4RRqUmTNX8mcs8sDVxXzX8JMf4uzpSHkaAh+j9HvcQhQ/4RcA2pm7E+tJn02rGxXhS6
	WCpbCX1SEVFbfjCYmMdsFL5woLZyKx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768987343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9NKk9MHajUDADjWRtly80Zlsega5THMxMJ9/UTBvCGA=;
	b=xwXvhIGfKadKVgXY21yKb96kDn05HGvocN73xYkyRmhxvGaxA4/MtQjd/DNGydpu/VVo3V
	LeeZ8mPmhbIqw9Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 653033EA63;
	Wed, 21 Jan 2026 09:22:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 96OxGM+acGl0MwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Jan 2026 09:22:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 25733A09E9; Wed, 21 Jan 2026 10:22:23 +0100 (CET)
Date: Wed, 21 Jan 2026 10:22:23 +0100
From: Jan Kara <jack@suse.cz>
To: morton@suse.cz
Cc: bernd@bsbernd.com, Joanne Koong <joannelkoong@gmail.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] flex_proportions: Make fprop_new_period() hardirq safe
Message-ID: <zftwpsgfwct5bx55usazm6ulnthi4yvnhpaudtmby5tq2zf7zg@wz77c6nlvquv>
References: <20260121091355.14209-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121091355.14209-2-jack@suse.cz>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[bsbernd.com,gmail.com,szeredi.hu,vger.kernel.org,suse.cz];
	TAGGED_FROM(0.00)[bounces-74824-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bsbernd.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,suse.cz:email,suse.cz:dkim,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1397254722
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed 21-01-26 10:13:56, Jan Kara wrote:
> Bernd has reported a lockdep splat from flexible proportions code that
> is essentially complaining about the following race:
> 
> <timer fires>
> run_timer_softirq - we are in softirq context
>   call_timer_fn
>     writeout_period
>       fprop_new_period
>         write_seqcount_begin(&p->sequence);
> 
>         <hardirq is raised>
>         ...
>         blk_mq_end_request()
> 	  blk_update_request()
> 	    ext4_end_bio()
> 	      folio_end_writeback()
> 		__wb_writeout_add()
> 		  __fprop_add_percpu_max()
> 		    if (unlikely(max_frac < FPROP_FRAC_BASE)) {
> 		      fprop_fraction_percpu()
> 			seq = read_seqcount_begin(&p->sequence);
> 			  - sees odd sequence so loops indefinitely
> 
> Note that a deadlock like this is only possible if the bdi has
> configured maximum fraction of writeout throughput which is very rare
> in general but frequent for example for FUSE bdis. To fix this problem
> we have to make sure write section of the sequence counter is irqsafe.
> 
> Reported-by: Bernd Schubert <bernd@bsbernd.com>
> Link: https://lore.kernel.org/all/9b845a47-9aee-43dd-99bc-1a82bea00442@bsbernd.com/
> Signed-off-by: Jan Kara <jack@suse.cz>

Forgot to add some tags:

CC: stable@vger.kernel.org
Fixes: a91befde3503 ("lib/flex_proportions.c: remove local_irq_ops in fprop_new_period()")

								Honza

> ---
>  lib/flex_proportions.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/flex_proportions.c b/lib/flex_proportions.c
> index 84ecccddc771..012d5614efb9 100644
> --- a/lib/flex_proportions.c
> +++ b/lib/flex_proportions.c
> @@ -64,13 +64,14 @@ void fprop_global_destroy(struct fprop_global *p)
>  bool fprop_new_period(struct fprop_global *p, int periods)
>  {
>  	s64 events = percpu_counter_sum(&p->events);
> +	unsigned long flags;
>  
>  	/*
>  	 * Don't do anything if there are no events.
>  	 */
>  	if (events <= 1)
>  		return false;
> -	preempt_disable_nested();
> +	local_irq_save(flags);
>  	write_seqcount_begin(&p->sequence);
>  	if (periods < 64)
>  		events -= events >> periods;
> @@ -78,7 +79,7 @@ bool fprop_new_period(struct fprop_global *p, int periods)
>  	percpu_counter_add(&p->events, -events);
>  	p->period += periods;
>  	write_seqcount_end(&p->sequence);
> -	preempt_enable_nested();
> +	local_irq_restore(flags);
>  
>  	return true;
>  }
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

