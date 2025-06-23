Return-Path: <linux-fsdevel+bounces-52526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51197AE3D5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29A947A98D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 10:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B542623C8DB;
	Mon, 23 Jun 2025 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ys9CTIv6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gnA2QG4Z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ys9CTIv6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gnA2QG4Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A98E1C8FB5
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 10:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675975; cv=none; b=pje94aukelwAZyxpaMx1YA2aIrMmqqr9nyP6h2+axLvqAjHBnC32Sc1b3gEnOOf9h2De87XuwBmFHfEoh9hZc8VWbE2GSQHJP4N1gHMvL1tksUAhtYQypEpviyz/RU+1WVE471SBJ2ch2D/8jZk0xQ5u47LxeSteGZKAFy0qADs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675975; c=relaxed/simple;
	bh=K4yThSDueV+AZ0w+s23aWYis98NN54wJ9EH+EVikzYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=if8X16Qs17D8bHVucIoj6gUVqSI+65cXhtKe5Ojl7+PI/HNTRIvB4+BWRPtZYqpRsue1H/StNimWeNqxixBUiUcf9vpHpNsqVP153azjx9a4Bn7jyZcj6P8cx/ZScPK5gBeTou5xlQvPLg4ydp9EeOIebqLMOySaTwuC4LWD1Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ys9CTIv6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gnA2QG4Z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ys9CTIv6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gnA2QG4Z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D1CAC21174;
	Mon, 23 Jun 2025 10:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750675971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6U+vycsx0yOGyeto/sQB753cmjZS5l0fRUpZ5LcgcIw=;
	b=Ys9CTIv6p2+9ZvWZkv/yo481zGnFbs/Y+KtaSyN6dQrXBpXaEuycMWkIYBWCIW+PD5yx/5
	msxRwA31m5T9BLq8G60U46gQJ9I2kQksGSEXp/gwkg4MzitCdB9WhaxZWXktDpTJOSR8YC
	wlHUTzV/441AmQGKx/RE6Gcx3Bgy/c8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750675971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6U+vycsx0yOGyeto/sQB753cmjZS5l0fRUpZ5LcgcIw=;
	b=gnA2QG4Z75pKwDZQOAb/+uDU1J0tnBNYGYJq/5RuojxEZNh7CQqJzLtMdEm1/hPnW/73xX
	Q9xTuwRUhaWxkgBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750675971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6U+vycsx0yOGyeto/sQB753cmjZS5l0fRUpZ5LcgcIw=;
	b=Ys9CTIv6p2+9ZvWZkv/yo481zGnFbs/Y+KtaSyN6dQrXBpXaEuycMWkIYBWCIW+PD5yx/5
	msxRwA31m5T9BLq8G60U46gQJ9I2kQksGSEXp/gwkg4MzitCdB9WhaxZWXktDpTJOSR8YC
	wlHUTzV/441AmQGKx/RE6Gcx3Bgy/c8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750675971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6U+vycsx0yOGyeto/sQB753cmjZS5l0fRUpZ5LcgcIw=;
	b=gnA2QG4Z75pKwDZQOAb/+uDU1J0tnBNYGYJq/5RuojxEZNh7CQqJzLtMdEm1/hPnW/73xX
	Q9xTuwRUhaWxkgBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6D9713485;
	Mon, 23 Jun 2025 10:52:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 94iHMAMyWWihJQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Jun 2025 10:52:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7241BA2A00; Mon, 23 Jun 2025 12:52:47 +0200 (CEST)
Date: Mon, 23 Jun 2025 12:52:47 +0200
From: Jan Kara <jack@suse.cz>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fanotify: wake-up all waiters on release
Message-ID: <lzvbms7m4n67h46u6xrp3nvdpyoapgghz4sowakfeek44bjndn@kgamxd67q6cd>
References: <3p5hvygkgdhrpbhphtjm55vnvprrgguk46gic547jlwdhjonw3@nz54h4fjnjkm>
 <20250520123544.4087208-1-senozhatsky@chromium.org>
 <bsji6w5ytunjt5vlgj6t53rrksqc7lp5fukwi2sbettzuzvnmg@fna73sxftrak>
 <ccdghhd5ldpqc3nps5dur5ceqa2dgbteux2y6qddvlfuq3ar4g@m42fp4q5ne7n>
 <xlbmnncnw6swdtf74nlbqkn57sxpt5f3bylpvhezdwgavx5h2r@boz7f5kg3x2q>
 <yo2mrodmg32xw3v3pezwreqtncamn2kvr5feae6jlzxajxzf6s@dclplmsehqct>
 <76mwzuvqxrpml7zm3ebqaqcoimjwjda27xfyqracb7zp4cf5qv@ykpy5yabmegu>
 <osoyo6valq3slgx5snl4dqw5bc23aogqoqmjdt7zct4izuie3e@pjmakfrsgjgm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <osoyo6valq3slgx5snl4dqw5bc23aogqoqmjdt7zct4izuie3e@pjmakfrsgjgm>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,google.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Fri 20-06-25 14:48:47, Sergey Senozhatsky wrote:
> On (25/06/20 13:53), Sergey Senozhatsky wrote:
> > On (25/05/26 23:12), Sergey Senozhatsky wrote:
> [..]
> > Surprisingly enough, this did not help.
> > 
> > Jan, one more silly question:
> > 
> > fsnotify_get_mark_safe() and fsnotify_put_mark_wake() can be called on
> > NULL mark.  Is it possible that between fsnotify_prepare_user_wait(iter_info)
> > and fsnotify_finish_user_wait(iter_info) iter_info->marks[type] changes in
> > such a way that creates imbalance?  That is, fsnotify_finish_user_wait() sees
> > more NULL marks and hence does not rollback all the group->user_waits
> > increments that fsnotify_prepare_user_wait() did?
> 
> No, that doesn't seem to be possible.  Sorry for the noise.

Yeah, iter_info is local and should not change outside of the call itself.

> My another silly idea was, fsnotify_put_mark_wake() is called in a loop
> and it tests group->shutdown locklessly, as far as I can tell, so maybe
> there is a speculative load and we use stale/"cached" group->shutdown
> value w/o ever waking up ->notification_waitq.  Am running out of ideas.

Well, but atomic_dec_and_test() in fsnotify_put_mark_wake() should be a
full memory barrier so such reordering should not be possible? At least
not on the CPU, you can check disassembly of fsnotify_put_mark_wake() on
your kernel whether the fetch of group->shutdown indeed happens after the
atomic_dec_and_test() (but it should because && is a sequencing point and
thus a compiler barrier).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

