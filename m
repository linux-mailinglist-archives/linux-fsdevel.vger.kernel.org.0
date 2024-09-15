Return-Path: <linux-fsdevel+bounces-29424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 496F397999D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 01:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0971F22C6E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 23:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0CF135A53;
	Sun, 15 Sep 2024 23:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vSPE8pAN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6A6d8CiC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vSPE8pAN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6A6d8CiC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6258175F;
	Sun, 15 Sep 2024 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726444377; cv=none; b=pYfPdkGyvn1Szf7XXBS3ZoLRXE5icU+iGKhsUWjdutc0wrAdoEPGREM9NUGzyyf2oYKnSKl528tzLY7FtTffDd5TyW++Q4COKoG4JFnFFIm1R3gIlmGRPt9jaK6oXiggskpr/UBlXYs6uEzpA/uwOzDcXySHFZXFb/8rzzfr7U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726444377; c=relaxed/simple;
	bh=ITkpgHKfuRfbjMe47+uAfPeMZI5fcCA82SAhXnYL82c=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=arS2vB1Hji2GQQdJPtSdB3ERqpwptTYDiQm5DjxV6uvmKUZtIU+fSkMD46VdrG8xbRtK0dChCXUQbHnf7l5BD37qKUWkpHM3hp6V050yhfuyBp9A2Il+GHm5XwL5cp8ZET6TqAOa7K+O/QTieSZnT5ZIU006XXseYEWMcMsNTgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vSPE8pAN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6A6d8CiC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vSPE8pAN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6A6d8CiC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 226FA1F837;
	Sun, 15 Sep 2024 23:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726444373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xiG13ZfZHbRtXyGwPrjs6tm9m2K4dADm70BU8g/HNek=;
	b=vSPE8pANYfBffFX2LjfSTIXbetOsfauvQi+6EC5tgY79kiIs65xPNMZe5+c8J5L6KNJ72z
	TOrR9zkdSYnSknDBYr/bVT9xC58BiB1uPfSGmlHynzFgH81Z+Q2cBIUOSESRmcJpqNL0Bs
	/HJsp2looqiqS5ANYZmNq4Nj5f5GlAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726444373;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xiG13ZfZHbRtXyGwPrjs6tm9m2K4dADm70BU8g/HNek=;
	b=6A6d8CiCwfWdLOZePf1uIcZeO1ut5uBH0tuB0RHXFerSz2k/VNnt0zPtC0kgRE72/evI5t
	mxFhPz56kyhc1xBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vSPE8pAN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6A6d8CiC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726444373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xiG13ZfZHbRtXyGwPrjs6tm9m2K4dADm70BU8g/HNek=;
	b=vSPE8pANYfBffFX2LjfSTIXbetOsfauvQi+6EC5tgY79kiIs65xPNMZe5+c8J5L6KNJ72z
	TOrR9zkdSYnSknDBYr/bVT9xC58BiB1uPfSGmlHynzFgH81Z+Q2cBIUOSESRmcJpqNL0Bs
	/HJsp2looqiqS5ANYZmNq4Nj5f5GlAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726444373;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xiG13ZfZHbRtXyGwPrjs6tm9m2K4dADm70BU8g/HNek=;
	b=6A6d8CiCwfWdLOZePf1uIcZeO1ut5uBH0tuB0RHXFerSz2k/VNnt0zPtC0kgRE72/evI5t
	mxFhPz56kyhc1xBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9B0E1351A;
	Sun, 15 Sep 2024 23:52:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nmF1G1Jz52YbNgAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 15 Sep 2024 23:52:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Ingo Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jens Axboe" <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org
Subject: Re: [PATCH 0/7 v2 RFC] Make wake_up_{bit,var} less fragile
In-reply-to: <20240826063659.15327-1-neilb@suse.de>
References: <20240826063659.15327-1-neilb@suse.de>
Date: Mon, 16 Sep 2024 09:52:47 +1000
Message-id: <172644436782.17050.10401810341028694092@noble.neil.brown.name>
X-Rspamd-Queue-Id: 226FA1F837
X-Spam-Level: 
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
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO


Hi Ingo and Peter,
 have you had a chance to look at these yet?  Should I resend?  Maybe
 after -rc is out?

Thanks,
NeilBrown


On Mon, 26 Aug 2024, NeilBrown wrote:
> This is a second attempt to make wake_up_{bit,var} less fragile.
> This version doesn't change those functions much, but instead
> improves the documentation and provides some helpers which
> both serve as patterns to follow and alternates so that use of the
> fragile functions can be limited or eliminated.
> 
> The only change to either function is that wake_up_bit() is changed to
> take an unsigned long * rather than a void *.  This necessitates the
> first patch which changes the one place where something other then
> unsigned long * is passed to wake_up bit - it is in block/.
> 
> The final patch modifies the same bit of code as a demonstration of one
> of the new APIs that has been added.
> 
> Thanks,
> NeilBrown
> 
> 
>  [PATCH 1/7] block: change wait on bd_claiming to use a var_waitqueue,
>  [PATCH 2/7] sched: change wake_up_bit() and related function to
>  [PATCH 3/7] sched: Improve documentation for wake_up_bit/wait_on_bit
>  [PATCH 4/7] sched: Document wait_var_event() family of functions and
>  [PATCH 5/7] sched: Add test_and_clear_wake_up_bit() and
>  [PATCH 6/7] sched: Add wait/wake interface for variable updated under
>  [PATCH 7/7] Block: switch bd_prepare_to_claim to use
> 
> 


