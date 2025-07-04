Return-Path: <linux-fsdevel+bounces-53921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F44AF8F49
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 11:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F11C17B601
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 09:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8592877CD;
	Fri,  4 Jul 2025 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W8riUqYc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k/5VTpYn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W8riUqYc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k/5VTpYn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8359D29A9ED
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751623003; cv=none; b=CGXR05s4NXzbF/yyRaQDwI7XsB3KTapzWRFBnf2onsYqeAfDvX8gVQ0PDH0ok5NjIiHkQ/7KJM0hyx7jEOkzqfzHJtTmlDH+gKMGJPdn6ifRXyQ1usHtcHvqD83zKAd49LAKhDA1NVogq2BjUTsVZFjAHI8i6xRqDybu5VwO7I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751623003; c=relaxed/simple;
	bh=HbU29xoVa7FiUlQtBhotoF69QXHZlT/HAFJiPJBj65I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhHPBvboCUegE5vdL1YupRT2VVD91D/FwEq9jQoSV54dEDCbmCQuzwy8OhcJEVa/TDAi22VkkUWxdZowFhjyKLDCm5kEpN9HHJVTLQx7OlpPBbOworja3AawCSSCkZOsBBRc63spCR147HnEWcMmvygsTSeWgrv0gOqObfR6Xs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W8riUqYc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k/5VTpYn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W8riUqYc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k/5VTpYn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7D14A1F456;
	Fri,  4 Jul 2025 09:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751622999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bWa/61o6pgkURWNaeDD+xZfcVGUHR11iGbJ4OVe8nt0=;
	b=W8riUqYcFlextEGd2ldZVAO5Zzw2Jn7DkfXvT3coY/vHr+TH5WUvuFSCkS6EEjtvowi+48
	yqN9A4JHOrdQ/kFcsrm4+XN/DjBSMYTr0bVCgW0I0BY3EW4Yz2i3h5Pi+/6poHaBt0ZUAL
	s3QwkT/7B7SpYZnG1zl2tJo6Wx6cDSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751622999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bWa/61o6pgkURWNaeDD+xZfcVGUHR11iGbJ4OVe8nt0=;
	b=k/5VTpYnizqNOP5bkyUEScNo+uObAy94/IOhoI6L9429cL06DanMyzPkmXAO9NviH8hfoI
	PEYys0CU1+LNasDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=W8riUqYc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="k/5VTpYn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751622999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bWa/61o6pgkURWNaeDD+xZfcVGUHR11iGbJ4OVe8nt0=;
	b=W8riUqYcFlextEGd2ldZVAO5Zzw2Jn7DkfXvT3coY/vHr+TH5WUvuFSCkS6EEjtvowi+48
	yqN9A4JHOrdQ/kFcsrm4+XN/DjBSMYTr0bVCgW0I0BY3EW4Yz2i3h5Pi+/6poHaBt0ZUAL
	s3QwkT/7B7SpYZnG1zl2tJo6Wx6cDSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751622999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bWa/61o6pgkURWNaeDD+xZfcVGUHR11iGbJ4OVe8nt0=;
	b=k/5VTpYnizqNOP5bkyUEScNo+uObAy94/IOhoI6L9429cL06DanMyzPkmXAO9NviH8hfoI
	PEYys0CU1+LNasDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EBF113757;
	Fri,  4 Jul 2025 09:56:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Yb8EG1elZ2hOLwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 04 Jul 2025 09:56:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 244AAA0A31; Fri,  4 Jul 2025 11:56:39 +0200 (CEST)
Date: Fri, 4 Jul 2025 11:56:39 +0200
From: Jan Kara <jack@suse.cz>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Ian Kent <raven@themaw.net>, Eric Sandeen <sandeen@redhat.com>
Subject: Re: [RFC PATCH] fanotify: add watchdog for permission events
Message-ID: <eybdb3wqnod644u2nmmasd34uxhnjbvte4p2ued6dyy2vzt3sv@tsc4wysiypvr>
References: <20250703130539.1696938-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703130539.1696938-1-mszeredi@redhat.com>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,gmail.com,themaw.net,redhat.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 7D14A1F456
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Thu 03-07-25 15:05:37, Miklos Szeredi wrote:
> This is to make it easier to debug issues with AV software, which time and
> again deadlocks with no indication of where the issue comes from, and the
> kernel being blamed for the deadlock.  Then we need to analyze dumps to
> prove that the kernel is not in fact at fault.

I share the pain. I had to do quite some of these analyses myself :).
Luckily our support guys have trained to do the analysis themselves over
the years so it rarely reaches my table anymore.

> With this patch a warning is printed when permission event is received by
> userspace but not answered for more than 20 seconds.
> 
> The timeout is very coarse (20-40s) but I guess it's good enough for the
> purpose.

I'm not opposed to the idea (although I agree with Amir that it should be
tunable - we have /proc/sys/fs/fanotify/ for similar things). Just I'm not
sure it will have the desired deterring effect for fanotify users wanting
to blame the kernel. What usually convinces them is showing where their
tasks supposed to write reply to permission event (i.e., those that have
corresponding event fds in their fdtable) are blocked and hence they cannot
reply. But with some education I suppose it can work. After all the
messages you print contain the task responsible to answer which is already
helpful.

> +config FANOTIFY_PERM_WATCHDOG
> +       bool "fanotify permission event watchdog"
> +       depends on FANOTIFY_ACCESS_PERMISSIONS
> +       default n

As Amir wrote, I don't think we need a kconfig for this, configuration
through /proc/sys/fs/fanotify/ will be much more flexible.

> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index b44e70e44be6..8b60fbb9594f 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -438,10 +438,14 @@ FANOTIFY_ME(struct fanotify_event *event)
>  struct fanotify_perm_event {
>  	struct fanotify_event fae;
>  	struct path path;
> -	const loff_t *ppos;		/* optional file range info */
> +	union {
> +		const loff_t *ppos;	/* optional file range info */
> +		pid_t pid;		/* pid of task processing the event */
> +	};

I think Amir complained about the generic 'pid' name already. Maybe
processing_pid? Also I'd just get rid of the union. We don't have *that*
many permission events that 4 bytes would matter and possible interactions
between pre-content events and this watchdog using the same space make me
somewhat uneasy.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

