Return-Path: <linux-fsdevel+bounces-24822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 854DB945138
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 19:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF39283982
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 17:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A901B3736;
	Thu,  1 Aug 2024 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jkg2ceAT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OorEbdqf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jkg2ceAT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OorEbdqf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93CF3A1DA
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722531689; cv=none; b=iwyJUxNT7kQ7ezt3WgcbjEXCyJOUfYjCwaZiVh93+zecmaNZTGCCj+zW5fdk/EtwKrPSwFZDjNvtxLPZICh8I8bX4cfutlSkRy9+AuCieIbFbEr1m81UztlCjbM5pHLZ1XM+evYs/owq0i2R08Of6QqIUnvMiLWOgZmj7xTB7NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722531689; c=relaxed/simple;
	bh=47pqmzqKVw4ziSBqeqroDARFzDNsE9HbX2TQ8eqcJFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6aILcjFl50h08U3+n1JJX9eqU6CqmPcmsBANzZqCs2I2luJL9NZiDkbbvRlP+Gs9asw+goddAL2PZJgTLq8/YZ036FyQrVonlZjdEKwypaPLsp5FbbcdoBDt5hNW5eVOEF15AWVrUlR5yaMsjVr6L07llM+V6ZdN3mImTY9e4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jkg2ceAT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OorEbdqf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jkg2ceAT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OorEbdqf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E44A51FB46;
	Thu,  1 Aug 2024 17:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722531685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D6/EBeX7gKAjx1HG6XQ71hszifht8PAoz56OZ14b9BE=;
	b=jkg2ceATeW1pcrkp1yqHqrL6+It1SVDIfHfPG+HOvk0o1rh43f8kRz37BDSQYl2FJ8maXT
	4nUf4OVRbyg5zJL/cJp/w+9P/k/SmrnGTERMfrGMGHiCub9oUhr7v5M804F0t3bNkHc3dR
	GZwKQM0stDnNwGjSzQP+azDZk6QHjsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722531685;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D6/EBeX7gKAjx1HG6XQ71hszifht8PAoz56OZ14b9BE=;
	b=OorEbdqfLKrrh1VqE2LZcAwihVTGFCx/7YzqXAPNBCex9oBMnVfxAXIPZ9h+wtK5Exgugs
	eG6uqvIyCy2tN6AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722531685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D6/EBeX7gKAjx1HG6XQ71hszifht8PAoz56OZ14b9BE=;
	b=jkg2ceATeW1pcrkp1yqHqrL6+It1SVDIfHfPG+HOvk0o1rh43f8kRz37BDSQYl2FJ8maXT
	4nUf4OVRbyg5zJL/cJp/w+9P/k/SmrnGTERMfrGMGHiCub9oUhr7v5M804F0t3bNkHc3dR
	GZwKQM0stDnNwGjSzQP+azDZk6QHjsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722531685;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D6/EBeX7gKAjx1HG6XQ71hszifht8PAoz56OZ14b9BE=;
	b=OorEbdqfLKrrh1VqE2LZcAwihVTGFCx/7YzqXAPNBCex9oBMnVfxAXIPZ9h+wtK5Exgugs
	eG6uqvIyCy2tN6AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D89E7136CF;
	Thu,  1 Aug 2024 17:01:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OlDcNGW/q2aRLwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Aug 2024 17:01:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5C95DA08CB; Thu,  1 Aug 2024 19:01:25 +0200 (CEST)
Date: Thu, 1 Aug 2024 19:01:25 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 03/10] fsnotify: generate pre-content permission event on
 open
Message-ID: <20240801170125.uimwmtbt4s6y7a5x@quack3>
References: <cover.1721931241.git.josef@toxicpanda.com>
 <c105b804f1f6e14d7536b98fea428211b131473a.1721931241.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c105b804f1f6e14d7536b98fea428211b131473a.1721931241.git.josef@toxicpanda.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-0.60 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -0.60

On Thu 25-07-24 14:19:40, Josef Bacik wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on open depending on
> file open mode.  The pre-content event will be generated in addition to
> FS_OPEN_PERM, but without sb_writers held and after file was truncated
> in case file was opened with O_CREAT and/or O_TRUNC.
> 
> The event will have a range info of (0..0) to provide an opportunity
> to fill entire file content on open.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

...

> @@ -176,10 +180,14 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
>  
>  /*
>   * fsnotify_file_perm - permission hook before file access
> + *
> + * Called from read()/write() with perm_mas MAY_READ/MAY_WRITE.
					^^^ perm_mask

> + * Called from open() with MAY_OPEN in addition to fsnotify_open_perm(),
> + * but without sb_writers held and after the file was truncated.

This sentence is a bit confusing to me (although I think I understand what
you want to say). How about just:

 * Called from open() with MAY_OPEN without sb_writers held and after the
 * file was truncated. Note that this is a different event from
 * fsnotify_open_perm().

>   */
>  static inline int fsnotify_file_perm(struct file *file, int perm_mask)
>  {
> -	return fsnotify_file_area_perm(file, perm_mask, NULL, 0);
> +	return fsnotify_file_area_perm(file, perm_mask, &file->f_pos, 0);
>  }

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

