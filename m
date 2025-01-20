Return-Path: <linux-fsdevel+bounces-39685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD78A16F42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 16:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F66F3A70DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 15:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4C01E7678;
	Mon, 20 Jan 2025 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G4x7nehP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cmfxEUix";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G4x7nehP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cmfxEUix"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D30D1E411D
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737387137; cv=none; b=gSXpWshmXLqArpMqsy29xpZIS45+/nnR6fKFLo0PoBLatNbsId++UEVGH1D5KruiXAbEhXkSUJlGsmNcm47wrukW4AMweZdNdEbILsYNEIUMBuLhwIc1v0xRL/rL3G7QXvOrYVlKPITj1GgdkjS8E7BpEwy4oGXTflYTZ23Xaq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737387137; c=relaxed/simple;
	bh=4ZQpPHbecc5NhxZz7Gttn8B4RN5ivDxDp18FLlxeYQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqCGHiR0uLIyvVBHyihpL+7HUes4sTlAGu4J8o/QojaDPfr21pYGg4h6Gby3BGPwUqnOWTNnX/xfBXvJrDyyg7vcMSwxjxOgG5zcaib8Qfqhm/1KsX/zmSjBxOIo2ucrfLrLFTb2sbKQPTsGmPP2JZ6WUGNEo/Xmh1KpRTzcCzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G4x7nehP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cmfxEUix; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G4x7nehP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cmfxEUix; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 372122117C;
	Mon, 20 Jan 2025 15:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737387134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NWo+OnZkpC5CZz7X4gQJSQuGi4VHj9JPgWXbX7uTVxw=;
	b=G4x7nehPRnnrBGObgh0+0nS5ZR1SxaHywdOAvJzlx5avZAFyO2a2WVBcJy8MLB2DNVU9d+
	UHXUJGrXsKXzliFQau5MmqOF+Cgqcv1RSnpfl/EItdZkPYU7HK5Xyteo2VzHFKLH3+7Xeu
	T2yTLOzDI7UJ6/IP3fXTXffn9KcF5iU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737387134;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NWo+OnZkpC5CZz7X4gQJSQuGi4VHj9JPgWXbX7uTVxw=;
	b=cmfxEUixA8hlQOMBvxmRnvD7JHUQ9rLy+utbCk/3mkr9DZmE5sZJjK3f3XVgQM2MMXuV3w
	4mo56iFpJqRLXZCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=G4x7nehP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cmfxEUix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737387134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NWo+OnZkpC5CZz7X4gQJSQuGi4VHj9JPgWXbX7uTVxw=;
	b=G4x7nehPRnnrBGObgh0+0nS5ZR1SxaHywdOAvJzlx5avZAFyO2a2WVBcJy8MLB2DNVU9d+
	UHXUJGrXsKXzliFQau5MmqOF+Cgqcv1RSnpfl/EItdZkPYU7HK5Xyteo2VzHFKLH3+7Xeu
	T2yTLOzDI7UJ6/IP3fXTXffn9KcF5iU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737387134;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NWo+OnZkpC5CZz7X4gQJSQuGi4VHj9JPgWXbX7uTVxw=;
	b=cmfxEUixA8hlQOMBvxmRnvD7JHUQ9rLy+utbCk/3mkr9DZmE5sZJjK3f3XVgQM2MMXuV3w
	4mo56iFpJqRLXZCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F54F1393E;
	Mon, 20 Jan 2025 15:32:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2YWhB35sjmd6cwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Jan 2025 15:32:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C44C4A081E; Mon, 20 Jan 2025 16:31:58 +0100 (CET)
Date: Mon, 20 Jan 2025 16:31:58 +0100
From: Jan Kara <jack@suse.cz>
To: Yuichiro Tsuji <yuichtsu@amazon.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v1 vfs 0/2] Fix the return type of several functions from
 long to int
Message-ID: <itcd5fl4jxbpxueeyr335wo2q3wvhauptcofqd3fnc3ktqljyz@2mvycuenzqd4>
References: <20250119090322.2598-1-yuichtsu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250119090322.2598-1-yuichtsu@amazon.com>
X-Rspamd-Queue-Id: 372122117C
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Sun 19-01-25 18:02:47, Yuichiro Tsuji wrote:
> These patches fix the return type of several functions from long to int to
> match its actual behavior.
> 
> Yuichiro Tsuji (2):
>   open: Fix return type of several functions from long to int
>   ioctl: Fix return type of several functions from long to int

The patches look good to me. Thanks! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

but you will need to provide your Signed-off-by tag (see
Documentation/process/submitting-patches.rst, chapter "Sign your work - the
Developer's Certificate of Origin") so that these patches can be merged. 

								Honza

> 
>  fs/internal.h            |  4 ++--
>  fs/ioctl.c               |  6 +++---
>  fs/open.c                | 18 +++++++++---------
>  include/linux/fs.h       |  6 +++---
>  include/linux/syscalls.h |  4 ++--
>  5 files changed, 19 insertions(+), 19 deletions(-)
> 
> -- 
> 2.43.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

