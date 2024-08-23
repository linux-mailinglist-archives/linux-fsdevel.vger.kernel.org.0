Return-Path: <linux-fsdevel+bounces-26852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4C295C1FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 02:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DE35B20B69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 00:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764E1259C;
	Fri, 23 Aug 2024 00:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M2URsNfK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/ChVoBek";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M2URsNfK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/ChVoBek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AC71C36
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 00:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724371710; cv=none; b=f3RXXFuDMyDcVOxYT5MrTzmxLXs4sHtgwoJaZRL3kBdSn9kyMR33n+Pkcw0rjUIuEU4hD3iSl8g7bMCDrBZZ8tosXcN/JJzN9wU9krjh0xjiPN5byrrG9rbfj0JTQsxh0Ljn6o7MODEXZYfNms1kSSgMuqPPiX+l9xEtfjzaQHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724371710; c=relaxed/simple;
	bh=kZWH5rIjy/sgSQm4h18RTewUduUk/c4sKzTR/DNIEF4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=cWxTzOy1NHmRcJ9INdjyOwgqbBqbEYRJ81K/6qN6/0RBtwYbirrt1Xi4S3IBzufS0GCZ99QVkDVkRZ+Pe5KFZIlrVAUBQQ9MhnCNgC5A7bU5kZTpTw9C1+IVWEwV63saxC+uR4oaWJkwq2MBUnmGkhiAmeGDZVFjjjeYvgBbixU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M2URsNfK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/ChVoBek; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M2URsNfK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/ChVoBek; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 20EBB224A1;
	Fri, 23 Aug 2024 00:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724371706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=czfs3QZOcp+12FbNfBBFuvVscUqNWC721CZI6XHovm8=;
	b=M2URsNfKQ4EhmUd11Fr7bEHslZVVSW9eTdalXt/yeJ8xi7JxVv1opLcn2aozznOAbwipQb
	c2LOv2PdDOK+FIYEIjMCK7tOySQcLpOD5oOlp4LIXYXlHE+7xySQJCTIVrGRFeS3YhQBkK
	rXLml2xl1gZcmu+99uyMpREz/UJW/ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724371706;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=czfs3QZOcp+12FbNfBBFuvVscUqNWC721CZI6XHovm8=;
	b=/ChVoBektAsxjMuJ0WNgCqFtrOwFYha9VCPTPaE+eV14HmcLxUH5dY76eqh3k/hO/UXNMB
	oraZ/zolOJf+KVDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=M2URsNfK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/ChVoBek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724371706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=czfs3QZOcp+12FbNfBBFuvVscUqNWC721CZI6XHovm8=;
	b=M2URsNfKQ4EhmUd11Fr7bEHslZVVSW9eTdalXt/yeJ8xi7JxVv1opLcn2aozznOAbwipQb
	c2LOv2PdDOK+FIYEIjMCK7tOySQcLpOD5oOlp4LIXYXlHE+7xySQJCTIVrGRFeS3YhQBkK
	rXLml2xl1gZcmu+99uyMpREz/UJW/ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724371706;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=czfs3QZOcp+12FbNfBBFuvVscUqNWC721CZI6XHovm8=;
	b=/ChVoBektAsxjMuJ0WNgCqFtrOwFYha9VCPTPaE+eV14HmcLxUH5dY76eqh3k/hO/UXNMB
	oraZ/zolOJf+KVDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C1E0139D2;
	Fri, 23 Aug 2024 00:08:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z+jACPfSx2YdBAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 23 Aug 2024 00:08:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Dave Chinner" <david@fromorbit.com>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/6] fs: add i_state helpers
In-reply-to: <ZsZ5otBAqL5Wir1j@dread.disaster.area>
References: <>, <ZsZ5otBAqL5Wir1j@dread.disaster.area>
Date: Fri, 23 Aug 2024 10:08:19 +1000
Message-id: <172437169942.6062.17473958359670923094@noble.neil.brown.name>
X-Rspamd-Queue-Id: 20EBB224A1
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 22 Aug 2024, Dave Chinner wrote:
> 
> Even better would be to fix wake_up_var() to not have an implicit
> ordering requirement. Add __wake_up_var() as the "I know what I'm
> doing" API, and have wake_up_var() always issue the memory barrier
> like so:
> 
> __wake_up_var(var)
> {
> 	__wake_up_bit(....);
> }
> 
> wake_up_var(var)
> {
> 	smp_mb();
> 	__wake_up_var(var);
> }

This is very close to what I proposed
 https://lore.kernel.org/all/20240819053605.11706-9-neilb@suse.de/
but Linus doesn't like that approach.
I would prefer a collection of interfaces which combine the update to
the variable with the wake_up.
So 
   atomic_dec_and_wake()
   store_release_and_wake()

though there are a few that don't fit into a common pattern.
Sometimes a minor code re-write can make them fit.  Other times I'm not
so sure.

I'm glad I'm not the only one who though that adding a barrier to
wake_up_var() was a good idea though - thanks.

NeilBrown


> 
> Then people who don't intimately understand ordering (i.e. just want
> to use a conditional wait variable) or just don't want to
> think about complex memory ordering issues for otherwise obvious and
> simple code can simply use the safe variant.
> 
> Those that need to optimise for speed or know they have solid
> ordering or external serialisation can use __wake_up_var() and leave
> a comment as to why that is safe. i.e.:
> 
> 	/*
> 	 * No wait/wakeup ordering required as both waker and waiters
> 	 * are serialised by the inode->i_lock.
> 	 */
> 	__wake_up_var(....);
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 


