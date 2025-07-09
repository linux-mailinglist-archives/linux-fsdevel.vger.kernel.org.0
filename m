Return-Path: <linux-fsdevel+bounces-54333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E44AFE1CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 10:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A621BC3A22
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 08:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C09231C91;
	Wed,  9 Jul 2025 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="reNW3Ye/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c8c3klp9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="reNW3Ye/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c8c3klp9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C09222539E
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048184; cv=none; b=i8JvbOjG/gK5jCnyiv1Y27CnXzlJnRkxvdAxHNKBKt4XH+rBVH9quiJCI02COrjpSnqtOUabNN23KkjQVR7kDEX62EvcJ8UoOhAi4kbz87MWfVsaH/6xVGKsQo9WCnEyujCugjDuJ/HVsV+U4iHFf0pJv3fMlz9m9vjC0lzyIf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048184; c=relaxed/simple;
	bh=2hVj3WPJGTOI5ttR0BXZCu36RqDG3d5KvV84aozwaT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIke2bhfOxXUHmQ1SkflMowTAvGIEA0zRh8BgLVffjYOWyTRup4jBhogkQuOQ9MYZgHaRCdlbhnc8UmszMjOU0Of9miy6ycmjEv/pxr1J+5W27Um+4NaKKuo/Gssp6PhTA/V0aInrztyFhW2ALTFxfku0HxuIZqTv+hHZddPIKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=reNW3Ye/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c8c3klp9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=reNW3Ye/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c8c3klp9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 225041F456;
	Wed,  9 Jul 2025 08:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752048180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D4USnKXLWVvhNtIXh9OCfgW10nJLrrVasICrkzTcF/Q=;
	b=reNW3Ye/JT4pOFyNnb3qTzur+8DixYMTxo571yrPPJxKPb8xUG38sGALu1M0JH/Wfh6+dW
	6mCFd0KHhGJ/Yp/bHGLKM3n8sGhukmRTvvLY9sqW4lk+lGVQcEKklIpQAcfAr+9YTjpQmo
	iXytIYfW9/RMDEijl9WAHc6QsCXJRwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752048180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D4USnKXLWVvhNtIXh9OCfgW10nJLrrVasICrkzTcF/Q=;
	b=c8c3klp9cDCWCfI97Eg9wnwr6nrRBHxrlacDL9GIsyMnEk4/H9RTfbFTddu9IzrRQ1+v9a
	SruPFGtSC+YHR6Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752048180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D4USnKXLWVvhNtIXh9OCfgW10nJLrrVasICrkzTcF/Q=;
	b=reNW3Ye/JT4pOFyNnb3qTzur+8DixYMTxo571yrPPJxKPb8xUG38sGALu1M0JH/Wfh6+dW
	6mCFd0KHhGJ/Yp/bHGLKM3n8sGhukmRTvvLY9sqW4lk+lGVQcEKklIpQAcfAr+9YTjpQmo
	iXytIYfW9/RMDEijl9WAHc6QsCXJRwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752048180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D4USnKXLWVvhNtIXh9OCfgW10nJLrrVasICrkzTcF/Q=;
	b=c8c3klp9cDCWCfI97Eg9wnwr6nrRBHxrlacDL9GIsyMnEk4/H9RTfbFTddu9IzrRQ1+v9a
	SruPFGtSC+YHR6Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16A0B136DC;
	Wed,  9 Jul 2025 08:03:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xdqCBTQibmgpcAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 09 Jul 2025 08:03:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AABEFA0A48; Wed,  9 Jul 2025 10:02:55 +0200 (CEST)
Date: Wed, 9 Jul 2025 10:02:55 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] More fsnotify hook optimizations
Message-ID: <bq6zo74rqcxrxsvna2brbijh6vspvpqhnfspl7qor3cm5vicoi@habq7bbppcxa>
References: <20250708143641.418603-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708143641.418603-1-amir73il@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

Hello!

On Tue 08-07-25 16:36:39, Amir Goldstein wrote:
> Following v2 addresses your review comments on v1 [1].
> 
> Changes since v1:
> - Raname macro to FMODE_NOTIFY_ACCESS_PERM()
> - Remove unneeded and unused event set macros
> 
> [1] https://lore.kernel.org/linux-fsdevel/20250707170704.303772-1-amir73il@gmail.com/
> 
> Amir Goldstein (2):
>   fsnotify: merge file_set_fsnotify_mode_from_watchers() with open perm
>     hook
>   fsnotify: optimize FMODE_NONOTIFY_PERM for the common cases

Thanks! I've merged the patches to my tree (after fixing up some typos).

								Honza

> 
>  fs/file_table.c          |  2 +-
>  fs/notify/fsnotify.c     | 87 ++++++++++++++++++++++++----------------
>  fs/open.c                |  6 +--
>  include/linux/fs.h       | 12 +++---
>  include/linux/fsnotify.h | 35 +++-------------
>  5 files changed, 68 insertions(+), 74 deletions(-)
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

