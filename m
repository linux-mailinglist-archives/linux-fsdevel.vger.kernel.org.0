Return-Path: <linux-fsdevel+bounces-45346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C414A7674E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 16:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E86188BB28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 14:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314622139C9;
	Mon, 31 Mar 2025 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pyJ7cTn7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Agd/pGK7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pyJ7cTn7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Agd/pGK7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06AF2135A1
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743429789; cv=none; b=fP2CzPLg2Vp7VvWot6/XSCyGN0nODDlyUO/0gD49qFFX8iE170sfWhAzVCZmZqeoe/FklfK1FkocNTeCX55nR+7wmidvFAp6n+w9G1zngd8oHBO55bSBo5/3+4a4iF/YIiIexr7uShxQyP5eE5S0t9gkZmyTqueb6LiDHXzY+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743429789; c=relaxed/simple;
	bh=8cCl+J8Of4LIDCZYO3CP+remfRlI8OBkPk561ZM4lbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cs3hqOQttxtKfCdsmN50Cs72gLDgOA6E6CyrW5VHtN9QZw54bgys20H39cZj5XUBm8gWBEfxTopsC1FHJEKbO/wnoPNMEgiTbrK4246zf5qu7jfqBLYtDs5SXmZOgNoMVteEcpupH9YRJVFuwe51KCsxQKXviJH1r5rkizYIvS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pyJ7cTn7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Agd/pGK7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pyJ7cTn7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Agd/pGK7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D33421201;
	Mon, 31 Mar 2025 14:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743429785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8yPvJPH+z1JsVLJz+ZjnOcry2V+7U8/Pvy6GC6y1IYY=;
	b=pyJ7cTn7eYhpYS/865CCMeAdpiQ7Ynn58mqOmV0I0R5YWL3Bl/cHeN5x6R05vPZW0OS6JB
	1riuRpGPctU6bw5WgjqmcIHrBW5sxB3NBtjnLySCqrn4FnwT9fvXUftI5X/WQTLu134T4U
	QITqaln70OX+ru2iExgY3LDBr1pHyZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743429785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8yPvJPH+z1JsVLJz+ZjnOcry2V+7U8/Pvy6GC6y1IYY=;
	b=Agd/pGK7tpYmGu8U5lg9tcJ13g3Uav7VHY8W1UrAkPGXXVz1iTirJE0a3okVBETqqPEPhs
	zuVgbZA+cB+vGjBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pyJ7cTn7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Agd/pGK7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743429785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8yPvJPH+z1JsVLJz+ZjnOcry2V+7U8/Pvy6GC6y1IYY=;
	b=pyJ7cTn7eYhpYS/865CCMeAdpiQ7Ynn58mqOmV0I0R5YWL3Bl/cHeN5x6R05vPZW0OS6JB
	1riuRpGPctU6bw5WgjqmcIHrBW5sxB3NBtjnLySCqrn4FnwT9fvXUftI5X/WQTLu134T4U
	QITqaln70OX+ru2iExgY3LDBr1pHyZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743429785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8yPvJPH+z1JsVLJz+ZjnOcry2V+7U8/Pvy6GC6y1IYY=;
	b=Agd/pGK7tpYmGu8U5lg9tcJ13g3Uav7VHY8W1UrAkPGXXVz1iTirJE0a3okVBETqqPEPhs
	zuVgbZA+cB+vGjBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F283113A1F;
	Mon, 31 Mar 2025 14:03:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7gLnOpig6md+LgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 31 Mar 2025 14:03:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A2633A08CF; Mon, 31 Mar 2025 16:03:04 +0200 (CEST)
Date: Mon, 31 Mar 2025 16:03:04 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alejandro Colomar <alx@kernel.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: Document mount namespace events
Message-ID: <3k2d32vlljorweynxujgyi4ezkkhbbmg6bfud26fthtg5xrpci@7dtdk72cvaga>
References: <20250331135101.1436770-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331135101.1436770-1-amir73il@gmail.com>
X-Rspamd-Queue-Id: 0D33421201
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
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 31-03-25 15:51:01, Amir Goldstein wrote:
> Used to subscribe for notifications for when mounts
> are attached/detached from a mount namespace.
> 
> Cc: Jan Kara <jack@suse.cz>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
...
> @@ -442,6 +459,12 @@ A file or directory that was opened read-only
>  .RB ( O_RDONLY )
>  was closed.
>  .TP
> +.BR FAN_MNT_ATTACH
> +A mount was attached to mount namespace.
> +.TP
> +.BR FAN_MNT_DETACH
> +A mount was detached to mount namespace.
			^^ from

> @@ -727,6 +751,21 @@ in case of a terminated process, the value will be
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

Since mnt_id is not well established, I think we should tell here a bit
more about the mnt_id - that this is the ID you'll get from listmount(2)
and can use it e.g. with statmount(2).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

