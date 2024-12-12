Return-Path: <linux-fsdevel+bounces-37144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AC09EE4FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 12:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41DF1663F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 11:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5217E211706;
	Thu, 12 Dec 2024 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CzktQ8Rz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RoYtOi2e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CzktQ8Rz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RoYtOi2e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4C8211475
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734002831; cv=none; b=qzq5vAvri2AMkF555QmdsnxxKlwSwI+zDZXbxg/4F3juO0wLchAtghNQhJMX/0rblHot/XDA97cqGRa7R2PBCa/164kpWnIgvdcU6g4KI9ZqsIb44PA5nhU9P/+BKYM3ymBGbVdDbT/oUr18BLoKdS7uLHKyE3SAMhylIAn25iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734002831; c=relaxed/simple;
	bh=fy3TDksTrR88yVPlcZgDoiggqzN6bCvOB/MJZYQPlPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qyyw/XQOCIPj+s/YHOh/5BN4j8xqtjISbjj8As0ZpeE31BFcMG1jO9xKpkoug09duhs554tyFnAczUVXo59nzMqmUrH0NjzpnuxwsGL6NsG5Uyo1HQGPE0/GUW5L1oWPLO5fSANnWDvv4KaR/BftSyH5tM9TIPzwaDTCHfr0R3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CzktQ8Rz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RoYtOi2e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CzktQ8Rz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RoYtOi2e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C82CE1F37C;
	Thu, 12 Dec 2024 11:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734002827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=omab/VWa17Kp3X+YHCWhrKXNIqJoY8Bl8T60rqgKZ+0=;
	b=CzktQ8RzXQE6TzPOx51NF2sRV9/SSUHN0NYPDlVrcc02B361bWKryWywVbkCVg8mTxas9i
	0OclA5vViYm3f4xKfBzrQrDKtQ/JPzzMMEXs0JmJKqS6KEjus7N5BeZK1XDM7SvuAwDlUm
	40W/YJ/7e7vplgfxHmBUPjY7kpK3dvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734002827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=omab/VWa17Kp3X+YHCWhrKXNIqJoY8Bl8T60rqgKZ+0=;
	b=RoYtOi2eOsVhjjAoJvG9MSW6iTToNjCIol3biGafRMBeiKavk39tkr/15mKKWjAETMleT7
	Lme+7bVLcrDd+2CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734002827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=omab/VWa17Kp3X+YHCWhrKXNIqJoY8Bl8T60rqgKZ+0=;
	b=CzktQ8RzXQE6TzPOx51NF2sRV9/SSUHN0NYPDlVrcc02B361bWKryWywVbkCVg8mTxas9i
	0OclA5vViYm3f4xKfBzrQrDKtQ/JPzzMMEXs0JmJKqS6KEjus7N5BeZK1XDM7SvuAwDlUm
	40W/YJ/7e7vplgfxHmBUPjY7kpK3dvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734002827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=omab/VWa17Kp3X+YHCWhrKXNIqJoY8Bl8T60rqgKZ+0=;
	b=RoYtOi2eOsVhjjAoJvG9MSW6iTToNjCIol3biGafRMBeiKavk39tkr/15mKKWjAETMleT7
	Lme+7bVLcrDd+2CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC14813508;
	Thu, 12 Dec 2024 11:27:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P03lLYvIWmekNQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Dec 2024 11:27:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 598CFA0894; Thu, 12 Dec 2024 12:27:07 +0100 (CET)
Date: Thu, 12 Dec 2024 12:27:07 +0100
From: Jan Kara <jack@suse.cz>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	Karel Zak <kzak@redhat.com>,
	Lennart Poettering <lennart@poettering.net>,
	Ian Kent <raven@themaw.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3] fanotify: notify on mount attach and detach
Message-ID: <20241212112707.6ueqp5fwgk64bry2@quack3>
References: <20241211153709.149603-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211153709.149603-1-mszeredi@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,suse.cz,gmail.com,redhat.com,poettering.net,themaw.net,zeniv.linux.org.uk];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 11-12-24 16:37:08, Miklos Szeredi wrote:
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
> Marks are added with FAN_MARK_MNTNS, which records the mount namespace
> belonging to the supplied path.
> 
> Prior to this patch mount namespace changes could be monitored by polling
> /proc/self/mountinfo, which did not convey any information about what
> changed.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

...

> @@ -1683,17 +1687,53 @@ int may_umount(struct vfsmount *mnt)
>  
>  EXPORT_SYMBOL(may_umount);
>  
> +static void notify_mount(struct mount *p)
> +{
> +	if (!p->prev_ns && p->mnt_ns) {
> +		fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
> +	} else if (p->prev_ns && !p->mnt_ns) {
> +		fsnotify_mnt_detach(p->prev_ns, &p->mnt);
> +	} else if (p->prev_ns == p->mnt_ns) {
> +		fsnotify_mnt_move(p->mnt_ns, &p->mnt);
> +	} else {
> +		fsnotify_mnt_detach(p->prev_ns, &p->mnt);
> +		fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
> +	}

Why not:
	if (p->prev_ns == p->mnt_ns) {
		fsnotify_mnt_move(p->mnt_ns, &p->mnt);
		return;
	}
	if (p->prev_ns)
		fsnotify_mnt_detach(p->prev_ns, &p->mnt);
	if (p->mnt_ns)
		fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
	p->prev_ns = p->mnt_ns;

> +	p->prev_ns = p->mnt_ns;
> +}
> +

...

> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 24c7c5df4998..a9dc004291bf 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -166,6 +166,8 @@ static bool fanotify_should_merge(struct fanotify_event *old,
>  	case FANOTIFY_EVENT_TYPE_FS_ERROR:
>  		return fanotify_error_event_equal(FANOTIFY_EE(old),
>  						  FANOTIFY_EE(new));
> +	case FANOTIFY_EVENT_TYPE_MNT:
> +		return false;

Perhaps instead of handling this in fanotify_should_merge(), we could
modify fanotify_merge() directly to don't even try if the event is of type
FANOTIFY_EVENT_TYPE_MNT? Similarly as we do it there for permission events.

> @@ -303,7 +305,11 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>  	pr_debug("%s: report_mask=%x mask=%x data=%p data_type=%d\n",
>  		 __func__, iter_info->report_mask, event_mask, data, data_type);
>  
> -	if (!fid_mode) {
> +	if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT))
> +	{

Unusual style here..

> +		if (data_type != FSNOTIFY_EVENT_MNT)
> +			return 0;
> +	} else if (!fid_mode) {
>  		/* Do we have path to open a file descriptor? */
>  		if (!path)
>  			return 0;

...

> @@ -910,7 +933,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>  	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
>  	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
>  
> -	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 21);
> +	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 23);
>  
>  	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
>  					 mask, data, data_type, dir);

So we have 9 bits left for fanotify events. I want throw in one idea for
discussion: Since these notification groups that can receive mount
notification events are special (they cannot receive anything else), we
could consider event value spaces separate as well (i.e., have say
FAN_MNT_ATTACH 0x1, FAN_MNT_DETACH 0x2). The internal FS_MNT_ATTACH,
FS_MNT_DETACH event bits would still stay separate for simplicity but those
are much easier to change if we ever start running out of internal fsnotify
event bits since we don't expose them to userspace. What this would mean is
to convert bits from FAN_MNT_* to FS_MNT_* in fanotify_mark() and then back
when copying event to userspace.

Now if we expect these mount notification groups will not have more than
these two events, then probably it isn't worth the hassle. If we expect
more event types may eventually materialize, it may be worth it. What do
people think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

