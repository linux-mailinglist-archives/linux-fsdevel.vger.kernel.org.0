Return-Path: <linux-fsdevel+bounces-24828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59224945195
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 19:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4F51C228BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 17:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C51C1B8EBE;
	Thu,  1 Aug 2024 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TJhK8Grg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b5z+jjDo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KEHKFdTw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CLm2vuCG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4AF182D8
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722533924; cv=none; b=ZsJXfhH0rSj8itysmGuEbnt+3/4aPBpKAh9u56NdGNmyYGFb3uYUwkz/wOFDdLuBO6/Up3l66PzMcCgK6pYo+Jx62AxbgfWxCQyIw8olMHkFky4pY5nTkRvz0TLjclWuvFUwOVftqeK4iir+IrL7yCT4hLvlCoRbcmKW5oeJh34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722533924; c=relaxed/simple;
	bh=GbH+o70rEC9qeVH5i++yMujQhNy1Vjt/yKXR6eQxdwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9J3xtwUNvfPTGmv5O9xcMDu1k43jJeiZ7xTYTBXsc2M0gL1NFLaGQtp0leXkw2QuAGXj4M6EjhykGkzoQ00P4dFD6A83dQrPaYcFj1Aapx/d0UtfNQ3FjHp9kcUq+Nk80wE3MKHe8+GiWA4e8WT4OuZRtoBGXi7wW60MrYhDd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TJhK8Grg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b5z+jjDo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KEHKFdTw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CLm2vuCG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 26AE521AAB;
	Thu,  1 Aug 2024 17:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722533921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yB2SQn1la12G4zOPrM5EVWYYdx0NMjRmwFVTjT38Vm0=;
	b=TJhK8GrgdMDKc0+ej8mkQQwcepnmT19ccVCvEwV729NeVkTqTej6o7Ub2F4cAzapZbaW3a
	NJt0/z/KDs3Tc6cNJ8vcVoWbuBtTSx2FO3Ic2nAu3/y6MOTASS+DrkDUv8KhhcEUN5s/w5
	a82e5Iz7KbeyE0I4HsJfgBzH6pvcljE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722533921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yB2SQn1la12G4zOPrM5EVWYYdx0NMjRmwFVTjT38Vm0=;
	b=b5z+jjDoyD9UzFR+RmiPp+bWjQ+5JhnHVU5Ls7YyRgMPb99+MRp6kKlwszXxK/WnOQx5Ev
	iOFZstY6EXqburDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722533920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yB2SQn1la12G4zOPrM5EVWYYdx0NMjRmwFVTjT38Vm0=;
	b=KEHKFdTwQh0WI8jrRyk4P8OqceHPFSDRX3TA9DQmtl0wRtCr7nx9BhbTTihbaEfWIwma9N
	vUptNtyfX5bZzDdv99PXSGsf8BY0RI3Ioy1goypLL7OKeExwpYhTisSpjHtYDKV8WKeioi
	97TPPSt1EqXVR3M1B7BZKvezwdQFpYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722533920;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yB2SQn1la12G4zOPrM5EVWYYdx0NMjRmwFVTjT38Vm0=;
	b=CLm2vuCGOUn/pvqlfAE8vCLSVAesZmKwp+08gmTqg0hIGA3sC/+jxVd/aYiHH9D4ml8dtd
	dGcfihFuWA5ALFAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FEE4136CF;
	Thu,  1 Aug 2024 17:38:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7JThAyDIq2ZGOQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Aug 2024 17:38:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8A90EA08CB; Thu,  1 Aug 2024 19:38:31 +0200 (CEST)
Date: Thu, 1 Aug 2024 19:38:31 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 08/10] fanotify: report file range info with pre-content
 events
Message-ID: <20240801173831.5uzwvhzdqro3om3q@quack3>
References: <cover.1721931241.git.josef@toxicpanda.com>
 <1a378ca2df2ce30e5aecf7145223906a427d9037.1721931241.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a378ca2df2ce30e5aecf7145223906a427d9037.1721931241.git.josef@toxicpanda.com>
X-Spamd-Result: default: False [-3.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.60

On Thu 25-07-24 14:19:45, Josef Bacik wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> With group class FAN_CLASS_PRE_CONTENT, report offset and length info
> along with FAN_PRE_ACCESS and FAN_PRE_MODIFY permission events.
> 
> This information is meant to be used by hierarchical storage managers
> that want to fill partial content of files on first access to range.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fanotify/fanotify.h      |  8 +++++++
>  fs/notify/fanotify/fanotify_user.c | 38 ++++++++++++++++++++++++++++++
>  include/uapi/linux/fanotify.h      |  7 ++++++
>  3 files changed, 53 insertions(+)
> 
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 93598b7d5952..7f06355afa1f 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -448,6 +448,14 @@ static inline bool fanotify_is_perm_event(u32 mask)
>  		mask & FANOTIFY_PERM_EVENTS;
>  }
>  
> +static inline bool fanotify_event_has_access_range(struct fanotify_event *event)
> +{
> +	if (!(event->mask & FANOTIFY_PRE_CONTENT_EVENTS))
> +		return false;
> +
> +	return FANOTIFY_PERM(event)->ppos;
> +}

Now I'm a bit confused. Can we have legally NULL ppos for an event from
FANOTIFY_PRE_CONTENT_EVENTS?

> +static size_t copy_range_info_to_user(struct fanotify_event *event,
> +				      char __user *buf, int count)
> +{
> +	struct fanotify_perm_event *pevent = FANOTIFY_PERM(event);
> +	struct fanotify_event_info_range info = { };
> +	size_t info_len = FANOTIFY_RANGE_INFO_LEN;
> +
> +	if (WARN_ON_ONCE(info_len > count))
> +		return -EFAULT;
> +
> +	if (WARN_ON_ONCE(!pevent->ppos))
> +		return 0;

I think we should be returning some error here. Maybe EINVAL? Otherwise
fanotify_event_len() will return different length than we actually generate
and that could lead to strange failures later.

> +
> +	info.hdr.info_type = FAN_EVENT_INFO_TYPE_RANGE;
> +	info.hdr.len = info_len;
> +	info.offset = *(pevent->ppos);
> +	info.count = pevent->count;
> +
> +	if (copy_to_user(buf, &info, info_len))
> +		return -EFAULT;
> +
> +	return info_len;
> +}
> +
>  static int copy_info_records_to_user(struct fanotify_event *event,
>  				     struct fanotify_info *info,
>  				     unsigned int info_mode, int pidfd,
...
> @@ -191,6 +192,12 @@ struct fanotify_event_info_error {
>  	__u32 error_count;
>  };
>  
> +struct fanotify_event_info_range {
> +	struct fanotify_event_info_header hdr;
> +	__u32 count;
> +	__u64 offset;
> +};

Just for the sake of future-proofing, I'd make 'count' u64. I understand it
means growing fanotify_event_info_range by 8 bytes and we currently never
do reads or writes larger than 2 GB but I don't think saving bytes like
this is really a good tradeoff these days...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

