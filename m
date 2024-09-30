Return-Path: <linux-fsdevel+bounces-30383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E1A98A8E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 17:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D976B1F23A54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 15:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B819C1925B3;
	Mon, 30 Sep 2024 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dTkt3XLZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="onFxhcP/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dTkt3XLZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="onFxhcP/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B828436D
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710978; cv=none; b=rtlv6XT/qm9kcg+Wktt2Pbx7bPur/hi1zmNIIOGiYSzFEod0IQDMZUDH1w+OB9+2SMKf7tDACaRuxJK1D/UemKfbQspvad9e3zD8fK6mxplFrI6lpRjXJdhPN8fCBTDfK1inRy8B+nWdRvEXG9v4TJp70FTIfEItnnPXvx5kfq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710978; c=relaxed/simple;
	bh=P+5FYCG0UEYAXpKEXDvBnLmGvVt6Inty/7b7Et/5Oqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3v4p8yf79f9l/q4aiihE718YgWz8k9R0SSziUUkPUR/thKLXkY+mlbddN+7hVliaoRUMOJOtDOZYc4yrjgePI4Q5/PaihTSUG+UrjrjIfPxsNs1VogMXWj8qdC/9VmwprgfjWr0eAF5MmUbr2DbQSulWua0QxBIrzke4Yl/qMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dTkt3XLZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=onFxhcP/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dTkt3XLZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=onFxhcP/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E207D21A73;
	Mon, 30 Sep 2024 15:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727710973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mGXO3G6iTndhUsRWtJwWC9Z/vhH6TRM7ZcZmyaXrjcM=;
	b=dTkt3XLZVVyQ0W9zbSEQwOax0LKxRGIm7fJz+YYgsb85EYoWoHIwHCqXTP+xRhWl33xu88
	NnKLDuFIFVCrgQV6I/p+0ljV0f8a0nG0nVRrjGW4tuLo/Oi+5RktK4+JAquYWlDEm0/l/W
	mowAff6KMwy1UZNdjpYgDc9ENjboewo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727710973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mGXO3G6iTndhUsRWtJwWC9Z/vhH6TRM7ZcZmyaXrjcM=;
	b=onFxhcP/4O2slIjE+hraqQggLkUg7dI1jB1y7MtfpxOQ7X19r19tCa4pH5XBw+Zr5i5BtN
	KP7zOPE32CJbYlAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727710973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mGXO3G6iTndhUsRWtJwWC9Z/vhH6TRM7ZcZmyaXrjcM=;
	b=dTkt3XLZVVyQ0W9zbSEQwOax0LKxRGIm7fJz+YYgsb85EYoWoHIwHCqXTP+xRhWl33xu88
	NnKLDuFIFVCrgQV6I/p+0ljV0f8a0nG0nVRrjGW4tuLo/Oi+5RktK4+JAquYWlDEm0/l/W
	mowAff6KMwy1UZNdjpYgDc9ENjboewo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727710973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mGXO3G6iTndhUsRWtJwWC9Z/vhH6TRM7ZcZmyaXrjcM=;
	b=onFxhcP/4O2slIjE+hraqQggLkUg7dI1jB1y7MtfpxOQ7X19r19tCa4pH5XBw+Zr5i5BtN
	KP7zOPE32CJbYlAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7170136CB;
	Mon, 30 Sep 2024 15:42:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yn2BNP3G+mYNKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 30 Sep 2024 15:42:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 72443A0845; Mon, 30 Sep 2024 17:42:49 +0200 (CEST)
Date: Mon, 30 Sep 2024 17:42:49 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Krishna Vivek Vitta <kvitta@microsoft.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: allow reporting errors on failure to open fd
Message-ID: <20240930154249.4oqs5cg4n6wzftzs@quack3>
References: <20240927125624.2198202-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927125624.2198202-1-amir73il@gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 27-09-24 14:56:24, Amir Goldstein wrote:
> When working in "fd mode", fanotify_read() needs to open an fd
> from a dentry to report event->fd to userspace.
> 
> Opening an fd from dentry can fail for several reasons.
> For example, when tasks are gone and we try to open their
> /proc files or we try to open a WRONLY file like in sysfs
> or when trying to open a file that was deleted on the
> remote network server.
> 
> Add a new flag FAN_REPORT_FD_ERROR for fanotify_init().
> For a group with FAN_REPORT_FD_ERROR, we will send the
> event with the error instead of the open fd, otherwise
> userspace may not get the error at all.
> 
> In any case, userspace will not know which file failed to
> open, so leave a warning in ksmg for further investigation.
> 
> Reported-by: Krishna Vivek Vitta <kvitta@microsoft.com>
> Closes: https://lore.kernel.org/linux-fsdevel/SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Jan,
> 
> This is my proposal for a slightly better UAPI for error reporting.
> I have a vague memory that we discussed this before and that you preferred
> to report errno in an extra info field (?), but I have a strong repulsion
> from this altenative, which seems like way over design for the case.

Hum, I don't remember a proposal for extra info field to hold errno. What I
rather think we talked about was that we would return only the successfully
formatted events, push back the problematic one and on next read from
fanotify group the first event will be the one with error so that will get
returned to userspace. Now this would work but I agree that from userspace
it is kind of difficult to know what went wrong when the read failed (were
the arguments somehow wrong, is this temporary or permanent problem, is it
the fd or something else in the event, etc.) so reporting the error in
place of fd looks like a more convenient option.

But I wonder: Do we really need to report the error code? We already have
FAN_NOFD with -1 value (which corresponds to EPERM), with pidfd we are
reporting FAN_EPIDFD when its open fails so here we could have FAN_EFD ==
-2 in case opening of fd fails for whatever reason?

>  	if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
>  	    path && path->mnt && path->dentry) {
>  		fd = create_fd(group, path, &f);
> -		if (fd < 0)
> -			return fd;
> +		/*
> +		 * Opening an fd from dentry can fail for several reasons.
> +		 * For example, when tasks are gone and we try to open their
> +		 * /proc files or we try to open a WRONLY file like in sysfs
> +		 * or when trying to open a file that was deleted on the
> +		 * remote network server.
> +		 *
> +		 * For a group with FAN_REPORT_FD_ERROR, we will send the
> +		 * event with the error instead of the open fd, otherwise
> +		 * Userspace may not get the error at all.
> +		 * In any case, userspace will not know which file failed to
> +		 * open, so leave a warning in ksmg for further investigation.
> +		 */
> +		if (fd < 0) {
> +			pr_warn_ratelimited("fanotify: create_fd(%pd2) failed err=%d\n",
> +					    path->dentry, fd);

This is triggerable only by priviledged user so it is not a huge issue but
it still seems wrong that we spam kernel logs with warnings on more or less
normal operation. It is unrealistic that userspace would scrape the logs to
extract these names and furthermove without full path they are not even
telling much. If anything, I'd be willing to accept pr_debug() here which
sysadmin can selectively enable to ease debugging.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

