Return-Path: <linux-fsdevel+bounces-73422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ACDD18A4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 13:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB6EA303370E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 12:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CFF38E5ED;
	Tue, 13 Jan 2026 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jjeDlUaw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T+m7KCVI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jjeDlUaw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T+m7KCVI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB8C28466C
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 12:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768306363; cv=none; b=hwhu8IJBYW+WxDb+wZkESkCdEplLENoeonqLsLSGhmhKsKppk+DqddvEHSpHq3+Yvm+wwAgJd00bXmdzWYXEz0Eto4K+f5pShubOhUg4nT8LX/bFk/iGVrYSnLGM5/uqumjUOIc2diGnqSJ3E9yeY7jPeB2zOdyO3qiObbi0aAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768306363; c=relaxed/simple;
	bh=AY8u6//aswwCxkN3XQtogWctMrxaNq5J1WULcup77ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9PUoDtFRALDTn47n+7fkoYF0Tpg200855soawX6fmQ7LqqGNdPMTB75D4AN7GQ31lPgrXcI0uMzVqcg1uQLYXyrXJbpwibF5plz+6h90jx8lyAhtE2G+kMzIeOPCJti9cVznFsB9SXIs3aJAcw9x8pWq7C/E2FWOsoaxBNJv4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jjeDlUaw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T+m7KCVI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jjeDlUaw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T+m7KCVI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 25C3F33684;
	Tue, 13 Jan 2026 12:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768306360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HkG9THnTGpiYgXkZKAKsLMh9TRlPW3i2vQeMDs667JQ=;
	b=jjeDlUawoXS9XxL0H07xFJxZTd07/Sw3LipRe5JQ2LfCOaDU8HQPd3XCNBy5V3JEOCcp7p
	whA0KlipdApKL56WY6kAa7kdkk3ol1toZFRg0II8Yww/cRWaLwl8HvANmL69zjisabmamD
	QbBM2A1Fv+IeqotfSrwYtwaNkFXXIfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768306360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HkG9THnTGpiYgXkZKAKsLMh9TRlPW3i2vQeMDs667JQ=;
	b=T+m7KCVIfhIODPuRqPf50y9Wez2INNJbkqZtAesg837tcotELN2YRq1OEW0hpbVTUwKh4t
	Z544eeVghq/j5SCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jjeDlUaw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=T+m7KCVI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768306360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HkG9THnTGpiYgXkZKAKsLMh9TRlPW3i2vQeMDs667JQ=;
	b=jjeDlUawoXS9XxL0H07xFJxZTd07/Sw3LipRe5JQ2LfCOaDU8HQPd3XCNBy5V3JEOCcp7p
	whA0KlipdApKL56WY6kAa7kdkk3ol1toZFRg0II8Yww/cRWaLwl8HvANmL69zjisabmamD
	QbBM2A1Fv+IeqotfSrwYtwaNkFXXIfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768306360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HkG9THnTGpiYgXkZKAKsLMh9TRlPW3i2vQeMDs667JQ=;
	b=T+m7KCVIfhIODPuRqPf50y9Wez2INNJbkqZtAesg837tcotELN2YRq1OEW0hpbVTUwKh4t
	Z544eeVghq/j5SCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1701A3EA63;
	Tue, 13 Jan 2026 12:12:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x4O3BLg2Zmn3RAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 13 Jan 2026 12:12:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D1608A08CF; Tue, 13 Jan 2026 13:12:31 +0100 (CET)
Date: Tue, 13 Jan 2026 13:12:31 +0100
From: Jan Kara <jack@suse.cz>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	zhaomengmeng@kylinos.cn, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [vfs/vfs.all PATCH] writeback: use round_jiffies_relative for
 dirtytime_work
Message-ID: <24hrsb5noiif6xfzyt3kqj2enrma6zzabdq6xoihezx4wqcll6@bifcu2vty5rg>
References: <20260113082614.231580-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113082614.231580-1-zhaomzhao@126.com>
X-Spam-Score: -4.01
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[126.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[126.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 25C3F33684
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Tue 13-01-26 16:26:14, Zhao Mengmeng wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> 
> The dirtytime_work is a background housekeeping task that flushes dirty
> inodes, using round_jiffies_relative() will allow kernel to batch this
> work with other aligned system tasks, reducing power consumption.
> 
> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index ea95f527aace..a32d354152d0 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2504,7 +2504,8 @@ static void wakeup_dirtytime_writeback(struct work_struct *w)
>  	}
>  	rcu_read_unlock();
>  	if (dirtytime_expire_interval)
> -		schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
> +		schedule_delayed_work(&dirtytime_work,
> +				      round_jiffies_relative(dirtytime_expire_interval * HZ));
>  }
>  
>  static int dirtytime_interval_handler(const struct ctl_table *table, int write,
> @@ -2536,7 +2537,8 @@ static const struct ctl_table vm_fs_writeback_table[] = {
>  static int __init start_dirtytime_writeback(void)
>  {
>  	if (dirtytime_expire_interval)
> -		schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
> +		schedule_delayed_work(&dirtytime_work,
> +				      round_jiffies_relative(dirtytime_expire_interval * HZ));
>  	register_sysctl_init("vm", vm_fs_writeback_table);
>  	return 0;
>  }
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

