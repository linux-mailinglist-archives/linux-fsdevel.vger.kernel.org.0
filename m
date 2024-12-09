Return-Path: <linux-fsdevel+bounces-36778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707009E93E2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 13:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54BA163444
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 12:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAFD224AE3;
	Mon,  9 Dec 2024 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hDV+qciK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DC+e+KmZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hDV+qciK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DC+e+KmZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AE021D008;
	Mon,  9 Dec 2024 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747217; cv=none; b=htKJ7UacVR+6lCv2vHv6+cOk8DMGWEG1ViWUdTDkk3ruBzHQxn9OE8uTzWgT/4vgqdcYiaCwVw7GZx+wVAmrynF1XOm5c2qsOAt3J3nXfH2Wqm414Sox0dafXihJY3KT2q0GqvFLMnM2psDO4qWIQS/3Dq49G9RneDNnqrB5XDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747217; c=relaxed/simple;
	bh=EXuffNypYZQBoi7xXVEosmidvBHnO0T9iy/3eDyUUck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bu6rP2iCXG4j/4w7UITNeAwUeGbEBD4GARwKVCqamBck7aREcwlYERzXBhBKLtoaNGmoDVB4ApSEwGbb0VZdd8EO632VfOELjioeXh6zzG1VlJWurM4qru5slNjHdxaOyHoZAuW4A0YY+vmNOt6nfBFXky717Q8GV0DbMKWk5wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hDV+qciK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DC+e+KmZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hDV+qciK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DC+e+KmZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5561821170;
	Mon,  9 Dec 2024 12:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733747213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=39v1UJM0wPzy1yOKPoun+15gHceKb1wHaTEtw27KJCc=;
	b=hDV+qciKDx6oL68xDXqrcCyLSYXGtcrbJz1IvjJt1bTUtS1M9m6tle3UhEWz7CXfNDOfEF
	jqTyg25TrY0zcuBP68b3+6amX27gggg4Pvub3o65w0d+JflnpGHUTRDNHmBTp5nZ//D/Ae
	AIJXtnr5nQwq3RcG7FyQ9f5aE9W1mQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733747213;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=39v1UJM0wPzy1yOKPoun+15gHceKb1wHaTEtw27KJCc=;
	b=DC+e+KmZ/WnfcmV7DU9t2KQKF2XIGc+Y/e98jEpDPB+lg7Vz+gmerLwJqeKP6a9Qi+Jf0Q
	wOpN7xYQKwnNmIAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733747213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=39v1UJM0wPzy1yOKPoun+15gHceKb1wHaTEtw27KJCc=;
	b=hDV+qciKDx6oL68xDXqrcCyLSYXGtcrbJz1IvjJt1bTUtS1M9m6tle3UhEWz7CXfNDOfEF
	jqTyg25TrY0zcuBP68b3+6amX27gggg4Pvub3o65w0d+JflnpGHUTRDNHmBTp5nZ//D/Ae
	AIJXtnr5nQwq3RcG7FyQ9f5aE9W1mQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733747213;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=39v1UJM0wPzy1yOKPoun+15gHceKb1wHaTEtw27KJCc=;
	b=DC+e+KmZ/WnfcmV7DU9t2KQKF2XIGc+Y/e98jEpDPB+lg7Vz+gmerLwJqeKP6a9Qi+Jf0Q
	wOpN7xYQKwnNmIAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4466B138D2;
	Mon,  9 Dec 2024 12:26:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VVxtEA3iVmdxWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Dec 2024 12:26:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E84FAA0B0C; Mon,  9 Dec 2024 13:26:48 +0100 (CET)
Date: Mon, 9 Dec 2024 13:26:48 +0100
From: Jan Kara <jack@suse.cz>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	brauner@kernel.org, torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: Re: commit 0790303ec869 leads to cpu stall without
 CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
Message-ID: <20241209122648.dpptugrol4p6ikmm@quack3>
References: <20241208152520.3559-1-spasswolf@web.de>
 <20241209121104.j6zttbqod3sh3qhr@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209121104.j6zttbqod3sh3qhr@quack3>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[web.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[toxicpanda.com,vger.kernel.org,suse.cz,fb.com,gmail.com,kernel.org,linux-foundation.org,zeniv.linux.org.uk,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 09-12-24 13:11:04, Jan Kara wrote:
> > Then I took a closer look at the function called in the problematic code
> > and noticed that fsnotify_file_area_perm(), is a NOOP when
> > CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set (which was the case in my
> > .config). This also explains why this was not found before, as
> > distributional .config file have this option enabled.  Setting the option
> > to y solves the issue, too
> 
> Well, I agree with you on all the points but the real question is, how come
> the test FMODE_FSNOTIFY_HSM(file->f_mode) was true on our kernel when you
> clearly don't run HSM software, even more so with
> CONFIG_FANOTIFY_ACCESS_PERMISSIONS disabled. That's the real cause of this
> problem. Something fishy is going on here... checking...
> 
> Ah, because I've botched out file_set_fsnotify_mode() in case
> CONFIG_FANOTIFY_ACCESS_PERMISSIONS is disabled. This should fix the
> problem:
> 
> index 1a9ef8f6784d..778a88fcfddc 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -215,6 +215,7 @@ static inline int fsnotify_open_perm(struct file *file)
>  #else
>  static inline void file_set_fsnotify_mode(struct file *file)
>  {
> +       file->f_mode |= FMODE_NONOTIFY_PERM;
>  }
> 
> I'm going to test this with CONFIG_FANOTIFY_ACCESS_PERMISSIONS disabled and
> push out a fixed version. Thanks again for the report and analysis!

So this was not enough, What we need is:
index 1a9ef8f6784d..778a88fcfddc 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -215,6 +215,10 @@ static inline int fsnotify_open_perm(struct file *file)
 #else
 static inline void file_set_fsnotify_mode(struct file *file)
 {
+	/* Is it a file opened by fanotify? */
+	if (FMODE_FSNOTIFY_NONE(file->f_mode))
+		return;
+	file->f_mode |= FMODE_NONOTIFY_PERM;
 }

This passes testing for me so I've pushed it out and the next linux-next
build should have this fix.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

