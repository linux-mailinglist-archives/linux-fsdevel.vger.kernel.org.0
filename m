Return-Path: <linux-fsdevel+bounces-65433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF6CC05035
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 10:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F94188A82A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 08:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9932B303C8B;
	Fri, 24 Oct 2025 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P3KNtUVe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gFE4XOXn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Se5jpWc2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9ilVHeZA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D59C303A37
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 08:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293776; cv=none; b=YgaS9Z2aqY5erVe4iUyfbwXLL2ql4USCZ9kjoGPgA9rRuL/9NMTU+QUf/esfFiJc3SKBNJmjoq9ODcaoiMfqB30CMhH56vf26wPJxzZXwPErYFvdBcpicYzktXYn8lxObVG/MEfOwmIntH19oOjJGCHn7DYwnNl/xUAFDvtFhD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293776; c=relaxed/simple;
	bh=yQDrtNvjKJr/WaX1Mv8sYjcgQzM/jpXVpNYnmYky8iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6aui3hIMQjCML9kK0hsT4rh2ZtD3CnYvI6fzdVzfY19zPZ2o1zqJMMirqeQVp0pB1TwPt1GXv5tUIoQUB6FCAZwmV8nMqpKxWbQbtGhSxAuPYneiovoe+TidKT2mWfNXJcoDdA/9csGd2hYU6HIS0uacgYfhmZ0uBjuiW94Rpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P3KNtUVe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gFE4XOXn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Se5jpWc2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9ilVHeZA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 719802115D;
	Fri, 24 Oct 2025 08:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761293768;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yQDrtNvjKJr/WaX1Mv8sYjcgQzM/jpXVpNYnmYky8iM=;
	b=P3KNtUVe0ldSy98VSM78tDn84HB2P3mLf6OFCxxGmGZzmE6AxyQ5OJlIgQF68KBRTiD5LQ
	m8N3/y6RRFF0UwWegrrtiMB5fvVbatXWNC2jxe43dMoQ4We6FS94NkEXRc6XUc3mM2ViiS
	2OMdXbXTBu+Wb+w20Kc1aGroWXsp5tE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761293768;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yQDrtNvjKJr/WaX1Mv8sYjcgQzM/jpXVpNYnmYky8iM=;
	b=gFE4XOXn9cXYTHuN8v6d1dMC+9tEnYU+VKr3dMyw6tgKU4YcOZm6AKLce668GR+WoNZQw2
	kRYYxH9hRNFNBVAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761293764;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yQDrtNvjKJr/WaX1Mv8sYjcgQzM/jpXVpNYnmYky8iM=;
	b=Se5jpWc2cAjwm0BK9VAslFH3u0dTHv0RliJcduVrRQ/y3nrEbMswBz0lz7b7C7Eg2yCW3w
	MU19J1edMKCoWf9+fUznlzLpmPtlK7nAshTGZhu/QawwJDNlG7YHVk3OHATRm5X9Qg7lII
	gOaJIDjYeJ7Q5Pc/UcNk4DD8KWe/Ifc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761293764;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yQDrtNvjKJr/WaX1Mv8sYjcgQzM/jpXVpNYnmYky8iM=;
	b=9ilVHeZAI6Ljz61brD4UoVTahQP8+0e2eJAStRvnh40t4t+dqvXglwqxraU6E3QWfnvyeh
	BgntVsYK1p7QUQCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F411313693;
	Fri, 24 Oct 2025 08:16:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xsQdM8I1+2g8RwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 24 Oct 2025 08:16:02 +0000
Date: Fri, 24 Oct 2025 10:15:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, ltp@lists.linux.it,
	lkft@linaro.org, arnd@kernel.org, dan.carpenter@linaro.org,
	jack@suse.cz, brauner@kernel.org, chrubis@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	regressions@lists.linux.dev, aalbersh@kernel.org, arnd@arndb.de,
	viro@zeniv.linux.org.uk, benjamin.copeland@linaro.org,
	andrea.cervesato@suse.com, lkft-triage@lists.linaro.org,
	Avinesh Kumar <akumar@suse.de>
Subject: Re: [PATCH v2] ioctl_pidfd05: accept both EINVAL and ENOTTY as valid
 errors
Message-ID: <20251024081556.GA570960@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20251023164401.302967-1-naresh.kamboju@linaro.org>
 <CADYN=9J1xAgctUqwptD5C3Ss9aJZvZQ2ep=Ck2zP6X+ZrKe81Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADYN=9J1xAgctUqwptD5C3Ss9aJZvZQ2ep=Ck2zP6X+ZrKe81Q@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -3.50

Hi all,

> On Thu, 23 Oct 2025 at 18:44, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> > Newer kernels (since ~v6.18-rc1) return ENOTTY instead of EINVAL when
> > invoking ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid). Update the
> > test to accept both EINVAL and ENOTTY as valid errors to ensure
> > compatibility across different kernel versions.

I dared to add a commit which caused the change (found by Cyril Hrubis):
3c17001b21b9f ("pidfs: validate extensible ioctls")

and merged!

Thanks for fix and review!

Kind regards,
Petr

