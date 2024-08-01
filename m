Return-Path: <linux-fsdevel+bounces-24837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D5B94540B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 23:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21FBCB2461E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 21:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65DF14B082;
	Thu,  1 Aug 2024 21:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m0OqkZ6e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vFK1MfVA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m0OqkZ6e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vFK1MfVA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399A614A603
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722546878; cv=none; b=DtF+xUO8e25pcc0FVH1IrgWWPycJDITrIo5icDu636mNugJg5Ef0ckVWMGKzb8r+B47bau2mAZTk/HuTLd+D6vcNLAwoX4c5lvnmZ7JGh2jXPuZeyv3YUliPTYgeXIIkHo7W6HIWBvZGfobB6h6tcsJxNa6WKvKMU+2dHl7tI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722546878; c=relaxed/simple;
	bh=3Wza8duJe5ECvYn2jyG62pph3SCG1YOOszQDr0FhZbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZ9j1Dg++iUQuQTyRkE+kzCPOfdgBTMRl3vldljpWTNI+P9upFHScic9DSPk3VEybAjdPN7iW45FngD6rWKuYzvV+1TGSFFu7i/B9g/Yu8iq7jQ5RHQx5MHBGx+B5MAXghZRV0W04RNf1DD3ot9W0Sy1t8MsVptsLwwnA2jCuPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m0OqkZ6e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vFK1MfVA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m0OqkZ6e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vFK1MfVA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1988F21A72;
	Thu,  1 Aug 2024 21:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722546873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v0DQ3NalQITJa5vzVr63tT10JgzApXBZiJ9w4yfQ9SM=;
	b=m0OqkZ6ePFIHovQ/bH+uRSaCjAPLaX5ZuUrzfUnpixEoKq7Zu1aB5qCux5Dqgjc7sN+H4d
	D2tVpiTW0fvA5rTKpqEQMEGXMrwAcA+z4dM/9O9B8RL7/cQ5eennScZf7F+EWfhqZqfXmc
	ii5UfgkWsrzWYlEf6PahZUxJXgUEsjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722546873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v0DQ3NalQITJa5vzVr63tT10JgzApXBZiJ9w4yfQ9SM=;
	b=vFK1MfVAXvBgax519QzgeKQrksDzFAYxH8SV0f4a1O2faoEQpKKUIeYBPltd5cYy+aT49I
	2N8wQ+APT1o4VVAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=m0OqkZ6e;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vFK1MfVA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722546873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v0DQ3NalQITJa5vzVr63tT10JgzApXBZiJ9w4yfQ9SM=;
	b=m0OqkZ6ePFIHovQ/bH+uRSaCjAPLaX5ZuUrzfUnpixEoKq7Zu1aB5qCux5Dqgjc7sN+H4d
	D2tVpiTW0fvA5rTKpqEQMEGXMrwAcA+z4dM/9O9B8RL7/cQ5eennScZf7F+EWfhqZqfXmc
	ii5UfgkWsrzWYlEf6PahZUxJXgUEsjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722546873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v0DQ3NalQITJa5vzVr63tT10JgzApXBZiJ9w4yfQ9SM=;
	b=vFK1MfVAXvBgax519QzgeKQrksDzFAYxH8SV0f4a1O2faoEQpKKUIeYBPltd5cYy+aT49I
	2N8wQ+APT1o4VVAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BA1B136CF;
	Thu,  1 Aug 2024 21:14:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JoqVArn6q2YycAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Aug 2024 21:14:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A4D01A08CB; Thu,  1 Aug 2024 23:14:32 +0200 (CEST)
Date: Thu, 1 Aug 2024 23:14:32 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 09/10] fanotify: allow to set errno in FAN_DENY
 permission response
Message-ID: <20240801211432.4u6gwkbyfzvobvhf@quack3>
References: <cover.1721931241.git.josef@toxicpanda.com>
 <fe7827974f5aec3403b07e8e70c020422126deaa.1721931241.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe7827974f5aec3403b07e8e70c020422126deaa.1721931241.git.josef@toxicpanda.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1988F21A72
X-Spam-Score: -3.81
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.com:email]

On Thu 25-07-24 14:19:46, Josef Bacik wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> With FAN_DENY response, user trying to perform the filesystem operation
> gets an error with errno set to EPERM.
> 
> It is useful for hierarchical storage management (HSM) service to be able
> to deny access for reasons more diverse than EPERM, for example EAGAIN,
> if HSM could retry the operation later.
> 
> Allow fanotify groups with priority FAN_CLASSS_PRE_CONTENT to responsd
> to permission events with the response value FAN_DENY_ERRNO(errno),
> instead of FAN_DENY to return a custom error.
> 
> Limit custom error to values to some errors expected on read(2)/write(2)
	^^^ parse error. Perhaps: "Limit custom error values to errors
expected on read..."

> and open(2) of regular files. This list could be extended in the future.
> Userspace can test for legitimate values of FAN_DENY_ERRNO(errno) by
> writing a response to an fanotify group fd with a value of FAN_NOFD
> in the fd field of the response.
> 
> The change in fanotify_response is backward compatible, because errno is
> written in the high 8 bits of the 32bit response field and old kernels
> reject respose value with high bits set.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

...

> @@ -258,18 +258,25 @@ static int fanotify_get_response(struct fsnotify_group *group,
>  	}
>  
>  	/* userspace responded, convert to something usable */
> -	switch (event->response & FANOTIFY_RESPONSE_ACCESS) {
> +	switch (FAN_RESPONSE_ACCESS(event->response)) {
>  	case FAN_ALLOW:
>  		ret = 0;
>  		break;
>  	case FAN_DENY:
> +		/* Check custom errno from pre-content events */
> +		errno = FAN_RESPONSE_ERRNO(event->response);
> +		if (errno) {
> +			ret = -errno;
> +			break;
> +		}
> +		fallthrough;
>  	default:
>  		ret = -EPERM;
>  	}
>  
>  	/* Check if the response should be audited */
>  	if (event->response & FAN_AUDIT)
> -		audit_fanotify(event->response & ~FAN_AUDIT,
> +		audit_fanotify(FAN_RESPONSE_ACCESS(event->response),
>  			       &event->audit_rule);

I think you need to also keep FAN_INFO in the flags not to break some
userspace possibly parsing audit requests.

> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index c3c8b2ea80b6..b4d810168521 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -337,11 +337,12 @@ static int process_access_response(struct fsnotify_group *group,
>  	struct fanotify_perm_event *event;
>  	int fd = response_struct->fd;
>  	u32 response = response_struct->response;
> +	int errno = FAN_RESPONSE_ERRNO(response);
>  	int ret = info_len;
>  	struct fanotify_response_info_audit_rule friar;
>  
> -	pr_debug("%s: group=%p fd=%d response=%u buf=%p size=%zu\n", __func__,
> -		 group, fd, response, info, info_len);
> +	pr_debug("%s: group=%p fd=%d response=%x errno=%d buf=%p size=%zu\n",
> +		 __func__, group, fd, response, errno, info, info_len);
>  	/*
>  	 * make sure the response is valid, if invalid we do nothing and either
>  	 * userspace can send a valid response or we will clean it up after the
> @@ -350,9 +351,33 @@ static int process_access_response(struct fsnotify_group *group,
>  	if (response & ~FANOTIFY_RESPONSE_VALID_MASK)
>  		return -EINVAL;
>  
> -	switch (response & FANOTIFY_RESPONSE_ACCESS) {
> +	switch (FAN_RESPONSE_ACCESS(response)) {
>  	case FAN_ALLOW:
> +		if (errno)
> +			return -EINVAL;
> +		break;
>  	case FAN_DENY:
> +		/* Custom errno is supported only for pre-content groups */
> +		if (errno && group->priority != FSNOTIFY_PRIO_PRE_CONTENT)
> +			return -EINVAL;
> +
> +		/*
> +		 * Limit errno to values expected on open(2)/read(2)/write(2)
> +		 * of regular files.
> +		 */
> +		switch (errno) {
> +		case 0:
> +		case EIO:
> +		case EPERM:
> +		case EBUSY:
> +		case ETXTBSY:
> +		case EAGAIN:
> +		case ENOSPC:
> +		case EDQUOT:
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
>  		break;
>  	default:
>  		return -EINVAL;
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index ae6cb2688d52..76d818a7d654 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -132,7 +132,14 @@
>  /* These masks check for invalid bits in permission responses. */
>  #define FANOTIFY_RESPONSE_ACCESS (FAN_ALLOW | FAN_DENY)
>  #define FANOTIFY_RESPONSE_FLAGS (FAN_AUDIT | FAN_INFO)
> -#define FANOTIFY_RESPONSE_VALID_MASK (FANOTIFY_RESPONSE_ACCESS | FANOTIFY_RESPONSE_FLAGS)
> +#define FANOTIFY_RESPONSE_ERRNO	(FAN_ERRNO_MASK << FAN_ERRNO_SHIFT)
> +#define FANOTIFY_RESPONSE_VALID_MASK \
> +	(FANOTIFY_RESPONSE_ACCESS | FANOTIFY_RESPONSE_FLAGS | \
> +	 FANOTIFY_RESPONSE_ERRNO)
> +
> +/* errno other than EPERM can specified in upper byte of deny response */
> +#define FAN_RESPONSE_ACCESS(res)	((res) & FANOTIFY_RESPONSE_ACCESS)
> +#define FAN_RESPONSE_ERRNO(res)		((int)((res) >> FAN_ERRNO_SHIFT))

I have to say I find the names FANOTIFY_RESPONSE_ERRNO and
FAN_RESPONSE_ERRNO() (and similarly with FAN_RESPONSE_ACCESS) very similar
and thus confusing. I was staring at it for 5 minutes wondering how comes
it compiles before I realized one prefix is shorter than the other one so
the indentifiers are indeed different. Maybe we'd make these inline
functions instead of macros and name them like:

fanotify_get_response_decision()
fanotify_get_response_errno()

???

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

