Return-Path: <linux-fsdevel+bounces-45665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90130A7A86A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 19:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815D23B60AC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B5A25178F;
	Thu,  3 Apr 2025 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S3+AShCl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BNRKwwYY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S3+AShCl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BNRKwwYY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FAE42A96
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743700242; cv=none; b=SW9/vXsCU/Z09pCQGRhCtIzJXjJ59GG4TpLQl2CIiJjRRRyP5gpDcNckGZJSEZ70DyAzNY++liDC3yeiwVLjrI/ezlsEV5ckS7eaEJ8bt4hv+gCRaO0hxtvsEG8SeOJ+10lqZRpoDwv0prTdLx9ZrMY+lEcJ0+pNRV9ep6nMt7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743700242; c=relaxed/simple;
	bh=e2/+6wxZhaTK5mg+Q77UFV2V+f1eixUaYJCYhmdQ42w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBxVRNh368VkBhyAOAdlLSPhDW3GlF6M03EkFBUqDcFV40TqMClkMMTPz0jJsiDC8A+t2fx+BIRsbGZKbfd1aqr37b72oKjG2RwL5sj9xKB4hHZUNzzyw3H6xURqO2PcDRnH3Qb0DHjVayFOkP7dfJjR41Fm5F332Ae1+crMP+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S3+AShCl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BNRKwwYY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S3+AShCl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BNRKwwYY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4D121F385;
	Thu,  3 Apr 2025 17:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743700237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vd0AEqJoKxLhteiVJ9eS3U6vcnnn5VSsymo3cjREyME=;
	b=S3+AShCl4qIwgYxsOH3h07HeWOWeb4EjMioxrU0z17nc7unxsVu4eBToiuDaJyXeX0p8tB
	Hwld4ZvOzgX4GBY5oDHIIofXscrLpNII/pDupynNsmO6uUGFrMAdMJbFbDxiaVifS8CpuW
	C1uHzdl0cCWMzlXnb2aVCT1/cUCQLDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743700237;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vd0AEqJoKxLhteiVJ9eS3U6vcnnn5VSsymo3cjREyME=;
	b=BNRKwwYYmYT7CLMmECCZNSxZapyi5MzwMD6uQt7bNkbpaO0K4rRe44eCulFKFP8ah3WzKC
	Tej40BtTn/MkrUAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743700237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vd0AEqJoKxLhteiVJ9eS3U6vcnnn5VSsymo3cjREyME=;
	b=S3+AShCl4qIwgYxsOH3h07HeWOWeb4EjMioxrU0z17nc7unxsVu4eBToiuDaJyXeX0p8tB
	Hwld4ZvOzgX4GBY5oDHIIofXscrLpNII/pDupynNsmO6uUGFrMAdMJbFbDxiaVifS8CpuW
	C1uHzdl0cCWMzlXnb2aVCT1/cUCQLDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743700237;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vd0AEqJoKxLhteiVJ9eS3U6vcnnn5VSsymo3cjREyME=;
	b=BNRKwwYYmYT7CLMmECCZNSxZapyi5MzwMD6uQt7bNkbpaO0K4rRe44eCulFKFP8ah3WzKC
	Tej40BtTn/MkrUAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4CBA13A2C;
	Thu,  3 Apr 2025 17:10:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EUfELw3B7mdkCgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 03 Apr 2025 17:10:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 74629A07E6; Thu,  3 Apr 2025 19:10:37 +0200 (CEST)
Date: Thu, 3 Apr 2025 19:10:37 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: allow creating FAN_PRE_ACCESS events on
 directories
Message-ID: <u3myluuaylejsfidkkajxni33w2ezwcfztlhjmavdmpcoir45o@ew32e4yra6xb>
References: <20250402062707.1637811-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402062707.1637811-1-amir73il@gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
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
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 02-04-25 08:27:07, Amir Goldstein wrote:
> Like files, a FAN_PRE_ACCESS event will be generated before every
> read access to directory, that is on readdir(3).
> 
> Unlike files, there will be no range info record following a
> FAN_PRE_ACCESS event, because the range of access on a directory
> is not well defined.
> 
> FAN_PRE_ACCESS events on readdir are only generated when user opts-in
> with FAN_ONDIR request in event mask and the FAN_PRE_ACCESS events on
> readdir report the FAN_ONDIR flag, so user can differentiate them from
> event on read.
> 
> An HSM service is expected to use those events to populate directories
> from slower tier on first readdir access. Having to range info means
> that the entire directory will need to be populated on the first
> readdir() call.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Jan,
> 
> IIRC, the reason we did not allow FAN_ONDIR with FAN_PRE_ACCESS event
> in initial API version was due to uncertainty around reporting range info.
> 
> Circling back to this, I do not see any better options other than not
> reporting range info and reporting the FAN_ONDIR flag.
> 
> HSM only option is to populate the entire directory on first access.
> Doing a partial range populate for directories does not seem practical
> with exising POSIX semantics.

I agree that range info for directory events doesn't make sense (or better
there's no way to have a generic implementation since everything is pretty
fs specific). If I remember our past discussion, filling in directory
content on open has unnecessarily high overhead because the user may then
just do e.g. lookup in the opened directory and not full readdir. That's
why you want to generate it on readdir. Correct?

> If you accept this claim, please consider fast tracking this change into
> 6.14.y.

Hum, why the rush? It is just additional feature to allow more efficient
filling in of directory entries...

> LTP tests pushed to my fan_hsm branch.

Thanks.

Otherwise the patch itself looks good so if my understanding is correct,
I'll pick it to my tree.

								Honza

>  fs/notify/fanotify/fanotify.c      | 11 +++++++----
>  fs/notify/fanotify/fanotify_user.c |  9 ---------
>  2 files changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 6c877b3646ec..531c038eed7c 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -303,8 +303,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>  				     struct inode *dir)
>  {
>  	__u32 marks_mask = 0, marks_ignore_mask = 0;
> -	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS |
> -				     FANOTIFY_EVENT_FLAGS;
> +	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS;
>  	const struct path *path = fsnotify_data_path(data, data_type);
>  	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
>  	struct fsnotify_mark *mark;
> @@ -356,6 +355,9 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>  	 * the child entry name information, we report FAN_ONDIR for mkdir/rmdir
>  	 * so user can differentiate them from creat/unlink.
>  	 *
> +	 * For pre-content events we report FAN_ONDIR for readdir, so user can
> +	 * differentiate them from read.
> +	 *
>  	 * For backward compatibility and consistency, do not report FAN_ONDIR
>  	 * to user in legacy fanotify mode (reporting fd) and report FAN_ONDIR
>  	 * to user in fid mode for all event types.
> @@ -368,8 +370,9 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>  		/* Do not report event flags without any event */
>  		if (!(test_mask & ~FANOTIFY_EVENT_FLAGS))
>  			return 0;
> -	} else {
> -		user_mask &= ~FANOTIFY_EVENT_FLAGS;
> +		user_mask |= FANOTIFY_EVENT_FLAGS;
> +	} else if (test_mask & FANOTIFY_PRE_CONTENT_EVENTS) {
> +		user_mask |= FAN_ONDIR;
>  	}
>  
>  	return test_mask & user_mask;
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index f2d840ae4ded..38cb9ba54842 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1410,11 +1410,6 @@ static int fanotify_may_update_existing_mark(struct fsnotify_mark *fsn_mark,
>  	    fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
>  		return -EEXIST;
>  
> -	/* For now pre-content events are not generated for directories */
> -	mask |= fsn_mark->mask;
> -	if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
> -		return -EEXIST;
> -
>  	return 0;
>  }
>  
> @@ -1956,10 +1951,6 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	if (mask & FAN_RENAME && !(fid_mode & FAN_REPORT_NAME))
>  		return -EINVAL;
>  
> -	/* Pre-content events are not currently generated for directories. */
> -	if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
> -		return -EINVAL;
> -
>  	if (mark_cmd == FAN_MARK_FLUSH) {
>  		if (mark_type == FAN_MARK_MOUNT)
>  			fsnotify_clear_vfsmount_marks_by_group(group);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

