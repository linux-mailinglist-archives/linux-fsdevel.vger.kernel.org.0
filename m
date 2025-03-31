Return-Path: <linux-fsdevel+bounces-45334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36040A764FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 13:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4947F1888C47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 11:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8F41DFDAB;
	Mon, 31 Mar 2025 11:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dxDAiSIU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8zSFrAk7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dxDAiSIU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8zSFrAk7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF671B423C
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743420847; cv=none; b=jEVRCZn5UyOmU6J0BDYYJYgnN2mGGYFi0l2MtpQV3xCxtYC/IJkGj3UkaEbDRF7SiJ5LE4SB3f1P9gNfcZea0/nFhSsUteFwJZ8xasL+NqojlsLiQ8wYw4+MxO+CdspCkZh9ARVn60EMH4NZcKqLG1SrkXKUaQC3rpPssvWUNtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743420847; c=relaxed/simple;
	bh=PpWc+Wk37NgdcHKCCbX74KA6ikYvQVOsPiY+MnCDX2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSwW6AHwUI+TYikT2uQMP8TddQb/3rWwqDwA4X/wYGGeYOPcStmlxetryshn5kZNJL7zvn/DVWWcsvtHgrENMcRFexEQOiC0lPLhAxxHBbzsXm77Xq9zsjOJDuAjGkCZ8iyJjwN/21m9myoLyOMNWBtcivEp5ExH+vTHmp9Mp/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dxDAiSIU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8zSFrAk7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dxDAiSIU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8zSFrAk7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6C62821199;
	Mon, 31 Mar 2025 11:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743420843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CUePnGN2d2EEQAFsm7rnbH/POedWO2F2y9wmYBH+DPc=;
	b=dxDAiSIUxHVGa4QhQUSOYlVVXbnZwr3p5FibBuZGaJEXIET6o7ulSSjg2g+ptJb/BPoQT0
	YZuVhPbfDG4kJHZbJdESXbgkvhZblEn9Uzjxvms0vzrHT4PGy8Sus9Hj30uNbycqgnkk68
	DBbPTTbSVItEI0Mqq4vflVab0yGSiYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743420843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CUePnGN2d2EEQAFsm7rnbH/POedWO2F2y9wmYBH+DPc=;
	b=8zSFrAk7N0dJR0PoS9IGlk8KU3Z0GojJuYO/lvx57wRK1KPCa6lfYnmu6yeskNxpJTnYRv
	GMSntjeaqacQnpBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dxDAiSIU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8zSFrAk7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743420843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CUePnGN2d2EEQAFsm7rnbH/POedWO2F2y9wmYBH+DPc=;
	b=dxDAiSIUxHVGa4QhQUSOYlVVXbnZwr3p5FibBuZGaJEXIET6o7ulSSjg2g+ptJb/BPoQT0
	YZuVhPbfDG4kJHZbJdESXbgkvhZblEn9Uzjxvms0vzrHT4PGy8Sus9Hj30uNbycqgnkk68
	DBbPTTbSVItEI0Mqq4vflVab0yGSiYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743420843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CUePnGN2d2EEQAFsm7rnbH/POedWO2F2y9wmYBH+DPc=;
	b=8zSFrAk7N0dJR0PoS9IGlk8KU3Z0GojJuYO/lvx57wRK1KPCa6lfYnmu6yeskNxpJTnYRv
	GMSntjeaqacQnpBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60D2713A1F;
	Mon, 31 Mar 2025 11:34:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R6GfF6t96mcIegAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 31 Mar 2025 11:34:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1EA5DA08CF; Mon, 31 Mar 2025 13:34:03 +0200 (CEST)
Date: Mon, 31 Mar 2025 13:34:03 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alejandro Colomar <alx.manpages@gmail.com>, Jan Kara <jack@suse.cz>, 
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Krishna Vivek Vitta <kvitta@microsoft.com>
Subject: Re: [PATCH] fanotify: Document FAN_REPORT_FD_ERROR
Message-ID: <vflts4w73gy23iquev6yxrvbzguxkvlx7ccrcuww3hhvjbuw4q@dqr3up7qjwgx>
References: <20250330125146.1408717-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250330125146.1408717-1-amir73il@gmail.com>
X-Rspamd-Queue-Id: 6C62821199
X-Spam-Score: -2.51
X-Rspamd-Action: no action
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,vger.kernel.org,microsoft.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sun 30-03-25 14:51:46, Amir Goldstein wrote:
> This flag from v6.13 allows reporting detailed errors on failure to
> open a file descriptor for an event.
> 
> This API was backported to LTS kernels v6.12.4 and v6.6.66.
> 
> Cc: Krishna Vivek Vitta <kvitta@microsoft.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

The text looks correct to me. So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Just two typo corrections below.

								Honza

> ---
>  man/man2/fanotify_init.2 | 29 +++++++++++++++++++++++++++++
>  man/man7/fanotify.7      | 12 ++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/man/man2/fanotify_init.2 b/man/man2/fanotify_init.2
> index fa4ae9125..23fbe126f 100644
> --- a/man/man2/fanotify_init.2
> +++ b/man/man2/fanotify_init.2
> @@ -364,6 +364,35 @@ so this restriction may eventually be lifted.
>  For more details on information records,
>  see
>  .BR fanotify (7).
> +.TP
> +.BR FAN_REPORT_FD_ERROR " (since Linux 6.13 and 6.12.4 and 6.6.66)"
> +.\" commit 522249f05c5551aec9ec0ba9b6438f1ec19c138d
> +Events for fanotify groups initialized with this flag may contain
> +an error code that explains the reason for failure to open a file descriptor.
> +The
> +.I fd
> +memeber of struct
   ^^^ typo here

> +.I fanotify_event_metadata
> +normally contains
> +an open file descriptor associated with the object of the event
> +or FAN_NOFD in case a file descriptor could not be opened.
> +For a group initialized with this flag, instead of FAN_NOFD,
> +the
> +.I fd
> +memeber of struct
   ^^^ typo here

> +.I fanotify_event_metadata
> +will contain
> +a negative error value.
> +When the group is also initialized with flag
> +.BR FAN_REPORT_PIDFD ,
> +in case a process file descriptor could not be opened,
> +the
> +.I pidfd
> +memeber of struct
> +.I fanotify_event_info_pidfd
> +will also contain a negative error value.
> +For more details, see
> +.BR fanotify (7).
>  .P
>  The
>  .I event_f_flags
> diff --git a/man/man7/fanotify.7 b/man/man7/fanotify.7
> index a5ddf1df0..7844f52f6 100644
> --- a/man/man7/fanotify.7
> +++ b/man/man7/fanotify.7
> @@ -335,6 +335,12 @@ file status flag is set on the open file description.
>  This flag suppresses fanotify event generation.
>  Hence, when the receiver of the fanotify event accesses the notified file or
>  directory using this file descriptor, no additional events will be created.
> +.IP
> +When an fanotify group is initialized using
> +.BR FAN_REPORT_FD_ERROR ,
> +this field will contain a negative error value in case a file descriptor
> +could not be opened and
> +in case of a queue overflow, the value will be -EBADF.
>  .TP
>  .I pid
>  If flag
> @@ -679,6 +685,12 @@ Once the event listener has dealt with an event
>  and the pidfd is no longer required,
>  the pidfd should be closed via
>  .BR close (2).
> +.IP
> +When an fanotify group is initialized using
> +.BR FAN_REPORT_FD_ERROR ,
> +this field will contain a negative error value
> +in case a pidfd creation failure and
> +in case of a terminated process, the value will be -ESRCH.
>  .P
>  The fields of the
>  .I fanotify_event_info_error
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

