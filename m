Return-Path: <linux-fsdevel+bounces-45335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E82FA7650E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 13:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2A03A886E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 11:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B831C1E1A32;
	Mon, 31 Mar 2025 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SvTRM6L+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yCndjHWh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SvTRM6L+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yCndjHWh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71226189F36
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743421029; cv=none; b=bSnzwDuBd4cFcRPjut7n5bTEP0PMHBPWdrr302mLK8Fm/cMgb4Aq/dw3bwmMSakwzSdvog7r6kV/SYuZ/wIAUwkO9P52ZhLz+dI9HCvbT7CgvC/lwnQ5PRNbRKZFiXEylumuO1OrXXd2WfDo0++ro2fxERDw4qcZiYeKvtaVs08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743421029; c=relaxed/simple;
	bh=WaSIgIAkl8WGUsAAIv//IM3+e8NLsBE9HCab9vToJVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDgbeWUr1YW3E1iijdwDGxF5Atxjro57ptcWaAOOU2eJH5JVkG21tas69YSaxKCEPU3O8J6NljJlR5n402YB3+fJjqhm6j4tvYc2YmCXHCfPD+SYpf2ZZh+umQO+zqMXOAnxArs2MdjFR1K+ydWfuwLannQvzk5JD1KXZ4IIDMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SvTRM6L+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yCndjHWh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SvTRM6L+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yCndjHWh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 919DC211A3;
	Mon, 31 Mar 2025 11:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743421025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=socGXxkao39Y28dTjNaU1o7xlnETwNCtq1H1l9L3odA=;
	b=SvTRM6L+ge3B0z6PtIKkdJhB7HUz6hiES+OIPBsKnjaAApcLBc0Nz+w2jizFZI1vInE53o
	gSu5HXJ8mzXPHDVNQyAnaQKd8ILZzstJSvvSAVb/F/ap/1fmK9zTJULwqyhRY5zSWcVxYG
	HhhCRRa4Ftd34qQLH0tIpAICtOdICx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743421025;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=socGXxkao39Y28dTjNaU1o7xlnETwNCtq1H1l9L3odA=;
	b=yCndjHWhtfnQx92EAKPYvK/ZZcNsjEsEnVm5cfHkOwib67+1fRwjlYsZiVpEQGdz9pfKe2
	oBBEMuH62Ij+8JDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743421025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=socGXxkao39Y28dTjNaU1o7xlnETwNCtq1H1l9L3odA=;
	b=SvTRM6L+ge3B0z6PtIKkdJhB7HUz6hiES+OIPBsKnjaAApcLBc0Nz+w2jizFZI1vInE53o
	gSu5HXJ8mzXPHDVNQyAnaQKd8ILZzstJSvvSAVb/F/ap/1fmK9zTJULwqyhRY5zSWcVxYG
	HhhCRRa4Ftd34qQLH0tIpAICtOdICx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743421025;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=socGXxkao39Y28dTjNaU1o7xlnETwNCtq1H1l9L3odA=;
	b=yCndjHWhtfnQx92EAKPYvK/ZZcNsjEsEnVm5cfHkOwib67+1fRwjlYsZiVpEQGdz9pfKe2
	oBBEMuH62Ij+8JDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8727A13A1F;
	Mon, 31 Mar 2025 11:37:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R8j9IGF+6mfsegAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 31 Mar 2025 11:37:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DA0C2A08CF; Mon, 31 Mar 2025 13:37:00 +0200 (CEST)
Date: Mon, 31 Mar 2025 13:37:00 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alejandro Colomar <alx.manpages@gmail.com>, Jan Kara <jack@suse.cz>, 
	Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: Document FAN_PRE_ACCESS event
Message-ID: <zncnbu47ygjcx7i72nt63xbeyhb7ihnjjnqa2ddzl24r4re577@haqsfrrcknun>
References: <20250330125536.1408939-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250330125536.1408939-1-amir73il@gmail.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,toxicpanda.com,kernel.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Sun 30-03-25 14:55:36, Amir Goldstein wrote:
> The new FAN_PRE_ACCESS events are created before access to a file range,
> to provides an opportunity for the event listener to modify the content
> of the object before the user can accesss it.
> 
> Those events are available for group in class FAN_CLASS_PRE_CONTENT
> They are reported with FAN_EVENT_INFO_TYPE_RANGE info record.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  man/man2/fanotify_init.2 |  4 ++--
>  man/man2/fanotify_mark.2 | 14 +++++++++++++
>  man/man7/fanotify.7      | 43 ++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 57 insertions(+), 4 deletions(-)
> 
> diff --git a/man/man2/fanotify_init.2 b/man/man2/fanotify_init.2
> index 23fbe126f..b1ef8018c 100644
> --- a/man/man2/fanotify_init.2
> +++ b/man/man2/fanotify_init.2
> @@ -57,8 +57,8 @@ Only one of the following notification classes may be specified in
>  .B FAN_CLASS_PRE_CONTENT
>  This value allows the receipt of events notifying that a file has been
>  accessed and events for permission decisions if a file may be accessed.
> -It is intended for event listeners that need to access files before they
> -contain their final data.
> +It is intended for event listeners that may need to write data to files
> +before their final data can be accessed.
>  This notification class might be used by hierarchical storage managers,
>  for example.
>  Use of this flag requires the
> diff --git a/man/man2/fanotify_mark.2 b/man/man2/fanotify_mark.2
> index 47cafb21c..edbcdc592 100644
> --- a/man/man2/fanotify_mark.2
> +++ b/man/man2/fanotify_mark.2
> @@ -445,6 +445,20 @@ or
>  .B FAN_CLASS_CONTENT
>  is required.
>  .TP
> +.BR FAN_PRE_ACCESS " (since Linux 6.14)"
> +.\" commit 4f8afa33817a6420398d1c177c6e220a05081f51
> +Create an event before read or write access to a file range,
> +that provides an opportunity for the event listener
> +to modify the content of the file
> +before access to the content
> +in the specified range.
> +An additional information record of type
> +.B FAN_EVENT_INFO_TYPE_RANGE
> +is returned for each event in the read buffer.
> +An fanotify file descriptor created with
> +.B FAN_CLASS_PRE_CONTENT
> +is required.
> +.TP
>  .B FAN_ONDIR
>  Create events for directories\[em]for example, when
>  .BR opendir (3),
> diff --git a/man/man7/fanotify.7 b/man/man7/fanotify.7
> index 7844f52f6..6f3a9496e 100644
> --- a/man/man7/fanotify.7
> +++ b/man/man7/fanotify.7
> @@ -247,6 +247,26 @@ struct fanotify_event_info_error {
>  .EE
>  .in
>  .P
> +In case of
> +.B FAN_PRE_ACCESS
> +events,
> +an additional information record describing the access range
> +is returned alongside the generic
> +.I fanotify_event_metadata
> +structure within the read buffer.
> +This structure is defined as follows:
> +.P
> +.in +4n
> +.EX
> +struct fanotify_event_info_range {
> +    struct fanotify_event_info_header hdr;
> +    __u32 pad;
> +    __u64 offset;
> +    __u64 count;
> +};
> +.EE
> +.in
> +.P
>  All information records contain a nested structure of type
>  .IR fanotify_event_info_header .
>  This structure holds meta-information about the information record
> @@ -509,8 +529,9 @@ The value of this field can be set to one of the following:
>  .BR FAN_EVENT_INFO_TYPE_FID ,
>  .BR FAN_EVENT_INFO_TYPE_DFID ,
>  .BR FAN_EVENT_INFO_TYPE_DFID_NAME ,
> -or
> -.BR FAN_EVENT_INFO_TYPE_PIDFD .
> +.BR FAN_EVENT_INFO_TYPE_PIDFD ,
> +.BR FAN_EVENT_INFO_TYPE_ERROR ,
> +.BR FAN_EVENT_INFO_TYPE_RANGE .
>  The value set for this field
>  is dependent on the flags that have been supplied to
>  .BR fanotify_init (2).
> @@ -711,6 +732,24 @@ Identifies the type of error that occurred.
>  This is a counter of the number of errors suppressed
>  since the last error was read.
>  .P
> +The fields of the
> +.I fanotify_event_info_range
> +structure are as follows:
> +.TP
> +.I hdr
> +This is a structure of type
> +.IR fanotify_event_info_header .
> +The
> +.I info_type
> +field is set to
> +.BR FAN_EVENT_INFO_TYPE_RANGE .
> +.TP
> +.I count
> +The number of bytes being read or written to the file.
> +.TP
> +.I offset
> +The offset from which bytes are read or written to the file.
> +.P
>  The following macros are provided to iterate over a buffer containing
>  fanotify event metadata returned by a
>  .BR read (2)
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

