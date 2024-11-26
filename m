Return-Path: <linux-fsdevel+bounces-35879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9679C9D93C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 10:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AF8CB264FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 09:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A84A1B0F30;
	Tue, 26 Nov 2024 09:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="13vWsjDH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="j/0VTlI7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SDIrGaJF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JUKaAptb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3CF17BB6;
	Tue, 26 Nov 2024 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732611910; cv=none; b=fN+96xz41fimvvADMN58HZ1b0cMU1L9g/Eu2Uxcm8hlLYpGhSLig7nkngFjhU1l89ilUWc5XTW5FCEz6drDH3urephy6NmbX3WK5I8C6RKQfdj1wEjcX0tMNJFLMgpAsaNaUKdY9nI8goyTLD9+W45/IMOSFUVvkdpOtfHJEPIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732611910; c=relaxed/simple;
	bh=/WMVsvejPM5SedIEZ9qbcp97P1LhcTtYG6MsBhrKCos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dL3xxV0GPp6ljK60ghB6GKwfcvUUCLRrIG1JckChH8vj6d+wxVoq/sTbuOYlMepC/5T4SvtbXkcIqU2CfkFGvBK3NS/4hPy8Qqm+SV7N3TPKrOAntqRy4TfO7/zsAneZ0eZ1nuxEYO1q/QyH4OZdaNCfx9TXWR3Geiqjd8Dq8nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=13vWsjDH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=j/0VTlI7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SDIrGaJF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JUKaAptb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E6FA11F457;
	Tue, 26 Nov 2024 09:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732611898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5f2eYYsgbnilvvGv6kfWZlrURuKYE01nYMXFSZO+CyA=;
	b=13vWsjDHYhzBdkOBOoIQkx+BvDRwbpr2ckJZHYzqPlkTOteDMLKN0gZFYMhHdOVPi/rOZR
	J8r8zdtq8C4cLlSdcQLKRs1QVETa65EwLozWKdwTuBPLNS3x+7gXY6GEEDoja+vG8sNNyM
	TUBIHfTczZmHZB0kYc2FSSw23X3/Vjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732611898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5f2eYYsgbnilvvGv6kfWZlrURuKYE01nYMXFSZO+CyA=;
	b=j/0VTlI7AqtNlJi9JfRfu1dVpcmDT0no/zhK9WpEVWJdRV9WaRQBVfgP8TmWHLrcyAxR7z
	ySIn+Zr7nYydLNDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SDIrGaJF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JUKaAptb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732611892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5f2eYYsgbnilvvGv6kfWZlrURuKYE01nYMXFSZO+CyA=;
	b=SDIrGaJFSoldVSKU7nrTtrHBmgysZ733lurbpggrrr4ZJRil47McBPVjHWaJ2QRNVCsPOF
	ILnHoCm/P040GUV3YEUIHfQwuv60c8Qus4q2U5x2Wy0/nxzwIqaj4c4zajTiZxGFNO4bl4
	RUvQtCO/MGEdcAI8nHJtwM/xE7EiEs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732611892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5f2eYYsgbnilvvGv6kfWZlrURuKYE01nYMXFSZO+CyA=;
	b=JUKaAptbJW2PELHPxN8u8f4fKPEplHyIdYtrawAecksFnjjLgmmGcAiF1ztINIYDwkUXrO
	W7Tei+zun/R1A8Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7E5713890;
	Tue, 26 Nov 2024 09:04:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EpZpNDSPRWcDfgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 26 Nov 2024 09:04:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8E42CA08CA; Tue, 26 Nov 2024 10:04:52 +0100 (CET)
Date: Tue, 26 Nov 2024 10:04:52 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Baokun Li <libaokun1@huawei.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 2/2] ext4: protect ext4_release_dquot against freezing
Message-ID: <20241126090452.ohggr3daqskllxjk@quack3>
References: <20241121123855.645335-1-ojaswin@linux.ibm.com>
 <20241121123855.645335-3-ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121123855.645335-3-ojaswin@linux.ibm.com>
X-Rspamd-Queue-Id: E6FA11F457
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,gmail.com,huawei.com,suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[suse.cz:server fail];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[suse.cz:server fail,suse.com:query timed out];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Thu 21-11-24 18:08:55, Ojaswin Mujoo wrote:
> Protect ext4_release_dquot against freezing so that we
> don't try to start a transaction when FS is frozen, leading
> to warnings.
> 
> Further, avoid taking the freeze protection if a transaction
> is already running so that we don't need end up in a deadlock
> as described in
> 
>   46e294efc355 ext4: fix deadlock with fs freezing and EA inodes
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks good to me (the 0-day reports seem to be due to wrong merge). Feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 16a4ce704460..f7437a592359 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6887,12 +6887,25 @@ static int ext4_release_dquot(struct dquot *dquot)
>  {
>  	int ret, err;
>  	handle_t *handle;
> +	bool freeze_protected = false;
> +
> +	/*
> +	 * Trying to sb_start_intwrite() in a running transaction
> +	 * can result in a deadlock. Further, running transactions
> +	 * are already protected from freezing.
> +	 */
> +	if (!ext4_journal_current_handle()) {
> +		sb_start_intwrite(dquot->dq_sb);
> +		freeze_protected = true;
> +	}
>  
>  	handle = ext4_journal_start(dquot_to_inode(dquot), EXT4_HT_QUOTA,
>  				    EXT4_QUOTA_DEL_BLOCKS(dquot->dq_sb));
>  	if (IS_ERR(handle)) {
>  		/* Release dquot anyway to avoid endless cycle in dqput() */
>  		dquot_release(dquot);
> +		if (freeze_protected)
> +			sb_end_intwrite(dquot->dq_sb);
>  		return PTR_ERR(handle);
>  	}
>  	ret = dquot_release(dquot);
> @@ -6903,6 +6916,10 @@ static int ext4_release_dquot(struct dquot *dquot)
>  	err = ext4_journal_stop(handle);
>  	if (!ret)
>  		ret = err;
> +
> +	if (freeze_protected)
> +		sb_end_intwrite(dquot->dq_sb);
> +
>  	return ret;
>  }
>  
> -- 
> 2.43.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

