Return-Path: <linux-fsdevel+bounces-29461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCD097A083
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 13:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A613B284533
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 11:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55317154429;
	Mon, 16 Sep 2024 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DKiNI1Gu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JTBjSP31";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DKiNI1Gu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JTBjSP31"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0488A47A62;
	Mon, 16 Sep 2024 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487307; cv=none; b=SxgMb0o7GLejSaPxBVpaTOUrsyRY8PfqIgIfrQf6y3hClXX60ZmRQisYxn5ta6nJIQLSS0J2Xd0pH3tL1f+Ucl0WAEfew45hlpaVtvid/7azzwHdRRoj58hkZhzse1fc3/EbJQ1bufUlD+ELSf2c01wgd1PkDMmUXn1Ppc9vxjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487307; c=relaxed/simple;
	bh=bZFA2khvja0mlkMESr0emDxNI+qt8CnAPPHy31qZBZU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=up/ib2DnL5xoAhaEgajptDJCcFE2K4dwnts18K6igbdDj7GnM7P8VFnQap4CLjPdWE2uJExsPeTdfx5jYdH7UHxd0M41KuUXH4q5nMMMVJtWRog5y/67HkQMJu87FfTeYX0kgtTmSMLU3VIcoiIsLUpxFkj7mjhPtaMCeZfFNyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DKiNI1Gu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JTBjSP31; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DKiNI1Gu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JTBjSP31; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C30101F460;
	Mon, 16 Sep 2024 11:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726487301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+2oCtNgwoyHEB0G7EYXuCKkSXUY7TMHg343T/9fc+0=;
	b=DKiNI1GuoX+TXhBg+7deiwMWWhIMoIQDSCjzpsS2j6G7V4pc96fyi87sYhpsihTlCbItrH
	2lZ0cMW7WXNY4OqoeQ8NP0R2JgIBz21zc4EmzeOlwk6BI1SLiLlnfiEprgTqjGRh1nTt6V
	Bm2eEOfGByOsSgxDu53uhCfKNv1dTrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726487301;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+2oCtNgwoyHEB0G7EYXuCKkSXUY7TMHg343T/9fc+0=;
	b=JTBjSP31EnOMB/YgmBSFWHG0sd+99VzCj3+xsUzq4eKh+VrrchtU6N9ARE47lmJWJdE8GR
	jcYWVwDyd2DigIAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726487301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+2oCtNgwoyHEB0G7EYXuCKkSXUY7TMHg343T/9fc+0=;
	b=DKiNI1GuoX+TXhBg+7deiwMWWhIMoIQDSCjzpsS2j6G7V4pc96fyi87sYhpsihTlCbItrH
	2lZ0cMW7WXNY4OqoeQ8NP0R2JgIBz21zc4EmzeOlwk6BI1SLiLlnfiEprgTqjGRh1nTt6V
	Bm2eEOfGByOsSgxDu53uhCfKNv1dTrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726487301;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+2oCtNgwoyHEB0G7EYXuCKkSXUY7TMHg343T/9fc+0=;
	b=JTBjSP31EnOMB/YgmBSFWHG0sd+99VzCj3+xsUzq4eKh+VrrchtU6N9ARE47lmJWJdE8GR
	jcYWVwDyd2DigIAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A6FC1397F;
	Mon, 16 Sep 2024 11:48:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VImKCAMb6GabfQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 16 Sep 2024 11:48:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Peter Zijlstra" <peterz@infradead.org>
Cc: "Ingo Molnar" <mingo@redhat.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jens Axboe" <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/7] sched: change wake_up_bit() and related function to
 expect unsigned long *
In-reply-to: <20240916112810.GY4723@noisy.programming.kicks-ass.net>
References: <>, <20240916112810.GY4723@noisy.programming.kicks-ass.net>
Date: Mon, 16 Sep 2024 21:48:11 +1000
Message-id: <172648729127.17050.15543415823867299910@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Mon, 16 Sep 2024, Peter Zijlstra wrote:
> On Mon, Aug 26, 2024 at 04:30:59PM +1000, NeilBrown wrote:
> > wake_up_bit() currently allows a "void *".  While this isn't strictly a
> > problem as the address is never dereferenced, it is inconsistent with
> > the corresponding wait_var_event() which requires "unsigned long *" and
> > does dereference the pointer.
> 
> I'm having trouble parsing this. The way I read it, you're contradicting
> yourself. Where does wait_var_event() require 'unsigned long *' ?

Sorry, that is meant so as "the corresponding wait_on_bit()".


> 
> > And code that needs to wait for a change in something other than an
> > unsigned long would be better served by wake_up_var().
> 
> This, afaict the whole var thing is size invariant. It only cares about
> the address.
> 

Again - wake_up_bit().  Sorry - bits are vars were swimming around my
brain and I didn't proof-read properly.

This patch is all "bit", no "var".

NeilBrown

