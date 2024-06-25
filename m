Return-Path: <linux-fsdevel+bounces-22317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FB7916553
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 12:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6FD1F23205
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 10:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D2714A4DC;
	Tue, 25 Jun 2024 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UHNTXEcY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K4hrgVPk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UHNTXEcY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K4hrgVPk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FC514A4CC;
	Tue, 25 Jun 2024 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719311818; cv=none; b=JoLbtrHY5w7009S9uxsZQimOfg7zuruqTiF5QKS8FdXYcVkCfIG0N8w9uQIlqFo7CGHXZjFu5DvDn3avz53HME/vD9diSl+qGHwz5LNsmeFyCuxAdwc0e31ic8VWaGobvcmmnzoUPrWq11hcO55OwMDA54x1S3jsW/o531SIqMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719311818; c=relaxed/simple;
	bh=V9ge5PEsq68iK3SY4uv+xZ7ugwu//+dBKqZw3UujnRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jC6ujPyqbUn38tGQiPYX5JjNOYyIy0CGf61KeJSxLeNAdnejtyy/7QYj+MLVCbU7V37suXRnqHstQuHWPUIkWzfpi6KrymRiXbEvugkPKCG756lluU1zX8vLZyaS9Ib3xL3/drrIkMH0qyV12pWQlt4vJLfzldTrMFqU8k8kI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UHNTXEcY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K4hrgVPk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UHNTXEcY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K4hrgVPk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07E1C21A6D;
	Tue, 25 Jun 2024 10:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719311814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dOxH/mMch9vEgRGxLUd6OPps9sVmCT7La0oUktmP5zQ=;
	b=UHNTXEcYWrxhg/B3pQMUz3EPQff483y7WiABrapkhI9mF8ExRZdPqtQpk64SwipcNEO0ym
	1kut2p4LK2ZoU8NFYvdeNmGkv9k96+hfh2C1pRXssOXfnlKXhATfYmcqDHN3MMgVb7m8mR
	QAL2P2dlEx6dxjRJjcGuAGYt2DULEtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719311814;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dOxH/mMch9vEgRGxLUd6OPps9sVmCT7La0oUktmP5zQ=;
	b=K4hrgVPkXEqGdu2WS2DwQcu2yvoQyTJzq0WTISScDkHGSMT/XKAwdQ/gO5Tbg8T2YnfvGd
	hpCFg4cHhHGNP3Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UHNTXEcY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=K4hrgVPk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719311814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dOxH/mMch9vEgRGxLUd6OPps9sVmCT7La0oUktmP5zQ=;
	b=UHNTXEcYWrxhg/B3pQMUz3EPQff483y7WiABrapkhI9mF8ExRZdPqtQpk64SwipcNEO0ym
	1kut2p4LK2ZoU8NFYvdeNmGkv9k96+hfh2C1pRXssOXfnlKXhATfYmcqDHN3MMgVb7m8mR
	QAL2P2dlEx6dxjRJjcGuAGYt2DULEtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719311814;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dOxH/mMch9vEgRGxLUd6OPps9sVmCT7La0oUktmP5zQ=;
	b=K4hrgVPkXEqGdu2WS2DwQcu2yvoQyTJzq0WTISScDkHGSMT/XKAwdQ/gO5Tbg8T2YnfvGd
	hpCFg4cHhHGNP3Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC6491384C;
	Tue, 25 Jun 2024 10:36:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RvegOcWdemYsXwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Jun 2024 10:36:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 90444A090B; Tue, 25 Jun 2024 12:36:53 +0200 (CEST)
Date: Tue, 25 Jun 2024 12:36:53 +0200
From: Jan Kara <jack@suse.cz>
To: zippermonkey <zzippermonkey@outlook.com>
Cc: zhangpengpeng0808@gmail.com, akpm@linux-foundation.org,
	bruzzhang@tencent.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	vernhao@tencent.com, willy@infradead.org, zigiwang@tencent.com,
	jack@suse.cz
Subject: Re: [PATCH RFC] mm/readahead: Fix repeat initial_readahead
Message-ID: <20240625103653.uzabtus3yq2lo3o6@quack3>
References: <20240618114941.5935-1-zhangpengpeng0808@gmail.com>
 <SYBP282MB2224E68F688DD74FFEA86AA6B9D52@SYBP282MB2224.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBP282MB2224E68F688DD74FFEA86AA6B9D52@SYBP282MB2224.AUSP282.PROD.OUTLOOK.COM>
X-Rspamd-Queue-Id: 07E1C21A6D
X-Spam-Score: -3.98
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.98 / 50.00];
	BAYES_HAM(-2.97)[99.88%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[outlook.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.com];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,tencent.com,vger.kernel.org,kvack.org,infradead.org,suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue 25-06-24 14:28:34, zippermonkey wrote:
> To illustrate this problem, I created the following example:
> 
> Assuming that the process reads sequentially from the beginning of the file
> and
> calls the `page_cache_sync_readahead` function. In this sync readahead
> function,
> since the index is 0, it will proceed to `initial_readahead` and initialize
> `ra_state`. It allocates a folio with an order of 2 and marks it as
> PG_readahead.
> Next, because` (folio_test_readahead(folio))` is true, the
> page_cache_async_ra
> function is called, which causes the `ra_state` to be initialized again.

Good spotting guys! There are actually more problems in the readahead code.
I have just pushed out a patch series [1] addressing several issues that
should also address the problem you've found. Can you please test whether
it provides a similar speedup as your fix (sorry, I forgot to CC you on the
series)? Thanks!

[1] https://lore.kernel.org/20240625100859.15507-1-jack@suse.cz

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

