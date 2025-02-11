Return-Path: <linux-fsdevel+bounces-41522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F71A31032
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 16:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6231889F92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 15:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF76253B7A;
	Tue, 11 Feb 2025 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y+D9bioG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cUfJNtWX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y+D9bioG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cUfJNtWX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D21253B4C;
	Tue, 11 Feb 2025 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739289046; cv=none; b=ovdTJTLkn/95DomUBi+9WQrnNf3KBrAX0zTFM1g+/6do2sfEBrsYuyyw7/pxjBD4qR6loaHrXdZS5NuPwJYzPSc93Y51lFy27xbuRJaM0vKwKBY681mr+OjKx3ZphRnZ2P/W1A0Y1nhabGnGj9mq+LH9Emhz5sNYngaKGohb2xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739289046; c=relaxed/simple;
	bh=DLoVaWN4pPM06i7274kUimEBAEHvEAUb+WbMY772pi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKVMwjvJ+uqCU1O3fFX8zTCxB01A6G/cmKtEDDS1E6kCI6v0bLfgKvqFo3xgLusxIiRYA1XIe0PJEH5XlZL09WCRBcIUQYcpc8AFGd7fwiZSP+FAqwbn86JhXU2qjzJirj2YrX3t9++q8SJ8d3EI1gX/f3A4BRvIs8oLTS9R4ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y+D9bioG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cUfJNtWX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y+D9bioG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cUfJNtWX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 90B43339CA;
	Tue, 11 Feb 2025 13:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739280741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OQgKLohp9UJppT3FHipy+VgWaxpWCieTbQmYejKjYXo=;
	b=Y+D9bioGmHa3DDMKdgMsSTgkLT52ggg513kAY8MGyJo9J+RRuPxmzxrz2jzIjsDWXn/LZ8
	gEyfQUVq5fthuIEy1dQCcDrvTlKHeG82eM0LeaBA5HNEqG/YHozg+247wLhrLpkFo/hl5R
	pFWJ2Z2FDhZp23o6G91hAm+hxv4AFXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739280741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OQgKLohp9UJppT3FHipy+VgWaxpWCieTbQmYejKjYXo=;
	b=cUfJNtWXPk4bQ4zdkwAwWtQYsC8ktoRqy5MbAny9T2dyKu7Ut+agGB3+Aw1OF1M/YyifI0
	0iL5fMt+7L4VmmAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Y+D9bioG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cUfJNtWX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739280741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OQgKLohp9UJppT3FHipy+VgWaxpWCieTbQmYejKjYXo=;
	b=Y+D9bioGmHa3DDMKdgMsSTgkLT52ggg513kAY8MGyJo9J+RRuPxmzxrz2jzIjsDWXn/LZ8
	gEyfQUVq5fthuIEy1dQCcDrvTlKHeG82eM0LeaBA5HNEqG/YHozg+247wLhrLpkFo/hl5R
	pFWJ2Z2FDhZp23o6G91hAm+hxv4AFXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739280741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OQgKLohp9UJppT3FHipy+VgWaxpWCieTbQmYejKjYXo=;
	b=cUfJNtWXPk4bQ4zdkwAwWtQYsC8ktoRqy5MbAny9T2dyKu7Ut+agGB3+Aw1OF1M/YyifI0
	0iL5fMt+7L4VmmAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8292513715;
	Tue, 11 Feb 2025 13:32:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AW7cH2VRq2dTOgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 11 Feb 2025 13:32:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 41745A095C; Tue, 11 Feb 2025 14:32:17 +0100 (CET)
Date: Tue, 11 Feb 2025 14:32:17 +0100
From: Jan Kara <jack@suse.cz>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Subject: Re: [PATCH v5 2/3] fanotify: notify on mount attach and detach
Message-ID: <7fjcocufagvqgytwiqvbcehovmehgwytz67jv76327c52jrz2y@5re5g57otcws>
References: <20250129165803.72138-1-mszeredi@redhat.com>
 <20250129165803.72138-3-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129165803.72138-3-mszeredi@redhat.com>
X-Rspamd-Queue-Id: 90B43339CA
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,suse.cz,gmail.com,redhat.com,poettering.net,themaw.net,zeniv.linux.org.uk,paul-moore.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 29-01-25 17:58:00, Miklos Szeredi wrote:
> Add notifications for attaching and detaching mounts.  The following new
> event masks are added:
> 
>   FAN_MNT_ATTACH  - Mount was attached
>   FAN_MNT_DETACH  - Mount was detached
> 
> If a mount is moved, then the event is reported with (FAN_MNT_ATTACH |
> FAN_MNT_DETACH).
> 
> These events add an info record of type FAN_EVENT_INFO_TYPE_MNT containing
> these fields identifying the affected mounts:
> 
>   __u64 mnt_id    - the ID of the mount (see statmount(2))
> 
> FAN_REPORT_MNT must be supplied to fanotify_init() to receive these events
> and no other type of event can be received with this report type.
> 
> Marks are added with FAN_MARK_MNTNS, which records the mount namespace from
> an nsfs file (e.g. /proc/self/ns/mnt).
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Just one small comment below. Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -1847,6 +1890,19 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  		return -EINVAL;
>  	group = fd_file(f)->private_data;
>  
> +	/* Only report mount events on mnt namespace */
> +	if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {
> +		if (mask & ~FANOTIFY_MOUNT_EVENTS)
> +			return -EINVAL;
> +		if (mark_type != FAN_MARK_MNTNS)
> +			return -EINVAL;
> +	} else {
> +		if (mask & FANOTIFY_MOUNT_EVENTS)
> +			return -EINVAL;
> +		if (mark_type == FAN_MARK_MNTNS)
> +			return -EINVAL;
> +	}
> +
>  	/*
>  	 * An unprivileged user is not allowed to setup mount nor filesystem
>  	 * marks.  This also includes setting up such marks by a group that
> @@ -1888,7 +1944,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	 * point.
>  	 */
>  	fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> -	if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
> +	if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_MOUNT_EVENTS|FANOTIFY_EVENT_FLAGS) &&

I understand why you need this but the condition is really hard to
understand now and the comment above it becomes out of date. Perhaps I'd
move this and the following two checks for FAN_RENAME and
FANOTIFY_PRE_CONTENT_EVENTS into !FAN_GROUP_FLAG(group, FAN_REPORT_MNT)
branch to make things more obvious?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

