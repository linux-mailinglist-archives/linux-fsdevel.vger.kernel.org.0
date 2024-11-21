Return-Path: <linux-fsdevel+bounces-35409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0349D4B05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3A628558A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 10:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22CE1D0B8B;
	Thu, 21 Nov 2024 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DMU+x6kw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cU49+M/h";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xx66AgB/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xQRHClmm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410A613C695;
	Thu, 21 Nov 2024 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732185877; cv=none; b=LpBoS1HYPqW0HyeyGySHbThXNMoCydCqgWGK9v90KBcjnW0VlrAp/ulnmgytTjqKzSmHRP4GYH8GPJoTgD8uAiCBoyWhO8qGEHhy2iHopYPF62+xAiP6OjxZxH5zv8V4Ofla5CuSnjRtFrDAi2A0XPdl+iOUFqMo8O7+tyUwPmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732185877; c=relaxed/simple;
	bh=Bs1suo0DtONuf+Um+1gxdgWDstlL4jWpxALZt7lqnkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksB2iYQxk4haiHlxZYGWFMqZ+bAA+WBbDSKrViZrM85/+0ZZ19NUCDrosPJDK7S3Gz9G0/tRAvY7wjvP8PBwfWXb+Vky0p700R5+T1DBtbbNGZJHobDyLwtZ0aU1EHAfZkBkb1f+Rl8trtqxUJLWDar8esD2YT+S8yrJFZ95M0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DMU+x6kw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cU49+M/h; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xx66AgB/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xQRHClmm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA2D11F7F2;
	Thu, 21 Nov 2024 10:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732185873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2odM2XwiSeig2qspZJhLnYlq4MgMTonOwI79YapIuR8=;
	b=DMU+x6kw4T5uyBoVt55eYOwF/PSE30mbyoOUYZCURemhDx9jEDyadG+Qbz39DDLQLtfFJ2
	eisI63F5peHstrwRPIyj4SDLKm13CdIIfY+V8AeHzP44MCspAkcbbz21d/0++w4p/aJsOa
	dR5YrULS2pXCiDJ9+fe2yDTzrB+aUWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732185873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2odM2XwiSeig2qspZJhLnYlq4MgMTonOwI79YapIuR8=;
	b=cU49+M/hbeCKK9XSXJVjNjN40leAntPTJ6+doHXRLfdq+vCmOCcxTxFep4kVLho2r5ZTy8
	+t4aX6spNM3hmpDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Xx66AgB/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xQRHClmm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732185872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2odM2XwiSeig2qspZJhLnYlq4MgMTonOwI79YapIuR8=;
	b=Xx66AgB/DMGr+Di0pE0UOUC4OvHrtZ2+N22JmMMQ5AOqHY0WkNPgqC/TkJLwgzg0FGn3cT
	f9ecyyhkwevA4d+ciChN8T263SR/W7XkYmK17YlC31+l6Fpi5h1cZCIi8hfUq7CpU0i2PL
	/PM9xsyFhlH1x+RF/bFNfMs3wQbBgrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732185872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2odM2XwiSeig2qspZJhLnYlq4MgMTonOwI79YapIuR8=;
	b=xQRHClmmPLzJw7SScv3PkXKxg7LCaj9fxYsbPe6x2P8w0byupibKmX4ttocCoJKumO/Dke
	GMEcWUopWS+ySdDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D862C137CF;
	Thu, 21 Nov 2024 10:44:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GDmLNBAPP2dUcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 10:44:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 89D9BA089E; Thu, 21 Nov 2024 11:44:28 +0100 (CET)
Date: Thu, 21 Nov 2024 11:44:28 +0100
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org,
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v8 10/19] fanotify: introduce FAN_PRE_ACCESS permission
 event
Message-ID: <20241121104428.wtlrfhadcvipkjia@quack3>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <b80986f8d5b860acea2c9a73c0acd93587be5fe4.1731684329.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b80986f8d5b860acea2c9a73c0acd93587be5fe4.1731684329.git.josef@toxicpanda.com>
X-Rspamd-Queue-Id: EA2D11F7F2
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org,linux-foundation.org,zeniv.linux.org.uk,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 15-11-24 10:30:23, Josef Bacik wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> Similar to FAN_ACCESS_PERM permission event, but it is only allowed with
> class FAN_CLASS_PRE_CONTENT and only allowed on regular files and dirs.
> 
> Unlike FAN_ACCESS_PERM, it is safe to write to the file being accessed
> in the context of the event handler.
> 
> This pre-content event is meant to be used by hierarchical storage
> managers that want to fill the content of files on first read access.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Here I was wondering about one thing:

> +	/*
> +	 * Filesystems need to opt-into pre-content evnets (a.k.a HSM)
> +	 * and they are only supported on regular files and directories.
> +	 */
> +	if (mask & FANOTIFY_PRE_CONTENT_EVENTS) {
> +		if (!(path->mnt->mnt_sb->s_iflags & SB_I_ALLOW_HSM))
> +			return -EINVAL;
> +		if (!is_dir && !d_is_reg(path->dentry))
> +			return -EINVAL;
> +	}

AFAICS, currently no pre-content events are generated for directories. So
perhaps we should refuse directories here as well for now? I'd like to
avoid the mistake of original fanotify which had some events available on
directories but they did nothing and then you have to ponder hard whether
you're going to break userspace if you actually start emitting them...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

