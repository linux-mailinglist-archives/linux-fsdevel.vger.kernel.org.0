Return-Path: <linux-fsdevel+bounces-63536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B2BBC0E16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 11:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD99189EBB2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 09:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0802D7D35;
	Tue,  7 Oct 2025 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nJKa6aIW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ocGYT1lD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nJKa6aIW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ocGYT1lD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AD83207
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Oct 2025 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830156; cv=none; b=NEWgPcpsZ3BwM3JazdvMd6Yx4WrZv6V7zwBcQuj28P3t6r5PGwsCivV6D/cnBooBodfpw0gjQTeW1aWiPxx9IQWDMIOjxO52qSTWZ1X7sXRmTJoLB/gblshfljeQrTM+PXyamUah5dvHlsdAU41+nIqrVs1TpPChjAAc7vGPET0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830156; c=relaxed/simple;
	bh=SX9TtvEtaU8//eJjH2aNmHq9f1adN3qCNI44DgPCUKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qujgNBMg778j+d6FsEe0HXn2FAzDppwF9MrWTCSSVBGCYxksBNky4i8lze2bwCdhJYSWBYJp3ZtsO076ccfq0+9a8GQ/26VHIjZ08IMNr3VafjnsJEoUzd+VLQc+aA8jUlY4Z2/5qBDRQxjAyI9lhDviRSyHfuTG3VubzWn7s4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nJKa6aIW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ocGYT1lD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nJKa6aIW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ocGYT1lD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BFCEB33714;
	Tue,  7 Oct 2025 09:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759830152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7UB+baPB3fVGqfXkTIxd1Owd3tCnYWmAjahqNt3dhE4=;
	b=nJKa6aIWcGJvP51orLjq22qpHG06Xjx/VDdI6AaIWd4jfzGjXe52XIfbvKdnIad1VV8dtb
	LOjV7Dttap34z/r5Svk2sv6L8IxcL9Q07Se22W55LXO4591jxGFntDJwTrCm34AxqECsUR
	pOjq0lAiqEfzK1kMhRU4D1Xfe1l18MU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759830152;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7UB+baPB3fVGqfXkTIxd1Owd3tCnYWmAjahqNt3dhE4=;
	b=ocGYT1lDtNF4qgXl1QWuGJ8pYfAleeYHKj7yn+X76QofmHMW9X+7PpMawBwPORMbvlQqWV
	UGV9yGUSiEGDSvBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nJKa6aIW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ocGYT1lD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759830152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7UB+baPB3fVGqfXkTIxd1Owd3tCnYWmAjahqNt3dhE4=;
	b=nJKa6aIWcGJvP51orLjq22qpHG06Xjx/VDdI6AaIWd4jfzGjXe52XIfbvKdnIad1VV8dtb
	LOjV7Dttap34z/r5Svk2sv6L8IxcL9Q07Se22W55LXO4591jxGFntDJwTrCm34AxqECsUR
	pOjq0lAiqEfzK1kMhRU4D1Xfe1l18MU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759830152;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7UB+baPB3fVGqfXkTIxd1Owd3tCnYWmAjahqNt3dhE4=;
	b=ocGYT1lDtNF4qgXl1QWuGJ8pYfAleeYHKj7yn+X76QofmHMW9X+7PpMawBwPORMbvlQqWV
	UGV9yGUSiEGDSvBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4CC313693;
	Tue,  7 Oct 2025 09:42:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FyofLIjg5GjeUwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 07 Oct 2025 09:42:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 46DF8A0A58; Tue,  7 Oct 2025 11:42:32 +0200 (CEST)
Date: Tue, 7 Oct 2025 11:42:32 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Al Viro <viro@zeniv.linux.org.uk>, Yu Watanabe <watanabe.yu@gmail.com>
Subject: Re: [PATCH] coredump: fix core_pattern input validation
Message-ID: <avokp5ifxuojjgblw77bgdvrfyyrnjicijl4qj5yjmyd533b7g@sn4mpwz3g7bf>
References: <20251007-infizieren-zitat-f736f932b5c4@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007-infizieren-zitat-f736f932b5c4@brauner>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,zeniv.linux.org.uk,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: BFCEB33714
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Tue 07-10-25 11:32:42, Christian Brauner wrote:
> In be1e0283021e ("coredump: don't pointlessly check and spew warnings")
> we tried to fix input validation so it only happens during a write to
> core_pattern. This would avoid needlessly logging a lot of warnings
> during a read operation. However the logic accidently got inverted in
> this commit. Fix it so the input validation only happens on write and is
> skipped on read.
> 
> Fixes: be1e0283021e ("coredump: don't pointlessly check and spew warnings")
> Fixes: 16195d2c7dd2 ("coredump: validate socket name as it is written")
> Reported-by: Yu Watanabe <watanabe.yu@gmail.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/coredump.c | 2 +-
>  fs/exec.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/coredump.c b/fs/coredump.c
> index b5fc06a092a4..5c1c381ee380 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -1468,7 +1468,7 @@ static int proc_dostring_coredump(const struct ctl_table *table, int write,
>  	ssize_t retval;
>  	char old_core_pattern[CORENAME_MAX_SIZE];
>  
> -	if (write)
> +	if (!write)
>  		return proc_dostring(table, write, buffer, lenp, ppos);
>  
>  	retval = strscpy(old_core_pattern, core_pattern, CORENAME_MAX_SIZE);
> diff --git a/fs/exec.c b/fs/exec.c
> index 6b70c6726d31..4298e7e08d5d 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -2048,7 +2048,7 @@ static int proc_dointvec_minmax_coredump(const struct ctl_table *table, int writ
>  {
>  	int error = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>  
> -	if (!error && !write)
> +	if (!error && write)
>  		validate_coredump_safety();
>  	return error;
>  }
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

