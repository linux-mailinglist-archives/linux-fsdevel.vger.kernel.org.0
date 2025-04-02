Return-Path: <linux-fsdevel+bounces-45515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41BEA78E63
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 14:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A4C3B7808
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 12:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D396238D49;
	Wed,  2 Apr 2025 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xg++0DKx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5eC5S8I3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xg++0DKx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5eC5S8I3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF382356B5
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596745; cv=none; b=r14byn/QtWaxux7ZULIdHXcIfJyTar5WM+CjGkHo/tf1SZp10SyEaHP8PnsyfAv1Uzpn4VPRbsQ6sajP07e8/2hWDTIgBJDnv/haDMeoaRQeUwAr+dFSmlHxlo68+ALVW4YTLbtt8JGxc9QABsE+W9rBxK8nW4cVf3KVZSNORDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596745; c=relaxed/simple;
	bh=TZuRNh2+/LTndjYTCCjKC6dYz36n3fn8iRP24Ux4SNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgSLJ8AwDBKJ8BAz11CQMi5DUD/DcH1VxrB5EUucNRXxv1hrySBLnyipLU0edamDSs8E8tb1JqvAVxBEDg1ZGdugUYjwKyeR5ot7EQY1LiG2tr/+L3CwlgYD3mtlPUOLFfEWHgYs8AwuhdsY/iRtDfIAHJLjXbSea7RageidBrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xg++0DKx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5eC5S8I3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xg++0DKx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5eC5S8I3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D93C21169;
	Wed,  2 Apr 2025 12:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743596742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HGmEULEpy7HAvpeXVydfjIl8HFDnw89gh0Xx/6e57wE=;
	b=Xg++0DKxdZimKaXAOTuH0GOm6OfRGt1oMkJe6sVl+5ZA31VUv2G4cMy/71xAxKxj1J/sM3
	pkU2GuGumaZz/4GD1EmfdzliVQNivPFTP/jFLYWf9WtpZivWRyIpvN0vnrXAhk/HUnHGrb
	fiMOqR3ViENcwoUs16BO600wv5y0d0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743596742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HGmEULEpy7HAvpeXVydfjIl8HFDnw89gh0Xx/6e57wE=;
	b=5eC5S8I3RAoAcPo11ECjFHhDlV6T6lsumwH51F6I95KQMk8f1/w/TUTIgFY8xfqgBDj4AJ
	q1iZIgx6uiwPyyAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743596742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HGmEULEpy7HAvpeXVydfjIl8HFDnw89gh0Xx/6e57wE=;
	b=Xg++0DKxdZimKaXAOTuH0GOm6OfRGt1oMkJe6sVl+5ZA31VUv2G4cMy/71xAxKxj1J/sM3
	pkU2GuGumaZz/4GD1EmfdzliVQNivPFTP/jFLYWf9WtpZivWRyIpvN0vnrXAhk/HUnHGrb
	fiMOqR3ViENcwoUs16BO600wv5y0d0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743596742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HGmEULEpy7HAvpeXVydfjIl8HFDnw89gh0Xx/6e57wE=;
	b=5eC5S8I3RAoAcPo11ECjFHhDlV6T6lsumwH51F6I95KQMk8f1/w/TUTIgFY8xfqgBDj4AJ
	q1iZIgx6uiwPyyAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3F2A137D4;
	Wed,  2 Apr 2025 12:25:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5TWIO8Us7WeZfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 02 Apr 2025 12:25:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A9FC4A07E6; Wed,  2 Apr 2025 14:25:41 +0200 (CEST)
Date: Wed, 2 Apr 2025 14:25:41 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alejandro Colomar <alx@kernel.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fanotify: Document mount namespace events
Message-ID: <uo4wxm2yjbawfriaz2mkh77qw2o64e6tc3iv25t3b3yyp5tj77@j5e2znz2syk6>
References: <20250401194629.1535477-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401194629.1535477-1-amir73il@gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 01-04-25 21:46:29, Amir Goldstein wrote:
> Used to subscribe for notifications for when mounts
> are attached/detached from a mount namespace.
> 
> Cc: Jan Kara <jack@suse.cz>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
> 
> Changes since v1:
> - Add RVB
> - Add reference to statx() unique mnt_id (Jan)
> - Fix description of MARK_MNTNS path (Miklos)
> 
>  man/man2/fanotify_init.2 | 20 ++++++++++++++++++
>  man/man2/fanotify_mark.2 | 35 +++++++++++++++++++++++++++++++-
>  man/man7/fanotify.7      | 44 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 98 insertions(+), 1 deletion(-)
> 
> diff --git a/man/man2/fanotify_init.2 b/man/man2/fanotify_init.2
> index 699b6f054..26289c496 100644
> --- a/man/man2/fanotify_init.2
> +++ b/man/man2/fanotify_init.2
> @@ -330,6 +330,26 @@ that the directory entry is referring to.
>  This is a synonym for
>  .RB ( FAN_REPORT_DFID_NAME | FAN_REPORT_FID | FAN_REPORT_TARGET_FID ).
>  .TP
> +.BR FAN_REPORT_MNT " (since Linux 6.14)"
> +.\" commit 0f46d81f2bce970b1c562aa3c944a271bbec2729
> +This value allows the receipt of events which contain additional information
> +about the underlying mount correlated to an event.
> +An additional record of type
> +.B FAN_EVENT_INFO_TYPE_MNT
> +encapsulates the information about the mount and is included alongside the
> +generic event metadata structure.
> +The use of
> +.BR FAN_CLASS_CONTENT ,
> +.BR FAN_CLASS_PRE_CONTENT,
> +or any of the
> +.B FAN_REPORT_DFID_NAME_TARGET
> +flags along with this flag is not permitted
> +and will result in the error
> +.BR EINVAL .
> +See
> +.BR fanotify (7)
> +for additional details.
> +.TP
>  .BR FAN_REPORT_PIDFD " (since Linux 5.15 and 5.10.220)"
>  .\" commit af579beb666aefb17e9a335c12c788c92932baf1
>  Events for fanotify groups initialized with this flag will contain
> diff --git a/man/man2/fanotify_mark.2 b/man/man2/fanotify_mark.2
> index da569279b..dab7e1a32 100644
> --- a/man/man2/fanotify_mark.2
> +++ b/man/man2/fanotify_mark.2
> @@ -67,7 +67,8 @@ contains
>  all marks for filesystems are removed from the group.
>  Otherwise, all marks for directories and files are removed.
>  No flag other than, and at most one of, the flags
> -.B FAN_MARK_MOUNT
> +.BR FAN_MARK_MNTNS ,
> +.BR FAN_MARK_MOUNT ,
>  or
>  .B FAN_MARK_FILESYSTEM
>  can be used in conjunction with
> @@ -99,6 +100,20 @@ If the filesystem object to be marked is not a directory, the error
>  .B ENOTDIR
>  shall be raised.
>  .TP
> +.BR FAN_MARK_MNTNS " (since Linux 6.14)"
> +.\" commit 0f46d81f2bce970b1c562aa3c944a271bbec2729
> +Mark the mount namespace specified by
> +.IR pathname .
> +If the
> +.I pathname
> +is not a path that represents a mount namespace (e.g.
> +.BR /proc/ pid /ns/mnt ),
> +the call fails with the error
> +.BR EINVAL .
> +An fanotify group that is initialized with flag
> +.B FAN_REPORT_MNT
> +is required.
> +.TP
>  .B FAN_MARK_MOUNT
>  Mark the mount specified by
>  .IR pathname .
> @@ -395,6 +410,24 @@ Create an event when a marked file or directory itself has been moved.
>  An fanotify group that identifies filesystem objects by file handles
>  is required.
>  .TP
> +.BR FAN_MNT_ATTACH ", " FAN_MNT_DETACH " (since Linux 6.14)"
> +.\" commit 0f46d81f2bce970b1c562aa3c944a271bbec2729
> +Create an event when a mount was attached to or detached from a marked mount namespace.
> +An attempt to set this flag on an inode, mount or filesystem mark
> +will result in the error
> +.BR EINVAL .
> +An fanotify group that is initialized with flag
> +.B FAN_REPORT_MNT
> +and the mark flag
> +.B FAN_MARK_MNTNS
> +are required.
> +An additional information record of type
> +.B FAN_EVENT_INFO_TYPE_MNT
> +is returned with the event.
> +See
> +.BR fanotify (7)
> +for additional details.
> +.TP
>  .BR FAN_FS_ERROR " (since Linux 5.16, 5.15.154, and 5.10.220)"
>  .\" commit 9709bd548f11a092d124698118013f66e1740f9b
>  Create an event when a filesystem error
> diff --git a/man/man7/fanotify.7 b/man/man7/fanotify.7
> index 77dcb8aa5..a2f766839 100644
> --- a/man/man7/fanotify.7
> +++ b/man/man7/fanotify.7
> @@ -228,6 +228,23 @@ struct fanotify_event_info_pidfd {
>  .EE
>  .in
>  .P
> +In cases where an fanotify group is initialized with
> +.BR FAN_REPORT_MNT ,
> +event listeners should expect to receive the below
> +information record object alongside the generic
> +.I fanotify_event_metadata
> +structure within the read buffer.
> +This structure is defined as follows:
> +.P
> +.in +4n
> +.EX
> +struct fanotify_event_info_mnt {
> +    struct fanotify_event_info_header hdr;
> +    __u64 mnt_id;
> +};
> +.EE
> +.in
> +.P
>  In case of a
>  .B FAN_FS_ERROR
>  event,
> @@ -442,6 +459,12 @@ A file or directory that was opened read-only
>  .RB ( O_RDONLY )
>  was closed.
>  .TP
> +.BR FAN_MNT_ATTACH
> +A mount was attached to mount namespace.
> +.TP
> +.BR FAN_MNT_DETACH
> +A mount was detached from mount namespace.
> +.TP
>  .B FAN_FS_ERROR
>  A filesystem error was detected.
>  .TP
> @@ -540,6 +563,7 @@ The value of this field can be set to one of the following:
>  .BR FAN_EVENT_INFO_TYPE_FID ,
>  .BR FAN_EVENT_INFO_TYPE_DFID ,
>  .BR FAN_EVENT_INFO_TYPE_DFID_NAME ,
> +.BR FAN_EVENT_INFO_TYPE_MNT ,
>  .BR FAN_EVENT_INFO_TYPE_ERROR ,
>  .BR FAN_EVENT_INFO_TYPE_RANGE ,
>  or
> @@ -727,6 +751,26 @@ in case of a terminated process, the value will be
>  .BR \-ESRCH .
>  .P
>  The fields of the
> +.I fanotify_event_info_mnt
> +structure are as follows:
> +.TP
> +.I .hdr
> +This is a structure of type
> +.IR fanotify_event_info_header .
> +The
> +.I .info_type
> +field is set to
> +.BR FAN_EVENT_INFO_TYPE_MNT .
> +.TP
> +.I .mnt_id
> +Identifies the mount associated with the event.
> +It is a 64bit unique mount id as the one returned by
> +.BR statx (2)
> +with the
> +.BR STATX_MNT_ID_UNIQUE
> +flag.
> +.P
> +The fields of the
>  .I fanotify_event_info_error
>  structure are as follows:
>  .TP
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

