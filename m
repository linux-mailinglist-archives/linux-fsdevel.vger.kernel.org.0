Return-Path: <linux-fsdevel+bounces-53208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312E0AEBE56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 19:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9E8172C4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 17:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17D62EAB6E;
	Fri, 27 Jun 2025 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KYJuMa3L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vGikfg2Y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KYJuMa3L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vGikfg2Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CED1DF244
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jun 2025 17:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751044686; cv=none; b=RcgWzPZhSrcx7S7WknrYl1yXsJ0BW6cQCF4XF4aCremsD32bEVV0LuiHWkfYPRceF2J1W3a294YdZJ5xTrKyGZLG9/ZnloTXuYwBm977TyDIlH6XeKWKejehhp2MPK7YwS8Grz0iStLn+S11miS8b3eHDmFyLk6JlV9AKyhzkwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751044686; c=relaxed/simple;
	bh=+WcgCcBM9YBnHxltS4K6Ixs+5eVYmkYXELdSvhf9FY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dC/EE7QpwV33fLJJrECYV6ds2cys80fspNJkRSXZYUS5GEF2GYBEiXLGZUiNnHAGGoLd6A6hBjOv8A+T+/i5PtQTZj22jUZyf5z1yLpG+Ck94iICc3QkwJO4BAe6FwBt64ijE/5MCPbJfpUdMlaapl2bp0G23bFUnNqY/10p0NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KYJuMa3L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vGikfg2Y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KYJuMa3L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vGikfg2Y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 14D391F38C;
	Fri, 27 Jun 2025 17:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751044677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nl+dS9SUMpF9YxSA7auDxNjb1F7gJjeIHJQRSlujoM8=;
	b=KYJuMa3LQMmP+qhqaLvrlYnu/O9cCTpJX3RqxJAVfrvN3zObzYUvpuJDUEHu1JUT+l/XQT
	FOXAtbDr02LT+o2EpLpSM0iC9sjnuWmP9F4jUJJObsaKepHyfQP5C7mTfebKrV69WZsVdX
	bdH80h0m5CXd8xI0Usx0hrkgdi4iOAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751044677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nl+dS9SUMpF9YxSA7auDxNjb1F7gJjeIHJQRSlujoM8=;
	b=vGikfg2YK5SHbtXw9NJUFeFHZM6hFK8v9rcrye5cCfTClY2lETTRIR+lpabK2fdNk4DYg5
	j8pspiQvMI+64lBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KYJuMa3L;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vGikfg2Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751044677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nl+dS9SUMpF9YxSA7auDxNjb1F7gJjeIHJQRSlujoM8=;
	b=KYJuMa3LQMmP+qhqaLvrlYnu/O9cCTpJX3RqxJAVfrvN3zObzYUvpuJDUEHu1JUT+l/XQT
	FOXAtbDr02LT+o2EpLpSM0iC9sjnuWmP9F4jUJJObsaKepHyfQP5C7mTfebKrV69WZsVdX
	bdH80h0m5CXd8xI0Usx0hrkgdi4iOAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751044677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nl+dS9SUMpF9YxSA7auDxNjb1F7gJjeIHJQRSlujoM8=;
	b=vGikfg2YK5SHbtXw9NJUFeFHZM6hFK8v9rcrye5cCfTClY2lETTRIR+lpabK2fdNk4DYg5
	j8pspiQvMI+64lBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1F43138A7;
	Fri, 27 Jun 2025 17:17:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AOi4OkTSXmgtAQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Jun 2025 17:17:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 78718A08D2; Fri, 27 Jun 2025 19:17:48 +0200 (CEST)
Date: Fri, 27 Jun 2025 19:17:48 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: sanitize handle_type values when reporting fid
Message-ID: <igu4lgxkuhod7xxdtgjxsllzy3dqtz6xmzunsqw2wcdc3pw4qb@jatnw37wylew>
References: <20250627104835.184495-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627104835.184495-1-amir73il@gmail.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 14D391F38C
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim]
X-Spam-Score: -4.01
X-Spam-Level: 

On Fri 27-06-25 12:48:35, Amir Goldstein wrote:
> Unlike file_handle, type and len of struct fanotify_fh are u8.
> Traditionally, filesystem return handle_type < 0xff, but there
> is no enforecement for that in vfs.
> 
> Add a sanity check in fanotify to avoid truncating handle_type
> if its value is > 0xff.
> 
> Fixes: 7cdafe6cc4a6 ("exportfs: check for error return value from exportfs_encode_*()")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Thanks. Added to my tree.

								Honza

> ---
> 
> Jan,
> 
> This cleanup is a followup to the review of FILEID_PIDFS.
> The Fixes commit is a bit misleading because there is no bug in the
> Fixes commit, it's a just a fix-it-better statement, which is
> practical for stable backporting.
> 
> Thanks,
> Amir.
> 
>  fs/notify/fanotify/fanotify.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 3083643b864b..bfe884d624e7 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -454,7 +454,13 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
>  	dwords = fh_len >> 2;
>  	type = exportfs_encode_fid(inode, buf, &dwords);
>  	err = -EINVAL;
> -	if (type <= 0 || type == FILEID_INVALID || fh_len != dwords << 2)
> +	/*
> +	 * Unlike file_handle, type and len of struct fanotify_fh are u8.
> +	 * Traditionally, filesystem return handle_type < 0xff, but there
> +	 * is no enforecement for that in vfs.
> +	 */
> +	BUILD_BUG_ON(MAX_HANDLE_SZ > 0xff || FILEID_INVALID > 0xff);
> +	if (type <= 0 || type >= FILEID_INVALID || fh_len != dwords << 2)
>  		goto out_err;
>  
>  	fh->type = type;
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

